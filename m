Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3174AC48BE5
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1AC8B61356
	for <linux-s390@archiver.kernel.org>; Tue, 22 Jun 2021 08:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhFVILl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 22 Jun 2021 04:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbhFVILl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 22 Jun 2021 04:11:41 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07398C061760
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 01:09:24 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id t4-20020a9d66c40000b029045e885b18deso257957otm.6
        for <linux-s390@vger.kernel.org>; Tue, 22 Jun 2021 01:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+KIhMHmG9xEoplSTe5YdDdzfi1paJ8XARniBwjTg03k=;
        b=Ym455ybyRuVNtnqTpdt7P8X+q69idT6SEJDlahlRmKJV8J1gpOx0evM0YjyJjusrTf
         a8cXrmGrAxJi7wlgusfO0uVUo/9QC971ql1DFoeOSzqCDZzmmHzsiKbu8s3eDfoCSt6G
         P2swb91IEChiat4UVcQfZ6vzmOk8Glck115Ho3zoNfvpzah8z5QZpvwHE39XDIyAgBuv
         5gKW3tUs6lXErSCW6dacjs/ovleLewk67xUMAYNuTPq0/GqpoqUPtJ4oQBzqKf+sfFss
         /PtP6vNZC9LNRq6pivnr+kGJzasgfAfQuYKy+cVS8XlVMpWthsCQBcaV6ll+O2N9Akmy
         ksdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+KIhMHmG9xEoplSTe5YdDdzfi1paJ8XARniBwjTg03k=;
        b=Qmqvr9HJM1BCtjINlnakAQ8JiaKSwpTTAWmP4zmIp8E9+8Dhl6RGo9URVkF7d50ERN
         ES8Bw9BPfCliIaFBZwNMxuxvb6WgqWj75dmFl4V1uoCqi/lHgBTpW8ee0HAn+LF0eXxy
         q6jC9B3FSb7Qhul40kOoUxorQBR8DW3URUckDBUBXbf2DY9R1tCfVnTUUjAaBnghPAQ5
         XNLElWkz7+ZX1KX3asWO1r6V3D4MIavTv0piC+FcW8sfFPstbDg/04D3e+AsYZrKXmU2
         tIP68E5t+73d4TpF350PBYLBTkeCWFuPp6fSVfjaIFB0Nye8iaN32PY8ipSiQf+QLKvU
         KLjw==
X-Gm-Message-State: AOAM532B/b7+bSmnw9Z8SF5D7aIXg3buD/ZENpeycPRbsn7iFWs1L/HQ
        qJ4AY6UcKVV9XS3IdVb/GfhMGVmq/SbFuQjgDGVdCQ==
X-Google-Smtp-Source: ABdhPJxgFSBmdcbDb55PtEoRgnwSIeaz86uH0dDuE3fvOVYXbp9t15kLoyQklb8X4sv2BZbnmGZBqSmyIw3TqpcW5Eg=
X-Received: by 2002:a05:6830:1bcb:: with SMTP id v11mr2131100ota.251.1624349363988;
 Tue, 22 Jun 2021 01:09:23 -0700 (PDT)
MIME-Version: 1.0
References: <20210621231822.2848305-1-ndesaulniers@google.com>
 <20210621231822.2848305-4-ndesaulniers@google.com> <YNGQhgKd9Ruti5qZ@hirez.programming.kicks-ass.net>
In-Reply-To: <YNGQhgKd9Ruti5qZ@hirez.programming.kicks-ass.net>
From:   Marco Elver <elver@google.com>
Date:   Tue, 22 Jun 2021 10:09:10 +0200
Message-ID: <CANpmjNMsM+tgf2Moy72Xd2oAxpVsAkXXYFtOodvVP5vRZDwdaA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] Kconfig: add ARCH_WANTS_NO_INSTR+CC_HAS_NO_PROFILE_FN_ATTR,
 depend on for GCOV and PGO
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Kees Cook <keescook@chromium.org>,
        Bill Wendling <wcw@google.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com,
        x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Martin Liska <mliska@suse.cz>,
        Jonathan Corbet <corbet@lwn.net>,
        Fangrui Song <maskray@google.com>, linux-doc@vger.kernel.org,
        linux-kbuild@vger.kernel.org, Dmitry Vyukov <dvyukov@google.com>,
        johannes.berg@intel.com, linux-toolchains@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 22 Jun 2021 at 09:26, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Jun 21, 2021 at 04:18:22PM -0700, Nick Desaulniers wrote:
> > We don't want compiler instrumentation to touch noinstr functions, which
> > are annotated with the no_profile_instrument_function function
> > attribute. Add a Kconfig test for this and make PGO and GCOV depend on
> > it.
> >
> > If an architecture is using noinstr, it should denote that via this
> > Kconfig value. That makes Kconfigs that depend on noinstr able to
> > express dependencies in an architecturally agnostic way.
> >
> > Cc: Masahiro Yamada <masahiroy@kernel.org>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Link: https://lore.kernel.org/lkml/YMTn9yjuemKFLbws@hirez.programming.kicks-ass.net/
> > Link: https://lore.kernel.org/lkml/YMcssV%2Fn5IBGv4f0@hirez.programming.kicks-ass.net/
> > Suggested-by: Nathan Chancellor <nathan@kernel.org>
> > Suggested-by: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>
> > ---
> > Changes V1 -> V2:
> > * Add ARCH_WANTS_NO_INSTR
> > * Change depdendencies to be !ARCH_WANTS_NO_INSTR || CC_HAS_NO_PROFILE_FN_ATTR
> >   rather than list architectures explicitly, as per Nathan.
> > * s/no_profile/no_profile_instrument_function/
> >
> >  arch/Kconfig        | 7 +++++++
> >  arch/arm64/Kconfig  | 1 +
> >  arch/s390/Kconfig   | 1 +
> >  arch/x86/Kconfig    | 1 +
> >  init/Kconfig        | 3 +++
> >  kernel/gcov/Kconfig | 1 +
> >  kernel/pgo/Kconfig  | 3 ++-
> >  7 files changed, 16 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/Kconfig b/arch/Kconfig
> > index 2b4109b0edee..2113c6b3b801 100644
> > --- a/arch/Kconfig
> > +++ b/arch/Kconfig
> > @@ -285,6 +285,13 @@ config ARCH_THREAD_STACK_ALLOCATOR
> >  config ARCH_WANTS_DYNAMIC_TASK_STRUCT
> >       bool
> >
> > +config ARCH_WANTS_NO_INSTR
> > +     bool
> > +     help
> > +       An architecure should select this if the noinstr macro is being used on
> > +       functions to denote that the toolchain should avoid instrumenting such
> > +       functions and is required for correctness.
> > +
> >  config ARCH_32BIT_OFF_T
> >       bool
> >       depends on !64BIT
>
> There's also CC_HAS_WORKING_NOSANITIZE_ADDRESS in lib/Kconfig.kasan that
> might want to be hooked into this, but that can be done separately I
> suppose.

KASAN already depends on this for all compiler instrumentation modes,
not just for 'noinstr' but also to avoid false positives. So it's not
just for noinstr's benefit, and we should not weaken the requirement
there.
