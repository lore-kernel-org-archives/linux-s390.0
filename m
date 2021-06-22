Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E16C2B9F4
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:24:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D97B660C3E
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:24:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbhFVI1N (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:27:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:45179 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229628AbhFVI1M (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 22 Jun 2021 04:27:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624350296;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zVozGF4hJZA941GLqgUVkQE/BXYFfLZ21xsbsn2roDY=;
        b=AUk2LLGukNgxPjuCSxtm6QKoHL5arsUyqWqXIF2wxrN5LqIiEgjbT/yaJyhecSKta/bBq2
        VOevP1t1EdUA8f0yiNYp4KsvzCw2FK6OTnVhYMWX5cWBMnH7JSFczfSsRp9HRaGcllQxMO
        NDk4DN3b2lrjrg7McOz1poWtoVPZeIQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-217-w7ZbVTUHO_SOG0f6menEzA-1; Tue, 22 Jun 2021 04:24:55 -0400
X-MC-Unique: w7ZbVTUHO_SOG0f6menEzA-1
Received: by mail-wm1-f70.google.com with SMTP id g14-20020a05600c4eceb02901b609849650so441965wmq.6
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 01:24:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zVozGF4hJZA941GLqgUVkQE/BXYFfLZ21xsbsn2roDY=;
        b=bli5MG4Po5Lm23W1VjiqVoQQtIc21Q+BL1k+/qmLeWt2A7lvROLal3MIQbSPiBDZYe
         Q7wUqL04V/2Q+VJOMlFOoUu7xWlge/oxK64R+vBnypHe9BYCxdYlnV8HO1dcEd3cZ5HI
         FO+M+O5SlQDZRCj2tiwrItLrt/uPpWBFKDXU8TYupvEC8mvFEK6eAEvRRJN+m8kdlXqH
         yQmbrkwQU0W+7w4CCZCeKb+x3myWrFEeFym6eJmsFUci3xjkEP3vTUjH/U0n4dxZG7ou
         t75COZoWLy5x4QiVY19/AlHgNyNcF3d5+nEMKpOxCJQUTGyAo4v7xxfD/HHPt3LhxYqo
         honA==
X-Gm-Message-State: AOAM531v5jdA4zTsiWv+IsMsLt93hZ2AQ3OXPgHDqtqyaEUsZrsPY9lf
        snXAHnhlxN1scJZ3utFkvjL/njANxsvxFeUwmHm5jayGTJnJqHys5h2z68VJrXAXMrSClqCOCE1
        rqyCDwuiUAnt6q6KG0pm/VA==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr3269210wrq.174.1624350294077;
        Tue, 22 Jun 2021 01:24:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwe6MmlnOxEV9WkVefBAAZcEhrmxm2rNI0OwW6f1BQv4LaVIdSahf2XG3G3DbyVJoPpIseEUQ==
X-Received: by 2002:a5d:4486:: with SMTP id j6mr3269193wrq.174.1624350293921;
        Tue, 22 Jun 2021 01:24:53 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id i6sm14791559wro.12.2021.06.22.01.24.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Jun 2021 01:24:53 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 00/12] s390x update 2021-22-06
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210622082042.13831-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a134a99f-fd80-4ed5-4122-a052ffcc5e34@redhat.com>
Date:   Tue, 22 Jun 2021 10:24:52 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20210622082042.13831-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/06/21 10:20, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
> 
> Merge:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/11
> 
> Pipeline:
> https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/324608397
> 
> Pull:
> The following changes since commit f09465ac9044145f20435344d41566aede62fc08:
> 
>    x86: Flush the TLB after setting user-bit (2021-06-17 14:36:25 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-22-06
> 
> for you to fetch changes up to d58ec2ec341cbea746944a8ae92c737041c35172:
> 
>    s390x: edat test (2021-06-21 14:55:12 +0000)
> 
> 
> Claudio Imbrenda (7):
>    s390x: lib: add and use macros for control register bits
>    libcflat: add SZ_1M and SZ_2G
>    s390x: lib: fix pgtable.h
>    s390x: lib: Add idte and other huge pages functions/macros
>    s390x: lib: add teid union and clear teid from lowcore
>    s390x: mmu: add support for large pages
>    s390x: edat test
> 
> Janosch Frank (5):
>    s390x: sie: Only overwrite r3 if it isn't needed anymore
>    s390x: selftest: Add prefixes to fix report output
>    s390x: Don't run PV testcases under tcg
>    configure: s390x: Check if the host key document exists
>    s390x: run: Skip PV tests when tcg is the accelerator
> 
>   configure                 |   5 +
>   lib/libcflat.h            |   2 +
>   lib/s390x/asm/arch_def.h  |  12 ++
>   lib/s390x/asm/float.h     |   4 +-
>   lib/s390x/asm/interrupt.h |  28 +++-
>   lib/s390x/asm/pgtable.h   |  44 +++++-
>   lib/s390x/interrupt.c     |   2 +
>   lib/s390x/mmu.c           | 264 ++++++++++++++++++++++++++++++++----
>   lib/s390x/mmu.h           |  84 +++++++++++-
>   lib/s390x/sclp.c          |   4 +-
>   s390x/Makefile            |   1 +
>   s390x/cpu.S               |   2 +-
>   s390x/diag288.c           |   2 +-
>   s390x/edat.c              | 274 ++++++++++++++++++++++++++++++++++++++
>   s390x/gs.c                |   2 +-
>   s390x/iep.c               |   4 +-
>   s390x/run                 |   5 +
>   s390x/selftest.c          |  26 ++--
>   s390x/skrf.c              |   2 +-
>   s390x/smp.c               |   8 +-
>   s390x/unittests.cfg       |   3 +
>   s390x/vector.c            |   2 +-
>   scripts/s390x/func.bash   |   3 +
>   23 files changed, 724 insertions(+), 59 deletions(-)
>   create mode 100644 s390x/edat.c
> 

Merged, thanks!

Paolo

