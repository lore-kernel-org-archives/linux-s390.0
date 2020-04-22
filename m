Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:64228 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726359AbgDVHjL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:11 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M7WRp8095399
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:39:10 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gg28p4eu-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:39:09 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Apr 2020 08:38:22 +0100
Subject: Re: [kvm-unit-tests PATCH v5 03/10] s390x: cr0: adding AFP-register
 control bit
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Apr 2020 09:39:03 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GyifXTZlsyM8ZIgho0Vn086lt06WUgA3h"
Message-Id: <a40f5061-e261-a6dd-ea6a-a8bec703175f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GyifXTZlsyM8ZIgho0Vn086lt06WUgA3h
Content-Type: multipart/mixed; boundary="EOWPvNTSl0Qrmj66m9JdSexUHJqGIhPYD"

--EOWPvNTSl0Qrmj66m9JdSexUHJqGIhPYD
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 1:00 PM, Pierre Morel wrote:
> While adding the definition for the AFP-Register control bit, move all
> existing definitions for CR0 out of the C zone to the assmbler zone to
> keep the definitions concerning CR0 together.

How about:
s390x: Move control register bit definitions and add AFP to them

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 11 ++++++-----
>  s390x/cstart64.S         |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 69a8256..863c2bf 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -18,6 +18,12 @@
> =20
>  #define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
> =20
> +#define CR0_EXTM_SCLP			0X0000000000000200UL
> +#define CR0_EXTM_EXTC			0X0000000000002000UL
> +#define CR0_EXTM_EMGC			0X0000000000004000UL
> +#define CR0_EXTM_MASK			0X0000000000006200UL
> +#define CR0_AFP_REG_CRTL		0x0000000000040000UL
> +
>  #ifndef __ASSEMBLER__
> =20
>  struct psw {
> @@ -25,11 +31,6 @@ struct psw {
>  	uint64_t	addr;
>  };
> =20
> -#define CR0_EXTM_SCLP			0X0000000000000200UL
> -#define CR0_EXTM_EXTC			0X0000000000002000UL
> -#define CR0_EXTM_EMGC			0X0000000000004000UL
> -#define CR0_EXTM_MASK			0X0000000000006200UL
> -
>  struct lowcore {
>  	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
>  	uint32_t	ext_int_param;			/* 0x0080 */
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 2885a36..3b59bd1 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -230,4 +230,4 @@ svc_int_psw:
>  	.quad	PSW_EXCEPTION_MASK, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used *=
/
> -	.quad	0x0000000000040000
> +	.quad	CR0_AFP_REG_CRTL
>=20



--EOWPvNTSl0Qrmj66m9JdSexUHJqGIhPYD--

--GyifXTZlsyM8ZIgho0Vn086lt06WUgA3h
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6f9JcACgkQ41TmuOI4
ufil/w//dbqGIM2HaV4WaUalhvxm/YfYG2jKvebHmD68d6wGgTEDx2mIkNR1jPlx
Rzz36pOnADQIXizEqwWNVbdK4gI2r+DlnPY88sJckv6JiiOqsZyPKyYc36asIArV
HKzHRYWIZBLC52VC2f1EopSXob7z/JlHFa6V4K+MCDdOBlWsMZIH1jgt0jVMLFU+
aWQMNZBeIZWZ2GsylmRxrZkIVLv3Z3Kx38hgpq/QIECTPn2zmT5spKbjPcZP2RVw
VNYI5T1gq7a/NTDIAVtr8+05LOGJ7jvhORMT6Z6MRG3XgyWNCBTV/WTppNsDX/ur
fWd7dn/ZnaOvQxPtfAOBh/sDtCxh9NvXnmip6238EecLcvFjGxKkJblQpYcSGoM4
aMVG3M6HWeQxAPTaZuRIKK442+kPtfl1u8ZWIe8jLc0BUn3cbFSWn0yzBYTzCaVG
3c50r7Szmz2RfjzxwEa0X4VcCCuvCXfSwvZX3qTWh8HrC2odS2C3gaGWTOm3Aax3
CRwQA3RTaGtKaMyoOCWRy7IosyQjXtbEOcUXJCqpESTLLV2/ls2CM8u0D1hhmfwD
2bPZzU4Z1iCtTdoPWnrsg/iUGmbLbcmR6Okip22WdUPHpm8kxYkWd8f+2eSY1z7Z
o+s0jTFv9ZbHr7KL/qF3MEOhqgtIy3rQmxHpPgWtuhGL8zAASVk=
=8jsV
-----END PGP SIGNATURE-----

--GyifXTZlsyM8ZIgho0Vn086lt06WUgA3h--
