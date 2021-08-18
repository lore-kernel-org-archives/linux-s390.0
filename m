Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-19.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1011EC4338F
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 09:28:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E75E960ED5
	for <linux-s390@archiver.kernel.org>; Wed, 18 Aug 2021 09:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbhHRJ3L (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 18 Aug 2021 05:29:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:54117 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231910AbhHRJ3H (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 18 Aug 2021 05:29:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629278913;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ss0YteSxGieknf/N001L6Bbd+tVJgnRWWRu4Uer/1WI=;
        b=QKNU1oNzhYZg7M92aodDAEiNp7zZCrZUQZdl28ZE3Fc7GIAKf99/onGmaXCd+0aAKm2USP
        7SXMx4Tt43VaIQp+aLMafZoVP0RGHLpPisB8V7qMHU30aH4e631EfBrFmpO3soGAWZuimR
        Obln96FW5JByJcpW9OYpn7oepotS3q8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-516-3SNozVhLMROJuw-B338JuA-1; Wed, 18 Aug 2021 05:28:32 -0400
X-MC-Unique: 3SNozVhLMROJuw-B338JuA-1
Received: by mail-ed1-f72.google.com with SMTP id b25-20020a05640202d9b02903be7281a80cso741078edx.3
        for <linux-s390@vger.kernel.org>; Wed, 18 Aug 2021 02:28:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ss0YteSxGieknf/N001L6Bbd+tVJgnRWWRu4Uer/1WI=;
        b=a+5c+PQOYY3/mJiyadSdd7R/rFkqWERPCeK2xMjLyB2jGekyouQmcE3FlN+JiKhh+6
         J3q6HiJafeBX8WazfHaRkYnrkhF/4mlTrgA/n1gVDsthcwvNKiq7VxvzQBZGVwRI7K8a
         0bOclQ0XLYoQuUKHa/HBThgjCRgAdCF5ECDxErJGRgqVcoCCMwDYbKGSwP0UzLh6gLXM
         rsnUVrVNtwTEgInGz9zHdCS6Eqdwp0w2r+yIK4uIAKPvlwmT5LWo66TQZrr/352jgbJ/
         rGo31zXObWVv2w6uLKmrRpDqlpAwlfxwvr6iVygJPgFYEDwVynSI/xGfDy9jspPDLA6m
         pV4Q==
X-Gm-Message-State: AOAM5330hIGP/WiqDwmoj/9m5mGcysluI7e7W480BQWoYIbCWO4l2t+A
        24PB7JpHYylllATT+eYM2RT4QlKfcYB7vdU09WEhiaCXZuUunSBCtr9nV0yn7C79MYV59Zxb5NQ
        zctjHlXaowGXjXN2gdc27gA==
X-Received: by 2002:a17:906:c249:: with SMTP id bl9mr8838938ejb.225.1629278910823;
        Wed, 18 Aug 2021 02:28:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2i3IaJ6FUHdnF7ye+k0n1lpDd35whxOvMpbIkocaOGGDMWrn6gFBYEsKYZJiDIyide4gNYg==
X-Received: by 2002:a17:906:c249:: with SMTP id bl9mr8838930ejb.225.1629278910663;
        Wed, 18 Aug 2021 02:28:30 -0700 (PDT)
Received: from thuth.remote.csb (pd9e83070.dip0.t-ipconnect.de. [217.232.48.112])
        by smtp.gmail.com with ESMTPSA id l19sm2271962edq.62.2021.08.18.02.28.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Aug 2021 02:28:30 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 6/8] lib: s390x: Add PSW_MASK_64
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210813073615.32837-1-frankja@linux.ibm.com>
 <20210813073615.32837-7-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <76f5c0bb-6a28-c480-6b69-25056accb5b6@redhat.com>
Date:   Wed, 18 Aug 2021 11:28:29 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210813073615.32837-7-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 13/08/2021 09.36, Janosch Frank wrote:
> Let's replace the magic 0x0000000180000000ULL numeric constants with
> PSW_MASK_64 as it's used more often since the introduction of smp and
> sie.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/arch_def.h | 3 +++
>   lib/s390x/smp.c          | 2 +-
>   s390x/mvpg-sie.c         | 2 +-
>   s390x/sie.c              | 2 +-
>   s390x/skrf.c             | 6 +++---
>   5 files changed, 9 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/arch_def.h b/lib/s390x/asm/arch_def.h
> index 39c5ba99..245453c3 100644
> --- a/lib/s390x/asm/arch_def.h
> +++ b/lib/s390x/asm/arch_def.h
> @@ -50,6 +50,9 @@ struct psw {
>   #define PSW_MASK_DAT			0x0400000000000000UL
>   #define PSW_MASK_WAIT			0x0002000000000000UL
>   #define PSW_MASK_PSTATE			0x0001000000000000UL
> +#define PSW_MASK_EA			0x0000000100000000UL
> +#define PSW_MASK_BA			0x0000000080000000UL
> +#define PSW_MASK_64			PSW_MASK_BA | PSW_MASK_EA;

Please put some parentheses around PSW_MASK_BA | PSW_MASK_EA and remove the 
semicolon at the end.

  Thomas

