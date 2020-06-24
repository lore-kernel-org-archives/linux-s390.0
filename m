Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2405677AbgFXRzE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 24 Jun 2020 13:55:04 -0400
Date: Wed, 24 Jun 2020 19:53:20 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH v4 6/8] arm: Break cyclic percpu include
Message-ID: <20200624175320.GN4781@hirez.programming.kicks-ass.net>
References: <20200623083645.277342609@infradead.org>
 <20200623083721.454517573@infradead.org>
 <20200623090257.GA3743@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200623090257.GA3743@willie-the-truck>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Will Deacon <will@kernel.org>
Cc: mingo@kernel.org, tglx@linutronix.de, x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

On Tue, Jun 23, 2020 at 10:02:57AM +0100, Will Deacon wrote:
> On Tue, Jun 23, 2020 at 10:36:51AM +0200, Peter Zijlstra wrote:
> > In order to use <asm/percpu.h> in irqflags.h, we need to make sure
> > asm/percpu.h does not itself depend on irqflags.h.
> > 
> > Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> > ---
> >  arch/arm/include/asm/percpu.h |    2 ++
> >  1 file changed, 2 insertions(+)
> > 
> > --- a/arch/arm/include/asm/percpu.h
> > +++ b/arch/arm/include/asm/percpu.h
> > @@ -10,6 +10,8 @@
> >   * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
> >   */
> >  #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
> > +register unsigned long current_stack_pointer asm ("sp");
> 
> If you define this unconditionally, then we can probably get rid of the
> copy in asm/thread_info.h, rather than duplicate the same #define.

The below delta seems to build arm-allnoconfig, arm-defconfig and
arm-allmodconfig.

Although please don't ask me how asm/thread_info.h includes asm/percpu.h

Does that work for you?

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index e86e47486b6b1..e2fcb3cfd3de5 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,13 +5,13 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+register unsigned long current_stack_pointer asm ("sp");
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
  */
 #if defined(CONFIG_SMP) && !defined(CONFIG_CPU_V6)
-register unsigned long current_stack_pointer asm ("sp");
-
 static inline void set_my_cpu_offset(unsigned long off)
 {
 	/* Set TPIDRPRW */
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 3609a6980c342..536b6b979f634 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -75,11 +75,6 @@ struct thread_info {
 	.addr_limit	= KERNEL_DS,					\
 }
 
-/*
- * how to get the current stack pointer in C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
 /*
  * how to get the thread information struct from C
  */
