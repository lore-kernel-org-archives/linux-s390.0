Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B5F2C432BE
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44F7560FC0
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 10:33:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234186AbhG1Kdo (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 06:33:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:36770 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235992AbhG1Kdn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 06:33:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627468421;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3H7VdrLA/CYVTJX3HgGL5wweGGgg7N9azTfzgCR+ivA=;
        b=NCKDlc3hVEXFonbGzfSQFynseZPfKtcc3unavkZH2PXv+HAgyfXqpESsjWLtV5OjekDG8K
        qEC6HdK7ZLEiV4zH6IJR4QkE8VsVKgB9PmrFJOZ3KJr80pNVIYO49Tp15wbk8CkuhALepw
        3xcUM3zMHlzWiF9Ot5Twv6GoytO+KoQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-lRoav58OOrCfsw770JCD_Q-1; Wed, 28 Jul 2021 06:33:40 -0400
X-MC-Unique: lRoav58OOrCfsw770JCD_Q-1
Received: by mail-wr1-f70.google.com with SMTP id c5-20020a5d52850000b0290126f2836a61so765727wrv.6
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 03:33:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=3H7VdrLA/CYVTJX3HgGL5wweGGgg7N9azTfzgCR+ivA=;
        b=XyuigW3iPYsYhyLaKXXboEHonB4l4oG9t8fXj5h0Fzo6nXj1QCItU4P2XEirGdh53L
         h919JIKj+WCUjbTcUNA0lD0Gw0QKfXWXwdpJPw+MB3akRc2bhN1xiRTXT32QCgSZTzm4
         OkY3sHZTYZYbUiJojTcIeLi0NE0CrCxgzvRAt56BD8e7I8jOPY/aI6EBXGtree+yr3wM
         iYaPScliJg4tByIKn6H4VKOFMGrIbdHGEcdMT4CtyNIuEHBpNuhdBq9zggDd/km4oN6d
         5TRfMEEqe0axkawW6hsIChS70fvv98t2E7sKzEnDiZwLis5bcXy+Ss2KbJMQb1ypD8JG
         OiCA==
X-Gm-Message-State: AOAM5328gDhpiYoMlJINbH4CyOGAACK6QKt+21/wDMeNhR7Qj9ag6FuH
        e9IllrAcMPtv59eK5rGuNxMUqBRow/jnLaOtb5UzUb4i523Pz33crh1b3UbF7oxnT79erydeWB1
        IKf2mFbVlAOM/K1ESMPkF2Q==
X-Received: by 2002:a5d:6891:: with SMTP id h17mr14638009wru.324.1627468418074;
        Wed, 28 Jul 2021 03:33:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHBEtfgAVa9u4YzKDq2rAkt19MZ6n4L8GkURVIrzPj+XQ0U8HePAVK6D4pR3TNrlkcik/rsQ==
X-Received: by 2002:a5d:6891:: with SMTP id h17mr14637991wru.324.1627468417889;
        Wed, 28 Jul 2021 03:33:37 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id x16sm6431492wru.40.2021.07.28.03.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 03:33:37 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH 2/3] s390x: Add SPDX and header comments
 for the snippets folder
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210728101328.51646-1-frankja@linux.ibm.com>
 <20210728101328.51646-3-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <72511217-a0ec-6a6c-dea7-20484e255ac8@redhat.com>
Date:   Wed, 28 Jul 2021 12:33:36 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728101328.51646-3-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 12.13, Janosch Frank wrote:
> Seems like I missed adding them.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   s390x/snippets/c/cstart.S       | 9 +++++++++
>   s390x/snippets/c/mvpg-snippet.c | 9 +++++++++
>   2 files changed, 18 insertions(+)
> 
> diff --git a/s390x/snippets/c/cstart.S b/s390x/snippets/c/cstart.S
> index 242568d6..a1754808 100644
> --- a/s390x/snippets/c/cstart.S
> +++ b/s390x/snippets/c/cstart.S
> @@ -1,3 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Start assembly for snippets
> + *
> + * Copyright (c) 2021 IBM Corp.
> + *
> + * Authors:
> + *  Janosch Frank <frankja@linux.ibm.com>
> + */
>   #include <asm/sigp.h>
>   
>   .section .init
> diff --git a/s390x/snippets/c/mvpg-snippet.c b/s390x/snippets/c/mvpg-snippet.c
> index c1eb5d77..e55caab4 100644
> --- a/s390x/snippets/c/mvpg-snippet.c
> +++ b/s390x/snippets/c/mvpg-snippet.c
> @@ -1,3 +1,12 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Snippet used by the mvpg-sie.c test to check SIE PEI intercepts.
> + *
> + * Copyright (c) 2021 IBM Corp
> + *
> + * Authors:
> + *  Janosch Frank <frankja@linux.ibm.com>
> + */
>   #include <libcflat.h>
>   
>   static inline void force_exit(void)
> 

Reviewed-by: Thomas Huth <thuth@redhat.com>

