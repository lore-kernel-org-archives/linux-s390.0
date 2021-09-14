Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CFCFC433EF
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:59:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3527061151
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:59:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232916AbhINQAp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:00:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbhINQAo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Sep 2021 12:00:44 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D7B1C061574
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:59:27 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id o20so19418988ejd.7
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XpWi4volfcYSm2oFWphGxI70Xoc4gQDszmXfggbAPag=;
        b=bXLrDvRwiE9LUrsUdTaOb8qv3MpstEI39Z126QnyB2PTkNIRA+z5Ylw/tbECp2MHmV
         gX1JHV2JOFK1e1MJCTTlwV1kibUe3fFGD3LyBUKt18UoGfT0okDbQ+10t1fJme/j5P5U
         D2vgNrnv1RgcRafeCGUDJ8RsTcI/ITO4E3K7Y=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XpWi4volfcYSm2oFWphGxI70Xoc4gQDszmXfggbAPag=;
        b=ZjPK3LQsrw2uNY8E0NRNlrlXMPYNjt+lmnGr6qdiOarGgYhq1xdLaC9c24mkWG4Ksf
         LrL2BLJmC0C81MI3pSY/IpRyMa/eQuhAdk884GQNEnSy8BqBOKhS2sJ2KxwDtQs/7f8J
         NAqz7ab+YMw8xOmo+fErexNJIIz+mny9j2EgYeS3jJzLRvCIgNzpW9W9UoIAVQ59do+x
         dV0l5eO9/h/J8oxUksm0kI6TU2x1wazVhW1fC2xq/XEN/gliGajxuyt8/EZ2WqEgoZCG
         Z7HKhBrBJELJtt6FeKemRnb3MB6u+t3xsfzmgC2ROrlFOTUZYa4J0xaDf9mn8IXjR/V9
         A5sA==
X-Gm-Message-State: AOAM530OBotE9ra/oe1UG94JAdfHA16VO6KPFiX/YYECvyMctuU3g2tE
        CQ0KzLvje+mH6R1ClteanubJjdtY0s70MrXgpjU=
X-Google-Smtp-Source: ABdhPJwZWeW7ZomZ3+U4cq2hVaEzzJBbSiRn4WhsYW2WZsZwXEaIGFyA1nTjG2oiU/OtSdSrhAK05w==
X-Received: by 2002:a17:906:689b:: with SMTP id n27mr956342ejr.459.1631635165359;
        Tue, 14 Sep 2021 08:59:25 -0700 (PDT)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id h10sm5114996ede.28.2021.09.14.08.59.24
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:59:25 -0700 (PDT)
Received: by mail-ed1-f44.google.com with SMTP id n10so20673562eda.10
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:59:24 -0700 (PDT)
X-Received: by 2002:a2e:8107:: with SMTP id d7mr16501365ljg.68.1631635154125;
 Tue, 14 Sep 2021 08:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-6-ardb@kernel.org>
 <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com> <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
In-Reply-To: <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:58:58 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
Message-ID: <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
Subject: Re: [RFC PATCH 5/8] sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
To:     Ard Biesheuvel <ardb@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Paul Mackerras <paulus@samba.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>,
        Andy Lutomirski <luto@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Sep 14, 2021 at 8:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
> task_cpu() takes a 'const struct task_struct *', whereas
> task_thread_info() takes a 'struct task_struct *'.

Oh, annoying, but that's easily fixed. Just make that

   static inline struct thread_info *task_thread_info(struct
task_struct *task) ..

be a simple

  #define task_thread_info(tsk) (&(tsk)->thread_info)

instead. That actually then matches the !THREAD_INFO_IN_TASK case anyway.

Make the commit comment be about how that fixes the type problem.

Because while in many cases inline functions are superior to macros,
it clearly isn't the case in this case.

              Linus
