Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEC36C433B4
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 09:40:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 791F5613EC
	for <linux-s390@archiver.kernel.org>; Wed,  5 May 2021 09:40:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231494AbhEEJlR (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 5 May 2021 05:41:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:44479 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232093AbhEEJlR (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 5 May 2021 05:41:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1620207620;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u6KBu7aHasKqgWwazHoVN54CeHN25mFYlkhheFdm9C0=;
        b=SZzSI5BNqhAjaPxzZcXcPRtCdlNpZ1BG+Qg0VDiR0NuaW7m9jnlc8cm5YvaPTqI2AN9HtF
        Uo1JHc8Rp3pHempHX6xY7tBXn6IqHUMr8xgoeqLWibLZBmvHtc3nJ2sBysIE37p677noGG
        Lky3RTnrsMLX+LQCsG2fb167sXZ22xk=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-leJu4qUcPqaci4o5luC7lg-1; Wed, 05 May 2021 05:40:18 -0400
X-MC-Unique: leJu4qUcPqaci4o5luC7lg-1
Received: by mail-ej1-f70.google.com with SMTP id z13-20020a1709067e4db02903a28208c9bdso254772ejr.0
        for <linux-s390@vger.kernel.org>; Wed, 05 May 2021 02:40:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u6KBu7aHasKqgWwazHoVN54CeHN25mFYlkhheFdm9C0=;
        b=f1sR1hdwCkRM4qAgW8HnwFCQoF3G7gAVb+H3Icaiq+azQbGwIJwyUyNXqzJdIrDW81
         Fz8eyzlDrs41xznf8sPSGC6FwLNBdbRoKpoEbPljuUzg4b2L/b9VLjkhs02FZ/JyRF7t
         zM/2VmRy5W+DWlv7sI2o6Fipbao5QQmgw3y/LtB1PGFxHz3sYGQNu/dtQ+M5m/jYT7iw
         pEraROJEsqKZyTyRFYQ3rNLES/21Rz5AiODZNLi2pnwApewKbt1u2mclKBCVf4u/TbjR
         8Loha1B3dcvoe8mhN0+T0x6Q+fqUe2DM9sEBw/dWQOgKjMlsEYiUdpanPsK+ajTXm5Fd
         uVSw==
X-Gm-Message-State: AOAM530wxB8tZFg8vzhcgOauChcEpS6X3Yuv2CD1y4f9Vo7I/XWczdCw
        raqcNMV9fErUkmfZjsbaU6LJD/eMym8NNziiiTAN/OjSSDGV2+AM6dZ+QmIKBeokMLUAokbt6zo
        L1YdFTFBN31K41ps3jZiE/A==
X-Received: by 2002:a17:906:2e17:: with SMTP id n23mr27037690eji.266.1620207617073;
        Wed, 05 May 2021 02:40:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygP1+3b8mE6aHVZIc9snR5pppl00aDCntPFGJzSHLzkBPzAvPO8An/W4LetTgP0eOKQtI5hw==
X-Received: by 2002:a17:906:2e17:: with SMTP id n23mr27037671eji.266.1620207616833;
        Wed, 05 May 2021 02:40:16 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id b8sm2601778ejc.29.2021.05.05.02.40.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 May 2021 02:40:16 -0700 (PDT)
Subject: Re: [kvm-unit-tests GIT PULL 0/9] s390x update 2021-05-05
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com, thuth@redhat.com
References: <20210505084301.17395-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3b084b6d-4de3-4bdb-6ce6-ada5d2bbc0b3@redhat.com>
Date:   Wed, 5 May 2021 11:40:11 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20210505084301.17395-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 05/05/21 10:42, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
> * IO extensions (Pierre)
> * New reviewer (Claudio)
> * Minor changes
> 
> MERGE:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/7
> 
> PIPELINE:
> https://gitlab.com/frankja/kvm-unit-tests/-/pipelines/297509337
> 
> PULL:
> The following changes since commit abe823807d13e451ca5c37f1b5ada5847e08084f:
> 
>    nSVM: Test addresses of MSR and IO permissions maps (2021-04-22 11:59:25 -0400)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-05-05
> 
> for you to fetch changes up to 7231778d3773f70582e705cf910976c79138d0c9:
> 
>    s390x: Fix vector stfle checks (2021-05-05 08:01:45 +0000)
> 
> 
> Claudio Imbrenda (2):
>    s390x: mvpg: add checks for op_acc_id
>    MAINTAINERS: s390x: add myself as reviewer
> 
> Janosch Frank (1):
>    s390x: Fix vector stfle checks
> 
> Pierre Morel (6):
>    s390x: css: Store CSS Characteristics
>    s390x: css: simplifications of the tests
>    s390x: css: extending the subchannel modifying functions
>    s390x: css: implementing Set CHannel Monitor
>    s390x: css: testing measurement block format 0
>    s390x: css: testing measurement block format 1
> 
>   MAINTAINERS         |   1 +
>   lib/s390x/css.h     | 115 ++++++++++++++++++++-
>   lib/s390x/css_lib.c | 236 ++++++++++++++++++++++++++++++++++++++++----
>   s390x/css.c         | 216 ++++++++++++++++++++++++++++++++++++++--
>   s390x/mvpg.c        |  28 +++++-
>   s390x/vector.c      |   4 +-
>   6 files changed, 568 insertions(+), 32 deletions(-)
> 

Pulled, thanks.

Paolo

