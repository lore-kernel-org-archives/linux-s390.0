Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013030.outbound.protection.outlook.com [40.93.196.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B27E93BAD84;
	Thu,  1 Oct 2026 19:34:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883266; cv=fail; b=uIUsnEXiil54T2iwopCk9JBH456zE3s/5HCETV/xqCFI4PdJ8i5ZmSs5OBcFZgS/leIpa8xI1yK7WkthLPx2XhvW5zvvSXRiM1Vq1q3Oipg36eqyeL2YoWKgRrDRl2tpvMolbsa+HeI/98jmem9zPPBtEZFB63JEfkwaSW4D54w=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883266; c=relaxed/simple;
	bh=3Vspzd1ai8IsZ99EAl72LFjpIHazsiu2X0H6yPwYTnw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FqO2tXbc22M1A0qKqBy32+LFD8xg7mxvSk9mmJCNhzvEp/84MdQ3za9XQgKKI3X3j1Sz3T82hfDtcq1jpMUwmtziwXiJ4HQ+zZSKY4cOY/lcya5GQzCmFmBtdLcr8/MM5wQvWtEx6oAb92x6D9MHB5R3R+hjYHIGviEftp7QJck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=HtKOVfPH; arc=fail smtp.client-ip=40.93.196.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="HtKOVfPH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=FHoOkiRlP4WH1nKBhQOqzTwFxiY4R4QQ8BgKk7yhiiSJmJ76kjKiBUEWPm1WbZM9RBYPtvC2jTSkwCWs3Ir+JsswsnGVle5F7ZqfPY5aK91siNJQgBuSTDjAmscxIq1ZHYeZSmdFnn/DWCQZ836bjUdNkElNwhyi8vN7RnRO52AsApfi3ZE/R9gMAuYbG+u7AEZr4RbZyWcQBoeqXWgdvsKaoVOzVQdSixqlulEzMrcJaU2rIyvml1aks5AT2887bBGw1spmUw50jQdERWocGRvzF4XJn52yzWcN4jgXv9j4A6m05qJz0ElCHAumP2e9Ap5oWzZhOC8wi1CMgJ2tag==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NLd8YfZXGgWTasBggef18JATDSIKlZNsiPsu0m5NuO4=;
 b=T5Lou1kaignq0lbOdjsP6wx7Eo8/AGOu19UV4AlhnwLaZNAIqrCF+F/ZYDysKbpYWGsk8OAQJ88wO7NTiNsiev8T+ywMDe6dQ9fQ0vIDIHhcZn8wwd5DA43zQlnGSHF8rFSSf2KDWfCbTO+dU0nTSPCFWBG4nQTjPA1Ceka2ms9ljL6pxdbH1VzEVDcnOvkRjmFQpK4Ba7bU3w0j3l9yBJXrKhcNYktEDkx4Ky5KubL2A8jFkmxOwOUsyfQrZTYBRvf+VyXTNIAbG6gokAIxgAA2pTJiZd/CGQELTfwP8dTMMUByO6xOE75lsSOTuVPjhZdKhp318/SQx8b36DJSsw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NLd8YfZXGgWTasBggef18JATDSIKlZNsiPsu0m5NuO4=;
 b=HtKOVfPHECqJ+tolLQQynbC946pqubvRiIhNWKDR8Iyox/wM8cIdcKSUpLzqI+QbqwAeKS7Oskc3lGZ3u+eRxZ/HIjoTSAMjRshYXgdAcK1ziGBeIGW+Ze52lyHj17znospfi3Zmu+BmXZ7ehPd6b+WE/6RlCsxxBIYxru4UMDw=
Received: from CH0P220CA0022.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::24)
 by PH7PR12MB5686.namprd12.prod.outlook.com (2603:10b6:510:13d::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 19:34:10 +0000
Received: from LV8PEPF0000005C.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::81) by CH0P220CA0022.outlook.office365.com
 (2603:10b6:610:ef::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 19:34:10 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005C.mail.protection.outlook.com (10.167.245.132) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:34:09 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:34:02 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v3 13/13] sched/fair: Switch nohz.idle_cpus to use sbm
