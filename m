Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 5 Apr 2016 17:59:04 +0200
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Subject: [PATCH] cpu/hotplug: fix rollback during error-out in __cpu_disable()
Message-ID: <20160405155904.GA19022@linutronix.de>
References: <1459765640-13599-1-git-send-email-anna-maria@linutronix.de>
 <20160405104912.GC3937@osiris>
 <57039DC2.6090907@linutronix.de>
 <20160405112336.GB6890@osiris>
 <20160405113637.GC6890@osiris>
 <20160405115129.GE30124@linutronix.de>
 <5703A836.7030708@linutronix.de>
 <20160405121155.GF6890@osiris>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20160405121155.GF6890@osiris>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Heiko Carstens <heiko.carstens@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>
Cc: Sebastian Andrzej Siewior <sebastian.siewior@linutronix.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, rt@linutronix.de, Martin Schwidefsky <schwidefsky@de.ibm.com>, Anna-Maria Gleixner <anna-maria@linutronix.de>
List-ID: <linux-s390.vger.kernel.org>

If we error out in __cpu_disable() (via takedown_cpu() which is
currently the last one that can fail) we don't rollback entirely to
CPUHP_ONLINE (where we started) but to CPUHP_AP_ONLINE_IDLE. This
happens because the former states were on the target CPU (the AP states)
and during the rollback we go back until the first BP state we started.
During the next cpu_down attempt (on the same failed CPU) will take
forever because the cpuhp thread is still down.

The fix this I rollback to where we started in _cpu_down() via a workqueue
to ensure that those callback will be run on the target CPU in
non-atomic context (as in normal cpu_up()).
The workqueues should be working again because the CPU_DOWN_FAILED were
already invoked.

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
 kernel/cpu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6ea42e8da861..35b3ce38cd93 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -724,6 +724,8 @@ static int takedown_cpu(unsigned int cpu)
 		/* CPU didn't die: tell everyone.  Can't complain. */
 		cpu_notify_nofail(CPU_DOWN_FAILED, cpu);
 		irq_unlock_sparse();
+		kthread_unpark(per_cpu_ptr(&cpuhp_state, cpu)->thread);
+		/* smpboot threads are up via CPUHP_AP_SMPBOOT_THREADS */
 		return err;
 	}
 	BUG_ON(cpu_online(cpu));
@@ -787,6 +789,13 @@ void cpuhp_report_idle_dead(void)
 
 #ifdef CONFIG_HOTPLUG_CPU
 
+static void undo_cpu_down_work(struct work_struct *work)
+{
+	struct cpuhp_cpu_state *st = this_cpu_ptr(&cpuhp_state);
+
+	undo_cpu_down(smp_processor_id(), st, cpuhp_ap_states);
+}
+
 /* Requires cpu_add_remove_lock to be held */
 static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 			   enum cpuhp_state target)
@@ -832,6 +841,15 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	 * to do the further cleanups.
 	 */
 	ret = cpuhp_down_callbacks(cpu, st, cpuhp_bp_states, target);
+	if (ret && st->state > CPUHP_TEARDOWN_CPU && st->state < prev_state) {
+		struct work_struct undo_work;
+
+		INIT_WORK_ONSTACK(&undo_work, undo_cpu_down_work);
+		st->target = prev_state;
+		schedule_work_on(cpu, &undo_work);
+		flush_work(&undo_work);
+		destroy_work_on_stack(&undo_work);
+	}
 
 	hasdied = prev_state != st->state && st->state == CPUHP_OFFLINE;
 out:
@@ -1249,6 +1267,7 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.name			= "notify:online",
 		.startup		= notify_online,
 		.teardown		= notify_down_prepare,
+		.skip_onerr		= true,
 	},
 #endif
 	/*
-- 
2.8.0.rc3
