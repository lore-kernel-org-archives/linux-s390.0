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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D66AC48BCD
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:45:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3301A60C41
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:45:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238086AbhFIOre (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:47:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:46568 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231162AbhFIOrc (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 9 Jun 2021 10:47:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1623249937;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tnzGT8LB+qqMPyhJStfYGlKykN8fg6Vcl9Y43OphKvE=;
        b=FltXgozsdU5YjSr6PxEIBjs51ZeeoCGVOxczcYeSBH1wbhsuxY3gf9FatwI9hTDLHA6kWj
        OCejbUBMCcDoCT40qmgONxO4ZYCNwXskSFsyRSLgGCR2bzN6vvmPTbS+WxiF7q6AUyC99A
        RtE/SHtGtGlE43sj9mjSsL2Tiqk5rK4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-134-saP1L8KHNqGBjKulzGFBmw-1; Wed, 09 Jun 2021 10:45:35 -0400
X-MC-Unique: saP1L8KHNqGBjKulzGFBmw-1
Received: by mail-wm1-f72.google.com with SMTP id h206-20020a1cb7d70000b0290198e478dfeaso894394wmf.3
        for <linux-s390@vger.kernel.org>; Wed, 09 Jun 2021 07:45:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:organization
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=tnzGT8LB+qqMPyhJStfYGlKykN8fg6Vcl9Y43OphKvE=;
        b=gc259NJ5WjdeyeWbc37HPHGcN4q3ZFOLKz3gLO/sODSiWXAVn1mJqv4owWRAj8xKl0
         La2hAdsZkLpDG9prHg0TZtLAIx0GtBjOyGjbYPOMf+s0Vj/qhJaQ7QkWwoko1EKCaQsF
         p8YPwPoibHdfR+nYS8zAqZhoe2/2JWZTtMaqitAVicT7B2o0YnR157tSmaqYv5AsENCY
         MfZHz8StTJ2r9BIXYG2qTRA/wiPgJaSQXeN0wv5hSGvJiTAh4/y14VrGIrTLzO7ukVtg
         wTBaaDFIltZISOVoZuf4Sug+dTAf6TTfN1aW3G3gluguJdJiw0kCeHgMvEwygkdpy6Ym
         ppyw==
X-Gm-Message-State: AOAM531NVeIzDrRqgx882elA4SWpYplIDcRUPRj0KvOQ6bp4dPF2DTDS
        d91MHedgIg1TSmTi2MgkYqtz6lgjb3m+rwpkKAp7+OcNXWIuXgU502KKTiIjL0I5C7RNxjJgUG1
        /X3LS2ibnWnXZFKUKjR6EStcyYE19MAsQ9ebF2++tHVLVjYT3wstA4QaNYRDCyO+DpdOoHw==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr166319wri.61.1623249934325;
        Wed, 09 Jun 2021 07:45:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBlt+Qd2SzrFOQD3lcTBbx/uITEZdEoScRy5/tAvd6+BgUrQgY42qMDWZ4IPIP1cvrcUECgg==
X-Received: by 2002:a05:6000:188d:: with SMTP id a13mr166282wri.61.1623249934070;
        Wed, 09 Jun 2021 07:45:34 -0700 (PDT)
Received: from [192.168.3.132] (p5b0c611d.dip0.t-ipconnect.de. [91.12.97.29])
        by smtp.gmail.com with ESMTPSA id k82sm6877536wmf.11.2021.06.09.07.45.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:45:33 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2 1/7] README.md: add guideline for header
 guards format
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
 <20210609143712.60933-2-cohuck@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Message-ID: <4884a501-939e-a343-7cb3-a31d2f59914f@redhat.com>
Date:   Wed, 9 Jun 2021 16:45:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210609143712.60933-2-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 09.06.21 16:37, Cornelia Huck wrote:
> Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> ---
>   README.md | 9 +++++++++
>   1 file changed, 9 insertions(+)
> 
> diff --git a/README.md b/README.md
> index 24d4bdaaee0d..687ff50d0af1 100644
> --- a/README.md
> +++ b/README.md
> @@ -156,6 +156,15 @@ Exceptions:
>   
>     - While the kernel standard requires 80 columns, we allow up to 120.
>   
> +Header guards:
> +
> +Please try to adhere to adhere to the following patterns when adding
> +"#ifndef <...> #define <...>" header guards:
> +    ./lib:             _HEADER_H_
> +    ./lib/<ARCH>:      _ARCH_HEADER_H_
> +    ./lib/<ARCH>/asm:  _ASMARCH_HEADER_H_

I'd have used _ARCH_ASM_HEADER_H_

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Thanks,

David / dhildenb

