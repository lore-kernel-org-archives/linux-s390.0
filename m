From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Mon, 19 Feb 2018 11:29:31 +0000
Subject: Re: [PATCH] KVM: s390: implement CPU model only facilities
Message-Id: <e8c17e56-0a6b-0745-0797-de3c505a1708@de.ibm.com>
In-Reply-To: <2d32056c-8735-bbfb-c28e-d1e789d8f661@redhat.com>
References: <2d32056c-8735-bbfb-c28e-d1e789d8f661@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 02/19/2018 12:20 PM, David Hildenbrand wrote:
> On 19.02.2018 09:53, Christian Borntraeger wrote:
>> Some facilities should only provided to the guest, if these are
>> enabled by a CPU model. This allows to avoid capabilities and
>> simply fallback to the cpumodel for deciding about a facility
>> without enabling it for older QEMUs or QEMUs without a CPU
>> model.
>>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c         | 40 ++++++++++++++++++++++++++++++++--------
>>  arch/s390/kvm/kvm-s390.h         |  2 --
>>  arch/s390/tools/gen_facilities.c | 20 ++++++++++++++++++++
>>  3 files changed, 52 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 5b7fe80cda56..7d982690b1fc 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -151,13 +151,27 @@ static int nested;
>>  module_param(nested, int, S_IRUGO);
>>  MODULE_PARM_DESC(nested, "Nested virtualization support");
>>  
>> -/* upper facilities limit for kvm */
>> -unsigned long kvm_s390_fac_list_mask[16] = { FACILITIES_KVM };
>>  
>> -unsigned long kvm_s390_fac_list_mask_size(void)
>> +/*
>> + * For now we handle not more than 16 double words as this is what
>> + * the s390 base kernel handles and stores in prefix page. If we
>> + * ever need to go beyond this, this requires changes to code, but
>> + * the external uapi can stay.
>> + */
>> +#define SIZE_INTERNAL 16
>> +
>> +/* upper facilities limit for kvm */
>> +static unsigned long kvm_s390_fac_list_mask[SIZE_INTERNAL] = { FACILITIES_KVM };
>> +/*
>> + * facility bits that are in the mask, but initially not in the list.
>> + * Those can be activated by the CPU model
>> + */
>> +static unsigned long kvm_s390_fac_model[SIZE_INTERNAL] = { FACILITIES_KVM_CPUMODEL };
> 
> _list_mask vs _model
> 
> Can we make this more consistent?

I will try.

> 
> 
>> +
>> +static unsigned long kvm_s390_fac_size(void)
>>  {
>> -	BUILD_BUG_ON(ARRAY_SIZE(kvm_s390_fac_list_mask) > S390_ARCH_FAC_MASK_SIZE_U64);
>> -	return ARRAY_SIZE(kvm_s390_fac_list_mask);
>> +	BUILD_BUG_ON(SIZE_INTERNAL > S390_ARCH_FAC_MASK_SIZE_U64);
>> +	return SIZE_INTERNAL;
>>  }
>>  
>>  /* available cpu features supported by kvm */
>> @@ -1946,17 +1960,27 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long type)
>>  	memcpy(kvm->arch.model.fac_mask, S390_lowcore.stfle_fac_list,
>>  	       sizeof(S390_lowcore.stfle_fac_list));
>>  	for (i = 0; i < S390_ARCH_FAC_LIST_SIZE_U64; i++) {
>> -		if (i < kvm_s390_fac_list_mask_size())
>> -			kvm->arch.model.fac_mask[i] &= kvm_s390_fac_list_mask[i];
>> +		if (i < kvm_s390_fac_size())
>> +			kvm->arch.model.fac_mask[i] &= (kvm_s390_fac_list_mask[i] |
>> +							kvm_s390_fac_model[i]);
>>  		else
>>  			kvm->arch.model.fac_mask[i] = 0UL;
>>  	}
>>  
>> -	/* Populate the facility list initially. */
>> +	/* Populate the facility list initially as a copy of the mask */
>>  	kvm->arch.model.fac_list = kvm->arch.sie_page2->fac_list;
>>  	memcpy(kvm->arch.model.fac_list, kvm->arch.model.fac_mask,
>>  	       S390_ARCH_FAC_LIST_SIZE_BYTE);
>>  
> 
> If you need a loop either way, why not simply drop the memcpy and
> instead do it explicitly in a single loop?

Yes, can do. I will also remove the zeroing (as in your other patch). To do that I need
to limit kvm_s390_fac_list_mask_size to not exceed sizeof(S390_lowcore.stfle_fac_list)
though.
