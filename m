Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011022.outbound.protection.outlook.com [40.107.208.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65887369D47;
	Wed,  7 Oct 2026 03:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791345131; cv=fail; b=eteEWnOStpQ2IrwQ2n0y7aJI0cebu8TKUN/qtNjQ1ufNQHRD0e3arMZJ24Lt8IBsioqThHEFOiAikwRIgAzSzVXXHDbgkLASUmJKaA5ix8gdVyVgr9It2zdgfmV5XGjiCzhg4gWxXbmsGoSVq2GfX+g5IAZ5/wsg0/fA+CqCaBU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791345131; c=relaxed/simple;
	bh=ctgq2OTu6zhisIKWUDw8cpqngQCApJFVZb+9FcfjZIA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=exRyhU2H2DKbgtAEJ1nVMzPQPsfm+5CoVwy7UnsB/ZoiaQGzyc/mbnMjy2UmqwTQlPv2kdLzWrNa8w50YE4uE2FDBLbdl5taE1oIp5gARwrPLaueRNliS9kViXrLUEWAEi81/XJjK+qZJFoIUBkERZKo8iTRmIaw/YYDhuaabnQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=OAYGMNsg; arc=fail smtp.client-ip=40.107.208.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="OAYGMNsg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=JtlEvfQTccbbwetc/XuwGNtUgF4q+cxYSO/z4Um4bSTj32VGiGOpvofvT0d0ddOASKiGRoGQZNz14oSmJ9I//wqAUzLsfutPGW3X6uKnf7nfdEyaOJE97/uegotJmFuwZeqJJXQaqbMYkJAnPf9rMzXY/7HaO84xneWPTBVjIMy1o38ZW3lTj5z0jBeumHuuwnLCcO02XLOS8W0BllQ67i0xXXvFoY2/uMyEaPRhhduBNi6qtcu3CVAwdhSzlUq4n5TFft66BmLNick5IwtJJu4oFF02KfYuOtCmNbXVBdWo/z9G0+dyvpXQgMFGPhOR5OF7bW0lf4QIPKCqKCciuw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vZ+DC0JoMWhS7jo9SIJsTqdVce7Oa/joX/iBL2Qpb8M=;
 b=vquob4HHr4JAe9hPZ8uMCYwODHgzadTOoxQ8jVCLq23b0QYdpkAIAblIaZPRrYRWydaqLDYSRkDSIx57MJcoXuSeNUOriofaCxOLmwVywiyZx91NlUj5clnpeLaRt8rxRH+LoL9raO6nEiuYCe5Cojr03e37+B82OUrtbo0w1bfZKIWFBgELcBIXKghV++qVOLCLZ9IrlLu5z4o0ceWXmBrNcdIhlRzA+MoUMvod0+YXbin2oYSKceMIbANFTA51rMUjTr71DZbbvU+1CA7JDvBJ0Tt4yDtx/0wMm+VFRwlkOcrOEPpJV2jwmqOcY0M9KbClUnH0kKc4mLLzegcLhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vZ+DC0JoMWhS7jo9SIJsTqdVce7Oa/joX/iBL2Qpb8M=;
 b=OAYGMNsggaWudo2WmxfLDOr4m5v2LO0dvdx8j5vOiQQRkQgVSYvz5OmdpJEIMWDbIZLR7tYCt4Bs7hxtJvmahdwIIamG74QK6hPvMDwxyfqhDkN4400rSc5NIiE5mAyURSQLA1ePGfmxhwUTvlvUIsqaOwWJqP3MQAtNmLFjWyg=
Received: from BLAPR03CA0010.namprd03.prod.outlook.com (2603:10b6:208:32b::15)
 by DS0PR12MB7850.namprd12.prod.outlook.com (2603:10b6:8:146::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.19; Wed, 7 Oct
 2026 03:52:06 +0000
Received: from BN1PEPF00018073.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::3a) by BLAPR03CA0010.outlook.office365.com
 (2603:10b6:208:32b::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 03:52:06 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018073.mail.protection.outlook.com (10.167.245.201) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 03:52:05 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 22:51:59 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Huacai Chen <chenhuacai@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "WANG
 Xuerui" <kernel@xen0n.name>
Subject: [RFC PATCH v3.1 04/13] LoongArch: Configure sbm topology during SMP preparation
Date: Wed, 7 Oct 2026 03:51:35 +0000
Message-ID: <20261007035135.3819-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001192849.74788-5-kprateek.nayak@amd.com>
References: <20261001192849.74788-5-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF00018073:EE_|DS0PR12MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d264537-46a1-488c-0378-08df24265ac7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|1800799024|82310400026|376014|36860700016|921020|10067099003|11063799006|22082099003|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info:
	IRkiWmf3yyh7o284aps0SmufpgRetKtwzV6/Pq5yNtVBM0MQ9IXbL2FNkxSdNH9/IMU7dViI+us3/0JoHAu1b0bzXoaNPQ9IPQMpkz3UEqPxi4MNplJCceDlaX5CXJym0It4L0NsOK/6s4S+MTIspBLBza7EHNHLEA/VXxE1bqqaNvU8Lf956W5ryLYR4PUMxO8PDaOLyC55L+xp3grpHJe5/dwWtMPdiB53vICGOeRSdTj/W8/vC11ZfBBUHIaop1Q9f1C28GnJfvW93nyGdITWOIpjslcaXFdAliPBAvYYbVtuQz+Ji1xC7mYUNbHtpRbS4dYbWgzaIreW1tr1Ol17NNB2Xj0mvG9fxFUJTw/4UFngpO6qHG8EcKBTPbbZWEpaH80HFktLlis+Zi5aEKvSakhvbUnUdp/yTQQhltmkwN9qRsXoFk0tswR6LHybqQ4QpDt520+2Rjg98fbxc9ti8CtLSGwi9wXHdPmF/hBsmtA4jNwhReQDK3BBXz2aGkek+xBS8IsEwY948on1+TEBIShyUfuQcsiaV+bjjLKqhWuMYWr/oU30f6jSlWnLVAm5E8Ksvvvrw926GhtEtT0UeLpqkppcKmDkid5vDH0XL9jKyPhwA6/zW6XdsmL0W1WCr5TUOi8tMP6+2v8HehBiQIFTpt+Ze7CjXWa56hBMxV2Gd6LVw+yG2mEj0PHccvK0cF6dWony3H/a2HluDuDKq9VRK+y+tRbeKipIPw5J4ICImtwHRFc2eDOztLQX
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(1800799024)(82310400026)(376014)(36860700016)(921020)(10067099003)(11063799006)(22082099003)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	o8Yfs8RA2sGVSuVhTXM8TpUpZxt5pX7IfTK/UYInrW0/M6zOlDTuODa3jqa0B/Wu2027v/nQu7AH+NIlH7TozFi1cKiI4u8GgTuNcvL7WQfPBGf4uAfuIY3MJLpTdBC1AdEMJqxLCaNsKLihHyuHHzzvHf46NQUx53KFpPm1lNUokMVM3u3cBhrEgXHSU1Lolw6dUtptaISc2rHuOYNdyPmcxu807fjATfeGkiGmFj3ZYa8AcQeNzJ2rBIY/lrRZZxZqbMM+P5sNL1NyKzRvsrketuVrAWQdGSKNeYBqsajLe2LB95cWpjzSwD0mWclgZizEMWAKmWQGcVmA0PLCawz5zhIo36BYg+zSwUsPnJgiE7oKmqPJlzsgwEsCFx/H1Evb5ZcUuMx1B6znKhwxmpbUxA3coYqBWJHFiESv/Dk52Yf0iI9Ewtk17sEQVIkz
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 03:52:05.9817
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d264537-46a1-488c-0378-08df24265ac7
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018073.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7850

Configure the sparsebitmask (sbm) topology for multi-node processors
once SRAT is parsed and early_cpu_to_node() mappings are stable.

The _PXM mappings are not reliable for disabled CPUs, and the worst case
scenario is considered where the disabled CPUs can either form their own
NUMA node (increases num_instances) or joins the node with the largest
CPU count (increases max_cpus_per_instance).

Since the final topology cannot be predicted at boot time, both are
incremented with the count of disabled CPUs to account for topology
going either ways.

The sbm core will limit traversals to the nodes that are onlined and it
is acceptable to overshoot the final limits.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v3 .. rfc v3.1:

o Alternate scheme to use disabled CPUs to find the worst case topology
  instead of relying of incorrect changes to SRAT parsing. 

This was cross-compiled and tested on QEMU with:

  qemu-system-loongarch64 \
  -machine virt \
  -m 4G \
  -cpu la464 \
  -smp sockets=2,cores=8 \
  -bios QEMU_EFI.fd \
  -kernel arch/loongarch/boot/vmlinuz.efi \
  -initrd ramdisk \
  -serial stdio \
  -append "root=/dev/ram rdinit=/sbin/init console=ttyS0,115200" \
  -object memory-backend-ram,size=2G,id=mem0 \
  -object memory-backend-ram,size=2G,id=mem1 \
  -numa node,nodeid=0,memdev=mem0,cpus=0-7 \
  -numa node,nodeid=1,memdev=mem1,cpus=8-15
  ...

The incorrect SRAT parsing changes from v3 Patch 03/13 is no longer
required with this alternate fallback.
---

 arch/loongarch/kernel/smp.c | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index d4b5d1b6bb01..6cf1f5ada038 100644
--- a/arch/loongarch/kernel/smp.c
+++ b/arch/loongarch/kernel/smp.c
@@ -15,6 +15,7 @@
 #include <linux/interrupt.h>
 #include <linux/irq_work.h>
 #include <linux/profile.h>
+#include <linux/sbm.h>
 #include <linux/seq_file.h>
 #include <linux/smp.h>
 #include <linux/threads.h>
@@ -73,6 +74,10 @@ static cpumask_t cpu_llc_shared_setup_map;
 /* representing cpus for which core maps can be computed */
 static cpumask_t cpu_core_setup_map;
 
+/* sbm setup data - only needed during init */
+static cpumask_t cpu_sbm_setup_map __initdata;
+static int __node_thread_count[NR_CPUS] __initdata;
+
 struct secondary_data cpuboot_data;
 static DEFINE_PER_CPU(int, cpu_state);
 
@@ -362,10 +367,17 @@ void __init loongson_smp_setup(void)
 	pr_info("Detected %i available CPU(s)\n", loongson_sysconf.nr_cpus);
 }
 
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	return cpu_to_node(cpu);
+}
+
 void __init loongson_prepare_cpus(unsigned int max_cpus)
 {
 	int i = 0;
+	int disabled_cpus = 0;
 	int threads_per_core = 0;
+	int num_sbm_instances, max_threads_per_instance = 1;
 
 	parse_acpi_topology();
 	cpu_data[0].global_id = cpu_logical_map(0);
@@ -388,6 +400,46 @@ void __init loongson_prepare_cpus(unsigned int max_cpus)
 
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	cpu_smt_set_num_threads(threads_per_core, threads_per_core);
+
+	for_each_possible_cpu(i) {
+		unsigned int node = early_cpu_to_node(i);
+		bool found = false;
+		int j;
+
+		if (node == NUMA_NO_NODE) {
+			disabled_cpus++;
+			continue;
+		}
+
+		for_each_cpu(j, &cpu_sbm_setup_map) {
+			if (node == early_cpu_to_node(j)) {
+				found = true;
+				break;
+			}
+		}
+
+		if (!found) {
+			cpumask_set_cpu(i, &cpu_sbm_setup_map);
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
+	 * In case of disabled CPUs, expect them to either show up as a
+	 * new node or get added to the largest NUMA node.
+	 *
+	 * XXX: Is there a way to establish the correct CPU <-> node
+	 * relation for CPUs that have disabled APIC?
+	 */
+	num_sbm_instances = cpumask_weight(&cpu_sbm_setup_map) + disabled_cpus;
+	max_threads_per_instance += disabled_cpus;
+
+	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
 }
 
 /*
-- 
2.34.1

