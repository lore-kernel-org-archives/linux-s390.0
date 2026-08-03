Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63EED38238F
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 16:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785773832; cv=none; b=SAwpVXYDVJ7xj3yK2vgUtjaHGw0Nbs71fW+Xe2kEFKQnVkZlGatWyCUQ+N0H/b5ax7mh0qjjgkqLI4GksQUhRFsQHO0ZyDJmz8XXVJ4nUu4i/iWS/POpCOeLmkbNbzWXMX0T8xgA4cnma5C+wzcQn0K8jpvkijNcbtTJf+0vbAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785773832; c=relaxed/simple;
	bh=J4ztnOqEi3beDP0VFnS9QFSPbrGPM5ApFebn2EQNLZU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=drzXapU0Fp+WaSD+fXqtongPe9hB5jRk70OYwc+7knPfHohCQGbcO+iYabHHRSO4K4Rnpv4/4GiEhX0QtiBtJ+SnPBJ7pC+q+Y0sfOefSU6oVUO87w1+TTVtlJjOFZq/ql2H3fdJNPz0zrSDA3Y47lM/RoLn9Ki47D8Nv6Z22qQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Nr+aiWd4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Nr+aiWd4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 673EHgAN2201771
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 16:17:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IefIXjyEgVo1fjO6xhmHX0BuHBMZJ2ZZMugKgssZr
	es=; b=Nr+aiWd44B0JFP7v0tYATRK693ZHUVF/96/5zL7YUI5eKG786WXnyquzg
	cNRWlBX3/NDPVir91tIWFqWMlB+h59PxB+jpX6neukD7yVJN9yCR2XCPL2MlKSp8
	tZe+8Pu0qASBNDcAmXCBLLuI7idkSJx/LWE7RuXzfAbxivJJ6ZiLu1vex7WR8yuE
	2RgtIsTbz0/lepPdQeFNf7gxigxdJY2tbt9jhokKo6p/Mvar4JeTT1nE4CBJ4ARh
	p2uLpg9dNm7bYUPOVJTkgyrbjAwYfDaP9f3gbOe8bcSPeZsrpXd5W5cIC5X3vwsY
	A3dpkbDAEh6Rx5cbaqPtNsEfW/DkQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hhpyk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 16:17:09 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 673FuPg2007006
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 16:17:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmh64xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 16:17:08 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 673GH4vn49873372
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 16:17:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CB0920043;
	Mon,  3 Aug 2026 16:17:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 514E620040;
	Mon,  3 Aug 2026 16:17:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 16:17:04 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org
Cc: Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete 6
Date: Mon,  3 Aug 2026 18:16:51 +0200
Message-ID: <20260803161651.3803702-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfX6ZhRTvVQHsGf
 26PmrLzCwIXgeF3wexwoZ+/1H1Bmhmo4Ib5C/zwra65vgT8tDJ50PExY28UQoTM0tQRO3+mEjC8
 4q+1YxQclkwvKPsVg54GgkD6J9TmOAU=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a70bf05 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=4x2RLCj_3cs3CYK3Y9YA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDE0MSBTYWx0ZWRfXx7Pt32GP6XUZ
 MZhszy8o+id7cetX6WInN36QaUqCBDvdbRZg3KlaOI9pP3tycyWU0IcmCk8T0SwH35AYSifwzkA
 KB5S+8P2QW6IGJQxMRGIsFghZalNzLJeKGhXPEXJM8qE7M/6n40bod0sgCuF5AC4Oo5gzorgAOO
 E8GNh7/F+P3RYFr5jeIWBWGu832WygAYc2mkxXwEG81B8MzKlu3cmZwnpXuDS5tMQAUSS3UgZFX
 XXgPnaoQkY9bnCDNogxoo32pXybWwCkoIDFje4OUnXjP7TzhK0Kiz63aU+znCUjd0xdsJ9pzof0
 oVYUuDDHOvz6Ort4hRb5/yFSLxJCsqugDx41Ar28kVH3iq50rRGlxGAe3/ceJS4P1DgQkwMXFUS
 IkKw/g6+w+gu3rUVA80uRHzPM6OfmzFUSOz70Rg46yeHbyn7cEkqqMyD7c/dR/anAFDfO6gRUIR
 l5dgUR/oH01QGUKADbQ==
