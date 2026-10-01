Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011013.outbound.protection.outlook.com [40.107.208.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6FAA45DF72;
	Thu,  1 Oct 2026 19:32:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883173; cv=fail; b=MyeQMFyBK4mTDgSn393Cev1FQhWINxVVCy6k4ZB2ixzSGS8BkZ+qx8COpBGNbvLTby1lIvuOraZMnst7M58inqW6z72nsThs+Pt9juNkSFXES/v+yjc2B8ttsTc94399vn6OUE/iEwmyMP+SyisFbYUdBQDxtLImN7h42hI9qbs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883173; c=relaxed/simple;
	bh=XjAbUzj5S40ln4FHHL/fIFvK9ABlmMTw+GTRXjUeBHg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hoDW4OasVE3UeWvSQHJ2/ZZoc8oONxU7LZxT+pCAxJ0lBFK0VSzhhdCVSRnuebNvjykZY9FFgpoarQpW+pfmTULspxVMR80EB4mG1LDmaDa86KNqw3m7kJ8i8b+OPsiy36Nz0TOZZCU9jTV8yJAtFADoVlArNyp4OE/dPc208pg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YaKpdDta; arc=fail smtp.client-ip=40.107.208.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YaKpdDta"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Zkj7RNCLf2bF9C8rw+Ym4WjfbUXdI/ulp8UFWgfbir4dvJ8fZbPu4wAfd2yTUFmFjZiAH3XNJYnypSvxfl26p/MScm2Et68kPZggyG2S/mzDft9yqoDXTXVoSVWb5O9RzMKsrWWyliyG7aS9NLxTT52GV5p3RIXyArOeGkoBiIqb54VvHuGOlOqPrZcwbEKjte0vbyisQz01ZnNpKqQ5eZ88niYe0MePcXSyau95MQNqjPDxC2zOV1XziszSIJTA+I/Q3fIdsA4B+3yuKwQKR/t8TMYLbOtZGrJQ8a/Whjc67QOMUVEnWcIgjDcnty/xU4R+B+AZgedjZfhsICvEtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HFPupHBN7/B6qzyxe0yjrQcCMBaklUxD9f3rJbJpJJk=;
 b=ZR3dBR92VHNOD98qFNHkDLv57lhIwWeAG4xngL0hZnH58nVIu2BgDT4yB0RhrBA9HeRna/P1yFyvTCUknmkv+TFkrukuGvjR3g+/ng/s4w2esKbgUUyDeNIKgKuDJFk8Pz7ciBJmAatK1pu55tRXkXynp6moLtEn0lUFAy0n1RWs3P6A4er72iQIrOLdDamCBM+ZSTB7YGxj79HyOguQB/o2BFNUoroLpWpf+1W6Ewj5wLAn4emv+jgAvNtD2ahZa9QevLPRRr/1/qnAy9tpUYnUg0CUg1Tu3PbzyETEG5Qlg5cwd9yqEt5fzhicl+CJsy6lC5sMxAQQGKSZTmoiiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HFPupHBN7/B6qzyxe0yjrQcCMBaklUxD9f3rJbJpJJk=;
 b=YaKpdDtaquUl1L7OkiD4WMzCfrgf31sbze95HuBq84Xby+qRfIMFVKObqRNvtc8vdfnxm9vCnfLT/zeKJ+/gntz3Ofo1FnyBcv2tQHNbJgx9uOieyELsf0rvxdUHzZUsy43n4yrN00EOj+oYzud08t6ISTWOOEsSWB92kpOBIiE=
Received: from MN0PR02CA0005.namprd02.prod.outlook.com (2603:10b6:208:530::26)
 by CH1PR12MB9670.namprd12.prod.outlook.com (2603:10b6:610:2af::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.25; Thu, 1 Oct
 2026 19:32:39 +0000
Received: from BL6PEPF00020E66.namprd04.prod.outlook.com
 (2603:10b6:208:530:cafe::4a) by MN0PR02CA0005.outlook.office365.com
 (2603:10b6:208:530::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.17 via Frontend Transport; Thu, 1
 Oct 2026 19:32:38 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E66.mail.protection.outlook.com (10.167.249.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:32:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:32:30 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, "Tim
 Chen" <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri
 Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>,
	"Andrew Morton" <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, K Prateek Nayak <kprateek.nayak@amd.com>, "H. Peter
 Anvin" <hpa@zytor.com>
Subject: [RFC PATCH v3 09/13] x86/cpu/topology: Initialize sbm topology after topology parsing
Date: Thu, 1 Oct 2026 19:28:45 +0000
Message-ID: <20261001192849.74788-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E66:EE_|CH1PR12MB9670:EE_
X-MS-Office365-Filtering-Correlation-Id: b4f28601-7561-4bd0-b460-08df1ff2c0ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|36860700016|7416014|23010399003|18002099003|22082099003|921020|10067099003|11063799006|56012099006|6133799003;
X-Microsoft-Antispam-Message-Info:
	SHnCLHW2DRH6Ryhf0qYWaA83Yo0Mh4Kj8XvSoTAK9B6pBu2jB6Qb4YgHHxoUtzZEo1W0TDYb6jsxYX4oAidU7DPJ4cJUoonlmufTi1sKQRwKNDK3HBPEtMgyR/PQcyHNsUFsFBVWJtSEZzYHYOwqFob+Xl+tBn7iTVwK1+HFy7BHHAGqcJ4yFSWLqJzRhxnFgvirk9w1YlMrULtkYHOQji+yypI9C1XVKIXkM1Iy+nZwOnfFGDinRfLHyjzNsVhFb6olUpLFCyJx5wymz3jzNH5bYwoQaNfZGjIs+eeTMQYkyUJZJyez1MrHkLpD0pTyo0iPNpxtEUpoupENTrq0FA0Tc8z9P3uRyIMgNXZQizjI9fFRcAjqEzbMy1EKPsbAoynFxocPBDGIxFrgBku0aZhCNbhZOlbiTzHq0Udn2p+a6qoIohWyBHwlX625/aL0lRABf8mAGgeTOiDQm+zUGOgoOnASoZ0QEBYXSjAbt5nSI4IWgvvVn+zm8BtVbw8RXYJSdi9Vh/wq0K4J1ojAX6+k8zNCq/JhbOQBP7OQNUtvlXFZxB+u6/3G0SVKbGU+Uk3BVmm2c+fX5jw55jkzndljTclwA+MBdrnH8q4DKcefRv1fedzYPedjuF0TTNJpbRqwyBJuwf1busHG8td5fD7lpBYzCG2U8WGPGisN/HbcFewtpL1v+IpSMLbnxHWSXhpGpVaOyaBIF7mrU7lYo1PHU+mnofh5ca03GsZpkPLUC9/Cn9p7noiRjnaiw50F
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(36860700016)(7416014)(23010399003)(18002099003)(22082099003)(921020)(10067099003)(11063799006)(56012099006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	i4UBQ+ylTfx7yQvt2iXyGidwqOomV/NPAtPVAANcB0NLB5Cau+2XislJ6WF1TJl9IG/A/BxgYQi2VGIHAuuOgCsh9E16+1i3jUmkI6085MfVNau9WmR7GoHoWae28oudWpsDsKeuWTeO1PiZ8q50Hi+3FRTtXT5p8stfXvZG3gsPkeIzQudlsm4VmLH17eFVXvhGYVwkLFRWn5OyG9XOkDecyGmS85wIUsRQRX9rdBgUkxdy5y53OucXqnbO1/rv4jVH66V3FQ9KMMEQIJTBOaYNPDR24oFpYtNL0xYq/O8bjVvJJQa6CBASa8UUi1hvUOVDjb+nf/JDgZGTCCeqWs2BehPz2wCTWdakTw8dUWx35bnp2nMNrzJQwB6QSEsfGX2+CM17bI74nVMcfa1CuzTnQWXjEVkv+CW/es32oWm/MKcGai37vxvwQsxqBZqD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:32:38.8771
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b4f28601-7561-4bd0-b460-08df1ff2c0ea
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E66.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH1PR12MB9670

From: Peter Zijlstra <peterz@infradead.org>

Once the topology is parsed, the APICIDs of all present CPUs and topology
shifts are available for use.

Use the max APICID encountered during traversal and TOPO_DIE_DOMAIN /
TOPO_TILE_DOMAIN shift to determine the maximum number of CPUs that can
be associated with a single LLC instance and the maximum number of LLC
instances that can exist on a the processor to initialize sparsebitmap
(sbm) topology.

On AMD heterogeneous processors, the Cache Identifier leaf CPUID
0x8000001d field "NumSharingCache" give true value of threads sharing
the cache instance and not the number of bits reserved for a cache
instance in APICID.

To avoid incorrect calculations, shifts from extended topology leaf
0x80000026 on AMD and Hygon systems are used to derive the domain
shifts.

  [ tim.c.chen: TOPO_DIE_DOMAIN / TOPO_TILE_DOMAIN based
    initialization. ]

  [ kprateek: Commit message. Adapting to new sbm helper. ]

(Not-yet-)Signed-off-by: Peter Zijlstra <peterz@infradead.org>
(Not-yet-)Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/x86/kernel/cpu/topology.c | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 4913b64ec592..150e098f0ef8 100644
--- a/arch/x86/kernel/cpu/topology.c
+++ b/arch/x86/kernel/cpu/topology.c
@@ -23,6 +23,7 @@
  */
 #define pr_fmt(fmt) "CPU topo: " fmt
 #include <linux/cpu.h>
+#include <linux/sbm.h>
 
 #include <xen/xen.h>
 
@@ -449,13 +450,45 @@ static __init bool restrict_to_up(void)
 	return apic_is_disabled;
 }
 
+int arch_sbm_cpu_instance_id(int cpu)
+{
+	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;
+	u32 apicid = cpuid_to_apicid[cpu];
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;
+
+	return (apicid >> sbm_shift);
+}
+
+static __init void init_sbm_topology(u32 max_apicid)
+{
+	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;
+	int num_sbm_instances, max_threads_per_instance;
+
+	/*
+	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
+	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
+	 * that instead.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;
+
+	num_sbm_instances = 1 + (max_apicid >> sbm_shift);
+	max_threads_per_instance = (1 << sbm_shift);
+
+	sbm_set_topology(num_sbm_instances, max_threads_per_instance);
+}
+
 void __init topology_init_possible_cpus(void)
 {
 	unsigned int assigned = topo_info.nr_assigned_cpus;
 	unsigned int disabled = topo_info.nr_disabled_cpus;
 	unsigned int cnta, cntb, cpu, allowed = 1;
 	unsigned int total = assigned + disabled;
-	u32 apicid, firstid;
+	u32 apicid, firstid, maxid;
 
 	/*
 	 * If there was no APIC registered, then fake one so that the
@@ -536,10 +569,13 @@ void __init topology_init_possible_cpus(void)
 		cpuid_to_apicid[topo_info.nr_assigned_cpus++] = apicid;
 	}
 
+	maxid = topo_info.boot_cpu_apic_id;
+
 	for (cpu = 0; cpu < allowed; cpu++) {
 		apicid = cpuid_to_apicid[cpu];
 
 		set_cpu_possible(cpu, true);
+		maxid = max(maxid, apicid);
 
 		if (apicid == BAD_APICID)
 			continue;
@@ -547,6 +583,8 @@ void __init topology_init_possible_cpus(void)
 		cpu_mark_primary_thread(cpu, apicid);
 		set_cpu_present(cpu, test_bit(apicid, phys_cpu_present_map));
 	}
+
+	init_sbm_topology(maxid);
 }
 
 /*
-- 
2.34.1

