From: David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH] KVM: s390: reset crypto attributes for all vcpus
Date: Fri, 20 Apr 2018 14:28:40 +0200
Message-ID: <f8c6e1c0-3ed7-8c25-7da2-01fb27a928ac@redhat.com>
References: <1524172432-26211-1-git-send-email-akrowiak@linux.vnet.ibm.com>
 <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <d7ed9844-0753-6d7a-ccd8-48e89992a34e@redhat.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, cohuck@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pbonzini@redhat.com, rkrcmar@redhat.com
List-ID: <linux-s390.vger.kernel.org>

On 20.04.2018 14:26, David Hildenbrand wrote:
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
> 
> A reported-by for a code refactoring is strange.
> 
>> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
>> ---
>>  arch/s390/kvm/kvm-s390.c |   18 ++++++++++++++----
>>  arch/s390/kvm/kvm-s390.h |   13 +++++++++++++
>>  2 files changed, 27 insertions(+), 4 deletions(-)
>>
>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>> index fa355a6..4fa3037 100644
>> --- a/arch/s390/kvm/kvm-s390.c
>> +++ b/arch/s390/kvm/kvm-s390.c
>> @@ -789,6 +789,19 @@ static int kvm_s390_set_mem_control(struct kvm *kvm, struct kvm_device_attr *att
>>  	return ret;
>>  }
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
> 
> This code has to be protected by kvm->lock. Can that be guaranteed by
> the caller?

Answering my own question: as the caller has access to struct kvm, the
can of course lock it :)

-- 

Thanks,

David / dhildenb
