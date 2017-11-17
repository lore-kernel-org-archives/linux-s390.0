From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 03/22] s390/mm: add gmap PMD invalidation notification
Date: Fri, 17 Nov 2017 10:02:57 +0100
Message-ID: <eebe97cd-5c3d-f54f-6dfc-e6a105c57dc4@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-4-git-send-email-frankja@linux.vnet.ibm.com>
 <3b439732-70a4-8b95-4b9e-87f230dd7aaa@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Fm95Eg5lMX5sjxSaQ5kfXNrGlLsjN78WS"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <3b439732-70a4-8b95-4b9e-87f230dd7aaa@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Fm95Eg5lMX5sjxSaQ5kfXNrGlLsjN78WS
Content-Type: multipart/mixed; boundary="oE3oVHmc5KXMhbH2QAGJi1wVJEtj0Nfjq";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <eebe97cd-5c3d-f54f-6dfc-e6a105c57dc4@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 03/22] s390/mm: add gmap PMD invalidation notification
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-4-git-send-email-frankja@linux.vnet.ibm.com>
 <3b439732-70a4-8b95-4b9e-87f230dd7aaa@redhat.com>
In-Reply-To: <3b439732-70a4-8b95-4b9e-87f230dd7aaa@redhat.com>

--oE3oVHmc5KXMhbH2QAGJi1wVJEtj0Nfjq
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 15.11.2017 10:55, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> For later migration of huge pages we want to write-protect guest
>> PMDs. While doing this, we have to make absolutely sure, that the
>> guest's lowcore is always accessible when the VCPU is running. With
>> PTEs, this is solved by marking the PGSTEs of the lowcore pages with
>> the invalidation notification bit and kicking the guest out of the SIE=

>> via a notifier function if we need to invalidate such a page.
>>
>> With PMDs we do not have PGSTEs or some other bits we could use in the=

>> host PMD. Instead we pick one of the free bits in the gmap PMD. Every
>> time a host pmd will be invalidated, we will check if the respective
>> gmap PMD has the bit set and in that case fire up the notifier.
>>
>> In the first step we only support setting the invalidation bit, but we=

>> do not support restricting access of guest pmds. It will follow
>> shortly.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> ---

>> index 74e2062..3961589 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -595,10 +595,17 @@ int __gmap_link(struct gmap *gmap, unsigned long=
 gaddr, unsigned long vmaddr)
