Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4574 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2390908AbgDCNmA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 09:42:00 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033DXY4s053997
        for <linux-s390@vger.kernel.org>; Fri, 3 Apr 2020 09:41:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0b-001b2d01.pphosted.com with ESMTP id 302072kuau-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2020 09:41:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 3 Apr 2020 14:41:55 +0100
Subject: Re: [PATCH v1 1/5] KVM: s390: vsie: Fix region 1 ASCE sanity shadow
 address checks
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-2-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 3 Apr 2020 15:41:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200402184819.34215-2-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VuYuhIihgc8kXyA392z7lxVZk0JYHRnZj"
Message-Id: <58888143-f27c-58e6-715e-41ff89ab6160@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>, stable@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VuYuhIihgc8kXyA392z7lxVZk0JYHRnZj
Content-Type: multipart/mixed; boundary="Vk5zZruvRNvPPgLPZS6eZqzObLnkFIpxv"

--Vk5zZruvRNvPPgLPZS6eZqzObLnkFIpxv
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/2/20 8:48 PM, David Hildenbrand wrote:
> In case we have a region 1 ASCE, our shadow/g3 address can have any val=
ue.
> Unfortunately, (-1UL << 64) is undefined and triggers sometimes,
> rejecting valid shadow addresses when trying to walk our shadow table
> hierarchy.
>=20
> The result is that the prefix cannot get mapped and will loop basically=

> forever trying to map it (-EAGAIN loop).
>=20
> After all, the broken check is only a sanity check, our table shadowing=

> code in kvm_s390_shadow_tables() already checks these conditions, injec=
ting
> proper translation exceptions. Turn it into a WARN_ON_ONCE().
>=20
> Fixes: 4be130a08420 ("s390/mm: add shadow gmap support")
> Cc: <stable@vger.kernel.org> # v4.8+
> Reported-by: Janosch Frank <frankja@linux.ibm.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

With the WARN_ON_ONCE fix applied I don't run into stalls or warnings
anymore, so:
Tested-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  arch/s390/mm/gmap.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index 2fbece47ef6f..f3dbc5bdde50 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -787,14 +787,18 @@ static void gmap_call_notifier(struct gmap *gmap,=
 unsigned long start,
>  static inline unsigned long *gmap_table_walk(struct gmap *gmap,
>  					     unsigned long gaddr, int level)
>  {
> +	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
>  	unsigned long *table;
> =20
>  	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
>  		return NULL;
>  	if (gmap_is_shadow(gmap) && gmap->removed)
>  		return NULL;
> -	if (gaddr & (-1UL << (31 + ((gmap->asce & _ASCE_TYPE_MASK) >> 2)*11))=
)
> +
> +	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
> +			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
>  		return NULL;
> +
>  	table =3D gmap->table;
>  	switch (gmap->asce & _ASCE_TYPE_MASK) {
>  	case _ASCE_TYPE_REGION1:
>=20



--Vk5zZruvRNvPPgLPZS6eZqzObLnkFIpxv--

--VuYuhIihgc8kXyA392z7lxVZk0JYHRnZj
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6HPR8ACgkQ41TmuOI4
ufgb+RAAsxZfc7kuWec9oOuipxBnN6zTyl3YsseJhgREuvN4gfSxNKUBszxkzDe+
AkHIrRmYTssGVaixZUec+N/x/rxOh7jIdWwTpHnQGWZNZoCHKTcFtbWGqgBQbnRY
QSUhg8i+Xw+OYtvnt+54Qo2AUThNlUxF8xUVfz//Rj3Vc55DZ/T/4StxLg8aAVg3
10YXv9/uuH2wBhQ2xZUwR6OTCcArA7ewTJx+ntjjawxY0BovxpWPdSc3AkErgXed
lYB22XVCpe4SsbTLLvJLb0Tvr9lhuuPQZ6qU5iN+4Huh3ioZsMYEsC7Td/U+yCUG
FGVKKdToeglKVV7A5vA8iHBzQRQ7Tx10jeSR8hBWSQcYNNG3MWEFy5YxAvwAAOTZ
6SdXqz7lAcYhok44oexhpGV3Ccdq/orALKfeAZlqY1NLNyDqg+/9vVzSufF9ghfo
PbRtHyjgw2hJUXGPLvP/cz22pIZ4wM2g7/0SP2QskUBqy4EZALeVXHeXEW0CEgK0
V6rVojM/leoYaRqoxCD7VIv73xda3Zp6PMVAj3UNUfj8wQXh24VYEDnEe7ePJ6HX
NW6nLxJnGYCRbAqpHP68VIYIy/BbS3YcgewMhcCH4Kpt19z1W5bAFFDGjXovBP1E
m5AOfXT4s/E0nh6wtpGud43sjagTxQIoiUL77KS0V7+LkaqnLT4=
=wb7M
-----END PGP SIGNATURE-----

--VuYuhIihgc8kXyA392z7lxVZk0JYHRnZj--
