Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CF946EF98;
	Thu,  8 Oct 2026 08:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791448317; cv=none; b=c8+rcDQc6SB7V1hYhuth1l2x+nNvUIWEhOFgsJdJ9embY/5X92a1e4mbE0AP9By9YksSh1nF3yZrWHz2dhis249Utid3mrjrtZDvk0eRwDfpqUGI/jLKbOpeOradp7GQWJAUdZU4eXOF29s1QPaG5S4kyIqVS1WzZF1/2D6iXqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791448317; c=relaxed/simple;
	bh=6BxCTmOtzW6loqbSdA3MSMZoPojyYWo8kJPZq6FIZl4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oVJmUI/3bHaMW2R4oW4y5F7FLgauQ1fnJbcB/aSyXW4E7dEcT59Z+ts+477IVgiL1CdCivEElxjpCpAD5SKGwZ73Z7bED43JOr6ex58f1GgQKrroNwaHIdTLnyR4dIbszLJb4iT3s1MY6gdm6wKa94Nh0oLCAO1HAURHfJmCiuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y4jusPjW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y4jusPjW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6987ZS2C702428;
	Thu, 8 Oct 2026 08:31:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iYlne5
	6jD3VjitnrKAkFZN4VqAox0oxIBS9t8pvbaHU=; b=Y4jusPjWXa01ot0mil7tw0
	ti8mRru/RyHdOdRE9umfQL+Y5EzRt57G3Px0Kq4Eyqyn3b0uWxe4QSTaNJ+GjAfF
	4juI6qT9D+8y9ogm0olbXeNoVGzJ1jmvcJz2v9wyNktKVryUm2vaFBbg8yUIdEXP
	ahVITuI7R+bSrERPv/ZzbHum3GJOc1y/Y/hy2zgSbd1jpSUWMTvEaoSJTd5xumYs
	D1snF+kNrHQEudhi/TqkbWdv9gir7jW6kH05l4od9CJamo/rQkz+ba54QknJXCd2
	YCZhJc62/Ud9pcgQewjoHb/Ma9HKgI5g+Os44wnjiUtPmfx1pypszgGsgLw37pHQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvadw9-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6987XNt63111524;
	Thu, 8 Oct 2026 08:31:20 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34u3gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 08:31:20 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6988VGEm44958170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 08:31:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A13F920043;
	Thu,  8 Oct 2026 08:31:16 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F05692004E;
	Thu,  8 Oct 2026 08:31:15 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 08:31:15 +0000 (GMT)
From: Mete Durlu <meted@linux.ibm.com>
Date: Thu, 08 Oct 2026 10:30:47 +0200
Subject: [PATCH RFC 1/2] kernel/sched: Introduce idle SMT priority
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261008-hiperdispatchfix-v1-1-73fe41081070@linux.ibm.com>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
In-Reply-To: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
To: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Shrikanth Hegde <sshegde@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        Mete Durlu <meted@linux.ibm.com>
X-Mailer: b4 0.14.3
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: fldCslSCN33gK_3VQjTjrGTLDXoda_ie
X-Proofpoint-ORIG-GUID: vGDwBKF1oWA7xTs4lBzzYAzksO8r_pZR
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac754da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=6AFPInLqYJm8LhiFHTUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfXyFJoVNheqA9G
 +PN82i2bjVjdH7Rtzbudw/5siK5L4mMfBTe2ogbXmhi1p5rLuGIHAqiGaxwP2wgayaIKXNnGXu4
 vtv8ZA5ansRDymPCwgjnJVvmfS0UOIfhw/Hw4MwAQCAaNvreGPoLIYVJdLmPgsQ4+rlSgrqonZs
 sRL+ZedbSDQfdBmaJgPtlA1lgsRFIUITHPbIBmoJr2hXPNynuGBSWw/Z0qbecj2qLmg4pzvXvgJ
 NP9To6aH+b50DYxjHbp9VS7dBjzV3EQ9wajMmchKWRbbPe70qQpsUYh89EkSKNHeSmCjsQ8OuV5
 kRRq9DL88VSDdoL68XNYXS9+UTo5MJmE9XUdoraYbgV8PeFm+aW9nRMWWS/CD8oRBGZqNesiTIS
 j04KTMa2CTQZt70VkfMJTP/ECL8FLIjwPlI7tBRl+ZbXyGpd5u8Ou0PpodqKfO1kaqh2vM9K8jx
 n746Gak/OzTPgGixcuA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDAzMiBTYWx0ZWRfX89jBBmxE++lg
 0KQcB8jmgFqCrY72GlXPr1NVmhsA8wjovvIo9/mnVc7HYV4g2UrnqxkS42rY2LH9Bx7yhBasol1
 JVEQxHMpG2bMAXm1BbmYW60F9cMpGQw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_03,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080032