Date: Thu, 1 Oct 2026 19:28:49 +0000
Message-ID: <20261001192849.74788-14-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001192849.74788-1-kprateek.nayak@amd.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005C:EE_|PH7PR12MB5686:EE_
X-MS-Office365-Filtering-Correlation-Id: 3d87f4d3-ed06-44f2-300a-08df1ff2f706
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|7416014|82310400026|30052699003|1800799024|23010399003|18002099003|22082099003|921020|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	8DvlSQLFGAV8/bVdXaUF2e/5ZcBmk9YsXjU9G3a0pkyQlvXoCluSjDD8P1r1/OJXWNjWSgc1o8lXWZZ1ZAHA8E2xky2HH8crtuw+ddiTl3tU5IaAeyHKZNdLLQfDZEa3yA12o0Y+xvPAlUNVV/rraFJ0q7OY5x9DaZPWK/kJ7hw6zQqUIHHt+l895XO18l1lxo9Cl+3RbtQXrnmjzvH9GHFRch9UpspccGHcfuckS/G6tVxjL+a6sdcYkOa3hcYU3IqvAxsqwhqd6lxO7okozFu/zN4dTVHFpkEOENoqs7xW/1KzEy9EwPq/aGDivnidPbWjKNvLdngjvrqONJYHFWDj8I8Z7rTEgacJBhT4tH+MICskHccOvb1kRaA/YJbIVsMy7AVl841McAMfxwcakn9/Q/4QnRehlcfnN8x6quB9/IJzaPoSOvjOsrtL0SCa4QpNSRICH2IPbaxe/P4g6bydtZVK0BMI5s87x9MGZ5/6DX55B6dlEqTdxQbJy2G3EnooeL/xpRRjmVOPmdzyulnurCWj4oYbmfE6woDdDMrJTwyczniyX38jTaiYvK3TYQiGpRHOWalEdJhHkixXp/2FiNlP4tlSRDRF80JDNvLZDQottqzwMEA2AsfsieKAFHWDlmIxF9uDRNnx1Smot5yTYusOKtnOBocCgqsdAelOXbYzSXDpMlPd1s50jZQW2jzR5WzYElPO5CTDMBioKbeIl1GePMkTlZrfLhi8/go1LpcgniXgiajunf4TcYWm
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(7416014)(82310400026)(30052699003)(1800799024)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	QKdoPo21WrRv8OAqFHsSnFM2u1IfkRh/kn27E5fWf7CcMJxyamYHkiUAbAMd+3FKV8Dir+kYiYQd92OIrYLcQFuhlOLryfWFQjI/Ao+iH+c4eWXqM1fzK5bRxh05S+fD9zqRfZarWVIKUe0JsVb2wRzyZhdiG4YN3lVqcIzMvkokn/rk/awxk13u+d7J9aep2p7ie695+TH/OWci3+eBUSff/LNwPa47fRlT17OC3m/8B0m2YOFlnlDWZByCs/yOTiuoVuZHXvR/8soq6KQQ15ahuTNopM8ENHovCtgRUQWKCPKnLJZFZ2uak7qoTXYGezqDIueAsv4HI8ZuBvtw5eZHT+L0CEmhX9VW7R43AyhmkJ87N69RzBQ3vaa10pbXC0PxoR8AnbFPw8o3j+gaxtXROCtg9hCy/I35ABJD71sU4tDcYR6fiH/iwGf8gZGW
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:34:09.6354
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3d87f4d3-ed06-44f2-300a-08df1ff2f706
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5686

From: Peter Zijlstra <peterz@infradead.org>

With sbm infrastructure in place, convert the global nohz.idle_cpus
cpumask to use sparsebitmap (sbm).

  [ prateek: Used sbm_for_each_bit_wrap(), and adapted find_new_ilb() to
    the current SMT aware scheme. ]

(Not-yet-)Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 kernel/sched/fair.c | 66 +++++++++++++++++++--------------------------
 1 file changed, 27 insertions(+), 39 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a0a659f4c3be..0b1458c4360e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -51,8 +51,9 @@
 #include <linux/profile.h>
 #include <linux/psi.h>
 #include <linux/ratelimit.h>
-#include <linux/task_work.h>
 #include <linux/rbtree_augmented.h>
+#include <linux/sbm.h>
+#include <linux/task_work.h>
 
 #include <asm/switch_to.h>
 
