Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726257AbgLCRLt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 3 Dec 2020 12:11:49 -0500
Date: Thu, 3 Dec 2020 18:10:15 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH AUTOSEL 5.9 27/39] sched/idle: Fix arch_cpu_idle() vs
 tracing
Message-ID: <20201203171015.GN2414@hirez.programming.kicks-ass.net>
References: <20201203132834.930999-1-sashal@kernel.org>
 <20201203132834.930999-27-sashal@kernel.org>
 <20201203145442.GC9994@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201203145442.GC9994@osiris>
List-ID: <linux-s390.vger.kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org, stable@vger.kernel.org, Sven Schnelle <svens@linux.ibm.com>, Mark Rutland <mark.rutland@arm.com>, linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, uclinux-h8-devel@lists.sourceforge.jp, linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org, linux-mips@vger.kernel.org, openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, linux-um@lists.infradead.org

On Thu, Dec 03, 2020 at 03:54:42PM +0100, Heiko Carstens wrote:
> On Thu, Dec 03, 2020 at 08:28:21AM -0500, Sasha Levin wrote:
> > From: Peter Zijlstra <peterz@infradead.org>
> > 
> > [ Upstream commit 58c644ba512cfbc2e39b758dd979edd1d6d00e27 ]
> > 
> > We call arch_cpu_idle() with RCU disabled, but then use
> > local_irq_{en,dis}able(), which invokes tracing, which relies on RCU.
> > 
> > Switch all arch_cpu_idle() implementations to use
> > raw_local_irq_{en,dis}able() and carefully manage the
> > lockdep,rcu,tracing state like we do in entry.
> > 
> > (XXX: we really should change arch_cpu_idle() to not return with
> > interrupts enabled)
> > 
> > Reported-by: Sven Schnelle <svens@linux.ibm.com>
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > Reviewed-by: Mark Rutland <mark.rutland@arm.com>
> > Tested-by: Mark Rutland <mark.rutland@arm.com>
> > Link: https://lkml.kernel.org/r/20201120114925.594122626@infradead.org
> > Signed-off-by: Sasha Levin <sashal@kernel.org>
> 
> This patch broke s390 irq state tracing. A patch to fix this is
> scheduled to be merged upstream today (hopefully).
> Therefore I think this patch should not yet go into 5.9 stable.

Agreed.
