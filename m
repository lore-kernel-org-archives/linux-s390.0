Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:7464 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727691AbgBKILs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 11 Feb 2020 03:11:48 -0500
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 01B89IJq080362
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 03:11:46 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2y1u2ep740-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Tue, 11 Feb 2020 03:11:46 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Tue, 11 Feb 2020 08:11:44 -0000
Subject: Re: [PATCH 1/1] s390/uv: Fix handling of length extensions
References: <20200210165439.3767-1-borntraeger@de.ibm.com>
 <20200210165439.3767-2-borntraeger@de.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Tue, 11 Feb 2020 09:11:38 +0100
MIME-Version: 1.0
In-Reply-To: <20200210165439.3767-2-borntraeger@de.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Z4gnDdExIfm1ctY5lzGbaREVqpMbTqGBv"
Message-Id: <fcbabb59-8998-4a31-e33b-8f5a784d37d9@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Christian Borntraeger <borntraeger@de.ibm.com>, Janosch Frank <frankja@linux.vnet.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Cornelia Huck <cohuck@redhat.com>, David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Z4gnDdExIfm1ctY5lzGbaREVqpMbTqGBv
Content-Type: multipart/mixed; boundary="gwrvUg0xYouSuXVh5SWvFQuDaNvVPTAtG"

--gwrvUg0xYouSuXVh5SWvFQuDaNvVPTAtG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/10/20 5:54 PM, Christian Borntraeger wrote:
> The query parameter block might contain additional information and can
> be extended in the future. If the size of the block does not suffice we=

> get an error code of rc=3D0x100.  The buffer will contain all informati=
on
> up to the specified size and the hypervisor/guest simply do not need th=
e
> additional information as they do not know about the new data.  That
                                                                ^

> means that we can (and must) accept rc=3D0x100 as success.

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

>=20
> Cc: stable@vger.kernel.org
> Fixes: 5abb9351dfd9 ("s390/uv: introduce guest side ultravisor code")
> Signed-off-by: Christian Borntraeger <borntraeger@de.ibm.com>
> ---
>  arch/s390/boot/uv.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/boot/uv.c b/arch/s390/boot/uv.c
> index af9e1cc93c68..c003593664cd 100644
> --- a/arch/s390/boot/uv.c
> +++ b/arch/s390/boot/uv.c
> @@ -21,7 +21,7 @@ void uv_query_info(void)
>  	if (!test_facility(158))
>  		return;
>=20
> -	if (uv_call(0, (uint64_t)&uvcb))
> +	if (uv_call(0, (uint64_t)&uvcb) && uvcb.header.rc !=3D 0x100)
>  		return;
>=20
>  	if (IS_ENABLED(CONFIG_KVM)) {
>=20



--gwrvUg0xYouSuXVh5SWvFQuDaNvVPTAtG--

--Z4gnDdExIfm1ctY5lzGbaREVqpMbTqGBv
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl5CYboACgkQ41TmuOI4
ufgdNw/8DQxKvIskLhq8f1BRwDkkd3dtwlhmF2LP9sE0m56Z1vZe+l1e/ize01LD
6NHtPoVZdVNwjS+/PafoGKACepP5X6ahGl2FquHvrvqYkgHRea6cZBn+gHQ+3Tmu
3dhfUHWSrp5UlirsFkLqLm8wu32v21FFi9fihmwnfL+i6qj8sEJUKJ7BPK8gX/t1
BY19T8rlbR1dZszyC1CzykchxzsYCKGyhG+r4tyZHU4sdt2FaPG1xY8mF7HWFkWF
CKuutDYtPHg6jOEDhls1ZkqdOfhegv6sUpx7hUtJYVSmpyXzCYlmzRekzHjAdAhL
u/fpdt7xKXwxznDJJ9uwCAM1Tywp0nB9c+8peUTx3idO1HlEVEcJW60ObIySWMht
76sPM1Cq4xjG6ix8URf6l2aPLRow+i8WDTVuIFHzUmgpVZwwmNZS++5obtfgKdJf
lSDzFcxT7CxrEWsmQDYCcUZhJVkNGfrE3vmIGJTJ8tjd4Aupds0B0UgYxbkfvZhq
SbDLWHobJ9lb+JigwLGRL30AC17297c7VllKcRxwmNKkiMRomSvcUVbOYRxmnR1V
OgFqc81v8/mzdyyUZncVUWeLv3lQK85tqqj2j9qh1vOqcqrzx9w0JYy8ZGkq0uHJ
LCBW1T9e4+5uebwFp8C3IpfrQEnB+f8nFgNoFMcaLMrqXYPsm8w=
=A6AE
-----END PGP SIGNATURE-----

--Z4gnDdExIfm1ctY5lzGbaREVqpMbTqGBv--
