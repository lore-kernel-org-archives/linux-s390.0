Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:39129 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727322AbfKDKTM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:19:12 -0500
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
Date: Mon, 4 Nov 2019 11:19:00 +0100
MIME-Version: 1.0
In-Reply-To: <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

>>> to synchronize page import/export with the I/O for paging. For example =
you can actually
>>> fault in a page that is currently under paging I/O. What do you do? imp=
ort (so that the
>>> guest can run) or export (so that the I/O will work). As this turned ou=
t to be harder then
>>> we though we decided to defer paging to a later point in time.
>>
>> I don't quite see the issue yet. If you page out, the page will
>> automatically (on access) be converted to !secure/encrypted memory. If
>> the UV/guest wants to access it, it will be automatically converted to
>> secure/unencrypted memory. If you have concurrent access, it will be
>> converted back and forth until one party is done.
>=20
> IO does not trigger an export on an imported page, but an error
> condition in the IO subsystem. The page code does not read pages through

Ah, that makes it much clearer. Thanks!

> the cpu, but often just asks the device to read directly and that's
> where everything goes wrong. We could bounce swapping, but chose to pin
> for now until we find a proper solution to that problem which nicely
> integrates into linux.

How hard would it be to

1. Detect the error condition
2. Try a read on the affected page from the CPU (will will automatically=20
convert to encrypted/!secure)
3. Restart the I/O

I assume that this is a corner case where we don't really have to care=20
about performance in the first shot.

>=20
>>
>> A proper automatic conversion should make this work. What am I missing?
>>
>>>
>>> As we do not want to rely on the userspace to do the mlock this is now =
done in the kernel.
>>
>> I wonder if we could come up with an alternative (similar to how we
>> override VM_MERGEABLE in the kernel) that can be called and ensured in
>> the kernel. E.g., marking whole VMAs as "don't page" (I remember
>> something like "special VMAs" like used for VDSOs that achieve exactly
>> that, but I am absolutely no expert on that). That would be much nicer
>> than pinning all pages and remembering what you pinned in huge page
>> arrays ...
>=20
> It might be more worthwhile to just accept one or two releases with
> pinning and fix the root of the problem than design a nice stopgap.

Quite honestly, to me this feels like a prototype hack that deserves a=20
proper solution first. The issue with this hack is that it affects user=20
space (esp. MADV_DONTNEED no longer working correctly). It's not just=20
something you once fix in the kernel and be done with it.
>=20
> Btw. s390 is not alone with the problem and we'll try to have another
> discussion tomorrow with AMD to find a solution which works for more
> than one architecture.

Let me know if there was an interesting outcome.

--=20

Thanks,

David / dhildenb
