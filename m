Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:36763 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfLHO6m (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sun, 8 Dec 2019 09:58:42 -0500
Date: Sun, 08 Dec 2019 14:58:32 -0000
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
Subject: [tip: sched/urgent] sched/rt, s390: Use CONFIG_PREEMPTION
In-Reply-To: <20191015191821.11479-18-bigeasy@linutronix.de>
References: <20191015191821.11479-18-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <157581711219.21853.18122159496311508925.tip-bot2@tip-bot2>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-tip-commits@vger.kernel.org
Cc: Thomas Gleixner <tglx@linutronix.de>, Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     fa686453053b70a8a01b7517df8cfc5872f63196
Gitweb:        https://git.kernel.org/tip/fa686453053b70a8a01b7517df8cfc5872f63196
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 15 Oct 2019 21:18:04 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 08 Dec 2019 14:37:35 +01:00

sched/rt, s390: Use CONFIG_PREEMPTION

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the preemption and entry code over to use CONFIG_PREEMPTION. Add
PREEMPT_RT output to die().

[bigeasy: +Kconfig, dumpstack.c]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Link: https://lore.kernel.org/r/20191015191821.11479-18-bigeasy@linutronix.de
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 arch/s390/Kconfig               | 2 +-
 arch/s390/include/asm/preempt.h | 4 ++--
 arch/s390/kernel/dumpstack.c    | 2 ++
 arch/s390/kernel/entry.S        | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index d4051e8..62b10a3 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,7 +30,7 @@ config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
 
 config GENERIC_LOCKBREAK
-	def_bool y if PREEMPT
+	def_bool y if PREEMPTTION
 
 config PGSTE
 	def_bool y if KVM
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preempt.h
index b5ea9e1..6ede299 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -130,11 +130,11 @@ static inline bool should_resched(int preempt_offset)
 
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
 
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index d306fe0..2c122d8 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -195,6 +195,8 @@ void die(struct pt_regs *regs, const char *str)
 	       regs->int_code >> 17, ++die_counter);
 #ifdef CONFIG_PREEMPT
 	pr_cont("PREEMPT ");
+#elif defined(CONFIG_PREEMPT_RT)
+	pr_cont("PREEMPT_RT ");
 #endif
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 270d1d1..9205add 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -790,7 +790,7 @@ ENTRY(io_int_handler)
 .Lio_work:
 	tm	__PT_PSW+1(%r11),0x01	# returning to user ?
 	jo	.Lio_work_user		# yes -> do resched & signal
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 	# check for preemptive scheduling
 	icm	%r0,15,__LC_PREEMPT_COUNT
 	jnz	.Lio_restore		# preemption is disabled
