Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E73F7C433FE
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 13:18:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C57B661139
	for <linux-s390@archiver.kernel.org>; Tue, 28 Sep 2021 13:18:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240669AbhI1NUi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 28 Sep 2021 09:20:38 -0400
Received: from mail.kernel.org ([198.145.29.99]:59174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S240907AbhI1NUg (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 28 Sep 2021 09:20:36 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3CF44611CC;
        Tue, 28 Sep 2021 13:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632835137;
        bh=VeB5GXPFGYAi+MDx0ZEO0Lyx1tXoFrq/FrWnMOweEWQ=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=D3dc8sMvlzcVo4NjXJ2vCRYVxSd/g7YSq3UTSfBOQFPNSX//4VhBwZC3SAWmebs/Q
         iHi/R9QijnXcrS5mBfMuL34YavB44RRDFDtOkkKW6diQ08yr76Z06D7TQDyweNMim1
         87hzyb5rjoc4JbHlt9OKqreZ14uLoiJtGPYxRZYxgfI47GSGbk3hGjd50oUO9x8/6/
         z9yjU+XfDMXOieObCTTm20a1I1NWslqCYKQ1z0NsGimH0+rt72IVWKA9UtU2K7x+ag
         0YHiMFXNMvZO93ij5Kqk/yZUxaU8LZDdOWuhm6olHJ19+zelgyeEb3E7rfpuTp9qC2
         nHGTzbmrO+G3w==
Received: by mail-oi1-f174.google.com with SMTP id s24so27324696oij.8;
        Tue, 28 Sep 2021 06:18:57 -0700 (PDT)
X-Gm-Message-State: AOAM531wJ9oTHOJWYqDDXg4ZKxL5KRcXzOAeFDS9KApx4OOakfQkdJel
        DGfhKtjs7gYwuk8yqQBlZx4nYdlQ4clRGdwoyls=
X-Google-Smtp-Source: ABdhPJyep3Pw1Kqo5huUAuGsrpllZ2c8nSuyzA6EOwJFgMmmBzpyy+vZsyEyrP7TXFbetznr+4dx/vVu8duHYpn76tM=
X-Received: by 2002:a05:6808:1148:: with SMTP id u8mr3509831oiu.33.1632835136613;
 Tue, 28 Sep 2021 06:18:56 -0700 (PDT)
MIME-Version: 1.0
References: <20210914121036.3975026-1-ardb@kernel.org> <20210914121036.3975026-5-ardb@kernel.org>
 <CAMj1kXEojbQbNzCP39KT4EzFAyW3J1Tfm_stCZ+fGo8_SO90PA@mail.gmail.com>
 <87ee99lii7.fsf@mpe.ellerman.id.au> <87pmst1rn9.fsf@mpe.ellerman.id.au>
In-Reply-To: <87pmst1rn9.fsf@mpe.ellerman.id.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 28 Sep 2021 15:18:45 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFXtbD3=L+QvCnwbyFr-qbWivZ0wRGT0N4LNxANPD8x4g@mail.gmail.com>
Message-ID: <CAMj1kXFXtbD3=L+QvCnwbyFr-qbWivZ0wRGT0N4LNxANPD8x4g@mail.gmail.com>
Subject: Re: [RFC PATCH 4/8] powerpc: add CPU field to struct thread_info
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Keith Packard <keithpac@amazon.com>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)" 
        <linuxppc-dev@lists.ozlabs.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        "open list:S390" <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 28 Sept 2021 at 02:16, Michael Ellerman <mpe@ellerman.id.au> wrote:
>
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Ard Biesheuvel <ardb@kernel.org> writes:
> >> On Tue, 14 Sept 2021 at 14:11, Ard Biesheuvel <ardb@kernel.org> wrote:
> >>>
> >>> The CPU field will be moved back into thread_info even when
> >>> THREAD_INFO_IN_TASK is enabled, so add it back to powerpc's definition
> >>> of struct thread_info.
> >>>
> >>> Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
> >>
> >> Michael,
> >>
> >> Do you have any objections or issues with this patch or the subsequent
> >> ones cleaning up the task CPU kludge for ppc32? Christophe indicated
> >> that he was happy with it.
> >
> > No objections, it looks good to me, thanks for cleaning up that horror :)
> >
> > It didn't apply cleanly to master so I haven't tested it at all, if you can point me at a
> > git tree with the dependencies I'd be happy to run some tests over it.
>
> Actually I realised I can just drop the last patch.
>
> So that looks fine, passes my standard quick build & boot on qemu tests,
> and builds with/without stack protector enabled.
>

Thanks.

Do you have any opinion on how this series should be merged? Kees Cook
is willing to take them via his cross-arch tree, or you could carry
them if you prefer. Taking it via multiple trees at the same time is
going to be tricky, or take two cycles, with I'd prefer to avoid.

-- 
Ard.
