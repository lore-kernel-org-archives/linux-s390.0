From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2 06/12] KVM: s390: exploit GISA and AIV for emulated
 interrupts
Date: Thu, 25 Jan 2018 17:47:12 +0100
Message-ID: <be0022df-be6d-3b03-f5f5-c61e09c08da7@redhat.com>
References: <20180125132848.175942-1-borntraeger@de.ibm.com>
 <20180125132848.175942-7-borntraeger@de.ibm.com>
 <040c7c5d-bbbd-89d4-ebcd-5d04ed80a40d@redhat.com>
 <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <b7fb3580-0eae-ee29-cae6-d58bc8a4e350@de.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: KVM <kvm@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Janosch Frank <frankja@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Mueller <mimu@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

On 25.01.2018 17:32, Christian Borntraeger wrote:
> 
> 
> On 01/25/2018 03:20 PM, David Hildenbrand wrote:
> [...]
>>> @@ -918,18 +919,38 @@ static int __must_check __deliver_virtio(struct kvm_vcpu *vcpu)
>>>  	return rc ? -EFAULT : 0;
>>>  }
>>>  
>>> +static int __do_deliver_io(struct kvm_vcpu *vcpu, struct kvm_s390_io_info *io)
>>> +{
>>> +	int rc;
>>> +
>>> +	rc  = put_guest_lc(vcpu, io->subchannel_id, (u16 *)__LC_SUBCHANNEL_ID);
>>> +	rc |= put_guest_lc(vcpu, io->subchannel_nr, (u16 *)__LC_SUBCHANNEL_NR);
>>> +	rc |= put_guest_lc(vcpu, io->io_int_parm, (u32 *)__LC_IO_INT_PARM);
>>> +	rc |= put_guest_lc(vcpu, io->io_int_word, (u32 *)__LC_IO_INT_WORD);
>>> +	rc |= write_guest_lc(vcpu, __LC_IO_OLD_PSW,
>>> +			     &vcpu->arch.sie_block->gpsw,
>>> +			     sizeof(psw_t));
>>> +	rc |= read_guest_lc(vcpu, __LC_IO_NEW_PSW,
>>> +			    &vcpu->arch.sie_block->gpsw,
>>> +			    sizeof(psw_t));
>>
>> These should now it into less lines.
> 
> The last two lines are way beyond 80. 
> 

Huh? At least in my world, I can reduce 3 to 2 lines (for both).

> Can you factor that change out into
>> a separate patch?
> 
> 
[...]

>>
>>> +			/*
>>> +			 * in case an adapter interrupt was not delivered
>>> +			 * in SIE context KVM will handle the delivery
>>> +			 */
>>> +			VCPU_EVENT(vcpu, 4, "%s isc %u", "deliver: I/O (AI/gisa)", isc);
>>> +			memset(&io, 0, sizeof(io));
>>> +			io.io_int_word = (isc << 27) | 0x80000000;
>>> +			vcpu->stat.deliver_io_int++;
>>> +			trace_kvm_s390_deliver_interrupt(vcpu->vcpu_id,
>>> +				KVM_S390_INT_IO(1, 0, 0, 0),
>>> +				((__u32)io.subchannel_id << 16) |
>>> +				io.subchannel_nr,
>>> +				((__u64)io.io_int_parm << 32) |
>>> +				io.io_int_word);
>>> +			rc = __do_deliver_io(vcpu, &io);
>>> +		}
>>> +	}
>>> +out:
>>> +	return rc;
>>>  }
>>>  
>>>  typedef int (*deliver_irq_t)(struct kvm_vcpu *vcpu);
>>> @@ -1537,12 +1566,23 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>>  	struct kvm_s390_float_interrupt *fi;
>>>  	struct list_head *list;
>>>  	int isc;
>>> +	int rc = 0;
>>> +
>>> +	isc = int_word_to_isc(inti->io.io_int_word);
>>> +
>>> +	if (kvm->arch.gisa && inti->type & KVM_S390_INT_IO_AI_MASK) {
>>
>> && (inti->type & KVM_S390_INT_IO_AI_MASK)) {
> 
> not necessary, & binds stronger than &&. So why?

You're right, I thought we usually do that because of "suggest
parentheses around comparison in operand of ..." warnings from GCC. But
it only seems to apply when using e.g. == / !=.

> 
> 
> 
>>
>>> +		VM_EVENT(kvm, 4, "%s isc %1u", "inject: I/O (AI/gisa)", isc);
>>> +		kvm_s390_gisa_set_ipm_gisc(kvm->arch.gisa, isc);
>>
>> Can there only be one pending at a time? (e.g. what happens if the bit
>> is already set?)
> 
> Yes there can be only one per ISC and the multiplexing is done on device
> specific summary and queue indicator bits. (e.g. look at the virtio-ccw 
> stuff)
> 
[...]

> 
>>>  
>>>  /*
>>> @@ -2705,3 +2745,29 @@ int kvm_s390_get_irq_state(struct kvm_vcpu *vcpu, __u8 __user *buf, int len)
>>>  	return n;
>>>  }
>>>  
>>> +void kvm_s390_gisa_clear(struct kvm *kvm)
>>
>> can we instead call this "gisa_setup" or move all that directly into the
>> init function? (because it essentially inits the gisa)
> 
> It is also called in other places (kvm_s390_clear_float_irqs)
> 
>>
>>> +{
>>> +	if (kvm->arch.gisa) {
>>
>> This check is not needed: guaranteed to be set by the caller.
> 
> Huh? kvm->arch.gisa can be NULL, also called by kvm_s390_clear_float_irqs

Okay, not clear when reviewing this patch on its own. But maybe just I
find the order in which things are added challenging to review :)

>>
>>> +		memset(kvm->arch.gisa, 0, sizeof(struct kvm_s390_gisa));
> 
> 
> 
>>> +
>>> +void kvm_s390_gisa_destroy(struct kvm *kvm)
>>> +{
>>> +	if (!kvm->arch.gisa)
>>> +		return;
>>> +	kvm->arch.gisa = NULL;
>>
>> You can do this unconditionally. Nevertheless, this function is not
>> really useful: only called when we destroy the VM.
> 
> It can be useful for later support of passthrough, so I would like to
> keep it as counter part of gisa_init

Makes sense.


-- 

Thanks,

David / dhildenb
