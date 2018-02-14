From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
Date: Wed, 14 Feb 2018 15:55:54 +0100
Message-ID: <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
 <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="mKkqvsEBd8LYiOJ7FacL6KwSIubmlCA8M"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--mKkqvsEBd8LYiOJ7FacL6KwSIubmlCA8M
Content-Type: multipart/mixed; boundary="Kg2kgGfVH14vxN9f86t67H0r9b87sEocd";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <da99ceda-9ce3-e8b9-f190-83dbdfed6c68@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v3 04/16] s390/mm: add gmap PMD invalidation
 notification
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1518168864-147803-5-git-send-email-frankja@linux.vnet.ibm.com>
 <38c32f80-9225-8e71-7a8a-aa759cdbbfc7@redhat.com>
 <e9024cdf-7f44-cae3-c839-96eb2e9a6f37@linux.vnet.ibm.com>
 <dd0b270b-cefe-00ad-0020-b7eb125b683f@redhat.com>
 <5fb02c01-bbda-bdd7-eb54-8e8ee525093c@linux.vnet.ibm.com>
 <dbaf7c40-928c-c535-db70-67e7d284a22b@redhat.com>
 <6e6d3053-1526-230c-0fb3-6d57168f47c7@linux.vnet.ibm.com>
 <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>
In-Reply-To: <7009cdd4-bbf1-2802-b9a8-03c238ec8ae2@redhat.com>

--Kg2kgGfVH14vxN9f86t67H0r9b87sEocd
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 14.02.2018 15:18, David Hildenbrand wrote:
> On 14.02.2018 12:19, Janosch Frank wrote:
>> On 14.02.2018 11:42, David Hildenbrand wrote:
>>>
>>>>>>> That's interesting, because the SIE can now suddenly work on thes=
e
>>>>>>> PGSTEs, e.g. not leading to intercepts on certain events (like se=
tting
>>>>>>> storage keys).
>>>>>>>
>>>>>>> How is that intended to be handled? I assume we would somehow hav=
e to
>>>>>>> forbid the SIE from making use of the PGSTE. But that involves cl=
earing
>>>>>>> certain interception controls, which might be problematic.
>>>>>>
>>>>>> Well, cmma is disabled and storage keys should only be a problem, =
when
>>>>>> the pte is invalid without the pgste lock, which should never be t=
he
>>>>>> case for split pmds.
>>>>>>
>>>>>
>>>>> Are you sure? Because the SIE would suddenly stark working on guest=

>>>>> storage keys stored in the PGSTE if I am not mistaking? So I would
>>>>> assume that there would have to be some kind of a sync.
>>>>>
>>>>> But I don't have any documentation at hand, so i can't tell :)
>>>>>
>>>>
>>>> The pgste lock is that sync and as the gmap is the only way to get t=
o
>>>> the pte, we don't have any ptes invalid without the lock. Also
>>>> set_guest_storage_keys will find a (userspace) pmd and do a hardware=

>>>> sske, like it is supposed to.
>>>
>>> What happens according to the documentation in the following cases:
>>>
>>> The HW has the storage-key facility enabled and a SKEY operation (ISK=
E,
>>> RRBE, SSKE) hits a huge page:
>>>
>>> a) Generates an intercept
>>> b) Uses the real machine storage key (as there are no pgste)
>>>
>>
>> b, this is an implicit RCP bypass (same goes for fc=3D1 r3 entries). T=
his
>> might be even independent of the SKF if I'm not mistaken.
>>
>=20
> SKF implements interpretation of these 3 instructions, without it, they=

> lead to an intercept (e.g. what we force when inside vSIE).

I know, the parts read like it didn't matter if SKF are available or
not, but it seems like I misread a sentence.

>=20
> Alright, so that means that we have two cases:
>=20
> 1. A SKEY operation hits a huge PMD. Everything is fine, the real
> storage key is used. This is also what get_guest_storage_key() /
> set_guest_storage_key() implement now.

Yep

>=20
> 2. A SKEY operation hits a split PMD. It will work on the PGSTE values.=

>=20
> As I don't have access to documentation, looking at set_guest_storage_k=
ey():
>=20
> a) The real storage key is read.
> b) The _PAGE_ACC_BITS and _PAGE_FP_BIT are written into the real storag=
e key
> c) The _PAGE_CHANGED and  _PAGE_REFERENCED are cleared from the real
> storage key. They are managed in the PGSTE.
>=20
> This means, that the requested _PAGE_CHANGED and _PAGE_REFERENCED bits
> part of the storage key are not updated in the real storage key.
>=20
>=20
> So what can happen is (please correct me if I'm wrong)
>=20
> a) PMD is split. SSKE writes storage key with _PAGE_CHANGED, ends up in=

> PGSTE. The real storage key doesn't match the requested storage key.
> b) Split PMD is replaced, triggers a removal of the split PMD ->
> gmap_pmd_split_free(pmdp). The requested storage key is partially lost
> (pgste removed).
> c) PMD is mapped in again. If the guest reads the storage key now, the
> value is wrong.

Yes, we loose GR and GC.
Is there a case when the VM is running, where this would happen?


--Kg2kgGfVH14vxN9f86t67H0r9b87sEocd--

--mKkqvsEBd8LYiOJ7FacL6KwSIubmlCA8M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJahE36AAoJEBcO/8Q8ZEV5Y68P/RAluvajUmrOO4LVUd7s76/g
boabVvkHBeoIEe6itwVvYLd3wgjVnQgKahLYBHXF8G0IIMjxFSTE/62+efsFTk2U
rWkrmdKRilX++kmwWEfnY51uNWD2dulVs1eHz5RM7sVzqrsvZrgH6hsw+4xLlOxa
K+UPPlgvHE5RwtyeQgxMpjUyYXvUEjpYwu5JVgAn/vaSXp0tg3BR/2J7fJTrOgQL
J5TeA1C5jTL01k9cKLAa8I1zJ07UIxTuqeXlUx8tw0TdXXnqymkmjvk1TlSYCKF8
ZlrfxplZLI852ROzCxupb3qj0TZHulI6HuJyKhadz9oJidtx3PxYoovRuLJ1h7zd
2NXIrTEyq8iCG3ViHPPNKvakSYyv6z/XLRq9x8a9ZPBGmrEZRLsaYvK6UWlMfvFn
6bF0IO9ASkdCbSWzFvunoX5XP3MEPNIewJQw+DsasCWl6M5rvVRVxMuk5OvAgAeK
DfsnTifduA9yeaZFTPfqYzZuFnUPnHJ97+0CQ/OZWayI6x46h1OVErzbCqFc2Lxi
XP1Co/DlMx545nrVxP8H1PDqceR8LduB97Q/M1TjbOAuNwNe3wF+aqzGuz0RtkC5
KfbVWFaMxf+8xuzFAhQTIIj2bDmNbcqCSPUl/TL/akmcDOyqFWoZkWrHUJM+ekyA
S3qjsAjbAyC56NPHTsOC
=VE6B
-----END PGP SIGNATURE-----

--mKkqvsEBd8LYiOJ7FacL6KwSIubmlCA8M--
