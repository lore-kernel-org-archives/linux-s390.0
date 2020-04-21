Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33874 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729151AbgDUQPh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 21 Apr 2020 12:15:37 -0400
Subject: Re: [kvm-unit-tests PATCH v5 03/10] s390x: cr0: adding AFP-register
 control bit
References: <1582200043-21760-1-git-send-email-pmorel@linux.ibm.com>
 <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <a4ce1829-027e-d632-be2b-9f6b59d9b96d@redhat.com>
Date: Tue, 21 Apr 2020 18:15:26 +0200
MIME-Version: 1.0
In-Reply-To: <1582200043-21760-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 20.02.20 13:00, Pierre Morel wrote:
> While adding the definition for the AFP-Register control bit, move all
> existing definitions for CR0 out of the C zone to the assmbler zone to
> keep the definitions concerning CR0 together.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 11 ++++++-----
>  s390x/cstart64.S         |  2 +-
>  2 files changed, 7 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 69a8256..863c2bf 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -18,6 +18,12 @@
>  
>  #define PSW_EXCEPTION_MASK (PSW_MASK_EA|PSW_MASK_BA)
>  
> +#define CR0_EXTM_SCLP			0X0000000000000200UL
> +#define CR0_EXTM_EXTC			0X0000000000002000UL
> +#define CR0_EXTM_EMGC			0X0000000000004000UL
> +#define CR0_EXTM_MASK			0X0000000000006200UL
> +#define CR0_AFP_REG_CRTL		0x0000000000040000UL
> +
>  #ifndef __ASSEMBLER__
>  
>  struct psw {
> @@ -25,11 +31,6 @@ struct psw {
>  	uint64_t	addr;
>  };
>  
> -#define CR0_EXTM_SCLP			0X0000000000000200UL
> -#define CR0_EXTM_EXTC			0X0000000000002000UL
> -#define CR0_EXTM_EMGC			0X0000000000004000UL
> -#define CR0_EXTM_MASK			0X0000000000006200UL
> -
>  struct lowcore {
>  	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
>  	uint32_t	ext_int_param;			/* 0x0080 */
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index 2885a36..3b59bd1 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -230,4 +230,4 @@ svc_int_psw:
>  	.quad	PSW_EXCEPTION_MASK, svc_int
>  initial_cr0:
>  	/* enable AFP-register control, so FP regs (+BFP instr) can be used */
> -	.quad	0x0000000000040000
> +	.quad	CR0_AFP_REG_CRTL
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
