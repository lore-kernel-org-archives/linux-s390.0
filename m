From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] s390x/mm: simplify gmap_protect_rmap()
Date: Wed, 24 Jan 2018 12:55:02 +0100
Message-ID: <494b3da3-3e23-4f40-cfdd-3b7a9bba384b@linux.vnet.ibm.com>
References: <20180123212618.32611-1-david@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="4SgGIhr9Gd4jzDKUkmXyRqlkub3wv0sSh"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20180123212618.32611-1-david@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4SgGIhr9Gd4jzDKUkmXyRqlkub3wv0sSh
Content-Type: multipart/mixed; boundary="7AUMd0kx0aaZlGUPfzFPSVniz2EDmY26s";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>
Message-ID: <494b3da3-3e23-4f40-cfdd-3b7a9bba384b@linux.vnet.ibm.com>
Subject: Re: [PATCH v1] s390x/mm: simplify gmap_protect_rmap()
References: <20180123212618.32611-1-david@redhat.com>
In-Reply-To: <20180123212618.32611-1-david@redhat.com>

--7AUMd0kx0aaZlGUPfzFPSVniz2EDmY26s
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 23.01.2018 22:26, David Hildenbrand wrote:
> We never call it with anything but PROT_READ. This is a left over from
> an old prototype. For creation of shadow page tables, we always only
> have to protect the original table in guest memory from write accesses,=

> so we can properly invalidate the shadow on writes. Other protections
> are not needed.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

I'm not completely convinced that this is necessary, but it looks right
nevertheless:

Reviewed-by: Janosch Frank <frankja@linux.vnet.ibm.com>

