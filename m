Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-Id: <20170418170553.363283884@linutronix.de>
Date: Tue, 18 Apr 2017 19:04:54 +0200
From: Thomas Gleixner <tglx@linutronix.de>
Subject: [patch V2 12/24] s390/kernel: Use stop_machine_cpuslocked()
References: <20170418170442.665445272@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline; filename=s390-kernel-Use_stop_machine_locked.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Sebastian Siewior <bigeasy@linutronix.de>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

stp_work_fn() holds get_online_cpus() while invoking stop_machine().

stop_machine() invokes get_online_cpus() as well. This is correct, but
prevents the conversion of the hotplug locking to a percpu rwsem.

Use stop_machine_cpuslocked() to avoid the nested call.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: David Hildenbrand <dahi@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org

---
 arch/s390/kernel/time.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -636,7 +636,7 @@ static void stp_work_fn(struct work_stru
 	memset(&stp_sync, 0, sizeof(stp_sync));
 	get_online_cpus();
 	atomic_set(&stp_sync.cpus, num_online_cpus() - 1);
-	stop_machine(stp_sync_clock, &stp_sync, cpu_online_mask);
+	stop_machine_cpuslocked(stp_sync_clock, &stp_sync, cpu_online_mask);
 	put_online_cpus();
 
 	if (!check_sync_clock())
