Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAD1472771;
	Tue,  1 Sep 2026 08:55:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788252919; cv=none; b=gyX5MGL8BrqZAG2KQVHyLJZLntw+arpbnxH6okG2bLTKXQgZXajd7hE8XvsSIybts0wUCZJDVV5+UleLsx89tJDpw70miB2m33Taw6AnApn+c/p+ZAaQWgQTMPDCCZFJ+5tMeX6n5zQKyyaJgxr4MCkGOS4O6EBm2tKXwHoW45c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788252919; c=relaxed/simple;
	bh=cZPy/vFS8QKB75qIQM7LFzkoWRiWdiOcjDQSb4Kp2s4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WBMY/qmoyaUgwPcAn3uR10eA0UIcZ/K9rg2xymaNquLBUfjaLy3eiwJlD8KXBVHRTTU3P6/vNFyoywSjxyFYeWS+xOC7cnapiBJPaqXYtupX4feE5QZ/kmPKXaqpAO+GIY3OZN+g0GRWTeb93FClueQLutpDcacBmjlBeu+I/jk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YU92/4P9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YU92/4P9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6817Vlw0458565;
	Tue, 1 Sep 2026 08:55:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=pGAXQAbpyWXr3oAiz
	FaPdFRZBEJcj1HC/7Rp65tD54I=; b=YU92/4P9/2c+8cGqFOlziloJvYWiq+EKA
	6muyKlW7c9FSbVxpLynGgfeZNjME/cbUtOHUkAlyZkascsDbYroxEpONmmyP7ug3
	zPQ2mS0hRO6fCIX2aWq1nBjwIJUcYJyPRbYekuSbqHWegxD5iI+svKGmUUCXbivc
	dQF/QPg1vyD0Mv5pbGYDuuyKi7VHgPNK0/rtDqTom0cRQZDeWym1vi79SaqaNaNq
	RMmyUy70Gmvq0aPOOxzZ5txNUR8Y/c7ybwUtrfn1WahOuf8ewNgaJfJlxoHvBr6x
	s1gWQbM+b8F71vOn75VgZFcs7oROQu8tbjRgx+yfSFlqxtMwEAuag==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gbmuhps30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 08:55:16 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6818fLNS021643;
	Tue, 1 Sep 2026 08:55:15 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gccey2j73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Sep 2026 08:55:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6818tCUq48300288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Sep 2026 08:55:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3052320043;
	Tue,  1 Sep 2026 08:55:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0B6D220040;
	Tue,  1 Sep 2026 08:55:12 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Sep 2026 08:55:11 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>, stable@vger.kernel.org,
        Jan Polensky <japo@linux.ibm.com>
Subject: [PATCH 3/3 v8] s390/pai: Support CPU hotplug for PMU PAI
Date: Tue,  1 Sep 2026 10:54:48 +0200
Message-ID: <20260901085448.2260658-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260901085448.2260658-1-tmricht@linux.ibm.com>
References: <20260901085448.2260658-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Jmg8AbMk75DlH2IaVDafrfTwX2bZDixq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX35IIzk3co9zM
 WeAFeKnoxD5aEBPFtYDs6F0K5hwKITkrEpI/Pzur1CFsJh0xRWWW4zQZTEikfeDAyQQQo95m39h
 RwGCxwwJ2JrsgH4veaA4c30svIRo0LrqSB3Nd1HvH39kgY4jhsRBQzhG/O6FCXpX1qoNdOEg3oh
 3vh6OGqSWPj7ndnuT2VuSaHYbiuXsKSEZX+tYF8ayb5I6E8dpi0UqduHQhHCLbyBxh5/vb4ZPn1
 POUHk32fTRrfSY1nN9Zl9qVl2TBx6BwLVi0pJ6ZtLaK7nyDTlB+fc8tal8jecFmb1LvzEv8wbCf
 WaSvp6/TWuMcN0mWUxRjssjrA+hd3Amw9OEGbydKmlBVFNc3rkUw+2Yy3gYVipnZgTzgONmZbWb
 qcxyN+v/KeBSpSf5vNqJ2+H8FE87zlJRV2YFiMPLKJAeJhiwJFy6LLFBKA/X5/9NMvsgaxQPSxH
 NLSPb2R4bANFI00fiDQ==
X-Authority-Analysis: v=2.4 cv=Osl/DS/t c=1 sm=1 tr=0 ts=6a9692f4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=jMXAtiaY6crg4VwQvokA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAxMDA3NSBTYWx0ZWRfX2ORPwC8VitOL
 Iz9on472wKigrQdt3v4YSwbTqvjDZ1w5cuL3Vf+RI1U3ieDP+XfaqUMm2xxb5OEqIPp6UrOU04z
 iZPkvwIUZltsjVxKSdYxC3PB9dYlXnc=
