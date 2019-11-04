Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:25939 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727766AbfKDOIV (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 09:08:21 -0500
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
 <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
 <69ddb6a7-8f69-fbc4-63a4-4f5695117078@de.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1fad0466-1eeb-7d24-8015-98af9b564f74@redhat.com>
Date: Mon, 4 Nov 2019 15:08:07 +0100
MIME-Version: 1.0
In-Reply-To: <69ddb6a7-8f69-fbc4-63a4-4f5695117078@de.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

On 04.11.19 14:58, Christian Borntraeger wrote:
>=20
>=20
> On 04.11.19 11:19, David Hildenbrand wrote:
>>>>> to synchronize page import/export with the I/O for paging. For exampl=
e you can actually
>>>>> fault in a page that is currently under paging I/O. What do you do? i=
mport (so that the
>>>>> guest can run) or export (so that the I/O will work). As this turned =
out to be harder then
>>>>> we though we decided to defer paging to a later point in time.
>>>>
>>>> I don't quite see the issue yet. If you page out, the page will
>>>> automatically (on access) be converted to !secure/encrypted memory. If
>>>> the UV/guest wants to access it, it will be automatically converted to
>>>> secure/unencrypted memory. If you have concurrent access, it will be
>>>> converted back and forth until one party is done.
>>>
>>> IO does not trigger an export on an imported page, but an error
>>> condition in the IO subsystem. The page code does not read pages throug=
h
>>
>> Ah, that makes it much clearer. Thanks!
>>
>>> the cpu, but often just asks the device to read directly and that's
>>> where everything goes wrong. We could bounce swapping, but chose to pin
>>> for now until we find a proper solution to that problem which nicely
>>> integrates into linux.
>>
>> How hard would it be to
>>
>> 1. Detect the error condition
>> 2. Try a read on the affected page from the CPU (will will automatically=
 convert to encrypted/!secure)
>> 3. Restart the I/O
>>
>> I assume that this is a corner case where we don't really have to care a=
bout performance in the first shot.
>=20
> We have looked into this. You would need to implement this in the low lev=
el
> handler for every I/O. DASD, FCP, PCI based NVME, iscsi. Where do you wan=
t
> to stop?

If that's the real fix, we should do that. Maybe one can focus on the=20
real use cases first. But I am no I/O expert, so my judgment might be=20
completely wrong.

> There is no proper global bounce buffer that works for everything.
>=20
>>>>
>>>> A proper automatic conversion should make this work. What am I missing=
?
>>>>
>>>>>
>>>>> As we do not want to rely on the userspace to do the mlock this is no=
w done in the kernel.
>>>>
>>>> I wonder if we could come up with an alternative (similar to how we
>>>> override VM_MERGEABLE in the kernel) that can be called and ensured in
>>>> the kernel. E.g., marking whole VMAs as "don't page" (I remember
>>>> something like "special VMAs" like used for VDSOs that achieve exactly
>>>> that, but I am absolutely no expert on that). That would be much nicer
>>>> than pinning all pages and remembering what you pinned in huge page
>>>> arrays ...
>>>
>>> It might be more worthwhile to just accept one or two releases with
>>> pinning and fix the root of the problem than design a nice stopgap.
>>
>> Quite honestly, to me this feels like a prototype hack that deserves a p=
roper solution first. The issue with this hack is that it affects user spac=
e (esp. MADV_DONTNEED no longer working correctly). It's not just something=
 you once fix in the kernel and be done with it.
>=20
> I disagree. Pinning is a valid initial version. I would find it strange t=
o
> allow it for AMD SEV, but not allowing it for s390x.

"not allowing" is wrong. I don't like it, but I am not NACKing it. All I=20
am saying is that this is for me a big fat "prototype" marker.

As a workaround, I would much rather want to see a "don't page" control=20
(process/vma) than pinning every single page if "paging" is the only=20
concern. Such an internal handling would not imply any real user space=20
changes (as noted, like MADV_DONTNEED would see).

> As far as I can tell  MADV_DONTNEED continues to work within the bounds
> of specification. In fact, it does work (or does not depending on your

There is a reason why we disallow MADV_DONTNEED in QEMU when we have=20
such vfio devices (e.g., balloon, postcopy live migration, ...). It does=20
no longer work as specified for devices that pinned pages. You get=20
inconsistent mappings.

> perspective :-) ) exactly in the same way as on hugetlbfs,which is also
> a way of pinning.

MADV_DONTNEED is documented to not work on huge pages. That's a=20
different story. You have to use FALLOC_FL_PUNCH_HOLE.


--=20

Thanks,

David / dhildenb
