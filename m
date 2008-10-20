Return-Path: <travis@sgi.com>
Message-Id: <20081020170320.288298000@polaris-admin.engr.sgi.com>
References: <20081020170319.539427000@polaris-admin.engr.sgi.com>
Date: Mon, 20 Oct 2008 10:03:24 -0700
From: Mike Travis <travis@sgi.com>
Subject: [PATCH 05/35] sched: Reduce stack size requirements in kernel/sched.c
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
To: Ingo Molnar <mingo@elte.hu>, Rusty Russell <rusty@rustcorp.com.au>
Cc: davej@codemonkey.org.uk, Jeremy Fitzhardinge <jeremy@goop.org>, Jes Sorensen <jes@sgi.com>, IA64 <linux-ia64@vger.kernel.org>, S390 <linux-s390@vger.kernel.org>, peterz@infradead.org, Jack Steiner <steiner@sgi.com>, linux-kernel@vger.kernel.org, Eric Dumazet <dada1@cosmosbay.com>, PowerPC <linuxppc-dev@ozlabs.org>, Andi Kleen <andi@firstfloor.org>, Thomas Gleixner <tglx@linutronix.de>, Yinghai Lu <yhlu.kernel@gmail.com>, "H. Peter Anvin" <hpa@zytor.com>, SPARC <sparclinux@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, David Miller <davem@davemloft.net>
List-ID: <linux-s390.vger.kernel.org>

  * use node_to_cpumask_ptr in place of node_to_cpumask to reduce stack
    requirements in sched.c

Applies to linux-2.6.tip/master.

Signed-off-by: Mike Travis <travis@sgi.com>
Acked-by: Rusty Russell <rusty@rustcorp.com.au>
---
 kernel/sched.c |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

--- linux-2.6.28.orig/kernel/sched.c
+++ linux-2.6.28/kernel/sched.c
@@ -6117,8 +6117,9 @@ static void move_task_off_dead_cpu(int d
 
 	do {
 		/* On same node? */
-		mask = node_to_cpumask(cpu_to_node(dead_cpu));
-		cpus_and(mask, mask, p->cpus_allowed);
+		node_to_cpumask_ptr(pnodemask, cpu_to_node(dead_cpu));
+
+		cpus_and(mask, *pnodemask, p->cpus_allowed);
 		dest_cpu = any_online_cpu(mask);
 
 		/* On any allowed CPU? */
@@ -7126,9 +7127,9 @@ static int cpu_to_allnodes_group(int cpu
 				 struct sched_group **sg, cpumask_t *nodemask)
 {
 	int group;
+	node_to_cpumask_ptr(pnodemask, cpu_to_node(cpu));
 
-	*nodemask = node_to_cpumask(cpu_to_node(cpu));
-	cpus_and(*nodemask, *nodemask, *cpu_map);
+	cpus_and(*nodemask, *pnodemask, *cpu_map);
 	group = first_cpu(*nodemask);
 
 	if (sg)
@@ -7178,9 +7179,9 @@ static void free_sched_groups(const cpum
 
 		for (i = 0; i < nr_node_ids; i++) {
 			struct sched_group *oldsg, *sg = sched_group_nodes[i];
+			node_to_cpumask_ptr(pnodemask, i);
 
-			*nodemask = node_to_cpumask(i);
-			cpus_and(*nodemask, *nodemask, *cpu_map);
+			cpus_and(*nodemask, *pnodemask, *cpu_map);
 			if (cpus_empty(*nodemask))
 				continue;
 

-- 
