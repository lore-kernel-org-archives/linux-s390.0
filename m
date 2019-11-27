Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:42000 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726576AbfK0SCE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 27 Nov 2019 13:02:04 -0500
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xARHq7xb154271
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:02:02 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2whcxpmed5-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 27 Nov 2019 13:02:02 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 27 Nov 2019 18:02:00 -0000
Subject: Re: [kvm-unit-tests PATCH v4 1/3] s390x: export sclp_setup_int
References: <1574157219-22052-1-git-send-email-imbrenda@linux.ibm.com>
 <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 27 Nov 2019 19:01:55 +0100
MIME-Version: 1.0
In-Reply-To: <1574157219-22052-2-git-send-email-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="pInQUD3OJ8iYmPnKMZddE2f6kLzyHVQV7"
Message-Id: <6b598de6-3f9b-d62d-9a5b-3eab933d687f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pInQUD3OJ8iYmPnKMZddE2f6kLzyHVQV7
Content-Type: multipart/mixed; boundary="cgXEdsFpStbPBxUNlNXLrtPd91mg6Rzzb"

--cgXEdsFpStbPBxUNlNXLrtPd91mg6Rzzb
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/19/19 10:53 AM, Claudio Imbrenda wrote:
> Export sclp_setup_int() so that it can be used from outside.

=2E.. so that it can be used in tests / outside of lib/s390x/sclp.c

Choose one

>=20
> Needed for an upocoming unit test.

upocoming?

>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
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



--cgXEdsFpStbPBxUNlNXLrtPd91mg6Rzzb--

--pInQUD3OJ8iYmPnKMZddE2f6kLzyHVQV7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIyBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3euhQACgkQ41TmuOI4
ufiUlw/2PdxcLZWb2mpm8B/elWnBVYnlr3vDxdjEQU8rk+i//AoAe1F0rHiTMkg8
zdLynRVMBdgzcSwviO0xlVSTlmvMdSZgCjQ6dOKsVf3Nqc5Yb3wGZIhUkUs7p9+s
S88LNZ4MmQJNmPkz8Mf5nF7S8qVyIiAtUwQ0ZAJbX4pliwdJI+bU+EKFL/5PXFaT
6bp/OkIc+QRYOeCL2YgODJaWVuIAeMpNDANWMLb0qxDmbWyiFVjoGj3iEFDLpOBX
MIdY85HA/JEtW2KwCenzwNfz8dVI4iSImtH765I2wkW1MRSWnrUS8Z/uj3SW77qc
faPvGbWqhmKCbw+buOsL7sOQIxCrsdAl6mq7w4x81G7Cd3PnB64yO1dNQTlo7cm4
uSo4+Mfij9pgQwRx2GjYK6boD+I5FlLd+TR+XQzKgHqPYav7YPJ9VMDvRcsH+JIE
bN16bQYYwLoqXrz/uN3/OY0ZOZ1jg3/LnAFcoKOv/yzvsbxg+75b7d3nV6u1mp4y
xpU2xBd7tAaUxxDxzhZgl/3a6EXgAGwzxGLFi995cBoR6b5DxTwHiggCj8gXIgkk
y5XfICeC3Az6q/chW0ZBk+PaSzpBAO8QQHYtcxUlVvvdD0zdoyzpPP3fks98tGRp
K26+3Z2jhGSqcv/lfDrXtvNFGeNtxrYuKMjQjY7uM6wh9I8AgA==
=Xoxw
-----END PGP SIGNATURE-----

--pInQUD3OJ8iYmPnKMZddE2f6kLzyHVQV7--
