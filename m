Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 4/9] workqueue: switch to modern timers
Date: Tue, 16 May 2017 13:48:07 +0200
Message-Id: <20170516114812.10660-5-hch@lst.de>
In-Reply-To: <20170516114812.10660-1-hch@lst.de>
References: <20170516114812.10660-1-hch@lst.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/workqueue.h                                | 16 ++++++----------
 kernel/workqueue.c                                       | 14 +++++++-------
 .../rcutorture/formal/srcu-cbmc/src/workqueues.h         |  2 +-
 3 files changed, 14 insertions(+), 18 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index c102ef65cb64..59c889bf601e 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -17,7 +17,7 @@ struct workqueue_struct;
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(unsigned long __data);
+void delayed_work_timer_fn(struct timer_list *timer);
 
 /*
  * The first word is the work queue pointer and the flags rolled into
@@ -175,9 +175,8 @@ struct execute_work {
 
 #define __DELAYED_WORK_INITIALIZER(n, f, tflags) {			\
 	.work = __WORK_INITIALIZER((n).work, (f)),			\
-	.timer = __TIMER_INITIALIZER(delayed_work_timer_fn,		\
-				     0, (unsigned long)&(n),		\
-				     (tflags) | TIMER_IRQSAFE),		\
+	.timer = INIT_TIMER(delayed_work_timer_fn, 0,			\
+		(tflags) | TIMER_IRQSAFE), \
 	}
 
 #define DECLARE_WORK(n, f)						\
@@ -241,18 +240,15 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
-		__setup_timer(&(_work)->timer, delayed_work_timer_fn,	\
-			      (unsigned long)(_work),			\
+		prepare_timer(&(_work)->timer, delayed_work_timer_fn,	\
 			      (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
 
 #define __INIT_DELAYED_WORK_ONSTACK(_work, _func, _tflags)		\
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
-		__setup_timer_on_stack(&(_work)->timer,			\
-				       delayed_work_timer_fn,		\
-				       (unsigned long)(_work),		\
-				       (_tflags) | TIMER_IRQSAFE);	\
+		prepare_timer_on_stack(&(_work)->timer, delayed_work_timer_fn, \
+			       (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
 
 #define INIT_DELAYED_WORK(_work, _func)					\
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c74bf39ef764..ba2cd509902f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1492,9 +1492,10 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 }
 EXPORT_SYMBOL(queue_work_on);
 
-void delayed_work_timer_fn(unsigned long __data)
+void delayed_work_timer_fn(struct timer_list *timer)
 {
-	struct delayed_work *dwork = (struct delayed_work *)__data;
+	struct delayed_work *dwork =
+		container_of(timer, struct delayed_work, timer);
 
 	/* should have been called from irqsafe timer with irq already off */
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
@@ -1508,8 +1509,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn ||
-		     timer->data != (unsigned long)dwork);
+	WARN_ON_ONCE(timer->func != delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
@@ -5335,11 +5335,11 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq)	{ }
  */
 #ifdef CONFIG_WQ_WATCHDOG
 
-static void wq_watchdog_timer_fn(unsigned long data);
+static void wq_watchdog_timer_fn(struct timer_list *timer);
 
 static unsigned long wq_watchdog_thresh = 30;
 static struct timer_list wq_watchdog_timer =
-	TIMER_DEFERRED_INITIALIZER(wq_watchdog_timer_fn, 0, 0);
+	INIT_TIMER(wq_watchdog_timer_fn, 0, TIMER_DEFERRABLE);
 
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
@@ -5353,7 +5353,7 @@ static void wq_watchdog_reset_touched(void)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
 }
 
-static void wq_watchdog_timer_fn(unsigned long data)
+static void wq_watchdog_timer_fn(struct timer_list *timer)
 {
 	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
 	bool lockup_detected = false;
diff --git a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
index e58c8dfd3e90..171982a32768 100644
--- a/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
+++ b/tools/testing/selftests/rcutorture/formal/srcu-cbmc/src/workqueues.h
@@ -13,7 +13,7 @@
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(unsigned long __data);
+void delayed_work_timer_fn(struct timer_list *timer);
 
 struct work_struct {
 /*	atomic_long_t data; */
-- 
2.11.0
