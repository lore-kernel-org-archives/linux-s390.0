Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7F7CC433EF
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE4E960FC0
	for <linux-s390@archiver.kernel.org>; Fri,  3 Sep 2021 05:55:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233852AbhICF4c (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 3 Sep 2021 01:56:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:35241 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233806AbhICF4c (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Sep 2021 01:56:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630648532;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=MZDF97QFhjJS8ErjA7NEtJpZOYG0jzgBTtJjf4MEDi55LTYWJm0NQkO8zD2hI9ZdvbV8B7
        JdHMU8OKf5FMjXsOSdZ10gmY8EG6i+BXXJ4jYYKvpdv1+2/KRDnnyn+e91EI+9MAVzNfU1
        2ui5sEzDugw9iOOwYwwydq+C0Enj1UA=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-MTmCdZALNw2LfJDoX2KzqQ-1; Fri, 03 Sep 2021 01:55:31 -0400
X-MC-Unique: MTmCdZALNw2LfJDoX2KzqQ-1
Received: by mail-qk1-f197.google.com with SMTP id j27-20020a05620a0a5b00b0042874883070so5251868qka.19
        for <linux-s390@vger.kernel.org>; Thu, 02 Sep 2021 22:55:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YVcqIhLjK1aLZFmGstA8aMe5xkC0R7kiAZwq3yD/UZo=;
        b=Ui4QcVl7wNOWnLxU0EF9HTvswlcKC8zHmUw/vzPyqutsWOVs81A5rv3/NHN+Se+M9k
         OF7o/OpeiMvW+PCjv6Z76Ty2Lm7c6fmSWKIkCPbUjGGz4dvZZEpLj1p02k6GOpqYGnae
         40hKhaFvdt2A91tMDJ10zi+pBXxpmuIiUgsGX3S+o9sAJ7i8M3UJmBkxFj8xvuegR/xf
         rqbEuLbiiMt6V7LmTvB768stKlUz0eihC74HYpUIYpS2/CcWUKO0QQsq/lHB/sTnZJpy
         z4P8lOUlX5zGkvcTOTP7nNCLY0Vwf9iu8SNfhO5YQrlRbBamzTgjDN0m85vKqwfF7OZc
         7D/g==
X-Gm-Message-State: AOAM530cEqRZYyiHY2H7pmSorQVDjK6qbF8rPjlp2sT0xZlvISp9ZX2y
        rAT9zSjyRoLHCukQDKGIpamWNPlycbJI+wCigm12z6G5Sx9Sq8UuNxpd6F5uz8usx/dahBK6Xyh
        UoPAg/ZR2W9NeCAteenys2A==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829201qkk.322.1630648530598;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyBA2PPgx2ogxp7sl4eBWoxXxd8xybtAdlH2aAWqzoyoFquWEXA675Jbr2q0U4tlJxGlHbFOw==
X-Received: by 2002:a05:620a:1529:: with SMTP id n9mr1829187qkk.322.1630648530395;
        Thu, 02 Sep 2021 22:55:30 -0700 (PDT)
Received: from treble ([2600:1700:6e32:6c00::d])
        by smtp.gmail.com with ESMTPSA id g8sm3144077qkm.25.2021.09.02.22.55.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Sep 2021 22:55:29 -0700 (PDT)
Date:   Thu, 2 Sep 2021 22:55:26 -0700
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
Subject: Re: [PATCH 1/4] vmlinux.lds.h: Use regular *RODATA and
 *RO_AFTER_INIT_DATA suffixes
Message-ID: <20210903055526.mmi6hoomawavkbsp@treble>
References: <20210901233757.2571878-1-keescook@chromium.org>
 <20210901233757.2571878-2-keescook@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20210901233757.2571878-2-keescook@chromium.org>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Sep 01, 2021 at 04:37:54PM -0700, Kees Cook wrote:
> Rename the various section macros that live in RODATA and
> RO_AFTER_INIT_DATA. Just being called "DATA" implies they are expected
> to be writable.
> 
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Josh Poimboeuf <jpoimboe@redhat.com>
> Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
> Cc: linux-arch@vger.kernel.org
> Signed-off-by: Kees Cook <keescook@chromium.org>

Acked-by: Josh Poimboeuf <jpoimboe@redhat.com>

-- 
Josh

