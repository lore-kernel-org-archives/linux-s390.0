From: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Sun, 22 Apr 2018 11:06:43 -0400
Message-ID: <d6e8e85b-525e-906a-3c17-ea5faef143cb@linux.vnet.ibm.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 04/20/2018 08:26 AM, David Hildenbrand wrote:
> On 19.04.2018 23:13, Tony Krowiak wrote:
>> Introduces a new function to reset the crypto attributes for all
>> vcpus whether they are running or not. Each vcpu in KVM will
>> be removed from SIE prior to resetting the crypto attributes in its
>> SIE state description. After all vcpus have had their crypto attributes
>> reset the vcpus will be restored to SIE.
>>
>> This function is incorporated into the kvm_s390_vm_set_crypto(kvm)
>> function to fix a reported issue whereby the crypto key wrapping
>> attributes could potentially get out of synch for running vcpus.
>>
>> Reported-by: Halil Pasic <pasic@linux.vnet.ibm.com>
> A reported-by for a code refactoring is strange.

I was asked to include this.

>
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>   arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>>   arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>>   2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index fa355a6..4fa3037 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>>   	return ret;
>>   }
>>   
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm)
>> + {
>> +	int i;
>> +	struct kvm_vcpu *vcpu;
>> +
>> +	kvm_s390_vcpu_block_all(kvm);
>> +
>> +	kvm_for_each_vcpu(i, vcpu, kvm)
>> +	        kvm_s390_vcpu_crypto_setup(vcpu);
>> +
>> +	kvm_s390_vcpu_unblock_all(kvm);
> This code has to be protected by kvm->lock. Can that be guaranteed by
> the caller?

I can hold the kvm->lock in this function, but if you look at the 
function from which it
is called, kvm_s390_vm_set_crypto(vcpu) below, the kvm->lock is already 
held by that
function to do other work. I suppose the kvm_s390_vm_set_crypto(vcpu) 
instruction could
have released the lock prior to calling 
kvm_s390_vcpu_crypto_reset_all(kvm), but since
this function is called within a block of crypto work, it made sense to 
me to place
the responsibility for locking in the caller and include a comment in 
the comments for
the function definition:

Note: The kvm->lock must be held while calling this function



>
>> +}
>> +
>>   static void kvm_s390_vcpu_crypto_setup(struct kvm_vcpu *vcpu);
>>   
>>   static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>> @@ -832,10 +845,7 @@ static int kvm_s390_vm_set_crypto(struct kvm *kvm, struct kvm_device_attr *attr)
>>   		return -ENXIO;
>>   	}
>>   
>> -	kvm_for_each_vcpu(i, vcpu, kvm) {
>> -		kvm_s390_vcpu_crypto_setup(vcpu);
>> -		exit_sie(vcpu);
>> -	}
>> +	kvm_s390_vcpu_crypto_reset_all(kvm);
>>   	mutex_unlock(&kvm->lock);
>>   	return 0;
>>   }
>> diff --git a/arch/s390/kvm/kvm-s390.h b/arch/s390/kvm/kvm-s390.h
>> index 1b5621f..981e3ba 100644
>> --- a/arch/s390/kvm/kvm-s390.h
>> +++ b/arch/s390/kvm/kvm-s390.h
>> @@ -410,4 +410,17 @@ static inline int kvm_s390_use_sca_entries(void)
>>   }
>>   void kvm_s390_reinject_machine_check(struct kvm_vcpu *vcpu,
>>   				     struct mcck_volatile_info *mcck_info);
>> +
>> +/**
>> + * kvm_s390_vcpu_crypto_reset_all
>> + *
>> + * Reset the crypto attributes for each vcpu. This can be done while the vcpus
>> + * are running as each vcpu will be removed from SIE before resetting the crypt
>> + * attributes and restored to SIE afterward.
>> + *
>> + * Note: The kvm->lock must be held while calling this function
>> + *
>> + * @kvm: the KVM guest
>> + */
>> +void kvm_s390_vcpu_crypto_reset_all(struct kvm *kvm);
>>   #endif
>>
>
