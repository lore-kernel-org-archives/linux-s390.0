Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECD42C433EF
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 15:44:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D5BED61002
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 15:44:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbhJYPrH (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Oct 2021 11:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232679AbhJYPrG (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 25 Oct 2021 11:47:06 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 3B50461002;
        Mon, 25 Oct 2021 15:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1635176684;
        bh=t/cG3NYZufoQXI80MvoVKxbOhh2gfbNI54UCGBT3C9s=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gxmadbL12O9CP1CNjr+LPFEaW4SzKdMH7wBlnUxy2TzbQ9gtUNV7DEu1WSahSAdvL
         u/BXtC5jblBxPTnpfFqJLIzEtCppyKyls5mNlnSUYhZum9GY/TH9dg/+vSn7xHICbC
         GLEZE6+WCHun6enc8dfKsjr2kBQWjDquNQv9BmuqxtjICcILdqOVO5TSfQnsQr7pUo
         9mokyel9t8DVcl3p+kpJ5J3zE1W6ObHH5vLJl7Mp+ES8XFxHce3uPgJ/Mf77S+X4Hm
         jYNewKS1aqWHMc6o18eqCgLn8SvSOXBCAmZWVHf49oAPQY46Q6rUNL5PhVtyNchEfn
         6muiFFPGVzArQ==
Received: by mail-wm1-f49.google.com with SMTP id z11-20020a1c7e0b000000b0030db7b70b6bso13618944wmc.1;
        Mon, 25 Oct 2021 08:44:44 -0700 (PDT)
X-Gm-Message-State: AOAM530Cn/8lzBrbj2Km/5FXTNqESozWc4szJDAsB9a9uzUki1tusjUC
        Sz1FiNP9ty7KA5mK/2nKPd8l9wNTrklcDOj8fZQ=
X-Google-Smtp-Source: ABdhPJwVwah/t3YoUqrQSaMsXvLvLT7cunG21zPbQEpZN6hLw+z/xKNabDoDNkoQgi86rA+/qLopU3mOKvl8de4bOgo=
X-Received: by 2002:a7b:ce93:: with SMTP id q19mr7749701wmj.98.1635176682689;
 Mon, 25 Oct 2021 08:44:42 -0700 (PDT)
MIME-Version: 1.0
References: <20211022120058.1031690-1-arnd@kernel.org> <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
 <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net> <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
 <2413f412-a390-bbc0-e848-e2a77d1f0ab3@redhat.com>
In-Reply-To: <2413f412-a390-bbc0-e848-e2a77d1f0ab3@redhat.com>
From:   Arnd Bergmann <arnd@kernel.org>
Date:   Mon, 25 Oct 2021 17:44:26 +0200
X-Gmail-Original-Message-ID: <CAK8P3a3JEBF-dEg0iVThMMRNK3CDxY+mRtTeStMusycnethO_g@mail.gmail.com>
Message-ID: <CAK8P3a3JEBF-dEg0iVThMMRNK3CDxY+mRtTeStMusycnethO_g@mail.gmail.com>
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
To:     Waiman Long <longman@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Mon, Oct 25, 2021 at 5:28 PM Waiman Long <longman@redhat.com> wrote:
> On 10/25/21 9:06 AM, Arnd Bergmann wrote:
> >
> > On s390, we pick between the cmpxchg() based directed-yield when
> > running on virtualized CPUs, and a normal qspinlock when running on a
> > dedicated CPU.
>
> I am not aware that s390 is using qspinlocks at all as I don't see
> ARCH_USE_QUEUED_SPINLOCKS being set anywhere under arch/s390. I only see
> that it uses a cmpxchg based spinlock.

Sorry, I should not have said "normal" here. See arch/s390/lib/spinlock.c
for their custom queued spinlocks as implemented in arch_spin_lock_queued().
I don't know if that code actually does the same thing as the generic qspinlock,
but it seems at least similar.

       Arnd
