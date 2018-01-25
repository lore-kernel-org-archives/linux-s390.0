From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 17:32:29 +0100
Message-ID: <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-7-borntraeger@de.ibm.com>
 <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>



On 01/25/2018 03:20 PM, David Hildenbrand wrote:
[...]
>> @@ -918,18 +919,38 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
>>  	return rc ? -EFAULT : 0;
>>  }
>>  
>> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
>> +{
>> +	int rc;
>> +
>> +	rc  = put_guest_lc(vcpu, io->subchannel_id, (u16 *)__LC_SUBCHANNEL_ID);
>> +	rc |= put_guest_lc(vcpu, io->subchannel_nr, (u16 *)__LC_SUBCHANNEL_NR);
>> +	rc |= put_guest_lc(vcpu, io->io_int_parm, (u32 *)__LC_IO_INT_PARM);
>> +	rc |= put_guest_lc(vcpu, io->io_int_word, (u32 *)__LC_IO_INT_WORD);
>> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
>> +			     &vcpu->arch.sie_block->gpsw,
>> +			     sizeof(psw_t));
>> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
>> +			    &vcpu->arch.sie_block->gpsw,
>> +			    sizeof(psw_t));
> 
> These should now it into less lines.

The last two lines are way beyond 80. 

Can you factor that change out into
> a separate patch?


Unless Conny agrees that this is absolutely mandatory I would like to avoid that.

> 
>> +	return rc ? -EFAULT : 0;
>> +}
>> +
>>  static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
>>  				     unsigned long irq_type)
>>  {
>>  	struct list_head *isc_list;
>>  	struct kvm_s390_float_interrupt *fi;
>>  	struct kvm_s390_interrupt_info *inti = NULL;
>> +	struct kvm_s390_io_info io;
>> +	u32 isc;
>>  	int rc = 0;
>>  
>>  	fi = &vcpu->kvm->arch.float_int;
>>  
>>  	spin_lock(&fi->lock);
>> -	isc_list = &fi->lists[irq_type_to_isc(irq_type)];
>> +	isc = irq_type_to_isc(irq_type);
>> +	isc_list = &fi->lists[isc];
>>  	inti = list_first_entry_or_null(isc_list,
>>  					struct kvm_s390_interrupt_info,
>>  					list);
>> @@ -957,24 +978,32 @@ static int __must_check __deliver_io(struct kvm_vcpu *vcpu,
>>  	spin_unlock(&fi->lock);
>>  
>>  	if (inti) {
>> -		rc  = put_guest_lc(vcpu, inti->io.subchannel_id,
>> -				(u16 *)__LC_SUBCHANNEL_ID);
>> -		rc |= put_guest_lc(vcpu, inti->io.subchannel_nr,
>> -				(u16 *)__LC_SUBCHANNEL_NR);
>> -		rc |= put_guest_lc(vcpu, inti->io.io_int_parm,
>> -				(u32 *)__LC_IO_INT_PARM);
>> -		rc |= put_guest_lc(vcpu, inti->io.io_int_word,
>> -				(u32 *)__LC_IO_INT_WORD);
>> -		rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
>> -				&vcpu->arch.sie_block->gpsw,
>> -				sizeof(psw_t));
>> -		rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
>> -				&vcpu->arch.sie_block->gpsw,
>> -				sizeof(psw_t));
>> +		rc = __do_deliver_io(vcpu, &(inti->io));
>>  		kfree(inti);
>> +		goto out;
>>  	}
>>  
>> -	return rc ? -EFAULT : 0;
>> +	if (vcpu->kvm->arch.gisa) {
>> +		if (kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc)) {
> 
> 
> if (vcpu->kvm->arch.gisa &&
>     kvm_s390_gisa_tac_ipm_gisc(vcpu->kvm->arch.gisa, isc) {
> 
> avoids one nesting level

agreed.


> 
>> +			/*
>> +			 * in case an adapter interrupt was not delivered
>> +			 * in SIE context KVM will handle the delivery
>> +			 */
>> +			VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
>> +			memset(&io, 0, sizeof(io));
>> +			io.io_int_word = (isc << 27) | 0x80000000;
>> +			vcpu->stat.deliver_io_int++;
>> +			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
>> +				KVM_S390_INT_IO(1, 0, 0, 0),
>> +				((__u32)io.subchannel_id << 16) |
>> +				io.subchannel_nr,
>> +				((__u64)io.io_int_parm << 32) |
>> +				io.io_int_word);
>> +			rc = __do_deliver_io(vcpu, &io);
>> +		}
>> +	}
>> +out:
>> +	return rc;
>>  }
>>  
>>  typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
>> @@ -1537,12 +1566,23 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>  	struct kvm_s390_float_interrupt *fi;
>>  	struct list_head *list;
>>  	int isc;
>> +	int rc = 0;
>> +
>> +	isc = int_word_to_isc(inti->io.io_int_word);
>> +
>> +	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
> 
> && (inti->type & KVM_S390_INT_IO_AI_MASK)) {

not necessary, & binds stronger than &&. So why?



> 
>> +		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
>> +		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
> 
> Can there only be one pending at a time? (e.g. what happens if the bit
> is already set?)

Yes there can be only one per ISC and the multiplexing is done on device
specific summary and queue indicator bits. (e.g. look at the virtio-ccw 
stuff)


> 
>> +		kfree(inti);
>> +		goto out;
> 
> Why not simply return 0? ...
> 
>> +	}
>>  
>>  	fi = &kvm->arch.float_int;
>>  	spin_lock(&fi->lock);
>>  	if (fi->counters[FIRQ_CNTR_IO] >= KVM_S390_MAX_FLOAT_IRQS) {
>>  		spin_unlock(&fi->lock);
>> -		return -EBUSY;
>> +		rc = -EBUSY;
>> +		goto out;
> 
> ... avoids this change ...
> 
>>  	}
>>  	fi->counters[FIRQ_CNTR_IO] += 1;
>>  
>> @@ -1553,12 +1593,12 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>  			inti->io.subchannel_id >> 8,
>>  			inti->io.subchannel_id >> 1 & 0x3,
>>  			inti->io.subchannel_nr);
>> -	isc = int_word_to_isc(inti->io.io_int_word);
>>  	list = &fi->lists[FIRQ_LIST_IO_ISC_0 + isc];
>>  	list_add_tail(&inti->list, list);
>>  	set_bit(isc_to_irq_type(isc), &fi->pending_irqs);
>>  	spin_unlock(&fi->lock);
>> -	return 0;
>> +out:
>> +	return rc;
> 
> ... and this.
> 
>>  }

Will double check but at the moment I agree to 3 comments.





>>  
>>  /*
>> @@ -2705,3 +2745,29 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>>  	return n;
>>  }
>>  
>> +void kvm_s390_gisa_clear(struct kvm *kvm)
> 
> can we instead call this "gisa_setup" or move all that directly into the
> init function? (because it essentially inits the gisa)

It is also called in other places (kvm_s390_clear_float_irqs)

> 
>> +{
>> +	if (kvm->arch.gisa) {
> 
> This check is not needed: guaranteed to be set by the caller.

Huh? kvm->arch.gisa can be NULL, also called by kvm_s390_clear_float_irqs
> 
>> +		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));



>> +
>> +void kvm_s390_gisa_destroy(struct kvm *kvm)
>> +{
>> +	if (!kvm->arch.gisa)
>> +		return;
>> +	kvm->arch.gisa = NULL;
> 
> You can do this unconditionally. Nevertheless, this function is not
> really useful: only called when we destroy the VM.

It can be useful for later support of passthrough, so I would like to
keep it as counter part of gisa_init
