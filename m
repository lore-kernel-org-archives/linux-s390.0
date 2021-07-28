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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA14C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:34:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9561060EB2
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:34:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbhG1KeS (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:34:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45205 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232094AbhG1KeS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 06:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627468456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hAcSWafNguMvEGYesVLx4c2+nv9O4pUOypF8+s9U8vw=;
        b=RYz79oA9xeXvGJgyxLYx0hrjQtt9IH7fV4+X1CfmVzSjPg1bHh+R42FZkRFPsJMaR7S6Xz
        f98RlxmNJr4Fh/BTtGC8vGIIkTvKLqWHY1p+xhG9SNhQAckZncrGw1bPddNuHrVyhNlB2U
        BOLaZl1TM9W/yWV15sVFL0RzkVYHAVQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-555-gIFyM08COWWlhok4QncE3A-1; Wed, 28 Jul 2021 06:34:15 -0400
X-MC-Unique: gIFyM08COWWlhok4QncE3A-1
Received: by mail-wr1-f72.google.com with SMTP id l7-20020a5d48070000b0290153b1557952so767213wrq.16
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 03:34:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hAcSWafNguMvEGYesVLx4c2+nv9O4pUOypF8+s9U8vw=;
        b=fKX9bQ9tY0273mKTTeFgBLvKLCqKrEqgb5ewsvYJpP9EADnHP5TRnv+vJMBqhnUNFT
         7+l0yaOfxysjH8Wr4h6+5bUZsiEm5jj3YdQvy/lfiD2vqCnMY6fh16htXFTOuSGyVp69
         NFsCwvxXx/6BgmTnbwwRoN63CFT00LcQ0nc1sMHyY9SuCSPepZFj4sAU8GxZ6GRyToe9
         pe8ftRKaMiOpyO/nGNlbhRZfPgi+Av6AYz8ihEeQltDBH00Gi3VvlBkWqXEs0sk1Gu81
         ZkukH0WBhfiYI5KzDpE3g+4ypdMjuVaZ0CR1ciQ2x3jDOYmne6dW5pOQKzUFNl1aVrwf
         wXrg==
X-Gm-Message-State: AOAM5322PfaJSG8ze77LI1Q2BeZ6f2CC2BwhR1qIOI7cV5OVjOo2F0J9
        UEczLjFsDm2v+07MoEbAiSyIabZZaRZptYRjnJHEYS5CWwhaz/ff6Ke0i6VSneW3wFCMUHBiiSO
        x0g7LB1yaMtP26TFghYCDTw==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr8823294wmg.46.1627468454083;
        Wed, 28 Jul 2021 03:34:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwhIx2/y5YYSvM37fbLL/GIWOnAVcoWk2GZD97Ng8SibdgZi5hprMteZXzq2lID6AARxMdEjA==
X-Received: by 2002:a1c:20ce:: with SMTP id g197mr8823274wmg.46.1627468453857;
        Wed, 28 Jul 2021 03:34:13 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id z17sm3075227wrt.47.2021.07.28.03.34.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:34:13 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 3/3] s390x: Fix my mail address in the
 headers
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210728101328.51646-1-frankja@linux.ibm.com>
 <20210728101328.51646-4-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <ce5bd14b-70bc-6290-be1e-f8e617219851@redhat.com>
Date:   Wed, 28 Jul 2021 12:34:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728101328.51646-4-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 12.13, Janosch Frank wrote:
> I used the wrong one once and then copied it over...
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/asm/mem.h | 2 +-
>   lib/s390x/mmu.h     | 2 +-
>   lib/s390x/stack.c   | 2 +-
>   s390x/gs.c          | 2 +-
>   s390x/iep.c         | 2 +-
>   s390x/vector.c      | 2 +-
>   6 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/lib/s390x/asm/mem.h b/lib/s390x/asm/mem.h
> index 1963cef7..40b22b63 100644
> --- a/lib/s390x/asm/mem.h
> +++ b/lib/s390x/asm/mem.h
> @@ -3,7 +3,7 @@
>    * Physical memory management related functions and definitions.
>    *
>    * Copyright IBM Corp. 2018
> - * Author(s): Janosch Frank <frankja@de.ibm.com>
> + * Author(s): Janosch Frank <frankja@linux.ibm.com>
>    */
>   #ifndef _ASMS390X_MEM_H_
>   #define _ASMS390X_MEM_H_
> diff --git a/lib/s390x/mmu.h b/lib/s390x/mmu.h
> index ab35d782..15f88e4f 100644
> --- a/lib/s390x/mmu.h
> +++ b/lib/s390x/mmu.h
> @@ -5,7 +5,7 @@
>    * Copyright (c) 2018 IBM Corp
>    *
>    * Authors:
> - *	Janosch Frank <frankja@de.ibm.com>
> + *	Janosch Frank <frankja@linux.ibm.com>
>    */
>   #ifndef _S390X_MMU_H_
>   #define _S390X_MMU_H_
> diff --git a/lib/s390x/stack.c b/lib/s390x/stack.c
> index 4cf80dae..e714e07c 100644
> --- a/lib/s390x/stack.c
> +++ b/lib/s390x/stack.c
> @@ -8,7 +8,7 @@
>    * Authors:
>    *  Thomas Huth <thuth@redhat.com>
>    *  David Hildenbrand <david@redhat.com>
> - *  Janosch Frank <frankja@de.ibm.com>
> + *  Janosch Frank <frankja@linux.ibm.com>
>    */
>   #include <libcflat.h>
>   #include <stack.h>
> diff --git a/s390x/gs.c b/s390x/gs.c
> index a017a97d..7567bb78 100644
> --- a/s390x/gs.c
> +++ b/s390x/gs.c
> @@ -6,7 +6,7 @@
>    *
>    * Authors:
>    *    Martin Schwidefsky <schwidefsky@de.ibm.com>
> - *    Janosch Frank <frankja@de.ibm.com>
> + *    Janosch Frank <frankja@linux.ibm.com>
>    */
>   #include <libcflat.h>
>   #include <asm/page.h>
> diff --git a/s390x/iep.c b/s390x/iep.c
> index 906c77b3..8d5e044b 100644
> --- a/s390x/iep.c
> +++ b/s390x/iep.c
> @@ -5,7 +5,7 @@
>    * Copyright (c) 2018 IBM Corp
>    *
>    * Authors:
> - *	Janosch Frank <frankja@de.ibm.com>
> + *	Janosch Frank <frankja@linux.ibm.com>
>    */
>   #include <libcflat.h>
>   #include <vmalloc.h>
> diff --git a/s390x/vector.c b/s390x/vector.c
> index fdb0eee2..c8c14e33 100644
> --- a/s390x/vector.c
> +++ b/s390x/vector.c
> @@ -5,7 +5,7 @@
>    * Copyright 2018 IBM Corp.
>    *
>    * Authors:
> - *    Janosch Frank <frankja@de.ibm.com>
> + *    Janosch Frank <frankja@linux.ibm.com>
>    */
>   #include <libcflat.h>
>   #include <asm/page.h>
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