> ---
>  arch/s390/mm/gmap.c | 17 ++++++++---------
>  1 file changed, 8 insertions(+), 9 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 54cfd51a5a27..a7e05c5dea70 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -1021,18 +1021,17 @@ static inline void gmap_insert_rmap(struct gmap=
 *sg, unsigned long vmaddr,
>  }
>=20
>  /**
> - * gmap_protect_rmap - modify access rights to memory and create an rm=
ap
> + * gmap_protect_rmap - restrict access rights to memory (RO) and creat=
e an rmap
>   * @sg: pointer to the shadow guest address space structure
>   * @raddr: rmap address in the shadow gmap
>   * @paddr: address in the parent guest address space
>   * @len: length of the memory area to protect
> - * @prot: indicates access rights: none, read-only or read-write
>   *
>   * Returns 0 if successfully protected and the rmap was created, -ENOM=
EM
>   * if out of memory and -EFAULT if paddr is invalid.
>   */
>  static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
> -			     unsigned long paddr, unsigned long len, int prot)
> +			     unsigned long paddr, unsigned long len)
>  {
>  	struct gmap *parent;
>  	struct gmap_rmap *rmap;
> @@ -1060,7 +1059,7 @@ static int gmap_protect_rmap(struct gmap *sg, uns=
igned long raddr,
>  		ptep =3D gmap_pte_op_walk(parent, paddr, &ptl);
>  		if (ptep) {
>  			spin_lock(&sg->guest_table_lock);
> -			rc =3D ptep_force_prot(parent->mm, paddr, ptep, prot,
> +			rc =3D ptep_force_prot(parent->mm, paddr, ptep, PROT_READ,
>  					     PGSTE_VSIE_BIT);
>  			if (!rc)
>  				gmap_insert_rmap(sg, vmaddr, rmap);
> @@ -1070,7 +1069,7 @@ static int gmap_protect_rmap(struct gmap *sg, uns=
igned long raddr,
>  		radix_tree_preload_end();
>  		if (rc) {
>  			kfree(rmap);
> -			rc =3D gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
> +			rc =3D gmap_pte_op_fixup(parent, paddr, vmaddr, PROT_READ);
>  			if (rc)
>  				return rc;
>  			continue;
> @@ -1609,7 +1608,7 @@ int gmap_shadow_r2t(struct gmap *sg, unsigned lon=
g saddr, unsigned long r2t,
>  	origin =3D r2t & _REGION_ENTRY_ORIGIN;
>  	offset =3D ((r2t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
>  	len =3D ((r2t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
> -	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);=

> +	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len);
>  	spin_lock(&sg->guest_table_lock);
>  	if (!rc) {
>  		table =3D gmap_table_walk(sg, saddr, 4);
> @@ -1692,7 +1691,7 @@ int gmap_shadow_r3t(struct gmap *sg, unsigned lon=
g saddr, unsigned long r3t,
>  	origin =3D r3t & _REGION_ENTRY_ORIGIN;
>  	offset =3D ((r3t & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
>  	len =3D ((r3t & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
> -	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);=

> +	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len);
>  	spin_lock(&sg->guest_table_lock);
>  	if (!rc) {
>  		table =3D gmap_table_walk(sg, saddr, 3);
> @@ -1776,7 +1775,7 @@ int gmap_shadow_sgt(struct gmap *sg, unsigned lon=
g saddr, unsigned long sgt,
>  	origin =3D sgt & _REGION_ENTRY_ORIGIN;
>  	offset =3D ((sgt & _REGION_ENTRY_OFFSET) >> 6) * PAGE_SIZE;
>  	len =3D ((sgt & _REGION_ENTRY_LENGTH) + 1) * PAGE_SIZE - offset;
> -	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len, PROT_READ);=

> +	rc =3D gmap_protect_rmap(sg, raddr, origin + offset, len);
>  	spin_lock(&sg->guest_table_lock);
>  	if (!rc) {
>  		table =3D gmap_table_walk(sg, saddr, 2);
> @@ -1895,7 +1894,7 @@ int gmap_shadow_pgt(struct gmap *sg, unsigned lon=
g saddr, unsigned long pgt,
>  	/* Make pgt read-only in parent gmap page table (not the pgste) */
>  	raddr =3D (saddr & _SEGMENT_MASK) | _SHADOW_RMAP_SEGMENT;
>  	origin =3D pgt & _SEGMENT_ENTRY_ORIGIN & PAGE_MASK;
> -	rc =3D gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE, PROT_READ);
> +	rc =3D gmap_protect_rmap(sg, raddr, origin, PAGE_SIZE);
>  	spin_lock(&sg->guest_table_lock);
>  	if (!rc) {
>  		table =3D gmap_table_walk(sg, saddr, 1);
>=20



--7AUMd0kx0aaZlGUPfzFPSVniz2EDmY26s--

--4SgGIhr9Gd4jzDKUkmXyRqlkub3wv0sSh
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaHQWAAoJEBcO/8Q8ZEV5Zn0P/iQn+dCwbDXjD1ZZCh7C5QH5
5u6vaTkH9nFBGz+7bFqCVm6/jyCN1KN/X58lwuhqAjYCsMLzHFLF73/EgmjMTLjw
IRHJ0KHgIUcXNRg/doQpky4svwoGNaksscBufwENs6du9t5mO5jgLCF+cfWps/d6
nQXmO3avwi0eVqhcw3zEdUoxr9I1zBu/nUNwIAETLYbE0u5pZ0BywFaOm0FuEzSx
kSOsT7x6KgfHHVSWemlG0IJyRvXvlM/ioJvigx8ZSCVebT97s7cWnu9ndrZQP0jP
Mr0A74LhaR23hhpcEkqC+JLNgNUHEgnf93vAyEd64y8hnkwqmpB1hQskmAC0duN+
iWhUjo11tWjY3WEGEqMqAMQSs6QmckAKckStH88zwyV2nYGwu+fF8KIGEiV4FoE8
ZOj6TnVfR2rDosQP/dXy/AAscEZl3CuDwqrshjq5lKAZLNFuLOPi4SS+0GT1ZU4B
bWrsmCttOssJ+0HzDOaSCTHiCalKotCWEvO1PT0XCht6C9fn5QbH/9qGmaYHnMPc
07BHtPdNJMOY2YGPaTmJsXa/0cPJHuT9ZwhUvHXfnwKPZ+hrHTcwWAjKEegfSLgl
t3B5aHwCKxCIqoGjQ4aw6FVcTNHPOxdoHt7zIMs3aPaJeAGEj9bsy7O00Tlxxul0
JH9kpoPo4fHNoFUYPfRi
=+6/z
-----END PGP SIGNATURE-----

--4SgGIhr9Gd4jzDKUkmXyRqlkub3wv0sSh--
