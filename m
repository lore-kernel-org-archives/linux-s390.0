Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010016.outbound.protection.outlook.com [52.101.85.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1C6949503F;
	Thu,  1 Oct 2026 19:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883207; cv=fail; b=mZ9sgS/a6WClCtVJCUiiBxZb/rPMo6yNgFTldEhUISGoitk37dnKXjaE3INKIPPRwliEhzW5zFBrlpe34nNhSDdzRrHKf3Bn5HSVt3Ij0K6T1dolO+jK7AKohjphT+IgrlFssOFcJLAz9IpkHfpjZb/dU1rZaRFbcsjtSQa0Bqs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883207; c=relaxed/simple;
	bh=RE4Xsw7EErkLJtldY3GqvvfCXm13PDOoJ9l4AiKxFBI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RRdgR4DV7NFw3/8pNcR9DRLkFaEJ4TDejrjbsndgK82CfXiAES5xpKrT18aakHxgX/pM+yOgNARbLqFco6p7BxBT/9t4TwmDUZxMSRM1g5CtZ42f/eYFswDNdI31mOuBbAzCDELXnHOMu8Ja1mf48N29EcUu3TnQ4f3YZ95JOKw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=kaKuJxxN; arc=fail smtp.client-ip=52.101.85.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="kaKuJxxN"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zG+PzQa9JB7z4PwznKtoJFX541R1sZpwVk/qa0XQul2MCciAgdddoV066y5FE2HwIUFkmiz4D4FBnNb5gs5tZxSoAcZlVkD+E5F6/OfHcRThcw6KtNOjcvIj0y7V+LtTNTsQGCYc+jwIDhJJzzlZiBmxTj2yTL5P5XoIGhkGcQ/kreL4uCdttL7+mZqrzwWYMetgKCe7yxME1OKYgnnCJIRxY7BIAWt9hRlhhjRyZxfyx1pRYwTPfaBKTY2lLyBILjza8VmhQkfa5Nl5W8TNf/jf+sBGjONCsZjacfRC8Aem+W6FnXmh1qswFyddLohuvkVsy0bkQKA5YF3rRt+3Hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hK3za29qqtbvTj18V0WcXn9cmFk1ypbiJbOEivkdV8Q=;
 b=g1nFGFndwewp9k0oueUfJy2Xhnt+1uq02pCiG6bGJwOXUuT1xjYVbNGSoA+EQbMJGBw8cUuj4RoDukrq3tgPkpKGAOCdKSumAgmkDOxAzPRsMs8fz3/6/sUbS6OTrgpzOl/Pvxi6Z08Nlr2U/V4dVEcf2WZG8mdbXTgxOiu3sOEiE7bmRHVMUAnk00Au0yHjlhsuzadoSNsPM6EQsfFzr3TM3/T+PEKviXFYZnQBSHgioNsduowGv1ZkSWIOC9dlObZoWXS+gWIxryelMfL5KLMMnk+rJk59Kaivr/7m2khLo6KqiQfVsfI9F36TRvF4Wvu27ks0N0sPp0SQGXLYdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hK3za29qqtbvTj18V0WcXn9cmFk1ypbiJbOEivkdV8Q=;
 b=kaKuJxxNSE3AReCuIkKhBFcrgzLQBU0bS5u8NbvT0MPl/dUFV69wfH3CUr0jdBkxe91jaXYcpuAQIgL6D/M1fOLXKFeExxz4Qw5atnscZftcx64U9/wA2tSL04UNCXbLnNRW6IIoQGFVL6WVV1PX/hzJY7sbDcOPOtIuQ4dumXI=
Received: from MN0PR03CA0009.namprd03.prod.outlook.com (2603:10b6:208:52f::14)
 by PH7PR12MB8795.namprd12.prod.outlook.com (2603:10b6:510:275::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Thu, 1 Oct
 2026 19:33:06 +0000
Received: from LV8PEPF0000005F.namprd02.prod.outlook.com
 (2603:10b6:208:52f:cafe::53) by MN0PR03CA0009.outlook.office365.com
 (2603:10b6:208:52f::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 19:33:05 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 LV8PEPF0000005F.mail.protection.outlook.com (10.167.245.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:33:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:32:51 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sudeep Holla <sudeep.holla@kernel.org>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, "Thomas
 Gleixner" <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "WANG
 Xuerui" <kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, "Nicholas
 Piggin" <npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>,
	"Christian Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle
	<svens@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v3 10/13] lib/sbm: Dynamically allocate sbm index when CPU is activated
Date: Thu, 1 Oct 2026 19:28:46 +0000
Message-ID: <20261001192849.74788-11-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005F:EE_|PH7PR12MB8795:EE_
X-MS-Office365-Filtering-Correlation-Id: a347a92a-3803-4083-5afb-08df1ff2d0a6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|23010399003|1800799024|921020|11063799006|56012099006|10067099003|18002099003|22082099003|6133799003|3023799007;
X-Microsoft-Antispam-Message-Info:
	JFdDF2Cf6VGQqYv0yYtbCtXodEx1y6ZLSGKhcNjJ11vnRMjM4X+bVn97MaQ4JbvBmks2meNXSIFF1aQy+Q6S+VrvjlSpP00puRFOpZKrmofo4gdCge7VJtXMW7l+dH0KHpIl1DAikFxti+QFoE455yxwEaTUz3VlKQPjBhWMauEqa9LSiKo1Vemm4SShiHMtDdae699JQxqt2R6JUSxatiMgTmmiPiVTCyoyso3ZTYwcbpfj9titcIATeQfeRyOHBEXanCTfPJn0jOsXiL9YxrcXj94Zyf0ZhN8CjMC6aToML4Cq5bRbg7IH0D0sxhY/WGHZyjU2DIFOZ11SVUGueoEtBickBZJhgzdF+twTnE/704tVMWoHZ4kQIzUo4AEI0fdSexr0ybOgupx6Ua0QLGRHMaadSsBboa2Whea0Mz2xGdVg4OEML43YyhH8zPP4iZ7ZKIV/LJLvh0GdF3p86NGVAT1MBXMR6V3fLmFmIjr1iEdYbIuqAmde3GvDIuw5KvSHFkKHuwpzPuMHSOWAWp+9yKk6dZ+qzY2HrI7m30qO0dHAjm8sV6DpfLFD1MYarkUXxUvSS1q4Ww/9udLbrf2pj6+FPO1z8+oVwwENcpr8BV5mRGEUvJh6335q6HVLYXeYlcxMuQ9juit72ikbhCrS1fWmF1BCxZHH4Qikx27FwJdEzcnnqAID+AafTi26JcqQY5336BFkTyGEZEeu5eWWl8hm8faBfYhmO/OyazuOPv5kJ0kR/F/64k+m9YwS
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(23010399003)(1800799024)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003)(6133799003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	bg9bk1+pzez17ykn3T/2WbhJWKOS0c8w/mmrNK0sJ992ZWd4Pz+t/ZpwahB6Ct7mFe02sNGuVREtErPwGetRsGqnjRCS58FzEn1i3IC8Fob/LdE1fEnsCBfO6CowpV0XLs3Cp2JJ0Zd2K/SEXPWq4oVac+AcqyM6Oii0YlVbrZFiSnx5l2tKbjJNU6t3VuLnimVMHjegpRVU9BRF/byik/64iNP5PszuatPifUpebMuZcGa/ZjioWYNZfTVJG2bEDnPfORxF1kie53iTCUl1sFDvMwv41rUDtVp73+Sxv6ljbnO9B4kQ+8vpWSWYlxi3J4k+MP/6Alqjl88EEqgjUYCFhJZpd0IHsPNsMMhXS3Mic75cgyhKVI+cWdUzuH3AOph7O0vWM76PrZ5sUN5vgHLRQp2PX/nx5AeWZK/94L5KuXN6i1d5HC4V5CmoaxpT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:33:05.2547
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a347a92a-3803-4083-5afb-08df1ff2d0a6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005F.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB8795

Add infrastructure to establish CPU to sparsebitmap (sbm) index relation
before CPU is turned active. CPU coming online looks for a free slot
based on its instance ID and acquires a free slot.

If slots are exhausted, a new leaf is allocated for an instance ID. New
CPUs activating with same instance ID can claim free slots on the same
leaf but must never exceed max_threads_per_instance.

For architectures that have not initialized the sbm topology, sbm core
overrides the arch_sbm_cpu_instance_id() in sbm_cpu_instance_id()
wrapper to always return 0 keeping all CPUs on same instance.

Data structures that require fast access have been runtime constified to
enable faster access in kernel hot paths.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 include/asm-generic/vmlinux.lds.h |   6 +-
 include/linux/sbm.h               |  14 +++
 init/main.c                       |   6 +
 kernel/sched/core.c               |  17 +++
 lib/sbm.c                         | 175 +++++++++++++++++++++++++++++-
 5 files changed, 215 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index b2988aa12f66..b0346d382cea 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -981,7 +981,11 @@
 		RUNTIME_CONST(ptr, __bfilp_cache)			\
 		RUNTIME_CONST(shift, __futex_shift)			\
 		RUNTIME_CONST(mask,  __futex_mask)			\
-		RUNTIME_CONST(ptr,   __futex_queues)
+		RUNTIME_CONST(ptr,   __futex_queues)			\
+		RUNTIME_CONST(shift, __sbm_shift)			\
+		RUNTIME_CONST(mask,  __sbm_mask)			\
+		RUNTIME_CONST(ptr,   __sbm_cpu_to_idx)			\
+		RUNTIME_CONST(ptr,   __sbm_idx_to_cpu)
 
 /* Alignment must be consistent with (kunit_suite *) in include/kunit/test.h */
 #define KUNIT_TABLE()							\
diff --git a/include/linux/sbm.h b/include/linux/sbm.h
index adac12ed233a..232b0076bb3f 100644
--- a/include/linux/sbm.h
+++ b/include/linux/sbm.h
@@ -2,7 +2,21 @@
 #ifndef _LINUX_SBM_H
 #define _LINUX_SBM_H
 
+/*
+ * Masks and shifts for sbm index to translate
+ * a sbm leaf to CPU.
+ */
+extern int __sbm_shift;
+extern int __sbm_mask;
+
 int arch_sbm_cpu_instance_id(int cpu);
 void sbm_set_topology(int num_instances, int max_threads_per_instance);
 
+int sbm_cpu_to_idx(int cpu);
+int sbm_idx_to_cpu(int idx);
+
+int alloc_sbm_index(int cpu);
+void free_sbm_index(int cpu);
+int sbm_init(void);
+
 #endif /* _LINUX_SBM_H */
diff --git a/init/main.c b/init/main.c
index 2613d3f9b3ce..b7406bd3acc8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -72,6 +72,7 @@
 #include <linux/pid_namespace.h>
 #include <linux/device/driver.h>
 #include <linux/kthread.h>
+#include <linux/sbm.h>
 #include <linux/sched.h>
 #include <linux/sched/init.h>
 #include <linux/signal.h>
@@ -1652,6 +1653,11 @@ static noinline void __init kernel_init_freeable(void)
 
 	smp_prepare_cpus(setup_max_cpus);
 
+	sbm_init();
+
+	/* Finish initializing boot CPU since it is already active. */
+	alloc_sbm_index(smp_processor_id());
+
 	workqueue_init();
 
 	init_mm_internals();
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0bb86a43a592..977f579da410 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -61,6 +61,7 @@
 #include <linux/rcuwait_api.h>
 #include <linux/rseq.h>
 #include <linux/sched/wake_q.h>
+#include <linux/sbm.h>
 #include <linux/scs.h>
 #include <linux/slab.h>
 #include <linux/syscalls.h>
@@ -8636,6 +8637,14 @@ int sched_cpu_activate(unsigned int cpu)
 	 */
 	balance_push_set(cpu, false);
 
+	alloc_sbm_index(cpu);
+
+	/*
+	 * Make sure sbm mappings are visible
+	 * before CPU is toggled active.
+	 */
+	smp_mb();
+
 	/*
 	 * When going up, increment the number of cores with SMT present.
 	 */
@@ -8688,6 +8697,14 @@ int sched_cpu_deactivate(unsigned int cpu)
 
 	set_cpu_active(cpu, false);
 
+	/*
+	 * Make sure CPU is inactive before
+	 * sbm indices are reclaimed.
+	 */
+	smp_mb();
+
+	free_sbm_index(cpu);
+
 	/*
 	 * From this point forward, this CPU will refuse to run any task that
 	 * is not: migrate_disable() or KTHREAD_IS_PER_CPU, and will actively
diff --git a/lib/sbm.c b/lib/sbm.c
index 82280e3306de..e5b0508b6825 100644
--- a/lib/sbm.c
+++ b/lib/sbm.c
@@ -1,10 +1,58 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <linux/sbm.h>
 #include <linux/init.h>
+#include <linux/log2.h>
+#include <linux/slab.h>
+#include <linux/cache.h>
 #include <linux/printk.h>
+#include <linux/cpumask.h>
+#include <linux/jump_label.h>
 
-static int sbm_max_threads_per_instance = -1;
-static int sbm_num_instance = -1;
+#include <asm/runtime-const.h>
+
+static int sbm_max_threads_per_instance __ro_after_init = -1;
+static int sbm_num_instance __ro_after_init = -1;
+
+int __sbm_shift __ro_after_init;
+int __sbm_mask __ro_after_init;
+
+static struct {
+	int		instance_id;	/* Instance ID linked to the leaf. */
+	unsigned long	allocated_mask;	/* Set of IDs that have been allocated. */
+} *__sbm_idx_metadata __ro_after_init;
+
+/* Translations between cpu <-> sbm leaf */
+static int *__sbm_cpu_to_idx __ro_after_init;
+static int *__sbm_idx_to_cpu __ro_after_init;
+
+static __always_inline int *_sbm_cpu_to_idx(void)
+{
+	return runtime_const_ptr(__sbm_cpu_to_idx);
+}
+
+static __always_inline int *_sbm_idx_to_cpu(void)
+{
+	return runtime_const_ptr(__sbm_idx_to_cpu);
+}
+
+int sbm_cpu_to_idx(int cpu)
+{
+	return _sbm_cpu_to_idx()[cpu];
+}
+
+int sbm_idx_to_cpu(int idx)
+{
+	return _sbm_idx_to_cpu()[idx];
+}
+
+/*
+ * Certain architectures may skip initializing sbm propoerties
+ * while having an arch_sbm_cpu_instance_id() definition.
+ *
+ * In such cases, don't trust the arch/ side redefine and use
+ * the default single instance mapping.
+ */
+static DEFINE_STATIC_KEY_FALSE(sbm_arch_initialized);
 
 /*
  * In absence of an arch definition, consider all CPUs to
@@ -15,6 +63,72 @@ int __weak arch_sbm_cpu_instance_id(int cpu)
 	return 0;
 }
 
+static int sbm_cpu_to_instance(int cpu)
+{
+	if (static_branch_likely(&sbm_arch_initialized))
+		return arch_sbm_cpu_instance_id(cpu);
+
+	return 0;
+}
+
+int alloc_sbm_index(int cpu)
+{
+	int cpu_instance = sbm_cpu_to_instance(cpu);
+	int i, idx = BITS_PER_LONG, free_index = -1;
+
+	for (i = 0; i < sbm_num_instance; ++i) {
+		if (__sbm_idx_metadata[i].instance_id == cpu_instance) {
+			idx = find_first_zero_bit(&__sbm_idx_metadata[i].allocated_mask,
+						  BITS_PER_LONG);
+
+			if (idx < BITS_PER_LONG)
+				break;
+		}
+		if (free_index == -1 && __sbm_idx_metadata[i].instance_id == -1)
+			free_index = i;
+	}
+
+	if (i == sbm_num_instance && free_index == -1)
+		return -ENOENT;
+
+	if (i == sbm_num_instance) {
+		__sbm_idx_metadata[free_index].instance_id = cpu_instance;
+		i = free_index;
+		idx = 0;
+	}
+
+	WARN_ON_ONCE(idx >= sbm_max_threads_per_instance);
+
+	__set_bit(idx, &__sbm_idx_metadata[i].allocated_mask);
+
+	idx = (i << __sbm_shift) + idx;
+	_sbm_idx_to_cpu()[idx] = cpu;
+	_sbm_cpu_to_idx()[cpu] = idx;
+
+	return 0;
+}
+
+void free_sbm_index(int cpu)
+{
+	int idx = sbm_cpu_to_idx(cpu);
+	u32 leaf;
+
+	if (idx < 0)
+		return;
+
+	_sbm_idx_to_cpu()[idx] = -1;
+	_sbm_cpu_to_idx()[cpu] = -1;
+
+	leaf = runtime_const_shift_right_32(idx, __sbm_shift);
+	idx = runtime_const_mask_32(idx, __sbm_mask);
+
+	__clear_bit(idx, &__sbm_idx_metadata[leaf].allocated_mask);
+
+	if (find_first_bit(&__sbm_idx_metadata[leaf].allocated_mask, BITS_PER_LONG) ==
+	    BITS_PER_LONG)
+		__sbm_idx_metadata[leaf].instance_id = -1;
+}
+
 void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
 {
 	sbm_max_threads_per_instance = max_threads_per_instance;
@@ -25,3 +139,60 @@ void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
 		sbm_max_threads_per_instance);
 }
 
+int __init sbm_init(void)
+{
+	int i;
+
+	if (sbm_max_threads_per_instance > 0 && sbm_num_instance > 0) {
+		static_branch_enable(&sbm_arch_initialized);
+		goto init_properties;
+	}
+
+	sbm_max_threads_per_instance = BITS_PER_LONG;
+	sbm_num_instance = (nr_cpumask_bits / BITS_PER_LONG) + 1;
+
+init_properties:
+	/*
+	 * If the number of CPUs per instance cross bitmask word boundary,
+	 * split the instances into samller chunks on BITS_PER_LONG and
+	 * increase the order of leaves.
+	 */
+	if (sbm_max_threads_per_instance > BITS_PER_LONG) {
+		int split = (sbm_max_threads_per_instance + BITS_PER_LONG - 1) / BITS_PER_LONG;
+
+		sbm_max_threads_per_instance = BITS_PER_LONG;
+		sbm_num_instance *= split;
+	}
+
+	sbm_max_threads_per_instance = roundup_pow_of_two(sbm_max_threads_per_instance);
+
+	__sbm_shift = ilog2(sbm_max_threads_per_instance);
+	__sbm_mask = sbm_max_threads_per_instance - 1;
+
+	__sbm_idx_metadata = kzalloc_objs(*__sbm_idx_metadata, sbm_num_instance);
+	__sbm_cpu_to_idx = kzalloc_objs(*__sbm_cpu_to_idx, nr_cpumask_bits);
+	__sbm_idx_to_cpu = kzalloc_objs(*__sbm_idx_to_cpu,
+					sbm_max_threads_per_instance * sbm_num_instance);
+
+	BUG_ON(!__sbm_cpu_to_idx || !__sbm_idx_to_cpu || !__sbm_idx_metadata);
+
+	for (i = 0; i < nr_cpumask_bits; ++i)
+		__sbm_cpu_to_idx[i] = -1;
+
+	/* Set all instance id to -1 to allow for future allocations to claim them. */
+	for (i = 0; i < sbm_num_instance; ++i)
+		__sbm_idx_metadata[i].instance_id = -1;
+
+	runtime_const_init(shift, __sbm_shift);
+	runtime_const_init(mask,  __sbm_mask);
+	runtime_const_init(ptr,   __sbm_cpu_to_idx);
+	runtime_const_init(ptr,   __sbm_idx_to_cpu);
+
+	barrier();
+
+	pr_info("sbm instance count: %d (maximum threads per instance: %d)\n",
+		sbm_num_instance,
+		sbm_max_threads_per_instance);
+
+	return 0;
+}
-- 
2.34.1

