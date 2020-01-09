Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:60242 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388250AbgAIRom (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 9 Jan 2020 12:44:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 009Hc9tM002819
        for <linux-s390@vger.kernel.org>; Thu, 9 Jan 2020 12:44:41 -0500
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2xe3j8wvcx-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 09 Jan 2020 12:44:40 -0500
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 9 Jan 2020 17:44:39 -0000
Subject: Re: [kvm-unit-tests PATCH v6 4/4] s390x: SCLP unit test
References: <20200109161625.154894-1-imbrenda@linux.ibm.com>
 <20200109161625.154894-5-imbrenda@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 9 Jan 2020 18:44:34 +0100
MIME-Version: 1.0
In-Reply-To: <20200109161625.154894-5-imbrenda@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="fAI7TKjL7K3tSxWoEJy3v5xsb8Uxl1EQN"
Message-Id: <9d57b1b1-155f-8f30-0a32-3540492a8c86@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com, borntraeger@de.ibm.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--fAI7TKjL7K3tSxWoEJy3v5xsb8Uxl1EQN
Content-Type: multipart/mixed; boundary="ZXR0z3ljfoIIpDxXRZfWSYvvwFW344a7r"

--ZXR0z3ljfoIIpDxXRZfWSYvvwFW344a7r
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 1/9/20 5:16 PM, Claudio Imbrenda wrote:
> SCLP unit test. Testing the following:
>=20
> * Correctly ignoring instruction bits that should be ignored
> * Privileged instruction check
> * Check for addressing exceptions
> * Specification exceptions:
>   - SCCB size less than 8
>   - SCCB unaligned
>   - SCCB overlaps prefix or lowcore
>   - SCCB address higher than 2GB
> * Return codes for
>   - Invalid command
>   - SCCB too short (but at least 8)
>   - SCCB page boundary violation
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

I wonder how fast this will run under z/VM and if we need to increase
the timeout.
Nicely done, one comment below.

Acked-by: Janosch Frank <frankja@linux.ibm.com>


Tested under LPAR, KVM and PV

> ---
>  s390x/Makefile      |   1 +
>  s390x/sclp.c        | 472 ++++++++++++++++++++++++++++++++++++++++++++=

>  s390x/unittests.cfg |   8 +
>  3 files changed, 481 insertions(+)
>  create mode 100644 s390x/sclp.c
[..]
> +/**
> + * Test SCCBs that are not 64-bit aligned.
> + */
> +static void test_sccb_unaligned(void)
> +{
> +	int offset;
> +
> +	for (offset =3D 1; offset < 8; offset++)
> +		if (!test_one_simple(valid_code, offset + pagebuf, 8, 8, PGM_BIT_SPE=
C, 0))
> +			break;
> +	report(offset =3D=3D 8, "SCCB unaligned");
> +}
> +
> +/**
> + * Test SCCBs whose address is in the lowcore or prefix area.
> + */
> +static void test_sccb_prefix(void)
> +{
> +	uint8_t scratch[2 * PAGE_SIZE];

LC_SIZE?
Can also be used in more places below.


--ZXR0z3ljfoIIpDxXRZfWSYvvwFW344a7r--

--fAI7TKjL7K3tSxWoEJy3v5xsb8Uxl1EQN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl4XZoIACgkQ41TmuOI4
ufgo1g/9GZRjyKWDC7KsAJBoClnutyU629/D4wBERtw1AUKkEWQJqUc2IBYa6hdb
2oc8GP35iPr7eIk5W08gXRGtKRo37YZnemilCib+Xw606fwB8Z2w6ENqwuYkcfYY
fxgtG1uUc7hTVbsmmUmWRLkkD1f+Ik1rusyjpKPpq7NxmSsN6BYQHjDD2/1auFq/
aSrx7++GvNPwJo84Ljw42taTkCJ33jXEEsx6w7q6HHUc6XW3qV12pIdBK5q3lLqe
CBz0UcOicK+0z/uDJ9GFPgmvMBR8Uc8mCeCKTg+fIlE1Qtru//Y4gMTFYg2QToAH
nQc5R3f7g7hpPwYs8VzKlLPiBH5Gi1j4IPEdauzL9DfBMVHOvIKXRyssNFI4PkN8
ctNHGPmSMB/9tsNEwIkPCi5tdlkevlSdfzWfbmJJqnFrmRm2Qa9vGcfc6IQ//222
cQvrKyHR7Dyu7DhO/V7A2OWQec8B1LAW5QQXHHyV0ILMvaMoeMT+Op3lVgre8K/v
IYyl2LCCRXEkterTRfhs16Z3/T4v5SApwLSIskTS/vgFef3tZ0tgU0O9q7zJf1wY
bL7CVoFab+DJTwWNzHMKSxWWPn243SDI7omSaQlYACiwkyxrCa6uyypgXd3OtNUK
2u81gqOkBfTJ4ns4fn/V9h8oH0kagNeCoEVdDIa0sgQLg+9UNHY=
=1kx/
-----END PGP SIGNATURE-----

--fAI7TKjL7K3tSxWoEJy3v5xsb8Uxl1EQN--
