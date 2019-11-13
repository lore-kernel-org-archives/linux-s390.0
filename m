Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:44118 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726165AbfKMQMs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 13 Nov 2019 11:12:48 -0500
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id xADG3Ype060351
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 11:12:47 -0500
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2w8krcbktn-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Wed, 13 Nov 2019 11:12:46 -0500
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <frankja@linux.ibm.com>;
        Wed, 13 Nov 2019 16:12:45 -0000
Subject: Re: [PATCH v1 1/4] s390x: saving regs for interrupts
References: <1573647799-30584-1-git-send-email-pmorel@linux.ibm.com>
 <1573647799-30584-2-git-send-email-pmorel@linux.ibm.com>
From: Janosch Frank <frankja@linux.ibm.com>
Date: Wed, 13 Nov 2019 17:12:41 +0100
MIME-Version: 1.0
In-Reply-To: <1573647799-30584-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="T7l0bocAsNY7PneeOXfo59mpPexWjFdhU"
Message-Id: <7f40bf69-6e34-7613-1ab5-83e09464c0b0@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, david@redhat.com, thuth@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--T7l0bocAsNY7PneeOXfo59mpPexWjFdhU
Content-Type: multipart/mixed; boundary="DFiyH82n6Typ8JwZzB8MBpyrm6vAPBrxR"

--DFiyH82n6Typ8JwZzB8MBpyrm6vAPBrxR
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 11/13/19 1:23 PM, Pierre Morel wrote:
> If we use multiple source of interrupts, for exemple, using SCLP consol=
e
> to print information while using I/O interrupts or during exceptions, w=
e
> need to have a re-entrant register saving interruption handling.
>=20
> Instead of saving at a static place, let's save the base registers on
> the stack.
>=20
> Note that we keep the static register saving that we need for the RESET=

> tests.
>=20
> We also care to give the handlers a pointer to the save registers in
> case the handler needs it (fixup_pgm_int needs the old psw address).

