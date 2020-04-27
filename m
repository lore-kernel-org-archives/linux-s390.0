Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:24173 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726349AbgD0JB5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 27 Apr 2020 05:01:57 -0400
Subject: Re: [kvm-unit-tests PATCH v6 02/10] s390x: Use PSW bits definitions
 in cstart
References: <1587725152-25569-1-git-send-email-pmorel@linux.ibm.com>
 <1587725152-25569-3-git-send-email-pmorel@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <231839f0-41f9-844c-efc4-34893e7b720f@redhat.com>
Date: Mon, 27 Apr 2020 11:01:47 +0200
MIME-Version: 1.0
In-Reply-To: <1587725152-25569-3-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, thuth@redhat.com, cohuck@redhat.com

On 24.04.20 12:45, Pierre Morel wrote:
> This patch defines the PSW bits EA/BA used to initialize the PSW masks
> for exceptions.
> 
> Since some PSW mask definitions exist already in arch_def.h we add these
> definitions there.
> We move all PSW definitions together and protect assembler code against
> C syntax.
> 
> Signed-off-by: Pierre Morel <pmorel@linux.ibm.com>
> ---
>  lib/s390x/asm/arch_def.h | 16 ++++++++++++----
>  s390x/cstart64.S         | 15 ++++++++-------
>  2 files changed, 20 insertions(+), 11 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49..c54409a 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -10,15 +10,22 @@
>  #ifndef _ASM_S390X_ARCH_DEF_H_
>  #define _ASM_S390X_ARCH_DEF_H_
>  
> +#define PSW_MASK_EXT			0x0100000000000000UL
> +#define PSW_MASK_DAT			0x0400000000000000UL
> +#define PSW_MASK_SHORT_PSW		0x0008000000000000UL
> +#define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +
> +#define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
> +#define PSW_RESET_MASK		(PSW_EXCEPTION_MASK | PSW_MASK_SHORT_PSW)
> +
> +#ifndef __ASSEMBLER__
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
>  
> -#define PSW_MASK_EXT			0x0100000000000000UL
> -#define PSW_MASK_DAT			0x0400000000000000UL
> -#define PSW_MASK_PSTATE			0x0001000000000000UL
> -
>  #define CR0_EXTM_SCLP			0X0000000000000200UL
>  #define CR0_EXTM_EXTC			0X0000000000002000UL
>  #define CR0_EXTM_EMGC			0X0000000000004000UL
> @@ -297,4 +304,5 @@ static inline uint32_t get_prefix(void)
>  	return current_prefix;
>  }
>  
> +#endif /* __ASSEMBLER */
>  #endif
> diff --git a/s390x/cstart64.S b/s390x/cstart64.S
> index ba2e67c..e394b3a 100644
> --- a/s390x/cstart64.S
> +++ b/s390x/cstart64.S
> @@ -12,6 +12,7 @@
>   */
>  #include <asm/asm-offsets.h>
>  #include <asm/sigp.h>
> +#include <asm/arch_def.h>
>  
>  .section .init
>  
> @@ -225,19 +226,19 @@ svc_int:
>  
>  	.align	8
>  reset_psw:
> -	.quad	0x0008000180000000
> +	.quad	PSW_RESET_MASK

I'd really prefer

.quad	PSW_EXCEPTION_MASK | PSW_MASK_SHORT_PSW

here instead and drop PSW_RESET_MASK. Makes it clearer that we are
talking about a special short psw here.

Apart from that, looks good to me.


-- 
Thanks,

David / dhildenb
