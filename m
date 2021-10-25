Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48D0CC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 13:06:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E3A660F92
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 13:06:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233441AbhJYNJF (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Oct 2021 09:09:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:33808 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233340AbhJYNJF (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Oct 2021 09:09:05 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id C838C60F92;
        Mon, 25 Oct 2021 13:06:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635167202;
        bh=ZCuob8BZrhlG+EmJNscDR7p2oOKkE8Oq9/x5u4oFHEA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FuPaO5h+P7m9O6f7jRX/FomhBE8wpXrQg46b5X/6nDR7a9FqlQoUCB6YkaGCFB4Qg
         9D0CqlTmvZwvwJoh4muObhBZmgmwMAb2I+SYudFaX7JYcTkGlmq+i4fWkanSJLgR8Z
         jUwIOx7GR2kLD0UUChm2UfR21umaKf01WuYBFZMWUzBgwv2B8JfwjcwD++K4i0EwgG
         +f5C0c0QSkTihCtJyXq/srIkiZfs/y50C2PSJPY/WZFtQxrY5DR7iJM/RE3f8JwOga
         SlBTGoq31CwHhSi2fX8vx7KhB0B/6wLW7b15SLXQodFLa9nbkIa2Np6fw+sWezH3z8
         EHLEv5gY54ilQ==
Received: by mail-wm1-f53.google.com with SMTP id b133-20020a1c808b000000b0032ca4d18aebso9291702wmd.2;
        Mon, 25 Oct 2021 06:06:42 -0700 (PDT)
X-Gm-Message-State: AOAM530JJJXzVpVQci/B5m5pceKZ3rEt3msx00ppM2V6g5vnHHJnQvEz
        F/k1JcQRh3dDsnxVnTS+lRgrxQK2Taol7sqXJI4=
X-Google-Smtp-Source: ABdhPJzvjBncUZE2QFv7r8anYBis3Hwxw5+smqgbcmZGe49Rh+5b7Sf365AJDO4MLIyZVs8sWDAX066taTW3DQLxG28=
X-Received: by 2002:a05:600c:1548:: with SMTP id f8mr19963769wmg.35.1635167201284;
 Mon, 25 Oct 2021 06:06:41 -0700 (PDT)
MIME-Version: 1.0
References: <20211022120058.1031690-1-arnd@kernel.org> <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com> <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
In-Reply-To: <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Oct 2021 15:06:24 +0200
X-Gmail-Original-Message-ID: <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
Message-ID: <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Openrisc <openrisc@lists.librecores.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 25, 2021 at 11:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
> On Sat, Oct 23, 2021 at 06:04:57PM +0200, Arnd Bergmann wrote:
> > On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
> > >> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> > > > From: Arnd Bergmann <arnd@arndb.de>
> > > >
> > > > As this is all dead code, just remove it and the helper functions built
> > > > around it. For arch/ia64, the inline asm could be cleaned up, but
> > > > it seems safer to leave it untouched.
> > > >
> > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> > >
> > > Does that mean we can also remove the GENERIC_LOCKBREAK config option
> > > from the Kconfig files as well?
> >
> >  I couldn't figure this out.
> >
> > What I see is that the only architectures setting GENERIC_LOCKBREAK are
> > nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
> > implementing arch_spin_is_contended() are arm32, csky and ia64.
> >
> > The part I don't understand is whether the option actually does anything
> > useful any more after commit d89c70356acf ("locking/core: Remove break_lock
> > field when CONFIG_GENERIC_LOCKBREAK=y").
>
> Urgh, what a mess.. AFAICT there's still code in
> kernel/locking/spinlock.c that relies on it. Specifically when
> GENERIC_LOCKBREAK=y we seem to create _lock*() variants that are
> basically TaS locks which drop preempt/irq disable while spinning.
>
> Anybody having this on and not having native TaS locks is in for a rude
> surprise I suppose... sparc64 being the obvious candidate there :/

Is this a problem on s390 and powerpc, those two being the ones
that matter in practice?

On s390, we pick between the cmpxchg() based directed-yield when
running on virtualized CPUs, and a normal qspinlock when running on a
dedicated CPU.

On PowerPC, we pick at compile-time between either the qspinlock
(default-enabled on Book3S-64, i.e. all server chips) or a ll/sc based
spinlock plus vm_yield() (default on embedded and 32-bit mac).

       Arnd
