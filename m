From: Kees Cook <keescook@chromium.org>
Subject: [PATCH 06/13] timer: Remove users of TIMER_DEFERRED_INITIALIZER
Date: Wed,  4 Oct 2017 16:27:00 -0700
Message-Id: <1507159627-127660-7-git-send-email-keescook@chromium.org>
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
Cc: Kees Cook <keescook@chromium.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>, linux-s390@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Chris Metcalf <cmetcalf@mellanox.com>, Geert Uytterhoeven <geert@linux-m68k.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Guenter Roeck <linux@roeck-us.net>, Harish Patil <harish.patil@cavium.com>, "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>, John Stultz <john.stultz@linaro.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Kalle Valo <kvalo@qca.qualcomm.com>, Len Brown <len.brown@intel.com>, Manish Chopra <manish.chopra@cavium.com>, Mark Gross <mark.gross@intel.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Michael Ellerman <mpe@ellerman.id.au>, Michael Reed <mdr@sgi.com>, netdev@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>, Paul Mackerras <paulus@samba.org>, Pavel Machek <pavel@ucw.cz>, Petr Mladek <pmladek@suse.com>, "Rafael J. Wysocki" <rjw@rjwysocki.net>, Ralf Baechle <ralf@linux-mips.org>, Sebastian Reichel <sre@kernel.org>, Stefan Richter <stefanr@s5r6.in-berlin.de>, Stephen Boyd <sboyd@codeaurora.org>, Sudip Mukherjee <sudipm.mukherjee@gmail.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Viresh Kumar <viresh.kumar@linaro.org>, Wim Van Sebroeck <wim@iguana.be>, linux1394-devel@lists.sourceforge.net, linux-mips@linux-mips.org, linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-scsi@vger.kernel.org, linux-watchdog@vger.kernel.org, linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This removes uses of TIMER_DEFERRED_INITIALIZER and chooses a location
to call timer_setup() from before add_timer() or mod_timer() is called.
Adjusts callbacks to use from_timer() as needed.

Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Lai Jiangshan <jiangshanlai@gmail.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/s390/kernel/lgr.c      | 6 +++---
 arch/s390/kernel/topology.c | 6 +++---
 kernel/workqueue.c          | 8 +++-----
 3 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/s390/kernel/lgr.c b/arch/s390/kernel/lgr.c
index ae7dff110054..bf9622f0e6b1 100644
--- a/arch/s390/kernel/lgr.c
+++ b/arch/s390/kernel/lgr.c
@@ -153,14 +153,13 @@ static void lgr_timer_set(void);
 /*
  * LGR timer callback
  */
-static void lgr_timer_fn(unsigned long ignored)
+static void lgr_timer_fn(struct timer_list *unused)
 {
 	lgr_info_log();
 	lgr_timer_set();
 }
 
-static struct timer_list lgr_timer =
-	TIMER_DEFERRED_INITIALIZER(lgr_timer_fn, 0, 0);
+static struct timer_list lgr_timer;
 
 /*
  * Setup next LGR timer
@@ -181,6 +180,7 @@ static int __init lgr_init(void)
 	debug_register_view(lgr_dbf, &debug_hex_ascii_view);
 	lgr_info_get(&lgr_info_last);
 	debug_event(lgr_dbf, 1, &lgr_info_last, sizeof(lgr_info_last));
+	timer_setup(&lgr_timer, lgr_timer_fn, TIMER_DEFERRABLE);
 	lgr_timer_set();
 	return 0;
 }
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index ed0bdd220e1a..d7ece9888c29 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -320,15 +320,14 @@ static void topology_flush_work(void)
 	flush_work(&topology_work);
 }
 
-static void topology_timer_fn(unsigned long ignored)
+static void topology_timer_fn(struct timer_list *unused)
 {
 	if (ptf(PTF_CHECK))
 		topology_schedule_update();
 	set_topology_timer();
 }
 
-static struct timer_list topology_timer =
-	TIMER_DEFERRED_INITIALIZER(topology_timer_fn, 0, 0);
+static struct timer_list topology_timer;
 
 static atomic_t topology_poll = ATOMIC_INIT(0);
 
@@ -597,6 +596,7 @@ static struct ctl_table topology_dir_table[] = {
 
 static int __init topology_init(void)
 {
+	timer_setup(&topology_timer, topology_timer_fn, TIMER_DEFERRABLE);
 	if (MACHINE_HAS_TOPOLOGY)
 		set_topology_timer();
 	else
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 64d0edf428f8..a5361fc6215d 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5390,11 +5390,8 @@ static void workqueue_sysfs_unregister(struct workqueue_struct *wq)	{ }
  */
 #ifdef CONFIG_WQ_WATCHDOG
 
-static void wq_watchdog_timer_fn(unsigned long data);
-
 static unsigned long wq_watchdog_thresh = 30;
-static struct timer_list wq_watchdog_timer =
-	TIMER_DEFERRED_INITIALIZER(wq_watchdog_timer_fn, 0, 0);
+static struct timer_list wq_watchdog_timer;
 
 static unsigned long wq_watchdog_touched = INITIAL_JIFFIES;
 static DEFINE_PER_CPU(unsigned long, wq_watchdog_touched_cpu) = INITIAL_JIFFIES;
@@ -5408,7 +5405,7 @@ static void wq_watchdog_reset_touched(void)
 		per_cpu(wq_watchdog_touched_cpu, cpu) = jiffies;
 }
 
-static void wq_watchdog_timer_fn(unsigned long data)
+static void wq_watchdog_timer_fn(struct timer_list *unused)
 {
 	unsigned long thresh = READ_ONCE(wq_watchdog_thresh) * HZ;
 	bool lockup_detected = false;
@@ -5510,6 +5507,7 @@ module_param_cb(watchdog_thresh, &wq_watchdog_thresh_ops, &wq_watchdog_thresh,
 
 static void wq_watchdog_init(void)
 {
+	timer_setup(&wq_watchdog_timer, wq_watchdog_timer_fn, TIMER_DEFERRABLE);
 	wq_watchdog_set_thresh(wq_watchdog_thresh);
 }
 
-- 
2.7.4
