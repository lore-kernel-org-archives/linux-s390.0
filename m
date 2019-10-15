Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from Galois.linutronix.de ([193.142.43.55]:45649 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389376AbfJOTSl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 15 Oct 2019 15:18:41 -0400
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH 17/34] s390: Use CONFIG_PREEMPTION
Date: Tue, 15 Oct 2019 21:18:04 +0200
Message-Id: <20191015191821.11479-18-bigeasy@linutronix.de>
In-Reply-To: <20191015191821.11479-1-bigeasy@linutronix.de>
References: <20191015191821.11479-1-bigeasy@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: tglx@linutronix.de, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-s390@vger.kernel.org, Sebastian Andrzej Siewior <bigeasy@linutronix.de>

From: Thomas Gleixner <tglx@linutronix.de>

CONFIG_PREEMPTION is selected by CONFIG_PREEMPT and by CONFIG_PREEMPT_RT.
Both PREEMPT and PREEMPT_RT require the same functionality which today
depends on CONFIG_PREEMPT.

Switch the preemption and entry code over to use CONFIG_PREEMPTION. Add
PREEMPT_RT output to die().

Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[bigeasy: +Kconfig, dumpstack.c]
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
 arch/s390/Kconfig               | 2 +-
 arch/s390/include/asm/preempt.h | 4 ++--
 arch/s390/kernel/dumpstack.c    | 2 ++
 arch/s390/kernel/entry.S        | 2 +-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 43a81d0ad5074..33d968175038e 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -30,7 +30,7 @@ config GENERIC_BUG_RELATIVE_POINTERS
 	def_bool y
=20
 config GENERIC_LOCKBREAK
-	def_bool y if PREEMPT
+	def_bool y if PREEMPTTION
=20
 config PGSTE
 	def_bool y if KVM
diff --git a/arch/s390/include/asm/preempt.h b/arch/s390/include/asm/preemp=
t.h
index b5ea9e14c017a..6ede29907fbf7 100644
--- a/arch/s390/include/asm/preempt.h
+++ b/arch/s390/include/asm/preempt.h
@@ -130,11 +130,11 @@ static inline bool should_resched(int preempt_offset)
=20
 #endif /* CONFIG_HAVE_MARCH_Z196_FEATURES */
=20
-#ifdef CONFIG_PREEMPT
+#ifdef CONFIG_PREEMPTION
 extern asmlinkage void preempt_schedule(void);
 #define __preempt_schedule() preempt_schedule()
 extern asmlinkage void preempt_schedule_notrace(void);
 #define __preempt_schedule_notrace() preempt_schedule_notrace()
-#endif /* CONFIG_PREEMPT */
+#endif /* CONFIG_PREEMPTION */
=20
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index 34bdc60c0b11d..8e38447be4653 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -194,6 +194,8 @@ void die(struct pt_regs *regs, const char *str)
 	       regs->int_code >> 17, ++die_counter);
 #ifdef CONFIG_PREEMPT
 	pr_cont("PREEMPT ");
+#elif defined(CONFIG_PREEMPT_RT)
+	pr_cont("PREEMPT_RT ");
 #endif
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 270d1d145761b..9205add8481d5 100644
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
--=20
2.23.0
