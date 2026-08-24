Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F63B3EDE6E
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787574205; cv=none; b=NX/atPgjxL3LLyPldL/YBsgzuGAieNRWjetYYvKIwoqogiK/L4MZklrzHIGlWLVOlXJdRrilRiQbSSMc10WOY8o1dVpMhTgGYPOfNbS8bcgDlQ1p8S2rEfutqWYKTV3O214qBhOlT7JDxcF3WNMMSAd04Zx8tvdASJGsJD4HpTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787574205; c=relaxed/simple;
	bh=N2fTZ2IfGJXTbzL5uHXDrKlZhW2BzbIkgTYs9ttup68=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ame/JHqM8ymDmZXZLytwjaYRKs/6nm4+5HtFAR3jCplnmvpC+eqIndqZbndKj/GI+iof0FH2enEa8ti7DwfB5ja26qVQRHgS7MDcF4tAjQa8aAiKRtVBs6Pk+zhJR5mpcs0IJbPgv0g5Ra5+OuJbLL9zy+jPHK7U/hmct4YvsAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MvctBRKw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MvctBRKw"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OBVXVm622863
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=NyMUimfTfgYmWD7hB
	vZAaJC49VcyJDnU3cdESdYY8u0=; b=MvctBRKwyj5CwbInGf2vSLmeCmIq/gcPN
	9wBmPSXjMDbDD+QARCOd/qzLaiLs3C6onY901K95YWwR/SupkJ5HNRLEw0u7yJfz
	GqtQVQ1UtMVt6d8cALI24zAVluFWs3MY2NfP+z9MbXuZP9yvvwVhgADeiDBKpNdH
	Co/IPwWb702kBtqtBQQmo4WIKhKUtzBoDWPoKPFtEoEGeP8hVWKFLfy5mTXBLAVO
	CMGVH30jhbFAr8RHarnnJ5arqstQc1qFxOF4jNuG7XRS9rtScJa5y0AR9Gdk9EJS
	aDS7QyzVgciWrLWbtFBkrWr9WQthTegzI3+Tk0ZCp/lQWwreB7EQg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e97h6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:22 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OCBK2x022532
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:21 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rag5m7u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 12:23:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OCNHpE45351348
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 12:23:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 827A92004B;
	Mon, 24 Aug 2026 12:23:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6525420043;
	Mon, 24 Aug 2026 12:23:17 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 12:23:17 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH 3/3 v2] s390/pai: Support CPU hotplug for PMU PAI
Date: Mon, 24 Aug 2026 14:23:07 +0200
Message-ID: <20260824122307.86133-4-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260824122307.86133-1-tmricht@linux.ibm.com>
References: <20260824122307.86133-1-tmricht@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c37ba cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=mC-QHw0Mver6cWnVaskA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfX8kDWXRCc2xbr
 AWlYsC8EUN+zszK8ojHZSEx1oD2h4E2zDjQDw8YdQsSpwKGlFLQnEZ3QjnGuT4Ue6RXRQBF6zg9
 Bv3Jtk7wMeJJrBu5mr4kB0QC6vpAHsk=
X-Proofpoint-GUID: LEWzTZ34eoH3PgXqV-y6IRmIb-WtW8KS
X-Proofpoint-ORIG-GUID: LEWzTZ34eoH3PgXqV-y6IRmIb-WtW8KS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEwMSBTYWx0ZWRfX9V7x633OL1o5
 bdjBLdZIM06urcm3HWcDgOejI6LaJo7x+fc7CnXnRHS5JY/LG1mLAS4YiA1i1+g1caP990x6sPw
 LuB5oBYRfhfe3OVs8y+3x02+ZV3tZeQBbIHwV1L6ECkeeSQS4+dJzw2MH2Cl3Pn1gn4Cs4+NlZZ
 JQHMhVy+vY0HD6IOf7Zy7IaiWNy2957l/FHHWc1PiOrcV7zdjPF38jxTOAheR4ZXwfOt1QkGuaA
 LNcfPKK+YK0p7lxwbmB5uViIaNcq+4dwzBiR01FsF09jN5f2wt0f/IM1AkIohhcCQR0Llz1MnT0
 nh2T+ah8j9qnFQ2UkqLYzZiuCpo32/F8hcLuCCzSe40/jpxDGH/r8n5HiDh/kkqCjhIsoQfM7vT
 NXchyaJG9y7Wbpd/odhQ16fzr1nl8pRJnTqVUw6mQWl9XYNbjjWrLh2GLBzJCLnYiibyTUzqI3X
 FYdHWXIH2b/bd+ZTS2A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_03,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240101

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
are available when CPU is made online and tasks are schedules on it.

 #Cc: stable@vger.kernel.org # v6.19
Fixes: 582cc1b28e8c ("s390/pai_ext: Enable per-task and system-wide sampling event")
Fixes: 9f66572f2889 ("s390/pai_crypto: Enable per-task and system-wide sampling event")
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/include/asm/pai.h |   1 -
 arch/s390/kernel/perf_pai.c | 160 ++++++++++++++++++++++++++----------
 2 files changed, 116 insertions(+), 45 deletions(-)

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
index 52d9f654346a..04a9dafa8f37 100644
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
@@ -160,13 +178,11 @@ static void pai_event_destroy(struct perf_event *event)
 	free_page(PAI_SAVE_AREA(event));
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
 }
@@ -232,17 +248,25 @@ static u64 paicrypt_getall(struct perf_event *event)
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
@@ -291,26 +315,42 @@ static int pai_alloc_cpu(int idx, int cpu)
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
+ * This function is called in process context and it is save to block.
+ * When the event initialization functions fails, no other call back will
+ * be invoked.
+ * Called under mutex_lock.
+ */
 static int pai_alloc(struct perf_event *event)
 {
 	int idx = PAI_PMU_IDX(event);
@@ -322,24 +362,20 @@ static int pai_alloc(struct perf_event *event)
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
@@ -389,7 +425,7 @@ static int pai_event_init(struct perf_event *event, int idx)
 
 	mutex_lock(&pai_reserve_mutex);
 	if (event->cpu >= 0)
-		rc = pai_alloc_cpu(idx, event->cpu);
+		rc = pai_alloc_cpu(idx, event->cpu, false);
 	else
 		rc = pai_alloc(event);
 	mutex_unlock(&pai_reserve_mutex);
@@ -1216,8 +1252,34 @@ static int __init paipmu_setup(void)
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
@@ -1226,7 +1288,17 @@ static int __init pai_init(void)
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

