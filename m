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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 041D4C4338F
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 14:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D27F660F91
	for <linux-s390@archiver.kernel.org>; Wed, 28 Jul 2021 14:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236837AbhG1Ofp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 28 Jul 2021 10:35:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:49499 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236667AbhG1Ofo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Jul 2021 10:35:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1627482941;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ns4+hvb10pCv09UW5xpgn10rDpJ/aUkX8DQEOdyq8JY=;
        b=IfaZdKaXnSgLTo5YAIGQ+ZNt1lreaUakh64ESLzCW7jKwnPPF1mVFqmV++JhUaSY160Mxd
        AuuBIi0ZhQo3+waaoowvqsyBZ/rR5x6JjDR4adJ6TAoco0A5xD2YT73Z9nX76fd7alg8p3
        26ZXVKgm6jtyl8V/J7IZH0NI0kcU7EE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-62-M_3NmVKsPnuZMIStzAI0bg-1; Wed, 28 Jul 2021 10:35:40 -0400
X-MC-Unique: M_3NmVKsPnuZMIStzAI0bg-1
Received: by mail-wm1-f70.google.com with SMTP id 132-20020a1c018a0000b029025005348905so1006032wmb.7
        for <linux-s390@vger.kernel.org>; Wed, 28 Jul 2021 07:35:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Ns4+hvb10pCv09UW5xpgn10rDpJ/aUkX8DQEOdyq8JY=;
        b=RJzWl244URiC0TjPNsz2vcl5cYCWwl4tGKVjZ/kiviELUTC0ssVpp11Q6XAds/dzYI
         6suwzThNek0O33gYJwVbOl3Oszpk0Mkzyhes0MSfMSFJKPG6it4Awl5ZEiXbVfakmI7G
         F/nAiywpJpMR/euStEuQwnXE2QRaVZUJTmBdXBYhxkfQpF7oUMF+vjgin9CFnrC84if4
         XMgkOrxlcR81U/fA2k9TmxrMMhvj49dtnwANGMPds/l0KyfS4HTGiTBLYSB4cA9ztoT0
         NIErkx63K/gJ9VpRpeTwb4a+jq7JTuSOFEo1OwI64gRZLSfGk+aSsWBJRXV8B1gkVrZO
         3eSw==
X-Gm-Message-State: AOAM532vgkDd+XihezV9TVg5Ws4owzuOtnS3SaJvToW6z41G1hXYaWVt
        tDwOCDI152C4IHSNQ+76SiAKheMnrGQIfkj7ZCszO1Zp0wk+r1xPSPxlD8N+wve9qYKtYz06Jjt
        t1A6ELfTRUUNVUxfUzOg4PA==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr9915961wmi.137.1627482938593;
        Wed, 28 Jul 2021 07:35:38 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxhTb5ddWwmkLn/CH3sMlITeGS1cEIPUQGu9uQ0XfoNZUun5nGZqs9ljS4qYZVOiACLgBqPBg==
X-Received: by 2002:a05:600c:206:: with SMTP id 6mr9915951wmi.137.1627482938459;
        Wed, 28 Jul 2021 07:35:38 -0700 (PDT)
Received: from thuth.remote.csb (p5791d475.dip0.t-ipconnect.de. [87.145.212.117])
        by smtp.gmail.com with ESMTPSA id y19sm6033618wma.21.2021.07.28.07.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jul 2021 07:35:37 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2] s390x: Add SPDX and header comments for
 s390x/* and lib/s390x/*
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210728101328.51646-2-frankja@linux.ibm.com>
 <20210728125643.80840-1-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <23050302-247b-11f6-249b-d9ead3a9bea3@redhat.com>
Date:   Wed, 28 Jul 2021 16:35:37 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210728125643.80840-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 28/07/2021 14.56, Janosch Frank wrote:
> Seems like I missed adding them.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
> 
> Dropped the sieve.c change.
> 
> ---
>   lib/s390x/uv.c   |  9 +++++++++
>   s390x/mvpg-sie.c |  9 +++++++++
>   s390x/sie.c      | 10 ++++++++++
>   3 files changed, 28 insertions(+)

Reviewed-by: Thomas Huth <thuth@redhat.com>

