Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:56868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726944AbgEZKRr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 06:17:47 -0400
Subject: Re: [kvm-unit-tests PATCH v7 02/12] s390x: Use PSW bits definitions
 in cstart
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-3-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <dfe3446e-1d57-fc2b-e467-29b3010cb936@linux.ibm.com>
Date: Tue, 26 May 2020 12:17:39 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="RIaHyS4Eca7uVKq4vHkKaYAvAidvvfSvU"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--RIaHyS4Eca7uVKq4vHkKaYAvAidvvfSvU
Content-Type: multipart/mixed; boundary="SIgvDd7ey92eY20ECzOGfxouwHorppIRG"

--SIgvDd7ey92eY20ECzOGfxouwHorppIRG
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/18/20 6:07 PM, Pierre Morel wrote:
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

Nice

Reviewed-by: Janosch Frank <frankja@linux.ibm.com>

> ---
>  lib/s390x/asm/arch_def.h | 15 +++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 19 insertions(+), 11 deletions(-)
>=20
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49..820af93 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,21 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
> =20
> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_SHORT_PSW		0x0008000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +#define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
> +
> +#ifndef __ASSEMBLER__
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
> +#endif /* __ASSEMBLER */
>  #endif
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 3c7d8a9..e890568 100644
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
> @@ -232,19 +233,19 @@ svc_int:
> =20
>  	.align	8
>  reset_psw:
> -	.quad	0x0008000180000000
> +	.quad	PSW_EXCEPTION_MASK | PSW_MASK_SHORT_PSW
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



--SIgvDd7ey92eY20ECzOGfxouwHorppIRG--

--RIaHyS4Eca7uVKq4vHkKaYAvAidvvfSvU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7M7MQACgkQ41TmuOI4
ufjIMw//cDVNKIvpHNmqcD//EnTLTd73Ckg+Wp3799uBQUPd223s0cKqP6+A4klF
HD/Gxxj3Qxb8VflSBEqHvVxsuvTN3+sS1YDCW9iIqqzLIs1VhuGfI+/ON/qgyWr8
WUCH5KHd3uGe4RG34mwyjLK7NWFMgt8t36PK0mlm2l3FVy+v7JzfgvXt6Q/RJWXH
GDXvCiOTvDG0cTp+KWIJ2Y39zpqNTHZvUKbyIc+XrjWxsInt7GSFU65CoAs4Yyxc
5LUpIFSrkFkD1k/4GYnjkLchiFopIWWm0UOtNMdYwmkmJ6lHHTFDYBS3oXPFyNdM
5uJS/JFh3NTbfxaIp3DFcQ2GaRo4HqTCuyd4Gx7KFYEYV+87zQOJmsUWF1g/unTe
7p1Hqe4szz7uSQ8MK8vHTDxiHDIQmI/7gNWsNdL96zFSAPChsZZ+j+5O6fAJWrG6
r4t4N2OjPIJjRRZb7GjIoFndXJxV6dSRHb2bJbKWuk8Kc74nhpxBZpRx2sIhZwNu
tT0La2FT6F+icfu6qFoiYhZ4ODKjyryzEcYVp7UY1jAysOb+gLfrUaA/0Lx4plLl
9/dHDf1Qfb1IskLBMV9LeSUsyEqavgbXG66yJiLa8D+jZG9JoiBDLZif2rYx94vK
2n+S5ZcJh6xd/C4FfwPwg3UBRX603PzLC7eo+D49M01lcj+o5Cc=
=8a3C
-----END PGP SIGNATURE-----

--RIaHyS4Eca7uVKq4vHkKaYAvAidvvfSvU--
