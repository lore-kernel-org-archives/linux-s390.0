Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBA50C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:53:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B423761163
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:53:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234946AbhINPya (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:54:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:46192 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234905AbhINPy3 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 11:54:29 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8B98860F11;
        Tue, 14 Sep 2021 15:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631634791;
        bh=SyILGKt3RsxWQZLKn6wlRw/UVoEX8mvp4miVI+z/vYo=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=HZ04Xourmi4uPI/BROV4LV3A0BImAtSUW0BcMr1LQ0ARiNbPPZMZFjVa+zXsdJi27
         63UP/yltipbMB9MgHcllDWmA+E+r+KPo5uyphrDt7ZzSJMi2Gl7nMQD6pRFkDpTj2O
         sENkKq3SrcVv2keytWm/YehRRfuXpzHrYeAO2ovXUnHTJWvQehVzjYMHabmT0icoyS
         iX9iygyFIqVAlScoGbL/xTFmfpzkfWpDKttM0sJMY6weSYzGxAGuS/p9QoNurNfWy+
         vHGWSHv7U1EElEFDnggSOdJI5FBrY4J9S5kTMUKsTYIF1C1j7EOi70w4LZyjXQB4fd
         qYfwT4p4rOeOw==
Received: by mail-oo1-f42.google.com with SMTP id v20-20020a4a2554000000b0028f8cc17378so4819700ooe.0;
        Tue, 14 Sep 2021 08:53:11 -0700 (PDT)
X-Gm-Message-State: AOAM530Hb8wLjv0RjiruUtGM56KjwDLyL1Gj8eYcTpp6PmFiFL3VO42z
        1MlFh8PowEa/QNBXG3C2AJ8k3Qo+vszr2oJrrp8=
X-Google-Smtp-Source: ABdhPJyDFc9VSO5h/RiqccbxZgmZOWSklBB73HxlIVY43T/ttJWTuXgDpoHxXQAJINO0RmpPM1mGY0nlklwutQHfE4k=
X-Received: by 2002:a4a:c904:: with SMTP id v4mr14629736ooq.26.1631634790945;
 Tue, 14 Sep 2021 08:53:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-6-ardb@kernel.org>
 <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com>
In-Reply-To: <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Sep 2021 17:52:59 +0200
X-Gmail-Original-Message-ID: <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
Message-ID: <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com>
Subject: Re: [RFC PATCH 5/8] sched: move CPU field back into thread_info if THREAD_INFO_IN_TASK=y
To:     Linus Torvalds <torvalds@linux-foundation.org>
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

On Tue, 14 Sept 2021 at 17:49, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 14, 2021 at 5:11 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> >  static inline unsigned int task_cpu(const struct task_struct *p)
> >  {
> >  #ifdef CONFIG_THREAD_INFO_IN_TASK
> > -       return READ_ONCE(p->cpu);
> > +       return READ_ONCE(p->thread_info.cpu);
> >  #else
> >         return READ_ONCE(task_thread_info(p)->cpu);
> >  #endif
>
> Those two lines look different, but aren't.
>
> Please just remove the CONFIG_THREAD_INFO_IN_TASK conditional, and use
>
>           return READ_ONCE(task_thread_info(p)->cpu);
>
> unconditionally, which now does the right thing regardless.
>

Unfortunately not.

task_cpu() takes a 'const struct task_struct *', whereas
task_thread_info() takes a 'struct task_struct *'.

Since task_thread_info()-><foo> is widely used as an lvalue, I would
need to update task_cpu()'s prototype and fix up all the callers, some
of which take the const flavor themselves. Or introduce
'const_task_thread_info()' which takes the const flavor, and cannot be
used to instantiate lvalues.

Suggestions welcome, but this is the cleanest I could come up with.
