Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:42179 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726338AbgD3Snz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 30 Apr 2020 14:43:55 -0400
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org>
 <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org>
 <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
Date: Thu, 30 Apr 2020 20:43:39 +0200
MIME-Version: 1.0
In-Reply-To: <875zdg26hp.fsf@x220.int.ebiederm.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev@lists.ozlabs.org, linux-acpi@vger.kernel.org, linux-nvdimm@lists.01.org, linux-hyperv@vger.kernel.org, linux-s390@vger.kernel.org, xen-devel@lists.xenproject.org, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

 >>> If the class of memory is different then please by all means let's m=
ark
>>> it differently in struct resource so everyone knows it is different.
>>> But that difference needs to be more than hotplug.
>>>
>>> That difference needs to be the hypervisor loaned us memory and might
>>> take it back at any time, or this memory is persistent and so it has
>>> these different characteristics so don't use it as ordinary ram.
>>
>> Yes, and I think kmem took an excellent approach of explicitly putting
>> that "System RAM" into a resource hierarchy. That "System RAM" won't
>> show up as a root node under /proc/iomem (see patch #3), which already
>> results in kexec-tools to treat it in a special way. I am thinking abo=
ut
>> doing the same for virtio-mem.
>=20
> Reading this and your patch cover letters again my concern is that
> the justification seems to be letting the tail wag the dog.
>=20
> You want kexec-tools to behave in a certain way so you are changing the
> kernel.
>=20
> Rather it should be change the kernel to clearly reflect reality and if
> you can get away without a change to kexec-tools that is a bonus.
>=20

Right, because user space has to have a way to figure out what to do.

But talking about the firmware memmap, indicating something via a "raw
firmware-provided memory map", that is not actually in the "raw
firmware-provided memory map" feels wrong to me. (below)


>>> That information is also useful to other people looking at the system
>>> and seeing what is going on.
>>>
>>> Just please don't muddle the concepts, or assume that whatever subset=
 of
>>> hotplug memory you are dealing with is the only subset.
>>
>> I can certainly rephrase the subject/description/comment, stating that
>> this is not to be used for ordinary hotplugged DIMMs - only when the
>> device driver is under control to decide what to do with that memory -
>> especially when kexec'ing.
>>
>> (previously, I called this flag MHP_DRIVER_MANAGED, but I think
>> MHP_NO_FIRMWARE_MEMMAP is clearer, we just need a better description)
>>
>> Would that make it clearer?
>=20
> I am not certain, but Andrew Morton deliberately added that
> firmware_map_add_hotplug call.  Which means that there is a reason
> for putting hotplugged memory in the firmware map.
>=20
> So the justification needs to take that reason into account.  The
> justification can not be it is hotplugged therefore it should not belon=
g
> in the firmware memory map.  Unless you can show that
> firmware_map_add_hotplug that was actually a bug and should be removed.
> But as it has been that way since 2010 that seems like a long shot.
>=20
> So my question is what is right for the firmware map?

We have documentation for that since 2008. Andrews patch is from 2010.

Documentation/ABI/testing/sysfs-firmware-memmap

It clearly talks about "raw firmware-provided memory map" and why the
interface was introduced at all ("on most architectures that
firmware-provided memory map is modified afterwards by the kernel itself"=
).

>=20
> Why does the firmware map support hotplug entries?

I assume:

The firmware memmap was added primarily for x86-64 kexec (and still, is
mostly used on x86-64 only IIRC). There, we had ACPI hotplug. When DIMMs
get hotplugged on real HW, they get added to e820. Same applies to
memory added via HyperV balloon (unless memory is unplugged via
ballooning and you reboot ... the the e820 is changed as well). I assume
we wanted to be able to reflect that, to make kexec look like a real rebo=
ot.

This worked for a while. Then came dax/kmem. Now comes virtio-mem.


But I assume only Andrew can enlighten us.

@Andrew, any guidance here? Should we really add all memory to the
firmware memmap, even if this contradicts with the existing
documentation? (especially, if the actual firmware memmap will *not*
contain that memory after a reboot)

--=20
Thanks,

David / dhildenb
