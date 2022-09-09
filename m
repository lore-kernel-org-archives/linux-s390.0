Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D5B7ECAAD3
	for <linux-s390@archiver.kernel.org>; Fri,  9 Sep 2022 08:44:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230472AbiIIIof (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 9 Sep 2022 04:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230095AbiIIIod (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 9 Sep 2022 04:44:33 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AA6115FF1
        for <linux-s390@vger.kernel.org>; Fri,  9 Sep 2022 01:44:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id a67so1678034ybb.3
        for <linux-s390@vger.kernel.org>; Fri, 09 Sep 2022 01:44:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UxHqcjqLV5SMzyyvdPn90TGI1ZaTqe/aoS8WhMGAgLo=;
        b=sw9SXPNgEqTzFEbub1fMIikW5XRHX3LXyotY2uUKcbNka3uMRULDKd2+TtJU9JhNsY
         HuRyRmzy75Vl795pPEj7Snw+41oN5Vj2TSr/I+MajIzPkaarOdZNazWvUr0P6Q2gXg23
         /eaTrmPP+f8iXnq3Ad2kFaC4PWXlDf10Zb9eSYkDI+Ke8zXfheTbaYDe7QxQcuuo8H8I
         JDc1wga/VBWxbOPuVo/H5bPeQ3ad4yNhMM/jqc4LUHGUiJCFuLTMJZEtBeRyvN3yA6kR
         5RPxxKX4BULHj0BKRJFwnYqFK/P5B3n6yVQbxK8G5FpaZ7374oOeYy5ksTOUcd/2wN3B
         p+8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UxHqcjqLV5SMzyyvdPn90TGI1ZaTqe/aoS8WhMGAgLo=;
        b=SFNnTpfS1sNrwLGs3h+2gU0pai9HMRdPjaB2+o9MqfJh6Xkc7rSoUF0VyDBqL06AVF
         lpsDQBtu8Uj5Pi8TDDnZ+kf71H5jDKvNwR9vY31h6WllEzxb+Zgf0TCTMEXglmSi6Pfu
         tZtuTLzR/fjFOJ1FY0MOVwOCjbgGgWqp+z1AuZeh+3r5qLYzltECt3c68bHWX4N2uwCn
         otP16sFwsQJemI1SbXAzpSeB4iU23AF60szlUBZ60jil24KjRCEugWcetSP0CjF6cA9g
         RByLJoLh9C0b82eJz+2kGEyXyiVPI3mNoiz4EMV1uF3lWfGRjYQp6rZldTPKrKdxf0IK
         jPnw==
X-Gm-Message-State: ACgBeo1t66iseBzqcn6hev8xwzFif2SoGNteUey/vYbEki8+P1Hiqcvx
        QPHhCgiLEcPUMGbmsoII5G35BhPTczukbexABB6VjA==
X-Google-Smtp-Source: AA6agR50LVYT/iKxeiXfZ1bnFnp7Ke4DBBdARvNMANKD4ACstbuhW0lSj6LRta+0KeY8t2U7vFcCdnQLIe3Imfh2cWQ=
X-Received: by 2002:a25:d686:0:b0:6a8:e9a8:54f7 with SMTP id
 n128-20020a25d686000000b006a8e9a854f7mr10920047ybg.611.1662713070956; Fri, 09
 Sep 2022 01:44:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220909073840.45349-1-elver@google.com> <20220909073840.45349-2-elver@google.com>
 <CACT4Y+Zuf+ynzSbboTAN0_VLedeVErO6qm49H4YzuR1e8EgJUQ@mail.gmail.com>
In-Reply-To: <CACT4Y+Zuf+ynzSbboTAN0_VLedeVErO6qm49H4YzuR1e8EgJUQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Fri, 9 Sep 2022 10:43:54 +0200
Message-ID: <CANpmjNOz9bomQv=Zem6kw9xamhp1yPKf3iCrVvhkzHxE2pcp0A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] kcsan: Instrument memcpy/memset/memmove with newer Clang
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Potapenko <glider@google.com>,
        Boqun Feng <boqun.feng@gmail.com>, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-s390@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, 9 Sept 2022 at 10:38, Dmitry Vyukov <dvyukov@google.com> wrote:
>
> On Fri, 9 Sept 2022 at 09:38, Marco Elver <elver@google.com> wrote:
> >
> > With Clang version 16+, -fsanitize=thread will turn
> > memcpy/memset/memmove calls in instrumented functions into
> > __tsan_memcpy/__tsan_memset/__tsan_memmove calls respectively.
> >
> > Add these functions to the core KCSAN runtime, so that we (a) catch data
> > races with mem* functions, and (b) won't run into linker errors with
> > such newer compilers.
> >
> > Cc: stable@vger.kernel.org # v5.10+
> > Signed-off-by: Marco Elver <elver@google.com>
> > ---
> > v2:
> > * Fix for architectures which do not provide their own
> >   memcpy/memset/memmove and instead use the generic versions in
> >   lib/string. In this case we'll just alias the __tsan_ variants.
> > ---
> >  kernel/kcsan/core.c | 39 +++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 39 insertions(+)
> >
> > diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
> > index fe12dfe254ec..4015f2a3e7f6 100644
> > --- a/kernel/kcsan/core.c
> > +++ b/kernel/kcsan/core.c
> > @@ -18,6 +18,7 @@
> >  #include <linux/percpu.h>
> >  #include <linux/preempt.h>
> >  #include <linux/sched.h>
> > +#include <linux/string.h>
> >  #include <linux/uaccess.h>
> >
> >  #include "encoding.h"
> > @@ -1308,3 +1309,41 @@ noinline void __tsan_atomic_signal_fence(int memorder)
> >         }
> >  }
> >  EXPORT_SYMBOL(__tsan_atomic_signal_fence);
> > +
> > +#ifdef __HAVE_ARCH_MEMSET
> > +void *__tsan_memset(void *s, int c, size_t count);
> > +noinline void *__tsan_memset(void *s, int c, size_t count)
> > +{
> > +       check_access(s, count, KCSAN_ACCESS_WRITE, _RET_IP_);
>
> These can use large sizes, does it make sense to truncate it to
> MAX_ENCODABLE_SIZE?

Hmm, good point - that way it can still set up watchpoints on them.
I'll do a v3.
