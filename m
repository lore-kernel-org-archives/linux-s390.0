Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010026.outbound.protection.outlook.com [52.101.201.26])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 760023C0A17;
	Thu,  1 Oct 2026 19:31:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.26
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883102; cv=fail; b=C/QvhwRaXOgco8pcLD9xc6zpbKXXDSWFU7f/TmOT/8NZDqcSscBR3/zf6RjmQThKjmKnLBZWCeueQamFRK7y60k9IXtZAns+/296RNdoar/9VpnYEFmb28OEPu5Y3p4fTsEybitEedpoXWH5s8KCLBc14heWQ9VjS6za1t718zU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883102; c=relaxed/simple;
	bh=JFzq+jwBHu9bsxtarOlg1r3ErZnWNSzv0S19ZlyIHa0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dIg+3/lv+Fe4ybWnIBe656JJHFM7fbi6NRHzlPmP9Ul4qh8J+G/TUpFDh+/CU5/1/yZ0pNPssRNKxNmToCYuajDneckr3nD/WWntDLAoesiGFVfcX7h1ZECo1OfLiMTD9UtaP2O7y5p7kRFKBwpZ9pQ3T+qRd1wp/3Eauq5EPIs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=46SksZdx; arc=fail smtp.client-ip=52.101.201.26
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="46SksZdx"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VMdnvUJA6i/34U11saTUrtAqcHYgBV/r4taXXaL32oeqsOpT1BZ4dcARw2mm7P4Rlvt5Dg9XyhDpUnkr5/ygDfrTrB+kYCd19pe3e0Cv3EG2wz305gbPhN7FafiZ9guQ2E+j0SeXC5W45y7wVi9OsW4akbiPGK1jJeTDJJsld2YDZPbwjz7pecuaNqzhTQDsAAPkua83rgpYHVyfw9ukHMlITCoHVg9YyLjE3vCSFUpyaEEuaA9TrBaQ00Oiy+33t6iuKrX035+SW6LUm9gFbWsu1DoySXwOwAot68dufKrliqIgYAXvyABG1l5jd3UrCivXTCldNHybfM/LKZ4bmA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lXV1fC7CcmYufav9XopCMAIQLIe5dVonxeaXXB5hjMs=;
 b=QLhnuk9e/lmYnbXqn5MTvwO4M4Itr1sK6epeASfKdqKAgI9pzPyW+umnA0nxx88DbDt5IuhEc820D2pt7LieHYkSgn9/tmaqdVxdhMv+BQaLSXLRqyiYf3lhfacGzL1dqUiU3g/OyPxfr95FswjQnMItMBOnfYkNHgtMe27EupecyNGHOyl0Mc1AHsjXygEJxStVQilD85+sK+60tpcIm//RMXCPp7Y8AuFi7EPHKYaMQft2ViTuDvUUmuE6/iWjriTexx3SkRcu7s29K5XGBLac4GDOglm6f8TzQOGAeFZk/1TMNpcnTQ1dJQ6LCDmE0X/IBCXQI8jPl+7YQEji5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lXV1fC7CcmYufav9XopCMAIQLIe5dVonxeaXXB5hjMs=;
 b=46SksZdxTabQRxuDFAk6Bx0qj7RH4SjB8WxdJ5cv4HFlojhS0umIQkSTbFgSFAiJ3OzxXIjKtT+FLcAjxiID9O/XQmDXVk2ccW9y4LXVX9TVX+4fqOtTeD/juc6ouGyad/D12ghcexkNCe634ER71PWkSOVCm/5noT4yOhCsSto=
