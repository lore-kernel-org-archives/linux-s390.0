Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:4442 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726655AbfK0SAm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 13:00:42 -0500
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARHq7ax080508
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:00:40 -0500
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2whcy82tra-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:00:40 -0500
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 27 Nov 2019 18:00:38 -0000
Subject: Re: [kvm-unit-tests PATCH v4 1/3] s390x: export sclp_setup_int
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
 <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 27 Nov 2019 19:00:34 +0100
MIME-Version: 1.0
In-Reply-To: <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="PDw2QwgBndjmlxTfLSna3B8sH13zrk7CN"
Message-Id: <c7f564db-0594-141c-6531-3ba21b6d3a8d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PDw2QwgBndjmlxTfLSna3B8sH13zrk7CN
Content-Type: multipart/mixed; boundary="sjzrViNbKoeSphFWOTOiUfp2HT2z7dv2H"

--sjzrViNbKoeSphFWOTOiUfp2HT2z7dv2H
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/19 10:53 AM, Claudio Imbrenda wrote:
> Export sclp_setup_int() so that it can be used from outside.
>=20
> Needed for an upocoming unit test.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  lib/s390x/sclp.h | 1 +
>  lib/s390x/sclp.c | 2 +-
>  2 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/lib/s390x/sclp.h b/lib/s390x/sclp.h
> index 6d40fb7..675f07e 100644
> --- a/lib/s390x/sclp.h
> +++ b/lib/s390x/sclp.h
> @@ -265,6 +265,7 @@ typedef struct ReadEventData {
>  } __attribute__((packed)) ReadEventData;
> =20
>  extern char _sccb[];
> +void sclp_setup_int(void);
>  void sclp_handle_ext(void);
>  void sclp_wait_busy(void);
>  void sclp_mark_busy(void);
> diff --git a/lib/s390x/sclp.c b/lib/s390x/sclp.c
> index 7798f04..123b639 100644
> --- a/lib/s390x/sclp.c
> +++ b/lib/s390x/sclp.c
> @@ -45,7 +45,7 @@ static void mem_init(phys_addr_t mem_end)
>  	page_alloc_ops_enable();
>  }
> =20
> -static void sclp_setup_int(void)
> +void sclp_setup_int(void)
>  {
>  	uint64_t mask;
> =20
>=20



--sjzrViNbKoeSphFWOTOiUfp2HT2z7dv2H--

--PDw2QwgBndjmlxTfLSna3B8sH13zrk7CN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3eucMACgkQ41TmuOI4
ufjGEw/9Fh3deGzKlwLMhI7HbwifL9nrMCwepU1/flPu37a4BtLPURrw7jJDjUPz
zv5Xh8h/wkn6TYO/VFYKBx2tI5p2WWYwyja6GQJRuSftyfqdP0CsOsCkQYlZQ7qm
pHtcbh+6xkGkmEaQ+pDfV6Mf3iNWabUh4dkPeOxEL+Ribpz4DomcGWR9i8k4jcuW
HcIz2DrwKXuZtySuYNNRGnYpwlxemDtqUgsfhpOXf707WEdB3bzTt75cYh4P0Cqt
ikjKvwaNy/x0NT2Sd9RaWFqrMeGWq5PhTWwmVSVjcYyeqF76HRDtqZRf39tFJq5q
h/iSMP/njpWQJXws3ne5kD2sJAPXQJf1oOQjwYwq8ztqWfawRW5Vf63EMRam3Flx
WydLdxkC+Dq9rFKIM+Cg+PHjtQY6Fj3W51dgk+yF2tv7RYakugDIUnb+CuqIvtGK
Pf0iDvul9QHxqK36f2jcq4NEvnIyrcvs1WZveQMK6ad2Mur3xwh66YY88E7dtxLl
LU/zTDlq6Eo2lZaV1jV8f5VZpYntKzkXSQQxQCDPkDF0rF0DAr3m9tOmB9slTkjY
bsuQPJvGFhUlFy2svy+LAsgC+2CGYPFbj2GP+NGJAB5SD0lwMhA/AxxTbGXQQ2qh
qcJj/F98QjEivk6xrB1uQWV1t9Ehk89IBDDxXHq3+WvCyYeR54s=
=UPTL
-----END PGP SIGNATURE-----

--PDw2QwgBndjmlxTfLSna3B8sH13zrk7CN--