@@ -8210,7 +8211,7 @@ static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_tmpmask);
 #ifdef CONFIG_NO_HZ_COMMON
 
 static struct {
-	cpumask_var_t idle_cpus_mask;
+	struct sbm *sbm;
 	int has_blocked_load;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
@@ -14030,7 +14031,7 @@ static inline int on_null_domain(struct rq *rq)
  */
 static inline int find_new_ilb(void)
 {
-	struct cpumask *ilb_cpus;
+	struct cpumask *skip_cpus;
 	int ilb_cpu, fallback = -1;
 
 	lockdep_assert_irqs_disabled();
@@ -14039,18 +14040,22 @@ static inline int find_new_ilb(void)
 	 * Reuse the per-CPU select_rq_mask, which is protected from concurrent
 	 * use on this CPU by having interrupts disabled.
 	 */
-	ilb_cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
-	cpumask_and(ilb_cpus, nohz.idle_cpus_mask,
-		    housekeeping_cpumask(HK_TYPE_KERNEL_NOISE));
+	skip_cpus = this_cpu_cpumask_var_ptr(select_rq_mask);
+	cpumask_clear(skip_cpus);
+
+	sbm_for_each_set_bit(nohz.sbm, idx) {
+		ilb_cpu = sbm_idx_to_cpu(idx);
+
+		if (cpumask_test_cpu(ilb_cpu, skip_cpus))
+			continue;
 
-	for_each_cpu(ilb_cpu, ilb_cpus) {
 		if (!idle_cpu(ilb_cpu)) {
 			/*
 			 * Once an idle fallback exists, a busy CPU proves that
 			 * this core cannot be fully idle. Skip its siblings.
 			 */
 			if (sched_smt_active() && fallback >= 0)
-				cpumask_andnot(ilb_cpus, ilb_cpus, cpu_smt_mask(ilb_cpu));
+				cpumask_or(skip_cpus, skip_cpus, cpu_smt_mask(ilb_cpu));
 			continue;
 		}
 
@@ -14069,8 +14074,7 @@ static inline int find_new_ilb(void)
 			 * The core is not idle, so there is no need to check
 			 * any of its other SMT siblings.
 			 */
-			cpumask_andnot(ilb_cpus, ilb_cpus,
-				       cpu_smt_mask(ilb_cpu));
+			cpumask_or(skip_cpus, skip_cpus, cpu_smt_mask(ilb_cpu));
 			continue;
 		}
 
@@ -14134,7 +14138,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	unsigned long now = jiffies;
 	struct sched_domain_shared *sds;
 	struct sched_domain *sd;
-	int nr_busy, i, cpu = rq->cpu;
+	int nr_busy, cpu = rq->cpu;
 	unsigned int flags = 0;
 
 	if (unlikely(rq->idle_balance))
@@ -14162,11 +14166,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (time_before(now, nohz.next_balance))
 		goto out;
 
-	/*
-	 * None are in tickless mode and hence no need for NOHZ idle load
-	 * balancing
-	 */
-	if (unlikely(cpumask_empty(nohz.idle_cpus_mask)))
+	if (unlikely(sbm_empty(nohz.sbm)))
 		return;
 
 	if (rq->nr_running >= 2) {
@@ -14186,24 +14186,6 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
 
-	sd = rcu_dereference_all(per_cpu(sd_asym_packing, cpu));
-	if (sd) {
-		/*
-		 * When ASYM_PACKING; see if there's a more preferred CPU
-		 * currently idle; in which case, kick the ILB to move tasks
-		 * around.
-		 *
-		 * When balancing between cores, all the SMT siblings of the
-		 * preferred CPU must be idle.
-		 */
-		for_each_cpu_and(i, sched_domain_span(sd), nohz.idle_cpus_mask) {
-			if (sched_asym(sd, i, cpu)) {
-				flags |= NOHZ_STATS_KICK | NOHZ_BALANCE_KICK;
-				goto out;
-			}
-		}
-	}
-
 	sd = rcu_dereference_all(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
@@ -14270,7 +14252,8 @@ void nohz_balance_exit_idle(struct rq *rq)
 		return;
 
 	rq->nohz_tick_stopped = 0;
-	cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
+	if (cpumask_test_cpu(rq->cpu, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
+		sbm_cpu_clear(nohz.sbm, rq->cpu);
 
 	set_cpu_sd_state_busy(rq->cpu);
 }
@@ -14324,7 +14307,8 @@ void nohz_balance_enter_idle(int cpu)
 
 	rq->nohz_tick_stopped = 1;
 
-	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
+	if (cpumask_test_cpu(rq->cpu, housekeeping_cpumask(HK_TYPE_KERNEL_NOISE)))
+		sbm_cpu_set(nohz.sbm, rq->cpu);
 
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
@@ -14351,7 +14335,7 @@ static bool update_nohz_stats(struct rq *rq)
 	if (!rq->has_blocked_load)
 		return false;
 
-	if (!cpumask_test_cpu(cpu, nohz.idle_cpus_mask))
+	if (!sbm_cpu_test(nohz.sbm, cpu))
 		return false;
 
 	if (!time_after(jiffies, READ_ONCE(rq->last_blocked_load_update_tick)))
@@ -14377,6 +14361,7 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	int this_cpu = this_rq->cpu;
 	int balance_cpu;
 	struct rq *rq;
+	int start;
 
 	WARN_ON_ONCE((flags & NOHZ_KICK_MASK) == NOHZ_BALANCE_KICK);
 
@@ -14405,7 +14390,10 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags)
 	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
 	 * chance for other idle cpu to pull load.
 	 */
-	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
+	start = sbm_cpu_to_idx(cpumask_next_wrap(this_cpu, cpu_online_mask));
+	sbm_for_each_set_bit_wrap(nohz.sbm, idx, start) {
+		balance_cpu = sbm_idx_to_cpu(idx);
+
 		if (!idle_cpu(balance_cpu))
 			continue;
 
@@ -15648,7 +15636,7 @@ void show_numa_stats(struct task_struct *p, struct seq_file *m)
 __init void init_sched_fair_class_smp(void)
 {
 #ifdef CONFIG_NO_HZ_COMMON
-	zalloc_cpumask_var(&nohz.idle_cpus_mask, GFP_NOWAIT);
+	nohz.sbm = sbm_alloc();
 #endif
 }
 
-- 
2.34.1

