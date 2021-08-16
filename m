Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A3409C432BE
	for <linux-s390@archiver.kernel.org>; Mon, 16 Aug 2021 16:25:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C08660F58
	for <linux-s390@archiver.kernel.org>; Mon, 16 Aug 2021 16:25:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbhHPQ0C (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 16 Aug 2021 12:26:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47665 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229542AbhHPQ0C (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Aug 2021 12:26:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629131129;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Dm4aMePRYw0Lag7qRAIAJhdtuPkpASWKHQdOAX43ecY=;
        b=La7uOJrdqFblbeQMkqb4UZwL64ECQzNkiF4cq9TH/xio53PLfXs5P7MvgiCpsDbvxY1KrL
        b4YnNADIy31tMOBdB3JDiVoZ2YAMAVmHMo3Vb8Hgh7yhBlVlDlMaQ65T2F9Xks0alcVHQs
        sZpTPMy5R9RwqIhpkUjcgZsObclYQMA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-94-7ROL5VIUOQm2g-D2VfgAMw-1; Mon, 16 Aug 2021 12:25:28 -0400
X-MC-Unique: 7ROL5VIUOQm2g-D2VfgAMw-1
Received: by mail-wm1-f70.google.com with SMTP id j33-20020a05600c1c21b02902e6828f7a20so138990wms.7
        for <linux-s390@vger.kernel.org>; Mon, 16 Aug 2021 09:25:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Dm4aMePRYw0Lag7qRAIAJhdtuPkpASWKHQdOAX43ecY=;
        b=rYb18MwaW9LB+mTZEq/QMErB931g9LTiHJ+L4CzB02JFNTKYfAEnVpKSN24s371H3z
         7LnZm4jtBZs8ZXgYRydouRBxVAoA5yerhTygeilDKVXt0VRmCU3Go85QaYJ4tA+T+kuw
         m42yDaRac+DNB67oe0tjokm2AbfUkdA5SRYb0H0k1byY+HlkUxrX6PQLIYaTELeU6sRJ
         6OTvA1DdZ1ikUk8+1MqBzL2szGnAdJDguCxFvizD6HUfGbSifAG1kcNztR06lCXOOdQ0
         Y0LYr++CuNh+FL4NOOoF4XHarFmbiYRNkYSLD1HVsrXZeJFWpVO8Dfi8FDtzJKFLemHo
         ZjvA==
X-Gm-Message-State: AOAM530yeL4IpjOrJIUdCJfNCMl6N1DjTSC0sSD2M6xJ+wtDQRiapeUu
        HpA/pSvxwxjXHEmtdBHJK7qY3tj+cwxu0IaMtDBAKMoGINvnn1qpbNo+DKc3OX20mwv7WDJrRrQ
        VUtHllUDJqxCyR9Z+hUAkyA==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr20201436wrx.338.1629131127504;
        Mon, 16 Aug 2021 09:25:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzYhKjdG+kBm0tIiUC+mqxW8U7EmFgO85Zvz4KPGYTPzsTEYVi5rvhCmZX4m4XwIZl+9k1V/g==
X-Received: by 2002:a05:6000:1241:: with SMTP id j1mr20201419wrx.338.1629131127344;
        Mon, 16 Aug 2021 09:25:27 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.gmail.com with ESMTPSA id f17sm12228951wrt.49.2021.08.16.09.25.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Aug 2021 09:25:26 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 00/11] s390x update 2021-16-08
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210816132054.60078-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd353058-a565-8451-1613-740d632067fd@redhat.com>
Date:   Mon, 16 Aug 2021 18:25:25 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210816132054.60078-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 16/08/21 15:20, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
> 
>   - SPDX cleanup
>   - SIE lib extensions
>   - Fixes/cleanup in the lib
> 
> MERGE:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/15
> 
> PIPELINE:
> https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/353890035
> 
> PULL:
> The following changes since commit c90c646d7381c99ac7d9d7812bd8535214458978:
> 
>    access: treat NX as reserved if EFER.NXE=0 (2021-08-13 07:29:28 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-16-08
> 
> for you to fetch changes up to 454da83a513761a0cd2bfda08f335735f345ef87:
> 
>    lib: s390x: Add PSW_MASK_64 (2021-08-16 11:28:02 +0000)
> 
> Janosch Frank (10):
>    s390x: Add SPDX and header comments for s390x/* and lib/s390x/*
>    s390x: Add SPDX and header comments for the snippets folder
>    s390x: Fix my mail address in the headers
>    s390x: sie: Add sie lib validity handling
>    s390x: lib: Introduce HPAGE_* constants
>    s390x: lib: sie: Add struct vm (de)initialization functions
>    lib: s390x: sie: Move sie function into library
>    lib: s390x: Add 0x3d, 0x3e and 0x3f PGM constants
>    lib: s390x: uv: Add rc 0x100 query error handling
>    lib: s390x: Add PSW_MASK_64
> 
> Pierre Morel (1):
>    s390x: lib: Simplify stsi_get_fc and move it to library
> 
>   lib/s390x/asm/arch_def.h        | 22 +++++++++
>   lib/s390x/asm/mem.h             |  2 +-
>   lib/s390x/asm/page.h            |  4 ++
>   lib/s390x/interrupt.c           |  3 ++
>   lib/s390x/mmu.h                 |  2 +-
>   lib/s390x/sie.c                 | 83 +++++++++++++++++++++++++++++++++
>   lib/s390x/sie.h                 |  7 +++
>   lib/s390x/smp.c                 |  2 +-
>   lib/s390x/stack.c               |  2 +-
>   lib/s390x/uv.c                  | 13 +++++-
>   s390x/Makefile                  |  1 +
>   s390x/gs.c                      |  2 +-
>   s390x/iep.c                     |  2 +-
>   s390x/mvpg-sie.c                | 42 +++++------------
>   s390x/sie.c                     | 53 ++++++---------------
>   s390x/skrf.c                    |  6 +--
>   s390x/snippets/c/cstart.S       |  9 ++++
>   s390x/snippets/c/mvpg-snippet.c |  9 ++++
>   s390x/stsi.c                    | 20 +-------
>   s390x/vector.c                  |  2 +-
>   20 files changed, 188 insertions(+), 98 deletions(-)
>   create mode 100644 lib/s390x/sie.c
> 

Merged, thanks!

Paolo

