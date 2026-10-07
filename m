Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012021.outbound.protection.outlook.com [40.93.195.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF3A3B3C1F;
	Wed,  7 Oct 2026 03:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791345162; cv=fail; b=rQBpmlqK+NZFTUKhQVZNInRdLEoOq2EyKM8wuu1OgOCNiJFuCm6cAkECTF/3Gk9bRbrJw4Lo8KgDJgGOnVu8EUS7pI1NbPGYLw/Q1Y3y1bYH8jzUbKrfSkA7Lo2rNcGb2n4OFBjzJNuqFDsgHYbz1xmUmHVsSsRYcQiDpQHLcLE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791345162; c=relaxed/simple;
	bh=eyDP2anxbMtdTWAl4YEruceABPhuTc6vpoa81p1GlWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=k5XZ3+h6PRyG5WsY0nouVXVtvEN6HDgoxdKhGJBntSNuCbkjQFGYiOau1pyn3ps61b2QU8We09e+G/cJTy7DCPx9a9htzx7WVjYWixKRxiBzGVh5DiT9LFRpoQnsLAsCxWR/+a0GVmOqt43mS5kswBz6EGgjSu6QAWnRUUtxxX8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2FwSWsTa; arc=fail smtp.client-ip=40.93.195.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2FwSWsTa"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GZTnOVKyULysHXNBNvFNxESFhlOP+uAqJvzPc6aCDoofF56bgvOXU+M8ziSje4TxGt6/9qVs1dKxyOt9a7V+Ljn18xlNAVRJ2ob8IpH9l6HprM/EvmZRCPR3tx0lQkgTRl005lckhzAYT1wfo04V0Tn5fJrcYlfM+zlUOHn+MmvWi3mA2WE9Q1aEl42kJ1skJji89xDdagFfOG7UVEkiiMXUn2d9uPgPqyFg0bY55HpaYc0qFLfKNIMM9qASKyFhybMLWIzn56ceTZndgh1xEmCytFiwCOMJSAsBJu9kmJ8hmbfQ2aM2eegC30PG6mUW2A14EeykNh/EKUeiRJKNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pYfQh2Jwli8K+8LsrUYCpg/4zOqOaeKX4H9VfuHYIu0=;
 b=uLK/+HKbx3Q14gkKIIEpNeItv51RcfwZwOhH3HFLX3r0lVMPtfJvvnq4OAnsALHEUAM+3ATJ4vHuvIm8TYZ9zRLcINoyTAosF/8Ac+HkXol4Iam/8tSdI5CnfTvESpHK38ktqay0vLZ0XVmp7FS7yqByDvxA3zkMU46UOS7u9hx1HSibW5JAZoz2s8G2Xt5Rov8X51QETvQn3ZNkZiaISVc1TNbuCUVQGLf5Aj5i+j2f2Iqzl+ooEqcJJhGBeQsazyle+HDmpgFyFKe+oGQObShe5bTvHkDN1tSnPhBOyGrkThAfSxI28aAVF3ntMzXP16kTeCBLS5JUk5gkrT1u+Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=pYfQh2Jwli8K+8LsrUYCpg/4zOqOaeKX4H9VfuHYIu0=;
 b=2FwSWsTaV4G7H6U+akEMDgOPGrQ01xXnFgPYX/2TS4shSxNvf6ahByexTFgO+MUDLiA4d0y1l5rkYwJfvWN4zxRAU+lBnfrBRE1FBjexGtxNGaqyVwdbuTE9r+Wrrekohx0omfqBbypNdR5nrES5OEHaC08OZMkHfdc4YMipl3A=
Received: from BN0PR04CA0069.namprd04.prod.outlook.com (2603:10b6:408:ea::14)
 by SA1PR12MB9003.namprd12.prod.outlook.com (2603:10b6:806:389::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.24; Wed, 7 Oct
 2026 03:52:34 +0000
Received: from BN1PEPF00018074.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::2a) by BN0PR04CA0069.outlook.office365.com
 (2603:10b6:408:ea::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Wed, 7
 Oct 2026 03:52:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF00018074.mail.protection.outlook.com (10.167.245.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Wed, 7 Oct 2026 03:52:34 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Tue, 6 Oct
 2026 22:52:29 -0500
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
Subject: [RFC PATCH v3.1 09/13] x86/cpu/topology: Initialize sbm topology after topology parsing
Date: Wed, 7 Oct 2026 03:52:20 +0000
Message-ID: <20261007035220.3839-1-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261001192849.74788-10-kprateek.nayak@amd.com>
References: <20261001192849.74788-10-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BN1PEPF00018074:EE_|SA1PR12MB9003:EE_
X-MS-Office365-Filtering-Correlation-Id: 480ed2fe-573a-4e0d-12dc-08df24266bb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|1800799024|82310400026|376014|7416014|36860700016|56012099006|10067099003|6133799003|921020|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	V+wvNzIUBPxBcE/ZFNIhFTI61gprKRLE9NN4kNFeP7Ecjp8okonTSZnOut6JCuGv5BrNn1lskYR+oTkaY5qk9aWG9den/AcZ1UIXhSG8A3NeqhalSPfF551F8PMtFr2Gkdpz1ysLuDiQ5fUpoDfD8Vpg8lnw8PTb9DF2ttOToPwjvLKDbMHcuy9p1BsDAbvqT95HHH+2cwZtyxjDmgN+BOkkodamQpF54vWNOlfnpeoYgkZeYtUuGZE50LRKQzY7zQdClOkg9DPctjHLzPD28dtulTb8TOh0BL1Jx2UoJD+3UE7K6AT4M6hzzrQD4BbVTe1k/aBiqZ/dFnmrIgtUFR3pqCnxfJffhJh7xnYjcWVmX/2WnWwAEC7OOpRLfsiGSHZGIyDFsGy89vNEWgIm3xLf2OL7gQsI/yjfCfCtFJ1/z0vwcIMS8hfGxw62FPPQPesE+yMRo2qtm7slk4nJnpPkrPU5xDppVRzWCTRq91RbGDq0kCxXBuwf6B7dLh0fEBAzKRX8otv99zHeUfucKcIJAzAdKw0zvtlI3nPjmeRR3DO5l9ufhQcCIYkxCBk8Dxi30lUb5576OMmJbOqCezJvcac6ad5uHuXNYab66GnfgBJcrpDsWJw4zaVrXx5zA1UWtfgvARXc7KbiA4FAR7GlDpywgnpPLFcADMdcDGnZ9CkLydW/NGF2H55nLC9OkqviiAomH6+JYGz62Cn5a55YqrUfqKhkbAs4nGVcYy/Od5YinMgjJ+Uk3mBxnJjg
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(82310400026)(376014)(7416014)(36860700016)(56012099006)(10067099003)(6133799003)(921020)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DA2H36uuTtaDgT+CWCukY6nWRqBEcQMXKOk9N5jLq8ZbzppwF2Y8I3AZ554Qh/WBiKXLHfC8c0Y5TEr+oyCh5yvraxLC2Lljaqb5QuPW4i5N6SSavb/nEzYdErCxq5G26uNoxJ9o0cC2WFAZpiNgnjzJax5K7qvXWaU+oME57KBPb10sSiNadiRKsnfVLnKviNIB2PWNtrTmIJlsfk0AzMyPTlOb9HFeWGBOFgAfLyFlgYpTU36TiApPFxZCc16AgU389OmHU6TE0pua88G4HvRJl572JT+tOjuketzA74RFL7XGbeI22y9f6iz5pnPKhr8C2IxSigTEkNbMDzzkX/f4zJgWf2zfPRgpQtXvI6O7lWBMXoLu8EcjUR7zdAIYzfi830klVsKncZUI4EmN5ZTCqHN9i/l8j2CjB/2ONuDE0Oj5xlIJUf9a3vqQUAgT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Oct 2026 03:52:34.4180
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 480ed2fe-573a-4e0d-12dc-08df24266bb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF00018074.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9003

From: Peter Zijlstra <peterz@infradead.org>

Once the topology is parsed, the APICIDs of all present CPUs and topology
shifts are available for use.

Use the max APICID encountered during traversal and TOPO_TILE_DOMAIN /
TOPO_MODULE_DOMAIN shift to determine the maximum number of CPUs that
can be associated with a single LLC instance and the maximum number of
LLC instances that can exist on a the processor to initialize
sparsebitmap (sbm) topology.

On AMD heterogeneous processors, the Cache Identifier leaf CPUID
0x8000001d field "NumSharingCache" give true value of threads sharing
the cache instance and not the number of bits reserved for a cache
instance in APICID.

To avoid incorrect calculations, shifts from extended topology leaf
0x80000026 on AMD and Hygon systems are used to derive the domain
shifts.

  [ tim.c.chen: TOPO_TILE_DOMAIN / TOPO_MODULE_DOMAIN based
    initialization. ]

  [ kprateek: Commit message. Adapting to new sbm helper. ]

(Not-yet-)Signed-off-by: Peter Zijlstra <peterz@infradead.org>
(Not-yet-)Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog rfc v3 .. rfc v3.1:

o Fix incorrect shifts derivation by using
  "dom_shifts[TOPO_TILE_DOMAIN - 1]" instead of
  "dom_shifts[TOPO_TILE_DOMAIN] - 1" (Chenyu, Sashiko).
---
 arch/x86/kernel/cpu/topology.c | 40 +++++++++++++++++++++++++++++++++-
 1 file changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
index 4913b64ec592..7467fa90b879 100644
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
+	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1];
+	u32 apicid = cpuid_to_apicid[cpu];
+
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN - 1];
+
+	return (apicid >> sbm_shift);
+}
+
+static __init void init_sbm_topology(u32 max_apicid)
+{
+	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1];
+	int num_sbm_instances, max_threads_per_instance;
+
+	/*
+	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
+	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
+	 * that instead.
+	 */
+	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
+	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
+		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN - 1];
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