X-Proofpoint-ORIG-GUID: y2IS1-3ZuI9lhZZm2PCKCTnV_qPa8qqD
X-Proofpoint-GUID: y2IS1-3ZuI9lhZZm2PCKCTnV_qPa8qqD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-03_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030141

V4: Addressed comments from Sumanth
    Fixed typos
    Reworked mutex locking to avoid race

V3: Implements Heiko's option 3
    Count per-task processes and only install CPUMF per-CPU
    infratructure when a per-task process is running during
    CPU hot plug add.

The command 'perf stat -e cycles -- <command> crashes the kernel
when CPUs are hotplug added during that run.

Root cause is the allocation of struct cpu_cf_events at first
event initialization. The allocation is dynamic and the first
event that has task context creates such a structure for
each online CPU. This is not sufficient. CPUs may be offline
during event creation and can be set online during the
perf run time. For example commands

 # echo 0 > /sys/devices/system/cpu/cpu1/online
 # perf stat -e cycles -i -- stress-ng -t10s --matrix X
 # sleep 1
 # echo 1 > /sys/devices/system/cpu/cpu1/online

create an event for CPUs 0,2-X. Since the events are created with
task-context, the scheduler will eventually schedule the program
on CPU1. This CPU has not created and initialized any per
CPU event infrastructure as that CPU was not online at the time
of the perf invocation. Thus when the scheduler runs stress-ng
on CPU1, the function cpumf_pmu_add() refers to a NULL pointer:

 struct cpu_cf_events *cpuhw = this_cpu_cfhw();

This function call is invoked after the task stress-ng has been
made runnable on CPU1. And this_cpu_cfhw() returns NULL.

