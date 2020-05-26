Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:11456 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388460AbgEZKat (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 26 May 2020 06:30:49 -0400
Subject: Re: [kvm-unit-tests PATCH v7 01/12] s390x: saving regs for interrupts
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-2-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Message-ID: <e06ed054-6038-3a7e-3eda-0d37ee382919@linux.ibm.com>
Date: Tue, 26 May 2020 12:30:41 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="Jd8Q3gADMBmmu8RQAwYtEa0YCstqKlPOw"
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Jd8Q3gADMBmmu8RQAwYtEa0YCstqKlPOw
Content-Type: multipart/mixed; boundary="6MVGXe3PLrNMZ6OEKOQx2pxmlGPcoMfeN"

--6MVGXe3PLrNMZ6OEKOQx2pxmlGPcoMfeN
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 5/18/20 6:07 PM, Pierre Morel wrote:
> If we use multiple source of interrupts, for example, using SCLP
> console to print information while using I/O interrupts, we need
> to have a re-entrant register saving interruption handling.
>=20
> Instead of saving at a static memory address, let's save the base
> registers, the floating point registers and the floating point
> control register on the stack in case of I/O interrupts
>=20
> Note that we keep the static register saving to recover from the
> RESET tests.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>

Some nits below

Acked-by: Janosch Frank <frankja@linux.ibm.com>


> ---
>  s390x/cstart64.S | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..3c7d8a9 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -118,6 +118,43 @@ memsetxc:
>  	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	.endm
> =20
> +/* Save registers on the stack (r15), so we can have stacked interrupt=
s. */
> +	.macro SAVE_REGS_STACK
> +	/* Allocate a stack frame for 15 general registers */
> +	slgfi   %r15, 15 * 8
> +	/* Store all registers from r0 to r14 on the stack */

/* Store registers r0 to r14 on the stack */

> +	stmg    %r0, %r14, 0(%r15)
> +	/* Allocate a stack frame for 16 floating point registers */
> +	/* The size of a FP register is the size of an double word */
> +	slgfi   %r15, 16 * 8
> +	/* Save fp register on stack: offset to SP is multiple of reg number =
*/
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	std	\i, \i * 8(%r15)
> +	.endr
> +	/* Save fpc, but keep stack aligned on 64bits */
> +	slgfi   %r15, 8
> +	efpc	%r0
> +	stg	%r0, 0(%r15)
> +	.endm
> +
> +/* Restore the register in reverse order */
> +	.macro RESTORE_REGS_STACK
> +	/* Restore fpc */
> +	lfpc	0(%r15)
> +	algfi	%r15, 8
> +	/* Restore fp register from stack: SP still where it was left */
> +	/* and offset to SP is a multile of reg number */

multile?
Multiple?

> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	ld	\i, \i * 8(%r15)
> +	.endr
> +	/* Now it is done, rewind the stack pointer by 16 double word */

Now that we're done, rewind the stack pointer by 16 double words

> +	algfi   %r15, 16 * 8
> +	/* Load the registers from stack */
> +	lmg     %r0, %r14, 0(%r15)
> +	/* Rewind the stack by 15 double word */
> +	algfi   %r15, 15 * 8
> +	.endm
> +
>  .section .text
>  /*
>   * load_reset calling convention:
> @@ -182,9 +219,9 @@ mcck_int:
>  	lpswe	GEN_LC_MCCK_OLD_PSW
> =20
>  io_int:
> -	SAVE_REGS
> +	SAVE_REGS_STACK
>  	brasl	%r14, handle_io_int
> -	RESTORE_REGS
> +	RESTORE_REGS_STACK
>  	lpswe	GEN_LC_IO_OLD_PSW
> =20
>  svc_int:
>=20



--6MVGXe3PLrNMZ6OEKOQx2pxmlGPcoMfeN--

--Jd8Q3gADMBmmu8RQAwYtEa0YCstqKlPOw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl7M79EACgkQ41TmuOI4
ufjq4xAAqgnwNNZheqD9BssRBbb8f9SklUusBzhlvqP94QQLAuV3YP+iIm0V8JsN
DqL4DoKuLrvKVPVyEKtxj4DOZv+rYIrR3AWaHP+ya/CstLZ/k5OMJvGL+TSHPAoQ
EYa5SmIpHWka8YU+VFRbO9y/SDGy1UMLKnEVbH0tAJXMZpCH8OYSbvpg51YQcyHY
LF78DnITmYcfHXmkLNk9QnkeGjmaUZ71Gx7udah/BgqfRNm09/e2/JAugCYpUgUc
2E/Nh15qzbiNAaDUseP5X50FqS9u3Hpd49J6yq97KBvnbMSBLZYdGnRWg1X+fGNT
/cReSPX+8v3sloAXpY1Z1VpQ0ni4sxBJGSAeqX/GWTjPT/bAhTSxAV2Yg1lQHhr9
mPrGfQlDu3bMNQzhH7GiDopj4Cy5Wu52fkAwYEPjHhZivI1Jpal2bWIKbxf+oE0E
D3TnJmgdXk3CR8SZ3z+eVhGdayLEabjt91ERv+GFqHoiTvfUEj2Wb/SHq8nOHSpI
jcyv5F3SHt2fAymr56Fo4mSxUbHpKd+oTnvuMPlCC+WtVuqH4hqvJQpFSAP8iWjt
Im+pCs3sNQYDC38JtNSqszf364E0TQ9n7ywlaKiQtpl2tWIFuZB0XDLDwUO5W4Y2
lbuf/T9Q/8/IxRmu+TNGpnTE2RnxXK+93DDspY0okWgC7co4aKE=
=cfPt
-----END PGP SIGNATURE-----

--Jd8Q3gADMBmmu8RQAwYtEa0YCstqKlPOw--
