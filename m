From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 13/13] workqueue: Convert callback to use from_timer()
Date: Wed,  4 Oct 2017 16:27:07 -0700
Message-Id: <1507159627-127660-14-git-send-email-keescook@chromium.org>
In-Reply-To: <1507159627-127660-1-git-send-email-keescook@chromium.org>
References: <1507159627-127660-1-git-send-email-keescook@chromium.org>
Return-Path: <keescook@chromium.org>
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
List-Archive: <https://lore.kernel.org/linux-mips/>
List-Post: <mailto:linux-mips@vger.kernel.org>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Kees Cook <keescook@chromium.org>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@mellanox.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Harish Patil <harish.patil@cavium.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Len Brown <len.brown@intel.com>, Manish Chopra <manish.chopra@cavium.com>, Mark Gross <mark.gross@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ralf Baechle <ralf@linux-mips.org>, Sebastian Reichel <sre@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Stephen Boyd <sboyd@codeaurora.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer
to all timer callbacks, switch workqueue to use from_timer() and pass the
timer pointer explicitly.

Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/workqueue.h | 15 ++++++++-------
 kernel/workqueue.c        |  7 +++----
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index f4960260feaf..f3c47a05fd06 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -17,7 +17,7 @@ struct workqueue_struct;
 
 struct work_struct;
 typedef void (*work_func_t)(struct work_struct *work);
-void delayed_work_timer_fn(unsigned long __data);
+void delayed_work_timer_fn(struct timer_list *t);
 
 /*
  * The first word is the work queue pointer and the flags rolled into
@@ -175,8 +175,8 @@ struct execute_work {
 
 #define __DELAYED_WORK_INITIALIZER(n, f, tflags) {			\
 	.work = __WORK_INITIALIZER((n).work, (f)),			\
-	.timer = __TIMER_INITIALIZER(delayed_work_timer_fn,		\
-				     (unsigned long)&(n),		\
+	.timer = __TIMER_INITIALIZER((TIMER_FUNC_TYPE)delayed_work_timer_fn,\
+				     (TIMER_DATA_TYPE)&(n.timer),	\
 				     (tflags) | TIMER_IRQSAFE),		\
 	}
 
@@ -241,8 +241,9 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 #define __INIT_DELAYED_WORK(_work, _func, _tflags)			\
 	do {								\
 		INIT_WORK(&(_work)->work, (_func));			\
-		__setup_timer(&(_work)->timer, delayed_work_timer_fn,	\
-			      (unsigned long)(_work),			\
+		__setup_timer(&(_work)->timer,				\
+			      (TIMER_FUNC_TYPE)delayed_work_timer_fn,	\
+			      (TIMER_DATA_TYPE)&(_work)->timer,		\
 			      (_tflags) | TIMER_IRQSAFE);		\
 	} while (0)
 
@@ -250,8 +251,8 @@ static inline unsigned int work_static(struct work_struct *work) { return 0; }
 	do {								\
 		INIT_WORK_ONSTACK(&(_work)->work, (_func));		\
 		__setup_timer_on_stack(&(_work)->timer,			\
-				       delayed_work_timer_fn,		\
-				       (unsigned long)(_work),		\
+				       (TIMER_FUNC_TYPE)delayed_work_timer_fn,\
+				       (TIMER_DATA_TYPE)&(_work)->timer,\
 				       (_tflags) | TIMER_IRQSAFE);	\
 	} while (0)
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index a5361fc6215d..c77fdf6bf24f 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1492,9 +1492,9 @@ bool queue_work_on(int cpu, struct workqueue_struct *wq,
 }
 EXPORT_SYMBOL(queue_work_on);
 
-void delayed_work_timer_fn(unsigned long __data)
+void delayed_work_timer_fn(struct timer_list *t)
 {
-	struct delayed_work *dwork = (struct delayed_work *)__data;
+	struct delayed_work *dwork = from_timer(dwork, t, timer);
 
 	/* should have been called from irqsafe timer with irq already off */
 	__queue_work(dwork->cpu, dwork->wq, &dwork->work);
@@ -1508,8 +1508,7 @@ static void __queue_delayed_work(int cpu, struct workqueue_struct *wq,
 	struct work_struct *work = &dwork->work;
 
 	WARN_ON_ONCE(!wq);
-	WARN_ON_ONCE(timer->function != delayed_work_timer_fn ||
-		     timer->data != (unsigned long)dwork);
+	WARN_ON_ONCE(timer->function != (TIMER_FUNC_TYPE)delayed_work_timer_fn);
 	WARN_ON_ONCE(timer_pending(timer));
 	WARN_ON_ONCE(!list_empty(&work->entry));
 
-- 
2.7.4
