Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63488C48BE8
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:51:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 476EB613BC
	for <linux-s390@archiver.kernel.org>; Wed,  9 Jun 2021 14:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbhFIOw4 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 9 Jun 2021 10:52:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:59320 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238257AbhFIOw4 (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Wed, 9 Jun 2021 10:52:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2163C6128A;
        Wed,  9 Jun 2021 14:50:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623250261;
        bh=svcXYr1x4uog0gl91R41ozY2Q0KNDzZmG4YRGTMMy2A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YkHX/JVfHqUvpWvWXkgg3rdrkk7agHtEIKqaX0vfSpX504lTGaDjO7Qz7iARqzkGp
         DWsHVY+tAbRsBUSVBkbhVjgZvGY6y/wRIXGMo+CgzooB/zqPomfgnsHX9y3mgTbMXc
         xGiW+RangNEk+pKIT8UX8w6paGaFQZLDQ+McKqTpjqFKueMHIVGMXJpalfW0Fph76r
         Lcm2WPwzewVnde/Vu5ujWTdQssxwNbFghUliAxp8Ku3YbSQHaHnLbkGz+awfGrnWGJ
         yu4qANQoP9p9s4/vzkSPeJiYpDnHVlRdjW4xbBVW2tivL4go8M8laNS3QaNsdGKKc0
         R1JEjjJpSG45g==
Date:   Wed, 9 Jun 2021 17:50:50 +0300
From:   Mike Rapoport <rppt@kernel.org>
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Jonathan Corbet <corbet@lwn.net>,
        Matt Turner <mattst88@gmail.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Richard Henderson <rth@twiddle.net>,
        Vineet Gupta <vgupta@synopsys.com>, kexec@lists.infradead.org,
        alpha <linux-alpha@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-ia64@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-m68k <linux-m68k@lists.linux-m68k.org>,
        "open list:BROADCOM NVRAM DRIVER" <linux-mips@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Linux-sh list <linux-sh@vger.kernel.org>,
        "open list:SYNOPSYS ARC ARCHITECTURE" 
        <linux-snps-arc@lists.infradead.org>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>
Subject: Re: [PATCH v2 0/9] Remove DISCINTIGMEM memory model
Message-ID: <YMDVSu00xXGmdCtC@kernel.org>
References: <20210604064916.26580-1-rppt@kernel.org>
 <CAK8P3a2tZDJDqgr9-1vJrnbDhd_36eKq8LMEznDkU7rvuAnAag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAK8P3a2tZDJDqgr9-1vJrnbDhd_36eKq8LMEznDkU7rvuAnAag@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Hi Arnd,

On Wed, Jun 09, 2021 at 01:30:39PM +0200, Arnd Bergmann wrote:
> On Fri, Jun 4, 2021 at 8:49 AM Mike Rapoport <rppt@kernel.org> wrote:
> >
> > From: Mike Rapoport <rppt@linux.ibm.com>
> >
> > Hi,
> >
> > SPARSEMEM memory model was supposed to entirely replace DISCONTIGMEM a
> > (long) while ago. The last architectures that used DISCONTIGMEM were
> > updated to use other memory models in v5.11 and it is about the time to
> > entirely remove DISCONTIGMEM from the kernel.
> >
> > This set removes DISCONTIGMEM from alpha, arc and m68k, simplifies memory
> > model selection in mm/Kconfig and replaces usage of redundant
> > CONFIG_NEED_MULTIPLE_NODES and CONFIG_FLAT_NODE_MEM_MAP with CONFIG_NUMA
> > and CONFIG_FLATMEM respectively.
> >
> > I've also removed NUMA support on alpha that was BROKEN for more than 15
> > years.
> >
> > There were also minor updates all over arch/ to remove mentions of
> > DISCONTIGMEM in comments and #ifdefs.
> 
> Hi Mike and Andrew,
> 
> It looks like everyone is happy with this version so far. How should we merge it
> for linux-next? I'm happy to take it through the asm-generic tree, but linux-mm
> would fit at least as well. In case we go for linux-mm, feel free to add

Andrew already took to mmotm.
 
> Acked-by: Arnd Bergmann <arnd@arndb.de>

Thanks!

> for the whole series.

-- 
Sincerely yours,
Mike.
