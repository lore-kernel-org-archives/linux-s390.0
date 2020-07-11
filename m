Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2020 10:09:56 -0000
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/core] sparc64: Fix asm/percpu.h build error
In-Reply-To: <20200623083721.277992771@infradead.org>
References: <20200623083721.277992771@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219606.4006.16923768828083285770.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, "David S. Miller" <davem@davemloft.net>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     48017e5481ce85ba52c4cff082cad5f021c4b413
Gitweb:        https://git.kernel.org/tip/48017e5481ce85ba52c4cff082cad5f021c4b413
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 29 May 2020 22:40:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:01 +02:00

sparc64: Fix asm/percpu.h build error

In order to break a header dependency between lockdep and task_struct,
I need per-cpu stuff from lockdep.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: David S. Miller <davem@davemloft.net>
Link: https://lkml.kernel.org/r/20200623083721.277992771@infradead.org
---
 arch/sparc/include/asm/percpu_64.h  | 2 ++
 arch/sparc/include/asm/trap_block.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/arch/sparc/include/asm/percpu_64.h b/arch/sparc/include/asm/percpu_64.h
index 32ef6f0..a8786a4 100644
--- a/arch/sparc/include/asm/percpu_64.h
+++ b/arch/sparc/include/asm/percpu_64.h
@@ -4,7 +4,9 @@
 
 #include <linux/compiler.h>
 
+#ifndef BUILD_VDSO
 register unsigned long __local_per_cpu_offset asm("g5");
+#endif
 
 #ifdef CONFIG_SMP
 
diff --git a/arch/sparc/include/asm/trap_block.h b/arch/sparc/include/asm/trap_block.h
index 0f6d0c4..ace0d48 100644
--- a/arch/sparc/include/asm/trap_block.h
+++ b/arch/sparc/include/asm/trap_block.h
@@ -2,6 +2,8 @@
 #ifndef _SPARC_TRAP_BLOCK_H
 #define _SPARC_TRAP_BLOCK_H
 
+#include <linux/threads.h>
+
 #include <asm/hypervisor.h>
 #include <asm/asi.h>
 
