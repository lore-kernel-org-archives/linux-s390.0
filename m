Return-Path: <linux-kernel-owner+w=401wt.eu-S932957AbYCEL5z@vger.kernel.org>
Message-Id: <20080305115713.374958723@de.ibm.com>
References: <20080305115432.691030908@de.ibm.com>
Date: Wed, 05 Mar 2008 12:54:34 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/10] idle: Fix machine check handling in idle loop.
Content-Disposition: inline; filename=002-idle-mcck.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

If a machine check handling is pending when the idle loop is entered
default_idle will be left with timer ticks and virtual timer disabled.
Fix this by "calling" the idle_chain. Also a BUG_ON(!in_interrupt) in
start_hz_timer must be removed since the function now gets called from
non interrupt context as well.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/process.c |    4 ++++
 arch/s390/kernel/time.c    |    2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

Index: quilt-2.6/arch/s390/kernel/process.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/process.c
+++ quilt-2.6/arch/s390/kernel/process.c
@@ -152,6 +152,10 @@ static void default_idle(void)
 	local_mcck_disable();
 	if (test_thread_flag(TIF_MCCK_PENDING)) {
 		local_mcck_enable();
+		/* disable monitor call class 0 */
+		__ctl_clear_bit(8, 15);
+		atomic_notifier_call_chain(&idle_chain, S390_CPU_NOT_IDLE,
+					   hcpu);
 		local_irq_enable();
 		s390_handle_mcck();
 		return;
Index: quilt-2.6/arch/s390/kernel/time.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/time.c
+++ quilt-2.6/arch/s390/kernel/time.c
@@ -209,8 +209,6 @@ static void stop_hz_timer(void)
  */
 static void start_hz_timer(void)
 {
-	BUG_ON(!in_interrupt());
-
 	if (!cpu_isset(smp_processor_id(), nohz_cpu_mask))
 		return;
 	account_ticks(get_clock());

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
