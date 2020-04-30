Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from out01.mta.xmission.com ([166.70.13.231]:39130 "EHLO
        out01.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726285AbgD3SJt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 14:09:49 -0400
From: ebiederm@xmission.com (Eric W. Biederman)
References: <20200430102908.10107-1-david@redhat.com>
        <20200430102908.10107-3-david@redhat.com>
        <87pnbp2dcz.fsf@x220.int.ebiederm.org>
        <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
        <871ro52ary.fsf@x220.int.ebiederm.org>
        <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
Date: Thu, 30 Apr 2020 13:06:26 -0500
In-Reply-To: <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com> (David
        Hildenbrand's message of "Thu, 30 Apr 2020 18:49:39 +0200")
Message-ID: <875zdg26hp.fsf@x220.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce MHP_NO_FIRMWARE_MEMMAP
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

David Hildenbrand <david@redhat.com> writes:

> On 30.04.20 18:33, Eric W. Biederman wrote:
>> David Hildenbrand <david@redhat.com> writes:
>> 
>>> On 30.04.20 17:38, Eric W. Biederman wrote:
>>>> David Hildenbrand <david@redhat.com> writes:
>>>>
>>>>> Some devices/drivers that add memory via add_memory() and friends (e.g.,
>>>>> dax/kmem, but also virtio-mem in the future) don't want to create entries
>>>>> in /sys/firmware/memmap/ - primarily to hinder kexec from adding this
>>>>> memory to the boot memmap of the kexec kernel.
>>>>>
>>>>> In fact, such memory is never exposed via the firmware memmap as System
>>>>> RAM (e.g., e820), so exposing this memory via /sys/firmware/memmap/ is
>>>>> wrong:
>>>>>  "kexec needs the raw firmware-provided memory map to setup the
>>>>>   parameter segment of the kernel that should be booted with
>>>>>   kexec. Also, the raw memory map is useful for debugging. For
>>>>>   that reason, /sys/firmware/memmap is an interface that provides
>>>>>   the raw memory map to userspace." [1]
>>>>>
>>>>> We don't have to worry about firmware_map_remove() on the removal path.
>>>>> If there is no entry, it will simply return with -EINVAL.
>>>>>
>>>>> [1]
>>>>> https://www.kernel.org/doc/Documentation/ABI/testing/sysfs-firmware-memmap
>>>>
>>>>
>>>> You know what this justification is rubbish, and I have previously
>>>> explained why it is rubbish.
>>>
>>> Actually, no, I don't think it is rubbish. See patch #3 and the cover
>>> letter why this is the right thing to do *for special memory*, *not
>>> ordinary DIMMs*.
>>>
>>> And to be quite honest, I think your response is a little harsh. I don't
>>> recall you replying to my virtio-mem-related comments.
>>>
>>>>
>>>> Nacked-by: "Eric W. Biederman" <ebiederm@xmission.com>
>>>>
>>>> This needs to be based on weather the added memory is ultimately normal
>>>> ram or is something special.
>>>
>>> Yes, that's what the caller are expected to decide, see patch #3.
>>>
>>> kexec should try to be as closely as possible to a real reboot - IMHO.
>> 
>> That is very fuzzy in terms of hotplug memory.  The kexec'd kernel
>> should see the hotplugged memory assuming it is ordinary memory.
>> 
>> But kexec is not a reboot although it is quite similar.   Kexec is
>> swapping one running kernel and it's state for another kernel without
>> rebooting.
>
> I agree (especially regarding the arm64 DIMM hotplug discussion).
> However, for the two cases
>
> a) dax/kmem
> b) virtio-mem
>
> We really want to let the driver take back control and figure out "what
> to do with the memory".

From reading your v1 cover letter (the description appears missing in
v2) I see what you are talking about with respect to virtio-mem.

So I will count virt-io mem as something different.

>>>> Justifying behavior by documentation that does not consider memory
>>>> hotplug is bad thinking.
>>>
>>> Are you maybe confusing this patch series with the arm64 approach? This
>>> is not about ordinary hotplugged DIMMs.
>> 
>> I think I am.
>> 
>> My challenge is that I don't see anything in the description that says
>> this isn't about ordinary hotplugged DIMMs.  All I saw was hotplug
>> memory.
>
> I'm sorry if that was confusing, I tried to stress that kmem and
> virtio-mem is special in the description.
>
> I squeezed a lot of that information into the cover letter and into
> patch #3.


>> If the class of memory is different then please by all means let's mark
>> it differently in struct resource so everyone knows it is different.
>> But that difference needs to be more than hotplug.
>> 
>> That difference needs to be the hypervisor loaned us memory and might
>> take it back at any time, or this memory is persistent and so it has
>> these different characteristics so don't use it as ordinary ram.
>
> Yes, and I think kmem took an excellent approach of explicitly putting
> that "System RAM" into a resource hierarchy. That "System RAM" won't
> show up as a root node under /proc/iomem (see patch #3), which already
> results in kexec-tools to treat it in a special way. I am thinking about
> doing the same for virtio-mem.

Reading this and your patch cover letters again my concern is that
the justification seems to be letting the tail wag the dog.

You want kexec-tools to behave in a certain way so you are changing the
kernel.

Rather it should be change the kernel to clearly reflect reality and if
you can get away without a change to kexec-tools that is a bonus.

>> That information is also useful to other people looking at the system
>> and seeing what is going on.
>> 
>> Just please don't muddle the concepts, or assume that whatever subset of
>> hotplug memory you are dealing with is the only subset.
>
> I can certainly rephrase the subject/description/comment, stating that
> this is not to be used for ordinary hotplugged DIMMs - only when the
> device driver is under control to decide what to do with that memory -
> especially when kexec'ing.
>
> (previously, I called this flag MHP_DRIVER_MANAGED, but I think
> MHP_NO_FIRMWARE_MEMMAP is clearer, we just need a better description)
>
> Would that make it clearer?

I am not certain, but Andrew Morton deliberately added that
firmware_map_add_hotplug call.  Which means that there is a reason
for putting hotplugged memory in the firmware map.

So the justification needs to take that reason into account.  The
justification can not be it is hotplugged therefore it should not belong
in the firmware memory map.  Unless you can show that
firmware_map_add_hotplug that was actually a bug and should be removed.
But as it has been that way since 2010 that seems like a long shot.

So my question is what is right for the firmware map?

Why does the firmware map support hotplug entries?

Once we have the answers to those questions we can figure out what logic
the special kinds of memory hotplug need.

Ref: d96ae5309165 ("memory-hotplug: create /sys/firmware/memmap entry for new memory")

Eric
