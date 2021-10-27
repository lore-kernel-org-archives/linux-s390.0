Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D2EAC433EF
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 12:01:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 359E260E8B
	for <linux-s390@archiver.kernel.org>; Wed, 27 Oct 2021 12:01:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240288AbhJ0MEQ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:04:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240286AbhJ0MEQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 27 Oct 2021 08:04:16 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B49C061570;
        Wed, 27 Oct 2021 05:01:50 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4HfS3D6fVvz4xbG;
        Wed, 27 Oct 2021 23:01:44 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1635336108;
        bh=eZo4L/VYResFxnSjYMuAe6p73rb/55QbmAx/d4+9tG4=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=JQ5dRRYao96n2QjnD9F5FAugsZopemn7Y8YqAmL2meL1PnI4mYsKSjfuExzvZpuA5
         fo98C/+hhHVxXiymFsgVUaNNU2OXZOe+c6bLZFJtrn3hoVRsK8UVbP9gK878GEbfPD
         VDvIrUapL3PKDDjCdUgv6N8Ux67vWT8CizDcTwrTHynUtV9jf15u69Gl+rLY036ixg
         zeY96EVJi9rErgfmwBI6fcGPd1tomYN/VkCpDGNVYTfs0wOrl9IkcGEvhuiGpQKYnb
         nfU4vnXu2gWqpvtG5V7u9/EXKXYSjwtZbh/n8+Hk2z9uQ9E8oJ+OXVuNanRAXRdn+r
         +hzmwqKHzlS9Q==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Peter Zijlstra <peterz@infradead.org>,
        Arnd Bergmann <arnd@kernel.org>
Cc:     Waiman Long <longman@redhat.com>, Ingo Molnar <mingo@redhat.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Boqun Feng <boqun.feng@gmail.com>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
        Helge Deller <deller@gmx.de>,
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
In-Reply-To: <YXbAPIm47WwpYYup@hirez.programming.kicks-ass.net>
References: <20211022120058.1031690-1-arnd@kernel.org>
 <cc8e3c58-457d-fdf3-6a62-98bde0cefdea@redhat.com>
 <CAK8P3a0YjaRS+aUCOKGjsfkR3TM49PrG6U4ftG_Fz+OFuyCb0w@mail.gmail.com>
 <YXZ/iLB7BvZtzDMp@hirez.programming.kicks-ass.net>
 <CAK8P3a2Luz7sd5cM1OdZhYCs_UPzo+2qVQYSZPfR2QN+0DkyRg@mail.gmail.com>
 <YXbAPIm47WwpYYup@hirez.programming.kicks-ass.net>
Date:   Wed, 27 Oct 2021 23:01:41 +1100
Message-ID: <87r1c6ad7e.fsf@mpe.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:
> On Mon, Oct 25, 2021 at 03:06:24PM +0200, Arnd Bergmann wrote:
>> On Mon, Oct 25, 2021 at 11:57 AM Peter Zijlstra <peterz@infradead.org> wrote:
>> > On Sat, Oct 23, 2021 at 06:04:57PM +0200, Arnd Bergmann wrote:
>> > > On Sat, Oct 23, 2021 at 3:37 AM Waiman Long <longman@redhat.com> wrote:
>> > > >> On 10/22/21 7:59 AM, Arnd Bergmann wrote:
>> > > > > From: Arnd Bergmann <arnd@arndb.de>
>> > > > >
>> > > > > As this is all dead code, just remove it and the helper functions built
>> > > > > around it. For arch/ia64, the inline asm could be cleaned up, but
>> > > > > it seems safer to leave it untouched.
>> > > > >
>> > > > > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> > > >
>> > > > Does that mean we can also remove the GENERIC_LOCKBREAK config option
>> > > > from the Kconfig files as well?
>> > >
>> > >  I couldn't figure this out.
>> > >
>> > > What I see is that the only architectures setting GENERIC_LOCKBREAK are
>> > > nds32, parisc, powerpc, s390, sh and sparc64, while the only architectures
>> > > implementing arch_spin_is_contended() are arm32, csky and ia64.
>> > >
>> > > The part I don't understand is whether the option actually does anything
>> > > useful any more after commit d89c70356acf ("locking/core: Remove break_lock
>> > > field when CONFIG_GENERIC_LOCKBREAK=y").
>> >
>> > Urgh, what a mess.. AFAICT there's still code in
>> > kernel/locking/spinlock.c that relies on it. Specifically when
>> > GENERIC_LOCKBREAK=y we seem to create _lock*() variants that are
>> > basically TaS locks which drop preempt/irq disable while spinning.
>> >
>> > Anybody having this on and not having native TaS locks is in for a rude
>> > surprise I suppose... sparc64 being the obvious candidate there :/
>> 
>> Is this a problem on s390 and powerpc, those two being the ones
>> that matter in practice?
>> 
>> On s390, we pick between the cmpxchg() based directed-yield when
>> running on virtualized CPUs, and a normal qspinlock when running on a
>> dedicated CPU.
>> 
>> On PowerPC, we pick at compile-time between either the qspinlock
>> (default-enabled on Book3S-64, i.e. all server chips) or a ll/sc based
>> spinlock plus vm_yield() (default on embedded and 32-bit mac).
>
> Urgh, yeah, so this crud undermines the whole point of having a fair
> lock. I'm thinking s390 and Power want to have this fixed.

Our Kconfig has:

  config GENERIC_LOCKBREAK
  	bool
  	default y
  	depends on SMP && PREEMPTION

And we have exactly one defconfig that enables both SMP and PREEMPT,
arch/powerpc/configs/85xx/ge_imp3a_defconfig, which is some ~10 year old
PCI card embedded thing I've never heard of. High chance anyone who has
those is not running upstream kernels on them.

So I think we'd be happy for you rip GENERIC_LOCKBREAK out, it's almost
entirely unused on powerpc anyway.

cheers
