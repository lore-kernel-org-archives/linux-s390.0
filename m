Return-Path: <SRS0=gcLq=QF=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Tue, 29 Jan 2019 09:49:04 +0100
From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: WARN_ON_ONCE(!new_owner) within wake_futex_pi() triggered
Message-ID: <20190129084904.GB28485@hirez.programming.kicks-ass.net>
References: <20181127081115.GB3625@osiris>
 <alpine.DEB.2.21.1811281526430.1532@nanos.tec.linutronix.de>
 <20181129112321.GB3449@osiris>
 <20190128134410.GA28485@hirez.programming.kicks-ass.net>
 <20190128135804.GB28878@hirez.programming.kicks-ass.net>
 <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.21.1901281650310.1582@nanos.tec.linutronix.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ingo Molnar <mingo@kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Stefan Liebler <stli@linux.ibm.com>, Sebastian Sewior <bigeasy@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jan 28, 2019 at 04:53:19PM +0100, Thomas Gleixner wrote:

> Right after staring long enough at it, the commit simply forgot to give
> __rt_mutex_start_proxy_lock() the same treatment as it gave to
> rt_mutex_wait_proxy_lock().
> 
> Patch below cures that.

Yes, that is a very nice solution. Find below an updated patch that
includes a few comments. I found it harder than it should be to
reconstruct this code.

(also, I flipped the label names)

---
 kernel/futex.c           | 28 ++++++++++++++++++----------
 kernel/locking/rtmutex.c | 37 ++++++++++++++++++++++++++++++++-----
 2 files changed, 50 insertions(+), 15 deletions(-)

diff --git a/kernel/futex.c b/kernel/futex.c
index fdd312da0992..9d8411d3142d 100644
--- a/kernel/futex.c
+++ b/kernel/futex.c
@@ -2861,35 +2861,39 @@ static int futex_lock_pi(u32 __user *uaddr, unsigned int flags,
 	 * and BUG when futex_unlock_pi() interleaves with this.
 	 *
 	 * Therefore acquire wait_lock while holding hb->lock, but drop the
-	 * latter before calling rt_mutex_start_proxy_lock(). This still fully
-	 * serializes against futex_unlock_pi() as that does the exact same
-	 * lock handoff sequence.
+	 * latter before calling __rt_mutex_start_proxy_lock(). This
+	 * interleaves with futex_unlock_pi() -- which does a similar lock
+	 * handoff -- such that the latter can observe the futex_q::pi_state
+	 * before __rt_mutex_start_proxy_lock() is done.
 	 */
 	raw_spin_lock_irq(&q.pi_state->pi_mutex.wait_lock);
 	spin_unlock(q.lock_ptr);
+	/*
+	 * __rt_mutex_start_proxy_lock() unconditionally enqueues the @rt_waiter
+	 * such that futex_unlock_pi() is guaranteed to observe the waiter when
+	 * it sees the futex_q::pi_state.
+	 */
 	ret = __rt_mutex_start_proxy_lock(&q.pi_state->pi_mutex, &rt_waiter, current);
 	raw_spin_unlock_irq(&q.pi_state->pi_mutex.wait_lock);
 
 	if (ret) {
 		if (ret == 1)
 			ret = 0;
-
-		spin_lock(q.lock_ptr);
-		goto no_block;
+		goto cleanup;
 	}
 
-
 	if (unlikely(to))
 		hrtimer_start_expires(&to->timer, HRTIMER_MODE_ABS);
 
 	ret = rt_mutex_wait_proxy_lock(&q.pi_state->pi_mutex, to, &rt_waiter);
 
+cleanup:
 	spin_lock(q.lock_ptr);
 	/*
-	 * If we failed to acquire the lock (signal/timeout), we must
+	 * If we failed to acquire the lock (deadlock/signal/timeout), we must
 	 * first acquire the hb->lock before removing the lock from the
-	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex
-	 * wait lists consistent.
+	 * rt_mutex waitqueue, such that we can keep the hb and rt_mutex wait
+	 * lists consistent.
 	 *
 	 * In particular; it is important that futex_unlock_pi() can not
 	 * observe this inconsistency.
@@ -3013,6 +3017,10 @@ static int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 		 * there is no point where we hold neither; and therefore
 		 * wake_futex_pi() must observe a state consistent with what we
 		 * observed.
+		 *
+		 * In particular; this forces __rt_mutex_start_proxy() to
+		 * complete such that we're guaranteed to observe the
+		 * rt_waiter. Also see the WARN in wake_futex_pi().
 		 */
 		raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 		spin_unlock(&hb->lock);
diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 581edcc63c26..afaf37d0ac15 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -1726,12 +1726,33 @@ void rt_mutex_proxy_unlock(struct rt_mutex *lock,
 	rt_mutex_set_owner(lock, NULL);
 }
 
+/**
+ * __rt_mutex_start_proxy_lock() - Start lock acquisition for another task
+ * @lock:		the rt_mutex to take
+ * @waiter:		the pre-initialized rt_mutex_waiter
+ * @task:		the task to prepare
+ *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: does _NOT_ remove the @waiter on failure; must either call
+ * rt_mutex_wait_proxy_lock() or rt_mutex_cleanup_proxy_lock() after this.
+ *
+ * Returns:
+ *  0 - task blocked on lock
+ *  1 - acquired the lock for task, caller should wake it up
+ * <0 - error
+ *
+ * Special API call for PI-futex support.
+ */
 int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
 			      struct task_struct *task)
 {
 	int ret;
 
+	lockdep_asssert_held(&lock->wait_lock);
+
 	if (try_to_take_rt_mutex(lock, task, NULL))
 		return 1;
 
@@ -1749,9 +1770,6 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 		ret = 0;
 	}
 
