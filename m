Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013034.outbound.protection.outlook.com [40.93.201.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80E383EA968;
	Thu,  1 Oct 2026 19:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790883044; cv=fail; b=BeYf7Mx+WTLm5f9kjSwNKUoCbiSkKNrwpE9d9PSwbQUUlB4q7BzH7gM2UXgHGZeaqC5+LjqoSg9cNCMlyT+peRizFTLm2HgnASkgnxII792I69kxR/KPPEmrHx4zOSae5I1Fd7ty5WIOpkEwN2YNVPbYqO3Pde9SgtPFnZqn0gE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790883044; c=relaxed/simple;
	bh=3sYtMebziXW6djESRNA/ELatjgX3s9m68p18Pt/zSWQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EXVygGZ+EGOexJqhpDSpnozD0rI23tzTraBUVRAe5lFkTu+9PhQe3gzolfq7cDDtaHAp/Fumawo+x9qzODreFj8ZiptA9FjrNJt98fG+00GDlK4vCu0K4tU0xCs4BEGaZZTNiA1i3TcC79YPa4/8i5FZktg4YS44eW715NsrYbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ov2do7oy; arc=fail smtp.client-ip=40.93.201.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ov2do7oy"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s9noaVKuhLRuXRIlOoq96F7hyiAdAINmp6QJJnMOVqc7YXA8EIcAS6FCm34ce8XZh2xFyUodlxwizjWq6B0eAraadkb1W2T2jSvVWpZorJPa6MIyx9brfjGbDnBK17mMT1uojPLxpGvlMdkcKgfM8i0VzHbr042u8FMSTiP7bgeq934Ev4T5M13hUAWBQFBqBuoFcickot3k6nGDqp86HZ1VaAgskRdP5daGbue9spyxCYwEFmXAXyIlo3uzIahALe3bvSFi2c+XXHjg77HKv5CsyqMitvJZmqIw6FeDf0wV1JqmuExDLFSE/PrfFkw3Za/3r3BO/W6iG8g13ufx4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=lIPcpQKwhl8fx64/pMDj58lNQFYsHNmZKx5FpswGTbQ=;
 b=MfiGh/Sm5j4pX0GqtPAQbhpBJda/qPVyOgAl83htGL1Nc+1AL5/feLINSckHY93GuI7i+AhIt9D8jFivowxGJUpnybZBHClkRH4ap77sSY3lrFEIlcwixCWFwR1rSXfEqEWYBXhayLf9bdFzBflyDjBneezMNk0TzjrmZRrHNg2lhE7s1d5svLCGYnzyaeLkYXHU7gg+fuGNBFME0bDH4RFpx6SGlu5qM6/NURYM+iDbf/DmEwLzWjd8r5INP5UB+P+8OFkgiUFNcGaL2K9mllBGg2ClhHRPgWva98Mj3NY4ByaXzvMJPmWQbzF/AhDbe6Jf46E+8l7pWkXsoiXuDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=lIPcpQKwhl8fx64/pMDj58lNQFYsHNmZKx5FpswGTbQ=;
 b=ov2do7oyhpgLa5A9uswphvi8wUfARbE0nIgRKUSKPjVmkmLKpgUBDW42/T7YPKP4iaPhpQdUxAAYsRQwYaH1m5FReUCUodERR09h/436PTXAAmZzaFJFVRB7LWrH1w/+bUIZsX/g2KJ6AiO9kUvTsVDRxau/JbZH1zYSNVkhcCw=
Received: from BL1PR13CA0145.namprd13.prod.outlook.com (2603:10b6:208:2bb::30)
 by CH3PR12MB647349.namprd12.prod.outlook.com (2603:10b6:610:365::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.26; Thu, 1 Oct
 2026 19:30:34 +0000
Received: from BL6PEPF00020E5F.namprd04.prod.outlook.com
 (2603:10b6:208:2bb:cafe::57) by BL1PR13CA0145.outlook.office365.com
 (2603:10b6:208:2bb::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.16 via Frontend Transport; Thu, 1
 Oct 2026 19:30:34 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF00020E5F.mail.protection.outlook.com (10.167.249.20) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Thu, 1 Oct 2026 19:30:34 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Thu, 1 Oct
 2026 14:30:27 -0500
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
Subject: [RFC PATCH v3 03/13] LoongArch: Initialize CPU _PXM relation for disabled CPUs from SRAT
Date: Thu, 1 Oct 2026 19:28:39 +0000
Message-ID: <20261001192849.74788-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BL6PEPF00020E5F:EE_|CH3PR12MB647349:EE_
X-MS-Office365-Filtering-Correlation-Id: 34bacea0-7912-4458-fbfa-08df1ff276db
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|23010399003|376014|36860700016|82310400026|921020|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	htltVPk+r/TGya7jlTaCt1AUKsQicPDQHa5jEEvg6LBGnN3RMUMgBqnRwcenRaqhJTjU6pkzkFt06maXXYfoT2KPc1zgMvav2B4irO/IYFILRaP9D8gkry5G3B1kzIPkTpesFRK+yZIOP5z909qPrs4PIGzGSccdP9TwxahY7jUSG/owRtyxIrpBF7wnSMU/0eBPMYlIM87LGbOqrgDIKaGIlIQ97mq0RIUwZb2xnNaNvbMrTAyi2nA2CoRp0oD8zotJa1UwTjo2C9ptxfTlesiFvg7be/Sckcxeidd5Cj1yKHOgNIn/9XmRIcnEugMDJV/SHRsmsb/HrgpuSTFFBnism9ngQT3tYnTCJfJgbLe6dvWYTy36UTXZHZkLTWxx3kdFofR/uN6pMZ4d0RAKtTfUDD7R7ao3GluXLjf9TV0at1njA2DgoFdI1dm2xNytDVDCWVVZNFcX7YRGDKWyS+XDiwXc6vNRVtp6MaHapUgqQ3AWLKpSAcrvHMPb+07aOKLo1AIh9vmA/VrYtUQtjbRx5PJRNd9BpYkqOL2xMPYToDMypxtst0D2JRfPJ7PzJXeDAq4wjAwszQ4DkmEpJdX8M1Ijt3jBNpFCJNuAV73U9WRBivQkRX8X/DFR39p/GZpNdq19PslHRpbqD61P9cn2dReHDipolPRyIxD/Vyji4aC4JsGhF8Uh6Vmfy4yZ3WsQbLIPc7KJ9e9YBNXmLo9N4QMHUtYwiFXSNcKRcZBLZaHfwwqALZdqT26rziz7
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(921020)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OdV7YonkJpNUD8JYwKzow/IvSUPawXLC5DuLz6s9HlnUyMfxuO/Ka3i3lhSMW1Z5jWT2qyZwVA0g0LYyg2htYDRzvB/loUpIfSu+O759pcg+3Zn/NRtcELJMAnPIngaPuAq+zXH5vcPGY14YsTfJk9U/LAkBZu+bqhlrhNzth8miej3tHmwK5De2IE02C4H5ghMKW9lpIsa2/rpNaNDVOMyk3HbYcJdFa4XPBvWHDWEdLQ7YLpQ2yiy4+RqfnlnUdKvnCzifUWjXp6oo8tCarxLOX44OX+ssmNE9wCPW+qeBXdMeR4ZI4VdJ/CDDQFlPOQUFSVfv6/XXmNjPi/jF0ylcC4IWEju+bCjjXppsgHaB9Cka8cLAJSeCEjwlmfO8pE5xZy3Lh2bpLJ5piRRp4zPmYTLak04+kd1NHHEZKScSKyR7i2M7mOR/bmB/VzlI
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Oct 2026 19:30:34.6080
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 34bacea0-7912-4458-fbfa-08df1ff276db
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL6PEPF00020E5F.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB647349

Use the CPU _PXM (Node) relation for disabled CPUs too when parsing SRAT
table. This detail will be used for early topology parsing to count the
LLC domains and set sparsebitmask (sbm) properties correctly.

In addition to sbm enablement, this also helps mapping per-CPU areas
correctly for disabled CPUs by initializing the node relations via
set_cpuid_to_node() correctly and avoiding the "rr_node" based fallback
in smp_prepare_boot_cpu().

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/loongarch/kernel/acpi.c | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/arch/loongarch/kernel/acpi.c b/arch/loongarch/kernel/acpi.c
index cb454ee92b20..1f15f78713b7 100644
--- a/arch/loongarch/kernel/acpi.c
+++ b/arch/loongarch/kernel/acpi.c
@@ -311,8 +311,7 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		bad_srat();
 		return;
 	}
-	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
-		return;
+
 	pxm = pa->proximity_domain_lo;
 	if (acpi_srat_revision >= 2) {
 		pxm |= (pa->proximity_domain_hi[0] << 8);
@@ -332,9 +331,12 @@ acpi_numa_processor_affinity_init(struct acpi_srat_cpu_affinity *pa)
 		return;
 	}
 
-	early_numa_add_cpu(pa->apic_id, node);
-
 	set_cpuid_to_node(pa->apic_id, node);
+
+	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
+		return;
+
+	early_numa_add_cpu(pa->apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u\n", pxm, pa->apic_id, node);
 }
@@ -350,8 +352,7 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 		bad_srat();
 		return;
 	}
-	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
-		return;
+
 	pxm = pa->proximity_domain;
 	node = acpi_map_pxm_to_node(pxm);
 	if (node < 0) {
@@ -366,9 +367,12 @@ acpi_numa_x2apic_affinity_init(struct acpi_srat_x2apic_cpu_affinity *pa)
 		return;
 	}
 
-	early_numa_add_cpu(pa->apic_id, node);
-
 	set_cpuid_to_node(pa->apic_id, node);
+
+	if ((pa->flags & ACPI_SRAT_CPU_ENABLED) == 0)
+		return;
+
+	early_numa_add_cpu(pa->apic_id, node);
 	node_set(node, numa_nodes_parsed);
 	pr_info("SRAT: PXM %u -> CPU 0x%02x -> Node %u\n", pxm, pa->apic_id, node);
 }
-- 
2.34.1

