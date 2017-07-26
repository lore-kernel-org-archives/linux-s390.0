Return-Path: <owner-linux-mm@kvack.org>
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: [PATCH] mm: take memory hotplug lock within numa_zonelist_order_handler()
Date: Wed, 26 Jul 2017 13:17:38 +0200
Message-Id: <20170726111738.38768-1-heiko.carstens@de.ibm.com>
Sender: owner-linux-mm@kvack.org
List-Archive: <https://lore.kernel.org/linux-mm/>
List-Post: <mailto:linux-mm@kvack.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Andre Wild <wild@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>, Thomas Gleixner <tglx@linutronix.de>, Michal Hocko <mhocko@suse.com>, Vlastimil Babka <vbabka@suse.cz>
List-ID: <linux-s390.vger.kernel.org>

Andre Wild reported the folling warning:

WARNING: CPU: 2 PID: 1205 at kernel/cpu.c:240 lockdep_assert_cpus_held+0x4c/0x60
Modules linked in:
CPU: 2 PID: 1205 Comm: bash Not tainted 4.13.0-rc2-00022-gfd2b2c57ec20 #10
Hardware name: IBM 2964 N96 702 (z/VM 6.4.0)
task: 00000000701d8100 task.stack: 0000000073594000
Krnl PSW : 0704f00180000000 0000000000145e24 (lockdep_assert_cpus_held+0x4c/0x60)
...
Call Trace:
 lockdep_assert_cpus_held+0x42/0x60)
 stop_machine_cpuslocked+0x62/0xf0
 build_all_zonelists+0x92/0x150
 numa_zonelist_order_handler+0x102/0x150
 proc_sys_call_handler.isra.12+0xda/0x118
 proc_sys_write+0x34/0x48
 __vfs_write+0x3c/0x178
 vfs_write+0xbc/0x1a0
 SyS_write+0x66/0xc0
 system_call+0xc4/0x2b0
 locks held by bash/1205:
 #0:  (sb_writers#4){.+.+.+}, at: [<000000000037b29e>] vfs_write+0xa6/0x1a0
 #1:  (zl_order_mutex){+.+...}, at: [<00000000002c8e4c>] numa_zonelist_order_handler+0x44/0x150
 #2:  (zonelists_mutex){+.+...}, at: [<00000000002c8efc>] numa_zonelist_order_handler+0xf4/0x150
Last Breaking-Event-Address:
 [<0000000000145e20>] lockdep_assert_cpus_held+0x48/0x60

This can be easily triggered with e.g.

 >echo n > /proc/sys/vm/numa_zonelist_order

With commit 3f906ba23689a ("mm/memory-hotplug: switch locking to a
percpu rwsem") memory hotplug locking was changed to fix a potential
deadlock. This also switched the stop_machine() invocation within
build_all_zonelists() to stop_machine_cpuslocked() which now expects
that online cpus are locked when being called.

This assumption is not true if build_all_zonelists() is being called
from numa_zonelist_order_handler(). In order to fix this simply add a
mem_hotplug_begin()/mem_hotplug_done() pair to numa_zonelist_order_handler().

Reported-by: Andre Wild <wild@linux.vnet.ibm.com>
Cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Michal Hocko <mhocko@suse.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 mm/page_alloc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 6d30e914afb6..fc32aa81f359 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -4891,9 +4891,11 @@ int numa_zonelist_order_handler(struct ctl_table *table, int write,
 				NUMA_ZONELIST_ORDER_LEN);
 			user_zonelist_order = oldval;
 		} else if (oldval != user_zonelist_order) {
+			mem_hotplug_begin();
 			mutex_lock(&zonelists_mutex);
 			build_all_zonelists(NULL, NULL);
 			mutex_unlock(&zonelists_mutex);
+			mem_hotplug_done();
 		}
 	}
 out:
-- 
2.11.2

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
