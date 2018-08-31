From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 31 Aug 2018 08:56:01 +0000
Subject: Re: [PATCH] KVM: s390: Properly lock mm context allow_gmap_hpage_1m setting
Message-Id: <24f9ee75-7094-e631-186a-c58896fbc804@de.ibm.com>
In-Reply-To: <ae24850c-f882-6948-401b-145fd1805437@redhat.com>
References: <ae24850c-f882-6948-401b-145fd1805437@redhat.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>



On 08/31/2018 10:53 AM, David Hildenbrand wrote:
> On 31.08.2018 10:48, Christian Borntraeger wrote:
>>
>>
>> On 08/31/2018 09:52 AM, David Hildenbrand wrote:
>>> On 31.08.2018 08:20, Janosch Frank wrote:
>>>> On 30.08.2018 16:18, David Hildenbrand wrote:
>>>>> On 30.08.2018 16:15, Janosch Frank wrote:
>>>>>> We have to do down_write on the mm semaphore to set a bitfield in the
>>>>>> mm context.
>>>>>>
>>>>>> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
>>>>>> Fixes: a4499382 ("KVM: s390: Add huge page enablement control")
>>>>>> ---
>>>>>>  arch/s390/include/asm/mmu.h | 8 +++++++-
>>>>>>  arch/s390/kvm/kvm-s390.c    | 2 ++
>>>>>>  2 files changed, 9 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/s390/include/asm/mmu.h b/arch/s390/include/asm/mmu.h
>>>>>> index f31a15044c24..a8418e1379eb 100644
>>>>>> --- a/arch/s390/include/asm/mmu.h
>>>>>> +++ b/arch/s390/include/asm/mmu.h
>>>>>> @@ -16,7 +16,13 @@ typedef struct {
>>>>>>  	unsigned long asce;
>>>>>>  	unsigned long asce_limit;
>>>>>>  	unsigned long vdso_base;
>>>>>> -	/* The mmu context allocates 4K page tables. */
>>>>>> +	/*
>>>>>> +	 * The following bitfields need a down_write on the mm
>>>>>> +	 * semaphore when they are written to. As they are only
>>>>>> +	 * written once, they can be read without a lock.
>>>>>> +	 *
>>>>>> +	 * The mmu context allocates 4K page tables.
>>>>>> +	 */
>>>>>>  	unsigned int alloc_pgste:1;
>>>>>>  	/* The mmu context uses extended page tables. */
>>>>>>  	unsigned int has_pgste:1;
>>>>>> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
>>>>>> index 8c039e12cb24..ac5da6b0b862 100644
>>>>>> --- a/arch/s390/kvm/kvm-s390.c
>>>>>> +++ b/arch/s390/kvm/kvm-s390.c
>>>>>> @@ -695,7 +695,9 @@ static int kvm_vm_ioctl_enable_cap(struct kvm *kvm, struct kvm_enable_cap *cap)
>>>>>>  			r = -EINVAL;
>>>>>>  		else {
>>>>>>  			r = 0;
>>>>>> +			down_write(&kvm->mm->mmap_sem);
>>>>>>  			kvm->mm->context.allow_gmap_hpage_1m = 1;
>>>>>> +			up_write(&kvm->mm->mmap_sem);
>>>>>>  			/*
>>>>>>  			 * We might have to create fake 4k page
>>>>>>  			 * tables. To avoid that the hardware works on
>>>>>>
>>>>>
>>>>> This is a theoretical scenario, right?
>>>>>
>>>>> (GMAP without vcpus will not be populated as far as I remember)
>>>>
>>>> Yes, currently highly unlikely.
>>>>
>>>> It's not the GMAP that bothers me here, it's the bitfield within the
>>>> context. If we are very unlucky, we could loose a write to it.
>>>
>>> Right, although I think this is also very theoretical. Never the less,
>>> this is certainly the right thing to do.
>>
>> Yes. The compiler might even use the oi instruction (which is on all newer machines
>> atomic in terms of setting bits).
>>>
>>> (I am just wondering if this one is worth backporting, do you see the need?)
>>
>> This also fixes a patch that was added after 4.18 so we should just add it for 4.19.
>>
> 
> Yes, backports to stable do not apply, but maybe to something else ;)

Yes, whoever picks a4499382 ("KVM: s390: Add huge page enablement control") should also
pick this. Thats what the Fixes tag is for :-)