X-Proofpoint-ORIG-GUID: Jmg8AbMk75DlH2IaVDafrfTwX2bZDixq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-01_02,2026-08-31_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 malwarescore=0 suspectscore=0 bulkscore=0 lowpriorityscore=0
 adultscore=0 impostorscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609010075

The command 'perf stat -e pai_crypto/CRYPTO_ALL/ -- <command>'
crashes the kernel when CPUs are hotplug added during that run.

Root cause is the missing allocation of per-CPU data structures
for that new CPU. The allocation is dynamic and the first
event that has task context creates such a structure for
each online CPU. This is not sufficient. CPUs may be offline
during event creation and can be set online during the
perf run time. For example commands

 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # perf stat -e cycles -i -- stress-ng -t10s --matrix X
 # sleep 1
 # echo 1 > /sys/devices/system/cpu/cpu1/online

Currently without a CPU hotplug handler, that new CPU has no
per-CPU data infrastructure. The scheduler runs PMU call back
function pai_add() to install the PMU support for that CPU before
the task is being scheduled on that new CPU.
In pai_add() instructions

    mp = this_cpu_ptr(pai_root[idx].mapptr);
    cpump = mp->mapptr;

return a NULL pointer and the result is a kernel panic as variable
cpump is used inside that function.

Add CPU hotplug support for CPU add and delete and create
the necessary per-CPU data infrastructure during CPU hotplug
add processing. Same for CPU hotplug remove.
This is done when the CPU is offline to ensure the data structures
are available when CPU is made online and tasks are scheduled on it.

Cc: stable@vger.kernel.org # v6.19
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Jan Polensky <japo@linux.ibm.com>
---
 arch/s390/include/asm/pai.h |   1 -
 arch/s390/kernel/perf_pai.c | 164 ++++++++++++++++++++++++++----------
 2 files changed, 120 insertions(+), 45 deletions(-)

diff --git a/arch/s390/include/asm/pai.h b/arch/s390/include/asm/pai.h
index 534d0320e2aa..a3456a36aaa7 100644
--- a/arch/s390/include/asm/pai.h
+++ b/arch/s390/include/asm/pai.h
@@ -76,7 +76,6 @@ static __always_inline void pai_kernel_exit(struct pt_regs *regs)
 }
 
 #define PAI_SAVE_AREA(x)	((x)->hw.event_base)
-#define PAI_CPU_MASK(x)		((x)->hw.addr_filters)
 #define PAI_PMU_IDX(x)		((x)->hw.last_tag)
 #define PAI_SWLIST(x)		(&(x)->hw.tp_list)
 
