From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH RFC 2/6] KVM: s390: provide only a single function for
 setting the tod
Date: Wed, 7 Feb 2018 22:42:55 +0100
Message-ID: <ffb06039-ef6b-1fdb-eb45-3083d91707ad@redhat.com>
References: <20180207114647.6220-1-david@redhat.com>
 <20180207114647.6220-3-david@redhat.com>
 <58ec2151-e95d-1286-e2ab-a958e6afcd2d@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <58ec2151-e95d-1286-e2ab-a958e6afcd2d@linux.vnet.ibm.com>
Content-Language: en-US
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: "Collin L. Walling" <walling@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>


>>
>> -void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
>> -				 const struct kvm_s390_vm_tod_clock *gtod)
>> +void kvm_s390_set_tod_clock(struct kvm *kvm,
>> +			    const struct kvm_s390_vm_tod_clock *gtod)
> Nit: off by one space --------^

This looks fine in code, just a quirk in the visual representation of
the diff file.

[...]
>>   /* implemented in kvm-s390.c */
>> -void kvm_s390_set_tod_clock_ext(struct kvm *kvm,
>> -				 const struct kvm_s390_vm_tod_clock *gtod);
>> -void kvm_s390_set_tod_clock(struct kvm *kvm, u64 tod);
>> +void kvm_s390_set_tod_clock(struct kvm *kvm,
>> +			    const struct kvm_s390_vm_tod_clock *gtod);
> Same nit here.

Dito.

>>   long kvm_arch_fault_in_page(struct kvm_vcpu *vcpu, gpa_t gpa, int writable);
>>   int kvm_s390_store_status_unloaded(struct kvm_vcpu *vcpu, unsigned long addr);
>>   int kvm_s390_vcpu_store_status(struct kvm_vcpu *vcpu, unsigned long addr);
>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>> index c4c4e157c036..33505c32c48a 100644
>> --- a/arch/s390/kvm/priv.c
>> +++ b/arch/s390/kvm/priv.c
>> @@ -85,9 +85,10 @@ int kvm_s390_handle_e3(struct kvm_vcpu *vcpu)
>>   /* Handle SCK (SET CLOCK) interception */
>>   static int handle_set_clock(struct kvm_vcpu *vcpu)
>>   {
>> +	struct kvm_s390_vm_tod_clock gtod = { 0 };
>>   	int rc;
>>   	u8 ar;
>> -	u64 op2, val;
>> +	u64 op2;
>>
>>   	vcpu->stat.instruction_sck++;
>>
>> @@ -97,12 +98,12 @@ static int handle_set_clock(struct kvm_vcpu *vcpu)
>>   	op2 = kvm_s390_get_base_disp_s(vcpu, &ar);
>>   	if (op2 & 7)	/* Operand must be on a doubleword boundary */
>>   		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
>> -	rc = read_guest(vcpu, op2, ar, &val, sizeof(val));
>> +	rc = read_guest(vcpu, op2, ar, &gtod.tod, sizeof(gtod.tod));
>>   	if (rc)
>>   		return kvm_s390_inject_prog_cond(vcpu, rc);
>>
>> -	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", val);
>> -	kvm_s390_set_tod_clock(vcpu->kvm, val);
>> +	VCPU_EVENT(vcpu, 3, "SCK: setting guest TOD to 0x%llx", gtod.tod);
>> +	kvm_s390_set_tod_clock(vcpu->kvm, &gtod);
>>
>>   	kvm_s390_set_psw_cc(vcpu, 0);
>>   	return 0;
> Set clock only concerns the left-most 64 bits of the TOD-Clock, right? 
> (thinking out
> loud) I wonder if we need to also concern ourselves about the epoch 
> extension... but
> perhaps current use cases of set clock do not warrant that?

SET CLOCK will always set the right-most 64 bits of the TOD. The
left-most bits are assumed to be 0 (that's how I understand the
architecture). SET CLOCK can at one point no longer be reliably used.

But until these years come, SET CLOCK has to continue to work (even if
the guest has Multiple-epoch facility). And that can be guaranteed by
setting the epoch index accordingly.

Especially, if we have with mepoch: "Guest TOD = HOST TOD - 1", the
epoch index has to be set to 0xff and the epoch to 0xffff...fff. Right
now, the epoch index would not be set.

Should be easy to reproduced by doing a

STORE CLOCK %d followed by A SET_CLOCK %d in the guest. As the Host TOD
has been incremented, we have "Guest TOD = Host TOD - X", and not
setting the epoch index to 0xff results in a wrong Guest TOD calculation
on the next STORE CLOCK.

Thanks!


-- 

Thanks,

David / dhildenb
