Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:53408 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726003AbgDVHru (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 22 Apr 2020 03:47:50 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 03M7VoZe178443
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:47:49 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 30gmvhskep-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 22 Apr 2020 03:47:49 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 22 Apr 2020 08:47:00 +0100
Subject: Re: [kvm-unit-tests PATCH v5 01/10] s390x: saving regs for interrupts
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-2-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 22 Apr 2020 09:47:41 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="GJaLqkBfGEmiLSCfLGIlw4CAjIGwPkjXQ"
Message-Id: <8c999975-bd94-67f1-98cc-3821f02a99c2@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GJaLqkBfGEmiLSCfLGIlw4CAjIGwPkjXQ
Content-Type: multipart/mixed; boundary="BzCGfuw0onaQEWLZFlHtDroGACAI6hKRE"

--BzCGfuw0onaQEWLZFlHtDroGACAI6hKRE
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 2/20/20 1:00 PM, Pierre Morel wrote:
> If we use multiple source of interrupts, for example, using SCLP
> console to print information while using I/O interrupts, we need
> to have a re-entrant register saving interruption handling.
>=20
> Instead of saving at a static memory address, let's save the base
> registers and the floating point registers on the stack.
>=20
> Note that we keep the static register saving to recover from the
> RESET tests.
>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/cstart64.S | 23 +++++++++++++++++++++--
>  1 file changed, 21 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..45da523 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -118,6 +118,25 @@ memsetxc:
>  	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	.endm
> =20
> +/* Save registers on the stack, so we can have stacked interrupts. */
> +	.macro SAVE_IRQ_REGS
> +	slgfi   %r15, 15 * 8
> +	stmg    %r0, %r14, 0(%r15)

So this is just making some space on the stack and storing r0 - r14, righ=
t?

Same is done for the floating point registers below.

Could you add a comment above slgfi and stmg and explain what they do?
A few words are enough.

> +	slgfi   %r15, 16 * 8
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	std	\i, \i * 8(%r15)
> +	.endr
> +	.endm
> +
> +	.macro RESTORE_IRQ_REGS
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	ld	\i, \i * 8(%r15)
> +	.endr
> +	algfi   %r15, 16 * 8
> +	lmg     %r0, %r14, 0(%r15)
> +	algfi   %r15, 15 * 8
> +	.endm
> +
>  .section .text
>  /*
>   * load_reset calling convention:
> @@ -182,9 +201,9 @@ mcck_int:
>  	lpswe	GEN_LC_MCCK_OLD_PSW
> =20
>  io_int:
> -	SAVE_REGS
> +	SAVE_IRQ_REGS
>  	brasl	%r14, handle_io_int
> -	RESTORE_REGS
> +	RESTORE_IRQ_REGS
>  	lpswe	GEN_LC_IO_OLD_PSW
> =20
>  svc_int:
>=20



--BzCGfuw0onaQEWLZFlHtDroGACAI6hKRE--

--GJaLqkBfGEmiLSCfLGIlw4CAjIGwPkjXQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl6f9p0ACgkQ41TmuOI4
ufj8FBAAlSirQV2UDz6G66HVqznrehHKM+n4ghvRC+7yLgt30/FYQcyDZ+ZGR35c
4fORpxRyrtoLa6aD8+MUHrKNhDLT588eWrx+ugRWOXkJfyg+17mZd8XgQFRM55Bs
puSM0bGOtuQfN6bhwS3uKPWabMdNwECjenzX4z7N4+kT3M+LeCOyVw/Mriy7luDE
95MQ/4uflu+i25C5Wk4vYVwk5/X5c3/NZp5AbabBJqPomULK+JTs4S53lFu8worQ
Ahh8PpCmWbr42uNnqpX8OejKKzS8426QUG83o9CH/ABBpLs+8wsyF/Xt3HaZ9vY0
PDovAdNwMNeQPeb3Fqf974SZ3YF0Ll3X+hiYuJqay9XZ/lBwkbZCkh42maW7645E
qsXAstiaHGeb5nBaPDDCEN9oHQmM/1aVndG7bZTKybyaXwgM/XOOltritI8kkHxR
YeGTbViYHzGt3ixZcLTE4ruGvmJZpkcabAiNSRrCG/ni0WQDtLTeJeobp3bTo16T
CZZijYf4xIvbsFG2bboMbaMvyQ+44djlsVVn0LpKDAXQSVldag5cCeS93BZfmcAk
hZgKz7AuyWqnxtsiE1j2UqC6VS/zBTp+9y6GChTWOm30QvXmau3/XpBFQFQ2/6ev
JBEibirWdnDbdg6OKmwaRabLwOw3PC5H/UE/K4y/4NGUjzGlbdM=
=sui4
-----END PGP SIGNATURE-----

--GJaLqkBfGEmiLSCfLGIlw4CAjIGwPkjXQ--
