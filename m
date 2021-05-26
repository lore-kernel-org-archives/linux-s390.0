Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03781C47089
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 16:33:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9873613E5
	for <linux-s390@archiver.kernel.org>; Wed, 26 May 2021 16:33:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234727AbhEZQfU (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 26 May 2021 12:35:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234500AbhEZQfU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 26 May 2021 12:35:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622046828;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XVqT1swsX27I0j5hE9T0VhOfylfMr7I1wTfKCDuG8vY=;
        b=gWJwpRQBqfSi0wYGf2G9M/v+R53JWmJhYyRZp131sOastJ8KLi0XvwBlCU8oIfJPwtqMTu
        TpQYb70h7R9lLxpMRm5Jr2QX4JJzpA3z/5Nv1c4x8M9t23UwTO/AnW0K4dDPqJDcl43b2J
        dGt57gP1wK71rU3rrcU7eUdgxryph8M=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-487-Sdpb5Y_5PfyQzAXoTAIT8g-1; Wed, 26 May 2021 12:33:45 -0400
X-MC-Unique: Sdpb5Y_5PfyQzAXoTAIT8g-1
Received: by mail-ed1-f70.google.com with SMTP id h16-20020a0564020950b029038cbdae8cbaso895005edz.6
        for <linux-s390@vger.kernel.org>; Wed, 26 May 2021 09:33:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=XVqT1swsX27I0j5hE9T0VhOfylfMr7I1wTfKCDuG8vY=;
        b=dJLMscfcqGrB/88aXkNQlIF38iyseD396Fe2IunwNJ8BhyyoXeKv1/wfWWoSTnHmbm
         fWVa/tRI8KHtHwcLamDgFKkUB3FyJUHBfP8+lcNeRlBF+aBNs6rdQWrJu7Wzu3VUS33q
         b2X+fnx/QkvvWTFf17oCCq0zxuOh4/WYUVffwhDZdTOIA6WmoJWs6YhJDuaznRAMwm43
         FDbFcnKXINL5iD6AT51VRipReiWWhs1f2kwCyYDXpp65wJ2Z+VSXQqV8Mp0yYBUMENUY
         2jkiAN9ytTvHDPZWLcGf1FSGafK04nhHDdwssKIf2IfYs6jCtz9mGgRFFvF/TQMRuBiZ
         tF5g==
X-Gm-Message-State: AOAM531O1otGxbK7Cb7eahf/PGetF0e8NRe+Y3MA0WGvr5f1Bh/sYyXj
        dy5LMyxPgRsgmmnrtS484Us6oX72A/pGn0GIAIixPxszjDuXBbEm0frgPaMk91BuLS2LloKHAIB
        iJiOecYDqJDCtpHHZsbqspQ==
X-Received: by 2002:a05:6402:1d18:: with SMTP id dg24mr38325808edb.369.1622046822963;
        Wed, 26 May 2021 09:33:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA9vMTjHhMUlf8GRrLD1umE9XiUdNeeF6QGlgK/FIicWbivIH+K1niCaR6uYncMTljDKHfKg==
X-Received: by 2002:a05:6402:1d18:: with SMTP id dg24mr38325789edb.369.1622046822758;
        Wed, 26 May 2021 09:33:42 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b9sm12882306edt.71.2021.05.26.09.33.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 May 2021 09:33:42 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 0/9] s390x update 2021-26-05
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210526145539.52008-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <605341e9-d6e8-b02e-eed3-f6756517d2a4@redhat.com>
Date:   Wed, 26 May 2021 18:33:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210526145539.52008-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 26/05/21 16:55, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
> * SCLP feature probing
> * SCLP cpu model check
> * UV host tests
> 
> MERGE:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/9
> 
> PIPELINE:
> https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/309936640
> 
> PULL:
> The following changes since commit 74ff0e9675ec6d9477f5e98ec7d5d50878fa7ebc:
> 
>    Merge branch 'arm/queue' into 'master' (2021-05-18 11:07:08 +0000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-26-05
> 
> for you to fetch changes up to 21f5f67675830e1c088539656cdc0f63bc18e4e0:
> 
>    s390x: cpumodel: FMT2 and FMT4 SCLP test (2021-05-26 14:27:09 +0000)
> 
> 
> Janosch Frank (9):
>    s390x: uv-guest: Add invalid share location test
>    s390x: Add more Ultravisor command structure definitions
>    s390x: uv: Add UV lib
>    s390x: Test for share/unshare call support before using them
>    s390x: uv-guest: Test invalid commands
>    s390x: Add UV host test
>    s390x: sclp: Only fetch read info byte 134 if cpu entries are above it
>    lib: s390x: sclp: Extend feature probing
>    s390x: cpumodel: FMT2 and FMT4 SCLP test
> 
>   lib/s390x/asm/uv.h    | 152 ++++++++++++-
>   lib/s390x/io.c        |   2 +
>   lib/s390x/malloc_io.c |   5 +-
>   lib/s390x/sclp.c      |  23 +-
>   lib/s390x/sclp.h      |  39 +++-
>   lib/s390x/uv.c        |  45 ++++
>   lib/s390x/uv.h        |  10 +
>   s390x/Makefile        |   2 +
>   s390x/cpumodel.c      |  71 ++++++-
>   s390x/uv-guest.c      |  60 +++++-
>   s390x/uv-host.c       | 480 ++++++++++++++++++++++++++++++++++++++++++
>   11 files changed, 871 insertions(+), 18 deletions(-)
>   create mode 100644 lib/s390x/uv.c
>   create mode 100644 lib/s390x/uv.h
>   create mode 100644 s390x/uv-host.c
> 

Pulled, thanks!

Paolo

