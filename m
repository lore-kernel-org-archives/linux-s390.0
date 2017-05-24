Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20170524081548.250203087@linutronix.de>
Date: Wed, 24 May 2017 10:15:26 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V3 15/32] s390/kernel: Use stop_machine_cpuslocked()
References: <20170524081511.203800767@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=s390kernel_Use_stop_machine_cpuslocked().patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Paul McKenney <paulmck@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

stp_work_fn() holds get_online_cpus() while invoking stop_machine().

stop_machine() invokes get_online_cpus() as well. This is correct, but
prevents the conversion of the hotplug locking to a percpu rwsem.

Use stop_machine_cpuslocked() to avoid the nested call. Convert
*_online_cpus() to the new interfaces while at it.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-s390@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>

---
 arch/s390/kernel/time.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -636,10 +636,10 @@ static void stp_work_fn(struct work_stru
 		goto out_unlock;
 
 	memset(&stp_sync, 0, sizeof(stp_sync));
-	get_online_cpus();
+	cpus_read_lock();
 	atomic_set(&stp_sync.cpus, num_online_cpus() - 1);
-	stop_machine(stp_sync_clock, &stp_sync, cpu_online_mask);
-	put_online_cpus();
+	stop_machine_cpuslocked(stp_sync_clock, &stp_sync, cpu_online_mask);
+	cpus_read_unlock();
 
 	if (!check_sync_clock())
 		/*
