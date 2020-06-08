Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:24629 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbgFHJFn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 05:05:43 -0400
Subject: Re: [kvm-unit-tests PATCH v8 03/12] s390x: saving regs for interrupts
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-4-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <d4f1167c-5e44-f69c-8aac-f792a2a50ca7@redhat.com>
Date: Mon, 8 Jun 2020 11:05:33 +0200
MIME-Version: 1.0
In-Reply-To: <1591603981-16879-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 08/06/2020 10.12, Pierre Morel wrote:
> If we use multiple source of interrupts, for example, using SCLP
> console to print information while using I/O interrupts, we need
> to have a re-entrant register saving interruption handling.
> 
> Instead of saving at a static memory address, let's save the base
> registers, the floating point registers and the floating point
> control register on the stack in case of I/O interrupts
> 
> Note that we keep the static register saving to recover from the
> RESET tests.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Acked-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/cstart64.S | 41 +++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index b50c42c..a9d8223 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -119,6 +119,43 @@ memsetxc:
>  	lmg	%r0, %r15, GEN_LC_SW_INT_GRS
>  	.endm
>  
> +/* Save registers on the stack (r15), so we can have stacked interrupts. */
> +	.macro SAVE_REGS_STACK
> +	/* Allocate a stack frame for 15 general registers */
> +	slgfi   %r15, 15 * 8
> +	/* Store registers r0 to r14 on the stack */
> +	stmg    %r0, %r14, 0(%r15)
> +	/* Allocate a stack frame for 16 floating point registers */
> +	/* The size of a FP register is the size of an double word */
> +	slgfi   %r15, 16 * 8
> +	/* Save fp register on stack: offset to SP is multiple of reg number */
> +	.irp i, 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	std	\i, \i * 8(%r15)
> +	.endr
> +	/* Save fpc, but keep stack aligned on 64bits */
> +	slgfi   %r15, 8
> +	efpc	%r0
> +	stg	%r0, 0(%r15)
> +	.endm

I wonder whether it would be sufficient to only save the registers here
that are "volatile" according to the ELF ABI? ... that would save quite
some space on the stack, I think... OTOH, the old code was also saving
all registers, so maybe that's something for a separate patch later...

Acked-by: Thomas Huth <thuth@redhat.com>
