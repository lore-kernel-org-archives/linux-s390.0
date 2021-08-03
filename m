Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DD2DC432BE
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:47:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CB9A61029
	for <linux-s390@archiver.kernel.org>; Tue,  3 Aug 2021 14:47:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236415AbhHCOsF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 3 Aug 2021 10:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:28050 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236689AbhHCOrz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 3 Aug 2021 10:47:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628002047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pQpxgCQc8toiVPwyKcWNVpCFEDp3kjB+8in0NoN4Xs=;
        b=EgqGCicMjEhkE5GMHu8arPy2ugYCOlkDsDyYKx+8eJGgeInEsNqb65+NPIgijtTeiDa5DZ
        8qZ8v97dHt4bbZwilU90uBCUWYTnZyDHMaENs7PR2uE/1lkWtyeV690kbYTANRQbkFsfqV
        ZpRg+hfRe1h1w89iSMKnIfCN2bvmaww=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-81-Bj-vsMJmMXWULjqbkSta3Q-1; Tue, 03 Aug 2021 10:47:26 -0400
X-MC-Unique: Bj-vsMJmMXWULjqbkSta3Q-1
Received: by mail-wm1-f70.google.com with SMTP id f142-20020a1c1f940000b029025093cddc1eso1002070wmf.3
        for <linux-s390@vger.kernel.org>; Tue, 03 Aug 2021 07:47:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1pQpxgCQc8toiVPwyKcWNVpCFEDp3kjB+8in0NoN4Xs=;
        b=pkb0JWOKu+yqoERKPW/Z0aiezm7OgS0DmF1Bea7A+yZrkiOXU3oymtfHFsQDZqB+2x
         c2WSQG+lNvTrxbKNwIEA/r70ILmyF75M2aLzjqXF3RbBNrj0wKTqrlEKemWZjyxv+SuJ
         qzCABJb9ikBTtRIgJ99Aea+oDGPmcXGszLP6Bt52vKPysO5iWjHo0HK9hmqBEEwFzE7y
         uKdDLPQEXLJlu9Ke0Lenvd+sGscryqcZzG3Dqy2YE9JREhsgK348fSs9plWaTtgCjY4Y
         izdQyCdPLNnbAMe9tnCPGd+tmgN1us/rq3OozG936krfbZd9JJXuGVJiH7cYE0D6tLSN
         aHMQ==
X-Gm-Message-State: AOAM532HeOpChX7JEmMykimYQy772FsmFj0QkTIQhcu2noHb1MoQDyC+
        d/1lScTG8uRLhsgG0BENOYF6SGDlTqfgpTI6qbtVmKdjq0Nav0BZqOZhzpFcYOKfgJdGpVQV4lF
        mQ6dpaAOiAm8K3bsAX3deBQ==
X-Received: by 2002:a05:600c:1d11:: with SMTP id l17mr23386931wms.185.1628002045384;
        Tue, 03 Aug 2021 07:47:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcBnin2htwVSVxF0E3xiuluPsaaFiY7FHl64X8ylZwe0APrrZQ5sAnWY+Tr7UhWRx/ULjnKQ==
X-Received: by 2002:a05:600c:1d11:: with SMTP id l17mr23386915wms.185.1628002045183;
        Tue, 03 Aug 2021 07:47:25 -0700 (PDT)
Received: from thuth.remote.csb (p5791d8a3.dip0.t-ipconnect.de. [87.145.216.163])
        by smtp.gmail.com with ESMTPSA id x21sm2753308wmi.46.2021.08.03.07.47.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Aug 2021 07:47:24 -0700 (PDT)
Subject: Re: [kvm-unit-tests PATCH v2] s390x: sie: Add sie lib validity
 handling
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, cohuck@redhat.com
References: <20210729134803.183358-2-frankja@linux.ibm.com>
 <20210803135739.21624-1-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <bf652d52-fc93-1aca-81d6-85b48343b171@redhat.com>
Date:   Tue, 3 Aug 2021 16:47:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210803135739.21624-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 03/08/2021 15.57, Janosch Frank wrote:
> Let's start off the SIE lib with validity handling code since that has
> the least amount of dependencies to other files.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>   lib/s390x/sie.c  | 40 ++++++++++++++++++++++++++++++++++++++++
>   lib/s390x/sie.h  |  3 +++
>   s390x/Makefile   |  1 +
>   s390x/mvpg-sie.c |  2 +-
>   s390x/sie.c      |  7 +------
>   5 files changed, 46 insertions(+), 7 deletions(-)
>   create mode 100644 lib/s390x/sie.c
> 
> diff --git a/lib/s390x/sie.c b/lib/s390x/sie.c
> new file mode 100644
> index 00000000..15ba407c
> --- /dev/null
> +++ b/lib/s390x/sie.c
> @@ -0,0 +1,40 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Virtualization library that speeds up managing guests.

Maybe something like:

Library for managing various aspects of (nested) guests

?

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>

