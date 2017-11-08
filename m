From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 01/22] s390/mm: make gmap_protect_range more modular
Date: Wed, 8 Nov 2017 13:21:35 +0100
Message-ID: <b08da302-fd79-1120-b27e-d1ed295b7bbe@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-2-git-send-email-frankja@linux.vnet.ibm.com>
 <1f39ee13-92a9-5d56-84c1-495c29a08a32@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="xFjilprqtexj3lE1tfXtloCQEwEba85l5"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1f39ee13-92a9-5d56-84c1-495c29a08a32@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xFjilprqtexj3lE1tfXtloCQEwEba85l5
Content-Type: multipart/mixed; boundary="iH8dfUwhFVVNhJwqUTVrScMKX1nBbRog8";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, dominik.dingel@gmail.com,
 linux-s390@vger.kernel.org
Message-ID: <b08da302-fd79-1120-b27e-d1ed295b7bbe@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH 01/22] s390/mm: make gmap_protect_range more modular
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1510007400-42493-2-git-send-email-frankja@linux.vnet.ibm.com>
 <1f39ee13-92a9-5d56-84c1-495c29a08a32@redhat.com>
In-Reply-To: <1f39ee13-92a9-5d56-84c1-495c29a08a32@redhat.com>

--iH8dfUwhFVVNhJwqUTVrScMKX1nBbRog8
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 08.11.2017 11:40, David Hildenbrand wrote:
> On 06.11.2017 23:29, Janosch Frank wrote:
>> This patch reworks the gmap_protect_range logic and extracts the pte
>> handling into an own function. Also we do now walk to the pmd and make=

>> it accessible in the function for later use. This way we can add huge
>> page handling logic more easily.
>=20
> I just realized (and hope it is correct), that any gmap_shadow() checks=

> in e.g. gmap_pte_op_walk() are superfluous. This code is never reached.=

>=20
> This would imply that also in this patch, you can drop all
> gmap_is_shadow(gmap) checks and instead add BUG_ON(gmap_is_shadow()) to=

> all functions.
>=20
> Will double check and prepare a cleanup for existing code.

Hrm, looks like it.

Be aware, that I'm very protective about changes in the GMAP, especially
on the VSIE part. I've had minimal changes on these patches setting me
back for weeks, so if you want to change things, be absolutely sure,
that it will work (also with further changes) or add them after this set
is merged.

Thanks for having a look!

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
>> +
>> +	if (gmap_is_shadow(gmap)) {
>> +		ptep =3D pte_offset_map(pmdp, gaddr);
>> +	} else {
>> +		ptep =3D pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
>> +		if (!ptep)
>> +			return -ENOMEM;
>> +	}
>=20
> if (gmap_is_shadow(gmap))
> 	ptep =3D pte_offset_map(pmdp, gaddr);
> else
> 	ptep =3D pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
>=20
> if (!ptep)
> 	return -ENOMEM;
>=20
> Makes it a little bit nicer to read.

Sure

>=20
>> +
>> +	/* Protect and unlock. */
>> +	rc =3D ptep_force_prot(gmap->mm, gaddr, ptep, prot, bits);
>> +	if (ptl)
>> +		gmap_pte_op_end(ptl);
>=20
> Would it make sense to move the ptl test into gmap_pte_op_end() ?

That's a great idea, I have a lot of these in the following patches.

>=20
>> +	return rc;
>> +}
>> +
>> @@ -913,10 +1002,7 @@ static int gmap_protect_range(struct gmap *gmap,=
 unsigned long gaddr,
>>  			rc =3D gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
>>  			if (rc)
>>  				return rc;
>> -			continue;
>>  		}
>> -		gaddr +=3D PAGE_SIZE;
>> -		len -=3D PAGE_SIZE;
>=20
> Not sure if I like this change. I think I prefer it the way it is now
> (keeps the loop body shorter).

Well, this loop and a lot of others will get longer through the other
patches in the set.

They need some refactoring, but just to be safe, start getting used to it=
 :)


--iH8dfUwhFVVNhJwqUTVrScMKX1nBbRog8--

--xFjilprqtexj3lE1tfXtloCQEwEba85l5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaAvbWAAoJEBcO/8Q8ZEV5saoP/RA6OwzqnFqmQHAu5gZ7dDX0
69MXfBk1a0DtKAfjjrV+maYy+eK/K3E6EBC/C6a3LqwoMshJO9VDYVf8+OfnjIRi
VZrH174E6sPRdWuetC75lRen7anx1iOYgeZYQBJqvBqdX/RenQL7tsuUin2ckqlG
12qpKXHjiNVBwkRUY1oBQ0QUDFex6z5EfMIDO82kZA1Eo4mQCvB6Z8DdBBhKXbGC
yUFUnmHclbvRSTSgHyU4VJv6ETrj+E1JzZR3Ctfbv8gVyzC9E2LplLDbVjpdQrfS
5Ikz3SI8MPUp9ZTm7y3iM6QHSzSukRpB5Vyh5NA/SiVV+ZKG2tjLqpR84EDDpYiZ
4Alagv6H8V/kxEIJ+ayUEcxzm38umGSRBk4iiTc1nCbIg56O58FWxf4zP+XVA8ZW
+REGkKVMnBH0SKhVTSzZlPPPpzSQlqdKKb1W90GUYiMWlgXfHG+FNyvLlqBcKP/7
RTYUDy6PEYFNMSaiZyaekmy5TLktE5AdNseUkj+mRYQzH70rNm9B5qqYMP8FCg1S
DIwdpj4iI3ywpx6rLpFWLloZf0nsYjbUVMIBFZ10JOU/gy1dJ0p2uUc+G0TiEVD4
XyrJA+RSVLUQcDzR+paiyZFOWsm50k80vGv6IAAVUzH6d0uzt0ueiTCc5zVhBfpK
pLg3kSLd7o71xSrCRnxH
=rkEW
-----END PGP SIGNATURE-----

--xFjilprqtexj3lE1tfXtloCQEwEba85l5--
