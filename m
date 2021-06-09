Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C51FC48BCD
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:47:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FFEA610A1
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:47:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238184AbhFIOsz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:48:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34240 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238165AbhFIOst (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 10:48:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623250014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t0hZQMWWxDl7Xi8l29AWO8IasO+rf5yU93tb5RzLQ7g=;
        b=hQp5IV7fTOiU7oEAh9Gq1XUQ0s8bg4UC8Af9hkh4tuVGo7P24gJ+HJhULDqXnt/o0vLxwC
        oI1PRtjIXmD1zyS7yLA7QFtHfFrscEy1JUspv384DNdvDztwqWf1hJ3dKg+cV034yRDBj1
        FNFjrWzIhG+fcMznWVLgOWnRAojzfVQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-5kaflTEFPwW25BukMuJIcA-1; Wed, 09 Jun 2021 10:46:53 -0400
X-MC-Unique: 5kaflTEFPwW25BukMuJIcA-1
Received: by mail-wm1-f72.google.com with SMTP id r4-20020a7bc0840000b02901b7cb5713ecso622681wmh.1
        for <linux-s390@vger.kernel.org>; Wed, 09 Jun 2021 07:46:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=t0hZQMWWxDl7Xi8l29AWO8IasO+rf5yU93tb5RzLQ7g=;
        b=GGRDgqsRc6O+ClkVfAUFmWJQUboSCNIGP2BDA6RoyDsm/VJKYXOpLQyDlafA73ls/C
         9lLh9NnnhbIkS0uCMRXPCTB1WrGBuEN8BWVlQ6yf7O+CGnl30vZIBXvA4pfQydvBLGWs
         1h/rnZ/HKytJfNWkFLor3cwYfpDXL5CJ2/Ah3hUagERrJ0Lx16bs8BHaS7r7jT+fbGsF
         DwdN7uoDNXXhrN3F2JAdLY+wOf+bgaVDrr4rF06Nk4iE9kdKGuwLOEhCcTlgS26f1ZTb
         XkXEbB/FHmY+zYTIZ4KEfn2gjuT/oYpmhfX15YcJCfM9CdeYhOB5zXKtIxOl1XFw9tc3
         lciA==
X-Gm-Message-State: AOAM533brVEkaFTUuFF82G0JxNiON99ZtgfHFO0/WdA0K92A190P825y
        hrLbbTrv5L/chU3s7uxqFsMpEusyADMZwVBUtpgwThDwYo4f/YtmaI0rwC0trwW6oPsGPPrWw3u
        KaI4xN8LzI+VKCXcpbtqILh7fOULphO5eBbRg8OLMbM35p5SLifHfz8t+opsIp7F1xcBY1A==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr10383529wmq.31.1623250012138;
        Wed, 09 Jun 2021 07:46:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzboBk7WBqh0GgSbryL8mzgfVK8EI4S6S8GDygMVs49zQtyl7XBe/7JeBQTIe1GgwDVwlYqzQ==
X-Received: by 2002:a05:600c:19d1:: with SMTP id u17mr10383492wmq.31.1623250011775;
        Wed, 09 Jun 2021 07:46:51 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id e16sm175080wrw.49.2021.06.09.07.46.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:46:51 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 4/7] arm: unify header guards
To:     Cornelia Huck <cohuck@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Huth <thuth@redhat.com>,
        Andrew Jones <drjones@redhat.com>
Cc:     kvm@vger.kernel.org, Laurent Vivier <lvivier@redhat.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        kvmarm@lists.cs.columbia.edu, kvm-ppc@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20210609143712.60933-1-cohuck@redhat.com>
 <20210609143712.60933-5-cohuck@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <97d532a5-af52-c2f6-0f0f-7334299aef1a@redhat.com>
Date:   Wed, 9 Jun 2021 16:46:50 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609143712.60933-5-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09.06.21 16:37, Cornelia Huck wrote:
> The assembler.h files were the only ones not already following
> the convention.
> 
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   lib/arm/asm/assembler.h   | 6 +++---
>   lib/arm64/asm/assembler.h | 6 +++---
>   2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/arm/asm/assembler.h b/lib/arm/asm/assembler.h
> index dfd3c51bf6ad..4200252dd14d 100644
> --- a/lib/arm/asm/assembler.h
> +++ b/lib/arm/asm/assembler.h
> @@ -8,8 +8,8 @@
>   #error "Only include this from assembly code"
>   #endif
>   
> -#ifndef __ASM_ASSEMBLER_H
> -#define __ASM_ASSEMBLER_H
> +#ifndef _ASMARM_ASSEMBLER_H_
> +#define _ASMARM_ASSEMBLER_H_
>   
>   /*
>    * dcache_line_size - get the minimum D-cache line size from the CTR register
> @@ -50,4 +50,4 @@
>   	dsb	\domain
>   	.endm
>   
> -#endif	/* __ASM_ASSEMBLER_H */
> +#endif	/* _ASMARM_ASSEMBLER_H_ */
> diff --git a/lib/arm64/asm/assembler.h b/lib/arm64/asm/assembler.h
> index 0a6ab9720bdd..a271e4ceefe6 100644
> --- a/lib/arm64/asm/assembler.h
> +++ b/lib/arm64/asm/assembler.h
> @@ -12,8 +12,8 @@
>   #error "Only include this from assembly code"
>   #endif
>   
> -#ifndef __ASM_ASSEMBLER_H
> -#define __ASM_ASSEMBLER_H
> +#ifndef _ASMARM64_ASSEMBLER_H_
> +#define _ASMARM64_ASSEMBLER_H_
>   
>   /*
>    * raw_dcache_line_size - get the minimum D-cache line size on this CPU
> @@ -51,4 +51,4 @@
>   	dsb	\domain
>   	.endm
>   
> -#endif	/* __ASM_ASSEMBLER_H */
> +#endif	/* _ASMARM64_ASSEMBLER_H_ */
> 

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

