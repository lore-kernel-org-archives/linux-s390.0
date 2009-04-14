Return-Path: <linux-kernel-owner+w=401wt.eu-S1756536AbZDNNzA@vger.kernel.org>
Message-Id: <20090414135347.536476032@de.ibm.com>
References: <20090414135327.576111185@de.ibm.com>
Date: Tue, 14 Apr 2009 15:53:32 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 05/14] extend virtual timer interface by mod_virt_timer_periodic
Content-Disposition: inline; filename=005-mod-vtimer.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Jan Glauber <jang@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

In case mod_virt_timer is used to add a non pending timer the timer
is always added as a one-shot timer. If mod_virt_timer is used for
periodic timers they may therfore be degraded to one-shot timers.

Add mod_virt_timer_periodic to the interface to allow safe re-programming
of the interval value.

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/include/asm/timer.h |    1 
 arch/s390/kernel/vtime.c      |   57 ++++++++++++++++++++++++------------------
 2 files changed, 34 insertions(+), 24 deletions(-)

Index: quilt-2.6/arch/s390/include/asm/timer.h
===================================================================
--- quilt-2.6.orig/arch/s390/include/asm/timer.h
+++ quilt-2.6/arch/s390/include/asm/timer.h
@@ -41,6 +41,7 @@ extern void init_virt_timer(struct vtime
 extern void add_virt_timer(void *new);
 extern void add_virt_timer_periodic(void *new);
 extern int mod_virt_timer(struct vtimer_list *timer, __u64 expires);
+extern int mod_virt_timer_periodic(struct vtimer_list *timer, __u64 expires);
 extern int del_virt_timer(struct vtimer_list *timer);
 
 extern void init_cpu_vtimer(void);
Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -425,17 +425,7 @@ void add_virt_timer_periodic(void *new)
 }
 EXPORT_SYMBOL(add_virt_timer_periodic);
 
-/*
- * If we change a pending timer the function must be called on the CPU
- * where the timer is running on, e.g. by smp_call_function_single()
- *
- * The original mod_timer adds the timer if it is not pending. For
- * compatibility we do the same. The timer will be added on the current
- * CPU as a oneshot timer.
- *
- * returns whether it has modified a pending timer (1) or not (0)
- */
-int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
+int __mod_vtimer(struct vtimer_list *timer, __u64 expires, int periodic)
 {
 	struct vtimer_queue *vq;
 	unsigned long flags;
@@ -444,39 +434,35 @@ int mod_virt_timer(struct vtimer_list *t
 	BUG_ON(!timer->function);
 	BUG_ON(!expires || expires > VTIMER_MAX_SLICE);
 
-	/*
-	 * This is a common optimization triggered by the
-	 * networking code - if the timer is re-modified
-	 * to be the same thing then just return:
-	 */
 	if (timer->expires == expires && vtimer_pending(timer))
 		return 1;
 
 	cpu = get_cpu();
 	vq = &per_cpu(virt_cpu_timer, cpu);
 
-	/* check if we run on the right CPU */
-	BUG_ON(timer->cpu != cpu);
-
 	/* disable interrupts before test if timer is pending */
 	spin_lock_irqsave(&vq->lock, flags);
 
 	/* if timer isn't pending add it on the current CPU */
 	if (!vtimer_pending(timer)) {
 		spin_unlock_irqrestore(&vq->lock, flags);
-		/* we do not activate an interval timer with mod_virt_timer */
-		timer->interval = 0;
+
+		if (periodic)
+			timer->interval = expires;
+		else
+			timer->interval = 0;
 		timer->expires = expires;
 		timer->cpu = cpu;
 		internal_add_vtimer(timer);
 		return 0;
 	}
 
+	/* check if we run on the right CPU */
+	BUG_ON(timer->cpu != cpu);
+
 	list_del_init(&timer->entry);
 	timer->expires = expires;
-
-	/* also change the interval if we have an interval timer */
-	if (timer->interval)
+	if (periodic)
 		timer->interval = expires;
 
 	/* the timer can't expire anymore so we can release the lock */
@@ -484,9 +470,32 @@ int mod_virt_timer(struct vtimer_list *t
 	internal_add_vtimer(timer);
 	return 1;
 }
+
+/*
+ * If we change a pending timer the function must be called on the CPU
+ * where the timer is running on.
+ *
+ * returns whether it has modified a pending timer (1) or not (0)
+ */
+int mod_virt_timer(struct vtimer_list *timer, __u64 expires)
+{
+	return __mod_vtimer(timer, expires, 0);
+}
 EXPORT_SYMBOL(mod_virt_timer);
 
 /*
+ * If we change a pending timer the function must be called on the CPU
+ * where the timer is running on.
+ *
+ * returns whether it has modified a pending timer (1) or not (0)
+ */
+int mod_virt_timer_periodic(struct vtimer_list *timer, __u64 expires)
+{
+	return __mod_vtimer(timer, expires, 1);
+}
+EXPORT_SYMBOL(mod_virt_timer_periodic);
+
+/*
  * delete a virtual timer
  *
  * returns whether the deleted timer was pending (1) or not (0)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
