Return-Path: <SRS0=n5k7=KW=vger.kernel.org=linux-kernel-owner@kernel.org>
Subject: Re: [PATCH] s390x/mm: avoid taking the table lock in
 gmap_pmd_op_walk()
References: <20180806155407.15252-1-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 7 Aug 2018 09:26:07 +0200
MIME-Version: 1.0
In-Reply-To: <20180806155407.15252-1-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="NYEbmNmPHBKnRu7s81gJEZlYf8ulhXisU"
Message-Id: <d3e543bc-d0ff-c8ef-f097-eeba2bde6971@linux.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--NYEbmNmPHBKnRu7s81gJEZlYf8ulhXisU
Content-Type: multipart/mixed; boundary="yvfh2izJUHpnV2mDovhO9V9zuNv9hvTaZ";
 protected-headers="v1"
From: Janosch Frank <frankja@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>, linux-kernel@vger.kernel.org
Cc: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>,
 Christian Borntraeger <borntraeger@de.ibm.com>
Message-ID: <d3e543bc-d0ff-c8ef-f097-eeba2bde6971@linux.ibm.com>
Subject: Re: [PATCH] s390x/mm: avoid taking the table lock in
 gmap_pmd_op_walk()
References: <20180806155407.15252-1-david@redhat.com>
In-Reply-To: <20180806155407.15252-1-david@redhat.com>

--yvfh2izJUHpnV2mDovhO9V9zuNv9hvTaZ
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 06.08.2018 17:54, David Hildenbrand wrote:
> Right now we temporarily take the page table lock in gmap_pmd_op_walk()=

> even though we know we won't need it (if we can never have 1mb pages
> mapped into the gmap).
>=20
> So let's special case this, so
> gmap_protect_range()/gmap_sync_dirty_log_pmd() will not take the lock i=
n
> case huge pages are not allowed.

So, let's make this a special case

>=20
> gmap_protect_range() is called quite frequently for managing shadow
> page tables in vSIE environments.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>

If you make the patch title more specific:
Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

I considered getting rid of the last unlock with the !large check, but
in theory somebody could run a VM with the HPAGE CAP and 4k pages which
would then result in havoc if we wouldn't also adapt gmap_pmd_op_end.

> ---
>  arch/s390/mm/gmap.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index bb44990c8212..d4fa0a4514e0 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -905,10 +905,16 @@ static inline pmd_t *gmap_pmd_op_walk(struct gmap=
 *gmap, unsigned long gaddr)
>  	pmd_t *pmdp;
> =20
>  	BUG_ON(gmap_is_shadow(gmap));
> -	spin_lock(&gmap->guest_table_lock);
>  	pmdp =3D (pmd_t *) gmap_table_walk(gmap, gaddr, 1);
> +	if (!pmdp)
> +		return NULL;
> =20
> -	if (!pmdp || pmd_none(*pmdp)) {
> +	/* without huge pages, there is no need to take the table lock */
> +	if (!gmap->mm->context.allow_gmap_hpage_1m)
> +		return pmd_none(*pmdp) ? NULL : pmdp;
> +
> +	spin_lock(&gmap->guest_table_lock);
> +	if (pmd_none(*pmdp)) {
>  		spin_unlock(&gmap->guest_table_lock);
>  		return NULL;
>  	}
>=20



--yvfh2izJUHpnV2mDovhO9V9zuNv9hvTaZ--

--NYEbmNmPHBKnRu7s81gJEZlYf8ulhXisU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJbaUmZAAoJEBcO/8Q8ZEV5DDcQAJwnfenMm7pE7WAaj9j1RPSR
UYKSoDenhCkNNvZdGPOr+JHo9YjuHSA3i7KXZ+PaxlpWfDd9Ok1R6geC2tCzpQey
Dr8fO0eeS2+9pemMNMbKYL5pVtvviy/9hxAsT92JOmiUMmIiVJjx8rUQBXWCKVGp
ksdgI9VOq6520CJEeLXJ0N5zXUxWq06gWvP+X5j5QojoQL4Vq21QVuH8yeogIL02
3jocS7K+OmR66ShA+od8LM/yuoK+wuv/l38ifdlGXPistSip2cHnCNQfQeY4DqnU
zA57mPcd64balRRBoZGBMDi9X4sJK7WOiccSIdrZLvNlfUxYJrF6Wbumm+oNNxew
iI3dpKzsiFA0VE3jTgYFB4tsXtmhDx+ATly4sXgaH82kq2lU6Dj/Q6eZVypZsCwb
wEVy0Dy9LUjHH8n0YfAVNXOjFdguZpzG5p6TQA6mzrrVPqSlQ4LO1FVyI/bvmAw7
xGmwLEQfMzf4uXtupEZeZH/X5JLkVqVX03nxjT3qs4SEMWiYe3J31AIy0wAm5gpO
hL+c/J3aiRdJnB59lDVbFhr4lZx3gxKiQ3HTSx/GymYYUy0s0arLqmmSn/50TRNX
UVrDbQWTXDu6z/LEo2AYRLiOzgVh/cVpb3taHalskS2rumQUO84JdzLbEF46iqAH
DD6xt8Qo31l7rLyS7zMC
=4uOv
-----END PGP SIGNATURE-----

--NYEbmNmPHBKnRu7s81gJEZlYf8ulhXisU--
