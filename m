Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2706 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbfKMQHU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 11:07:20 -0500
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADG6lZJ095230
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 11:07:19 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w8kbgdg1y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 11:07:13 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 16:05:47 -0000
Subject: Re: [PATCH v1 2/4] s390x: Define the PSW bits
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 13 Nov 2019 17:05:44 +0100
MIME-Version: 1.0
In-Reply-To: <1573647799-30584-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="r6LilpwTr9TbDNSPSWL1oDoptgo0xTTfp"
Message-Id: <5796f620-7ee6-6333-e4f4-5e904284a331@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--r6LilpwTr9TbDNSPSWL1oDoptgo0xTTfp
Content-Type: multipart/mixed; boundary="OsN9bhzKnYOUfx87CoQ2XbRQNiXBPd6wW"

--OsN9bhzKnYOUfx87CoQ2XbRQNiXBPd6wW
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/13/19 1:23 PM, Pierre Morel wrote:
> Instead of assigning obfuscated masks to the PSW dedicated to the
> exceptions, let's define the masks explicitely, it will clarify the

s/explicitely/explicitly/
Try to break that up into sentences.

> usage.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_bits.h | 32 ++++++++++++++++++++++++++++++++
>  lib/s390x/asm/arch_def.h  |  6 ++----
>  s390x/cstart64.S          | 13 +++++++------
>  3 files changed, 41 insertions(+), 10 deletions(-)
>  create mode 100644 lib/s390x/asm/arch_bits.h
>=20
> diff --git a/lib/s390x/asm/arch_bits.h b/lib/s390x/asm/arch_bits.h
> new file mode 100644
> index 0000000..0521125
> --- /dev/null
> +++ b/lib/s390x/asm/arch_bits.h
> @@ -0,0 +1,32 @@
> +
> +/*
> + * Copyright (c) 2019 IBM Corp
> + *
> + * Authors:
> + *  Pierre Morel <pmorel@linux.ibm.com>
> + *
> + * This code is free software; you can redistribute it and/or modify i=
t
> + * under the terms of the GNU Library General Public License version 2=
=2E
> + */
> +#ifndef _ASM_S390X_ARCH_BITS_H_
> +#define _ASM_S390X_ARCH_BITS_H_
> +
> +#define PSW_MASK_PER		0x4000000000000000
> +#define PSW_MASK_DAT		0x0400000000000000
> +#define PSW_MASK_IO		0x0200000000000000
> +#define PSW_MASK_EXT		0x0100000000000000
> +#define PSW_MASK_BASE		0x0000000000000000
> +#define PSW_MASK_KEY		0x00F0000000000000
> +#define PSW_MASK_MCHECK		0x0004000000000000
> +#define PSW_MASK_WAIT		0x0002000000000000
> +#define PSW_MASK_PSTATE		0x0001000000000000
> +#define PSW_MASK_ASC		0x0000C00000000000
> +#define PSW_MASK_CC		0x0000300000000000
> +#define PSW_MASK_PM		0x00000F0000000000
> +#define PSW_MASK_RI		0x0000008000000000
> +#define PSW_MASK_EA		0x0000000100000000
> +#define PSW_MASK_BA		0x0000000080000000

a-f should be lower case in hex values.
Also, do we need all of them?
I'd like to keep it as small as possible.

> +
> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)

That's not a bit anymore, shouldn't that be in arch_def.h?
Also please add a comment, that this is 64 bit addressing.

> +
> +#endif
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 96cca2e..34c1188 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,13 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> =20
> +#include <asm/arch_bits.h>
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
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index eaff481..7475f32 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -11,6 +11,7 @@
>   * under the terms of the GNU Library General Public License version 2=
=2E
>   */
>  #include <asm/asm-offsets.h>
> +#include <asm/arch_bits.h>
>  #include <asm/sigp.h>
> =20
>  .section .init
> @@ -196,17 +197,17 @@ svc_int:
> =20
>  	.align	8
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



--OsN9bhzKnYOUfx87CoQ2XbRQNiXBPd6wW--

--r6LilpwTr9TbDNSPSWL1oDoptgo0xTTfp
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3MKdgACgkQ41TmuOI4
ufiULQ/+KAOZr4oZPPU6rgejOXLz0O5SS8znVAOuoVIy60keg9MgjmuRP9RIQrw0
nZBG/IMp/RqRvk03+qx8XR2RS6weRo0dj5VkKz4Nefi2Aio3PnMKj/PAmkoedVJe
57G6kbQIZsgEza15DPntwkrhDPNNp4rciVQMLyUMAnCI6USewYewludRaWWclSqr
kci6eio0i01eWgHrvBuFzpJPTzVGVFYer7uaYJZJZ2upbngNMY7WwkS3IExD2xbP
KMQgSf48KyQwe0oa22RuY7lt9DUI2NoqDlUWE18iz8++i/NjvIhwkgSF85PkWH73
GUHVXdNTcmTZBO96h8r3d9mmvuz+VV8XTA4AZ6FaTRTtoRm45rHYI8Q21zWIq95L
oefcxsvqKIbgMNdxhKPCDDvcx8E1lpr1uEFC6UKQqb+++7Cm5NmS0rTVjgocOkyy
kuaP8nySBETZUhfdFg4Py3wMb4Dzzh06U0SswLA0MJwBsnziH2sJu4xgAdBbjrgf
AAQe90w2h4RMWh15WugVzqqWGiIlWUhLNWkIH6avICkJr9RT9FekGIgaPpo4OTcC
WH5vhXM5IfnfO1Cb+UjmkBGR5ZO70Ic9R4mI+GbiAslW4ktIVt4aKVqcO6SCboSM
Dz+XzscC3HW308crg9JYHLFjqi6phkG2hrG9txMQvtFHaK6uQvU=
=gPle
-----END PGP SIGNATURE-----

--r6LilpwTr9TbDNSPSWL1oDoptgo0xTTfp--
