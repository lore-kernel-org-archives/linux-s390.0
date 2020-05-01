Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:50268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726346AbgEATSP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 1 May 2020 15:18:15 -0400
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
 <9f3a813e-dc1d-b675-6e69-85beed3057a4@redhat.com>
 <CAPcyv4jjrxQ27rsfmz6wYPgmedevU=KG+wZ0GOm=qiE6tqa+VA@mail.gmail.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <04242d48-5fa9-6da4-3e4a-991e401eb580@redhat.com>
Date: Fri, 1 May 2020 21:17:58 +0200
MIME-Version: 1.0
In-Reply-To: <CAPcyv4jjrxQ27rsfmz6wYPgmedevU=KG+wZ0GOm=qiE6tqa+VA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Dan Williams <dan.j.williams@intel.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, "Eric W. Biederman" <ebiederm@xmission.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux MM <linux-mm@kvack.org>, virtio-dev@lists.oasis-open.org, virtualization@lists.linux-foundation.org, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Linux ACPI <linux-acpi@vger.kernel.org>, linux-nvdimm <linux-nvdimm@lists.01.org>, linux-hyperv@vger.kernel.org, linux-s390 <linux-s390@vger.kernel.org>, xen-devel <xen-devel@lists.xenproject.org>, Michal Hocko <mhocko@kernel.org>, "Michael S . Tsirkin" <mst@redhat.com>, Michal Hocko <mhocko@suse.com>, Pankaj Gupta <pankaj.gupta.linux@gmail.com>, Wei Yang <richard.weiyang@gmail.com>, Baoquan He <bhe@redhat.com>

On 01.05.20 20:43, Dan Williams wrote:
> On Fri, May 1, 2020 at 11:14 AM David Hildenbrand <david@redhat.com> wr=
ote:
>>
>> On 01.05.20 20:03, Dan Williams wrote:
>>> On Fri, May 1, 2020 at 10:51 AM David Hildenbrand <david@redhat.com> =
wrote:
>>>>
>>>> On 01.05.20 19:45, David Hildenbrand wrote:
>>>>> On 01.05.20 19:39, Dan Williams wrote:
>>>>>> On Fri, May 1, 2020 at 10:21 AM David Hildenbrand <david@redhat.co=
m> wrote:
>>>>>>>
>>>>>>> On 01.05.20 18:56, Dan Williams wrote:
>>>>>>>> On Fri, May 1, 2020 at 2:34 AM David Hildenbrand <david@redhat.c=
om> wrote:
>>>>>>>>>
>>>>>>>>> On 01.05.20 00:24, Andrew Morton wrote:
>>>>>>>>>> On Thu, 30 Apr 2020 20:43:39 +0200 David Hildenbrand <david@re=
dhat.com> wrote:
>>>>>>>>>>
>>>>>>>>>>>>
>>>>>>>>>>>> Why does the firmware map support hotplug entries?
>>>>>>>>>>>
>>>>>>>>>>> I assume:
>>>>>>>>>>>
>>>>>>>>>>> The firmware memmap was added primarily for x86-64 kexec (and=
 still, is
>>>>>>>>>>> mostly used on x86-64 only IIRC). There, we had ACPI hotplug.=
 When DIMMs
>>>>>>>>>>> get hotplugged on real HW, they get added to e820. Same appli=
es to
>>>>>>>>>>> memory added via HyperV balloon (unless memory is unplugged v=
ia
>>>>>>>>>>> ballooning and you reboot ... the the e820 is changed as well=
). I assume
>>>>>>>>>>> we wanted to be able to reflect that, to make kexec look like=
 a real reboot.
>>>>>>>>>>>
>>>>>>>>>>> This worked for a while. Then came dax/kmem. Now comes virtio=
-mem.
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> But I assume only Andrew can enlighten us.
>>>>>>>>>>>
>>>>>>>>>>> @Andrew, any guidance here? Should we really add all memory t=
o the
>>>>>>>>>>> firmware memmap, even if this contradicts with the existing
>>>>>>>>>>> documentation? (especially, if the actual firmware memmap wil=
l *not*
>>>>>>>>>>> contain that memory after a reboot)
>>>>>>>>>>
>>>>>>>>>> For some reason that patch is misattributed - it was authored =
by
>>>>>>>>>> Shaohui Zheng <shaohui.zheng@intel.com>, who hasn't been heard=
 from in
>>>>>>>>>> a decade.  I looked through the email discussion from that tim=
e and I'm
>>>>>>>>>> not seeing anything useful.  But I wasn't able to locate Dave =
Hansen's
>>>>>>>>>> review comments.
>>>>>>>>>
>>>>>>>>> Okay, thanks for checking. I think the documentation from 2008 =
is pretty
>>>>>>>>> clear what has to be done here. I will add some of these detail=
s to the
>>>>>>>>> patch description.
>>>>>>>>>
>>>>>>>>> Also, now that I know that esp. kexec-tools already don't consi=
der
>>>>>>>>> dax/kmem memory properly (memory will not get dumped via kdump)=
 and
