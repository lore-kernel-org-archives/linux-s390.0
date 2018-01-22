From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 01/22] s390/mm: make gmap_protect_range more
 modular
Date: Mon, 22 Jan 2018 13:31:17 +0100
Message-ID: <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-2-git-send-email-frankja@linux.vnet.ibm.com>
 <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="zVqY9ppcpgQlngIW2xZGZRLMa0lwKA7OC"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--zVqY9ppcpgQlngIW2xZGZRLMa0lwKA7OC
Content-Type: multipart/mixed; boundary="4sQq6XDOLiHeNBd8rHR87WRn7QuME0Xks";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <2a4094a9-aee5-adad-f543-3bfe1ca9d440@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 01/22] s390/mm: make gmap_protect_range more
 modular
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-2-git-send-email-frankja@linux.vnet.ibm.com>
 <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>
In-Reply-To: <f8fe917b-a95f-406c-fa6b-b12b2dae6e61@redhat.com>

--4sQq6XDOLiHeNBd8rHR87WRn7QuME0Xks
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 22.01.2018 12:33, David Hildenbrand wrote:
> On 13.12.2017 13:53, Janosch Frank wrote:
>> This patch reworks the gmap_protect_range logic and extracts the pte
>> handling into an own function. Also we do now walk to the pmd and make=

