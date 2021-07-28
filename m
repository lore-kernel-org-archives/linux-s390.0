Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3762C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D446960FC0
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbhG1KdP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:33:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:28727 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231984AbhG1KdP (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 06:33:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627468393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IBnjip7bmZlo5iIFfE9USXwqXSxtKiL/lSH0+0EZMvE=;
        b=TGYPqAzsAE4/NcRsgdiq9Z1xC5AmLmWEcPWs7ypDslhvTQfjzvqrHNHKzrBxDwa7vpkILp
        GSjBstbxGWKm6PVmpHsD1yjmb0Y7eH5/aOmxJhVY6Yf7Al9sD/eVj+/WDEhR/V+pMopxPs
        bnZY+2rWm5rgXhKgOKAeKpcXP/9Fotw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-hYKihuwpOI2GrF2E6YK5iw-1; Wed, 28 Jul 2021 06:33:12 -0400
X-MC-Unique: hYKihuwpOI2GrF2E6YK5iw-1
Received: by mail-wr1-f71.google.com with SMTP id o8-20020a5d4a880000b029013a10564614so763267wrq.15
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 03:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=IBnjip7bmZlo5iIFfE9USXwqXSxtKiL/lSH0+0EZMvE=;
        b=TjB1KzJl4eG637/6viAql5RV7kWPn59rV+o4jtulwAPsAN9cnQvu/sMyrL199WBa0R
         QJYtbZFNKO1FGru8SucovUHevdfPhsoMTlejunvfRHA1LeWgPmaqIXy/2QdTKl5crKYR
         6zo2388s/8dgLAWMbaGQzu3ICZ7nSWucIZIavVLk+iPy4eur+r7Y/phIsnJIRPR9opjt
         vtiSQstxR8M+4kHIvXhDJVd7w4NxQMZTtaICXhp+GtOAy1A+hpqJNlVwoIrpC+xpzFjv
         n+mv7sLOj7FSbB2/JBLSu7II8hU+onNNv1/gjB3AyDPX5NxjzyEmuDp4PgjMU2QE1l8c
         Br5A==
X-Gm-Message-State: AOAM532qM2fPv3D/2HQp5+vcWwxui8ZTS4mxpoRX8hfz3NSY7Ut+9eUI
        kReYtqpHONI7M3hLVVEWxb8UPufTxCfbqXIDLYzyHaXlLHDEo9oSSqNNav9yFkbJMg7uRUfLGQv
        0HK8UZMpYjoexlDGBxuSGJA==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr19621480wrx.379.1627468391104;
        Wed, 28 Jul 2021 03:33:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzg+mRSLuRF0fKoIVNkZUaXxgdmcVCNiAJAjD+MCyNtOlp9tZSli5/Dg0H/oK/AX3nCaTBDpA==
X-Received: by 2002:a05:6000:1201:: with SMTP id e1mr19621459wrx.379.1627468390926;
        Wed, 28 Jul 2021 03:33:10 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id s3sm6128233wru.29.2021.07.28.03.33.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:33:10 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 1/3] s390x: Add SPDX and header comments
 for s390x/* and lib/s390x/*
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210728101328.51646-1-frankja@linux.ibm.com>
 <20210728101328.51646-2-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <7e33e33f-63ef-c4d9-50d9-c1df150af1e6@redhat.com>
Date:   Wed, 28 Jul 2021 12:33:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728101328.51646-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 12.13, Janosch Frank wrote:
> Seems like I missed adding them.
> 
> The s390x/sieve.c one is a bit of a head scratcher since it came with
> the first commit but I assume it's lpgl2-only since that's what the
> COPYRIGHT file said then.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/uv.c   |  9 +++++++++
>   s390x/mvpg-sie.c |  9 +++++++++
>   s390x/sie.c      | 10 ++++++++++
>   x86/sieve.c      |  5 +++++
>   4 files changed, 33 insertions(+)
> 
> diff --git a/lib/s390x/uv.c b/lib/s390x/uv.c
> index 0d8c141c..fd9de944 100644
> --- a/lib/s390x/uv.c
> +++ b/lib/s390x/uv.c
> @@ -1,3 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Ultravisor related functionality
> + *
> + * Copyright 2020 IBM Corp.
> + *
> + * Authors:
> + *    Janosch Frank <frankja@linux.ibm.com>
> + */
>   #include <libcflat.h>
>   #include <bitops.h>
>   #include <alloc.h>
> diff --git a/s390x/mvpg-sie.c b/s390x/mvpg-sie.c
> index 9bcd15a2..5e70f591 100644
> --- a/s390x/mvpg-sie.c
> +++ b/s390x/mvpg-sie.c
> @@ -1,3 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Tests mvpg SIE partial execution intercepts.
> + *
> + * Copyright 2021 IBM Corp.
> + *
> + * Authors:
> + *    Janosch Frank <frankja@linux.ibm.com>
> + */
>   #include <libcflat.h>
>   #include <asm/asm-offsets.h>
>   #include <asm-generic/barrier.h>
> diff --git a/s390x/sie.c b/s390x/sie.c
> index cfc746f3..134d3c4f 100644
> --- a/s390x/sie.c
> +++ b/s390x/sie.c
> @@ -1,3 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Tests SIE diagnose intercepts.
> + * Mainly used as a template for SIE tests.
> + *
> + * Copyright 2021 IBM Corp.
> + *
> + * Authors:
> + *    Janosch Frank <frankja@linux.ibm.com>
> + */
>   #include <libcflat.h>
>   #include <asm/asm-offsets.h>
>   #include <asm/arch_def.h>
> diff --git a/x86/sieve.c b/x86/sieve.c
> index 8150f2d9..b89d5f80 100644
> --- a/x86/sieve.c
> +++ b/x86/sieve.c
> @@ -1,3 +1,8 @@
> +/* SPDX-License-Identifier: LGPL-2.0-only */
> +/*
> + * Implementation of the sieve of Eratosthenes
> + * Calculation and memory intensive workload for general stress testing.
> + */
>   #include "alloc.h"
>   #include "libcflat.h"
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>