>>>>>>>>> won't really suffer from a name change in /proc/iomem, I will g=
o back to
>>>>>>>>> the MHP_DRIVER_MANAGED approach and
>>>>>>>>> 1. Don't create firmware memmap entries
>>>>>>>>> 2. Name the resource "System RAM (driver managed)"
>>>>>>>>> 3. Flag the resource via something like IORESOURCE_MEM_DRIVER_M=
ANAGED.
>>>>>>>>>
>>>>>>>>> This way, kernel users and user space can figure out that this =
memory
>>>>>>>>> has different semantics and handle it accordingly - I think tha=
t was
>>>>>>>>> what Eric was asking for.
>>>>>>>>>
>>>>>>>>> Of course, open for suggestions.
>>>>>>>>
>>>>>>>> I'm still more of a fan of this being communicated by "System RA=
M"
>>>>>>>
>>>>>>> I was mentioning somewhere in this thread that "System RAM" insid=
e a
>>>>>>> hierarchy (like dax/kmem) will already be basically ignored by
>>>>>>> kexec-tools. So, placing it inside a hierarchy already makes it l=
ook
>>>>>>> special already.
>>>>>>>
>>>>>>> But after all, as we have to change kexec-tools either way, we ca=
n
>>>>>>> directly go ahead and flag it properly as special (in case there =
will
>>>>>>> ever be other cases where we could no longer distinguish it).
>>>>>>>
>>>>>>>> being parented especially because that tells you something about=
 how
>>>>>>>> the memory is driver-managed and which mechanism might be in pla=
y.
>>>>>>>
>>>>>>> The could be communicated to some degree via the resource hierarc=
hy.
>>>>>>>
>>>>>>> E.g.,
>>>>>>>
>>>>>>>             [root@localhost ~]# cat /proc/iomem
>>>>>>>             ...
>>>>>>>             140000000-33fffffff : Persistent Memory
>>>>>>>               140000000-1481fffff : namespace0.0
>>>>>>>               150000000-33fffffff : dax0.0
>>>>>>>                 150000000-33fffffff : System RAM (driver managed)
>>>>>>>
>>>>>>> vs.
>>>>>>>
>>>>>>>            :/# cat /proc/iomem
>>>>>>>             [...]
>>>>>>>             140000000-333ffffff : virtio-mem (virtio0)
>>>>>>>               140000000-147ffffff : System RAM (driver managed)
>>>>>>>               148000000-14fffffff : System RAM (driver managed)
>>>>>>>               150000000-157ffffff : System RAM (driver managed)
>>>>>>>
>>>>>>> Good enough for my taste.
>>>>>>>
>>>>>>>> What about adding an optional /sys/firmware/memmap/X/parent attr=
ibute.
>>>>>>>
>>>>>>> I really don't want any firmware memmap entries for something tha=
t is
>>>>>>> not part of the firmware provided memmap. In addition,
>>>>>>> /sys/firmware/memmap/ is still a fairly x86_64 specific thing. On=
ly mips
>>>>>>> and two arm configs enable it at all.
>>>>>>>
>>>>>>> So, IMHO, /sys/firmware/memmap/ is definitely not the way to go.
>>>>>>
>>>>>> I think that's a policy decision and policy decisions do not belon=
g in
>>>>>> the kernel. Give the tooling the opportunity to decide whether Sys=
tem
>>>>>> RAM stays that way over a kexec. The parenthetical reference other=
wise
>>>>>> looks out of place to me in the /proc/iomem output. What makes it
>>>>>> "driver managed" is how the kernel handles it, not how the kernel
>>>>>> names it.
>>>>>
>>>>> At least, virtio-mem is different. It really *has to be handled* by=
 the
>>>>> driver. This is not a policy. It's how it works.
>>>
>>> ...but that's not necessarily how dax/kmem works.
>>>
>>
>> Yes, and user space could still take that memory and add it to the
>> firmware memmap if it really wants to. It knows that it is special. It
>> can figure out that it belongs to a dax device using /proc/iomem.
>>
>>>>>
>>>>
>>>> Oh, and I don't see why "System RAM (driver managed)" would hinder a=
ny
>>>> policy in user case to still do what it thinks is the right thing to=
 do
>>>> (e.g., for dax).
>>>>
>>>> "System RAM (driver managed)" would mean: Memory is not part of the =
raw
>>>> firmware memmap. It was detected and added by a driver. Handle with
>>>> care, this is special.
>>>
>>> Oh, no, I was more reacting to your, "don't update
>>> /sys/firmware/memmap for the (driver managed) range" choice as being =
a
>>> policy decision. It otherwise feels to me "System RAM (driver
>>> managed)" adds confusion for casual users of /proc/iomem and for clue=
d
>>> in tools they have the parent association to decide policy.
>>
>> Not sure if I understand correctly, so bear with me :).
>>
>> Adding or not adding stuff to /sys/firmware/memmap is not a policy
>> decision. If it's not part of the raw firmware-provided memmap, it has
>> nothing to do in /sys/firmware/memmap. That's what the documentation
>> from 2008 tells us.
>=20
> It just occurs to me that there are valid cases for both wanting to
> start over with driver managed memory with a kexec and keeping it in
> the map.

Yes, there might be valid cases. My gut feeling is that in the general
case, you want to let the kexec kernel implement a policy/ let the user
in the new system decide.

But as I said, you can implement in kexec-tools whatever policy you
want. It has access to all information.

> Consider the case of EFI Special Purpose (SP) Memory that is
> marked EFI Conventional Memory with the SP attribute. In that case the
> firmware memory map marked it as conventional RAM, but the kernel
> optionally marks it as System RAM vs Soft Reserved. The 2008 patch
> simply does not consider that case. I'm not sure strict textualism
> works for coding decisions.

I am no expert on that matter (esp EFI). But looking at the users of
firmware_map_add_early(), the single user is in arch/x86/kernel/e820.c
. So the single source of /sys/firmware/memmap is (besides hotplug) e820.

"'e820_table_firmware': the original firmware version passed to us by
the bootloader - not modified by the kernel. ... inform the user about
the firmware's notion of memory layout via /sys/firmware/memmap"
(arch/x86/kernel/e820.c)

How is the EFI Special Purpose (SP) Memory represented in e820?

/sys/firmware/memmap is really simple: just dump in e820. No policies IIU=
C.

--=20
Thanks,

David / dhildenb
