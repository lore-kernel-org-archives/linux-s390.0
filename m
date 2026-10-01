Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010049.outbound.protection.outlook.com [52.101.193.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E58E2C21FD;
	Thu,  1 Oct 2026 19:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883060; cv=fail; b=CD/x8CMfE6tTtCsgMlPL76MiHjvClnhOG0szvt+jwLIjxrYHJH1RwLghBueL7tFNNMrFGeLXZP3Wyu25v8jgkQMMaf75cGoaSxMkJ4zFwkPV6nbSk4YoM0JfwPztgEnZPlX0BtGhCanyeYnzYCqyEQ2KUvjqpxvoXoKOFENCPr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883060; c=relaxed/simple;
	bh=XjxT0fZ/C6orDyE/ETFKYDXCU0h12gOwOUZI6AkhKcU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uXbh5+JvFBGpdBc+tbbJLxWgDuGdQYbCBnrHIj72qY8DBYr+eb/vHsDilcfxBqiqBnFqzYaYBMWDTC5Z3yY/W1b2Ug8Xq21XvXXtHe87Saa5gBLTyLuL4ql48khtTXLYXVpQVKiXqJC+YZc7rop3pnIk+01z2b5oaCDl4wlHXaA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wrTqjc/X; arc=fail smtp.client-ip=52.101.193.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wrTqjc/X"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Oj6aar59D6m19Ru2CESXSw/XSQSIXk981uC3MKiVTGjlIogAt9O4twCQI6xkYER4fEVIMKjBTP74Et8YkL2Ls+tnvcnFp4L+wx9AXjh47ZYUdlZ47LnwtM+kuL81dp75YdhtrQvcFmQ7SUSujxtvQDDDKo0yjr9OyAbbR8Pj0++u09nK8w6HugtNTnmA8CAR9A9rClpxOJyHsYGBoU4CopvTUh7kORYTk3dMHEAaFOuYoWAiqTtQqNy6N/ekvXRN3+XXoxPkS6VEfcw3hMj3teq+oeAsRAN3FC7asyLbTz5djJO3R1i8siP3aaWDYudS+UxZIbZys30syU3A+2B/8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sSMOgds698862fj2AvDQplwuUNWTjhbayImMvShaFTE=;
 b=bkhVlTZGF6QGFnDvhIzwn+Vj9wEE7ZRFKj92QwPMiFh4/N495vr1Zk7bfwcm7L8oAD9uKwJ1r7IcrvIkW7f9WaDkORcIZGAba/Un0cf9wWvuhVO8PohxloCxia6bQtlwshlO4sQDMEti5v5J+g3aB6dBvfuu22JrZ3iRWQ449Zg7rbp0MFAzDN50m0pzxvT0ltITwUnCrLOjov+YmyHBhGhGqerPbO5mkmvtrOZu8IX96sxOZgC9RcUE0+y05PPIrwG5p5rw8a2oA0xU3vbsI9I/rwB7EGk/2GmLrGfh5/I+A6UwJPwVEdoROJG7b+cYkKIx+cCVmmkzC9C5g5Doqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sSMOgds698862fj2AvDQplwuUNWTjhbayImMvShaFTE=;
 b=wrTqjc/XQZ1IsBALg7jC83DMj0oHq92p9S6V4s3u4y6/gPPlylbB2UUFXxBJmGCoGXCBUYsKsQloxmOEfsDwHlCOEdv2o32Y1obMO5lm7zOVcFV/aU2XJNGShfChfQQMq9TIC/WQcMBlMDPdpoATvVUWs+vzeS9nkoE2KxvsaJY=
Received: from BL1P223CA0021.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::26)
 by MN2PR12MB4438.namprd12.prod.outlook.com (2603:10b6:208:267::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:30:55 +0000
Received: from BL6PEPF00020E65.namprd04.prod.outlook.com
 (2603:10b6:208:2c4:cafe::a3) by BL1P223CA0021.outlook.office365.com
 (2603:10b6:208:2c4::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:30:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E65.mail.protection.outlook.com (10.167.249.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:30:55 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:30:47 -0500
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
Subject: [RFC PATCH v3 04/13] LoongArch: Configure sbm topology during SMP preparation
Date: Thu, 1 Oct 2026 19:28:40 +0000
Message-ID: <20261001192849.74788-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E65:EE_|MN2PR12MB4438:EE_
X-MS-Office365-Filtering-Correlation-Id: 6672af75-a0d1-4e28-5baa-08df1ff28308
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	wlf5QJNcTL1kS0M4dPyNYpe/GamkCGcjWXR/Kvuv7oEVsvAciyud/HEPHicYfh73AiBbwK0XRsKlVjl0WI41LKdFYV2SgVHYBaRcdtJ2e2QPa9uN2GPud9oukPpgJAmtxrTuL5I1fEzFzAFd/B5vWo7gt1xsnTqryagfHkskKfb1HL1KMp5N/+Dl3swzGq7XaBjcnvWEjqTnmrkWhphAWe/1c04GMT3GkP3ZwSkjcZaQcM9TICSHuj77Qbtitwy5e4ua8yoQeReC4Qk/QkLcs7uDOxdrSiO9E6V+qmDxsj9xcXt2qeNbew6xoEWMVqzfWME6DJGvgHF3DNKihKJ1We6DYyhnEr5UnZRB/ME9yecaSDd7uVA/p335E98PqZ+oHf8ZogXWrRY8Sa4UrNz3ChWsygYDPvkbBEufD75WxkKhvoiz9KFWIWuw6aS1qFX7xuhYtFVazBX8qs9IeKSWAMJowRoAXGplb0uzXdrjsXuvLGWQw7tPxQHdboy7WWfWPbBS0bonyLo12FCPmvFaCMoiUHAX31xHXXpaKH4NwyC/y84Wg0+6KphuOOG3p/cwEcEKx0U0wLYgZ9R2yAnd+lLXyxWcI/B5MGIDsSnk5esII2/kkeDPT8zpIw7VXRt1s6go2tyxP80+gAIDYE9cbfhrs6XmM2RDGz6tfXvr2vRiF64dUWqYhfGtr6PYhcCX6j+B/S61Kt20aN1vf6x2SWmvk5S8FADbvSLYqEH98QjIxjxSlkA1EY5RBcBrgMy3
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	k7wA583/+GXsWrfYiRaB3m5PL4HuXG1GXpYjBCMKE6uGmpH1Sw7uXK1bBLzzgZJMuOtSkd1VFyAb16F6pvQayv7FAkbTgtxzhPeyUvwrVlHSo+D+cNmUrJ5l6bCPbvtLlfdAVD266ZGfqYkYDRgmWhYs7yzDz0vgaP2iEC09UoK96ORncz4uYh/mr7/8EVHg8RDemvHFecVx+9SJSfiP1ItrYlrsJMTUayKjgGko0+yYo7EVmQ80pTxCKLnWTUrKRjcfuZfIIyRVznePLfspRnYKPhRMaPbYgDMIbI7fukpAYJlyVV139+eVwcnMq2265HtxKUPxbx7XYTaxJ/1N6X7GIsfCZVlmrtU/pz/+c8dIhT/Nx+0oTqaOgskgQ93puNVSpYak6pyMzCrfU/KY6G5K1p6aJD1sEkTqwXkFq2UuEzK/T5jKlAH2stRZsEWE
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:30:55.0216
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6672af75-a0d1-4e28-5baa-08df1ff28308
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E65.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4438

Configure the sparsebitmask (sbm) topology for multi-node processors
once SRAT is parsed and cpu_to_node() mappings are stable.

Former commit enabled parsing node mappings for disabled CPUs during
SRAT parsing and every CPU will have a valid mapping before the sbm
topology parsing is attempted ensuring correct bounds for
max_threads_per_instance.

XXX: If _PXM mappings cannot be trusted for disabled CPUs, an alternate
logic needs to be added. See PowerPC enablement later in the series.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Only build tested with config from
https://lore.kernel.org/lkml/202609190905.OZTcO07l-lkp@intel.com/
---
 arch/loongarch/kernel/smp.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/arch/loongarch/kernel/smp.c b/arch/loongarch/kernel/smp.c
index d4b5d1b6bb01..d8155b26c4df 100644
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
 
@@ -362,10 +367,16 @@ void __init loongson_smp_setup(void)
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
 	int threads_per_core = 0;
+	int num_sbm_instances, max_threads_per_instance = 1;
 
 	parse_acpi_topology();
 	cpu_data[0].global_id = cpu_logical_map(0);
@@ -388,6 +399,31 @@ void __init loongson_prepare_cpus(unsigned int max_cpus)
 
 	per_cpu(cpu_state, smp_processor_id()) = CPU_ONLINE;
 	cpu_smt_set_num_threads(threads_per_core, threads_per_core);
+
+	for_each_possible_cpu(i) {
+		bool found = false;
+		int j;
+
+		for_each_cpu(j, &cpu_sbm_setup_map) {
+			if (cpu_to_node(i) == cpu_to_node(j)) {
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
+	num_sbm_instances = cpumask_weight(&cpu_sbm_setup_map);
+	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
 }
 
 /*
-- 
2.34.1

