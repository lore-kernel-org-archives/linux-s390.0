Return-Path: <BATV+d8c56d9a67374e13c9b4+5014+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/9] timers: provide a "modern" variant of timers
Date: Tue, 16 May 2017 13:48:05 +0200
Message-Id: <20170516114812.10660-3-hch@lst.de>
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

The new callback gets a pointer to the timer_list itself, which can
then be used to get the containing structure using container_of
instead of casting from and to unsigned long all the time.

The setup helpers take a flags argument instead of needing countless
variants.

Note: this further reduces space for the cpumask.  By the time we'll
need the additional cpumask space getting rid of the old-style timers
will hopefully be finished.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/timer.h | 50 ++++++++++++++++++++++++++++++++++++++++++++++++--
 kernel/time/timer.c   | 24 ++++++++++++++----------
 2 files changed, 62 insertions(+), 12 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index e6789b8757d5..87afe52c8349 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -16,7 +16,10 @@ struct timer_list {
 	 */
 	struct hlist_node	entry;
 	unsigned long		expires;
-	void			(*function)(unsigned long);
+	union {
+		void		(*func)(struct timer_list *timer);
+		void		(*function)(unsigned long);
+	};
 	unsigned long		data;
 	u32			flags;
 
@@ -52,7 +55,8 @@ struct timer_list {
  * workqueue locking issues. It's not meant for executing random crap
  * with interrupts disabled. Abuse is monitored!
  */
-#define TIMER_CPUMASK		0x0003FFFF
+#define TIMER_CPUMASK		0x0001FFFF
+#define TIMER_MODERN		0x00020000
 #define TIMER_MIGRATING		0x00040000
 #define TIMER_BASEMASK		(TIMER_CPUMASK | TIMER_MIGRATING)
 #define TIMER_DEFERRABLE	0x00080000
@@ -63,6 +67,22 @@ struct timer_list {
 
 #define TIMER_TRACE_FLAGMASK	(TIMER_MIGRATING | TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
 
+#define INIT_TIMER(_func, _expires, _flags)		\
+{							\
+	.entry = { .next = TIMER_ENTRY_STATIC },	\
+	.func = (_func),				\
+	.expires = (_expires),				\
+	.flags = TIMER_MODERN | (_flags),		\
+	__TIMER_LOCKDEP_MAP_INITIALIZER(__FILE__ ":" __stringify(__LINE__)) \
+}
+
+#define DECLARE_TIMER(_name, _func, _expires, _flags)		\
+	struct timer_list _name = INIT_TIMER(_func, _expires, _flags)
+
+/*
+ * Don't use the macros below, use DECLARE_TIMER and INIT_TIMER with their
+ * improved callback signature above.
+ */
 #define __TIMER_INITIALIZER(_function, _expires, _data, _flags) { \
 		.entry = { .next = TIMER_ENTRY_STATIC },	\
 		.function = (_function),			\
@@ -126,6 +146,32 @@ static inline void init_timer_on_stack_key(struct timer_list *timer,
 	init_timer_on_stack_key((_timer), (_flags), NULL, NULL)
 #endif
 
+/**
+ * prepare_timer - initialize a timer before first use
+ * @timer:	timer structure to prepare
+ * @func:	callback to be called when the timer expires
+ * @flags	%TIMER_* flags that control timer behavior
+ *
+ * This function initializes a timer_list structure so that it can
+ * be used (by calling add_timer() or mod_timer()).
+ */
+static inline void prepare_timer(struct timer_list *timer,
+		void (*func)(struct timer_list *timer), u32 flags)
+{
+	__init_timer(timer, TIMER_MODERN | flags);
+	timer->func = func;
+}
+
+static inline void prepare_timer_on_stack(struct timer_list *timer,
+		void (*func)(struct timer_list *timer), u32 flags)
+{
+	__init_timer_on_stack(timer, TIMER_MODERN | flags);
+	timer->func = func;
+}
+
+/*
+ * Don't use - use prepare_timer above for new code instead.
+ */
 #define init_timer(timer)						\
 	__init_timer((timer), 0)
 #define init_timer_pinned(timer)					\
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index c7978fcdbbea..48d8450cfa5f 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -579,7 +579,7 @@ static struct debug_obj_descr timer_debug_descr;
 
 static void *timer_debug_hint(void *addr)
 {
-	return ((struct timer_list *) addr)->function;
+	return ((struct timer_list *) addr)->func;
 }
 
 static bool timer_is_static_object(void *addr)
@@ -930,7 +930,7 @@ __mod_timer(struct timer_list *timer, unsigned long expires, bool pending_only)
 	unsigned long clk = 0, flags;
 	int ret = 0;
 
-	BUG_ON(!timer->function);
+	BUG_ON(!timer->func && !timer->function);
 
 	/*
 	 * This is a common optimization triggered by the networking code - if
@@ -1064,12 +1064,12 @@ EXPORT_SYMBOL(mod_timer);
  * add_timer - start a timer
  * @timer: the timer to be added
  *
- * The kernel will do a ->function(->data) callback from the
- * timer interrupt at the ->expires point in the future. The
- * current time is 'jiffies'.
+ * The kernel will do a ->func (or ->function(->data) for legacy timers)
+ * callback from the timer interrupt at the ->expires point in the future.
+ * The current time is 'jiffies'.
  *
- * The timer's ->expires, ->function (and if the handler uses it, ->data)
- * fields must be set prior calling this function.
+ * The timer's ->expires, ->func / ->function (and if the handler uses it,
+ * ->data) fields must be set prior calling this function.
  *
  * Timers with an ->expires field in the past will be executed in the next
  * timer tick.
@@ -1093,7 +1093,8 @@ void add_timer_on(struct timer_list *timer, int cpu)
 	struct timer_base *new_base, *base;
 	unsigned long flags;
 
-	BUG_ON(timer_pending(timer) || !timer->function);
+	BUG_ON(timer_pending(timer));
+	BUG_ON(!timer->func && !timer->function);
 
 	new_base = get_timer_cpu_base(timer->flags, cpu);
 
@@ -1264,14 +1265,17 @@ static void call_timer_fn(struct timer_list *timer)
 	lock_map_acquire(&lockdep_map);
 
 	trace_timer_expire_entry(timer);
-	timer->function(timer->data);
+	if (timer->flags & TIMER_MODERN)
+		timer->func(timer);
+	else
+		timer->function(timer->data);
 	trace_timer_expire_exit(timer);
 
 	lock_map_release(&lockdep_map);
 
 	if (count != preempt_count()) {
 		WARN_ONCE(1, "timer: %pF preempt leak: %08x -> %08x\n",
-			  timer->function, count, preempt_count());
+			  timer->func, count, preempt_count());
 		/*
 		 * Restore the preempt count. That gives us a decent
 		 * chance to survive and extract information. If the
-- 
2.11.0
