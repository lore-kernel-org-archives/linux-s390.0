Return-Path: <linux-kernel-owner+w=401wt.eu-S1762147AbYD2ORk@vger.kernel.org>
Message-Id: <20080429140249.548985385@de.ibm.com>
References: <20080429140117.631962807@de.ibm.com>
Date: Tue, 29 Apr 2008 16:01:21 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 04/15] smp: Fix locking order.
Content-Disposition: inline; filename=004-smp-locking.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

On some smp sysfs store attributes get_online_cpus() may block on
cpu_hotplug.lock, but we hold already smp_cpu_state_mutex. Since the
locking order on cpu hotplug via arch_update_cpu_topology is inverse
this might lead to deadlocks.
So make sure locking order is always the same.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/smp.c |   12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

Index: quilt-2.6/arch/s390/kernel/smp.c
===================================================================
--- quilt-2.6.orig/arch/s390/kernel/smp.c
+++ quilt-2.6/arch/s390/kernel/smp.c
@@ -890,8 +890,8 @@ static ssize_t cpu_configure_store(struc
 	if (val != 0 && val != 1)
 		return -EINVAL;
 
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	rc = -EBUSY;
 	if (cpu_online(cpu))
 		goto out;
@@ -919,8 +919,8 @@ static ssize_t cpu_configure_store(struc
 		break;
 	}
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(configure, 0644, cpu_configure_show, cpu_configure_store);
@@ -1095,8 +1095,8 @@ static ssize_t __ref rescan_store(struct
 	int cpu;
 	int rc;
 
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	newcpus = cpu_present_map;
 	rc = smp_rescan_cpus();
 	if (rc)
@@ -1109,8 +1109,8 @@ static ssize_t __ref rescan_store(struct
 	}
 	rc = 0;
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	if (!cpus_empty(newcpus))
 		topology_schedule_update();
 	return rc ? rc : count;
@@ -1139,16 +1139,16 @@ static ssize_t dispatching_store(struct 
 	if (val != 0 && val != 1)
 		return -EINVAL;
 	rc = 0;
-	mutex_lock(&smp_cpu_state_mutex);
 	get_online_cpus();
+	mutex_lock(&smp_cpu_state_mutex);
 	if (cpu_management == val)
 		goto out;
 	rc = topology_set_cpu_management(val);
 	if (!rc)
 		cpu_management = val;
 out:
-	put_online_cpus();
 	mutex_unlock(&smp_cpu_state_mutex);
+	put_online_cpus();
 	return rc ? rc : count;
 }
 static SYSDEV_ATTR(dispatching, 0644, dispatching_show, dispatching_store);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
