Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729073AbgFDUmA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Jun 2020 16:42:00 -0400
Date: Thu, 4 Jun 2020 22:41:16 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
Message-ID: <20200604204116.GD4496@worktop.programming.kicks-ass.net>
References: <20200529213550.683440625@infradead.org>
 <20200529214203.673108357@infradead.org>
 <20200529.162917.1970892823680223252.davem@davemloft.net>
 <20200604165703.GG3976@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200604165703.GG3976@hirez.programming.kicks-ass.net>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: mingo@kernel.org, will@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org

On Thu, Jun 04, 2020 at 06:57:03PM +0200, Peter Zijlstra wrote:

> I think I see, what happens is that these headers end up in the VDSO
> build, and that doesn't have these CFLAGS, because userspace.
> 
> Let me see what to do about that.

I feel like the below is cheating, but it's the best I could find :/
VDSO including kernel headers and the utter maze that our kernel headers
are makes it really hard to untangle :/

This builds sparc64-defconfig and sparc64-all{no,mod}config.

Dave, does this work for you, or should I try hardder?

---
 arch/sparc/include/asm/percpu_64.h  | 2 ++
 arch/sparc/include/asm/trap_block.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/percpu_64.h b/arch/sparc/include/asm/percpu_64.h
index 32ef6f05cc565..a8786a4b90b6b 100644
--- a/arch/sparc/include/asm/percpu_64.h
+++ b/arch/sparc/include/asm/percpu_64.h
@@ -4,7 +4,9 @@

 #include <linux/compiler.h>

+#ifndef BUILD_VDSO
 register unsigned long __local_per_cpu_offset asm("g5");
+#endif

 #ifdef CONFIG_SMP

diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 0f6d0c4f66838..ace0d48e837e5 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H

+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>
