Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:38509 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726535AbgFHIpZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Jun 2020 04:45:25 -0400
Subject: Re: [kvm-unit-tests PATCH v8 02/12] s390x: Move control register bit
 definitions and add AFP to them
References: <1591603981-16879-1-git-send-email-pmorel@linux.ibm.com>
 <1591603981-16879-3-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <ac5e93fa-3b52-0f28-2c62-64c31b902c33@redhat.com>
Date: Mon, 8 Jun 2020 10:45:15 +0200
MIME-Version: 1.0
In-Reply-To: <1591603981-16879-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 08/06/2020 10.12, Pierre Morel wrote:
> While adding the definition for the AFP-Register control bit, move all
> existing definitions for CR0 out of the C zone to the assmbler zone to
> keep the definitions concerning CR0 together.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> Reviewed-by: David Hildenbrand <david@redhat.com>
> Reviewed-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/asm/arch_def.h | 11 ++++++-----
>  s390x/cstart64.S         |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 5388114..12045ff 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -19,17 +19,18 @@
>  
>  #define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
>  
> +#define CR0_EXTM_SCLP			0x0000000000000200UL
> +#define CR0_EXTM_EXTC			0x0000000000002000UL
> +#define CR0_EXTM_EMGC			0x0000000000004000UL
> +#define CR0_EXTM_MASK			0x0000000000006200UL
> +#define CR0_AFP_REG_CRTL		0x0000000000040000UL
> +
>  #ifndef __ASSEMBLER__
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
>  
> -#define CR0_EXTM_SCLP			0x0000000000000200UL
> -#define CR0_EXTM_EXTC			0x0000000000002000UL
> -#define CR0_EXTM_EMGC			0x0000000000004000UL
> -#define CR0_EXTM_MASK			0x0000000000006200UL
> -
>  struct lowcore {
>  	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
>  	uint32_t	ext_int_param;			/* 0x0080 */
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 6e85635..b50c42c 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -214,4 +214,4 @@ svc_int_psw:
>  	.quad	PSW_EXCEPTION_MASK, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
> -	.quad	0x0000000000040000
> +	.quad	CR0_AFP_REG_CRTL
> 

Acked-by: Thomas Huth <thuth@redhat.com>