So you're still ignoring the FPRs...
I disassembled a test and looked at all stds and it looks like printf
and related functions use them. Wouldn't we overwrite test FPRs if
printing in a handler?

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/interrupt.h | 15 ++++++++++-----
>  lib/s390x/interrupt.c     | 16 ++++++++--------
>  s390x/cstart64.S          | 17 ++++++++++++++---
>  3 files changed, 32 insertions(+), 16 deletions(-)
>=20
> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
> index 4cfade9..a39a3a3 100644
> --- a/lib/s390x/asm/interrupt.h
> +++ b/lib/s390x/asm/interrupt.h
> @@ -15,11 +15,16 @@
>  #define EXT_IRQ_EXTERNAL_CALL	0x1202
>  #define EXT_IRQ_SERVICE_SIG	0x2401
> =20
> -void handle_pgm_int(void);
> -void handle_ext_int(void);
> -void handle_mcck_int(void);
> -void handle_io_int(void);
> -void handle_svc_int(void);
> +typedef struct saved_registers {
> +        unsigned long regs[15];
> +} sregs_t;
> +
> +void handle_pgm_int(sregs_t *regs);
> +void handle_ext_int(sregs_t *regs);
> +void handle_mcck_int(sregs_t *regs);
> +void handle_io_int(sregs_t *regs);
> +void handle_svc_int(sregs_t *regs);
> +
>  void expect_pgm_int(void);
>  void expect_ext_int(void);
>  uint16_t clear_pgm_int(void);
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 5cade23..7aecfc5 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -50,7 +50,7 @@ void check_pgm_int_code(uint16_t code)
>  	       code =3D=3D lc->pgm_int_code, code, lc->pgm_int_code);
>  }
> =20
> -static void fixup_pgm_int(void)
> +static void fixup_pgm_int(sregs_t *regs)
>  {
>  	switch (lc->pgm_int_code) {
>  	case PGM_INT_CODE_PRIVILEGED_OPERATION:
> @@ -64,7 +64,7 @@ static void fixup_pgm_int(void)
>  		/* Handling for iep.c test case. */
>  		if (lc->trans_exc_id & 0x80UL && lc->trans_exc_id & 0x04UL &&
>  		    !(lc->trans_exc_id & 0x08UL))
> -			lc->pgm_old_psw.addr =3D lc->sw_int_grs[14];
> +			lc->pgm_old_psw.addr =3D regs->regs[14];
>  		break;
>  	case PGM_INT_CODE_SEGMENT_TRANSLATION:
>  	case PGM_INT_CODE_PAGE_TRANSLATION:
> @@ -103,7 +103,7 @@ static void fixup_pgm_int(void)
>  	/* suppressed/terminated/completed point already at the next address =
*/
>  }
> =20
> -void handle_pgm_int(void)
> +void handle_pgm_int(sregs_t *regs)
>  {
>  	if (!pgm_int_expected)
>  		report_abort("Unexpected program interrupt: %d at %#lx, ilen %d\n",
> @@ -111,10 +111,10 @@ void handle_pgm_int(void)
>  			     lc->pgm_int_id);
> =20
>  	pgm_int_expected =3D false;
> -	fixup_pgm_int();
> +	fixup_pgm_int(regs);
>  }
> =20
> -void handle_ext_int(void)
> +void handle_ext_int(sregs_t *regs)
>  {
>  	if (!ext_int_expected &&
>  	    lc->ext_int_code !=3D EXT_IRQ_SERVICE_SIG) {
> @@ -134,19 +134,19 @@ void handle_ext_int(void)
>  		lc->ext_old_psw.mask &=3D ~PSW_MASK_EXT;
>  }
> =20
> -void handle_mcck_int(void)
> +void handle_mcck_int(sregs_t *regs)
>  {
>  	report_abort("Unexpected machine check interrupt: at %#lx",
>  		     lc->mcck_old_psw.addr);
>  }
> =20
> -void handle_io_int(void)
> +void handle_io_int(sregs_t *regs)
>  {
>  	report_abort("Unexpected io interrupt: at %#lx",
>  		     lc->io_old_psw.addr);
>  }
> =20
> -void handle_svc_int(void)
> +void handle_svc_int(sregs_t *regs)
>  {
>  	report_abort("Unexpected supervisor call interrupt: at %#lx",
>  		     lc->svc_old_psw.addr);
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 8e2b21e..eaff481 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -90,6 +90,17 @@ memsetxc:
>  	xc 0(1,%r1),0(%r1)
> =20
>  	.macro SAVE_REGS
> +	slgfi	%r15, 15 * 8
> +	stmg	%r0, %r14, 0(%r15)
> +	lgr	%r2, %r15
> +	.endm
> +
> +	.macro RESTORE_REGS
> +	lmg     %r0, %r14, 0(%r15)
> +	algfi   %r15, 15 * 8
> +	.endm
> +
> +	.macro SAVE_REGS_RESET
>  	/* save grs 0-15 */
>  	stmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	/* save cr0 */
> @@ -105,7 +116,7 @@ memsetxc:
>  	stfpc	GEN_LC_SW_INT_FPC
>  	.endm
> =20
> -	.macro RESTORE_REGS
> +	.macro RESTORE_REGS_RESET
>  	/* restore fprs 0-15 + fpc */
>  	la	%r1, GEN_LC_SW_INT_FPRS
>  	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> @@ -125,7 +136,7 @@ memsetxc:
>   */
>  .globl diag308_load_reset
>  diag308_load_reset:
> -	SAVE_REGS
> +	SAVE_REGS_RESET
>  	/* Save the first PSW word to the IPL PSW */
>  	epsw	%r0, %r1
>  	st	%r0, 0
> @@ -142,7 +153,7 @@ diag308_load_reset:
>  	/* We lost cr0 due to the reset */
>  0:	larl	%r1, initial_cr0
>  	lctlg	%c0, %c0, 0(%r1)
> -	RESTORE_REGS
> +	RESTORE_REGS_RESET
>  	lhi	%r2, 1
>  	br	%r14
> =20
>=20



--DFiyH82n6Typ8JwZzB8MBpyrm6vAPBrxR--

--T7l0bocAsNY7PneeOXfo59mpPexWjFdhU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwGNS88vfc9+v45Yq41TmuOI4ufgFAl3MK3kACgkQ41TmuOI4
ufgp+g//d1yXGzI5IK/w9iUQQXYs3a0VyV6Bq23FSIIrwUYJh/iuVJxvG66yR6+V
XmaDrXG/kfpU63hpl2+Efqsh8U/plTFCc+fbe4olf1Lq+MWFYvyQ7oTWCwxxFd0p
g3NCKuEZW/7An9PPDvaGt5UP/1g75f2k6ZQgAJvbmiZzEJe+yCgCBNuxNe7pxi5q
Fqe0lKiQNN5Ht97nzbHbDjD36OAuyL7XjZXHBDD6Jw6lENlWEDBjV9JtMaRdK64u
WQFs2DRfXqSNEuxrXoL5c/fOjlbI5A8Zw6TeJHPtXwGIwsppcwtJAiX+wdU8b/Xh
WJRgZ6CTl2qiQv+SWAa2RYQ2uQYezovv14yjCHpZJrjAYE5c0ScQSBv6gIWfWAFs
VVhVjz32r8kz6XUGBBW9zoIq9iFNHBwVynMKH83e69uQBjnVNWWlkBPtrOWgJh/e
HFuVhoDQUUMd6OqWb/bKKDgcAoP8XF08WnI79prDW2O1YLPEISq4qlYFvezvuX/L
PJ0FT/4QFbZr4uIM+DyLtUzWsiBUlUxEUsdRv6woX54o90n1+zDTS0ptwHmHqh+y
MDeHZ2xjmIemkoxxw1pnU0nsQgosArm3XWqArdn+LBc8G7XKKI/p4nlNZOI/gKd8
FoVCNsHpSqrc+ciCoIjjHgyLHPHjQ4lRB1j9QsSRCmOWxbKogz8=
=4b+C
-----END PGP SIGNATURE-----

--T7l0bocAsNY7PneeOXfo59mpPexWjFdhU--
