Return-Path: <linux-kernel-owner+w=401wt.eu-S1764851AbXGJJdY@vger.kernel.org>
Message-Id: <20070710093123.675746249@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:50 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 15/16] s390: rename CPU_IDLE to S390_CPU_IDLE
Content-Disposition: inline; filename=015-cpu-idle.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, Ingo Molnar <mingo@elte.hu>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

sched-cfs-v2.6.22-git-v18.patch introduces CPU_IDLE in sched.h.
This conflict with the already existing define in
include/asm-s390/processor.h
Just rename the s390 defines, since they will go away as soon as
we support CONFIG_NO_HZ instead of our own CONFIG_NO_IDLE_HZ.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c   |    6 +++---
 arch/s390/kernel/time.c      |    4 ++--
 arch/s390/kernel/vtime.c     |    4 ++--
 include/asm-s390/processor.h |    4 ++--
 4 files changed, 9 insertions(+), 9 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -93,8 +93,8 @@ void do_monitor_call(struct pt_regs *reg
 	/* disable monitor call class 0 */
 	__ctl_clear_bit(8, 15);
 
-	atomic_notifier_call_chain(&idle_chain, CPU_NOT_IDLE,
-			    (void *)(long) smp_processor_id());
+	atomic_notifier_call_chain(&idle_chain, S390_CPU_NOT_IDLE,
+				   (void *)(long) smp_processor_id());
 }
 
 extern void s390_handle_mcck(void);
@@ -115,7 +115,7 @@ static void default_idle(void)
 	}
 
 	rc = atomic_notifier_call_chain(&idle_chain,
-			CPU_IDLE, (void *)(long) cpu);
+					S390_CPU_IDLE, (void *)(long) cpu);
 	if (rc != NOTIFY_OK && rc != NOTIFY_DONE)
 		BUG();
 	if (rc != NOTIFY_OK) {
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -226,10 +226,10 @@ static int nohz_idle_notify(struct notif
 			    unsigned long action, void *hcpu)
 {
 	switch (action) {
-	case CPU_IDLE:
+	case S390_CPU_IDLE:
 		stop_hz_timer();
 		break;
-	case CPU_NOT_IDLE:
+	case S390_CPU_NOT_IDLE:
 		start_hz_timer();
 		break;
 	}
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -545,10 +545,10 @@ static int vtimer_idle_notify(struct not
 			      unsigned long action, void *hcpu)
 {
 	switch (action) {
-	case CPU_IDLE:
+	case S390_CPU_IDLE:
 		stop_cpu_timer();
 		break;
-	case CPU_NOT_IDLE:
+	case S390_CPU_NOT_IDLE:
 		start_cpu_timer();
 		break;
 	}
Index: quilt-2.6/include/asm-s390/processor.h
===================================================================
--- quilt-2.6.orig/include/asm-s390/processor.h
+++ quilt-2.6/include/asm-s390/processor.h
@@ -357,8 +357,8 @@ extern void (*s390_base_ext_handler_fn)(
 /*
  * CPU idle notifier chain.
  */
-#define CPU_IDLE	0
-#define CPU_NOT_IDLE	1
+#define S390_CPU_IDLE		0
+#define S390_CPU_NOT_IDLE	1
 
 struct notifier_block;
 int register_idle_notifier(struct notifier_block *nb);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
