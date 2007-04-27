Return-Path: <linux-kernel-owner+w=401wt.eu-S1755934AbXD0OKQ@vger.kernel.org>
Message-Id: <20070427140519.417985695@de.ibm.com>
References: <20070427140503.087958775@de.ibm.com>
Date: Fri, 27 Apr 2007 16:05:35 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/38] vtime: cleanup per_cpu usage.
Content-Disposition: inline; filename=135-vtime-percpu.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Jan Glauber <jan.glauber@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jan.glauber@de.ibm.com>

Replace per_cpu(... , smp_processor_id()) with __get_cpu_var()

Signed-off-by: Jan Glauber <jan.glauber@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/vtime.c |   16 +++++++---------
 1 files changed, 7 insertions(+), 9 deletions(-)

Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c	2007-04-27 16:01:49.000000000 +0200
+++ quilt-2.6/arch/s390/kernel/vtime.c	2007-04-27 16:05:00.000000000 +0200
@@ -128,7 +128,7 @@
 	S390_lowcore.last_update_timer = expires;
 
 	/* store expire time for this CPU timer */
-	per_cpu(virt_cpu_timer, smp_processor_id()).to_expire = expires;
+	__get_cpu_var(virt_cpu_timer).to_expire = expires;
 }
 #else
 static inline void set_vtimer(__u64 expires)
@@ -137,7 +137,7 @@
 	asm volatile ("SPT %0" : : "m" (S390_lowcore.last_update_timer));
 
 	/* store expire time for this CPU timer */
-	per_cpu(virt_cpu_timer, smp_processor_id()).to_expire = expires;
+	__get_cpu_var(virt_cpu_timer).to_expire = expires;
 }
 #endif
 
@@ -145,7 +145,7 @@
 {
 	struct vtimer_queue *vt_list;
 
-	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
+	vt_list = &__get_cpu_var(virt_cpu_timer);
 
 	/* CPU timer interrupt is pending, don't reprogramm it */
 	if (vt_list->idle & 1LL<<63)
@@ -159,7 +159,7 @@
 {
 	struct vtimer_queue *vt_list;
 
-	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
+	vt_list = &__get_cpu_var(virt_cpu_timer);
 
 	/* nothing to do */
 	if (list_empty(&vt_list->list)) {
@@ -219,7 +219,7 @@
 	if (list_empty(cb_list))
 		return;
 
-	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
+	vt_list = &__get_cpu_var(virt_cpu_timer);
 
 	list_for_each_entry_safe(event, tmp, cb_list, entry) {
 		fn = event->function;
@@ -244,7 +244,6 @@
  */
 static void do_cpu_timer_interrupt(__u16 error_code)
 {
-	int cpu;
 	__u64 next, delta;
 	struct vtimer_queue *vt_list;
 	struct vtimer_list *event, *tmp;
@@ -253,8 +252,7 @@
 	struct list_head cb_list;
 
 	INIT_LIST_HEAD(&cb_list);
-	cpu = smp_processor_id();
-	vt_list = &per_cpu(virt_cpu_timer, cpu);
+	vt_list = &__get_cpu_var(virt_cpu_timer);
 
 	/* walk timer list, fire all expired events */
 	spin_lock(&vt_list->lock);
@@ -534,7 +532,7 @@
 	/* enable cpu timer interrupts */
 	__ctl_set_bit(0,10);
 
-	vt_list = &per_cpu(virt_cpu_timer, smp_processor_id());
+	vt_list = &__get_cpu_var(virt_cpu_timer);
 	INIT_LIST_HEAD(&vt_list->list);
 	spin_lock_init(&vt_list->lock);
 	vt_list->to_expire = 0;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
