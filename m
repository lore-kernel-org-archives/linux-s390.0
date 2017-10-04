From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 01/13] timer: Convert schedule_timeout() to use from_timer()
Date: Wed,  4 Oct 2017 16:26:55 -0700
Message-Id: <1507159627-127660-2-git-send-email-keescook@chromium.org>
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
Cc: Kees Cook <keescook@chromium.org>, John Stultz <john.stultz@linaro.org>, Stephen Boyd <sboyd@codeaurora.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@mellanox.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Harish Patil <harish.patil@cavium.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Lai Jiangshan <jiangshanlai@gmail.com>, Len Brown <len.brown@intel.com>, Manish Chopra <manish.chopra@cavium.com>, Mark Gross <mark.gross@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ralf Baechle <ralf@linux-mips.org>, Sebastian Reichel <sre@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Tejun Heo <tj@kernel.org>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new from_timer() helper and passing
the timer pointer explicitly. Since this special timer is on the stack, it
needs to have a wrapper structure to carry state once .data is eliminated.

Cc: John Stultz <john.stultz@linaro.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Stephen Boyd <sboyd@codeaurora.org>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 include/linux/timer.h |  8 ++++++++
 kernel/time/timer.c   | 26 +++++++++++++++++++-------
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/linux/timer.h b/include/linux/timer.h
index 6383c528b148..5ef5c9e41a09 100644
--- a/include/linux/timer.h
+++ b/include/linux/timer.h
@@ -179,6 +179,14 @@ static inline void timer_setup(struct timer_list *timer,
 		      (TIMER_DATA_TYPE)timer, flags);
 }
 
+static inline void timer_setup_on_stack(struct timer_list *timer,
+			       void (*callback)(struct timer_list *),
+			       unsigned int flags)
+{
+	__setup_timer_on_stack(timer, (TIMER_FUNC_TYPE)callback,
+			       (TIMER_DATA_TYPE)timer, flags);
+}
+
 #define from_timer(var, callback_timer, timer_fieldname) \
 	container_of(callback_timer, typeof(*var), timer_fieldname)
 
diff --git a/kernel/time/timer.c b/kernel/time/timer.c
index f2674a056c26..38613ced2324 100644
--- a/kernel/time/timer.c
+++ b/kernel/time/timer.c
@@ -1668,9 +1668,20 @@ void run_local_timers(void)
 	raise_softirq(TIMER_SOFTIRQ);
 }
 
-static void process_timeout(unsigned long __data)
+/*
+ * Since schedule_timeout()'s timer is defined on the stack, it must store
+ * the target task on the stack as well.
+ */
+struct process_timer {
+	struct timer_list timer;
+	struct task_struct *task;
+};
+
+static void process_timeout(struct timer_list *t)
 {
-	wake_up_process((struct task_struct *)__data);
+	struct process_timer *timeout = from_timer(timeout, t, timer);
+
+	wake_up_process(timeout->task);
 }
 
 /**
@@ -1704,7 +1715,7 @@ static void process_timeout(unsigned long __data)
  */
 signed long __sched schedule_timeout(signed long timeout)
 {
-	struct timer_list timer;
+	struct process_timer timer;
 	unsigned long expire;
 
 	switch (timeout)
@@ -1738,13 +1749,14 @@ signed long __sched schedule_timeout(signed long timeout)
 
 	expire = timeout + jiffies;
 
-	setup_timer_on_stack(&timer, process_timeout, (unsigned long)current);
-	__mod_timer(&timer, expire, false);
+	timer.task = current;
+	timer_setup_on_stack(&timer.timer, process_timeout, 0);
+	__mod_timer(&timer.timer, expire, false);
 	schedule();
-	del_singleshot_timer_sync(&timer);
+	del_singleshot_timer_sync(&timer.timer);
 
 	/* Remove the timer from the object tracker */
-	destroy_timer_on_stack(&timer);
+	destroy_timer_on_stack(&timer.timer);
 
 	timeout = expire - jiffies;
 
-- 
2.7.4
