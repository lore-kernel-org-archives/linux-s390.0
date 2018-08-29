From: David Hildenbrand <david@redhat.com>
Date: Wed, 29 Aug 2018 14:45:24 +0000
Subject: Re: [PATCH] KVM: s390: Fix pfmf and conditional skey emulation
Message-Id: <bcb88b0d-37c7-e145-8601-aab0e3499415@redhat.com>
In-Reply-To: <d85c70f9-b030-5b5a-cfd0-b4a85ee4c6b8@linux.ibm.com>
References: <d85c70f9-b030-5b5a-cfd0-b4a85ee4c6b8@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 29.08.2018 16:44, Janosch Frank wrote:
> On 29.08.2018 15:31, David Hildenbrand wrote:
>> On 29.08.2018 15:19, Janosch Frank wrote:
>>> We should not return with a lock.
>>> We also have to increase the address when we do page clearing.
>>>
>>> Fixes: bd096f644319 ("KVM: s390: Add skey emulation fault handling")
>>> Fixes: 0230cae75df6 ("KVM: s390: Replace clear_user with kvm_clear_guest")
> 
> These will will be removed, KVM: s390: Add skey emulation fault handling
> is only in rc1.
> 
>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>> ---
>>>  arch/s390/kvm/priv.c | 9 +++++----
>>>  1 file changed, 5 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
>>> index d68f10441a16..7d61dccfd034 100644
>>> --- a/arch/s390/kvm/priv.c
>>> +++ b/arch/s390/kvm/priv.c
>>> @@ -390,10 +390,10 @@ static int handle_sske(struct kvm_vcpu *vcpu)
>>>  					      FAULT_FLAG_WRITE, &unlocked);
>>>  			rc = !rc ? -EAGAIN : rc;
>>>  		}
>>> +		up_read(&current->mm->mmap_sem);
>>>  		if (rc == -EFAULT)
>>>  			return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>>>  
>>> -		up_read(&current->mm->mmap_sem);
>>
>> Indeed.
>>
>>>  		if (rc >= 0)
>>>  			start += PAGE_SIZE;
>>>  	}
>>> @@ -1002,13 +1002,14 @@ static int handle_pfmf(struct kvm_vcpu *vcpu)
>>>  						      FAULT_FLAG_WRITE, &unlocked);
>>>  				rc = !rc ? -EAGAIN : rc;
>>>  			}
>>> +			up_read(&current->mm->mmap_sem);
>>
>> that's certainly correct
>>
>>>  			if (rc == -EFAULT)
>>>  				return kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
>>> +			if (rc == -EAGAIN)
>>
>> I would prefer "rc < 0" instead I guess.
> 
> No, I do not want to continue on any other rc.
> But we could add this afterwards:
> if (rc < 0)
> 	return rc;

Makes sense. (otherwise it could smell like an endless loop)


-- 

Thanks,

David / dhildenb
