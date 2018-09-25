From: Tony Krowiak <akrowiak@linux.ibm.com>
Subject: Re: [PATCH v10 24/26] KVM: s390: device attrs to enable/disable AP
 interpretation
Date: Tue, 25 Sep 2018 09:26:12 -0400
Message-ID: <889157be-c209-8938-ccb2-240ae5249cda@linux.ibm.com>
References: <1536781396-13601-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <1536781396-13601-25-git-send-email-akrowiak@linux.vnet.ibm.com>
 <9263b698-1827-1b7f-28bf-75b44657dea2@redhat.com>
 <18a21cda-1da9-3bfb-7b34-80415b5457f9@linux.ibm.com>
 <172560fb-2c54-ea43-3401-f108cf2a0595@redhat.com>
 <bb2639ac-469a-a71f-8f0a-2df3c12c6ac5@linux.ibm.com>
 <1c0c5a2e-3ef4-e5f5-52b8-7aeddca1f472@linux.ibm.com>
 <62f0cacc-8338-9370-a4dc-12f793214c48@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <62f0cacc-8338-9370-a4dc-12f793214c48@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, cohuck@redhat.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, berrange@redhat.com, fiuczy@linux.vnet.ibm.com, buendgen@de.ibm.com, frankja@linux.ibm.com
List-ID: <linux-s390.vger.kernel.org>

On 09/25/2018 03:32 AM, David Hildenbrand wrote:
> On 24/09/2018 20:42, Tony Krowiak wrote:
>> On 09/24/2018 12:25 PM, Tony Krowiak wrote:
>>> On 09/24/2018 07:23 AM, David Hildenbrand wrote:
>>
>> (...)
>>
>>>> Will you also fixup this patch to expose KVM_S390_VM_CRYPTO_ENABLE_APIE
>>>> only if supported by HW? (ap_instructions_available)
>>>
>>> Given that this patch DOES expose KVM_S390_VM_CRYPTO_ENABLE_APIE only if
>>> supported by HW, I assume you are talking about
>>> KVM_S390_VM_CRYPTO_DISABLE_APIE. I didn't check
>>> ap_instructions_available() for disabling APIE because I didn't
>>> think it necessary given that ECA.28 will be set to 0 (intercept) by
>>> default, whether AP instructions are installed or not; so why not allow
>>> disabling apie. I suppose from the perspective of consistency, since the
>>> kvm_s390_vm_has_attr() function checks ap_instructions_available() for
>>> both attributes, then it probably makes sense to add that check to
>>> KVM_S390_VM_CRYPTO_DISABLE_APIE here. Then again, we could make a change
>>> in ap_instructions_available() to allow KVM_S390_VM_CRYPTO_DISABLE_APIE
>>> regardless of whether AP instructions are available. It boils down to
>>> whether APIE needs to be dynamically disabled at some point when it has
>>> been enabled. The only case I can think of where that may be necessary
>>> is if a guest is migrated to a system without AP instructions. I don't
>>> think that can happen and may even be protected against precisely
>>> because the VM attributes won't be available on the target system due to
>>> no AP instructions. What say you?
>>>
>> David,
>>
>> I'm sorry, I misinterpreted what you were asking for. Check out the
>> fixup! patch below and let me know if that is what you are looking for.
>> If so, I will integrate that change and post v11 tomorrow (Tuesday 9/24).
>>
>> -----------------------------------8<-----------------------------------
>>
>> From: Tony Krowiak <akrowiak@linux.ibm.com>
>> Date: Mon, 24 Sep 2018 14:18:37 -0400
>> Subject: [FIXUP v10] fixup! KVM: s390: device attrs to enable/disable AP
>>    interpretation
>>
>> ---
>>    arch/s390/kvm/kvm-s390.c | 9 ++++++++-
>>    1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index 6654bb1fc26a..a528558baa78 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -901,6 +901,10 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm,
>> struct kvm_device_attr *attr)
>>    		kvm->arch.crypto.apie = 1;
>>    		break;
>>    	case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>> +		if (!ap_instructions_available()) {
>> +			mutex_unlock(&kvm->lock);
>> +			return -EOPNOTSUPP;
>> +		}
>>    		kvm->arch.crypto.apie = 0;
>>    		break;
>>    	default:
>> @@ -1509,9 +1513,11 @@ static int kvm_s390_vm_has_attr(struct kvm *kvm,
>> struct kvm_device_attr *attr)
>>    		case KVM_S390_VM_CRYPTO_ENABLE_DEA_KW:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_AES_KW:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_DEA_KW:
>> +			ret = 0;
>> +			break;
>>    		case KVM_S390_VM_CRYPTO_ENABLE_APIE:
>>    		case KVM_S390_VM_CRYPTO_DISABLE_APIE:
>> -			ret = 0;
>> +			ret = ap_instructions_available();
> 
> Just a little remark, I guess we want to report 0 if available and
> -ENXIO if not.

That makes sense ... I'll fix it.

> 
