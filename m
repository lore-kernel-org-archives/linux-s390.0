Return-Path: <linux-kernel-owner+w=401wt.eu-S932233AbYD2OVl@vger.kernel.org>
Message-Id: <20080429140250.775945990@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:26 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 09/15] cpu topology: Fix possible deadlock.
Content-Disposition: inline; filename=009-topology-deadlock.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Oleg Nesterov <oleg@tv-sign.ru>, Peter Zijlstra <peterz@infradead.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

When we get a notification that cpu topology changed, we schedule a
work struct which just calls arch_reinit_sched_domains. This function
in turn calls get_online_cpus() which results int the lockdep warning
below.

After all it turnded out that it's not legal to call get_online_cpus()
from the context of a multi-threaded work queue.
It could deadlock this way:

process 0 (events/cpu-x):
-> run_workqueue
-> removes my work_struct from the work queue
-> calls work_struct->fn
-> get_online_cpus()
-> locks on cpu_hotplug.lock since process 1 below is doing cpu hotplug

process 1:
-> cpu_down (for cpu-x)
-> cpu_hotplug_begin (holds cpu_hotplug.lock now)
-> cpu-x dead
-> notifier_call_chain with CPU_DEAD
-> cleanup_workqueue_thread
-> flush_cpu_workqueue (succeeds)
-> kthread_stop for events/cpu-x
  -> now kthread_stop waits for my work_struct to complete from within
     process 0. -> dead.

A single threaded workqueue wouldn't have such problems, however there is
no such common queue available and it's not worth to create one for the
very rare calls to arch_reinit_sched_domains.

So we just create a kernel thread from our work struct which calls
arch_reinit_sched_domains and are done with it.

Thanks to Oleg Nesterov and Peter Zijlstra for helping me figuring out
that this isn't a false positive lockdep warning:

=======================================================
[ INFO: possible circular locking dependency detected ]
2.6.25-03562-g3dc5063-dirty #12
-------------------------------------------------------
events/3/14 is trying to acquire lock:
 (&cpu_hotplug.lock){--..}, at: [<0000000000076094>] get_online_cpus+0x50/0x78

but task is already holding lock:
 (topology_work){--..}, at: [<0000000000059cde>] run_workqueue+0x106/0x278

which lock already depends on the new lock.

the existing dependency chain (in reverse order) is:

-> #2 (topology_work){--..}:
       [<000000000006fc74>] __lock_acquire+0x1010/0x111c
       [<000000000006fe40>] lock_acquire+0xc0/0xf8
       [<0000000000059d48>] run_workqueue+0x170/0x278
       [<0000000000059edc>] worker_thread+0x8c/0xf0
       [<000000000005f5bc>] kthread+0x68/0xa0
       [<000000000001a33e>] kernel_thread_starter+0x6/0xc
       [<000000000001a338>] kernel_thread_starter+0x0/0xc

-> #1 (events){--..}:
       [<000000000006fc74>] __lock_acquire+0x1010/0x111c
       [<000000000006fe40>] lock_acquire+0xc0/0xf8
       [<000000000005a23c>] cleanup_workqueue_thread+0x60/0xa8
       [<00000000003b2ab8>] workqueue_cpu_callback+0xbc/0x170
       [<00000000003bba80>] notifier_call_chain+0x5c/0xa4
       [<00000000000655a2>] __raw_notifier_call_chain+0x26/0x38
       [<00000000000655e2>] raw_notifier_call_chain+0x2e/0x40
       [<0000000000075e00>] cpu_down+0x228/0x31c
       [<00000000003b1dd8>] store_online+0x64/0xb8
       [<00000000001e7128>] sysdev_store+0x48/0x58
       [<0000000000121cd2>] sysfs_write_file+0x126/0x1c0
       [<00000000000c1944>] vfs_write+0xb0/0x15c
       [<00000000000c20e6>] sys_write+0x56/0x88
       [<0000000000027a68>] sys32_write+0x34/0x4c
       [<0000000000023f70>] sysc_noemu+0x10/0x16
       [<0000000077f3f186>] 0x77f3f186

