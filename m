Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:54624 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728344AbfLLJY6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Dec 2019 04:24:58 -0500
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id xBC9HhZV060584
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:24:57 -0500
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2wuhsca8tq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Dec 2019 04:24:57 -0500
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Thu, 12 Dec 2019 09:24:55 -0000
Subject: Re: [kvm-unit-tests PATCH v4 1/9] s390x: saving regs for interrupts
References: <1576079170-7244-1-git-send-email-pmorel@linux.ibm.com>
 <1576079170-7244-2-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Thu, 12 Dec 2019 10:24:50 +0100
MIME-Version: 1.0
In-Reply-To: <1576079170-7244-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="hI1B612YQUHgvmt0GtLBR9CjAxEuIk7Es"
Message-Id: <19f572f1-5855-154a-af2b-1273d485be51@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com, cohuck@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--hI1B612YQUHgvmt0GtLBR9CjAxEuIk7Es
Content-Type: multipart/mixed; boundary="MHONfmY7A4mTNnuqvstqP77b8k5VSv3sU"

--MHONfmY7A4mTNnuqvstqP77b8k5VSv3sU
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 12/11/19 4:46 PM, Pierre Morel wrote:
> If we use multiple source of interrupts, for exemple, using SCLP

s/exemple/example/

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
>  s390x/cstart64.S | 25 +++++++++++++++++++++++--
>  1 file changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 86dd4c4..ff05f9b 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -118,6 +118,25 @@ memsetxc:
>  	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	.endm
> > +	.macro SAVE_IRQ_REGS

Maybe add comments to the start of the macros like:
"Save registers on the stack, so we can have stacked interrupts."

> +	slgfi   %r15, 15 * 8
> +	stmg    %r0, %r14, 0(%r15)
> +	slgfi   %r15, 16 * 8
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	std	\i, \i * 8(%r15)
> +	.endr
> +	lgr     %r2, %r15

What's that doing?

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
> @@ -154,6 +173,8 @@ diag308_load_reset:
>  	lpswe	GEN_LC_SW_INT_PSW
>  1:	br	%r14
> =20
> +
> +

Still not fixed

>  .globl smp_cpu_setup_state
>  smp_cpu_setup_state:
>  	xgr	%r1, %r1
> @@ -180,9 +201,9 @@ mcck_int:
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



--MHONfmY7A4mTNnuqvstqP77b8k5VSv3sU--

--hI1B612YQUHgvmt0GtLBR9CjAxEuIk7Es
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3yB2IACgkQ41TmuOI4
ufigTg/8DODt0q9qxmbJ1judszxqeFWqAvEiFqbP/n/7fRjMvsPnOC+Mf/j2BRtb
LTuwqZ8/SISBlRWew8o2QFIqZinrpmIRH8VU9lsWBIc4I3OSPhHZLdxhZ9gbk/h2
N2PnbONkRO/ndyj7tSP/AQJdREawFnOUQfhX/tP8TzdmGJSeAPdqxLl7yOBhW8sl
W707onT4BUH1qr/YYMQLjEAQZ8Y1f9RCDWlXukRpz8dOmfOGEYhy2dwm0R6OFj2I
OE9lfOA/MdJ/1oOHQBFrhGBUS9jk+uGi+ldwamO+0EJewndfComP7nLhpZfH/qIZ
7HV3Gh/fYxcyYTCUwHlddKU85ZXCN8vBsUCKjVf7T3309L3TuRzGO7ICzZWkTpiS
naGNDi2rSJ01KK0WMwbNFASrKoCCM5KDanE0S4E397yGZ8xIfqY/EEbclNHQQ+IC
Hj0528fKElwxb99WAVUiMFUidgyzPF0g1YZsZuX/DNbT2YZPEE7hdI0NKsOBQrAo
0hSCfEzWUnuFq4bIuC68VUJm1dtpF8RWLqmhW+Ta7VEmN7teOjDcF39qyHDqO3ci
UKBsKB+qUgjAQAux/m3ZS5sKgFzv1fai/NTv0weUL9HKJGt42fQOfEBIjYXFG3Yf
ujnluPWhAc9e4cJ4wguHs854WX9AkecSwJSxYTxLhRKtQTCIKF8=
=1wXM
-----END PGP SIGNATURE-----

--hI1B612YQUHgvmt0GtLBR9CjAxEuIk7Es--
