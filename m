Return-Path: <SRS0=aATr=IG=vger.kernel.org=linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8730AC433E0
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 14:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 56E06651DE
	for <linux-s390@archiver.kernel.org>; Mon,  8 Mar 2021 14:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbhCHOge (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 8 Mar 2021 09:36:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:46545 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231159AbhCHOgS (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 8 Mar 2021 09:36:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1615214177;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z6aTjsstS//XU46FW5n04GbzvkHS0se7lPTHSWa5HW4=;
        b=G78zCm3vYeIR+N60kVYI14bX1KfS/ZDmUqgsl3nhsUDJQzSaHdQ00oeaOpFHYyjoEXuGjx
        huciCg5rl9/9RSLq6jzs+sYDXIhGA2JgCP1/oZqaWWfit21C4KdZfKY96yj9L61UxonfB+
        X/B3tQuEi2yJu98egPd8D5FthTpTSiI=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-247-V75IiX1ePniW8lT40TmqUA-1; Mon, 08 Mar 2021 09:36:16 -0500
X-MC-Unique: V75IiX1ePniW8lT40TmqUA-1
Received: by mail-ej1-f72.google.com with SMTP id si4so4161373ejb.23
        for <linux-s390@vger.kernel.org>; Mon, 08 Mar 2021 06:36:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=z6aTjsstS//XU46FW5n04GbzvkHS0se7lPTHSWa5HW4=;
        b=RsDOykjRzSETeV5XMJETeTO0PhiHwJlotSw50G3QxdcEUJyIkj07dGvY5IAT6TDF0B
         P+u9lWZP4pWc3U973b0SQYbGZ/vpekcJHnLtIhbvHnOAQnZ59LumQ0nTNdzJucRCycTW
         Ej0XSbcC24zqKyUtnF5l+3EnLjo/uvuMPMRa71p1ovskHuSZgwpB/auK0stFv1EcHdXA
         VlEZJVVILSVXn5tIA2j4nDn0hKQcezw5LI39D4Qq9xDtXTyfWGAg/yUMYsRlG0T7I3wd
         2cn72wr2y65Se1eDzGFdtsZJgO311Rpreb7Z7SyQg3gO+ZE6UWmJnBfZvz0LlfN0q5uC
         DKeQ==
X-Gm-Message-State: AOAM532+HEPIlw0bsnVUiedg4g3n+tvXGk2YQ6HDJxK/xNEOPo4mawcP
        V1jp3HXEaHjdC9vA4JlcNFWZb6v7wg+XgaO8BMLlo79siaqEAZv742hbOIjSD9qeOE74dMupH/J
        VdjeApAF0U0Go+EU9qNSvgw==
X-Received: by 2002:a17:906:7c44:: with SMTP id g4mr15038610ejp.269.1615214175040;
        Mon, 08 Mar 2021 06:36:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwXAR5BlVE65pzfj2tGCA9YAyD71OkhlsSV9Ii80iP6dafAeCBsMyLBkRK/oC2uHVJpQscBCg==
X-Received: by 2002:a17:906:7c44:: with SMTP id g4mr15038580ejp.269.1615214174812;
        Mon, 08 Mar 2021 06:36:14 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.gmail.com with ESMTPSA id f11sm6683683eje.107.2021.03.08.06.36.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Mar 2021 06:36:14 -0800 (PST)
Subject: Re: [kvm-unit-tests GIT PULL 00/16] s390x update
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, david@redhat.com, borntraeger@de.ibm.com,
        cohuck@redhat.com, linux-s390@vger.kernel.org,
        imbrenda@linux.ibm.com
References: <20210308143147.64755-1-frankja@linux.ibm.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a47a30be-1edc-6351-747d-d14db3e6f932@redhat.com>
Date:   Mon, 8 Mar 2021 15:36:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210308143147.64755-1-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 08/03/21 15:31, Janosch Frank wrote:
> Dear Paolo,
> 
> please merge or pull the following changes:
>   * IO tests PV compatibility (Pierre)
>   * Backtrace support (Janosch)
>   * mvpg test (Claudio)
>   * Fixups (Thomas)
> 
> 
> MERGE:
> https://gitlab.com/kvm-unit-tests/kvm-unit-tests/-/merge_requests/5
> 
> 
> PULL:
> The following changes since commit 739f7de6b3c8deaf22d2fa5e6016ad2c7bd22ddc:
> 
>    x86: clean up EFER definitions (2021-02-18 13:31:22 -0500)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/frankja/kvm-unit-tests.git s390x-pull-2021-08-03
> 
> for you to fetch changes up to b7f0f9a2e1fdb9d4235164f0a8d8ea880e1cefd4:
> 
>    s390x: mvpg: skip some tests when using TCG (2021-03-08 12:03:47 +0100)

Pulled, thanks.

Paolo

> ----------------------------------------------------------------
> Claudio Imbrenda (3):
>    s390x: introduce leave_pstate to leave userspace
>    s390x: mvpg: simple test
>    s390x: mvpg: skip some tests when using TCG
> 
> Janosch Frank (8):
>    s390x: Remove sthyi partition number check
>    s390x: Fix fpc store address in RESTORE_REGS_STACK
>    s390x: Fully commit to stack save area for exceptions
>    s390x: Introduce and use CALL_INT_HANDLER macro
>    s390x: Provide preliminary backtrace support
>    s390x: Print more information on program exceptions
>    s390x: Move diag308_load_reset to stack saving
>    s390x: Remove SAVE/RESTORE_STACK and lowcore fpc and fprs save areas
> 
> Pierre Morel (3):
>    s390x: pv: implement routine to share/unshare memory
>    s390x: define UV compatible I/O allocation
>    s390x: css: pv: css test adaptation for PV
> 
> Thomas Huth (2):
>    lib/s390x/sclp: Clarify that the CPUEntry array could be at a
>      different spot
>    Fix the length in the stsi check for the VM name
> 
>   lib/s390x/asm-offsets.c   |  17 ++-
>   lib/s390x/asm/arch_def.h  |  42 ++++--
>   lib/s390x/asm/interrupt.h |   4 +-
>   lib/s390x/asm/uv.h        |  39 ++++++
>   lib/s390x/css.h           |   3 +-
>   lib/s390x/css_lib.c       |  28 ++--
>   lib/s390x/interrupt.c     |  61 +++++++--
>   lib/s390x/malloc_io.c     |  71 ++++++++++
>   lib/s390x/malloc_io.h     |  45 +++++++
>   lib/s390x/sclp.h          |   9 +-
>   lib/s390x/stack.c         |  20 ++-
>   s390x/Makefile            |   3 +
>   s390x/cpu.S               |   6 +-
>   s390x/css.c               |  43 ++++--
>   s390x/cstart64.S          |  25 +---
>   s390x/macros.S            |  96 ++++++-------
>   s390x/mvpg.c              | 277 ++++++++++++++++++++++++++++++++++++++
>   s390x/sthyi.c             |   1 -
>   s390x/stsi.c              |   2 +-
>   s390x/unittests.cfg       |   4 +
>   20 files changed, 657 insertions(+), 139 deletions(-)
>   create mode 100644 lib/s390x/malloc_io.c
>   create mode 100644 lib/s390x/malloc_io.h
>   create mode 100644 s390x/mvpg.c
> 

