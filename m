Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <20200529214203.673108357@infradead.org>
Date: Fri, 29 May 2020 23:35:51 +0200
From: Peter Zijlstra <peterz@infradead.org>
Subject: [RFC][PATCH v3 1/5] sparc64: Fix asm/percpu.h build error
References: <20200529213550.683440625@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: mingo@kernel.org, will@kernel.org, tglx@linutronix.de
Cc: x86@kernel.org, linux-kernel@vger.kernel.org, a.darwish@linutronix.de, rostedt@goodmis.org, bigeasy@linutronix.de, peterz@infradead.org, davem@davemloft.net, sparclinux@vger.kernel.org, mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org

In order to break a header dependency between lockdep and task_struct,
I need per-cpu stuff from lockdep.

Including <asm/percpu.h> from lockdep.h gives a build error, this
patch cures that, but results in the following warning:

../arch/sparc/include/asm/percpu_64.h:7:24: warning: call-clobbered register used for global register variable
register unsigned long __local_per_cpu_offset asm("g5");

But i've no idea how to fix that :/ but it does build.

Not-Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/sparc/include/asm/trap_block.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H
 
+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>
 