The result is a panic:
[1148608.961663] Unable to handle kernel pointer dereference in virtual kernel address space
[1148608.961677] Failing address: 0000000000000000 TEID: 0000000000000483
[1148608.961679] Fault in home space mode while using kernel ASCE.
[1148608.961683] AS:000000ff318dc007 R3:000000fffd5a8007 S:000000fffd5a7801 P:000000000000013d
[1148608.961733] Oops: 0004 ilc:3 [#1]SMP
[1148608.961738] Modules linked in: nf_tables ib_core vhost_net vhost
                 ....
[1148608.961797] Hardware name: IBM 9175 ML1 400 (LPAR)
[1148608.961799] Krnl PSW : 0404d00180000000 000003ef8291fd0c (cpumf_pmu_add+0x3c/0x80)
[1148608.961813]            R:0 T:1 IO:0 EX:0 Key:0 M:1 W:0 P:0 AS:3 CC:1 PM:0 RI:0 EA:3
[1148608.961816] Krnl GPRS: 0000000000000026 0000000000040000 0000000000000000 0000000000000004
[1148608.961818]            0000000000000130 fffffd105615b000 0000000000000000 0000000085324300
[1148608.961820]            0000000000000000 00000000857edc80 0000000000000001 0000000290090000
[1148608.961821]            000003ff9ad094c0 0000000290090000 000003ef8291fcfa 0000036f86ccb3e0
[1148608.961830] Krnl Code: 000003ef8291fcfa: e330b1880004      lg      %r3,392(%r11)
           000003ef8291fd00: e31020180004       lg      %r1,24(%r2)
          #000003ef8291fd06: ec13002f1056       rosbg   %r1,%r3,0,47,16
          >000003ef8291fd0c: e31020180024       stg     %r1,24(%r2)
           000003ef8291fd12: e54cb1f00003       mvhi    496(%r11),3
           000003ef8291fd18: a7a10001           tmll    %r10,1
           000003ef8291fd1c: a774000a           brc     7,000003ef8291fd30
           000003ef8291fd20: a7290000           lghi    %r2,0
[1148608.961880] Call Trace:
[1148608.961881]  [<000003ef8291fd0c>] cpumf_pmu_add+0x3c/0x80
[1148608.961885]  [<000003ef82bb5e3e>] event_sched_in+0xae/0x190
[1148608.961890]  [<000003ef82bb60d6>] merge_sched_in+0x1b6/0x390
[1148608.961892]  [<000003ef82bb65b8>] visit_groups_merge.constprop.0.isra.0+0x308/0x5b0
[1148608.961894]  [<000003ef82bb689a>] pmu_groups_sched_in+0x3a/0x50
[1148608.961896]  [<000003ef82bb6a30>] ctx_sched_in+0x180/0x260
[1148608.961898]  [<000003ef82bb780c>] perf_event_context_sched_in+0x11c/0x2d0
[1148608.961900]  [<000003ef82bb79ee>] __perf_event_task_sched_in+0x2e/0xc0
[1148608.961902]  [<000003ef82994834>] finish_task_switch.isra.0+0x1a4/0x250
[1148608.961907]  [<000003ef8340b5e6>] __schedule+0x376/0x750
[1148608.961914]  [<000003ef8340b9fe>] schedule+0x3e/0xd0
[1148608.961916]  [<000003ef83412ca2>] schedule_hrtimeout_range_clock+0xc2/0x110
[1148608.961919]  [<000003ef82d0d36c>] poll_schedule_timeout.constprop.0+0x5c/0xb0
[1148608.961926]  [<000003ef82d0e276>] do_poll+0x286/0x3b0
[1148608.961928]  [<000003ef82d0e5a8>] do_sys_poll+0x208/0x2f0
[1148608.961931]  [<000003ef82d0f230>] __s390x_sys_poll+0xe0/0x160
[1148608.961934]  [<000003ef83408028>] __do_syscall+0x168/0x290
[1148608.961936]  [<000003ef83413754>] system_call+0x74/0x98
[1148608.961938] Last Breaking-Event-Address:
[1148608.961939]  [<000003ef8291f1d8>] this_cpu_cfhw+0x38/0x40
[1148608.961943] Kernel panic - not syncing: Fatal exception: panic_on_oops

The issue arises only in per-task context when the CPUMF facility is
used and the scheduler picks a random CPU for such a process to run on.
The scheduler enables the CPUMF infrastructure via PMU callback
functions pmu::add() and pmu::del().
Now count all per-task processes currently running and active.
When a CPU is hotplug added, check for running per-task context
processes. If one or more are active, install the CPUMF instructure
on that new CPU.  This ensures the intrastructure is available when
new CPU is selected to run the per-task context process.

Fixes: 9b9cf3c77e7e ("s390/cpum_cf: rework PER_CPU_DEFINE of struct cpu_cf_events")
Cc: <Stable@vger.kernel.org> # v6.10+
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 86 ++++++++++++++++++++++-----------
 1 file changed, 58 insertions(+), 28 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 2076ac22e2c4..c94334a4cfc4 100644
--- a/arch/s390/kernel/perf_cpum_cf.c
+++ b/arch/s390/kernel/perf_cpum_cf.c
@@ -110,6 +110,7 @@ struct cpu_cf_ptr {
 
 static struct cpu_cf_root {		/* Anchor to per CPU data */
 	refcount_t refcnt;		/* Overall active events */
+	atomic_t tskcnt;		/* Number task-context users */
 	struct cpu_cf_ptr __percpu *cfptr;
 } cpu_cf_root;
 
@@ -175,9 +176,9 @@ static void cpum_cf_free_root(void)
 	cpu_cf_root.cfptr = NULL;
 	irq_subclass_unregister(IRQ_SUBCLASS_MEASUREMENT_ALERT);
 	on_each_cpu(cpum_cf_reset_cpu, NULL, 1);
-	debug_sprintf_event(cf_dbg, 4, "%s root.refcnt %u cfptr %d\n",
+	debug_sprintf_event(cf_dbg, 4, "%s root.refcnt %u cfptr %d tskcnt %d\n",
 			    __func__, refcount_read(&cpu_cf_root.refcnt),
-			    !cpu_cf_root.cfptr);
+			    !cpu_cf_root.cfptr, atomic_read(&cpu_cf_root.tskcnt));
 }
 
 /*
@@ -212,14 +213,13 @@ static void cpum_cf_free_cpu(int cpu)
 	struct cpu_cf_events *cpuhw;
 	struct cpu_cf_ptr *p;
 
-	mutex_lock(&pmc_reserve_mutex);
 	/*
 	 * When invoked via CPU hotplug handler, there might be no events
 	 * installed or that particular CPU might not have an
 	 * event installed. This anchor pointer can be NULL!
 	 */
 	if (!cpu_cf_root.cfptr)
-		goto out;
+		return;
 	p = per_cpu_ptr(cpu_cf_root.cfptr, cpu);
 	cpuhw = p->cpucf;
 	/*
@@ -227,15 +227,13 @@ static void cpum_cf_free_cpu(int cpu)
 	 * installed on that CPU, but on different CPUs.
 	 */
 	if (!cpuhw)
-		goto out;
+		return;
 
 	if (refcount_dec_and_test(&cpuhw->refcnt)) {
 		kfree(cpuhw);
 		p->cpucf = NULL;
 	}
 	cpum_cf_free_root();
-out:
-	mutex_unlock(&pmc_reserve_mutex);
 }
 
 /* Allocate CPU counter data structure for a PMU. Called under mutex lock. */
