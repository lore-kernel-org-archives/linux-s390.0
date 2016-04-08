Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 8 Apr 2016 14:40:15 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH v2] cpu/hotplug: fix rollback during error-out in
 __cpu_disable()
Message-ID: <20160408124015.GA21960@linutronix.de>
References: <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
 <5703A836.7030708@linutronix.de>
 <20160405121155.GF6890@osiris>
 <20160405155904.GA19022@linutronix.de>
 <20160406195133.GB3485@osiris>
 <57067938.6030908@linutronix.de>
 <20160408061949.GA3433@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160408061949.GA3433@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

If we error out in __cpu_disable() (via takedown_cpu() which is
currently the last one that can fail) we don't rollback entirely to
CPUHP_ONLINE (where we started) but to CPUHP_AP_ONLINE_IDLE. This
happens because the former states were on the target CPU (the AP states)
and during the rollback we go back until the first BP state we started.
The next cpu_down attempt (on the same failed CPU) will take forever
because the cpuhp thread is still down (same goes for smpboot threads).

The fix this I rollback to where we started in _cpu_down(). For this I
add a ->rollback flag so we can invoke the states on the target CPU via
undo_cpu_down() (otherwise cpuhp_ap_online() rollback to
CPUHP_AP_ONLINE_IDLE in case of an error).

notify_online() has been marked as ->skip_onerr because otherwise we
will see the CPU_ONLINE notifier in addition to the CPU_DOWN_FAILED.
However with ->skip_onerr we neither see CPU_ONLINE nor CPU_DOWN_FAILED
if something in between (CPU_DOWN_FAILED … CPUHP_TEARDOWN_CPU).
Currently there is nothing.

This regression got probably introduce in the rework while we introduced
the hotplug thread to offload the work to the target CPU.

Fixes: 4cb28ced23c4 ("cpu/hotplug: Create hotplug threads")
Reported-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
---
v1…v2: replace the workqueue with cpuhp thread

CPU_DOWN_FAILED is still invoked on the "wrong" CPU, this is still just
about fixing the regression.

 kernel/cpu.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ea42e8da861..6433b9639946 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -36,6 +36,7 @@
  * @target:	The target state
  * @thread:	Pointer to the hotplug thread
  * @should_run:	Thread should execute
+ * @rollback:	Perform a rollback
  * @cb_stat:	The state for a single callback (install/uninstall)
  * @cb:		Single callback function (install/uninstall)
  * @result:	Result of the operation
@@ -47,6 +48,7 @@ struct cpuhp_cpu_state {
 #ifdef CONFIG_SMP
 	struct task_struct	*thread;
 	bool			should_run;
+	bool			rollback;
 	enum cpuhp_state	cb_state;
 	int			(*cb)(unsigned int cpu);
 	int			result;
@@ -477,6 +479,11 @@ static void cpuhp_thread_fun(unsigned int cpu)
 		} else {
 			ret = cpuhp_invoke_callback(cpu, st->cb_state, st->cb);
 		}
+	} else if (st->rollback) {
+		BUG_ON(st->state < CPUHP_AP_ONLINE_IDLE);
+
+		undo_cpu_down(cpu, st, cpuhp_ap_states);
+		st->rollback = false;
 	} else {
 		/* Cannot happen .... */
 		BUG_ON(st->state < CPUHP_AP_ONLINE_IDLE);
@@ -724,6 +731,8 @@ static int takedown_cpu(unsigned int cpu)
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		cpu_notify_nofail(CPU_DOWN_FAILED, cpu);
 		irq_unlock_sparse();
+		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		/* smpboot threads are up via CPUHP_AP_SMPBOOT_THREADS */
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));
@@ -832,6 +841,12 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, cpuhp_bp_states, target);
+	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+
+		st->target = prev_state;
+		st->rollback = true;
+		cpuhp_kick_ap_work(cpu);
+	}
 
 	hasdied = prev_state != st->state && st->state == CPUHP_OFFLINE;
 out:
@@ -1249,6 +1264,7 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.name			= "notify:online",
 		.startup		= notify_online,
 		.teardown		= notify_down_prepare,
+		.skip_onerr		= true,
 	},
 #endif
 	/*
-- 
2.8.0.rc3
