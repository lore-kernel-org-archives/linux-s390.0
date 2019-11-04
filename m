Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59514 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728476AbfKDKZM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Nov 2019 05:25:12 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA4A6xZY036553
        for <linux-s390@vger.kernel.org>; Mon, 4 Nov 2019 05:25:11 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w2hxp0px7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Mon, 04 Nov 2019 05:25:11 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Mon, 4 Nov 2019 10:25:09 -0000
Subject: Re: [RFC 09/37] KVM: s390: protvirt: Implement on-demand pinning
References: <20191024114059.102802-1-frankja@linux.ibm.com>
 <20191024114059.102802-10-frankja@linux.ibm.com>
 <b76ae1ca-d211-d1c7-63d9-9b45c789f261@redhat.com>
 <7465141c-27b7-a89e-f02d-ab05cdd8505d@de.ibm.com>
 <4abdc1dc-884e-a819-2e9d-2b8b15030394@redhat.com>
 <2a7c4644-d718-420a-9bd7-723baccfb302@linux.ibm.com>
 <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Mon, 4 Nov 2019 11:25:04 +0100
MIME-Version: 1.0
In-Reply-To: <84bd87f0-37bf-caa8-5762-d8da58f37a8f@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ll9ofum3paBG7u8XY2oUHCxD5vFOm6S4o"
Message-Id: <5a630f24-4d17-7844-e4e7-d3ab1c8507a4@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, imbrenda@linux.ibm.com, mihajlov@linux.ibm.com, mimu@linux.ibm.com, cohuck@redhat.com, gor@linux.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ll9ofum3paBG7u8XY2oUHCxD5vFOm6S4o
Content-Type: multipart/mixed; boundary="6ZJCxyP15pXbd7WZ9PsALd6qUutBNqhsg"

--6ZJCxyP15pXbd7WZ9PsALd6qUutBNqhsg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/4/19 11:19 AM, David Hildenbrand wrote:
>>>> to synchronize page import/export with the I/O for paging. For examp=
le you can actually
>>>> fault in a page that is currently under paging I/O. What do you do? =
import (so that the
>>>> guest can run) or export (so that the I/O will work). As this turned=
 out to be harder then
>>>> we though we decided to defer paging to a later point in time.
>>>
>>> I don't quite see the issue yet. If you page out, the page will
>>> automatically (on access) be converted to !secure/encrypted memory. I=
f
>>> the UV/guest wants to access it, it will be automatically converted t=
o
>>> secure/unencrypted memory. If you have concurrent access, it will be
>>> converted back and forth until one party is done.
>>
>> IO does not trigger an export on an imported page, but an error
>> condition in the IO subsystem. The page code does not read pages throu=
gh
>=20
> Ah, that makes it much clearer. Thanks!
>=20
>> the cpu, but often just asks the device to read directly and that's
>> where everything goes wrong. We could bounce swapping, but chose to pi=
n
>> for now until we find a proper solution to that problem which nicely
>> integrates into linux.
>=20
> How hard would it be to
>=20
> 1. Detect the error condition
> 2. Try a read on the affected page from the CPU (will will automaticall=
y=20
> convert to encrypted/!secure)
> 3. Restart the I/O
>=20
> I assume that this is a corner case where we don't really have to care =

> about performance in the first shot.

Restarting IO can be quite difficult with CCW, we might need to change
request data...

>=20
>>
>>>
>>> A proper automatic conversion should make this work. What am I missin=
g?
>>>
>>>>
>>>> As we do not want to rely on the userspace to do the mlock this is n=
ow done in the kernel.
>>>
>>> I wonder if we could come up with an alternative (similar to how we
>>> override VM_MERGEABLE in the kernel) that can be called and ensured i=
n
>>> the kernel. E.g., marking whole VMAs as "don't page" (I remember
>>> something like "special VMAs" like used for VDSOs that achieve exactl=
y
>>> that, but I am absolutely no expert on that). That would be much nice=
r
>>> than pinning all pages and remembering what you pinned in huge page
>>> arrays ...
>>
>> It might be more worthwhile to just accept one or two releases with
>> pinning and fix the root of the problem than design a nice stopgap.
>=20
> Quite honestly, to me this feels like a prototype hack that deserves a =

> proper solution first. The issue with this hack is that it affects user=
=20
> space (esp. MADV_DONTNEED no longer working correctly). It's not just=20
> something you once fix in the kernel and be done with it.

It is a hack, yes.
But we're not the only architecture to need it x86 pins all the memory
at the start of the VM and that code is already upstream...

>>
>> Btw. s390 is not alone with the problem and we'll try to have another
>> discussion tomorrow with AMD to find a solution which works for more
>> than one architecture.
>=20
> Let me know if there was an interesting outcome.
>=20



--6ZJCxyP15pXbd7WZ9PsALd6qUutBNqhsg--

--ll9ofum3paBG7u8XY2oUHCxD5vFOm6S4o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl2//IAACgkQ41TmuOI4
ufi+NhAAv6jnjE4NeOye1Yy1exuQ65rT2L7f5MfNwEW50vw7ULmFXbWUO8TjWX/R
Mw87PacIXx0U9ImWHGYI8mLlU7El9K8CsFwBjEc19ajqQ1zP7d0qzYsp/xBxObEy
BXxa4WAfNukH/LyyIm/2bBhNFV4gO7Spq0QeCzb0xckEmux1BAMOnaG3a2TQxLNR
8zhRf06nTmeNbYUl0epPOWyixWBVwGwvKlHjFQx80PzJooovDl0eNYqH7RGz/SHg
JYC1PQcNnaVxweHc1m41ahhwpev2WycGX70v/luasuXyltDnXkfx0SMgq8uuARHN
nq6HidlO4qEergHhzNvum4ft9dKcT9R45ldIxDfi0bHvlxdNcBkRWl8Oshj2m4jI
WJh7E3XmrZcG2hBR6RZpkDP81Ml8RBIdP+lx7vTRM4B0lOdtrZVEwPcFsScyHLuQ
wy2Djawqqf8icePBinCzNNvpYkS6Tvr+O/jcqPUNQuI6bRFR+Jof0XZD1PuSN6FP
SQpXHyqEN+4ibDUAhordLpzYbqNYPxdfT4C0YRsjICMK4LR4HKZ+iWwP6NoneSS9
dkNQkV0DodxHpHpUwDIINogVsjUa2XfSeeNptqefTLgyKywel76HoilYaa+yMDne
aUdk3pwW4NF8W22IlTNfoCavNnTfJ7kzQ0b46T3Ml9lHwkJWC6o=
=HOrR
-----END PGP SIGNATURE-----

--ll9ofum3paBG7u8XY2oUHCxD5vFOm6S4o--