@@ -245,7 +243,6 @@ static int cpum_cf_alloc_cpu(int cpu)
 	struct cpu_cf_ptr *p;
 	int rc;
 
-	mutex_lock(&pmc_reserve_mutex);
 	rc = cpum_cf_alloc_root();
 	if (rc)
 		goto unlock;
@@ -272,7 +269,6 @@ static int cpum_cf_alloc_cpu(int cpu)
 		cpum_cf_free_root();
 	}
 unlock:
-	mutex_unlock(&pmc_reserve_mutex);
 	return rc;
 }
 
@@ -290,9 +286,12 @@ static int cpum_cf_alloc(int cpu)
 	cpumask_var_t mask;
 	int rc;
 
+	mutex_lock(&pmc_reserve_mutex);
 	if (cpu == -1) {
-		if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
-			return -ENOMEM;
+		if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+			rc = -ENOMEM;
+			goto out;
+		}
 		for_each_online_cpu(cpu) {
 			rc = cpum_cf_alloc_cpu(cpu);
 			if (rc) {
@@ -303,20 +302,27 @@ static int cpum_cf_alloc(int cpu)
 			cpumask_set_cpu(cpu, mask);
 		}
 		free_cpumask_var(mask);
+		if (!rc)
+			atomic_inc(&cpu_cf_root.tskcnt);
 	} else {
 		rc = cpum_cf_alloc_cpu(cpu);
 	}
+out:
+	mutex_unlock(&pmc_reserve_mutex);
 	return rc;
 }
 
 static void cpum_cf_free(int cpu)
 {
+	mutex_lock(&pmc_reserve_mutex);
 	if (cpu == -1) {
 		for_each_online_cpu(cpu)
 			cpum_cf_free_cpu(cpu);
+		atomic_dec(&cpu_cf_root.tskcnt);
 	} else {
 		cpum_cf_free_cpu(cpu);
 	}
+	mutex_unlock(&pmc_reserve_mutex);
 }
 
 #define	CF_DIAG_CTRSET_DEF		0xfeef	/* Counter set header mark */
