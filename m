Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:3378 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728230AbfLLJbu (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:31:50 -0500
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9TPnp124538
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:31:49 -0500
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wtf8jy3b1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:31:48 -0500
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:31:46 -0000
Subject: Re: [kvm-unit-tests PATCH v4 2/9] s390x: Use PSW bits definitions in
 cstart
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:31:42 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="WBTHpSk0zDFFkEN6eLm4kJ7Frwi70T3Be"
Message-Id: <41887741-3db0-5969-edb4-1f50e7b17da7@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WBTHpSk0zDFFkEN6eLm4kJ7Frwi70T3Be
Content-Type: multipart/mixed; boundary="QhkVlxYw7rAmyIcZx6xJhFTNQDS67kEhG"

--QhkVlxYw7rAmyIcZx6xJhFTNQDS67kEhG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> This patch defines the PSW bits EA/BA used to initialize the PSW masks
> for exceptions.
>=20
> Since some PSW mask definitions exist already in arch_def.h we add thes=
e
> definitions there.
> We move all PSW definitions together and protect assembler code against=

> C syntax.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 16 ++++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 20 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index cf6e1ca..b6bb8c1 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,22 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> =20
> +#define PSW_MASK_IO			0x0200000000000000UL

That's new and not used in this patch, please move it to the patch where
it's needed.

> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +
> +#define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
> +
> +#ifndef __ASSEMBLER__

\n

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
> @@ -272,3 +279,4 @@ static inline int stsi(void *addr, int fc, int sel1=
, int sel2)
>  }
> =20
>  #endif
> +#endif

Please add a comment to which ifdef this endif belongs.

> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index ff05f9b..56a2045 100644
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

Could you maybe also fix that up in a separate patch and use the same
constant in lib/s390x/smp.c

>=20



--QhkVlxYw7rAmyIcZx6xJhFTNQDS67kEhG--

--WBTHpSk0zDFFkEN6eLm4kJ7Frwi70T3Be
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yCP4ACgkQ41TmuOI4
ufhekg/9EHu28jI1vZg6UYW17AjEBXwlA3z3RlMpVmHh1g/pfGlbqC2klQ8CLiDh
0OXZr/+XywaYwAcPhNYHfVIiwejPvkL/LGBml1shu7EoBbkYutfshKbCNPsDpmRx
zuCvWCCAJR3EbFS5JZbSrDuewf5AenJKVkUGUg8yJLYdRmhWh3+STAyv1TyQtgQR
AY0T+idgrtnM8dblp/Aq0lwuXJOpxSs4Y98u8GpERVBAQxEhRYsdoH4nasuGDUcU
4WiK9Go4R0Thmd8z9/NRpCJJGqWbpQWqHKi0YmGB8kPse5MeQwZEGkMoAFCL4+TK
0uAhVTjoWV/m2l9jCSUnx4CSOlkCt065ufXmUd6rjND1CqhXa8KFrrQoYDJtBJ1Z
DiVxVjymwT1bT0whGHb07Avn2FP+h53lkM19BCN4pUW97yTnJ4S+wZ5os8osDf6B
1esuoX8/AwLrvHAYvYIkWPEUZyIqIM8sWrm+ZwkX1c+Xpei13g/BRJA1wqriiGM9
h9wbbiaLIZPEzPAtjrQsGoc8S723XslbeIxN3nFfk73oxhg9cBYfGaXNQFMIly5t
gY6tfK++7/0J37HSklHMrlFvVsXnslVesODpWasBh9e+ARE0GAgbTd+czLOPhUWE
UbogC1Vde4oBZqr3ahsPZZlukXYbWiyMG2Kz7RD7RRGRVMDSXQs=
=9oCY
-----END PGP SIGNATURE-----

--WBTHpSk0zDFFkEN6eLm4kJ7Frwi70T3Be--