On systems with asymmetric CPU capacities and SMT, the scheduler
currently prefers fully idle cores over idle SMT siblings of busy
cores. This leads tasks onto lower capacity idle cores when a
higher-capacity core has an idle sibling thread available. This hurts
performance in cases where an SMT sibling of a busy but high capacity
core can outperform a fully idle but low capacity core.

Introduce SCHED_IDLE_SMT_PRIO and the sched_idle_smt_prio static branch
to allow architectures to override this preference. When enabled, idle
SMT siblings of busy cores are treated as regular candidates.

The static branch defaults to false and is opt-in per architecture, so
systems that do not select ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO see no
change in behavior.

Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
implementing arch_needs_idle_smt_prio(), which is called during each
asym_cpu_capacity_scan(). In case there is no asymmetric capacities
static branches get disabled.

Signed-off-by: Mete Durlu <meted@linux.ibm.com>
---
 arch/Kconfig                   | 14 +++++++++
 include/linux/sched/topology.h |  9 ++++++
 kernel/sched/fair.c            | 67 ++++++++++++++++++++++++++++++------------
 kernel/sched/sched.h           | 10 +++++++
 kernel/sched/topology.c        | 17 +++++++++++
 5 files changed, 99 insertions(+), 18 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index 45c657772362..716c2134e81e 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -47,6 +47,9 @@ config ARCH_SUPPORTS_SCHED_SMT
 config ARCH_SUPPORTS_SCHED_CLUSTER
 	bool
 
+config ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO
+	bool
+
 config ARCH_SUPPORTS_SCHED_MC
 	bool
 
@@ -79,6 +82,17 @@ config SCHED_MC
 	  making when dealing with multi-core CPU chips at a cost of slightly
 	  increased overhead in some places. If unsure say N here.
 
+config SCHED_IDLE_SMT_PRIO
+	bool "Idle SMT priority support in presence of asymmetric capacities"
+	depends on SCHED_SMT
+	depends on ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO
+	default y
+	help
+	  On asymmetric CPU capacity systems, an idle SMT sibling of a
+	  busy high-capacity core can outperform a fully idle low-capacity
+	  core. Allows architectures to override the schedulers default
+	  idle core preference accordingly.
+
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
 	bool
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index b5d9d7c2b8ad..ae51e7c467f8 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -275,6 +275,15 @@ unsigned int arch_scale_freq_ref(int cpu)
 }
 #endif
 
