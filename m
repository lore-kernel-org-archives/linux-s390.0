Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:54571 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726776AbgDXKNb (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 24 Apr 2020 06:13:31 -0400
Subject: Re: [PATCH v2 10/10] s390x: Fix library constant definitions
References: <20200423091013.11587-1-frankja@linux.ibm.com>
 <20200423091013.11587-11-frankja@linux.ibm.com>
From: David Hildenbrand <david@redhat.com>
Message-ID: <1ffe6eca-0f17-939e-ecf4-2719c455cb6f@redhat.com>
Date: Fri, 24 Apr 2020 12:13:23 +0200
MIME-Version: 1.0
In-Reply-To: <20200423091013.11587-11-frankja@linux.ibm.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: thuth@redhat.com, linux-s390@vger.kernel.org, borntraeger@de.ibm.com, cohuck@redhat.com

On 23.04.20 11:10, Janosch Frank wrote:
> Seems like I uppercased the whole region instead of only the ULs when
> I added those definitions. Let's make the x lowercase again.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@de.ibm.com>
> Reviewed-by: Cornelia Huck <cohuck@redhat.com>
> ---
>  lib/s390x/asm/arch_def.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 15a4d49..1b3bb0c 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -19,10 +19,10 @@ struct psw {
>  #define PSW_MASK_DAT			0x0400000000000000UL
>  #define PSW_MASK_PSTATE			0x0001000000000000UL
>  
> -#define CR0_EXTM_SCLP			0X0000000000000200UL
> -#define CR0_EXTM_EXTC			0X0000000000002000UL
> -#define CR0_EXTM_EMGC			0X0000000000004000UL
> -#define CR0_EXTM_MASK			0X0000000000006200UL
> +#define CR0_EXTM_SCLP			0x0000000000000200UL
> +#define CR0_EXTM_EXTC			0x0000000000002000UL
> +#define CR0_EXTM_EMGC			0x0000000000004000UL
> +#define CR0_EXTM_MASK			0x0000000000006200UL
>  
>  struct lowcore {
>  	uint8_t		pad_0x0000[0x0080 - 0x0000];	/* 0x0000 */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb
