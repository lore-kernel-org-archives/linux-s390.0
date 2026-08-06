Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C6C9327BEC
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 13:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786021927; cv=none; b=K0VsrRK8lnvNKloJstu5hqkQxSDRZI8jwIMWgA2O+6/td38jGv84KeZKbReMMHdPhaNay58NMW4CHhBpJkQ9qR7Rx409bs6insEBvpRhfV7WQfhvI12ayKoQbDKsSoT8wvySNrHVOTbMzmtqFDejdd4+xR+ay/pUIa+nQ8xAgLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786021927; c=relaxed/simple;
	bh=9e7Hn85fc9roHIayP0fzw95sieTpvzrxwOhwXjg4j/U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jUY2OUIK+RPxOoM8euQub76EBmS8EH7r21pUnQgmMlomk0t88oyhGXPEsu7Tt7Tq0sS6ui9BUTZbBc/7kfgXE++PIQfNgcrLziB2NL3Td4oRUOzTdmeQ34c1TyuJe/b2UASys2RU0M47Qwu5ptALRwXEfXZzpLKDUw4iLrdNIMk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=g5Zm9xXm; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="g5Zm9xXm"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NldHq1092726
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 13:12:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=7+jr96D1bONuuV9DfktQ9m3c/mtxUni14nvkJAsW8
	Z0=; b=g5Zm9xXmkmCdpbKJCmisDbN2EvgRwsxl1jFm9ICIZCB+kU2cpZNZXnvHz
	vPVvSXT0J7ft/3iy8WHUi4fNupJ/kUsnd5ObRVytqevH0RPcmeeARPIa6+Pjzll9
	iocftrfF69VIWRKrLrKyhKsUzLF7tBYNK3hCCHB2qFpEie6NZOctNeeQi7UnQH1N
	O9NjRDAYx1Mtn2hlYARDTZloHaoK54RwZBBXWs5vFdfFTJPgVhYnbY6/SS3Pzuy8
	L9lkasL5ox4nI7rYrm+9pIif0H7bqB3q2ocMniTsVlnENa7vzda71/pMVhElDfeU
	ghYOuhcO1O8fuuX4XYo4kJm0WYDpg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h58bm6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 13:12:00 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676CuKDC022034
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 13:11:59 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhk66a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 13:11:59 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676DBtqU30474520
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 13:11:55 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 790212005A;
	Thu,  6 Aug 2026 13:11:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F9972004E;
	Thu,  6 Aug 2026 13:11:55 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 13:11:55 +0000 (GMT)
From: Thomas Richter <tmricht@linux.ibm.com>
To: linux-s390@vger.kernel.org, sumanthk@linux.ibm.com, japo@linux.ibm.com
Cc: agordeev@linux.ibm.com, iii@linux.ibm.com, hca@linux.ibm.com,
        Thomas Richter <tmricht@linux.ibm.com>
Subject: [PATCH] s390/cpum_cf: Handle CPU hotplug add and delete
Date: Thu,  6 Aug 2026 15:11:31 +0200
Message-ID: <20260806131131.2073914-1-tmricht@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX98ddOF7oK806
 jsA5EZJ7oiURKEWGvMWm4Sqpe2tAy8a9lcidxir3jANCV2bcwmA3+yWLOdF+0XQQcYdQGX8ZTHw
 XEZKSyQvCpjnAWxsUSQ6xidYYrfu+uw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDEwMSBTYWx0ZWRfX9dEFX61fCeD/
 FE3TN5gJj3q/vUvQb93n/H26hyBhch3Hub9KYgfFMfIPF+6ETgZXl72uYrydraNQ/qCprTqMxE9
 iorFlSt4vImHtklQ76xo9ihOpse32IMXh30s2Ur+KJAS8qEEajjFP+Gnd4NLteXhqaMk9pcvf3o
 YPrF7SPfg1HPrzsRbr35HjlgkAUUeBkcHWDuF4zF2R5d4pb5b7NG+csYbWGNLMZ7EcBbO7exj59
 JJ5sdAkP2A+OFV81L4RpyPFvRowK1E7lLG688MrIUg1Pf/zAVzJ7ZADrpqz7oI7a496XnZ4piVQ
 fuUUduGa9saIuYpYYioeMozvELigKRdd1IRhmA2RkjAnsaqZwwBIgccfPHqQI/rRdzPKsdBQ/E1
 Hdrskm/jCzc9z5HaWA79c6pLxjPcZljGnRUC4ohurb3y246F0W5M9j6xRdCTV3wM9aAYq5YgUdN
 es6zCrLbvJBqKIU6MJA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a748820 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=1mKDHp9e9Q62Odc2JB4A:9
X-Proofpoint-ORIG-GUID: AoQt3wDNcPfAUwVkcsE98FT-DjhVCesl
X-Proofpoint-GUID: AoQt3wDNcPfAUwVkcsE98FT-DjhVCesl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060101

The command 'perf stat -e cycles -- <command>' crashes the kernel
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
processes. If one or more are active, install the CPUMF infrastructure
on that new CPU.  This ensures the infrastructure is available when
new CPU is selected to run the per-task context process.

Fixes: 9b9cf3c77e7e ("s390/cpum_cf: rework PER_CPU_DEFINE of struct cpu_cf_events")
Cc: <stable@vger.kernel.org> # v6.5+
Signed-off-by: Thomas Richter <tmricht@linux.ibm.com>
Reviewed-by: Sumanth Korikkar <sumanthk@linux.ibm.com>
---
 arch/s390/kernel/perf_cpum_cf.c | 140 +++++++++++++++++++++++---------
 1 file changed, 100 insertions(+), 40 deletions(-)

diff --git a/arch/s390/kernel/perf_cpum_cf.c b/arch/s390/kernel/perf_cpum_cf.c
index 2076ac22e2c4..aa84ada13d8b 100644
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
@@ -206,20 +207,19 @@ static int cpum_cf_alloc_root(void)
 	return rc;
 }
 
-/* Free CPU counter data structure for a PMU */
+/* Free CPU counter data structure for a PMU. Called under mutex lock */
 static void cpum_cf_free_cpu(int cpu)
 {
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
@@ -245,10 +243,9 @@ static int cpum_cf_alloc_cpu(int cpu)
 	struct cpu_cf_ptr *p;
 	int rc;
 
-	mutex_lock(&pmc_reserve_mutex);
 	rc = cpum_cf_alloc_root();
 	if (rc)
-		goto unlock;
+		goto out;
 	p = per_cpu_ptr(cpu_cf_root.cfptr, cpu);
 	cpuhw = p->cpucf;
 
@@ -271,8 +268,7 @@ static int cpum_cf_alloc_cpu(int cpu)
 		 */
 		cpum_cf_free_root();
 	}
-unlock:
-	mutex_unlock(&pmc_reserve_mutex);
+out:
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
@@ -1090,28 +1117,62 @@ static refcount_t cfset_opencnt = REFCOUNT_INIT(0);	/* Access count */
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
+ * Common code relies on that and calls cpumf_pmu_add(), cpumf_pmu_start(),
+ * cpumf_pmu_stop() and cpumf_pmu_del() to install PMU backend functions on
+ * the new CPU.
+ *
+ * If no per-task context event has been installed, the events are per-CPU
+ * and do not care about a new CPU.
  */
 static int cfset_online_cpu(unsigned int cpu);
 
 static int cpum_cf_online_cpu(unsigned int cpu)
 {
-	int rc = 0;
+	int i, rc = 0;
 
-	/*
-	 * Ignore notification for perf_event_open().
-	 * Handle only /dev/hwctr device sessions.
-	 */
 	mutex_lock(&cfset_ctrset_mutex);
-	if (refcount_read(&cfset_opencnt)) {
+	/* Allocate per-CPU infrastructure when per-task context active. */
+	mutex_lock(&pmc_reserve_mutex);
+	if (atomic_read(&cpu_cf_root.tskcnt)) {
 		rc = cpum_cf_alloc_cpu(cpu);
+		/* Adjust reference counts:
+		 * CPU X is offline
+		 *   perf_event_open() task event E1: tskcnt = 1, no cpuhw for CPU X
+		 *   perf_event_open() task event E2: tskcnt = 2
+		 *   CPU X set online
+		 *     cpum_cf_online_cpu()
+		 *       cpum_cf_alloc_cpu(X): cpuhw->refcnt = 1
+		 * E1 closed
+		 *   hw_perf_event_destroy()
+		 *     cpum_cf_free(-1)
+		 *       cpum_cf_free_cpu(X): refcnt 1 -> 0, kfree(cpuhw)
+		 * E2's task runs on CPU X
+		 *   cpumf_pmu_add(): this_cpu_cfhw() == NULL, -ENODEV
+		 *
+		 * If tskcnt > 1, adjust the reference counts to the number
+		 * of process-context tasks.
+		 */
+		if (!rc && atomic_read(&cpu_cf_root.tskcnt) > 1) {
+			struct cpu_cf_events *cpuhw;
+			struct cpu_cf_ptr *p;
+
+			p = per_cpu_ptr(cpu_cf_root.cfptr, cpu);
+			for (i = 1; i < atomic_read(&cpu_cf_root.tskcnt); ++i)
+				cpum_cf_alloc_root();
+
+			cpuhw = p->cpucf;
+			refcount_set(&cpuhw->refcnt,
+				     atomic_read(&cpu_cf_root.tskcnt));
+		}
+	}
+	mutex_unlock(&pmc_reserve_mutex);
+	if (refcount_read(&cfset_opencnt)) {
 		if (!rc)
 			cfset_online_cpu(cpu);
 	}
@@ -1123,20 +1184,11 @@ static int cfset_offline_cpu(unsigned int cpu);
 
 static int cpum_cf_offline_cpu(unsigned int cpu)
 {
-	/*
-	 * During task exit processing of grouped perf events triggered by CPU
-	 * hotplug processing, pmu_disable() is called as part of perf context
-	 * removal process. Therefore do not trigger event removal now for
-	 * perf_event_open() created events. Perf common code triggers event
-	 * destruction when the event file descriptor is closed.
-	 *
-	 * Handle only /dev/hwctr device sessions.
-	 */
 	mutex_lock(&cfset_ctrset_mutex);
-	if (refcount_read(&cfset_opencnt)) {
+	/* Handle /dev/hwctr device sessions */
+	if (refcount_read(&cfset_opencnt))
 		cfset_offline_cpu(cpu);
-		cpum_cf_free_cpu(cpu);
-	}
+	cpum_cf_free(cpu);
 	mutex_unlock(&cfset_ctrset_mutex);
 	return 0;
 }
@@ -1313,6 +1365,8 @@ static void cfset_ioctl_off(void *parm)
 	struct cfset_call_on_cpu_parm *p = parm;
 	int rc;
 
+	if (!cpuhw)
+		return;
 	/* Check if any counter set used by /dev/hwctr */
 	for (rc = CPUMF_CTR_SET_BASIC; rc < CPUMF_CTR_SET_MAX; ++rc)
 		if ((p->sets & cpumf_ctr_ctl[rc])) {
@@ -1339,6 +1393,8 @@ static void cfset_ioctl_on(void *parm)
 	struct cfset_call_on_cpu_parm *p = parm;
 	int rc;
 
+	if (!cpuhw)
+		return;
 	cpuhw->flags |= PMU_F_IN_USE;
 	ctr_set_enable(&cpuhw->dev_state, p->sets);
 	ctr_set_start(&cpuhw->dev_state, p->sets);
@@ -1358,6 +1414,8 @@ static void cfset_release_cpu(void *p)
 	struct cpu_cf_events *cpuhw = this_cpu_cfhw();
 	int rc;
 
+	if (!cpuhw)
+		return;
 	cpuhw->dev_state = 0;
 	rc = lcctl(cpuhw->state);	/* Keep perf_event_open counter sets */
 	if (rc)
@@ -1530,6 +1588,8 @@ static void cfset_cpu_read(void *parm)
 	int set, set_size;
 	size_t space;
 
+	if (!cpuhw)
+		return;
 	/* No data saved yet */
 	cpuhw->used = 0;
 	cpuhw->sets = 0;
-- 
2.55.0

