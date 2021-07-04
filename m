Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8356FC07E95
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 07:45:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58C1F61357
	for <linux-s390@archiver.kernel.org>; Sun,  4 Jul 2021 07:45:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbhGDHsW (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sun, 4 Jul 2021 03:48:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21751 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229529AbhGDHsW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 4 Jul 2021 03:48:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625384746;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=t1Gb4Gbd7xkRwBneJi/dyKuYm8JJapDVv+41hhK6Pwk=;
        b=XNPY/ptiCF6HYEr10y00+65jv0TdL2C/Lqa9fMWqcPsdJRC+Pat0nlPwYzT52uptbrLJh0
        W5dBhRnlTBhgSFOMzD2cIpQM+TDbuU0U7jaPNV50Ovn82nljrPCQZwfkOmDkEMCqHQF0oX
        FmaGU2hpHiIqDuekNDrUqlkxIgrXowI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-250-nDLyJBpAMJudNaoV2KtLew-1; Sun, 04 Jul 2021 03:45:43 -0400
X-MC-Unique: nDLyJBpAMJudNaoV2KtLew-1
Received: by mail-wm1-f70.google.com with SMTP id t82-20020a1cc3550000b02901ee1ed24f94so8163943wmf.9
        for <linux-s390@vger.kernel.org>; Sun, 04 Jul 2021 00:45:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=t1Gb4Gbd7xkRwBneJi/dyKuYm8JJapDVv+41hhK6Pwk=;
        b=NsvMrugX/iDLKZL2pj6ZiqSZGFPp3q1VGp5/2nLKq7SYCEcB5TQ6vWDZwwarVqGqXa
         8HUxXMdGrgdXcsLfwRqA4BNsb4+3yljBcyFKw/DkFkFdIWtLfZXX9zPzmQerg3ySJaw9
         6ob9BUT/4rIjg9FUxocupTybtNq6BatBCRRThwLEyRw5m9RZmCvJu5uY+Q4vVVyusXYV
         MQfKb6IrwoCPQplGptyzGiLQntkrOr8wpJLR/3OW61pyI724BgiFPB4VPYkgZRPa9up4
         cTpyWu3wHDz7o80oX8fUAYqpm59niXTFx79SOOKA6vJehWn1LFHSA26vMttV1sXTPhuu
         CNLg==
X-Gm-Message-State: AOAM530QWaa0REGqeEOjZm939Yja+eC54zC7wK82noYT5+sgbYjsxOAz
        ZptVJszd2QqeYhVanFSj8Q30rtm6LVeHerMoEM394H2Hf0OXENZ6+LtUlCaLfWhpcZGAZM35dw1
        9UWh7cYoq3FxeVmniubKd/w==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr8602367wmi.107.1625384742786;
        Sun, 04 Jul 2021 00:45:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzj0Ugoz9yao1AAb5cz9Y0Weyu+UXNHEv6oa7LHhCk4CeHzMXz0V2Ud/jjCzEE7aniZbjFEJA==
X-Received: by 2002:a7b:c107:: with SMTP id w7mr8602350wmi.107.1625384742535;
        Sun, 04 Jul 2021 00:45:42 -0700 (PDT)
Received: from thuth.remote.csb (p5791d89b.dip0.t-ipconnect.de. [87.145.216.155])
        by smtp.gmail.com with ESMTPSA id r3sm6068485wrz.89.2021.07.04.00.45.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jul 2021 00:45:42 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/5] s390x: sie: Fix sie.h integer types
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210629133322.19193-1-frankja@linux.ibm.com>
 <20210629133322.19193-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <2cbcce3b-1311-536d-4eec-66f08e3d379b@redhat.com>
Date:   Sun, 4 Jul 2021 09:45:39 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210629133322.19193-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/06/2021 15.33, Janosch Frank wrote:
> Let's only use the uint*_t types.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/sie.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/lib/s390x/sie.h b/lib/s390x/sie.h
> index b4bb78c..6ba858a 100644
> --- a/lib/s390x/sie.h
> +++ b/lib/s390x/sie.h
> @@ -173,9 +173,9 @@ struct kvm_s390_sie_block {
>   } __attribute__((packed));
>   
>   struct vm_save_regs {
> -	u64 grs[16];
> -	u64 fprs[16];
> -	u32 fpc;
> +	uint64_t grs[16];
> +	uint64_t fprs[16];
> +	uint32_t fpc;
>   };
>   
>   /* We might be able to nestle all of this into the stack frame. But
> @@ -191,7 +191,7 @@ struct vm {
>   	struct kvm_s390_sie_block *sblk;
>   	struct vm_save_area save_area;
>   	/* Ptr to first guest page */
> -	u8 *guest_mem;
> +	uint8_t *guest_mem;
>   };

Yes, that's more consistent in this file.

Reviewed-by: Thomas Huth <thuth@redhat.com>

