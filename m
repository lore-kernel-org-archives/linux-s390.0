From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
Date: Tue, 25 Sep 2018 09:31:16 -0400
Message-ID: <7f77492a-6561-b116-9c27-b54f549d7d9a@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9263b698-1827-1b7f-28bf-75b44657dea2@redhat.com>
 <18a21cda-1da9-3bfb-7b34-80415b5457f9@linux.ibm.com>
 <172560fb-2c54-ea43-3401-f108cf2a0595@redhat.com>
 <bb2639ac-469a-a71f-8f0a-2df3c12c6ac5@linux.ibm.com>
 <ea1e79bd-63e8-819a-3cc0-62e5321d7993@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ea1e79bd-63e8-819a-3cc0-62e5321d7993@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/24/2018 02:46 PM, David Hildenbrand wrote:
> On 24/09/2018 18:25, Tony Krowiak wrote:
>> On 09/24/2018 07:23 AM, David Hildenbrand wrote:
>>> On 22/09/2018 01:40, Tony Krowiak wrote:
>>>> On 09/17/2018 04:51 AM, David Hildenbrand wrote:
>>>>> Am 12.09.18 um 21:43 schrieb Tony Krowiak:
>>>>>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>>
>>>>>> Introduces two new VM crypto device attributes (KVM_S390_VM_CRYPTO)
>>>>>> to enable or disable AP instruction interpretation from userspace
>>>>>> via the KVM_SET_DEVICE_ATTR ioctl:
>>>>>>
>>>>>> * The KVM_S390_VM_CRYPTO_ENABLE_APIE attribute enables hardware
>>>>>>      interpretation of AP instructions executed on the guest.
>>>>>>
>>>>>> * The KVM_S390_VM_CRYPTO_DISABLE_APIE attribute disables hardware
>>>>>>      interpretation of AP instructions executed on the guest. In this
>>>>>>      case the instructions will be intercepted and pass through to
>>>>>>      the guest.
>>>>>>
>>>>>> Signed-off-by: Tony Krowiak <akrowiak@linux.ibm.com>
>>>>>> ---
>>>>>>     arch/s390/include/asm/kvm_host.h |    1 +
>>>>>>     arch/s390/include/uapi/asm/kvm.h |    2 ++
>>>>>>     arch/s390/kvm/kvm-s390.c         |   27 +++++++++++++++++++++++----
>>>>>>     3 files changed, 26 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
>>>>>> index b32bd1b..36d3531 100644
>>>>>> --- a/arch/s390/include/asm/kvm_host.h
>>>>>> +++ b/arch/s390/include/asm/kvm_host.h
>>>>>> @@ -719,6 +719,7 @@ struct kvm_s390_crypto {
>>>>>>     	__u32 crycbd;
>>>>>>     	__u8 aes_kw;
>>>>>>     	__u8 dea_kw;
>>>>>> +	__u8 apie;
>>>>>>     };
>>>>>>     
>>>>>>     #define APCB0_MASK_SIZE 1
>>>>>> diff --git a/arch/s390/include/uapi/asm/kvm.h b/arch/s390/include/uapi/asm/kvm.h
>>>>>> index 8c23afc..a8dbd90 100644
>>>>>> --- a/arch/s390/include/uapi/asm/kvm.h
>>>>>> +++ b/arch/s390/include/uapi/asm/kvm.h
>>>>>> @@ -161,6 +161,8 @@ struct kvm_s390_vm_cpu_subfunc {
>>>>>>     #define KVM_S390_VM_CRYPTO_ENABLE_DEA_KW	1
>>>>>>     #define KVM_S390_VM_CRYPTO_DISABLE_AES_KW	2
>>>>>>     #define KVM_S390_VM_CRYPTO_DISABLE_DEA_KW	3
>>>>>> +#define KVM_S390_VM_CRYPTO_ENABLE_APIE		4
>>>>>> +#define KVM_S390_VM_CRYPTO_DISABLE_APIE		5
>>>>>>     
>>>>>>     /* kvm attributes for migration mode */
>>>>>>     #define KVM_S390_VM_MIGRATION_STOP	0
>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>> index 2cdd980..286c2e0 100644
>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>> @@ -856,12 +856,11 @@ void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>>>>>>     
>>>>>>     static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     {
>>>>>> -	if (!test_kvm_facility(kvm, 76))
>>>>>> -		return -EINVAL;
>>>>>> -
>>>>>>     	mutex_lock(&kvm->lock);
>>>>>>     	switch (attr->attr) {
>>>>>>     	case KVM_S390_VM_CRYPTO_ENABLE_AES_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		get_random_bytes(
>>>>>>     			kvm->arch.crypto.crycb->aes_wrapping_key_mask,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>>> @@ -869,6 +868,8 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		VM_EVENT(kvm, 3, "%s", "ENABLE: AES keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		get_random_bytes(
>>>>>>     			kvm->arch.crypto.crycb->dea_wrapping_key_mask,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>>> @@ -876,17 +877,31 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		VM_EVENT(kvm, 3, "%s", "ENABLE: DEA keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		kvm->arch.crypto.aes_kw = 0;
>>>>>>     		memset(kvm->arch.crypto.crycb->aes_wrapping_key_mask, 0,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->aes_wrapping_key_mask));
>>>>>>     		VM_EVENT(kvm, 3, "%s", "DISABLE: AES keywrapping support");
>>>>>>     		break;
>>>>>>     	case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>>> +		if (!test_kvm_facility(kvm, 76))
>>>>>> +			return -EINVAL;
>>>>>>     		kvm->arch.crypto.dea_kw = 0;
>>>>>>     		memset(kvm->arch.crypto.crycb->dea_wrapping_key_mask, 0,
>>>>>>     			sizeof(kvm->arch.crypto.crycb->dea_wrapping_key_mask));
>>>>>>     		VM_EVENT(kvm, 3, "%s", "DISABLE: DEA keywrapping support");
>>>>>>     		break;
>>>>>> +	case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>>> +		if (!ap_instructions_available()) {
>>>>>> +			mutex_unlock(&kvm->lock);
>>>>>> +			return -EOPNOTSUPP;
>>>>>> +		}
>>>>>> +		kvm->arch.crypto.apie = 1;
>>>>>> +		break;
>>>>>> +	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>>> +		kvm->arch.crypto.apie = 0;
>>>>>> +		break;
>>>>>>     	default:
>>>>>>     		mutex_unlock(&kvm->lock);
>>>>>>     		return -ENXIO;
>>>>>> @@ -1493,6 +1508,8 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm, struct kvm_device_attr *attr)
>>>>>>     		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>>>>>     		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>>>>>     		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>>>>>> +		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>>>>> +		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>>>>>
>>>>> As also replied to the QEMU series, could we indicate
>>>>> KVM_S390_VM_CRYPTO_ENABLE_APIE (and maybe
>>>>> KVM_S390_VM_CRYPTO_DISABLE_APIE) only with ap_instructions_available(),
>>>>> so we can avoid the additional KVM_S390_VM_CPU_FEAT_AP?
>>>>>
>>>>> KVM_S390_VM_CPU_FEAT_AP is right now completely unused in KVM otherwise
>>>>> (never checked, we only care about apie).
>>>>
>>>> After much discussion with Halil and a few exchanges with you, we
>>>> decided to go ahead and accept your suggestion to get rid of
>>>> KVM_S390_VM_CPU_FEAT and keep the VM device attributes to enable/disable
>>>> apie.
>>>>
>>>> To that end, I responded to patches 03/26, 11/26 and 25/26 with fixup!
>>>> patches that show the KVM/kernel changes that will be necessary to get
>>>> rid of KVM_S390_VM_CPU_FEAT and use apie to control ECA.28. I did that
>>>> to generate discussion in v10 rather than waiting until v11 for
>>>> comments. I make no guarantees that those fixup! patches will
>>>> successfully apply should you have a v10 branch generated from this
>>>> patch series you want to update.
>>>>
>>>
>>> Will you also fixup this patch to expose KVM_S390_VM_CRYPTO_ENABLE_APIE
>>> only if supported by HW? (ap_instructions_available)
>>
>> Given that this patch DOES expose KVM_S390_VM_CRYPTO_ENABLE_APIE only if
>> supported by HW, I assume you are talking about
>> KVM_S390_VM_CRYPTO_DISABLE_APIE. I didn't check
>> ap_instructions_available() for disabling APIE because I didn't
>> think it necessary given that ECA.28 will be set to 0 (intercept) by
>> default, whether AP instructions are installed or not; so why not allow
>> disabling apie. I suppose from the perspective of consistency, since the
>> kvm_s390_vm_has_attr() function checks ap_instructions_available() for
>> both attributes, then it probably makes sense to add that check to
>> KVM_S390_VM_CRYPTO_DISABLE_APIE here. Then again, we could make a change
>> in ap_instructions_available() to allow KVM_S390_VM_CRYPTO_DISABLE_APIE
>> regardless of whether AP instructions are available. It boils down to
>> whether APIE needs to be dynamically disabled at some point when it has
>> been enabled. The only case I can think of where that may be necessary
>> is if a guest is migrated to a system without AP instructions. I don't
>> think that can happen and may even be protected against precisely
>> because the VM attributes won't be available on the target system due to
>> no AP instructions. What say you?
>>
>>>
>>
> 
> Just so we're on the same page, I am talking about exposing, I talk
> about indicating the attribute:
> 
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 03c23045527f..40924fe05bdf 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -1491,6 +1491,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm,
> struct kvm_device_attr *attr)
>                  case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>                          ret = 0;
>                          break;
> +               case KVM_S390_VM_CRYPTO_ENABLE_APIE:
> +               case KVM_S390_VM_CRYPTO_DISABLE_APIE:
> +                       ret = -ENXIO;
> +                       if (ap_instructions_available())
> +                               ret = 0;
>                  default:
>                          ret = -ENXIO;
>                          break;
> 
> KVM_S390_VM_CRYPTO_DISABLE_APIE can either be handled like
> KVM_S390_VM_CRYPTO_ENABLE_APIE (return -EOPNOTSUPP) when setting or
> always be allowed. I'll leave that up to you. But as it is completely
> useless without ap_instructions_available() /
> KVM_S390_VM_CRYPTO_ENABLE_APIE , we might as well also just not expose
> it then.

We are on the same page.

> 