>>  	if (*table =3D=3D _SEGMENT_ENTRY_EMPTY) {
>>  		rc =3D radix_tree_insert(&gmap->host_to_guest,
>>  				       vmaddr >> PMD_SHIFT, table);
>> -		if (!rc)
>> -			*table =3D pmd_val(*pmd);
>> -	} else
>> -		rc =3D 0;
>> +		if (!rc) {
>> +			if (pmd_large(*pmd)) {
>> +				*table =3D pmd_val(*pmd) &
>> +					(_SEGMENT_ENTRY_ORIGIN_LARGE
>> +					 | _SEGMENT_ENTRY_INVALID
>> +					 | _SEGMENT_ENTRY_LARGE
>> +					 | _SEGMENT_ENTRY_PROTECT);
>=20
> Can we reuse/define a mask for that?

We could define GMAP masks, that only leave the bits needed for GMAP
usage. Integrating this in pgtable.h might be hard and we only have one
user of this.

>=20
> Like _SEGMENT_ENTRY_BITS_LARGE
>=20
>> +			} else
>> +				*table =3D pmd_val(*pmd) & ~0x03UL;
>=20
> Where exactly does the 0x03UL come from? Can we reuse e.g.
> _SEGMENT_ENTRY_BITS here?

No, _SEGMENT_ENTRY_BITS contains these bits.

This is effectively ~(_SEGMENT_ENTRY_READ | _SEGMENT_ENTRY_WRITE) to get
rid of the software bits linux uses for tracking.

>=20
> Or is there a way to unify both cases?

That will be difficult because of the different origin masks.

>> =20
>>  /*
>> + * gmap_protect_large - set pmd notification bits
>=20
> Why not gmap_protect_pmd just like gmap_protect_pte?

When I started I thought adding edat2 would not be harder than adding
edat1. The large suffix could have later been used to do 1m and 2g
handling because the bits are at the same places.

I'll change this one and all later occurrences.

>=20
>> + * @pmdp: pointer to the pmd to be protected
>> + * @prot: indicates access rights: PROT_NONE, PROT_READ or PROT_WRITE=

>> + * @bits: notification bits to set
>> + *
>> + * Returns 0 if successfully protected, -ENOMEM if out of memory and
>> + * -EAGAIN if a fixup is needed.
>> + *
>> + * Expected to be called with sg->mm->mmap_sem in read and
>> + * guest_table_lock held.
>=20
> gmap_pmd_op_walk() guarantees the latter, correct?

Yes

>=20
>> + */
>> +static int gmap_protect_large(struct gmap *gmap, unsigned long gaddr,=

>> +			      pmd_t *pmdp, int prot, unsigned long bits)
>> +{
>> +	int pmd_i, pmd_p;
>> +
>> +	pmd_i =3D pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID;
>> +	pmd_p =3D pmd_val(*pmdp) & _SEGMENT_ENTRY_PROTECT;
>=20
> initialize both directly and make them const.

Sure

>>  static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,=

>>  			      unsigned long len, int prot, unsigned long bits)
>> @@ -990,11 +1026,20 @@ static int gmap_protect_range(struct gmap *gmap=
, unsigned long gaddr,
>>  		rc =3D -EAGAIN;
>>  		pmdp =3D gmap_pmd_op_walk(gmap, gaddr);
>>  		if (pmdp) {
>> -			rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> -					      bits);
>> -			if (!rc) {
>> -				len -=3D PAGE_SIZE;
>> -				gaddr +=3D PAGE_SIZE;
>> +			if (!pmd_large(*pmdp)) {
>> +				rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> +						      bits);
>> +				if (!rc) {
>> +					len -=3D PAGE_SIZE;
>> +					gaddr +=3D PAGE_SIZE;
>> +				}
>> +			} else {
>> +				rc =3D  gmap_protect_large(gmap, gaddr, pmdp,
>> +							 prot, bits);
>> +				if (!rc) {
>> +					len =3D len < HPAGE_SIZE ? 0 : len - HPAGE_SIZE;
>=20
> Shouldn't you also have to take the difference to (gaddr & HPAGE_MASK)
> into account, like you do in the next step? (so always subtracting
> HPAGE_SIZE looks suspicious)

Yes it seems we have to do that.
We just never ran into troubles because len is generally < HPAGE_SIZE
and tables don't seem to cross segment boundaries.

>> +/**
>> + * pmdp_notify - call all invalidation callbacks for a specific pmd
>> + * @mm: pointer to the process mm_struct
>> + * @vmaddr: virtual address in the process address space
>> + *
>> + * This function is expected to be called with mmap_sem held in read.=

>> + */
>> +void pmdp_notify(struct mm_struct *mm, unsigned long vmaddr)
>> +{
>> +	unsigned long *table, gaddr;
>> +	struct gmap *gmap;
>> +
>> +	rcu_read_lock();
>> +	list_for_each_entry_rcu(gmap, &mm->context.gmap_list, list) {
>> +		spin_lock(&gmap->guest_table_lock);
>> +		table =3D radix_tree_lookup(&gmap->host_to_guest,
>> +					  vmaddr >> PMD_SHIFT);
>> +		if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN)) {
>> +			spin_unlock(&gmap->guest_table_lock);
>> +			continue;
>> +		}
>> +		gaddr =3D __gmap_segment_gaddr(table);
>> +		*table &=3D ~_SEGMENT_ENTRY_GMAP_IN;
>=20
> We can perform this page table change without any flushing/stuff like
> that because we don't modify bits used by the HW. Is that guaranteed by=

> the architecture or are there any special conditions to take into
> account? (applies also to were we set the _SEGMENT_ENTRY_GMAP_IN)

ACC is ignored when the validity is 0 and 62 and 63 (0x3) are "available
for programming".
It pretty much sounds like these are OS bits free for any usage, I'll
ask the hardware team when I find time.


--oE3oVHmc5KXMhbH2QAGJi1wVJEtj0Nfjq--

--Fm95Eg5lMX5sjxSaQ5kfXNrGlLsjN78WS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaDqXBAAoJEBcO/8Q8ZEV5LxMQAJygfboyVmKpMDPEQDd3QBu/
I2GiRFtRBKirZz3VqI1T0FbTWVIi9a/KAsc4Ax7W2UGFSOcYfuMTd5a8Sup14kPY
vGpJyYg9Q9/uBSEsYQsS2RU/e/hM57KgOtl173y8osrObsrFw1+BekcCgmPo7jRU
mu+kXex+lKl1o7lKwa/Sc24y3TsLimU3nXHPQzhsUdUZWfssHO55PJdXcPgKFeQ3
KX4KOHSCsFzLnkSekrN6vfEEd0P9/g7WPek2zPWl81tHv1QQwekQ6VD/UXHd5U+i
mOy/HZ26aw9jbkZJDw1rm5fX0ja9IB5qVY39LxEv6wDr/+nZAyqifpo3+etROfAW
73cNhEL1glJYfGme0LD/DEoNmW2OIvr4zBJuuUE2J1i43ulQ0g2aRMFhjBYeCckW
uYNHP81MW+zLDDdSdus7Ca+fqMbHjIxDVBrS3zQWvCxT2IqtLS6leSTleHMzJSwJ
iIGGRAxQdr2BQOHqTpmsATzron2eZZgU03GtyV3+hjh4LR018YFeIPX0KQoWLcA7
/HRL0FGwS9Rh4ffCzmg2s5SmBDe8N3Ua7yBBcTrIcw12rWWGF7F6qOlbA4J1xZPj
B7OI8mvUa9Kq/PGIVZYOLgbnHXyXheu756c5ou7aX1rzqK4Lp1DOAZuWZu1ZEjsK
QjnhRo1udAia1k/AKV9B
=0nHs
-----END PGP SIGNATURE-----

--Fm95Eg5lMX5sjxSaQ5kfXNrGlLsjN78WS--
