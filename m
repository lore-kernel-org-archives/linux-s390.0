Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15119C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:47:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F05256113E
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 15:47:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234534AbhINPsl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 11:48:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234462AbhINPsl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Sep 2021 11:48:41 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23B2C061574
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:47:23 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id g8so20650426edt.7
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:47:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=AuGH7A1j3mwghnSNlt7ii3pSP3zqhI3ZLfhyE1/i7mY=;
        b=R7AKqlIgzHsNi6Tq6c2IwOarByE0iXqz4YlcYfOLGqwYPfSWeFNr9LdrOHY0sHRCu8
         naDWlgwpYmTs3LAeSJhTpybHunXV2G0Zr6u1AYtP8z+sHgAVUF85Ux4F5km4EfIbfx7r
         jZuWndb2Alk2aESrYA3wH6fpzGqN1esmqt/VE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=AuGH7A1j3mwghnSNlt7ii3pSP3zqhI3ZLfhyE1/i7mY=;
        b=qoWujYn49mPmShr76q/4yLB/3D97xi3Nv7Ky3r87sGGoRuKG31WB9DAMhBpXOFic7o
         +9thNPNAC+rMMWHrvejCIsT10HnBHi6BZjDSuE4DGKtaVFffb5hlVraTPIykgKLk93wM
         1mClFIRf4vPajtxcdHU0ry36Zzkwo696tO1BTZiaJ8tVb4WHIYp8h8gBFs+uAHEjIis4
         0XvjbaOuys7fcE1WiNLGOwvD9Xo0Ya3K7t10Irg2BD5iCv3Iw8uMSYRFqps3AZDz0hia
         8oPbSgjMmvIaLmRCWvSsCetwOyhaWb1+tJQzAStu04hyYKBAgS0hwKc3tZ4c+nEgRzT7
         kDvg==
X-Gm-Message-State: AOAM531+WcYKthlcG5AB7084RydVfwEYjydRyOPEGLjtW4/aeTSB4NYQ
        UbvMwqCLKEutaXltiYgioYaEnKKn9ZeIagvvPYA=
X-Google-Smtp-Source: ABdhPJwg9rmtV/6R9m9DqDGelQ7+v+VBm/AN5dTRn717qK3/eFBMcQY8sbbuOhvC7HZLcI43D3v7sw==
X-Received: by 2002:a05:6402:2913:: with SMTP id ee19mr4877700edb.332.1631634441768;
        Tue, 14 Sep 2021 08:47:21 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id v1sm5315826ejd.31.2021.09.14.08.47.21
        for <linux-s390@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Sep 2021 08:47:21 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id i23so21006937wrb.2
        for <linux-s390@vger.kernel.org>; Tue, 14 Sep 2021 08:47:21 -0700 (PDT)
X-Received: by 2002:a2e:8185:: with SMTP id e5mr15545178ljg.31.1631634430421;
 Tue, 14 Sep 2021 08:47:10 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-6-ardb@kernel.org>
In-Reply-To: <20210914121036.3975026-6-ardb@kernel.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 14 Sep 2021 08:46:54 -0700
X-Gmail-Original-Message-ID: <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com>
Message-ID: <CAHk-=whLEofPLzzTKXN5etnH5WqsTPQRLVv8uQgHnx7c59omBg@mail.gmail.com>
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

On Tue, Sep 14, 2021 at 5:11 AM Ard Biesheuvel <ardb@kernel.org> wrote:
>
>  static inline unsigned int task_cpu(const struct task_struct *p)
>  {
>  #ifdef CONFIG_THREAD_INFO_IN_TASK
> -       return READ_ONCE(p->cpu);
> +       return READ_ONCE(p->thread_info.cpu);
>  #else
>         return READ_ONCE(task_thread_info(p)->cpu);
>  #endif

Those two lines look different, but aren't.

Please just remove the CONFIG_THREAD_INFO_IN_TASK conditional, and use

          return READ_ONCE(task_thread_info(p)->cpu);

unconditionally, which now does the right thing regardless.

             Linus
