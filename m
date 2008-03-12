Return-Path: <linux-kernel-owner+w=401wt.eu-S1754888AbYCLRdi@vger.kernel.org>
Message-Id: <20080312173217.078548501@de.ibm.com>
References: <20080312173155.703966894@de.ibm.com>
Date: Wed, 12 Mar 2008 18:31:59 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/10] sched: Add arch_update_cpu_topology hook.
Content-Disposition: inline; filename=104-nodes-hook.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

Will be called each time the scheduling domains are rebuild.
Needed for architectures that don't have a static cpu topology.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 include/linux/topology.h |    2 ++
 kernel/sched.c           |    5 +++++
 2 files changed, 7 insertions(+)

Index: quilt-2.6/include/linux/topology.h
===================================================================
--- quilt-2.6.orig/include/linux/topology.h
+++ quilt-2.6/include/linux/topology.h
@@ -50,6 +50,8 @@
 	for_each_online_node(node)						\
 		if (nr_cpus_node(node))
 
+void arch_update_cpu_topology(void);
+
 /* Conform to ACPI 2.0 SLIT distance definitions */
 #define LOCAL_DISTANCE		10
 #define REMOTE_DISTANCE		20
Index: quilt-2.6/kernel/sched.c
===================================================================
--- quilt-2.6.orig/kernel/sched.c
+++ quilt-2.6/kernel/sched.c
@@ -6804,6 +6804,10 @@ static int ndoms_cur;		/* number of sche
  */
 static cpumask_t fallback_doms;
 
+void __attribute__((weak)) arch_update_cpu_topology(void)
+{
+}
+
 /*
  * Set up scheduler domains and groups. Callers must hold the hotplug lock.
  * For now this just excludes isolated cpus, but could be used to
@@ -6813,6 +6817,7 @@ static int arch_init_sched_domains(const
 {
 	int err;
 
+	arch_update_cpu_topology();
 	ndoms_cur = 1;
 	doms_cur = kmalloc(sizeof(cpumask_t), GFP_KERNEL);
 	if (!doms_cur)

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
