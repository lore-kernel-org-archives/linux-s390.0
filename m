From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Sun, 22 Apr 2018 11:10:45 -0400
Message-ID: <b7f76d7e-c7e1-ba7f-fc7a-abb7affc6a93@linux.vnet.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <870459b4-228d-0be3-5dd3-48ab480b46de@linux.ibm.com>
 <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <ac56c3e5-bbf5-5083-9988-eb8a337e0bb0@linux.ibm.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 04/20/2018 08:15 AM, Janosch Frank wrote:
> On 20.04.2018 13:59, Janosch Frank wrote:
>> Thanks, applied.
>>
> Well this does not compile, as you use kvm_s390_vcpu_crypto_setup before
> declaration. Please fix, then I'll take the patch.

Stupid mistake. I'll fix it.

>
>
>> On 19.04.2018 23:13, Tony Krowiak wrote:
>>> Introduces a new function to reset the crypto attributes for all
>>> vcpus whether they are running or not. Each vcpu in KVM will
>>> be removed from SIE prior to resetting the crypto attributes in its
>>> SIE state description. After all vcpus have had their crypto attributes
>>> reset the vcpus will be restored to SIE.
>>>
>>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>>> function to fix a reported issue whereby the crypto key wrapping
>>> attributes could potentially get out of synch for running vcpus.
>>>
>>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
>>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>>> ---
>>>   arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>>>   arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>> index fa355a6..4fa3037 100644
>>> --- a/arch/s390/kvm/kvm-s390.c
>>> +++ b/arch/s390/kvm/kvm-s390.c
>>> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>>>   	return ret;
>>>   }
>>>
>>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>>> + {
>>> +	int i;
>>> +	struct kvm_vcpu *vcpu;
>>> +
>>> +	kvm_s390_vcpu_block_all(kvm);
>>> +
>>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>>> +	        kvm_s390_vcpu_crypto_setup(vcpu);
>>> +
>>> +	kvm_s390_vcpu_unblock_all(kvm);
>>> +}
>>> +
>>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>>>
>>>   static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>>   		return -ENXIO;
>>>   	}
>>>
>>> -	kvm_for_each_vcpu(i, vcpu, kvm) {
>>> -		kvm_s390_vcpu_crypto_setup(vcpu);
>>> -		exit_sie(vcpu);
>>> -	}
>>> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>>>   	mutex_unlock(&kvm->lock);
>>>   	return 0;
>>>   }
>>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>>> index 1b5621f..981e3ba 100644
>>> --- a/arch/s390/kvm/kvm-s390.h
>>> +++ b/arch/s390/kvm/kvm-s390.h
>>> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>>>   }
>>>   void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>>>   				     struct mcck_volatile_info *mcck_info);
>>> +
>>> +/**
>>> + * kvm_s390_vcpu_crypto_reset_all
>>> + *
>>> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
>>> + * are running as each vcpu will be removed from SIE before resetting the crypt
>>> + * attributes and restored to SIE afterward.
>>> + *
>>> + * Note: The kvm->lock must be held while calling this function
>>> + *
>>> + * @kvm: the KVM guest
>>> + */
>>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>>>   #endif
>>>
>>
>
