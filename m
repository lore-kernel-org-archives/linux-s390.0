Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:27411 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728856AbgEASOY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 14:14:24 -0400
Subject: Re: [PATCH v2 2/3] mm/memory_hotplug: Introduce
 MHP_NO_FIRMWARE_MEMMAP
References: <20200430102908.10107-1-david@redhat.com>
 <20200430102908.10107-3-david@redhat.com>
 <87pnbp2dcz.fsf@x220.int.ebiederm.org>
 <1b49c3be-6e2f-57cb-96f7-f66a8f8a9380@redhat.com>
 <871ro52ary.fsf@x220.int.ebiederm.org>
 <373a6898-4020-4af1-5b3d-f827d705dd77@redhat.com>
 <875zdg26hp.fsf@x220.int.ebiederm.org>
 <b28c9e02-8cf2-33ae-646b-fe50a185738e@redhat.com>
 <20200430152403.e0d6da5eb1cad06411ac6d46@linux-foundation.org>
 <5c908ec3-9495-531e-9291-cbab24f292d6@redhat.com>
 <CAPcyv4j=YKnr1HW4OhAmpzbuKjtfP7FdAn4-V7uA=b-Tcpfu+A@mail.gmail.com>
 <2d019c11-a478-9d70-abd5-4fd2ebf4bc1d@redhat.com>
 <CAPcyv4iOqS0Wbfa2KPfE1axQFGXoRB4mmPRP__Lmqpw6Qpr_ig@mail.gmail.com>
 <62dd4ce2-86cc-5b85-734f-ec8766528a1b@redhat.com>
 <0169e822-a6cc-1543-88ed-2a85d95ffb93@redhat.com>
 <CAPcyv4jGnR_fPtpKBC1rD2KRcT88bTkhqnTMmuwuc+f9Dwrz1g@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <9f3a813e-dc1d-b675-6e69-85beed3057a4@redhat.com>
Date: Fri, 1 May 2020 20:14:10 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jGnR_fPtpKBC1rD2KRcT88bTkhqnTMmuwuc+f9Dwrz1g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

On 01.05.20 20:03, Dan Williams wrote:
> On Fri, May 1, 2020 at 10:51 AM David Hildenbrand <david@redhat.com> wr=
ote:
>>
>> On 01.05.20 19:45, David Hildenbrand wrote:
>>> On 01.05.20 19:39, Dan Williams wrote:
>>>> On Fri, May 1, 2020 at 10:21 AM David Hildenbrand <david@redhat.com>=
 wrote:
>>>>>
>>>>> On 01.05.20 18:56, Dan Williams wrote:
>>>>>> On Fri, May 1, 2020 at 2:34 AM David Hildenbrand <david@redhat.com=
> wrote:
>>>>>>>
>>>>>>> On 01.05.20 00:24, Andrew Morton wrote:
>>>>>>>> On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@redh=
at.com> wrote:
>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> Why does the firmware map support hotplug entries?
>>>>>>>>>
>>>>>>>>> I assume:
>>>>>>>>>
>>>>>>>>> The firmware memmap was added primarily for x86-64 kexec (and s=
till, is
>>>>>>>>> mostly used on x86-64 only IIRC). There, we had ACPI hotplug. W=
hen DIMMs
>>>>>>>>> get hotplugged on real HW, they get added to e820. Same applies=
 to
>>>>>>>>> memory added via HyperV balloon (unless memory is unplugged via
>>>>>>>>> ballooning and you reboot ... the the e820 is changed as well).=
 I assume
>>>>>>>>> we wanted to be able to reflect that, to make kexec look like a=
 real reboot.
>>>>>>>>>
>>>>>>>>> This worked for a while. Then came dax/kmem. Now comes virtio-m=
em.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> But I assume only Andrew can enlighten us.
>>>>>>>>>
>>>>>>>>> @Andrew, any guidance here? Should we really add all memory to =
the
>>>>>>>>> firmware memmap, even if this contradicts with the existing
>>>>>>>>> documentation? (especially, if the actual firmware memmap will =
*not*
>>>>>>>>> contain that memory after a reboot)
>>>>>>>>
>>>>>>>> For some reason that patch is misattributed - it was authored by
>>>>>>>> Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard f=
rom in
>>>>>>>> a decade.  I looked through the email discussion from that time =
and I'm
>>>>>>>> not seeing anything useful.  But I wasn't able to locate Dave Ha=
nsen's
>>>>>>>> review comments.
>>>>>>>
>>>>>>> Okay, thanks for checking. I think the documentation from 2008 is=
 pretty
