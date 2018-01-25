From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular
 protection is needed
Date: Thu, 25 Jan 2018 08:16:05 +0100
Message-ID: <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="C8HuKPNTd5m53v6DFmJNrRo3hcolTqlS1"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--C8HuKPNTd5m53v6DFmJNrRo3hcolTqlS1
Content-Type: multipart/mixed; boundary="p78uivfIIavDiDghSbjAihzIPYVBYIKPr";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.vnet.ibm.com>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com,
 dominik.dingel@gmail.com, linux-s390@vger.kernel.org
Message-ID: <d886d2af-925b-47ef-300d-99ba9f088df7@linux.vnet.ibm.com>
Subject: Re: [RFC/PATCH v2 19/22] s390/mm: Split huge pages if granular
 protection is needed
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
 <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>
In-Reply-To: <1513169613-13509-20-git-send-email-frankja@linux.vnet.ibm.com>

--p78uivfIIavDiDghSbjAihzIPYVBYIKPr
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 13.12.2017 13:53, Janosch Frank wrote:
> A guest can put DAT tables for a lower level guest in the same huge
> segment as one of its prefixes or a g3 page. This would make it
> necessary for the segment to be unprotected (because of the prefix)
> and protected (because of the shadowing) at the same time. This is not
> possible in this universe.
>=20
> Hence we split the affected huge segment, so we can protect on a
> per-page basis. Such gmap segments are special and get a new software
> bit, that helps us handling this edge case.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
> ---
>  arch/s390/include/asm/gmap.h    |  13 ++
>  arch/s390/include/asm/pgtable.h |   7 +-
>  arch/s390/mm/fault.c            |  10 +-
>  arch/s390/mm/gmap.c             | 256 ++++++++++++++++++++++++++++++++=
++++----
>  arch/s390/mm/pgtable.c          |  51 ++++++++
>  5 files changed, 313 insertions(+), 24 deletions(-)

> @@ -1081,20 +1189,27 @@ static int gmap_protect_range(struct gmap *gmap=
, unsigned long gaddr,
>  	spinlock_t *ptl;
>  	unsigned long vmaddr, dist;
>  	pmd_t *pmdp, *hpmdp;
> -	int rc;
> +	int rc =3D 0;
>=20
>  	while (len) {
>  		rc =3D -EAGAIN;
>  		vmaddr =3D __gmap_translate(gmap, gaddr);
>  		hpmdp =3D (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
> +		if (!hpmdp)
> +			BUG();
>  		/* Do we need tests here? */
>  		ptl =3D pmd_lock(gmap->mm, hpmdp);
>=20
>  		pmdp =3D gmap_pmd_op_walk(gmap, gaddr);
>  		if (pmdp) {
>  			if (!pmd_large(*pmdp)) {
> -				rc =3D gmap_protect_pte(gmap, gaddr, pmdp, prot,
> -						      bits);
> +				if (gmap_pmd_is_split(pmdp) &&
> +				    (bits & GMAP_NOTIFY_MPROT)) {
> +					pmd_val(*pmdp) |=3D _SEGMENT_ENTRY_GMAP_IN;
> +				}

@David:
This currently breaks my brain. There *was* a reason why I put this
there and I was quite insistent that we needed it. Something about
notification areas on splits, but I absolutely can't remember it. Sigh,
should've made a comment.

This might be a leftover from earlier versions, but could also keep us
from doing mprot notification on pte's.

> +
> +				rc =3D gmap_protect_pte(gmap, gaddr, vmaddr,
> +						      pmdp, hpmdp, prot, bits);
>  				if (!rc) {
>  					len -=3D PAGE_SIZE;
>  					gaddr +=3D PAGE_SIZE;
> @@ -1111,7 +1226,9 @@ static int gmap_protect_range(struct gmap *gmap, =
unsigned long gaddr,

[...]

> @@ -2774,6 +2977,8 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, =
unsigned long vmaddr)
>  					    IDTE_GLOBAL);
>  			else
>  				__pmdp_csp(pmdp);
> +
> +			gmap_pmd_split_free(pmdp);
>  			*entry =3D _SEGMENT_ENTRY_EMPTY;
>  		}
>  		spin_unlock(&gmap->guest_table_lock);
> @@ -2852,6 +3057,7 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, u=
nsigned long bitmap[4],
>  	pmd_t *pmdp, *hpmdp;
>  	spinlock_t *ptl;
>=20
> +	/* Protection against gmap_link vsie unprotection. */
>  	hpmdp =3D (pmd_t *)huge_pte_offset(gmap->mm, vmaddr, HPAGE_SIZE);
>  	if (!hpmdp)
>  		return;
> @@ -2867,9 +3073,17 @@ void gmap_sync_dirty_log_pmd(struct gmap *gmap, =
unsigned long bitmap[4],
>  						      gaddr, vmaddr))
>  			memset(bitmap, 0xFF, 32);

s/0xFF/0xff/



--p78uivfIIavDiDghSbjAihzIPYVBYIKPr--

--C8HuKPNTd5m53v6DFmJNrRo3hcolTqlS1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJaaYQ8AAoJEBcO/8Q8ZEV5oTAP/Rjw649LEcihV2w7ddgQK+JZ
6YdaFztUjBUSflGPwuBG0BhBSePQlVxaYiWpBHS3Gr4LuJIqEY4dKtGgc9qkWFLE
lJbVWPgOnlrkffrqP1AlefzL/SItop2hegahYBA8lRFi3++qj42udLIb4e4XcDle
ojDEZx47e1vqz2Wg+CC+k8kJ5OKLpUJEx1FVwGSMqbiIeS2/QigSoqoiDZ0XcdXi
e+yO4p8hvKD6EjlGAirs4Ma8Kf6GeeRqNayT1vSwMCGVN+NAjmuh7O5WEF2hQEZJ
+T+513pMEewHoz8X+Ifhvh2cnpdkxHvO9QGE6fxWLlhEHzz6fV2qaVe8e8/npclo
g4AlhylHHs+HQ0oylvAgeeiqAzfj0DfuPwMqvELZ/rxV11p82T8TpF824maRbiq6
aExPis3FMqjPrxzXLLxUTk6V4Vqh4ypx1dbALinHuk7VdiLbL93US8oE9LsCXI6T
u9D8NM++hcnvOLvlz6udeyodf4Q8v/BqOhhl24+mhBaJaRUAh/dC096vFNbrGzSk
GIHGfgAm0LKfc0LYSWo0pft+vTcZVl7QZZ95S0FoHcSMxIugiNRpxG+Ri//XXWJn
kxi+gTVvgkJ5eDLMRrvybmZeBYf/GvhpuPe0Z70pQ3JeoYi3DFQWjtOn/1ZDqmQ3
LRXqD77WpSKzPuYoAXk3
=zEhT
-----END PGP SIGNATURE-----

--C8HuKPNTd5m53v6DFmJNrRo3hcolTqlS1--
