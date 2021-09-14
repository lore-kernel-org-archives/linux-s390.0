Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59AD9C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 16:10:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 36C1C60FED
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 16:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234989AbhINQME (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 12:12:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:59984 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235205AbhINQMD (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Sep 2021 12:12:03 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 1EBE061184;
        Tue, 14 Sep 2021 16:10:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631635846;
        bh=EG2I9oaRHQ+gf10Ljpq+PHD1qpxygSWw9ESK9c5OiTI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=IHaez8cpMAtBscPugr8Wcx49J5XMmJfvQ3Mok3kfERhW3dEAPDFubeaLOLLeh9fHG
         t5pEK4LY2m3b8QwYehsOmmn+zYydXxpWeyI/hxKSpEuhTc8H6OvGtmAE2NhlJGK+g3
         i0iqI5O2vxZND4woIXUIws78VJBZv/sXg/SPQRTYh2UPJItg9+zmp6pHD6hfFNF96Q
         Y+GA5w3hfbEPP7jRxdS+2cqxABnGmRf7UBZxcVh0prTu8fgpFidPfDlongZapwbyW6
         vNEe7VR9+LbNh4FHXz4UpdNRgT4H2B3yc0IfMjLEa1EhSNZlHpQwon17Fyxt0NQdXv
         N32FT/mRdaGnA==
Received: by mail-ot1-f49.google.com with SMTP id g66-20020a9d12c8000000b0051aeba607f1so19235288otg.11;
        Tue, 14 Sep 2021 09:10:45 -0700 (PDT)
X-Gm-Message-State: AOAM531KxFi6+kFUJWb+QARtiHxauuDPFE/u7WdbtXJQ8eRK0w+UJ0Ro
        HjFE8l/cINdLwzfNfGotFHDDvzRpuwshANQ2adw=
X-Google-Smtp-Source: ABdhPJy/NGgZ1IROAgHU5psXnjNt0DbcmbCt3vJiiC8iJFGuRSAXr6SftyZ8/TdDx/41hvt3tr6orITFhHtqOeCjlZU=
X-Received: by 2002:a9d:200b:: with SMTP id n11mr15316897ota.30.1631635845243;
 Tue, 14 Sep 2021 09:10:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-6-ardb@kernel.org>
 <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com>
 <CAMj1kXH_Q4a4Gsi0Xuw=YsV-b7Mu8TQndk3Ei-JFaRV=GSiqUQ@mail.gmail.com> <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
In-Reply-To: <CAHk-=wiaVLChOjJ=7fdoQXKE4JHb98MjDtg8pPkA8EYfd5aj3g@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Sep 2021 18:10:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXHKn+RLQf1Nc_7Vs1qVoFZd6RL4=WX8AwoLst18i7n+LA@mail.gmail.com>
Message-ID: <CAMj1kXHKn+RLQf1Nc_7Vs1qVoFZd6RL4=WX8AwoLst18i7n+LA@mail.gmail.com>
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

On Tue, 14 Sept 2021 at 17:59, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Sep 14, 2021 at 8:53 AM Ard Biesheuvel <ardb@kernel.org> wrote:
> >
> > task_cpu() takes a 'const struct task_struct *', whereas
> > task_thread_info() takes a 'struct task_struct *'.
>
> Oh, annoying, but that's easily fixed. Just make that
>
>    static inline struct thread_info *task_thread_info(struct
> task_struct *task) ..
>
> be a simple
>
>   #define task_thread_info(tsk) (&(tsk)->thread_info)
>
> instead. That actually then matches the !THREAD_INFO_IN_TASK case anyway.
>
> Make the commit comment be about how that fixes the type problem.
>
> Because while in many cases inline functions are superior to macros,
> it clearly isn't the case in this case.
>

Works for me.