Received: from MN2PR03CA0018.namprd03.prod.outlook.com (2603:10b6:208:23a::23)
 by IA1PR12MB9497.namprd12.prod.outlook.com (2603:10b6:208:593::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Thu, 1 Oct
 2026 19:31:36 +0000
Received: from BL6PEPF00020E60.namprd04.prod.outlook.com
 (2603:10b6:208:23a:cafe::64) by MN2PR03CA0018.outlook.office365.com
 (2603:10b6:208:23a::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:31:36 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E60.mail.protection.outlook.com (10.167.249.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:31:36 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:31:28 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Madhavan Srinivasan <maddy@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Michael
 Ellerman" <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
	Christophe Leroy <chleroy@kernel.org>
Subject: [RFC PATCH v3 06/13] powerpc/setup: Initialize sbm topology based on coregroup / NUMA topology
Date: Thu, 1 Oct 2026 19:28:42 +0000
Message-ID: <20261001192849.74788-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E60:EE_|IA1PR12MB9497:EE_
X-MS-Office365-Filtering-Correlation-Id: 1aff2af2-7510-4c4c-7054-08df1ff29bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|23010399003|7416014|376014|82310400026|1800799024|56012099006|10067099003|6133799003|3023799007|22082099003|18002099003|11063799006|921020;
X-Microsoft-Antispam-Message-Info:
	aYGk2jRvyzTtd+bAXbLTTeoP6g7X3Yh1DpM2DV7GUiSuYQrwT1hmhJBH3rSbr6xOCYsvzvO+sAxASU8bece7aAcQzo72efGiFcysiKu8iMfXgGuqMzXhd1R8O1PGeN10RAH4uew//xxKyecuGVLo+QXOeju0IsemfO+RnXNdotV2FoSEUfz2oeIpnsxsSsxYkv5uMAjtK6Burt/MDQAiTGzzyRwKKYahmXV/poDlnTXC0TU6NWlaeNKl7Pggqf79sQTRsotSeUNobOBbYgtCaqCgkyxgxcwlnYVJhda7hJqZqv70/JTd9MJKBUUX66VXVLLQczcwCyXgaeeijJsddf5bAM6twJtfq+zFFb5CiKzQvZ+6UDbsTKkjjVizo5tzGsl4qQK1FEbTJaxA0wTAEhitO9us4jgbwjQbvaNqEW5/OMikxJj27W5sMhbiZNMkT2k95sq0TU19Nwd0QbsG4Xbod+pm5ZSFC0xKh18mnlCN+NOQ3Zvd0Sl3Gbs/8sCW5Rs5zpkMt6i1DTfDPROl9FiZjO+215A/YGduHxMDSIC0+JYCTwCw3wNQ71X2FzpKK72obC8fUbcqkA2vhF3gfCObxqPhnEy+lYfgkdJr8jiCpeBWUsjOGZQQp6CcgBxhkOiZUyM1C5eqrZ3EaiWie/pWNDEmMxuUvzqEQNf21csk4JYouTSgFM8CraItBou41PohsFra/Zb7+6w7R05I0Q==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(23010399003)(7416014)(376014)(82310400026)(1800799024)(56012099006)(10067099003)(6133799003)(3023799007)(22082099003)(18002099003)(11063799006)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/ZIXv8/jj2kWiDrkjzSmcR+ka8y59GaojZEZ3RkYbG9RmbQEz8kCILvCFYWw7/88ifh3cwOumfPMaz2IlY2csKCohubtYfIhcavX1/ZLX4SvEwOUDCFj3aC5HgcKMa00nl6lZ/ODWL7Wsaf5zs3Pv1354M+EnAOyfIAsNuzsQCYe9yF4WTp/ROFCsTv5fmxkFF1RP9658V56KNVnNnt9SkiqetMIzA9iMnTfpZoFIb0V5A6FR+edfprTyMLUW7HBc8hK38W7rNiu1R66WMrDhCFTl+3YhP69wAiRU/GqxXBV5DClVPe30I+sHAdNP0ztsYALTkQf1mYiIzP9brdAMyf0PhQYvDV0IotpofeL7ML6sGmQuN1nVtMxvyGuSr/XEOKJ1IjtEV3OSRhtcGeFyd2FRZ4V30tT23L4GGHfzqkWG2yI1p7DV+pJ4S62oktE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:31:36.3050
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1aff2af2-7510-4c4c-7054-08df1ff29bbe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E60.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB9497

Initialize sparsebitmap (sbm) topology based on the coregroup
information. Each coregorup gets its own sparsemask leaf.

pSeries and memory hotplug are interesting since a hotplug can place a
newly added CPU on any online node. This requires special care to allow
estimating bitmask size considering the worst case scenarios - each CPU
onlined is on a separate node, and this is a new N_CPU node.

Platform may enforce a stricter standards for the CPUs being online and
what nodes they can be mapped to but the current implementations makes
no assumptions and considers each CPU can be onlined on a unique node.

pSeries systems that can hotplug CPUs (detected using smp_ops) use the
NUMA topology instead for sbm initialization. arch_sbm_cpu_instance_id()
on these systems use cpu_to_node() mappings to match CPUs to sbm
instances.

XXX: This requires further optimizations to shorten sparsemask
traversals by keeping the number of leaf nodes to a minimum. If there
are nuances I'm not aware of, please reach out.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Tested on ppc64le_defconfig with:

  qemu-system-ppc64 \
  -M pseries \
  -cpu power10 \
  -smp sockets=2,cores=2,threads=4 \
  -m 10G -nographic \
  -kernel vmlinux \
  -append "root=/dev/ram sched_debug"

and also on ppce500 VM based on instructions in
https://www.qemu.org/docs/master/system/ppc/ppce500.html
---
 arch/powerpc/kernel/setup-common.c           | 88 ++++++++++++++++++++
 arch/powerpc/platforms/pseries/hotplug-cpu.c | 10 +++
 2 files changed, 98 insertions(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
index 4afaba19b586..4b57ad553172 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -11,6 +11,7 @@
 #include <linux/export.h>
 #include <linux/panic_notifier.h>
 #include <linux/string.h>
+#include <linux/sbm.h>
 #include <linux/sched.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -602,6 +603,87 @@ static __init int add_pcspkr(void)
 device_initcall(add_pcspkr);
 #endif	/* CONFIG_PCSPKR_PLATFORM */
 
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	/*
+	 * In case of pSeries processors, sbm masks are
+	 * grouped by nodes where the cpuhotplug
+	 * operations can remove and re-add same logical
+	 * CPUs on different nodes.
+	 *
+	 * See comment in pseries_cpu_hotplug_init().
+	 */
+	if (smp_ops->cpu_disable)
+		return cpu_to_node(cpu);
+
+	return cpu_to_coregroup_id(cpu);
+}
+
+static void __init setup_sbm_topology(void)
+{
+	int num_sbm_instances, max_threads_per_instance = 1;
+	struct cpumask *cpu_sbm_setup_map;
+	int i, *__node_thread_count;
+	int disabled_cpus = 0;
+
+	cpu_sbm_setup_map = memblock_alloc_or_panic(cpumask_size(), __alignof__(long));
+	__node_thread_count = memblock_alloc_or_panic(nr_cpu_ids * sizeof(int),
+						      __alignof__(int));
+
+	memset(__node_thread_count, 0, nr_cpu_ids * sizeof(int));
+	memset(cpu_sbm_setup_map, 0, cpumask_size());
+
+	for_each_possible_cpu(i) {
+		bool found = false;
+		int j;
+
+		if (!cpu_present(i)) {
+			disabled_cpus += 1;
+			continue;
+		}
+
+		for_each_cpu(j, cpu_sbm_setup_map) {
+			if (cpu_to_coregroup_id(i) == cpu_to_coregroup_id(j)) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			cpumask_set_cpu(i, cpu_sbm_setup_map);
+			__node_thread_count[i] = 1;
+			continue;
+		}
+
+		__node_thread_count[j] += 1;
+		max_threads_per_instance = max(max_threads_per_instance,
+					       __node_thread_count[j]);
+	}
+
+	/*
+	 * If CPUs are disabled, they may pop up on any online node.
+	 *
+	 * XXX: Any implementation nuances that can help this?
+	 * pSeries says only online nodes can be extended.
+	 */
+	if (disabled_cpus) {
+		num_sbm_instances = num_sbm_instances + disabled_cpus;
+	} else {
+		num_sbm_instances = cpumask_weight(cpu_sbm_setup_map);
+	}
+
+	/*
+	 * If disabled threads exists, assume the maximum threads per
+	 * instance can extend by the number of disabled threads if they
+	 * are all added to the same node.
+	 */
+	sbm_set_topology(num_sbm_instances,
+			 max_threads_per_instance + disabled_cpus);
+
+	memblock_free(__node_thread_count, nr_cpu_ids * sizeof(int));
+	memblock_free(cpu_sbm_setup_map, cpumask_size());
+}
+
 static char ppc_hw_desc_buf[128] __initdata;
 
 struct seq_buf ppc_hw_desc __initdata = {
@@ -1006,6 +1088,12 @@ void __init setup_arch(char **cmdline_p)
 
 	early_memtest(min_low_pfn << PAGE_SHIFT, max_low_pfn << PAGE_SHIFT);
 
+	/*
+	 * setup_arch() below can override topology for
+	 * pSeries platforms as a result of hotplug nuances.
+	 */
+	setup_sbm_topology();
+
 	if (ppc_md.setup_arch)
 		ppc_md.setup_arch();
 
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/platforms/pseries/hotplug-cpu.c
index bc6926dbf148..7c1c1ac3efde 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -19,6 +19,7 @@
 #include <linux/kernel.h>
 #include <linux/interrupt.h>
 #include <linux/delay.h>
+#include <linux/sbm.h>
 #include <linux/sched.h>	/* for idle_task_exit */
 #include <linux/sched/hotplug.h>
 #include <linux/cpu.h>
@@ -870,6 +871,15 @@ void __init pseries_cpu_hotplug_init(void)
 		return;
 	}
 
+	/*
+	 * find_cpu_id_range() only looks at online nodes.
+	 *
+	 * XXX: Is it possible for a CPU attached memory node to come
+	 * online after this point? May need num_possbile_nodes() then
+	 * unless there are platform nuances that can help optimize.
+	 */
+	sbm_set_topology(num_online_nodes(), num_possible_cpus());
+
 	smp_ops->cpu_offline_self = pseries_cpu_offline_self;
 	smp_ops->cpu_disable = pseries_cpu_disable;
 	smp_ops->cpu_die = pseries_cpu_die;
-- 
2.34.1

