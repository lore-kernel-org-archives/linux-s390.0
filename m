Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Sat, 11 Jul 2020 10:09:54 -0000
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: locking/core] arm: Break cyclic percpu include
In-Reply-To: <20200623083721.454517573@infradead.org>
References: <20200623083721.454517573@infradead.org>
MIME-Version: 1.0
Message-ID: <159446219427.4006.4005355405552922553.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Will Deacon <will@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     a6342915881a687b07847b7c57628de07a256525
Gitweb:        https://git.kernel.org/tip/a6342915881a687b07847b7c57628de07a256525
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 17:21:58 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 10 Jul 2020 12:00:02 +02:00

arm: Break cyclic percpu include

In order to use <asm/percpu.h> in irqflags.h, we need to make sure
asm/percpu.h does not itself depend on irqflags.h.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/r/20200623083721.454517573@infradead.org
---
 arch/arm/include/asm/percpu.h      | 2 ++
 arch/arm/include/asm/thread_info.h | 5 -----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/arch/arm/include/asm/percpu.h b/arch/arm/include/asm/percpu.h
index f44f448..e2fcb3c 100644
--- a/arch/arm/include/asm/percpu.h
+++ b/arch/arm/include/asm/percpu.h
@@ -5,6 +5,8 @@
 #ifndef _ASM_ARM_PERCPU_H_
 #define _ASM_ARM_PERCPU_H_
 
+register unsigned long current_stack_pointer asm ("sp");
+
 /*
  * Same as asm-generic/percpu.h, except that we store the per cpu offset
  * in the TPIDRPRW. TPIDRPRW only exists on V6K and V7
diff --git a/arch/arm/include/asm/thread_info.h b/arch/arm/include/asm/thread_info.h
index 3609a69..536b6b9 100644
--- a/arch/arm/include/asm/thread_info.h
+++ b/arch/arm/include/asm/thread_info.h
@@ -76,11 +76,6 @@ struct thread_info {
 }
 
 /*
- * how to get the current stack pointer in C
- */
-register unsigned long current_stack_pointer asm ("sp");
-
-/*
  * how to get the thread information struct from C
  */
 static inline struct thread_info *current_thread_info(void) __attribute_const__;
