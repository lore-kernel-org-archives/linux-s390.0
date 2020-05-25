Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42914 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2389683AbgEYS5Y (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 May 2020 14:57:24 -0400
Subject: Re: [kvm-unit-tests PATCH v7 03/12] s390x: Move control register bit
 definitions and add AFP to them
References: <1589818051-20549-1-git-send-email-pmorel@linux.ibm.com>
 <1589818051-20549-4-git-send-email-pmorel@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <7614689a-62e6-944e-6162-93aa72407a90@redhat.com>
Date: Mon, 25 May 2020 20:57:12 +0200
MIME-Version: 1.0
In-Reply-To: <1589818051-20549-4-git-send-email-pmorel@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Pierre Morel <pmorel@linux.ibm.com>, kvm@vger.kernel.org
Cc: linux-s390@vger.kernel.org, frankja@linux.ibm.com, david@redhat.com, cohuck@redhat.com

On 18/05/2020 18.07, Pierre Morel wrote:
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
> index 820af93..54ffd0b 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -19,17 +19,18 @@
>  
>  #define PSW_EXCEPTION_MASK	(PSW_MASK_EA | PSW_MASK_BA)
>  
> +#define CR0_EXTM_SCLP			0X0000000000000200UL
> +#define CR0_EXTM_EXTC			0X0000000000002000UL
> +#define CR0_EXTM_EMGC			0X0000000000004000UL
> +#define CR0_EXTM_MASK			0X0000000000006200UL
> +#define CR0_AFP_REG_CRTL		0x0000000000040000UL
> +
>  #ifndef __ASSEMBLER__
>  struct psw {
>  	uint64_t	mask;
>  	uint64_t	addr;
>  };
>  
> -#define CR0_EXTM_SCLP			0X0000000000000200UL
> -#define CR0_EXTM_EXTC			0X0000000000002000UL
> -#define CR0_EXTM_EMGC			0X0000000000004000UL
> -#define CR0_EXTM_MASK			0X0000000000006200UL

This patch does not apply anymore due to commit f7df29115f736b ...
please switch to lower-case "0x"s in the next version.

 Thanks,
  Thomas