-> #0 (&cpu_hotplug.lock){--..}:
       [<000000000006fa84>] __lock_acquire+0xe20/0x111c
       [<000000000006fe40>] lock_acquire+0xc0/0xf8
       [<00000000003b701c>] mutex_lock_nested+0xd0/0x364
       [<0000000000076094>] get_online_cpus+0x50/0x78
       [<000000000003a03e>] arch_reinit_sched_domains+0x26/0x58
       [<000000000002700e>] topology_work_fn+0x26/0x34
       [<0000000000059d4e>] run_workqueue+0x176/0x278
       [<0000000000059edc>] worker_thread+0x8c/0xf0
       [<000000000005f5bc>] kthread+0x68/0xa0
       [<000000000001a33e>] kernel_thread_starter+0x6/0xc
       [<000000000001a338>] kernel_thread_starter+0x0/0xc

other info that might help us debug this:

2 locks held by events/3/14:
 #0:  (events){--..}, at: [<0000000000059cde>] run_workqueue+0x106/0x278
 #1:  (topology_work){--..}, at: [<0000000000059cde>] run_workqueue+0x106/0x278

stack backtrace:
CPU: 3 Not tainted 2.6.25-03562-g3dc5063-dirty #12
Process events/3 (pid: 14, task: 000000002fb04038, ksp: 000000002fb0bd70)
0400000000000000 000000002fb0ba40 0000000000000002 0000000000000000 
       000000002fb0bae0 000000002fb0ba58 000000002fb0ba58 0000000000016488 
       0000000000000000 000000002fb0bd70 0000000000000000 0000000000000000 
       000000002fb0ba40 000000000000000c 000000002fb0ba40 000000002fb0bab0 
       00000000003c99e0 0000000000016488 000000002fb0ba40 000000002fb0ba90 
Call Trace:
([<00000000000163fc>] show_trace+0x138/0x158)
 [<00000000000164e2>] show_stack+0xc6/0xf8
 [<0000000000016624>] dump_stack+0xb0/0xc0
 [<000000000006cd36>] print_circular_bug_tail+0xa2/0xb4
 [<000000000006fa84>] __lock_acquire+0xe20/0x111c
 [<000000000006fe40>] lock_acquire+0xc0/0xf8
 [<00000000003b701c>] mutex_lock_nested+0xd0/0x364
 [<0000000000076094>] get_online_cpus+0x50/0x78
 [<000000000003a03e>] arch_reinit_sched_domains+0x26/0x58
 [<000000000002700e>] topology_work_fn+0x26/0x34
 [<0000000000059d4e>] run_workqueue+0x176/0x278
 [<0000000000059edc>] worker_thread+0x8c/0xf0
 [<000000000005f5bc>] kthread+0x68/0xa0
 [<000000000001a33e>] kernel_thread_starter+0x6/0xc
 [<000000000001a338>] kernel_thread_starter+0x0/0xc
INFO: lockdep is turned off.

Cc: Oleg Nesterov <oleg@tv-sign.ru>
Cc: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/topology.c |   14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

Index: quilt-2.6/arch/s390/kernel/topology.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/topology.c
+++ quilt-2.6/arch/s390/kernel/topology.c
@@ -9,6 +9,7 @@
 #include <linux/device.h>
 #include <linux/bootmem.h>
 #include <linux/sched.h>
+#include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/cpu.h>
 #include <linux/smp.h>
@@ -229,9 +230,20 @@ void arch_update_cpu_topology(void)
 	}
 }
 
-static void topology_work_fn(struct work_struct *work)
+static int topology_kthread(void *data)
 {
 	arch_reinit_sched_domains();
+	return 0;
+}
+
+static void topology_work_fn(struct work_struct *work)
+{
+	/* We can't call arch_reinit_sched_domains() from a multi-threaded
+	 * workqueue context since it may deadlock in case of cpu hotplug.
+	 * So we have to create a kernel thread in order to call
+	 * arch_reinit_sched_domains().
+	 */
+	kthread_run(topology_kthread, NULL, "topology_update");
 }
 
 void topology_schedule_update(void)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
