Return-Path: <linux-kernel-owner+w=401wt.eu-S1756843AbYFYOip@vger.kernel.org>
Message-Id: <20080625143611.856207140@de.ibm.com>
References: <20080625143459.100139455@de.ibm.com>
Date: Wed, 25 Jun 2008 16:35:01 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 02/21] Cleanup vtime printk messages.
Content-Disposition: inline; filename=801-printk-vtime.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Martin Schwidefsky <schwidefsky@de.ibm.com>

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/vtime.c |   56 ++++++++++-------------------------------------
 1 file changed, 12 insertions(+), 44 deletions(-)

Index: quilt-2.6/arch/s390/kernel/vtime.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/vtime.c
+++ quilt-2.6/arch/s390/kernel/vtime.c
@@ -318,8 +318,7 @@ static void internal_add_vtimer(struct v
 	vt_list = &per_cpu(virt_cpu_timer, timer->cpu);
 	spin_lock_irqsave(&vt_list->lock, flags);
 
-	if (timer->cpu != smp_processor_id())
-		printk("internal_add_vtimer: BUG, running on wrong CPU");
+	BUG_ON(timer->cpu != smp_processor_id());
 
 	/* if list is empty we only have to set the timer */
 	if (list_empty(&vt_list->list)) {
@@ -353,25 +352,12 @@ static void internal_add_vtimer(struct v
 	put_cpu();
 }
 
-static inline int prepare_vtimer(struct vtimer_list *timer)
+static inline void prepare_vtimer(struct vtimer_list *timer)
 {
-	if (!timer->function) {
-		printk("add_virt_timer: uninitialized timer\n");
-		return -EINVAL;
-	}
-
-	if (!timer->expires || timer->expires > VTIMER_MAX_SLICE) {
-		printk("add_virt_timer: invalid timer expire value!\n");
-		return -EINVAL;
-	}
-
-	if (vtimer_pending(timer)) {
-		printk("add_virt_timer: timer pending\n");
-		return -EBUSY;
-	}
-
+	BUG_ON(!timer->function);
+	BUG_ON(!timer->expires || timer->expires > VTIMER_MAX_SLICE);
+	BUG_ON(vtimer_pending(timer));
 	timer->cpu = get_cpu();
-	return 0;
 }
 
 /*
@@ -382,10 +368,7 @@ void add_virt_timer(void *new)
 	struct vtimer_list *timer;
 
 	timer = (struct vtimer_list *)new;
-
-	if (prepare_vtimer(timer) < 0)
-		return;
-
+	prepare_vtimer(timer);
 	timer->interval = 0;
 	internal_add_vtimer(timer);
 }
@@ -399,10 +382,7 @@ void add_virt_timer_periodic(void *new)
 	struct vtimer_list *timer;
 
 	timer = (struct vtimer_list *)new;
-
-	if (prepare_vtimer(timer) < 0)
-		return;
-
+	prepare_vtimer(timer);
 	timer->interval = timer->expires;
 	internal_add_vtimer(timer);
 }
@@ -423,15 +403,8 @@ int mod_virt_timer(struct vtimer_list *t
 	unsigned long flags;
 	int cpu;
 
-	if (!timer->function) {
-		printk("mod_virt_timer: uninitialized timer\n");
-		return	-EINVAL;
-	}
-
-	if (!expires || expires > VTIMER_MAX_SLICE) {
-		printk("mod_virt_timer: invalid expire range\n");
-		return -EINVAL;
-	}
+	BUG_ON(!timer->function);
+	BUG_ON(!expires || expires > VTIMER_MAX_SLICE);
 
 	/*
 	 * This is a common optimization triggered by the
@@ -444,6 +417,9 @@ int mod_virt_timer(struct vtimer_list *t
 	cpu = get_cpu();
 	vt_list = &per_cpu(virt_cpu_timer, cpu);
 
+	/* check if we run on the right CPU */
+	BUG_ON(timer->cpu != cpu);
+
 	/* disable interrupts before test if timer is pending */
 	spin_lock_irqsave(&vt_list->lock, flags);
 
@@ -458,14 +434,6 @@ int mod_virt_timer(struct vtimer_list *t
 		return 0;
 	}
 
-	/* check if we run on the right CPU */
-	if (timer->cpu != cpu) {
-		printk("mod_virt_timer: running on wrong CPU, check your code\n");
-		spin_unlock_irqrestore(&vt_list->lock, flags);
-		put_cpu();
-		return -EINVAL;
-	}
-
 	list_del_init(&timer->entry);
 	timer->expires = expires;
 

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
