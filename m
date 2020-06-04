Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729115AbgFDQ5S (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 12:57:18 -0400
Date: Thu, 4 Jun 2020 18:57:03 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
Message-ID: <20200604165703.GG3976@hirez.programming.kicks-ass.net>
References: <20200529213550.683440625@infradead.org>
 <20200529214203.673108357@infradead.org>
 <20200529.162917.1970892823680223252.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200529.162917.1970892823680223252.davem@davemloft.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org

On Fri, May 29, 2020 at 04:29:17PM -0700, David Miller wrote:
> From: Peter Zijlstra <peterz@infradead.org>
> Date: Fri, 29 May 2020 23:35:51 +0200
> 
> > ../arch/sparc/include/asm/percpu_64.h:7:24: warning: call-clobbered register used for global register variable
> > register unsigned long __local_per_cpu_offset asm("g5");
> 
> The "-ffixed-g5" option on the command line tells gcc that we are
> using 'g5' as a fixed register, so some part of your build isn't using
> the:
> 
> KBUILD_CFLAGS += -ffixed-g4 -ffixed-g5 -fcall-used-g7 -Wno-sign-compare
> 
> from arch/sparc/Makefile for some reason.

Thanks, that was the clue I needed.

I think I see, what happens is that these headers end up in the VDSO
build, and that doesn't have these CFLAGS, because userspace.

Let me see what to do about that.