+#ifdef CONFIG_SCHED_IDLE_SMT_PRIO
+#ifndef arch_needs_idle_smt_prio
+static __always_inline bool arch_needs_idle_smt_prio(void)
+{
+	return true;
+}
+#endif
+#endif
+
 static inline int task_node(const struct task_struct *p)
 {
 	return cpu_to_node(task_cpu(p));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7455a83a6a99..3e21233ee2ce 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8813,11 +8813,14 @@ static int
 select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 {
 	/*
-	 * On !SMT systems, has_idle_core is always false and preferred_core
-	 * is always true (CPU == core), so the SMT preference logic below
-	 * collapses to the plain capacity scan.
-	 */
-	bool has_idle_core = sched_smt_active() && test_idle_cores(target);
+	 * On !SMT systems or when idle SMT thread priority is active,
+	 * has_idle_core is always false and preferred_core is always true
+	 * (CPU == core), so the SMT preference logic below collapses to the
+	 * plain capacity scan.
+	 */
+	bool has_idle_core = sched_smt_active() &&
+			     !sched_idle_smt_prio_active() &&
+			     test_idle_cores(target);
 	unsigned long task_util, util_min, util_max, best_cap = 0;
 	int fits, best_fits = ASYM_IDLE_THREAD_MISFIT;
 	int cpu, best_cpu = -1;
@@ -8860,8 +8863,8 @@ select_idle_capacity(struct task_struct *p, struct sched_domain *sd, int target)
 
 		/*
 		 * Perfect fit: capacity satisfies util + uclamp and the CPU
-		 * sits on a fully-idle SMT core, this is a !SMT system, or
-		 * there is no idle core to find.
+		 * sits on a fully-idle SMT core, this is a !SMT system, idle
+		 * smt priority is active, or there is no idle core to find.
 		 * Short-circuit the rank-based selection and return
 		 * immediately.
 		 */
@@ -8936,15 +8939,17 @@ static inline bool asym_fits_cpu(unsigned long util,
 		 * Return true only if the cpu fully fits the task requirements
 		 * which include the utilization and the performance hints.
 		 *
-		 * When SMT is active, also require that the core has no busy
-		 * siblings.
+		 * When SMT is active or idle SMT priority is disabled, also
+		 * require that the core has no busy siblings.
 		 *
 		 * Note: gating on is_core_idle() also makes the early-bailout
 		 * candidates in select_idle_sibling() (target, prev,
 		 * recent_used_cpu) idle-core-aware on ASYM+SMT, which the
 		 * NO_ASYM path does not do.
 		 */
-		return (!sched_smt_active() || is_core_idle(cpu)) &&
+		return (!sched_smt_active() ||
+		       sched_idle_smt_prio_active() ||
+		       is_core_idle(cpu)) &&
 		       (util_fits_cpu(util, util_min, util_max, cpu) > 0);
 	}
 
@@ -11793,6 +11798,12 @@ static inline bool smt_balance(struct lb_env *env, struct sg_lb_stats *sgs,
 	if (!env->idle)
 		return false;
 
+	/* Skip group_smt_balance case when idle SMT priority is active */
+	if (sched_idle_smt_prio_active()) {
+		if (env->sd->flags & SD_ASYM_CPUCAPACITY)
+			return false;
+	}
+
 	/*
 	 * For SMT source group, it is better to move a task
 	 * to a CPU that doesn't have multiple tasks sharing its CPU capacity.
@@ -12121,10 +12132,10 @@ static bool update_sd_pick_busiest(struct lb_env *env,
 	 * CPUs in the group should either be possible to resolve
 	 * internally or be covered by avg_load imbalance (eventually).
 	 *
-	 * When SMT is active, only pull a misfit to dst_cpu if it is on a
-	 * fully idle core; otherwise the effective capacity of the core is
-	 * reduced and we may not actually provide more capacity than the
-	 * source.
+	 * When SMT is active or idle smt priority disabled, only pull a misfit
+	 * to dst_cpu if it is on a fully idle core; otherwise the effective
+	 * capacity of the core is reduced and we may not actually provide more
+	 * capacity than the source.
 	 */
 	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
 	    (sgs->group_type == group_misfit_task) &&
@@ -12429,6 +12440,17 @@ static bool update_pick_idlest(struct sched_group *idlest,
 		break;
 
 	case group_has_spare:
+		/*
+		 * Select group with higher max capacity to prioritize groups
+		 * with high capacity SMT siblings
+		 */
+		if (sched_idle_smt_prio_active()) {
+			if (idlest->sgc->max_capacity > group->sgc->max_capacity)
+				return false;
+			if (idlest->sgc->max_capacity < group->sgc->max_capacity)
+				break;
+		}
+
 		/* Select group with most idle CPUs */
 		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
 			return false;
@@ -12699,7 +12721,9 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
 	unsigned long sum_util = 0;
 	bool sg_overloaded = 0, sg_overutilized = 0;
 
-	env->dst_core_idle = !sched_smt_active() || is_core_idle(env->dst_cpu);
+	env->dst_core_idle = !sched_smt_active() ||
+			     is_core_idle(env->dst_cpu) ||
+			     sched_idle_smt_prio_active();
 
 	do {
 		struct sg_lb_stats *sgs = &tmp_sgs;
@@ -13171,11 +13195,14 @@ static struct rq *sched_balance_find_src_rq(struct lb_env *env,
 			bool cluster_equal_cap = static_branch_unlikely(&sched_cluster_active) &&
 						 (get_actual_cpu_capacity(env->dst_cpu) ==
 						  get_actual_cpu_capacity(i));
-			bool smt_degraded_cap = sched_smt_active() && !is_core_idle(i);
+			bool smt_degraded_cap = sched_smt_active() &&
+						!is_core_idle(i) &&
+						!sched_idle_smt_prio_active();
 
 			/*
-			 * Busy SMT siblings reduce the capacity of CPU @i. Do
-			 * not skip it in this case.
+			 * Busy SMT siblings reduce the capacity of CPU @i
+			 * unless idle SMT priority is active. Do not skip it
+			 * in this case.
 			 *
 			 * CONFIG_SCHED_CLUSTER requires balancing load across
 			 * clusters of identical capacity, accounting for
@@ -13394,6 +13421,10 @@ static int should_we_balance(struct lb_env *env)
 	for_each_cpu_and(cpu, swb_cpus, env->cpus) {
 		if (!idle_cpu(cpu))
 			continue;
+		if (sched_idle_smt_prio_active()) {
+			if (env->sd->flags & SD_ASYM_CPUCAPACITY)
+				return cpu == env->dst_cpu;
+		}
 
 		/*
 		 * Don't balance to idle SMT in busy core right away when
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e656c7059bf8..2d168e8565fc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2241,12 +2241,22 @@ DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 
 extern struct static_key_false sched_asym_cpucapacity;
 extern struct static_key_false sched_cluster_active;
+DECLARE_STATIC_KEY_FALSE(sched_idle_smt_prio);
 
 static __always_inline bool sched_asym_cpucap_active(void)
 {
 	return static_branch_unlikely(&sched_asym_cpucapacity);
 }
 
+static __always_inline bool sched_idle_smt_prio_active(void)
+{
+#ifdef CONFIG_SCHED_IDLE_SMT_PRIO
+	return static_branch_unlikely(&sched_idle_smt_prio);
+#else
+	return false;
+#endif
+}
+
 struct sched_group_capacity {
 	atomic_t		ref;
 	/*
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 0248227d983a..a66ea34a1dfd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -684,6 +684,7 @@ DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
 
 DEFINE_STATIC_KEY_FALSE(sched_asym_cpucapacity);
 DEFINE_STATIC_KEY_FALSE(sched_cluster_active);
+DEFINE_STATIC_KEY_FALSE(sched_idle_smt_prio);
 
 static void update_top_cache_domain(int cpu)
 {
@@ -1559,6 +1560,21 @@ build_sched_groups(struct sched_domain *sd, int cpu)
 	return 0;
 }
 
+#ifdef CONFIG_SCHED_IDLE_SMT_PRIO
+static void sched_set_idle_smt_prio(int asym_detected)
+{
+	bool smt_prio;
+
+	smt_prio = arch_needs_idle_smt_prio() && asym_detected;
+	if (smt_prio && !sched_idle_smt_prio_active())
+		static_branch_enable_cpuslocked(&sched_idle_smt_prio);
+	else if (!smt_prio && sched_idle_smt_prio_active())
+		static_branch_disable_cpuslocked(&sched_idle_smt_prio);
+}
+#else
+static void sched_set_idle_smt_prio(int asym_detected) {}
+#endif
+
 /*
  * Initialize sched groups cpu_capacity.
  *
@@ -1769,6 +1785,7 @@ static void asym_cpu_capacity_scan(void)
 		}
 	}
 
+	sched_set_idle_smt_prio(!list_is_singular(&asym_cap_list));
 	/*
 	 * Only one capacity value has been detected i.e. this system is symmetric.
 	 * No need to keep this data around.

-- 
2.55.0

