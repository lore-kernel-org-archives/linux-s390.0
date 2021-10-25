Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4EBDC433EF
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 09:58:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BBC6760FDC
	for <linux-s390@archiver.kernel.org>; Mon, 25 Oct 2021 09:58:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbhJYKAi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 25 Oct 2021 06:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbhJYKAi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 25 Oct 2021 06:00:38 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77274C061745;
        Mon, 25 Oct 2021 02:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=kBcBoUwV55Vzzvl24KD3p0ArPNxglJAR5S99vkQU21A=; b=MBCIXeXhf6eTBncr2QpHLUaYS7
        6G6hOzIwUql2vqiXbPvPa9A34kSeid/gzxP9EN8BQVKIOSUqesYOAciHBywhpFV3bEqT11li2ezNu
        zXx9DIsxagTnN0sBGW93C3YbKy15aQnc8uqykO8jv9JtgA7VFmGzMn4I4p3JH8gdxJP7oqeAJkvZK
        9hy4dbsx6zYQT7WBZKaHuQoTx6ibgTsFc6MJcGaipDs9afWbC+XldzOHN6X5mUvDpqD4/OWFj24A9
        qTxIRw6JiXreO28PuVyy/+uQk7JTwDJ6Zg/u5Y+Y7ul3SpvRSdBp1gBelToDOuKySSBC3ttwob/pS
        /4/6lXZQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mewjU-00C7ZM-Sf; Mon, 25 Oct 2021 09:57:33 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 9A95B3002AE;
        Mon, 25 Oct 2021 11:57:28 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 74DE220C6C150; Mon, 25 Oct 2021 11:57:28 +0200 (CEST)
Date:   Mon, 25 Oct 2021 11:57:28 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Arnd Bergmann <arnd@kernel.org>
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
Subject: Re: [PATCH] locking: remove spin_lock_flags() etc
Message-ID: <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sat, Oct 23, 2021 at 06:04:57PM +0200, Arnd Bergmann wrote:
> On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
> >> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
> > > From: Arnd Bergmann <arnd@arndb.de>
> > >
> > > As this is all dead code, just remove it and the helper functions built
> > > around it. For arch/ia64, the inline asm could be cleaned up, but
> > > it seems safer to leave it untouched.
> > >
> > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> >
> > Does that mean we can also remove the GENERIC_LOCKBREAK config option
> > from the Kconfig files as well?
> 
>  I couldn't figure this out.
> 
> What I see is that the only architectures setting GENERIC_LOCKBREAK are
> nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
> implementing arch_spin_is_contended() are arm32, csky and ia64.
> 
> The part I don't understand is whether the option actually does anything
> useful any more after commit d89c70356acf ("locking/core: Remove break_lock
> field when CONFIG_GENERIC_LOCKBREAK=y").

Urgh, what a mess.. AFAICT there's still code in
kernel/locking/spinlock.c that relies on it. Specifically when
GENERIC_LOCKBREAK=y we seem to create _lock*() variants that are
basically TaS locks which drop preempt/irq disable while spinning.

Anybody having this on and not having native TaS locks is in for a rude
surprise I suppose... sparc64 being the obvious candidate there :/



