Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010047.outbound.protection.outlook.com [52.101.193.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFCF2308F39;
	Thu,  1 Oct 2026 19:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883153; cv=fail; b=VHcecK6HnBT6zYzkOBdifBWGKgr6olnGUjpW/dvHNmGkS3cukm8jJarXZ4V+zJ7B67MwLEZF1xVRpfY9o3QOpkuHKDhY8lMTHIKSORXkAnL2J81ZpCmptEqzT4NHLGr1lEnDQmC3xk4Gum9zqsAhzET+fsW0EbzFFWm54K3yNmc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883153; c=relaxed/simple;
	bh=9ezd4LkqX18fi9pYHvwcoCEeS/YaUUj+P7zOimHlkKA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nxSf9pRslR8iD9PvukFZuK72wVNYB9gQ3MxS5S2SlrRv95gjm/EhLArU+ahkxOGf7uBaB1nqt2KHhfbVwTD0CY2VIVq2sNhSqj0sjW0kP7fvn+iDgmEVexMMlWg30M084+72KK2ZnKDrWE8181N4r8qHYsSg5YQXQotyAyWMegc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=re5pxXuY; arc=fail smtp.client-ip=52.101.193.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="re5pxXuY"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RhXxWJeHQIo2SzlX0opjTOilJY+cKdKOJCAqDQP7X0XJ+tfZeuRmY0g/DummA5Q/YWpae9AWoLXs/Yalxl6WO6Z9WXKmRRZSzPazc0nfVbeZyHBd8cXyP7kdyM9m/JKK/JXNoZRIGp60lxXIkpRou+xnsrHeKMo0zJL6P0sdljf6ByVc8qCvHk5eVOMMBf7yMzSzg8DAntCVQXe80QoJk4RhOR9n/JDiK9Ibn1Bjv09axtEhgBSAjmqTY3tyQR4cqtqSXnRiYwyQIgJTrrKiCNkX1hY0tuzrmosWAlV41iMOaUqnb44zxez/jDDInshzGS13vvJbzl6E5Mth++4QVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3Ao5K1e4w0XUBqVRDbJtWkr9oeJ1Ocne/Iny8/7erFQ=;
 b=KhFnG3OQFcnudUzAW24L0eZT4xRf0zkberr8et+vAkcSub2v6Pq+zgAWE6y/p+aRga87fMLfADIYa6NJ6LgWvbEAAds7NL1WkqJJrsE647YsAhwfX3bXwDO6AELqiejesHnidugsPhoysSfa1EIKIDAshan2qk3afv5sBycl7RoiR97IcAe3PYG3vQFA/Y4+q7y6GjKy57QkAcUxaNNJAz97jQhtsGCm0//yzHXa63x+ZBxcu+fLJnlH3ix2BRubm1HpgYv6Mqp2hfw1IY6Tc9Hf4lUDewEG2hKt7IrDUn51fynBs1Y3PRnQkbUQPGjdrIO+6E4CQoHL9WmS26HZZQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3Ao5K1e4w0XUBqVRDbJtWkr9oeJ1Ocne/Iny8/7erFQ=;
 b=re5pxXuYffJc1bFq8430JdV+YWdLdHcA5OuzZvMvq/aAtjXcgchu2cR9PwEYoS+jtQDmjfJ70STHhp9cOi4IQg8orvZ7KEvsMpwkFHc5EjREfdhPzDICacOSFLWrVl/6oI6aBREU6azw8ROTtRS2GKOlgAqmRFJv0bYW1HQ3Dio=
Received: from BN9PR03CA0778.namprd03.prod.outlook.com (2603:10b6:408:13a::33)
 by MN2PR12MB4304.namprd12.prod.outlook.com (2603:10b6:208:1d0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:32:18 +0000
Received: from BL6PEPF00020E64.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::25) by BN9PR03CA0778.outlook.office365.com
 (2603:10b6:408:13a::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:32:17 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E64.mail.protection.outlook.com (10.167.249.25) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:32:17 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:32:10 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, "David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v3 08/13] sparc64: Initialize sbm topology on multi-LLC system
Date: Thu, 1 Oct 2026 19:28:44 +0000
Message-ID: <20261001192849.74788-9-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E64:EE_|MN2PR12MB4304:EE_
X-MS-Office365-Filtering-Correlation-Id: 1090bf0a-bc25-4f89-b449-08df1ff2b449
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|376014|1800799024|7416014|82310400026|10067099003|56012099006|6133799003|921020|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	G01kMJlnNnq3aEm6QBGqqHPVe825nJx2f9c+dwFXBlTgNvkK9s86eEU0P+z3G8JtGWOlPjP32CenLPmiDOcf9kv5xnB7K1ll5rvWHyOQ+QbMgPE9N7+HRyVQUXhT9+wAnCryu9hSoFMhRb6ue9zrrTC00GtDH+CsHFpwywKEaXtPBzzb/J1x7nRUbHBT8144CnN9DxMa7kYl7uhuIue9d3IbZmUwnkNxZiwZZjp6rZF+BIclOqaFDAwfQSrqsmYQYEMBNKZ+/T5ZFsHRvhiIQeadyFh8iuE8vPI6WpoEuT/k/eGrQSBXHzEb0qgkNBNFoANmJNaGjsuHYdG9XyR674ZSG9TQPekq9oOSr4wygarkBZskm1WrzMBBuHeTbwTTWspk9c/o6KxWZQHBok8br3m2QD6lflaUO2hcwVxSzzBpBqAbYTUTVu5SeZT1Tj73l8Yyor2OHDrqytdmcUrEAcmau5Arm2CIjPWeCdfjPclix/N4UXR1ZGBBJcXukM+hZN/1ZbdDhxlSJRCvcJqybNm6jltQbm96Zrov6UP8eD7KqKFPQrNLQlVfgTqJp2CtQCBhA9pwXiLTv7F9DVF7U6GzbsLJaiR14KYsx1T6WqJuEgiPTrYQ/ybjZYSsi92lZteAq9fr6wmPjaxAPQXEVNfHWLARQdWTOyilubiqSud1CStlOCqR7rHjUjb9Su9rpuuuaxTDJk7xrJ01RqZxarCY26+6iOYWGVohWk2IW9+dmR5mRhPrfYtBjo642zqK
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(376014)(1800799024)(7416014)(82310400026)(10067099003)(56012099006)(6133799003)(921020)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SZOlqHPaD74ZX/CpjpLJyyIKU4GFvqcr1XtK6zKm5uy5CIaUdy/UU1haAvx1ufb7FTxnpYQFgQHC7O8bF0Nmy8a1AEV9pyR0uaLxWRp1I+fHCd1meybgzhhLLUg1+YQLsd5Ji7lggV4gAGV2MlsieY7G0uVN3Fb7yAAfOfWnjoGD3cyzK99MxFktB0qEv+K4nE6VeiJcLzQp+N/WbVgNo4Ahb/DzK5H8Oqbdjv+QTYZSmEgzfWIhoS8rGCMQSST2XbDu//MImqtqOxXgFFzspwdZnb4SQ53rZNhR3gUog0NxMlAz5sddGri2ZEH6GRaITlt4IgQxO8mCJnS4O/B0J0a4z7V2RdFkiiXWYmBWsMDxNS7nA20zyiHs5BoNfhS0/RdlSCOwH8MXUXIEhWq+ThNdtZRUDJozZMhlnDV8o4vFaxjJfjLhe9OsoHwhDXoD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:32:17.6733
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1090bf0a-bc25-4f89-b449-08df1ff2b449
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E64.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4304

Once the CPU topology is parsed, initialize the sparsebitmap (sbm)
topology by counting the number of LLC / NUMA instances in the system
and the maximum number of threads in these instance.

Similar to alloc_irqstack_bootmem(), init_sbm_topology() is done after
setup_arch() has finished mapping the cache, socket, and NUMA IDs for
all the present CPUs.

arch_sbm_cpu_instance_id() uses a combination of cpu_to_node() and
max_cache_id to determine the sparsemask instances.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Tested with sparc64_defconfig with

  qemu-system-sparc64 \
  -M sun4u \
  -m 512 \
  -kernel vmlinux \
  -nographic -append "console=ttyS0"

Similar to some of my previous attempts, I was not able to boot a SMP
configuration with qemu-system-sparc64. For all purposes, sbm
initialization is only build tested.
---
 arch/sparc/kernel/setup_64.c | 45 ++++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/arch/sparc/kernel/setup_64.c b/arch/sparc/kernel/setup_64.c
index 63615f5c99b4..7ab52d17e46f 100644
--- a/arch/sparc/kernel/setup_64.c
+++ b/arch/sparc/kernel/setup_64.c
@@ -28,6 +28,7 @@
 #include <linux/root_dev.h>
 #include <linux/interrupt.h>
 #include <linux/cpu.h>
+#include <linux/sbm.h>
 #include <linux/initrd.h>
 #include <linux/module.h>
 #include <linux/start_kernel.h>
@@ -53,6 +54,7 @@
 #include <asm/cacheflush.h>
 #include <asm/dma.h>
 #include <asm/irq.h>
+#include <asm/cpudata.h>
 
 #ifdef CONFIG_IP_PNP
 #include <net/ipconfig.h>
@@ -619,6 +621,48 @@ static void __init alloc_irqstack_bootmem(void)
 	}
 }
 
+static struct cpumask cpu_sbm_setup_map __initdata;
+static int __node_thread_count[NR_CPUS] __initdata;
+
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	/* Combine the node and cache identifier. */
+	return ((u32)cpu_to_node(cpu) << 16) |
+	       cpu_data(cpu).max_cache_id;
+}
+
+static void __init init_sbm_topology(void)
+{
+	int num_sbm_instances, max_threads_per_instance = 1;
+	int i;
+
+	for_each_possible_cpu(i) {
+		bool found = false;
+		int j;
+
+		for_each_cpu(j, &cpu_sbm_setup_map) {
+			if (cpu_to_node(i) == cpu_to_node(j) &&
+			    cpu_data(i).max_cache_id == cpu_data(j).max_cache_id) {
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
+}
+
 void __init setup_arch(char **cmdline_p)
 {
 	/* Initialize PROM console and command line. */
@@ -677,6 +721,7 @@ void __init setup_arch(char **cmdline_p)
 	 * allocate the IRQ stacks.
 	 */
 	alloc_irqstack_bootmem();
+	init_sbm_topology();
 }
 
 extern int stop_a_enabled;
-- 
2.34.1

