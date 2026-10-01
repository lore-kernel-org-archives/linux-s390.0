Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012025.outbound.protection.outlook.com [40.93.195.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0255B3C108F;
	Thu,  1 Oct 2026 19:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.25
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883084; cv=fail; b=kSr4J6ecAsdG9kAmaEXQDF0e+Uerzv74nvwGB4p2slnMtXPnjdc+74vxdabQfz4fQt338JllIZVkXR8BEu2ppx0hchS+7YFYmYck3eZY0gAL/4h/9089I+61QeLA+kGBZnGPFvSeZT0BpMh0SunUy7o1YWLvhD0ByLO7GKQO4oo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883084; c=relaxed/simple;
	bh=wlrc/ATYdQYEi6KqR+ALPB38Pso5YpJl88nCumCXrAQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jhuuQNxh9ToXVfWDWjEGd9k/U7G4xfES/vSQWilTTBWKsw4j/8zQxpIKDrOeAIZ2oyIFo4JhUBOkXF9wOC16a8vVcwTGtmbzIEheZqIXNWPloHFJhb5RwIfmraz+2zeY7NjNYggXmJl9Zug94QbVnBgRycenJgIvLclITxHL/s4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=no8RP5rH; arc=fail smtp.client-ip=40.93.195.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="no8RP5rH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XAKRkaCm3gZ0vr4uiUAaQZvoCiwejRjlokMmKKxpl5R2IYhjQZEfpvT/QJ4jRU0Mp2lY7G9lgN6vTYDRGy4UfZmxxG4LfyN5XTr4a/9n+/QOIx3uIY4JnoKhDdwiRn5ZCUGynE1COwwRirDr9K5hHdjlXawK/xyGQsb1zgqM4SCuozC6sxHHgVGTogobPNFtOG1S9Lbe8zdO7CFfi/Q/HUvDa7pcuu/wCpI4C8F375WW7AfAvP+gBPqgileTFw6wcKrTq745a6YvIaaLHmQD9wxTUyJS2Do6r+6P0Azvkww+zYEEd8bqCaqNVBHJgs/qF00LtVa5HZev8NeyYeyhxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VvLhKUzgoTQ/EqIndXGWZRJe7Q/mSKvK/B1i5yWhBGY=;
 b=KN1Uw19yEB7reT7Xc+Ov9wxt94oq2HHYFS1uOoXv9HNIX0gI1LZ3QCK/SGtjYP5GkwjZ0wmHtSOB6CnKYAaB93cXxQHWOFJZsz8Thtow5uKiI8AsRQ8/ReRUx5ZW3PipKQjjUgnoWBTcdxS7/A7CZV8LNVHd/RdfPySijdVJ0G9UfZ1A6ejhbRlis41SPezchfmMGyp/poDrIra7MMdrDQ+2ACCTv4uQUrgI1UgCxNoZW5NRdi5d27fkkPjQuUlcFzvWg+L+x2j9+81MHG9mOHshdyHybnpGxyapVenjo3Hin1+Bxc6mYUbLw4ZYVqwE+5IXjROc8cDOYTc+c++jEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VvLhKUzgoTQ/EqIndXGWZRJe7Q/mSKvK/B1i5yWhBGY=;
 b=no8RP5rHOwTnhqyAfymwuu51cOhbz7+G6ATUV+FpNkpWr48xLUtcWZc4aQnJEfaCT3feg4+4g6du2K0qKqbfc1iklklBTt/vWylyYE/0Vb4USluPHm/Xh9q2yVV8eBreisfCf4P08Kt2g7fvm4//jpu1EwW5Rq3SYpq8JtHsc8Y=
Received: from CH2PR20CA0005.namprd20.prod.outlook.com (2603:10b6:610:58::15)
 by DSVPR12MB985431.namprd12.prod.outlook.com (2603:10b6:8:4fd::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.18; Thu, 1 Oct
 2026 19:31:16 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:610:58:cafe::f) by CH2PR20CA0005.outlook.office365.com
 (2603:10b6:610:58::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:31:15 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:31:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:31:07 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
	<jiaxun.yang@flygoat.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v3 05/13] MIPS: Initialize sbm topology on multi-node systems
Date: Thu, 1 Oct 2026 19:28:41 +0000
Message-ID: <20261001192849.74788-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|DSVPR12MB985431:EE_
X-MS-Office365-Filtering-Correlation-Id: 36954c3a-e5ef-408b-975c-08df1ff28f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|23010399003|1800799024|10067099003|11063799006|56012099006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	XJEk8uPrapzqHOPa0AACTTwBvCgNGgglRtkoCNUIK8zS4gswod//RXuTBrePSi582Hu7/QbWyQJ4eSrZggXSG5ZmPWFKE2sl0vWE9t7ZMkKl1E3Ub0ebiA5BDnOFbcad+g99/YUVxG7kS+WmVitLLnOMR/WuRRoQ0Im2oLeMWb4Mh3Ncc6eIRQz7oWnn0ZIk4BIjtJc5Wkt9KzJKB+VGS07uk0MLJz3ES0itW3GO90WvNT7Bj56QKC3jFs6LyP34S4FZPXfUGLh1PBa3MCLERZ/CI7ixySCxVnlzvlEE9+VfHJYDoKOaFzA+j5MMCkFtz+pj/DLV9YvntljMY3WzHc0nHqM5qtYR9Jh5T3JP5Vynjl7sly89FTdaWXEhWc+yvWT7/sQcGTlmaRvpbdge3q89/zGlKDJJySRDvDQv1xcYz54DOZXJJBcJ/elrWmqvvn4W1Tf0/MZVajsobRfnVKaSPJ32Wwsf8PsYiIsYytIqxiLwRrzesnmd+wBHqeiEZQhzKlYShX0aW5CiGfzRp5xgJ2q6KnFIXe94XOo5YhzEiW8AlszxrNLRyvDVmXTfFUNfuBvKjXkLI7kMS6yClVO5f9UsH4TqbA+ej01HZ6B93AIDLYODankNp0eW+P+bCUEbUGMlufWsMJuZCvwTAK2Ndal1E6+EN5t2nr7UgHKUzL0iSZ9nzAyuryLAifVIfww0b0kdPdAHNtHeYpABsw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(23010399003)(1800799024)(10067099003)(11063799006)(56012099006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kJIiaujzXIRMtGt4ppWr9i62nWWrTYE9mXt9IivQlumXfQy+PqqKoijZfbf9dIkFAiAD0+9BmLeh/5tnW8i4k9WwL4EOtvlgi+crycqKSx1JCMRz96mxeWLo85mF73P0F4WFGW/erZBoinKEqo7uXlWkPuyBYsRYLFLrMqtDDCQ1HHls2KBNyfUhQXjEL6mYinYpdvBebKdshcxmJJyet8sk8bAMR5Jp5sMgLXoY751fPn/u1f/v9osbaqIfZKsG/32s5aEtUEIf7M+PQX4IQrz71B9uCmNcLE/e65P/OfFqlujBOwv3CDVvMdK2MRAScWSlr2QFzFliUpg7xiCCqsbBWIhkSAGq42G25tMnsQa0veXxpNIQGXxUe3JwY6ZGx0MRsHWLiTI1HcYBKiAaXdEta3nU7gg3BWfkIJJjdapYLP0Skm4KRASyrU6tZBnb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:31:15.5443
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 36954c3a-e5ef-408b-975c-08df1ff28f41
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DSVPR12MB985431

For MIPS systems that support NUMA, configure the sparsebitmap (sbm)
topology.

The two systems that toggle NUMA - loongson64 and sgi-ip27, find the
number of nodes and the maximum threads present in an instance. The
data structures used to parse the topology are marked __initdata to
allow reclaim post init.

In both cases - loongson64 and sgi-ip27, loongson3_smp_setup() and
node_scan_cpus() sets node IDs for all possible CPUs ensuring
configure_sbm_topology() captures the full possible system.

arch_sbm_cpu_instance_id() returns the cpu_to_node() mapping to derive
the instance ID and group the CPUs sharing the node on the same sbm
instance (leaf).

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Tested on QEMU with loongson3_defconfig from
https://gitlab.postmarketos.org/royka1/linux/-/blob/apollo-7.1.0-r3/arch/mips/configs/loongson3_defconfig?ref_type=tags

QEMU cmdline:

  qemu-system-mips64el \
  -M loongson3-virt,accel=tcg \
  -smp sockets=2,cores=4 \
  -cpu Loongson-3A1000 \
  -kernel vmlinux \
  -append "console=ttyS0 root=/dev/ram" \
  -nographic
---
 arch/mips/include/asm/topology.h |  6 +++++
 arch/mips/kernel/topology.c      | 43 ++++++++++++++++++++++++++++++++
 arch/mips/loongson64/smp.c       |  3 +++
 arch/mips/sgi-ip27/ip27-smp.c    |  3 +++
 4 files changed, 55 insertions(+)

diff --git a/arch/mips/include/asm/topology.h b/arch/mips/include/asm/topology.h
index 5158c802eb65..7a57cbd59819 100644
--- a/arch/mips/include/asm/topology.h
+++ b/arch/mips/include/asm/topology.h
@@ -21,4 +21,10 @@ extern struct cpumask __cpu_primary_thread_mask;
 #define cpu_primary_thread_mask ((const struct cpumask *)&__cpu_primary_thread_mask)
 #endif
 
+#ifdef CONFIG_NUMA
+extern void configure_sbm_topology(void);
+#else /* !CONFIG_NUMA */
+static void __maybe_unused configure_sbm_topology(void) { }
+#endif /* CONFIG_NUMA */
+
 #endif /* __ASM_TOPOLOGY_H */
diff --git a/arch/mips/kernel/topology.c b/arch/mips/kernel/topology.c
index 9429d85a4703..729a811e8b99 100644
--- a/arch/mips/kernel/topology.c
+++ b/arch/mips/kernel/topology.c
@@ -5,9 +5,52 @@
 #include <linux/node.h>
 #include <linux/nodemask.h>
 #include <linux/percpu.h>
+#include <linux/sbm.h>
 
 static DEFINE_PER_CPU(struct cpu, cpu_devices);
 
+#ifdef CONFIG_NUMA
+/* sbm setup data - only needed during init */
+static struct cpumask cpu_sbm_setup_map __initdata;
+static int __node_thread_count[NR_CPUS] __initdata;
+
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	return cpu_to_node(cpu);
+}
+
+void __init configure_sbm_topology(void)
+{
+	int num_sbm_instances, max_threads_per_instance = 1;
+	int i;
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
+}
+#endif /* CONFIG_NUMA */
+
 static int __init topology_init(void)
 {
 	int i, ret;
diff --git a/arch/mips/loongson64/smp.c b/arch/mips/loongson64/smp.c
index e584299d0fde..22174ae2b574 100644
--- a/arch/mips/loongson64/smp.c
+++ b/arch/mips/loongson64/smp.c
@@ -17,6 +17,7 @@
 #include <asm/smp.h>
 #include <asm/time.h>
 #include <asm/tlbflush.h>
+#include <asm/topology.h>
 #include <asm/cacheflush.h>
 #include <loongson.h>
 #include <loongson_regs.h>
@@ -493,6 +494,8 @@ static void __init loongson3_smp_setup(void)
 	if (smp_group[0])
 		ipi_write_enable(0);
 
+	configure_sbm_topology();
+
 	cpu_set_core(&cpu_data[0],
 		     cpu_logical_map(0) % loongson_sysconf.cores_per_package);
 	cpu_data[0].package = cpu_logical_map(0) / loongson_sysconf.cores_per_package;
diff --git a/arch/mips/sgi-ip27/ip27-smp.c b/arch/mips/sgi-ip27/ip27-smp.c
index 62733e049570..244f8d987f13 100644
--- a/arch/mips/sgi-ip27/ip27-smp.c
+++ b/arch/mips/sgi-ip27/ip27-smp.c
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include <asm/processor.h>
 #include <asm/ptrace.h>
+#include <asm/topology.h>
 #include <asm/sn/agent.h>
 #include <asm/sn/arch.h>
 #include <asm/sn/gda.h>
@@ -80,6 +81,8 @@ void cpu_node_probe(void)
 		highest = node_scan_cpus(nasid, highest);
 	}
 
+	configure_sbm_topology();
+
 	printk("Discovered %d cpus on %d nodes\n", highest + 1, num_online_nodes());
 }
 
-- 
2.34.1

