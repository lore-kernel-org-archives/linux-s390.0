From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v10 03/26] KVM: s390: refactor crypto initialization
Date: Mon, 24 Sep 2018 10:35:41 +0200
Message-ID: <3403a255-8125-18f7-45b8-bb6a8a9f7f84@redhat.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-4-git-send-email-akrowiak@linux.vnet.ibm.com>
 <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <e340e3ec-4f8f-1f7b-b2f5-6fec77c4c5f9@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.ibm.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 22/09/2018 01:18, Tony Krowiak wrote:
> On 09/12/2018 03:42 PM, Tony Krowiak wrote:
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>
>> This patch refactors the code that initializes and sets up the
>> crypto configuration for a guest. The following changes are
>> implemented via this patch:
>>
>> 1. Prior to the introduction of AP device virtualization, it
>>     was not necessary to provide guest access to the CRYCB
>>     unless the MSA extension 3 (MSAX3) facility was installed
>>     on the host system. With the introduction of AP device
>>     virtualization, the CRYCB must be made accessible to the
>>     guest if the AP instructions are installed on the host
>>     and are to be provided to the guest.
>>
>> 2. Introduces a flag indicating AP instructions executed on
>>     the guest shall be interpreted by the firmware. It is
>>     initialized to indicate AP instructions are to be
>>     to be interpreted and is used to set the SIE bit for
>>     each vcpu during vcpu setup.
>>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>> Reviewed-by: Halil Pasic <pasic@linux.ibm.com>
>> Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Acked-by: Janosch Frank <frankja@linux.ibm.com>
>> Tested-by: Michael Mueller <mimu@linux.ibm.com>
>> Tested-by: Farhan Ali <alifm@linux.ibm.com>
>> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> ---
>>   arch/s390/include/asm/kvm_host.h |    2 +
>>   arch/s390/include/uapi/asm/kvm.h |    1 +
>>   arch/s390/kvm/kvm-s390.c         |   71 ++++++++++++++++++--------------------
>>   3 files changed, 37 insertions(+), 37 deletions(-)
>>
> 
> (...)
> 
>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>> index 9a50f02..8c23afc 100644
>> --- a/arch/s390/include/uapi/asm/kvm.h
>> +++ b/arch/s390/include/uapi/asm/kvm.h
>> @@ -130,6 +130,7 @@ struct kvm_s390_vm_cpu_machine {
>>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>>   #define KVM_S390_VM_CPU_FEAT_KSS	13
>> +#define KVM_S390_VM_CPU_FEAT_AP		14
>>   struct kvm_s390_vm_cpu_feat {
>>   	__u64 feat[16];
>>   };
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 876fbb2..d717041 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -40,6 +40,7 @@
>>   #include <asm/sclp.h>
>>   #include <asm/cpacf.h>
>>   #include <asm/timex.h>
>> +#include <asm/ap.h>
>>   #include "kvm-s390.h"
>>   #include "gaccess.h"
>>   
> 
> (...)
> 
>> @@ -2586,17 +2575,25 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>>   
>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>>   {
>> -	if (!test_kvm_facility(vcpu->kvm, 76))
>> +	/*
>> +	 * If neither the AP instructions nor the MSAX3 facility are configured
>> +	 * for the guest, there is nothing to set up.
>> +	 */
>> +	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
>> +	    !test_kvm_facility(vcpu->kvm, 76))
>>   		return;
>>   
>> +	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>   	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
>>   
>> +	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
>> +		vcpu->arch.sie_block->eca |= ECA_APIE;
>> +
>> +	/* Set up protected key support */
>>   	if (vcpu->kvm->arch.crypto.aes_kw)
>>   		vcpu->arch.sie_block->ecb3 |= ECB3_AES;
>>   	if (vcpu->kvm->arch.crypto.dea_kw)
>>   		vcpu->arch.sie_block->ecb3 |= ECB3_DEA;
>> -
>> -	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>>   }
>>   
>>   void kvm_s390_vcpu_unsetup_cmma(struct kvm_vcpu *vcpu)
>>
> 
> The fixup! patch below modifies this patch (03/26) to illustrate how
> 
> David's recommendation will be implemented for v11 of the series. It
> 
> is one of three fixup! patches (the other two are in responses to
> 11/26
>   and 25/26) included to generate discussion in v10 rather than
> 
> waiting until v11 for comments.
> 
> -----------------------------------8<-----------------------------------
> 
> From: Tony Krowiak <akrowiak@linux.ibm.com>
> Date: Thu, 20 Sep 2018 12:26:08 -0400
> Subject: [FIXUP v10] fixup!: KVM: s390: refactor crypto initialization
> 
> ---
>   arch/s390/include/asm/kvm_host.h |    1 +
>   arch/s390/include/uapi/asm/kvm.h |    1 -
>   arch/s390/kvm/kvm-s390.c         |    9 ++++-----
>   3 files changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h 
> b/arch/s390/include/asm/kvm_host.h
> index 423cce7..79fa0a3 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -718,6 +718,7 @@ struct kvm_s390_crypto {
>   	__u32 crycbd;
>   	__u8 aes_kw;
>   	__u8 dea_kw;
> +	__u8 apie;
>   };
> 
>   #define APCB0_MASK_SIZE 1
> diff --git a/arch/s390/include/uapi/asm/kvm.h 
> b/arch/s390/include/uapi/asm/kvm.h
> index 8c23afc..9a50f02 100644
> --- a/arch/s390/include/uapi/asm/kvm.h
> +++ b/arch/s390/include/uapi/asm/kvm.h
> @@ -130,7 +130,6 @@ struct kvm_s390_vm_cpu_machine {
>   #define KVM_S390_VM_CPU_FEAT_PFMFI	11
>   #define KVM_S390_VM_CPU_FEAT_SIGPIF	12
>   #define KVM_S390_VM_CPU_FEAT_KSS	13
> -#define KVM_S390_VM_CPU_FEAT_AP		14
>   struct kvm_s390_vm_cpu_feat {
>   	__u64 feat[16];
>   };
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index d717041..ae4769b 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -2576,17 +2576,16 @@ void kvm_arch_vcpu_postcreate(struct kvm_vcpu *vcpu)
>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu)
>   {
>   	/*
> -	 * If neither the AP instructions nor the MSAX3 facility are configured
> -	 * for the guest, there is nothing to set up.
> +	 * If the AP instructions are not available and the MSAX3 facility
> +	 * is not configured for the guest, there is nothing to set up.
>   	 */
> -	if (!test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP) &&
> -	    !test_kvm_facility(vcpu->kvm, 76))
> +	if (!ap_instructions_available() && !test_kvm_facility(vcpu->kvm, 76))
>   		return;
> 
>   	vcpu->arch.sie_block->crycbd = vcpu->kvm->arch.crypto.crycbd;
>   	vcpu->arch.sie_block->ecb3 &= ~(ECB3_AES | ECB3_DEA);
> 
> -	if (test_kvm_cpu_feat(vcpu->kvm, KVM_S390_VM_CPU_FEAT_AP))
> +	if (vcpu->kvm->arch.crypto.apie)
>   		vcpu->arch.sie_block->eca |= ECA_APIE;
> 
>   	/* Set up protected key support */
> 

Looks sane, too.

-- 

Thanks,

David / dhildenb
