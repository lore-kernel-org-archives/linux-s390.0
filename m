From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular
 protection is needed
Date: Thu, 25 Jan 2018 15:55:24 +0100
Message-ID: <46412d0c-622c-44a3-dff3-48fd6b3ce3ac@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
 <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
 <c3eb3a5f-fbd7-6581-c88e-cace39bdfbcb@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="ScKlbvMFFoYZiKz0TCBaKePcz3cEwS7wV"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <c3eb3a5f-fbd7-6581-c88e-cace39bdfbcb@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--ScKlbvMFFoYZiKz0TCBaKePcz3cEwS7wV
Content-Type: multipart/mixed; boundary="1Gpsv9kj2T6rea8dIOdkZ9c6KLer8baiv";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <46412d0c-622c-44a3-dff3-48fd6b3ce3ac@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular
 protection is needed
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
 <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
 <c3eb3a5f-fbd7-6581-c88e-cace39bdfbcb@redhat.com>
In-Reply-To: <c3eb3a5f-fbd7-6581-c88e-cace39bdfbcb@redhat.com>

--1Gpsv9kj2T6rea8dIOdkZ9c6KLer8baiv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 25.01.2018 15:39, David Hildenbrand wrote:
> On 25.01.2018 08:16, Janosch Frank wrote:
>> On 13.12.2017 13:53, Janosch Frank wrote:
>>> A guest can put DAT tables for a lower level guest in the same huge
>>> segment as one of its prefixes or a g3 page. This would make it
>>> necessary for the segment to be unprotected (because of the prefix)
>>> and protected (because of the shadowing) at the same time. This is no=
t
>>> possible in this universe.
>>>
>>> Hence we split the affected huge segment, so we can protect on a
>>> per-page basis. Such gmap segments are special and get a new software=

