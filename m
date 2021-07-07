Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4362BC07E95
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 17:33:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 26B1861CC0
	for <linux-s390@archiver.kernel.org>; Wed,  7 Jul 2021 17:33:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230282AbhGGRgb (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 7 Jul 2021 13:36:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:59743 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230019AbhGGRga (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 7 Jul 2021 13:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625679229;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ztSKe4ohIUqqQH9SGOnGeVNu0uOF3bjar9aLJ6lT9vE=;
        b=AuilmbeLzofxI8hfTNLTvf9YSwXR8kTvtgsQdRiy2J2NbwdYZfpIeQ5yjJZFKjNNXPhuZS
        0HP2wPNntTu10rbnetRUQqQ1lTAS3HdyYiMHzV2qiCJZ1EaJOJmkNtyFJzPM6Ie6jgmFGl
        dbV09d/g+6XEPoCfZMxWEGZqCEF2J1Q=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-581-XVZFiUc3P9qrCJTYHA5T1Q-1; Wed, 07 Jul 2021 13:33:48 -0400
X-MC-Unique: XVZFiUc3P9qrCJTYHA5T1Q-1
Received: by mail-ej1-f72.google.com with SMTP id rl7-20020a1709072167b02904f7606bd58fso414301ejb.11
        for <linux-s390@vger.kernel.org>; Wed, 07 Jul 2021 10:33:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=ztSKe4ohIUqqQH9SGOnGeVNu0uOF3bjar9aLJ6lT9vE=;
        b=pamq6yuZQurvaMXA4x4Cb5xKDISaf1kcln9tD3FL3V2Z2KhkXEMO6AL53qcrWlNDgp
         7ncozmGUnpZk6ZS+1iqGdjp19i1iGllRc0zY1Tmxz9s9UO5AFOaGfTPY4k5m2CjLjBEE
         tJUzNPOM/JqSkSt+LH3WlT1f57nBqY6K6A1JRXhmW3PDp25rwuLcovZcOR4hMYXXTo0e
         sni2yD2ytnvP8SfHF+g/36PsL6QmdC3rMtF4CWD1bEe/402NHvtt1zyRE1HI90tHfFfS
         I1nQhdWNv0/lP28WF2NDfcMSubKpq8l2r95apzAI/qbiLFz7r3uBQdoKFCaHkdWflwr/
         jFBg==
X-Gm-Message-State: AOAM5330s3oFSXIJRaR4LjeAL2Oxm2AwEga1d4ODLL9BERhQMT/SgXS8
        re5DNPF8mtLQ7HiDmtYOGz2HwrZX08YMpQkOopRV9PeDzp3KRac+HtQgtd1zTXXq2ufaLRiZ12k
        4h5MilQZzis02my8nOARaqA==
X-Received: by 2002:aa7:c74e:: with SMTP id c14mr3576618eds.40.1625679227488;
        Wed, 07 Jul 2021 10:33:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx4H7YCNWBMgXB4JzVR+DWO9DKkRru2JlbEPF3Wcemi+/0vgmz8QsbMsVSpvtTObng8PB5zwQ==
X-Received: by 2002:aa7:c74e:: with SMTP id c14mr3576606eds.40.1625679227325;
        Wed, 07 Jul 2021 10:33:47 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id z5sm3459534ejn.65.2021.07.07.10.33.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jul 2021 10:33:46 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 0/8] s390x update 2021-07-07
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210707140318.44255-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a4f3e98f-f86b-52f8-dc96-4b24fb3e66a0@redhat.com>
Date:   Wed, 7 Jul 2021 19:33:45 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210707140318.44255-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 07/07/21 16:03, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
> 
> * Add snippet support that makes starting guests in tests easier
> * Cleanup
> 
> MERGE:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/13
> 
> PIPELINE:
> https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/333035606
> 
> PULL:
> The following changes since commit bc6f264386b4cb2cadc8b2492315f3e6e8a801a2:
> 
>    Merge branch 'arm/queue' into 'master' (2021-06-30 13:35:55 +0000)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-07-07
> 
> for you to fetch changes up to 81598ca0d3fbeb52e02eecf5ddbc15e30f8c600a:
> 
>    lib: s390x: Remove left behing PGM report (2021-07-07 08:00:29 +0000)
> 
> Janosch Frank (7):
>    s390x: snippets: Add gitignore as well as linker script and start
>      assembly
>    s390x: mvpg: Add SIE mvpg test
>    s390x: sie: Add missing includes
>    s390x: sie: Fix sie.h integer types
>    lib: s390x: uv: Add offset comments to uv_query and extend it
>    lib: s390x: Print if a pgm happened while in SIE
>    lib: s390x: Remove left behing PGM report
> 
> Steffen Eiden (1):
>    s390x: snippets: Add snippet compilation
> 
>   .gitignore                      |   1 +
>   lib/s390x/asm/uv.h              |  33 +++----
>   lib/s390x/interrupt.c           |  14 +--
>   lib/s390x/sie.h                 |  11 ++-
>   s390x/Makefile                  |  29 +++++--
>   s390x/mvpg-sie.c                | 149 ++++++++++++++++++++++++++++++++
>   s390x/snippets/c/cstart.S       |  16 ++++
>   s390x/snippets/c/flat.lds       |  51 +++++++++++
>   s390x/snippets/c/mvpg-snippet.c |  33 +++++++
>   s390x/unittests.cfg             |   3 +
>   10 files changed, 308 insertions(+), 32 deletions(-)
>   create mode 100644 s390x/mvpg-sie.c
>   create mode 100644 s390x/snippets/c/cstart.S
>   create mode 100644 s390x/snippets/c/flat.lds
>   create mode 100644 s390x/snippets/c/mvpg-snippet.c
> 

Merged, thanks!

Paolo

