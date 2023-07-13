Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5CFEB64DD
	for <linux-s390@archiver.kernel.org>; Thu, 13 Jul 2023 07:18:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbjGMHSU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 13 Jul 2023 03:18:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234069AbjGMHST (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 13 Jul 2023 03:18:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44C92E75
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 00:17:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689232653;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2LejsROT8ViVogg5eUBhr0atMu0AKpWZYVlQl+igMgI=;
        b=fpCr9JYgy7w9gES/VJmw9yUH+zft55hT7Ov4wlfl25aJnmD+Zpd2+fRwLwWuI025oTMqX/
        j7oChCVGu7yBbyCp4YGfFhf0fngP5SssiP2GzCdLP4qO/gxdVypzJiTFsG+d1uBvoFZDZq
        sJ7fFns6rKYT4gAG9f+LliftaMeNEGE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-641-dJ6xChwiNY61wac7ien0jg-1; Thu, 13 Jul 2023 03:17:32 -0400
X-MC-Unique: dJ6xChwiNY61wac7ien0jg-1
Received: by mail-qv1-f69.google.com with SMTP id 6a1803df08f44-635ed44d2afso2653556d6.2
        for <linux-s390@vger.kernel.org>; Thu, 13 Jul 2023 00:17:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689232652; x=1691824652;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2LejsROT8ViVogg5eUBhr0atMu0AKpWZYVlQl+igMgI=;
        b=HW7dxnBlEUaLrcxVm4g00kiDOgx1nG6upK89wJdX7g/WcJl1w7QTO4PI3pc0S00TMe
         ojewdZDk4MgRbwKiPcylE4cPCeE2UPi7elZSkTQCIgR29MYba+A17pVG162zq8LIJHb7
         XDdZihvdccELjo1YoQAh04tjtOmMtuEXyfOOo0NFeNzCsvu33xP+Ri8dVHvCnZk6a955
         ocMXNYTPLukpGjw+wQ5BI4KXl4AbDzefYn6gTmgrZZmU6adL4biAw4mVJsz7QjFJO2qk
         eWXAbUDuKGIyBxk1igw8eG1eVQnBq1aAO0a+DQgyd0JmMj58SJWcHz0lMgIz7JwC7TMi
         mt8w==
X-Gm-Message-State: ABy/qLYZysna6Hnq+I0BJYc4EmQ3RHur6qIr+mth3a8U4yDoEM1swf9y
        ZYIjReGVbI88aNjKjt5kU1xchlJ0IQziLUxlHnpP0JO+pQiG9JAjNhw9PkAqC5dw/KMrn23dU+E
        0cGLYcqW0Ibdvn79avUxjoA==
X-Received: by 2002:a0c:f30d:0:b0:624:3af6:21d2 with SMTP id j13-20020a0cf30d000000b006243af621d2mr567936qvl.13.1689232651802;
        Thu, 13 Jul 2023 00:17:31 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH0ylf23Un3JPDLz8dfGb4y1DOBv9H5wy1gDTlXzqFZNaiT4razpM88Y+ZPQl79Gmw4hqpkXw==
X-Received: by 2002:a0c:f30d:0:b0:624:3af6:21d2 with SMTP id j13-20020a0cf30d000000b006243af621d2mr567926qvl.13.1689232651489;
        Thu, 13 Jul 2023 00:17:31 -0700 (PDT)
Received: from [10.33.192.205] (nat-pool-str-t.redhat.com. [149.14.88.106])
        by smtp.gmail.com with ESMTPSA id r3-20020a0ccc03000000b0063211e61875sm2849980qvk.14.2023.07.13.00.17.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 00:17:30 -0700 (PDT)
Message-ID: <9b2cdc37-0b93-ff00-d077-397b8c0c2950@redhat.com>
Date:   Thu, 13 Jul 2023 09:17:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To:     Nico Boehr <nrb@linux.ibm.com>, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org
References: <20230712114149.1291580-1-nrb@linux.ibm.com>
 <20230712114149.1291580-3-nrb@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Subject: Re: [kvm-unit-tests PATCH v5 2/6] s390x: add function to set DAT mode
 for all interrupts
In-Reply-To: <20230712114149.1291580-3-nrb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 12/07/2023 13.41, Nico Boehr wrote:
> When toggling DAT or switch address space modes, it is likely that
> interrupts should be handled in the same DAT or address space mode.
> 
> Add a function which toggles DAT and address space mode for all
> interruptions, except restart interrupts.
> 
> Signed-off-by: Nico Boehr <nrb@linux.ibm.com>
> ---
>   lib/s390x/asm/interrupt.h |  4 ++++
>   lib/s390x/interrupt.c     | 36 ++++++++++++++++++++++++++++++++++++
>   lib/s390x/mmu.c           |  5 +++--
>   3 files changed, 43 insertions(+), 2 deletions(-)
> 
> diff --git a/lib/s390x/asm/interrupt.h b/lib/s390x/asm/interrupt.h
> index 35c1145f0349..55759002dce2 100644
> --- a/lib/s390x/asm/interrupt.h
> +++ b/lib/s390x/asm/interrupt.h
> @@ -83,6 +83,10 @@ void expect_ext_int(void);
>   uint16_t clear_pgm_int(void);
>   void check_pgm_int_code(uint16_t code);
>   
> +#define IRQ_DAT_ON	true
> +#define IRQ_DAT_OFF	false

Just a matter of taste, but IMHO having defines like this for just using 
them as boolean parameter to one function is a little bit overkill already. 
I'd rather rename the "bool dat" below into "bool use_dat" and then use 
"true" and "false" directly as a parameter for that function instead. 
Anyway, just my 0.02 €.

> +void irq_set_dat_mode(bool dat, uint64_t as);
> +
>   /* Activate low-address protection */
>   static inline void low_prot_enable(void)
>   {
> diff --git a/lib/s390x/interrupt.c b/lib/s390x/interrupt.c
> index 3f993a363ae2..9b1bc6ce819d 100644
> --- a/lib/s390x/interrupt.c
> +++ b/lib/s390x/interrupt.c
> @@ -9,6 +9,7 @@
>    */
>   #include <libcflat.h>
>   #include <asm/barrier.h>
> +#include <asm/mem.h>
>   #include <asm/asm-offsets.h>
>   #include <sclp.h>
>   #include <interrupt.h>
> @@ -104,6 +105,41 @@ void register_ext_cleanup_func(void (*f)(struct stack_frame_int *))
>   	THIS_CPU->ext_cleanup_func = f;
>   }
>   
> +/**
> + * irq_set_dat_mode - Set the DAT mode of all interrupt handlers, except for
> + * restart.
> + * This will update the DAT mode and address space mode of all interrupt new
> + * PSWs.
> + *
> + * Since enabling DAT needs initalized CRs and the restart new PSW is often used

s/initalized/initialized/

> + * to initalize CRs, the restart new PSW is never touched to avoid the chicken

dito

> + * and egg situation.
> + *
> + * @dat specifies whether to use DAT or not
> + * @as specifies the address space mode to use - one of AS_PRIM, AS_ACCR,
> + * AS_SECN or AS_HOME.
> + */
> +void irq_set_dat_mode(bool dat, uint64_t as)

why uint64_t for "as" ? "int" should be enough?

(alternatively, you could turn the AS_* defines into a properly named enum 
and use that type here instead)

  Thomas

> +{
> +	struct psw* irq_psws[] = {
> +		OPAQUE_PTR(GEN_LC_EXT_NEW_PSW),
> +		OPAQUE_PTR(GEN_LC_SVC_NEW_PSW),
> +		OPAQUE_PTR(GEN_LC_PGM_NEW_PSW),
> +		OPAQUE_PTR(GEN_LC_MCCK_NEW_PSW),
> +		OPAQUE_PTR(GEN_LC_IO_NEW_PSW),
> +	};
> +	struct psw *psw;
> +
> +	assert(as == AS_PRIM || as == AS_ACCR || as == AS_SECN || as == AS_HOME);
> +
> +	for (size_t i = 0; i < ARRAY_SIZE(irq_psws); i++) {
> +		psw = irq_psws[i];
> +		psw->dat = dat;
> +		if (dat)
> +			psw->as = as;
> +	}
> +}
> +
>   static void fixup_pgm_int(struct stack_frame_int *stack)
>   {
>   	/* If we have an error on SIE we directly move to sie_exit */
> diff --git a/lib/s390x/mmu.c b/lib/s390x/mmu.c
> index b474d7021d3f..199bd3fbc9c8 100644
> --- a/lib/s390x/mmu.c
> +++ b/lib/s390x/mmu.c
> @@ -12,6 +12,7 @@
>   #include <asm/pgtable.h>
>   #include <asm/arch_def.h>
>   #include <asm/barrier.h>
> +#include <asm/interrupt.h>
>   #include <vmalloc.h>
>   #include "mmu.h"
>   
> @@ -41,8 +42,8 @@ static void mmu_enable(pgd_t *pgtable)
>   	/* enable dat (primary == 0 set as default) */
>   	enable_dat();
>   
> -	/* we can now also use DAT unconditionally in our PGM handler */
> -	lowcore.pgm_new_psw.mask |= PSW_MASK_DAT;
> +	/* we can now also use DAT in all interrupt handlers */
> +	irq_set_dat_mode(IRQ_DAT_ON, AS_PRIM);
>   }
>   
>   /*