diff --git a/arch/s390/kernel/perf_pai.c b/arch/s390/kernel/perf_pai.c
index 52d9f654346a..794ce69a2fd5 100644
--- a/arch/s390/kernel/perf_pai.c
+++ b/arch/s390/kernel/perf_pai.c
@@ -67,6 +67,7 @@ struct pai_mapptr {
 
 static struct pai_root {		/* Anchor to per CPU data */
 	refcount_t refcnt;		/* Overall active events */
+	atomic_t tskctx;		/* Overall per-task events */
 	struct pai_mapptr __percpu *mapptr;
 } pai_root[PAI_PMU_MAX];
 
@@ -93,14 +94,15 @@ struct pai_pmu {			/* Define PAI PMU characteristics */
 static struct pai_pmu pai_pmu[];	/* Forward declaration */
 
 /* Free per CPU data when the last event is removed. */
-static void pai_root_free(int idx)
+static void pai_root_free(int idx, int tasks)
 {
-	if (refcount_dec_and_test(&pai_root[idx].refcnt)) {
+	if (refcount_sub_and_test(tasks, &pai_root[idx].refcnt)) {
 		free_percpu(pai_root[idx].mapptr);
 		pai_root[idx].mapptr = NULL;
 	}
-	debug_sprintf_event(paidbg, 5, "%s root[%d].refcount %d\n", __func__,
-			    idx, refcount_read(&pai_root[idx].refcnt));
+	debug_sprintf_event(paidbg, 5, "%s root[%d].refcount %d tskctx %d\n",
+			    __func__, idx, refcount_read(&pai_root[idx].refcnt),
+			    atomic_read(&pai_root[idx].tskctx));
 }
 
 /*
@@ -137,20 +139,36 @@ static void pai_free(struct pai_mapptr *mp)
 	mp->mapptr = NULL;
 }
 
-/* Adjust usage counters and remove allocated memory when all users are
- * gone. Called under mutex_lock.
- */
-static void pai_event_destroy_cpu(int idx, int cpu)
+/* Called under mutex_lock */
+static void pai_event_destroy_cpu(int idx, int cpu, bool hotplug)
 {
-	struct pai_mapptr *mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
-	struct pai_map *cpump = mp->mapptr;
+	struct pai_mapptr *mp;
+	struct pai_map *cpump;
+	int tasks = 1;
 
-	debug_sprintf_event(paidbg, 5, "%s users %d refcnt %u\n",
-			    __func__, cpump->active_events,
-			    refcount_read(&cpump->refcnt));
-	if (refcount_dec_and_test(&cpump->refcnt))
+	/* Check reference count and return when all gone.
+	 * 1. An event is installed on online CPU X.
+	 * 2. CPU x is offlined and the per-CPU data is removed.
+	 * 3. Event is destroyed via close system call.
+	 */
+	if (!refcount_read(&pai_root[idx].refcnt))
+		return;			/* No events at all */
+	mp = per_cpu_ptr(pai_root[idx].mapptr, cpu);
+	if (!mp || !mp->mapptr)		/* No events on that CPU */
+		return;
+
+	/* When hotplug is true, invocation is from CPU hotplug callback.
+	 * Delete per-CPU resource and adjust refcnt when per-task events
+	 * are currently active. This can be more than one.
+	 * In this case adjust counters.
+	 */
+	if (hotplug)
+		tasks = atomic_read(&pai_root[idx].tskctx);
+
+	cpump = mp->mapptr;
+	if (refcount_sub_and_test(tasks, &cpump->refcnt))
 		pai_free(mp);
-	pai_root_free(idx);
+	pai_root_free(idx, tasks);
 }
 
 static void pai_event_destroy(struct perf_event *event)
@@ -158,17 +176,17 @@ static void pai_event_destroy(struct perf_event *event)
 	int cpu = 0, idx = PAI_PMU_IDX(event);
 
 	free_page(PAI_SAVE_AREA(event));
+	cpus_read_lock();
 	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu == -1) {
-		struct cpumask *mask = PAI_CPU_MASK(event);
-
-		for_each_cpu(cpu, mask)
-			pai_event_destroy_cpu(idx, cpu);
-		kfree(mask);
+		atomic_dec(&pai_root[idx].tskctx);
+		for_each_online_cpu(cpu)
+			pai_event_destroy_cpu(idx, cpu, false);
 	} else {
-		pai_event_destroy_cpu(idx, event->cpu);
+		pai_event_destroy_cpu(idx, event->cpu, false);
 	}
 	mutex_unlock(&pai_reserve_mutex);
+	cpus_read_unlock();
 }
 
 static void paicrypt_event_destroy(struct perf_event *event)
@@ -232,17 +250,25 @@ static u64 paicrypt_getall(struct perf_event *event)
 	return sum;
 }
 
-/* Allocate all per-CPU data structures. This function is called in
- * process context and can block. In case of error all partly allocated
- * memory is released and the reference counters adjusted correctly.
- * Called under mutex_lock.
- */
-static int pai_alloc_cpu(int idx, int cpu)
+/* Called under mutex_lock */
+static int pai_alloc_cpu(int idx, int cpu, bool hotplug)
 {
 	struct pai_map *cpump = NULL;
 	bool need_paiext_cb = false;
 	struct pai_mapptr *mp;
-	int rc;
+	int tasks = 1, rc = 0;
+
+	/* When hotplug is true, invocation is from CPU hotplug callback.
+	 * Allocate per-CPU resource when per-task events are currently active.
+	 * This can be more than one. In this case adjust all reference
+	 * counters. Otherwise return, this ensures memory is only allocated
+	 * when needed.
+	 */
+	if (hotplug) {
+		tasks = atomic_read(&pai_root[idx].tskctx);
+		if (!tasks)
+			goto out;
+	}
 
 	/* Allocate root node */
 	rc = pai_root_alloc(idx);
@@ -291,26 +317,42 @@ static int pai_alloc_cpu(int idx, int cpu)
 			goto undo;
 		}
 		INIT_LIST_HEAD(&cpump->syswide_list);
-		refcount_set(&cpump->refcnt, 1);
+		refcount_set(&cpump->refcnt, tasks);
 		rc = 0;
 	} else {
-		refcount_inc(&cpump->refcnt);
+		refcount_add(tasks, &cpump->refcnt);
 	}
