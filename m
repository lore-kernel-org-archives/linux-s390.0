From: Collin Walling <walling@linux.ibm.com>
Date: Thu, 13 Dec 2018 15:54:36 +0000
Subject: Re: [PATCH v2 2/2] s390/kvm: handle diagnose 318 instruction call
Message-Id: <609d79a2-db3b-84fd-d452-1429775a3ae1@linux.ibm.com>
In-Reply-To: <564a769b-4ce0-bba0-bb4a-2aa6f9b42ec6@linux.ibm.com>
References: <564a769b-4ce0-bba0-bb4a-2aa6f9b42ec6@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 12/13/18 6:19 AM, Janosch Frank wrote:
> On 13.12.18 11:27, David Hildenbrand wrote:
>> On 13.12.18 11:21, Cornelia Huck wrote:
>>> On Thu, 13 Dec 2018 10:12:49 +0100
>>> David Hildenbrand <david@redhat.com> wrote:
>>>
>>>> On 12.12.18 14:08, Cornelia Huck wrote:
>>>>> On Wed, 12 Dec 2018 11:49:56 +0100
>>>>> David Hildenbrand <david@redhat.com> wrote:
>>>>>   
>>>>>> I am wondering if another way to handle this would maybe be even better.
>>>>>> It would allow also new QEMU on old KVM to get access to these values.
>>>>>> It will simply not be written to HW then (bad luck, there is no HW
>>>>>> support eventually)
>>>>>>
>>>>>>
>>>>>> It goes like this:
>>>>>>
>>>>>> 1. don't implement diag318 in the kernel, implement it in user space.
>>>>>> diag318 is already forwarded to QEMU as of now. (I don't consider
>>>>>> diag318 peformance relevant)
>>>>>>
>>>>>> 2. in user space, we can always support diag318, even without KVM/HW
>>>>>> support. (could glue to machines if really needed)
>>>>>>
>>>>>> 3. If we get a diag318 and the CPU feature is not enabled, handle it if
>>>>>> diag318 is not available (exception, just as we do now).
>>>>>>
>>>>>> 3. If we get a diag318 and the CPU feature is enabled, store both values
>>>>>> in QEMU (for migration and e.g. DUMPs) AND ...
>>>>>>
>>>>>> 4. ... if KVM supports KVM_S390_VM_MACHINE_CPC, also write the new
>>>>>> values (or even only the CPNC! ) to KVM.
>>>>>>
>>>>>> 5. During migration, if KVM supports KVM_S390_VM_MACHINE_CPC, also write
>>>>>> the migrated value to KVM.  
>>>>>
>>>>> What about that sclp thingie (I'm not quite sure what it signifies)?  
>>>>
>>>> You mean the indication of diag318? Well we might want to check in KVM
>>>> if the host has it (and therefore the CPNC in the SCB actually gets
>>>> used) and only then allow to set the CPNC. Or we could simply always
>>>> allow to write it to the SCB even though the value won't get used by HW.
>>>
>>> Maybe always allow to write it, for simplicity's sake? Does it matter
>>> much whether it will get used by HW?
>>>
>>
>> Usually it does not matter. I remember that there were some fields that
>> should not be touched if the feature is not available (otherwise you
>> might get undefined behavior).
>>
> 
> @Collin: Could you clear that up?
> I'd prefer to always have it if possible, if it would result in
> undefined behavior we could store it in the KVM struct and not write it
> to the SCB if the sclp bit is off.
> 

It should be completely safe. The CPNC takes up a previously reserved location
and firmware treats the CPNC as a read-only value. If we have it in the SCB and
firmware doesn't support reading it, then no harm is done.

> It would be nice to have a consolidated sysfs or debugfs interface to
> read that (and other things) from userspace, not having to parse the VM
> messages. Well, maybe some other time.
> 

Hm. Might be a useful feature for the host to get a quick at-a-glance
view of what guests are running. We should keep this in mind.

-- 
Respectfully,
- Collin Walling
