Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:39276 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728164AbgDCNDZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Apr 2020 09:03:25 -0400
Received: from pps.filterd (m0187473.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 033CWw0W134425
        for <linux-s390@vger.kernel.org>; Fri, 3 Apr 2020 09:03:24 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 304r51nqe7-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 03 Apr 2020 09:03:21 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Fri, 3 Apr 2020 14:02:56 +0100
Subject: Re: [PATCH v1 5/5] KVM: s390: vsie: gmap_table_walk() simplifications
References: <20200402184819.34215-1-david@redhat.com>
 <20200402184819.34215-6-david@redhat.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Fri, 3 Apr 2020 15:03:04 +0200
MIME-Version: 1.0
In-Reply-To: <20200402184819.34215-6-david@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="VlNIpXV7boDOQ3LRBC6v8WVFkTOdQwvN5"
Message-Id: <99c824d1-88ca-c98d-c4e9-75a97c2a8a7b@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Hildenbrand <david@redhat.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Cornelia Huck <cohuck@redhat.com>, Christian Borntraeger <borntraeger@de.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VlNIpXV7boDOQ3LRBC6v8WVFkTOdQwvN5
Content-Type: multipart/mixed; boundary="USmy0Wzc73PZu5yOZsW92xu6k5FR7HGDU"

--USmy0Wzc73PZu5yOZsW92xu6k5FR7HGDU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 4/2/20 8:48 PM, David Hildenbrand wrote:
> Let's use asce_type where applicable. Also, simplify our sanity check f=
or
> valid table levels and convert it into a WARN_ON_ONCE(). Check if we ev=
en
> have a valid gmap shadow as the very first step.
>=20
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  arch/s390/mm/gmap.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
> index fd32ab566f57..3c801dae7988 100644
> --- a/arch/s390/mm/gmap.c
> +++ b/arch/s390/mm/gmap.c
> @@ -790,17 +790,18 @@ static inline unsigned long *gmap_table_walk(stru=
ct gmap *gmap,
>  	const int asce_type =3D gmap->asce & _ASCE_TYPE_MASK;
>  	unsigned long *table;
> =20
> -	if ((gmap->asce & _ASCE_TYPE_MASK) + 4 < (level * 4))
> -		return NULL;
>  	if (gmap_is_shadow(gmap) && gmap->removed)
>  		return NULL;
> =20
> +	if (WARN_ON_ONCE(level > (asce_type >> 2) + 1))
> +		return NULL;
> +
>  	if (WARN_ON_ONCE(asce_type !=3D _ASCE_TYPE_REGION1) &&
>  			 gaddr & (-1UL << (31 + (asce_type >> 2) * 11)))
>  		return NULL;
> =20
>  	table =3D gmap->table;

We could also initialize this variable at the top, no?

> -	switch (gmap->asce & _ASCE_TYPE_MASK) {
> +	switch (asce_type) {
>  	case _ASCE_TYPE_REGION1:
>  		table +=3D (gaddr & _REGION1_INDEX) >> _REGION1_SHIFT;
>  		if (level =3D=3D 4)
>=20



--USmy0Wzc73PZu5yOZsW92xu6k5FR7HGDU--

--VlNIpXV7boDOQ3LRBC6v8WVFkTOdQwvN5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6HNAgACgkQ41TmuOI4
ufj06BAAqPVN3ay5tibFacZICN2+AtixZeGC9aBiEXKkIPbn3vJLKfuxqGEJIAqR
sa83dUYL4lYbsvOOC0UGTVDX9/ZcDIB1WIMOG6drCQO2TnOnwSs+u2RiIKnPUdTO
q1nKtOWfSf2nHGHiIDozvnI2/ggdu0+VRx911rsbU51K07CSYStbransnkYwnlk/
CLf5axqBAHm+yIIuZUXB+5GZ2DOwyNt1ALnq/2YPG1ekqsq6WEAAR2bsJ5zubipg
6EtV0sN8ABBhnbAocbs/gDgc9siZOkL63UtuEJStsj1ADUp/2h9Dmoj8+NjXDoLQ
zDwJbg6xVovcH6v3vG1E+msXr7kZpX4I4BQ6lXXWwJav1ilGfBqRMuouaXHb2jR6
kwdRP16ekDsQSer35ahYJQqSjw5UDhYbhLNCdauXtgSBLXF+h8VMzMmEU4dyb3pS
UAcZLq/wPPtQ+s2eI79XEaMkAopkKkhlhntukJptLKx2e5Av3+kS1lT2fW/64zBi
mRs1E0Os8ATZNBmykyOR2n6l3fyBqWgOfoApWXFtf/VwlbIQofE3uKcSjFizOAPo
IRbFuMEbHLKxra2XfI7u8rWbzEDsC93txiPO9+YWl96xSsAKucRv8sl+l1gp3Oe7
1ROLm6bU2r9PG2vqZsG77evtwJwVixhYxQJDj8muar8dJzOW0RA=
=Lk4v
-----END PGP SIGNATURE-----

--VlNIpXV7boDOQ3LRBC6v8WVFkTOdQwvN5--
