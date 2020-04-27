Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:38650 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726183AbgD0I77 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Apr 2020 04:59:59 -0400
Subject: Re: [kvm-unit-tests PATCH v6 01/10] s390x: saving regs for interrupts
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-2-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <6b8e4ce5-0c9c-6111-98e8-1c9e392d0a73@redhat.com>
Date: Mon, 27 Apr 2020 10:59:47 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-2-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 24.04.20 12:45, Pierre Morel wrote:
> If we use multiple source of interrupts, for example, using SCLP
> console to print information while using I/O interrupts, we need
> to have a re-entrant register saving interruption handling.

So the primary reason is to print during I/O interrupts (which we
already do, but usually never trigger - handle_io_int())

>=20
> Instead of saving at a static memory address, let's save the base
> registers and the floating point registers on the stack.

".. in case of I/O interrupts".

>=20
> Note that we keep the static register saving to recover from the
> RESET tests.

and for all other types of interrupts.

>=20
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  s390x/cstart64.S | 34 ++++++++++++++++++++++++++++++++--
>  1 file changed, 32 insertions(+), 2 deletions(-)
>=20
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 9af6bb3..ba2e67c 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -118,6 +118,36 @@ memsetxc:
>  	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	.endm
> =20
> +/* Save registers on the stack (r15), so we can have stacked interrupt=
s. */
> +	.macro SAVE_IRQ_REGS

s/SAVE_IRQ_REGS/SAVE_REGS_STACK/ ?

Same for the other macro.

> +	/* Allocate a stack frame for 15 integer registers */

not integers. sizeof(int) =3D=3D 4.

"doublewords" should be the right s390x speak.

> +	slgfi   %r15, 15 * 8
> +	/* Store all registers from r0 to r14 on the stack */
> +	stmg    %r0, %r14, 0(%r15)
> +	/* Allocate a stack frame for 16 floating point registers */
> +	/* The size of a FP register is the size of an integer */
> +	slgfi   %r15, 16 * 8
> +	/* Save fp register on stack: offset to SP is multiple of reg number =
*/
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	std	\i, \i * 8(%r15)
> +	.endr
> +	.endm

What about the FPC?

> +
> +/* Restore the register in reverse order */
> +	.macro RESTORE_IRQ_REGS
> +	/* Restore fp register from stack: SP still where it was left */
> +	/* and offset to SP is a multile of reg number */
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	ld	\i, \i * 8(%r15)
> +	.endr
> +	/* Now it is done, rewind the stack pointer by 16 integers */
> +	algfi   %r15, 16 * 8
> +	/* Load the registers from stack */
> +	lmg     %r0, %r14, 0(%r15)
> +	/* Rewind the stack by 15 integers */
> +	algfi   %r15, 15 * 8
> +	.endm

Dito, FPC?

> +
>  .section .text
>  /*
>   * load_reset calling convention:
> @@ -182,9 +212,9 @@ mcck_int:
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


--=20
Thanks,

David / dhildenb
