Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 256C2C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F12E260FC0
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234696AbhICF4r (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 01:56:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26981 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235706AbhICF4r (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 01:56:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648547;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=MgAVpRD73pk/8lzcW+DoNeFbL133ALWIsVv/se/2fJfovYIk1jr85DGjEpv2f7mRu4/G20
        4Vvl8KFwUBfSL7T4yvLoVhp38FP0tc6nnPt2cwcCA1wpIqEgHQ52v6tifbiGvBtAUPWZaO
        SiQBohye4M7Lt4pPUReecl3BlheLtzc=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-20-Y22OIawGMKes-PDVc1w9KA-1; Fri, 03 Sep 2021 01:55:46 -0400
X-MC-Unique: Y22OIawGMKes-PDVc1w9KA-1
Received: by mail-qv1-f71.google.com with SMTP id c4-20020a0ce7c4000000b00370a5bb605eso5130389qvo.0
        for <linux-s390@vger.kernel.org>; Thu, 02 Sep 2021 22:55:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=bDvgsokZwzrcNUaLieJR18ZGVjKpNWnq/qMS3t3kGKI=;
        b=glKrgHMMS1HRXNbsmxl+oC6Cf35I4mNy9kt82lG26yzf5VxH0v+8Om7qw1eiUzAgP7
         bqAQK6js/dT9S1kCAbQkPaEUl2AMSsQn6IGtMLt0Mp4iIGVw5H3nkbFw0A6QV/4E//37
         Ufgj67dgx5Ic7SDGB7zLooEHtIxxIm72YsxMoUHNdDQOuhTL0FW+UtN2Vo42GmIlvhyl
         FSiB6HcofeWvLvG5xbHGdscr/2Aj9lwHPPedLB8vPQwRhJPYuR6pFBMTQsxNHez3Z6/z
         0RScmeAfQhRmCR+yv4GygPQEF/X25rnox/xoL91UaaaozoLJQOTdJrRpjMzogPsVe5Nm
         kjrw==
X-Gm-Message-State: AOAM533c7J+y6kLD5KMnCBmoI+oKtJD4sVT6H5xTSTjLdhxjdhuzWtRs
        A4+cuHXEfsnD1owH3IjOxH9Wz5TK9jdUDGtv8uth+6n01l3KlcFBnEE+UsHOfOzjUtsB2xb5vkA
        0qnqcUyiWlbWwbIDUTcsz9g==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967389qvw.16.1630648545823;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy2rfokB35RHoytkOenvkXEQNhy0zoJ+Ni5jGU5Fpr4Gqpd31z62no5fBtGg9o+rq+iUgaKgw==
X-Received: by 2002:ad4:47cc:: with SMTP id p12mr1967372qvw.16.1630648545652;
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id x23sm3180733qkn.29.2021.09.02.22.55.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:45 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:41 -0700
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-arch@vger.kernel.org, Jessica Yu <jeyu@kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Egorenkov <egorenar@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Ingo Molnar <mingo@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH 2/4] vmlinux.lds.h: Split .static_call_sites from
 .static_call_tramp_key
Message-ID: <20210903055541.b3dk5yqwkslklvsa@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-3-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-3-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:55PM -0700, Kees Cook wrote:
> These two sections are ro_after_init and .rodata respectively. While
> they will ultimately become read-only, there's no reason to confuse
> their macro names.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

