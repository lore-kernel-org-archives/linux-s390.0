Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:20093 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728287AbfKDRoq (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 12:44:46 -0500
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
 <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
 <69ddb6a7-8f69-fbc4-63a4-4f5695117078@de.ibm.com>
 <1fad0466-1eeb-7d24-8015-98af9b564f74@redhat.com>
 <8a68fcbb-1dea-414f-7d48-e4647f7985fe@redhat.com>
 <20191104181743.3792924a.cohuck@redhat.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <b7003d0d-cde8-b1c8-9e26-f1ff390099f6@redhat.com>
Date: Mon, 4 Nov 2019 18:44:22 +0100
MIME-Version: 1.0
In-Reply-To: <20191104181743.3792924a.cohuck@redhat.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, gor@linux.ibm.com

On 04.11.19 18:17, Cornelia Huck wrote:
> On Mon, 4 Nov 2019 15:42:11 +0100
> David Hildenbrand <david@redhat.com> wrote:
>=20
>> On 04.11.19 15:08, David Hildenbrand wrote:
>>> On 04.11.19 14:58, Christian Borntraeger wrote:
>>>>
>>>>
>>>> On 04.11.19 11:19, David Hildenbrand wrote:
>>>>>>>> to synchronize page import/export with the I/O for paging. For exa=
mple you can actually
>>>>>>>> fault in a page that is currently under paging I/O. What do you do=
? import (so that the
>>>>>>>> guest can run) or export (so that the I/O will work). As this turn=
ed out to be harder then
>>>>>>>> we though we decided to defer paging to a later point in time.
>>>>>>>
>>>>>>> I don't quite see the issue yet. If you page out, the page will
>>>>>>> automatically (on access) be converted to !secure/encrypted memory.=
 If
>>>>>>> the UV/guest wants to access it, it will be automatically converted=
 to
>>>>>>> secure/unencrypted memory. If you have concurrent access, it will b=
e
>>>>>>> converted back and forth until one party is done.
>>>>>>
>>>>>> IO does not trigger an export on an imported page, but an error
>>>>>> condition in the IO subsystem. The page code does not read pages thr=
ough
>>>>>
>>>>> Ah, that makes it much clearer. Thanks!
>>>>>  =20
>>>>>> the cpu, but often just asks the device to read directly and that's
>>>>>> where everything goes wrong. We could bounce swapping, but chose to =
pin
>>>>>> for now until we find a proper solution to that problem which nicely
>>>>>> integrates into linux.
>>>>>
>>>>> How hard would it be to
>>>>>
>>>>> 1. Detect the error condition
>>>>> 2. Try a read on the affected page from the CPU (will will automatica=
lly convert to encrypted/!secure)
>>>>> 3. Restart the I/O
>>>>>
>>>>> I assume that this is a corner case where we don't really have to car=
e about performance in the first shot.
>>>>
>>>> We have looked into this. You would need to implement this in the low =
level
>>>> handler for every I/O. DASD, FCP, PCI based NVME, iscsi. Where do you =
want
>>>> to stop?
>>>
>>> If that's the real fix, we should do that. Maybe one can focus on the
>>> real use cases first. But I am no I/O expert, so my judgment might be
>>> completely wrong.
>>>   =20
>>
>> Oh, and by the way, as discussed you really only have to care about
>> accesses via "real" I/O devices (IOW, not via the CPU). When accessing
>> via the CPU, you should have automatic conversion back and forth. As I
>> am no expert on I/O, I have no idea how iscsi fits into this picture
>> here (especially on s390x).
>>
>=20
> By "real" I/O devices, you mean things like channel devices, right? (So
> everything where you basically hand off control to a different kind of
> processor.)

Exactly.

>=20
> For classic channel I/O (as used by dasd), I'd expect something like
> getting a check condition on a ccw if the CU or device cannot access
> the memory. You will know how far the channel program has progressed,
> and might be able to restart (from the beginning or from that point).
> Probably has a chance of working for a subset of channel programs.

Yeah, sound sane to me.

>=20
> For QDIO (as used by FCP), I have no idea how this is could work, as we
> have long-running channel programs there and any error basically kills
> the queues, which you would have to re-setup from the beginning.
>=20
> For PCI devices, I have no idea how the instructions even act.
>=20
>  From my point of view, that error/restart approach looks nice on paper,
> but it seems hard to make it work in the general case (and I'm unsure
> if it's possible at all.)

Then I'm afraid whoever designed protected virtualization didn't=20
properly consider concurrent I/O access to encrypted pages. It might not=20
be easy to sort out, though, so I understand why the I/O part was=20
designed that way :)

I was wondering if one could implement some kind of automatic conversion=20
"back and forth" on I/O access (or even on any access within the HW). I=20
mean, "basically" it's just encrypting/decrypting the page and updating=20
the state by the UV (+ synchronization, lol). But yeah, the UV is=20
involved, and would be triggered somehow via I/O access to these pages.
Right now that conversion is performed via exceptions by the OS=20
explicitly. Instead of passing exceptions, the UV could convert=20
automatically. Smells like massive HW changes, if possible and desired=20
at all.

I do wonder what would happen if you back your guest memory not on=20
anonymous memory but on e.g., a file. Could be that this eliminates all=20
options besides pinning and fixing I/O, because we're talking about=20
writeback and not paging.

HOWEVER, reading https://lwn.net/Articles/787636/

"Kara talked mostly about the writeback code; in some cases, it will=20
simply skip pages that are pinned. But there are cases where those pages=20
must be written out =E2=80=94 "somebody has called fsync(), and they expect=
=20
something to be saved". In this case, pinned pages will be written, but=20
they will not be marked clean at the end of the operation; they will=20
still be write-protected in the page tables while writeback is underway,=20
though."

So, sounds like you will get concurrent I/O access even without paging=20
... and that would leave fixing I/O the only option with the current HW=20
design AFAIKS :/

--=20

Thanks,

David / dhildenb