@@ -924,6 +930,11 @@ static void cpumf_pmu_start(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int i;
 
+	/* Might be zero when a per-task context event is active. Happens
+	 * when CPUs are made offline and process migration takes place.
+	 */
+	if (!cpuhw)
+		return;
 	if (!(hwc->state & PERF_HES_STOPPED))
 		return;
 
@@ -992,6 +1003,12 @@ static void cpumf_pmu_stop(struct perf_event *event, int flags)
 	struct hw_perf_event *hwc = &event->hw;
 	int i;
 
+	/* Might be zero when a per-task context event is active. Happens
+	 * when CPUs are made offline and process migration takes place.
+	 */
+	if (!cpuhw)
+		return;
+
 	if (!(hwc->state & PERF_HES_STOPPED)) {
 		/* Decrement reference count for this counter set and if this
 		 * is the last used counter in the set, clear activation
@@ -1026,6 +1043,11 @@ static int cpumf_pmu_add(struct perf_event *event, int flags)
 {
 	struct cpu_cf_events *cpuhw = this_cpu_cfhw();
 
+	/* Might be zero when a per-task context event is active. Happens
+	 * when CPUs are made offline and process migration takes place.
+	 */
+	if (!cpuhw)
+		return -ENODEV;
 	ctr_set_enable(&cpuhw->state, event->hw.config_base);
 	event->hw.state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
@@ -1040,6 +1062,11 @@ static void cpumf_pmu_del(struct perf_event *event, int flags)
 	struct cpu_cf_events *cpuhw = this_cpu_cfhw();
 	int i;
 
+	/* Might be zero when a per-task context event is active. Happens
+	 * when CPUs are made offline and process migration takes place.
+	 */
+	if (!cpuhw)
+		return;
 	cpumf_pmu_stop(event, PERF_EF_UPDATE);
 
 	/* Check if any counter in the counter set is still used.  If not used,
@@ -1090,14 +1117,18 @@ static refcount_t cfset_opencnt = REFCOUNT_INIT(0);	/* Access count */
 static DEFINE_MUTEX(cfset_ctrset_mutex);
 
 /*
- * CPU hotplug handles only /dev/hwctr device.
- * For perf_event_open() the CPU hotplug handling is done on kernel common
- * code:
- * - CPU add: Nothing is done since a file descriptor can not be created
- *   and returned to the user.
- * - CPU delete: Handled by common code via pmu_disable(), pmu_stop() and
- *   pmu_delete(). The event itself is removed when the file descriptor is
- *   closed.
+ * CPU hotplug handles /dev/hwctr device.
+ *
+ * For perf_event_open() the CPU hotplug handler needs to check the number
+ * of per-task context events currently active. A per-task context event
+ * needs per-CPU data structures. The scheduler might schedule the task on
+ * the new CPU and then the CPUMF per-CPU infrastructure must be available.
+ * Common code relies on that and calls cpum_cf_add(), cpum_cf_start(),
+ * cpum_cf_stop() and cpum_cf_del() to install PMU backend functions on
+ * the new CPU.
+ *
+ * If no per-task context event has been installed, the events are per-CPU
+ * and do not care about a new CPU.
  */
 static int cfset_online_cpu(unsigned int cpu);
 
@@ -1105,13 +1136,13 @@ static int cpum_cf_online_cpu(unsigned int cpu)
 {
 	int rc = 0;
 
-	/*
-	 * Ignore notification for perf_event_open().
-	 * Handle only /dev/hwctr device sessions.
-	 */
 	mutex_lock(&cfset_ctrset_mutex);
-	if (refcount_read(&cfset_opencnt)) {
+	/* Allocate per-CPU infrastructure when per-task context active. */
+	mutex_lock(&pmc_reserve_mutex);
+	if (atomic_read(&cpu_cf_root.tskcnt))
 		rc = cpum_cf_alloc_cpu(cpu);
+	mutex_unlock(&pmc_reserve_mutex);
+	if (refcount_read(&cfset_opencnt)) {
 		if (!rc)
 			cfset_online_cpu(cpu);
 	}
@@ -1130,13 +1161,12 @@ static int cpum_cf_offline_cpu(unsigned int cpu)
 	 * perf_event_open() created events. Perf common code triggers event
 	 * destruction when the event file descriptor is closed.
 	 *
-	 * Handle only /dev/hwctr device sessions.
+	 * Handle /dev/hwctr device sessions.
 	 */
 	mutex_lock(&cfset_ctrset_mutex);
-	if (refcount_read(&cfset_opencnt)) {
+	if (refcount_read(&cfset_opencnt))
 		cfset_offline_cpu(cpu);
-		cpum_cf_free_cpu(cpu);
-	}
+	cpum_cf_free(cpu);
 	mutex_unlock(&cfset_ctrset_mutex);
 	return 0;
 }
-- 
2.55.0

