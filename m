Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010013.outbound.protection.outlook.com [52.101.56.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9818B286D5E;
	Thu,  1 Oct 2026 19:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883125; cv=fail; b=phmUje6Qs6dSetnRbX2LA2/EccHJ7HFCibVRvGDBBVh2wILRan4ceAN6WV1OZn3e42/GmbgU7MxBbMd/05nZBaev6C2sC5Vi4bwi6rv/XINujJWvLBSFSB3HpOZWUelc2/OxdYbkmroc+HO1/tz7AEgEerm9CGbsAQt+gakzll0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883125; c=relaxed/simple;
	bh=PxARIVIQ5pL0guuPK4YGE9SIV1rsANZ8D3GfDSHkPpY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gyUwpvOpMSgJOGpz07yOlsQyOa82/K+qCrc1+QwCpwMA/kKZkCYNk+J8WMnWuQsVX8cLPjV767hJE/BBCKeJyymCh1TngY2RdXGIgIB/X5G1SZrkmwabhWGqF5FI4+fXOLD8QF6Mcw+CzDX7L6r6htg52arUhVVxtHUerLFOk+o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=D0Y+6iqS; arc=fail smtp.client-ip=52.101.56.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="D0Y+6iqS"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=oPG67yPzcgUa3Hb9RxcwqkNyLzVGIW1Kp/8jApcriBQTVMnzgI0MTG4cdzY/mLdal2BOcinQsDrBXezcncDQ2xmRse5q9BHAxhg3llTxmvPrX71VxOKBlm+vZl6tKSqUmUf6m6qsgB/yLVnNn+jP/4spv8FMb/PK8wdBZGbuigWr1k8dg0ROCt/INWG3Ju1zpcXkzNe5/FlHabbeI4ursUi3zD1wRHzJcB4vO6L17dXsNSksPz9YuQFtoqEtLBGWIxuCo+dTl/BUR9D2splpf2YLdCyzRikemKO7w8FE0jdrs9MKyWwzySbx4sKdxoqgPQkqydxJWHRLjbLNnbl57g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zQeaHS93ITPdC0zKWkCLZMYz9jW9g27rfTidaODgJeg=;
 b=DIlsXdMiow5G7GK5zDPCjN1oete+bX2dXoiUp/CvWwhaRn2rRt5pcOrjEqYTRsfKA7xjYUf8PRB+LogoQx2bOkpzo3X8rbRExrLQBJ76x3ZJPZqqeTrDRY2Klq+iYqxu/nhaQGdWySj7Bf7WudsUG3sgpOVfvFmO//jdPSSQe8353yoPmioGRAR8tliNsSij05reyRo+PUpphxoRPMMSQS7rttyB7WIpXRAS2VWx0BnlzVNl356VkaJkZnH35ts9ohWX0StX9g2LB9ZBkEpwtk6ugqon92Gd5OW0ZXA1ib+6GXhZwss9iZTdlWyZOgaXpKg4TZm/T/3I8QvlgZZFyg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zQeaHS93ITPdC0zKWkCLZMYz9jW9g27rfTidaODgJeg=;
 b=D0Y+6iqSvi61f/9oBAf9W7R4mKdyuYkRKiOXf07lcLYvXR/3QnZowaN4IfU/Rzm803AochL0HmIg2eZo5JfiqYuo2fXlZtWCZjtLX312hevMOSH3aahhH5WmhiFR48Slj2GcEVUoKe2n7BP3gt4kkbBTJSVM1/5CvB9DwbIu/E0=
Received: from MN0PR02CA0001.namprd02.prod.outlook.com (2603:10b6:208:530::21)
 by MN0PR12MB6197.namprd12.prod.outlook.com (2603:10b6:208:3c6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.428.22; Thu, 1 Oct
 2026 19:31:57 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::75) by MN0PR02CA0001.outlook.office365.com
 (2603:10b6:208:530::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.18 via Frontend Transport; Thu, 1
 Oct 2026 19:31:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:31:57 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:31:49 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Heiko Carstens <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: [RFC PATCH v3 07/13] s390/topology: Initialize sbm topology during topology_init_early()
Date: Thu, 1 Oct 2026 19:28:43 +0000
Message-ID: <20261001192849.74788-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|MN0PR12MB6197:EE_
X-MS-Office365-Filtering-Correlation-Id: b2e6f1c3-b4bd-4821-06f2-08df1ff2a83c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|23010399003|1800799024|7416014|56012099006|921020|11063799006|10067099003|6133799003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	AgXPlTBYPAuMxeJXSr4jlN336eO0seCWWAleET9Eai7I5nmU+72o6q6miKNDEjOaCcsRSEgvLJKcq9WQwgBqfk5GqngfOt8mQd9Ob/YS1B73NJnkjk8NZPMwzKHtf76pSVw7DmWLkyygEmXj4S8xmPBso979j8CA73ToFNZLp6y42K7H6IYZhz6dcuCJT73Id0uDvROU7XPbVEb6vzEZoj4AqEugi00oTEjR/5oO6m6w8/sNHFVVwIY5mVmFsgRH0LFKfiv7dfhzD4dB7DY5E2I2RUaBr0jjNgzZIm7J92+2jJ65+2a456dABh39eTBHwt8dZc4HbJI7JCnMHAjGH5n1YSpo/m2QM9Eu7ljoeDpL/YxYciBdu8iBdf7IAdIz2InXD+s2o/wX3y4ftXv9Ek3yVvxjrgR3PG+Tm5Mpz6l5zH1CQ7AYZRhDV4uecWvwCIOYiCyA/y3W4ztXMl4A4qC89MKxP6o7nQucycRW4F9Kq95LLYMy/1WVm3KwAb+7oF0vzR2oaZhVGTofxqBwN1uFDD7jX8ehz9B9LGmm3tVtvXPTxZ5LBDhURgagbyd+iBUiiTBN7XfTC/PLjHeGiSkaGURSHTWBxKxa4lVtzvAQFEj+f8MlIq9gAjAhhF4I8lpShZ58Ah7eRFCI6DQ3C8sZXJ0hnip3OK0PUE8Bhdnkq2b0TNOObisz8di9PABxzM4sCAVsncZd+w9TQOK/yTGd5oPmwg/tjxf1kanK8/1hs3LuF0YiH9UFGAfh7c3J
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(23010399003)(1800799024)(7416014)(56012099006)(921020)(11063799006)(10067099003)(6133799003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6i3VovFEO5FKQiVZrcfh4wClpVS9rCrcGPR2Cad+sGr7CorjW+3N/dnzlsbC8JqMDWPLFdXLi/3tOexoRWOH1Hsr7USBkS7xdJRrsUm0FePvZDKxKPAxEnREXY9Yjsh4WoYl8PlkTPuU7z7e5on1xocgqXvtb1fpc+NvhXn1fc7CpFLbJm+13mtxc3aweaVWNpDBCfM3ghCVTdYIHAy/0sqVVhW2GxkyeA2q4y18MX+iFNya4BgpcU/ikl4+TEe62smAZh1Okqu+gcsjfJn0HrslDWP1Xu1Ps9AHfGmbNSu8Kp+ceCTcZosfmZxGV4bMvLtnL84vC+M3hkGoAbozAE/pmD5MtMQcaCPzpeUwPoh3vj49OeqND1/DEphxgGgN1AUfiizSlzX10wturQ73aVSCz22yO5Qrgfqwg5PqSI65QqMSz4n2wRNBVrt4kXVV
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:31:57.4668
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b2e6f1c3-b4bd-4821-06f2-08df1ff2a83c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6197

When the topology mode is TOPOLOGY_MODE_HW, topology_init_early()
already parses the set of socket present on the system.

Use the socket_info to configure the sparsebitmask (sbm) properties for
the system - namely the number of sockets and maximum threads in a
socket instance.

arch_sbm_cpu_instance_id() traverses all socket instances to find
a matching CPU which is not optimal but instance ID is only checked
when the CPU is coming online. Since this is a rare event, the
inefficiency is tolerable.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Build tested with LKP's s390 randconfig with QEMU cmdline:

  qemu-system-s390x \
  -cpu max \
  -smp 2 \
  -m 2048 \
  -kernel ./arch/s390/boot/vmlinux  \
  -append "console=ttyAMA0 earlycon ignore_loglevel log_buf_len=10M print_fatal_signals=1 LOGLEVEL=8 sched_debug" \
  -nographic

Note: Since ctop needs KVM acceleration to emulate TOPOLOGY_MODE_HW, the
actual spasemask setting is only build tested at the moment.

XXX: Any way around this using cross-compile and QEMU?
---
 arch/s390/kernel/topology.c | 52 +++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 1377c6f3f670..80dc51f5ce6f 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -20,6 +20,7 @@
 #include <linux/init.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include <linux/sbm.h>
 #include <linux/smp.h>
 #include <linux/mm.h>
 #include <linux/nodemask.h>
@@ -561,6 +562,55 @@ static int __init detect_polarization(union topology_entry *tle)
 	return tl_core->pp != POLARIZATION_HRZ;
 }
 
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	struct mask_info *info = &socket_info;
+
+	/*
+	 * sbm core should not call this if sbm_set_topology() was
+	 * skipped below due to lack of topology information.
+	 */
+	if (WARN_ON_ONCE(topology_mode != TOPOLOGY_MODE_HW))
+		return -1;
+
+	while (info) {
+		if (cpumask_test_cpu(cpu, &info->mask))
+			return info->id;
+		info = info->next;
+	}
+
+	pr_warn_once("socket mapping for CPU%d not found! Mapping to ID 0", cpu);
+	return 0;
+}
+
+static void __configure_sbm_topology(void)
+{
+	int num_sbm_instances = 0, max_threads_per_instance = -1;
+	struct mask_info *info = &socket_info;
+
+	/*
+	 * Consider single package if topology
+	 * information is unavailable.
+	 *
+	 * sbm core will handle the initialization.
+	 */
+	if (topology_mode != TOPOLOGY_MODE_HW)
+		return;
+
+	while (info) {
+		num_sbm_instances += 1;
+		max_threads_per_instance = max_t(int,
+						 cpumask_weight(&info->mask),
+						 max_threads_per_instance);
+		info = info->next;
+	}
+
+	if (WARN_ON_ONCE(!num_sbm_instances || max_threads_per_instance < 1))
+		return;
+
+	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
+}
+
 void __init topology_init_early(void)
 {
 	struct sysinfo_15_1_x *info;
@@ -588,6 +638,8 @@ void __init topology_init_early(void)
 	cpumask_set_cpu(0, &cpu_setup_mask);
 	__arch_update_cpu_topology();
 	__arch_update_dedicated_flag(NULL);
+
+	__configure_sbm_topology();
 }
 
 static inline int topology_get_mode(int enabled)
-- 
2.34.1