+	/* If tasks is greater than 1, we are called from CPU hotplug path
+	 * and need to adjust the pai_root[idx].refcnt by the number of
+	 * per-process events. Function pai_root_alloc(idx) already
+	 * incremented by one. Adjust for the rest.
+	 */
+	if (tasks > 1)
+		refcount_add(tasks - 1, &pai_root[idx].refcnt);
 
 undo:
 	if (rc) {
 		/* Error in allocation of event, decrement anchor. Since
 		 * the event in not created, its destroy() function is never
 		 * invoked. Adjust the reference counter for the anchor.
+		 * The failure happened in the case of variable
+		 * cpump == NULL branch above. The pai_root[XXX].refcnt has
+		 * been incremented by one. Then the per-CPU allocation
+		 * failed, so decrement it by one, regardless of tasks.
 		 */
-		pai_root_free(idx);
+		pai_root_free(idx, 1);
 	}
 out:
 	/* If rc is non-zero, no increment of counter/sampler was done. */
 	return rc;
 }
 
-/* Called under mutex_lock */
+/* Check concurrent access of counting and sampling for PAI events.
+ * This function is called in process context and it is safe to block.
+ * When the event initialization functions fails, no other call back will
+ * be invoked.
+ * Called under mutex_lock.
+ */
 static int pai_alloc(struct perf_event *event)
 {
 	int idx = PAI_PMU_IDX(event);
@@ -322,24 +364,20 @@ static int pai_alloc(struct perf_event *event)
 		goto out;
 
 	for_each_online_cpu(cpu) {
-		rc = pai_alloc_cpu(idx, cpu);
+		rc = pai_alloc_cpu(idx, cpu, false);
 		if (rc) {
 			for_each_cpu(cpu, maskptr)
-				pai_event_destroy_cpu(idx, cpu);
-			kfree(maskptr);
-			goto out;
+				pai_event_destroy_cpu(idx, cpu, false);
+			goto undo;
 		}
 		cpumask_set_cpu(cpu, maskptr);
 	}
 
-	/*
-	 * On error all cpumask are freed and all events have been destroyed.
-	 * Save of which CPUs data structures have been allocated for.
-	 * Release them in pai_event_destroy call back function
-	 * for this event.
-	 */
-	PAI_CPU_MASK(event) = maskptr;
 	rc = 0;
+	/* Trace per-task events for CPU hotplug. */
+	atomic_inc(&pai_root[idx].tskctx);
+undo:
+	kfree(maskptr);
 out:
 	return rc;
 }
@@ -387,12 +425,14 @@ static int pai_event_init(struct perf_event *event, int idx)
 		}
 	}
 
+	cpus_read_lock();
 	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu >= 0)
-		rc = pai_alloc_cpu(idx, event->cpu);
+		rc = pai_alloc_cpu(idx, event->cpu, false);
 	else
 		rc = pai_alloc(event);
 	mutex_unlock(&pai_reserve_mutex);
+	cpus_read_unlock();
 	if (rc) {
 		free_page(PAI_SAVE_AREA(event));
 		goto out;
@@ -1216,8 +1256,34 @@ static int __init paipmu_setup(void)
 	return install_ok;
 }
 
+static int pai_online_cpu(unsigned int cpu)
+{
+	int rc;
+
+	mutex_lock(&pai_reserve_mutex);
+	rc = pai_alloc_cpu(PAI_PMU_CRYPTO, cpu, true);
+	if (!rc) {
+		rc = pai_alloc_cpu(PAI_PMU_EXT, cpu, true);
+		if (rc)
+			pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
+	}
+	mutex_unlock(&pai_reserve_mutex);
+	return rc;
+}
+
+static int pai_offline_cpu(unsigned int cpu)
+{
+	mutex_lock(&pai_reserve_mutex);
+	pai_event_destroy_cpu(PAI_PMU_CRYPTO, cpu, true);
+	pai_event_destroy_cpu(PAI_PMU_EXT, cpu, true);
+	mutex_unlock(&pai_reserve_mutex);
+	return 0;
+}
+
 static int __init pai_init(void)
 {
+	int rc;
+
 	/* Setup s390dbf facility */
 	paidbg = debug_register("pai", 32, 256, 128);
 	if (!paidbg) {
@@ -1226,7 +1292,17 @@ static int __init pai_init(void)
 	}
 	debug_register_view(paidbg, &debug_sprintf_view);
 
+	/* CPUHP_BP_PREPARE_DYN --> before CPU is brought online */
+	rc = cpuhp_setup_state(CPUHP_BP_PREPARE_DYN, "perf/pai:prepare",
+			       pai_online_cpu, pai_offline_cpu);
+	if (rc < 0) {
+		debug_unregister_view(paidbg, &debug_sprintf_view);
+		debug_unregister(paidbg);
+		return rc;
+	}
+
 	if (!paipmu_setup()) {
+		cpuhp_remove_state(rc);
 		/* No PMU registration, no need for debug buffer */
 		debug_unregister_view(paidbg, &debug_sprintf_view);
 		debug_unregister(paidbg);
-- 
2.55.0

