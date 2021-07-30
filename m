Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7503C4338F
	for <linux-s390@archiver.kernel.org>; Fri, 30 Jul 2021 14:46:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B061E60C40
	for <linux-s390@archiver.kernel.org>; Fri, 30 Jul 2021 14:46:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239276AbhG3Oqz (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 30 Jul 2021 10:46:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55736 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239142AbhG3Oqv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 30 Jul 2021 10:46:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627656403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nD2LfDK5V0KudzsHM8L+/67w/lp/ADAceaawIhpxJt8=;
        b=LricX92Rvcf4DXgR8gOBH0pRCe1PjcV+MI3N53yHCGm7+bTVhvyeil+wfbE/MiT/c2QxhM
        HJWx5mRJdce9QG8OahK6YnPCK1xhqOqMmacl9oRvVegj8Y/8+NcBR/5jRlh/nR0+LQpMaX
        S6KF6jT70UyIm3YRC6juw5NDgtBgnAI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-73-MY-4YxG4NQmr3q6qTajaIg-1; Fri, 30 Jul 2021 10:46:41 -0400
X-MC-Unique: MY-4YxG4NQmr3q6qTajaIg-1
Received: by mail-wr1-f72.google.com with SMTP id f6-20020adfe9060000b0290153abe88c2dso3294868wrm.20
        for <linux-s390@vger.kernel.org>; Fri, 30 Jul 2021 07:46:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=nD2LfDK5V0KudzsHM8L+/67w/lp/ADAceaawIhpxJt8=;
        b=eo1jIdoIr6xb44tDZXRxBqiv+J7EOHeZJVHA5YlKTe8qSyGM1wbrGVq66CpEb8xk9i
         w0vNDngED4dKqW4GkYiJcJ3gQ72TIDImRMdOJYnIYDDBwNN5I2OMZml6Psp9PiLYeYm5
         5aC8n1ir0EWNF2d483QClqE7fbMYQMSReJFw/z4JQPgs1tFFl40LeoAoADKOXlqJJRbT
         WRUcNQeXdF5rg0a5A6u4ZBYBuM96bRzfxaQTPvGbOWV+nmeoubW2Snl5js3jgl+sjmHF
         lgiB1gFICIyLcc5yhbW3Bx0LzZVVzMKGUh2HGFW0E6FEw2VwkSnDlKg5ZxMXj1Hvd+wG
         UTww==
X-Gm-Message-State: AOAM530rL1nbH4XIqabD6+W5RWoWSymRCyPGhzcV6CAh1QIUVg3PpySa
        qY9KYNeo1ehVxrWi2EUCX1HcesHH/QM9jZMBY8tV/5eG7ofzZbiRX6BNRldWxhlkeEj4HVODndj
        8hywmUEdeKF40HZu3gDTqfQ==
X-Received: by 2002:adf:f110:: with SMTP id r16mr3440008wro.358.1627656393994;
        Fri, 30 Jul 2021 07:46:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyoe56kStW4UdUBwmtRKFzNS0WDSMqier5up9gpHBjzBCacrkuBdo+oN2BtQ90dqB3KLYTX/w==
X-Received: by 2002:adf:f110:: with SMTP id r16mr3439991wro.358.1627656393850;
        Fri, 30 Jul 2021 07:46:33 -0700 (PDT)
Received: from thuth.remote.csb (p5791d280.dip0.t-ipconnect.de. [87.145.210.128])
        by smtp.gmail.com with ESMTPSA id j5sm1909395wrs.22.2021.07.30.07.46.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jul 2021 07:46:33 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/4] s390x: lib: Introduce HPAGE_*
 constants
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210729134803.183358-1-frankja@linux.ibm.com>
 <20210729134803.183358-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <820e39e3-3ea4-42e5-c89e-f271bb25b886@redhat.com>
Date:   Fri, 30 Jul 2021 16:46:32 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210729134803.183358-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 29/07/2021 15.48, Janosch Frank wrote:
> They come in handy when working with 1MB blocks/addresses.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/page.h | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/lib/s390x/asm/page.h b/lib/s390x/asm/page.h
> index f130f936..2f4afd06 100644
> --- a/lib/s390x/asm/page.h
> +++ b/lib/s390x/asm/page.h
> @@ -35,4 +35,8 @@ typedef struct { pteval_t pte; } pte_t;
>   #define __pmd(x)	((pmd_t) { (x) } )
>   #define __pte(x)	((pte_t) { (x) } )
>   
> +#define HPAGE_SHIFT		20
> +#define HPAGE_SIZE		(_AC(1,UL) << HPAGE_SHIFT)
> +#define HPAGE_MASK		(~(HPAGE_SIZE-1))
> +
>   #endif
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