>>>>>>> clear what has to be done here. I will add some of these details =
to the
>>>>>>> patch description.
>>>>>>>
>>>>>>> Also, now that I know that esp. kexec-tools already don't conside=
r
>>>>>>> dax/kmem memory properly (memory will not get dumped via kdump) a=
nd
>>>>>>> won't really suffer from a name change in /proc/iomem, I will go =
back to
>>>>>>> the MHP_DRIVER_MANAGED approach and
>>>>>>> 1. Don't create firmware memmap entries
>>>>>>> 2. Name the resource "System RAM (driver managed)"
>>>>>>> 3. Flag the resource via something like IORESOURCE_MEM_DRIVER_MAN=
AGED.
>>>>>>>
>>>>>>> This way, kernel users and user space can figure out that this me=
mory
>>>>>>> has different semantics and handle it accordingly - I think that =
was
>>>>>>> what Eric was asking for.
>>>>>>>
>>>>>>> Of course, open for suggestions.
>>>>>>
>>>>>> I'm still more of a fan of this being communicated by "System RAM"
>>>>>
>>>>> I was mentioning somewhere in this thread that "System RAM" inside =
a
>>>>> hierarchy (like dax/kmem) will already be basically ignored by
>>>>> kexec-tools. So, placing it inside a hierarchy already makes it loo=
k
>>>>> special already.
>>>>>
>>>>> But after all, as we have to change kexec-tools either way, we can
>>>>> directly go ahead and flag it properly as special (in case there wi=
ll
>>>>> ever be other cases where we could no longer distinguish it).
>>>>>
>>>>>> being parented especially because that tells you something about h=
ow
>>>>>> the memory is driver-managed and which mechanism might be in play.
>>>>>
>>>>> The could be communicated to some degree via the resource hierarchy=
.
>>>>>
>>>>> E.g.,
>>>>>
>>>>>             [root@localhost ~]# cat /proc/iomem
>>>>>             ...
>>>>>             140000000-33fffffff : Persistent Memory
>>>>>               140000000-1481fffff : namespace0.0
>>>>>               150000000-33fffffff : dax0.0
>>>>>                 150000000-33fffffff : System RAM (driver managed)
>>>>>
>>>>> vs.
>>>>>
>>>>>            :/# cat /proc/iomem
>>>>>             [...]
>>>>>             140000000-333ffffff : virtio-mem (virtio0)
>>>>>               140000000-147ffffff : System RAM (driver managed)
>>>>>               148000000-14fffffff : System RAM (driver managed)
>>>>>               150000000-157ffffff : System RAM (driver managed)
>>>>>
>>>>> Good enough for my taste.
>>>>>
>>>>>> What about adding an optional /sys/firmware/memmap/X/parent attrib=
ute.
>>>>>
>>>>> I really don't want any firmware memmap entries for something that =
is
>>>>> not part of the firmware provided memmap. In addition,
>>>>> /sys/firmware/memmap/ is still a fairly x86_64 specific thing. Only=
 mips
>>>>> and two arm configs enable it at all.
>>>>>
>>>>> So, IMHO, /sys/firmware/memmap/ is definitely not the way to go.
>>>>
>>>> I think that's a policy decision and policy decisions do not belong =
in
>>>> the kernel. Give the tooling the opportunity to decide whether Syste=
m
>>>> RAM stays that way over a kexec. The parenthetical reference otherwi=
se
>>>> looks out of place to me in the /proc/iomem output. What makes it
>>>> "driver managed" is how the kernel handles it, not how the kernel
>>>> names it.
>>>
>>> At least, virtio-mem is different. It really *has to be handled* by t=
he
>>> driver. This is not a policy. It's how it works.
>=20
> ...but that's not necessarily how dax/kmem works.
>=20

Yes, and user space could still take that memory and add it to the
firmware memmap if it really wants to. It knows that it is special. It
can figure out that it belongs to a dax device using /proc/iomem.

>>>
>>
>> Oh, and I don't see why "System RAM (driver managed)" would hinder any
>> policy in user case to still do what it thinks is the right thing to d=
o
>> (e.g., for dax).
>>
>> "System RAM (driver managed)" would mean: Memory is not part of the ra=
w
>> firmware memmap. It was detected and added by a driver. Handle with
>> care, this is special.
>=20
> Oh, no, I was more reacting to your, "don't update
> /sys/firmware/memmap for the (driver managed) range" choice as being a
> policy decision. It otherwise feels to me "System RAM (driver
> managed)" adds confusion for casual users of /proc/iomem and for clued
> in tools they have the parent association to decide policy.

Not sure if I understand correctly, so bear with me :).

Adding or not adding stuff to /sys/firmware/memmap is not a policy
decision. If it's not part of the raw firmware-provided memmap, it has
nothing to do in /sys/firmware/memmap. That's what the documentation
from 2008 tells us.

Again, my point is that we don't create /sys/firmware/memmap entries for
dax/kmem and virtio-mem memory - because it's not part of the raw
firmware-provided memmap. I was not suggesting to add something like
"System RAM (driver managed)" there instead, maybe that part was confusin=
g.

--=20
Thanks,

David / dhildenb
