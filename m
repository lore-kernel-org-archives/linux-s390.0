Return-Path: <pmladek@suse.com>
Date: Wed, 17 May 2017 14:09:52 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 3/9] kthread: remove unused macros
Message-ID: <20170517120952.GB7297@pathway.suse.cz>
References: <20170516114812.10660-1-hch@lst.de>
 <20170516114812.10660-4-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170516114812.10660-4-hch@lst.de>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Christoph Hellwig <hch@lst.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Mark Gross <mark.gross@intel.com>, Tejun Heo <tj@kernel.org>, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Tue 2017-05-16 13:48:06, Christoph Hellwig wrote:
> KTHREAD_DELAYED_WORK_INIT and DEFINE_KTHREAD_DELAYED_WORK are unused
> and are using a timer helper that's about to go away.

A patch using this API is flying around, see
https://lkml.kernel.org/r/1476715742-14924-1-git-send-email-pmladek@suse.com
And I have one more, for hung_task.c, in the drawer.

I admit that I got sidetracked and did not push these conversions
last months. But the conversions are useful and I want to continue
or find a trainee that might continue.

I wanted to make your life easier, took inspiration from the
workqueues conversion and prepared the patch below. It is tested
with the above mentioned API user.

Please, let me known if you would prefer another approach.
I do not want to complicate development of the new timer API.


From fcac2f124c0c4a5af0c803b4adef50cd2aef88e1 Mon Sep 17 00:00:00 2001
From: Petr Mladek <pmladek@suse.com>
Date: Wed, 17 May 2017 14:00:19 +0200
Subject: [PATCH] kthread_worker: switch to modern timers

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Petr Mladek <pmladek@suse.com>
---
 include/linux/kthread.h | 11 ++++-------
 kernel/kthread.c        |  9 ++++-----
 2 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 4fec8b775895..8c62c36eb32a 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -75,7 +75,7 @@ struct task_struct *kthread_create_on_cpu(int (*threadfn)(void *data),
  */
 struct kthread_work;
 typedef void (*kthread_work_func_t)(struct kthread_work *work);
-void kthread_delayed_work_timer_fn(unsigned long __data);
+void kthread_delayed_work_timer_fn(struct timer_list *timer);
 
 enum {
 	KTW_FREEZABLE		= 1 << 0,	/* freeze during suspend */
@@ -116,9 +116,8 @@ struct kthread_delayed_work {
 
 #define KTHREAD_DELAYED_WORK_INIT(dwork, fn) {				\
 	.work = KTHREAD_WORK_INIT((dwork).work, (fn)),			\
-	.timer = __TIMER_INITIALIZER(kthread_delayed_work_timer_fn,	\
-				     0, (unsigned long)&(dwork),	\
-				     TIMER_IRQSAFE),			\
+	.timer = INIT_TIMER(kthread_delayed_work_timer_fn,		\
+			    0, TIMER_IRQSAFE),				\
 	}
 
 #define DEFINE_KTHREAD_WORKER(worker)					\
@@ -163,9 +162,7 @@ extern void __kthread_init_worker(struct kthread_worker *worker,
 #define kthread_init_delayed_work(dwork, fn)				\
 	do {								\
 		kthread_init_work(&(dwork)->work, (fn));		\
-		__setup_timer(&(dwork)->timer,				\
-			      kthread_delayed_work_timer_fn,		\
-			      (unsigned long)(dwork),			\
+		prepare_timer(&(dwork)->timer, delayed_work_timer_fn,	\
 			      TIMER_IRQSAFE);				\
 	} while (0)
 
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 26db528c1d88..369e72ec7e48 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -797,15 +797,15 @@ bool kthread_queue_work(struct kthread_worker *worker,
 /**
  * kthread_delayed_work_timer_fn - callback that queues the associated kthread
  *	delayed work when the timer expires.
- * @__data: pointer to the data associated with the timer
+ * @timer: pointer to timer_list in the associated data structure
  *
  * The format of the function is defined by struct timer_list.
  * It should have been called from irqsafe timer with irq already off.
  */
-void kthread_delayed_work_timer_fn(unsigned long __data)
+void kthread_delayed_work_timer_fn(struct timer_list *timer)
 {
 	struct kthread_delayed_work *dwork =
-		(struct kthread_delayed_work *)__data;
+		container_of(timer, struct kthread_delayed_work, timer);
 	struct kthread_work *work = &dwork->work;
 	struct kthread_worker *worker = work->worker;
 
@@ -836,8 +836,7 @@ void __kthread_queue_delayed_work(struct kthread_worker *worker,
 	struct timer_list *timer = &dwork->timer;
 	struct kthread_work *work = &dwork->work;
 
-	WARN_ON_ONCE(timer->function != kthread_delayed_work_timer_fn ||
-		     timer->data != (unsigned long)dwork);
+	WARN_ON_ONCE(timer->func != kthread_delayed_work_timer_fn);
 
 	/*
 	 * If @delay is 0, queue @dwork->work immediately.  This is for
-- 
1.8.5.6
