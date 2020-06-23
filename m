Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731899AbgFWIju (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 23 Jun 2020 04:39:50 -0400
Message-ID: <20200623083721.396143816@infradead.org>
Date: Tue, 23 Jun 2020 10:36:50 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v4 5/8] s390: Break cyclic percpu include
References: <20200623083645.277342609@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux@armlinux.org.uk

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/s390/include/asm/smp.h         |    1 +
 arch/s390/include/asm/thread_info.h |    1 -
 2 files changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/smp.h
+++ b/arch/s390/include/asm/smp.h
@@ -10,6 +10,7 @@
 
 #include <asm/sigp.h>
 #include <asm/lowcore.h>
+#include <asm/processor.h>
 
 #define raw_smp_processor_id()	(S390_lowcore.cpu_nr)
 
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -24,7 +24,6 @@
 #ifndef __ASSEMBLY__
 #include <asm/lowcore.h>
 #include <asm/page.h>
-#include <asm/processor.h>
 
 #define STACK_INIT_OFFSET \
 	(THREAD_SIZE - STACK_FRAME_OVERHEAD - sizeof(struct pt_regs))
