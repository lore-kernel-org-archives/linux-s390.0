Return-Path: <SRS0=sFCg=TC=vger.kernel.org=kvm-owner@kernel.org>
Subject: Re: [PATCH v4 2/2] s390/kvm: diagnose 318 handling
References: <1556751063-21835-1-git-send-email-walling@linux.ibm.com>
 <1556751063-21835-3-git-send-email-walling@linux.ibm.com>
 <783ecdb4-3bc2-4bf3-55cb-9a902467aadd@redhat.com>
 <1988b4c3-e123-47dd-2008-15d8bec0171d@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <02bfe52f-95e7-b4a3-e8d3-a8a8fffc5dec@redhat.com>
Date: Thu, 2 May 2019 17:39:50 +0200
MIME-Version: 1.0
In-Reply-To: <1988b4c3-e123-47dd-2008-15d8bec0171d@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Collin Walling <walling@linux.ibm.com>, cohuck@redhat.com, pbonzini@redhat.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On 02.05.19 17:25, Collin Walling wrote:
> On 5/2/19 8:59 AM, David Hildenbrand wrote:
>> On 02.05.19 00:51, Collin Walling wrote:
>>> DIAGNOSE 0x318 (diag318) is a privileged s390x instruction that must
>>> be intercepted by SIE and handled via KVM. Let's introduce some
>>> functions to communicate between userspace and KVM via ioctls. These
>>> will be used to get/set the diag318 related information (also known
>>> as the "Control Program Code" or "CPC"), as well as check the system
>>> if KVM supports handling this instruction.
>>>
>>> This information can help with diagnosing the OS the VM is running
>>> in (Linux, z/VM, etc) if the OS calls this instruction.
>>>
>>> The get/set functions are introduced primarily for VM migration and
>>> reset, though no harm could be done to the system if a userspace
>>> program decides to alter this data (this is highly discouraged).
>>>
>>> The Control Program Name Code (CPNC) is stored in the SIE block and
>>> a copy is retained in each VCPU. The Control Program Version Code
>>> (CPVC) retains a copy in each VCPU as well.
>>>
>>> At this time, the CPVC is not reported as its format is yet to be
>>> defined.
>>>
>>> Note that the CPNC is set in the SIE block iff the host hardware
>>> supports it.
>>
>> For vSIE and SIE you only configure the CPNC. Is that sufficient?
>> Shouldn't diag318 allow the guest to set both? (especially regarding vSIE)
>>
> 
> The SIE block only stores the CPNC. The CPVC is not designed to be
> stored in the SIE block, so we store it in guest memory only.

How can the cpvc value be used? Who will access it? Right now, it is
only written to some location in KVM, and only read/written during
migration.

You mention "The Control Program Version Code (CPVC) retains a copy in
each VCPU as well", this is wrong, no?

> 
>> [...]
>>>
>>> diff --git a/Documentation/virtual/kvm/devices/vm.txt b/Documentation/virtual/kvm/devices/vm.txt
>>> index 95ca68d..9a8d934 100644
>>> --- a/Documentation/virtual/kvm/devices/vm.txt
>>> +++ b/Documentation/virtual/kvm/devices/vm.txt
>>> @@ -267,3 +267,17 @@ Parameters: address of a buffer in user space to store the data (u64) to;
>>>   	    if it is enabled
>>>   Returns:    -EFAULT if the given address is not accessible from kernel space
>>>   	    0 in case of success.
>>> +
>>> +6. GROUP: KVM_S390_VM_MISC
>>> +Architectures: s390
>>> +
>>> +6.1. KVM_S390_VM_MISC_CPC (r/w)
>>> +
>>> +Allows userspace to access the "Control Program Code" which consists of a
>>> +1-byte "Control Program Name Code" and a 7-byte "Control Program Version Code".
>>> +This information is initialized during IPL and must be preserved during
>>> +migration.
>>
>> Your implementation does not match this description. User space can only
>> get/set the cpnc effectively for the HW to see it, not the CPVC, no?
>>
> 
> We retrieve the entire CPNC + CPVC. User space (i.e. QEMU) can retrieve
> this 64-bit value and save / load it during live guest migration.
> 
> I figured it would be best to set / get this entire value now, so that
> we don't need to add extra handling for the version code later when its
> format is properly decided.
> 
>> Shouldn't you transparently forward that data to the SCB for vSIE/SIE,
>> because we really don't care what the target format will be?
>>
> 
> Sorry, I'm not fully understanding what you mean by "we really don't
> care what the target format will be?"
> 
> Do you mean to shadow the CPNC without checking if diag318 is supported?
> I imagine that would be harmless.

No, I was rather wondering about the CPVC format. But I think I am
missing how that one will be used at all.

-- 

Thanks,

David / dhildenb