-	if (unlikely(ret))
-		remove_waiter(lock, waiter);
-
 	debug_rt_mutex_print_deadlock(waiter);
 
 	return ret;
@@ -1763,12 +1781,18 @@ int __rt_mutex_start_proxy_lock(struct rt_mutex *lock,
  * @waiter:		the pre-initialized rt_mutex_waiter
  * @task:		the task to prepare
  *
+ * Starts the rt_mutex acquire; it enqueues the @waiter and does deadlock
+ * detection. It does not wait, see rt_mutex_wait_proxy_lock() for that.
+ *
+ * NOTE: unlike __rt_mutex_start_proxy_lock this _DOES_ remove the @waiter
+ * on failure.
+ *
  * Returns:
  *  0 - task blocked on lock
  *  1 - acquired the lock for task, caller should wake it up
  * <0 - error
  *
- * Special API call for FUTEX_REQUEUE_PI support.
+ * Special API call for PI-futex support.
  */
 int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 			      struct rt_mutex_waiter *waiter,
@@ -1778,6 +1802,8 @@ int rt_mutex_start_proxy_lock(struct rt_mutex *lock,
 
 	raw_spin_lock_irq(&lock->wait_lock);
 	ret = __rt_mutex_start_proxy_lock(lock, waiter, task);
+	if (unlikely(ret))
+		remove_waiter(lock, waiter);
 	raw_spin_unlock_irq(&lock->wait_lock);
 
 	return ret;
@@ -1845,7 +1871,8 @@ int rt_mutex_wait_proxy_lock(struct rt_mutex *lock,
  * @lock:		the rt_mutex we were woken on
  * @waiter:		the pre-initialized rt_mutex_waiter
  *
- * Attempt to clean up after a failed rt_mutex_wait_proxy_lock().
+ * Attempt to clean up after a failed __rt_mutex_start_proxy_lock() or
+ * rt_mutex_wait_proxy_lock().
  *
  * Unless we acquired the lock; we're still enqueued on the wait-list and can
  * in fact still be granted ownership until we're removed. Therefore we can
