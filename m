Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:59684 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725786AbgDVHfg (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 03:35:36 -0400
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M7XLfI004483
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:35:35 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 30gc2y0vp4-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:35:35 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Apr 2020 08:34:48 +0100
Subject: Re: [kvm-unit-tests PATCH v5 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Apr 2020 09:35:27 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="wr1b1unh9tYkGTawBfVC3YX3iv2NVBeGV"
Message-Id: <aae40a5a-63a6-e802-53bb-9683d03ad57d@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--wr1b1unh9tYkGTawBfVC3YX3iv2NVBeGV
Content-Type: multipart/mixed; boundary="wJeMg9qX91ouO8XFKRiSqYHBRhQH46whj"

--wJeMg9qX91ouO8XFKRiSqYHBRhQH46whj
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 1:00 PM, Pierre Morel wrote:
> This patch defines the PSW bits EA/BA used to initialize the PSW masks
> for exceptions.
>=20
> Since some PSW mask definitions exist already in arch_def.h we add thes=
e
> definitions there.
> We move all PSW definitions together and protect assembler code against=

> C syntax.

Please fix the issue mentioned below and run *all* tests against your
new code to verify you didn't introduce regressions.

The rest looks good to me.

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 15 +++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49..69a8256 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,21 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> =20
> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)

Could you add a space before and after the | ?

> +
> +#ifndef __ASSEMBLER__
> +
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
> =20
> -#define PSW_MASK_EXT			0x0100000000000000UL
> -#define PSW_MASK_DAT			0x0400000000000000UL
> -#define PSW_MASK_PSTATE			0x0001000000000000UL
> -
>  #define CR0_EXTM_SCLP			0X0000000000000200UL
>  #define CR0_EXTM_EXTC			0X0000000000002000UL
>  #define CR0_EXTM_EMGC			0X0000000000004000UL
> @@ -297,4 +303,5 @@ static inline uint32_t get_prefix(void)
>  	return current_prefix;
>  }
> =20
> +#endif /* not __ASSEMBLER__ */
>  #endif
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 45da523..2885a36 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -12,6 +12,7 @@
>   */
>  #include <asm/asm-offsets.h>
>  #include <asm/sigp.h>
> +#include <asm/arch_def.h>
> =20
>  .section .init
> =20
> @@ -214,19 +215,19 @@ svc_int:
> =20
>  	.align	8
>  reset_psw:
> -	.quad	0x0008000180000000
> +	.quad	PSW_EXCEPTION_MASK

That won't work, this is a short PSW and you're removing the short
indication here. Notice the 0008 at the front.

>  initial_psw:
> -	.quad	0x0000000180000000, clear_bss_start
> +	.quad	PSW_EXCEPTION_MASK, clear_bss_start
>  pgm_int_psw:
> -	.quad	0x0000000180000000, pgm_int
> +	.quad	PSW_EXCEPTION_MASK, pgm_int
>  ext_int_psw:
> -	.quad	0x0000000180000000, ext_int
> +	.quad	PSW_EXCEPTION_MASK, ext_int
>  mcck_int_psw:
> -	.quad	0x0000000180000000, mcck_int
> +	.quad	PSW_EXCEPTION_MASK, mcck_int
>  io_int_psw:
> -	.quad	0x0000000180000000, io_int
> +	.quad	PSW_EXCEPTION_MASK, io_int
>  svc_int_psw:
> -	.quad	0x0000000180000000, svc_int
> +	.quad	PSW_EXCEPTION_MASK, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used *=
/
>  	.quad	0x0000000000040000
>=20



--wJeMg9qX91ouO8XFKRiSqYHBRhQH46whj--

--wr1b1unh9tYkGTawBfVC3YX3iv2NVBeGV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6f88AACgkQ41TmuOI4
ufhgmw//dfVHl30+2+dqnfVvNWWFohwErw313kmwGAx8TkQon9G0oI6mgk2c5X2l
FmAQXUUxPcL67YatmPQhK1l2npyKLon3/zF+vz9i4wIq3tMApfuVIRETclt15uB5
Gpj8IiuyND1r4rISn66kMEsDORAnxNnrz6ONAXWdGg9agEtetkmeh8vzORzBj3+c
2RzD75kUc//GtejD3ZIqq7ZRZ6GGDJUR2gqzXZEhnFl35i9RgcjJMP7oUopnkTdQ
13iZBms4QUPpZgR2gimjP8MYrtTCGPUCz9aJ97J5DE03t8PdCgCwsqzPbgmH5q6j
pkdVzet53P9EWfSzFIg7r7cMrVWHi2PLuntkej7fnlfhIq37LBnLeZLLKVOCo7Mu
lJC+dsxYVG0hzjqBchIGQiHd/UJoDhoh2NVwb2dcXmukd1sUPMYru6vCof/QlKV6
g43kPxpNaHXPnF4w13arET3osh04afYdVfMeWsuSq3tGVsZk636zTAy+dG5S5y0B
SUvcnXQmLHIVsZV4+qPgltZEhYVAIA9+XcdF6HFNaLs988pYEIixQ7K29Bgk3Ni4
RtSGWPDvVSDYGzRQpkCifq9fC+a8u5UEcn391wuREUDebWxk1p24YcBPoCKFEWJn
Lx70275it8LNdQn0So2deQAMGt6j93+W6YEZX/TkJZ4UCPqw9K0=
=Wx9o
-----END PGP SIGNATURE-----

--wr1b1unh9tYkGTawBfVC3YX3iv2NVBeGV--