>>> bit, that helps us handling this edge case.
>>>
>>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>>> ---
>>>  arch/s390/include/asm/gmap.h    |  13 ++
>>>  arch/s390/include/asm/pgtable.h |   7 +-
>>>  arch/s390/mm/fault.c            |  10 +-
>>>  arch/s390/mm/gmap.c             | 256 ++++++++++++++++++++++++++++++=
++++++----
>>>  arch/s390/mm/pgtable.c          |  51 ++++++++
>>>  5 files changed, 313 insertions(+), 24 deletions(-)
>>
>>> @@ -1081,20 +1189,27 @@ static int gmap_protect_range(struct gmap *gm=
ap, unsigned long gaddr,
>>>  	spinlock_t *ptl;
>>>  	unsigned long vmaddr, dist;
>>>  	pmd_t *pmdp, *hpmdp;
>>> -	int rc;
>>> +	int rc =3D 0;
>>>
>>>  	while (len) {
>>>  		rc =3D -EAGAIN;
>>>  		vmaddr =3D __gmap_translate(gmap, gaddr);
>>>  		hpmdp =3D (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
>>> +		if (!hpmdp)
>>> +			BUG();
>>>  		/* Do we need tests here? */
>>>  		ptl =3D pmd_lock(gmap->mm, hpmdp);
>>>
>>>  		pmdp =3D gmap_pmd_op_walk(gmap, gaddr);
>>>  		if (pmdp) {
>>>  			if (!pmd_large(*pmdp)) {
>>> -				rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>>> -						      bits);
>>> +				if (gmap_pmd_is_split(pmdp) &&
>>> +				    (bits & GMAP_NOTIFY_MPROT)) {
>>> +					pmd_val(*pmdp) |=3D _SEGMENT_ENTRY_GMAP_IN;
>>> +				}
>>
>> @David:
>> This currently breaks my brain. There *was* a reason why I put this
>> there and I was quite insistent that we needed it. Something about
>> notification areas on splits, but I absolutely can't remember it. Sigh=
,
>> should've made a comment.
>>
>> This might be a leftover from earlier versions, but could also keep us=

>> from doing mprot notification on pte's.
>>
>=20
> This is indeed confusing.
>=20
> Somebody wants to protect are certain memory (e.g. PREFIX) and get
> notified on changes to this subpart.
>=20
> We have a split pmd
>  -> we have huge pages in our user process tables
>  -> we have 4k pages in our GMAP tables
>=20
> Now, we protect a subpart of this huge page via PTEs. My assumption is,=

> that your "mirroring code" might reduce access rights to the PMD in the=

> user process tables.
Yes, it does at the end of gmap_protect_pte

>=20
> So e.g. via user space tables -> 1MB write protected
> Via GMAP: only 8K write protected

Yes and if userspace touches the pmd, we end up in pmdp_notify which
will call notify split and do pte notification.

>=20
>=20
> In addition, you are setting the _SEGMENT_ENTRY_GMAP_IN on the GMAP PMD=
=2E
> This means, that the pmdp_notify_gmap() calls all notifiers
> (gmap_call_notifier) in case the whole PMD is changed (e.g. by write
> protecting for migration)
>=20
> So if we get a gmap_pmdp_xchg(), we would see _SEGMENT_ENTRY_GMAP_IN an=
d
> trigger a notification. The PTEs remain unchecked (bad!).

Split pmds have own handling functions for setting and clearing RO which
work on pte bases.

ptep_remove_dirty_protection_split
test_and_clear_guest_dirty_split
ptep_notify_gmap

>=20
>=20
> Now, If I understand this correctly, what you would have to do:
>=20
> gmap_pmdp_xchg() (or rather pmdp_notify_gmap()) has to check whether it=

> is a real huge page or a split pmd. If split, it has to call the PTE
> invalidators of the page table accordingly.

If I didn't just confuse myself completely, we don't need that. We never
call xchg on a split pmd, except for setting up the split and
pmdp_notify_gmap is never called on a split pmd either as it's not a pmd
anymore (from the gmap sight, for mm we do ptep_notify_gmap_split).

>=20
> This makes this manual hack unnecessary.
>=20
> Hope this helps :)

A tiny bit.
Anyway, the change seems to be stable, I'll send the change as a reply
when I come from the next meeting. Also had no postcopy problems.

When we agree on the change I'll do a new version.




--1Gpsv9kj2T6rea8dIOdkZ9c6KLer8baiv--

--ScKlbvMFFoYZiKz0TCBaKePcz3cEwS7wV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaae/jAAoJEBcO/8Q8ZEV5JiIP/2gmgzv0IrsYrHMix/zL6Y3Q
iZzMW33NloKq0dWmEGOLmf9yb/R/07iPqmy9luc5k4Z9tdSZUaO4+l32vhrF/dwE
9GgwqwKs+F8JzgNPyGS58joeFeglYFPoP0p0g2CMDj1TrfQpUV1V8mocxBqh2IUU
MkMflGZSa4fskMrMhmp8RITy3IBVR8Tg028z2EvgwAQWMzDO1d0W2ghEa3ffqmhT
YlzdzWB2uHg2gfMGObM6Fq0kTpVv0vQZ3SaETGQQfUgnVTWUExhzH4PoxksVFdt9
3BAKG/1ioJVqHZbgYacx5tVd3lqaCtjvwFv8JfRwN/oRgaC+3JGjxB3PZhwuuCkW
pCaxYz8l7Op9mp1/G/513yojibXLTTco2uGQ4398ZESP6hsLoj0MBt2fMcySgxxQ
/ywqxy3T1FP5Ff5+r7iItO5FSxnrIIje/9eH0rx9VB+d8blEH63Id/sR//hrV+Yj
KblBw6CJ4uVi/Dtq+0bhxWAyrBZMDaQ/yf8VvMjAPm748XZSEjjG6Ni8Sfje/GRa
10f4hPR76tvxpxFp5tuUXEdS4ZtfnzQmvh8FSU7g8a60040p0iM5BQZgk/elb+6t
Yfx+Y4EiDPYnJ1v1MhN+/ynuvit6YEvZ/FDEY2xHsU3JiFKNWzh1cwcN6UDPMbKg
EUnGtez8sdcCnP51KRSQ
=VeyJ
-----END PGP SIGNATURE-----

--ScKlbvMFFoYZiKz0TCBaKePcz3cEwS7wV--
