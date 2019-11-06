Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:53158 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbfKFKTm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Nov 2019 05:19:42 -0500
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xA69uBWE049493
        for <linux-s390@vger.kernel.org>; Wed, 6 Nov 2019 05:19:41 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2w3u2rtuhq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 06 Nov 2019 05:19:41 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 6 Nov 2019 10:19:39 -0000
Subject: Re: [kvm-unit-tests PATCH 2/2] s390x: Remove DAT and add short
 indication psw bits on diag308 reset
From: Janosch Frank <frankja@linux.ibm.com>
References: <20191105162828.2490-1-frankja@linux.ibm.com>
 <20191105162828.2490-3-frankja@linux.ibm.com>
Date: Wed, 6 Nov 2019 11:19:34 +0100
MIME-Version: 1.0
In-Reply-To: <20191105162828.2490-3-frankja@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="j4ML4Gy1U04lLyaz2OBIvyEIFgfoEoO27"
Message-Id: <c53bab1c-3158-f9c2-bd36-c3eca857d26f@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, thuth@redhat.com, david@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--j4ML4Gy1U04lLyaz2OBIvyEIFgfoEoO27
Content-Type: multipart/mixed; boundary="SRfEZYxOf5YPbrjPL2QwqalbagPRCb2rx"

--SRfEZYxOf5YPbrjPL2QwqalbagPRCb2rx
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/5/19 5:28 PM, Janosch Frank wrote:
> On a diag308 subcode 0 CRs will be reset, so we need to mask of PSW
> DAT indication until we restore our CRs.
>=20
> Also we need to set the short psw indication to be compliant with the
> architecture.
>=20
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm-offsets.c  |  1 +
>  lib/s390x/asm/arch_def.h |  3 ++-
>  s390x/cstart64.S         | 20 ++++++++++++++------
>  3 files changed, 17 insertions(+), 7 deletions(-)
>=20
> diff --git a/lib/s390x/asm-offsets.c b/lib/s390x/asm-offsets.c
> index 4b213f8..61d2658 100644
> --- a/lib/s390x/asm-offsets.c
> +++ b/lib/s390x/asm-offsets.c
> @@ -58,6 +58,7 @@ int main(void)
>  	OFFSET(GEN_LC_SW_INT_FPRS, lowcore, sw_int_fprs);
>  	OFFSET(GEN_LC_SW_INT_FPC, lowcore, sw_int_fpc);
>  	OFFSET(GEN_LC_SW_INT_CRS, lowcore, sw_int_crs);
> +	OFFSET(GEN_LC_SW_INT_PSW, lowcore, sw_int_psw);
>  	OFFSET(GEN_LC_MCCK_EXT_SA_ADDR, lowcore, mcck_ext_sa_addr);
>  	OFFSET(GEN_LC_FPRS_SA, lowcore, fprs_sa);
>  	OFFSET(GEN_LC_GRS_SA, lowcore, grs_sa);
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 07d4e5e..7d25e4f 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -79,7 +79,8 @@ struct lowcore {
>  	uint32_t	sw_int_fpc;			/* 0x0300 */
>  	uint8_t		pad_0x0304[0x0308 - 0x0304];	/* 0x0304 */
>  	uint64_t	sw_int_crs[16];			/* 0x0308 */
> -	uint8_t		pad_0x0310[0x11b0 - 0x0388];	/* 0x0388 */
> +	struct psw	sw_int_psw;			/* 0x0388 */
> +	uint8_t		pad_0x0310[0x11b0 - 0x0390];	/* 0x0390 */

That's obviously not correct, the psw is two DWORDS long, not one...

>  	uint64_t	mcck_ext_sa_addr;		/* 0x11b0 */
>  	uint8_t		pad_0x11b8[0x1200 - 0x11b8];	/* 0x11b8 */
>  	uint64_t	fprs_sa[16];			/* 0x1200 */
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 0455591..2e0dcf5 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -129,8 +129,15 @@ memsetxc:
>  .globl diag308_load_reset
>  diag308_load_reset:
>  	SAVE_REGS
> -	/* Save the first PSW word to the IPL PSW */
> +	/* Backup current PSW */
>  	epsw	%r0, %r1
> +	st	%r0, GEN_LC_SW_INT_PSW
> +	st	%r1, GEN_LC_SW_INT_PSW + 4
> +	/* Disable DAT as the CRs will be reset too */
> +	nilh	%r0, 0xfbff
> +	/* Add psw bit 12 to indicate short psw */
> +	oilh	%r0, 0x0008
> +	/* Save the first PSW word to the IPL PSW */
>  	st	%r0, 0
>  	/* Store the address and the bit for 31 bit addressing */
>  	larl    %r0, 0f
> @@ -142,12 +149,13 @@ diag308_load_reset:
>  	xgr	%r2, %r2
>  	br	%r14
>  	/* Success path */
> -	/* We lost cr0 due to the reset */
> -0:	larl	%r1, initial_cr0
> -	lctlg	%c0, %c0, 0(%r1)
> -	RESTORE_REGS
> +	/* Switch to z/Architecture mode and 64-bit */
> +0:	RESTORE_REGS
>  	lhi	%r2, 1
> -	br	%r14
> +	larl	%r0, 1f
> +	stg	%r0, GEN_LC_SW_INT_PSW + 8
> +	lpswe	GEN_LC_SW_INT_PSW
> +1:	br	%r14
> =20
>  .globl smp_cpu_setup_state
>  smp_cpu_setup_state:
>=20



--SRfEZYxOf5YPbrjPL2QwqalbagPRCb2rx--

--j4ML4Gy1U04lLyaz2OBIvyEIFgfoEoO27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3CnjYACgkQ41TmuOI4
ufiMTBAAqT4SiXuVUybd2PMwg2w+wRrEMgvWLJBvIPfATV2SlrN9GbA925GHcgvd
gl+jGv613xGsH4egnx9AzaY2MSbebQOeNf8zIObmYagvxlba9qtrjKeh+PZw2SeT
+OAErjAp1IRtN/SQ3dT8QHyVnamhxeVGVQ3UWOE/lI3QyL3TkhmL1Gz6qDy+/BFg
kdw1yu9m19mQjEXSADGi17wB20ibLcYUHTobbjy05cUTcksMmrh8VNK9Wqhe2Z3q
MjkLc1yFLFE8rajICDO812eK39WmiDcY3R5zherPp7gHAKSW2mw6qQ9XNKXKY/t/
iMMyDfYOnNMiGt6M13wDlr9RXdhi7OpTaDwT+SXwddLaY6BKzuQ8N9tLMz8Np6Xt
1P8U4Mqfme3IhsvwiWByQZNRwHdK/CbmMu5g7LlYi4eLUvihWYkQQJIeBrrHmhQF
818vFt1D9uriG2a5JmbQZuFmhLCYPH8Nz1F/NFJjokE6Paxt6DjJyw9+2ttzifvT
2wAWO0cZDRQHhvG8fjYSapMC+aZoaULfI3dclLdCSgIYDVGkRiFHAh36YI+BHbbn
Hh8ZJHyCiYnvJbprOAXL+FpoGvbmT5ukRyNmRvKG4jMbpMm4LRCjUJQ4M4+P1gfI
HQ8M9Pu+nWyPt++vHwv9ETvPFKXwfhTMmYSzh1ssAVCgQVx2D3U=
=9n94
-----END PGP SIGNATURE-----

--j4ML4Gy1U04lLyaz2OBIvyEIFgfoEoO27--