>> it accessible in the function for later use. This way we can add huge
>> page handling logic more easily.
>>
>> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
>> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
>> Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
>> ---
>>  arch/s390/mm/gmap.c | 102 +++++++++++++++++++++++++++++++++++++++++++=
+++------
>>  1 file changed, 92 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
>> index 05d459b..8de8bf9 100644
>> --- a/arch/s390/mm/gmap.c
>> +++ b/arch/s390/mm/gmap.c
>> @@ -874,7 +874,88 @@ static int gmap_pte_op_fixup(struct gmap *gmap, u=
nsigned long gaddr,
>>   */
>>  static void gmap_pte_op_end(spinlock_t *ptl)
>>  {
>> -	spin_unlock(ptl);
>> +	if (ptl)
>> +		spin_unlock(ptl);
>> +}
>> +
>> +/**
>> + * gmap_pmd_op_walk - walk the gmap tables, get the guest table lock
>> + *		      and return the pmd pointer
>> + * @gmap: pointer to guest mapping meta data structure
>> + * @gaddr: virtual address in the guest address space
>> + *
>> + * Returns a pointer to the pmd for a guest address, or NULL
>> + */
>> +static inline pmd_t *gmap_pmd_op_walk(struct gmap *gmap, unsigned lon=
g gaddr)
>> +{
>> +	pmd_t *pmdp;
>> +
>> +	spin_lock(&gmap->guest_table_lock);
>> +	pmdp =3D (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
>> +
>> +	/*
>> +	 * Empty pmds can become large after we give up the
>> +	 * guest_table_lock, so we have to check for pmd_none
>> +	 * here.
>> +	 */
>=20
> Don't understand that comment. We give up the lock after we're done wit=
h
> the pmd either way. So I think this comment can go.

TBH I'm currently not able to recall the reason for this comment.

>=20
>> +	if (!pmdp || pmd_none(*pmdp)) {
>> +		spin_unlock(&gmap->guest_table_lock);
>> +		return NULL;
>> +	}
>> +	/*
>> +	 * For plain 4k guests that do not run under the vsie it
>> +	 * suffices to take the pte lock later on. Thus we can unlock
>> +	 * the guest_table_lock here.
>> +	 */
>=20
> As discussed, the gmap_is_shadow() check is not needed. The comment
> should be something like

IFF we'll never use this function to walk shadow tables, then you are
right. We can make it a policy and throw in a BUG_ON.

[...]
>> +static int gmap_protect_pte(struct gmap *gmap, unsigned long gaddr,
>> +			    pmd_t *pmdp, int prot, unsigned long bits)
>> +{
>> +	int rc;
>> +	pte_t *ptep;
>> +	spinlock_t *ptl =3D NULL;
>> +
>> +	/* We have no upper segment, let's go back and fix this up. */
>> +	if (pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)
>> +		return -EAGAIN;
>=20
> This is essentially pmd_none(*pmdp), which you already verified in
> gmap_pmd_op_walk().

Well, not really pmd_none is entry =3D=3D ENTRY_EMPTY (only I bit set) no=
t
entry & I.
Is there a path where we have an I bit on a pmd entry which has a valid p=
to?

>=20
> I suggest requiring for this function that the entry is valid (which is=

> always the case) and getting rid of the -EAGAIN return code. Makes this=

> function simpler.
>=20
>> +
>> +	ptep =3D pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
>> +	if (!ptep)
>> +		return -ENOMEM;
>> +
>> +	/* Protect and unlock. */
>> +	rc =3D ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
>> +	gmap_pte_op_end(ptl);
>> +	return rc;
>>  }
>> =20
>>  /*
>> @@ -896,16 +977,20 @@ static int gmap_protect_range(struct gmap *gmap,=
 unsigned long gaddr,
>>  			      unsigned long len, int prot, unsigned long bits)
>>  {
>>  	unsigned long vmaddr;
>> -	spinlock_t *ptl;
>> -	pte_t *ptep;
>> +	pmd_t *pmdp;
>>  	int rc;
>> =20
>>  	while (len) {
>>  		rc =3D -EAGAIN;
>> -		ptep =3D gmap_pte_op_walk(gmap, gaddr, &ptl);
>> -		if (ptep) {
>> -			rc =3D ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
>> -			gmap_pte_op_end(ptl);
>> +		pmdp =3D gmap_pmd_op_walk(gmap, gaddr);
>> +		if (pmdp) {
>> +			rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
>> +					      bits);
>> +			if (!rc) {
>> +				len -=3D PAGE_SIZE;
>> +				gaddr +=3D PAGE_SIZE;
>> +			}
>> +			gmap_pmd_op_end(gmap, pmdp);
>=20
> This change looks good to me.

Great :)

>=20
>>  		}
>>  		if (rc) {
>>  			vmaddr =3D __gmap_translate(gmap, gaddr);
>> @@ -914,10 +999,7 @@ static int gmap_protect_range(struct gmap *gmap, =
unsigned long gaddr,
>>  			rc =3D gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
>>  			if (rc)
>>  				return rc;
>> -			continue;
>>  		}
>> -		gaddr +=3D PAGE_SIZE;
>> -		len -=3D PAGE_SIZE;
>>  	}
>>  	return 0;
>>  }
>>
>=20
>=20



--4sQq6XDOLiHeNBd8rHR87WRn7QuME0Xks--

--zVqY9ppcpgQlngIW2xZGZRLMa0lwKA7OC
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaZdmVAAoJEBcO/8Q8ZEV51xwP/izicKufRxaYqE3NdS8SVGTI
9FMeolv9XZtAe3tx/g2OZPYN1ZgXNyg6bwugdV/OO6Ii2s0oheI56IkzK1IgVGp7
9kxdtM5G5M+P1Q7bqBCqDShlKtgPf4rFesQVAVCYsAMm70EeME9cW6jl6u3PiF3e
17b0Mb409O6j5zIk7zwoHt9jMMfMfGtal3cXd7DZhjeQyjH5vkx+PiUY0AwM+xZn
SXgpr1N8i93g9wJmN420sfKto1Nh069XfE+jG9J4R8GVk05Whvk0pj0/nqPJipxI
krWlYWlr9OTpguL9qNKH+LTAfFPldsvv3l/wdjW+dUQ14hclyW/PMC9vNCkjUZC1
9QS1r3QVRMPUy5lneAYNQ47eWYTqR+89GbLmOpEBXRCb0tG/IAIcZpqm4UMDJ2Za
SNLE1D7ejIS29NY6mWLDZeb2sfg0UwlTrUJ5464iDsHt5sYIuxQDiIT/y3oyJuQh
iuqXtA/9UovHPCyp8/sZW2QraDp074GtIUxWHDKzYG+CjohozR8pUDs155OE0srN
r/oF0//07PRhVBXhVXUxBN48THyNo2VGqgzLE/u6VlI3PGVYkS7uUgct9L9Jy+i8
pC5N0/gWUf5EbhIxgLWlcSSSO9/lKDIXef23ATp0C4P557nSHkCHzrLuf0FaC0dd
E9iONnA0Flaft4nzk0KM
=FK8B
-----END PGP SIGNATURE-----

--zVqY9ppcpgQlngIW2xZGZRLMa0lwKA7OC--
