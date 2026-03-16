Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013021.outbound.protection.outlook.com [40.107.201.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C0233FE05;
	Mon, 16 Mar 2026 05:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638708; cv=fail; b=VEovtblpcOsH9kKYG9l3tHspW8cTLzhINh5kfviosAsDaIkXrSkQ2fDibq45I30fA/B8lWyrwNuLmuZYuMndoYh9xSI1/YtXjzVIxH7LU50Jz0RUuLcbf5kDjXF5YS5kheqEo+Edgp32LssS8FIEtw4LCnwEwY/m8PB0sHX8SVs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638708; c=relaxed/simple;
	bh=YeggqgDqBJpM0+BfXOf8iVHNhjo1eBTLnPMtviXfmMA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PzriKJENQquIZSVPFqK0alRrMSHtUNqGz+0r77JBUYJTsBQmIqm2Oz6umGJwjQULRNiSWLm4XKP8vrO0HQFEpQ8A4BGiaJsSb99d5AIvpPYHFN+9hVvgKxaav82cFVSSsU90ZNHQmLgbOD7S852wyBC7ZX7DACuO+OtvMOOtw2g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JarAkNok; arc=fail smtp.client-ip=40.107.201.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JarAkNok"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fcf/4uiBliMGFnBNWxLO52voUNHDGmRPTyJtpKjesHzF2V440VICD2wWyi8uK7fEV0ihjxixIfbKQtyZoHbjfMVP2vaoylrrYRcEix2kyRV2zHMt+t+uXUXSqe2vhXr4vtBSCDxYLX67ILo6Hb4YVTqCleJxUfqlE3xnkUgWMnPyDAq72EPZQIPvP6k9l5PS5TnsH32pSXh5rslVO5oyFdBKeza99CO1JPq3nMWIVkW2E0LhE7mf1JoEf6t8E6RhKwn7H64Op9S8a2p8kTUJDdwgvIQcdeVd5DU7mC6VTl8bfJ2JzJmcT7TJDFmM+KsMbblr8UHCFvcWz435BGyT7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=t36xLPqDKW0J6OU/5qNiAqz6zE7HlXGRhGSuFGOuZ1c=;
 b=HqAjz+iSFme+2IiMfv7UtCrt99HhOb5toMSs+/CBVHTEA+FLnmrBLsqKhG86M5eYbSc/+ZfKNhP30Ep/7FSowkQAXGEyGYa4jvPBXrvN3YiiYoeFVonDue1PwslGvdEtbrNejklD+C8DRGAOihvLtePx7RQxecbQxTLXxzcMNjmMHIiFKNPaENTMTZ8zOpXvUuJYLP3ME4OAuzUcZZlAbjbjORXLKhuiAtM44sxx2mrExebqYtKreR4GV/5QKLylusWd9wNWMno9DFpfsoblLq85QVtPbtub8b+ybERZTG/lZ5N51AkO8Xkes1qh7LUNZZA6UwmrIUSD/8ZvnYz+Aw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=t36xLPqDKW0J6OU/5qNiAqz6zE7HlXGRhGSuFGOuZ1c=;
 b=JarAkNokvSEJPlDuHRS2ROsdi17mzUVRQsq9as8bfTr7O2jT00rnQoJmxJt1vEsBcib73zp/8ZEhgeW+irP8ga8CUDsnKCpHxETIKkPSHArVB4cGP0Bh6yGGgBNtiSPOobNZ6yYX5tDv4B+lqf6uN7Rsf4NSdBZnmYyDl1VYYe8=
Received: from DS7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:1ca::13) by
 CY5PR12MB6405.namprd12.prod.outlook.com (2603:10b6:930:3e::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9723.13; Mon, 16 Mar 2026 05:25:03 +0000
Received: from DS1PEPF00017099.namprd05.prod.outlook.com
 (2603:10b6:8:1ca:cafe::88) by DS7P220CA0009.outlook.office365.com
 (2603:10b6:8:1ca::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 05:25:04 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017099.mail.protection.outlook.com (10.167.18.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 05:25:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 00:24:58 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
	Jisheng Zhang <jszhang@kernel.org>
Subject: [RFC PATCH v2 2/7] arm64/runtime-const: Introduce runtime_const_mask_32()
Date: Mon, 16 Mar 2026 05:23:56 +0000
Message-ID: <20260316052401.18910-3-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316052401.18910-1-kprateek.nayak@amd.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017099:EE_|CY5PR12MB6405:EE_
X-MS-Office365-Filtering-Correlation-Id: 4c859d49-42a1-4103-13c8-08de831c604b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|7416014|376014|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	HgvvBYOF6AYHsrrQG7J4sa5YnUFLgrSnrNTT/Dk0cRHKdixbRwAiHhBZ8bw63HIGS37scXqRmmRxE1gnIPyhxObwB+5ngFCmOSwS1ax5EUSa3utTNvym0bbds4a7au6gKR48/NyYnNIBIOYHIupeBE84sAmdQCw2DA3b+EJAeOLCPy3RCVwzEcE6qGT/EFYVpGgi/hEKHa7VfYjdueNHcLXK2QioFIjGwYObd2Pn3R0XqPxAZeghyvBPPmnZttQOBK9WDR2xkMebql1fuxuyeo4nwENCL5bTMAUPLJflTfHVMRmla9PSPAer0HI6bTWcxcCpZ598ixybyDS1YbHQ1Ssx5yCoxUD1vgxgNMFpiIFJAqCpk1sxUKNCtZQVZVX5hY43Gm9C7CovoAPI4sLNq7IxVxjgWb7I4qayGfE7O/9oFfVyIMcYI0KBZJv2n4grSIUB1FkDNSF+XaNa/d3jBW1tniga/eP3++aZBQgJFQ0WSVscljb+tHoqH4Qj4F23V7LmYsJvW9qcvgLzMGNiYpUbiLC8QXYASTWdW9aNQ8EE1ViRIvkRtxjATyk3RcHZaiuSGGxI37vNGJBIBIyzrMJu40rJWHd1s5zzxdSuk5qvqQ6mFgjOibIVqxp3P90iH2+lpX09MB3JE9nhSB+DhuMibSfcwLfbgExI7Mv5pij9SQpRWbiVhmWvjMpcb8JpD42I6e0mRLrRZ9I9Bmmn1yQWzPBH4Z7HYjAjJalNMfPgAQ3ZG4opP0CjUUN/CDvnXi3QGgqXtP4hQsIF4Ekhrg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(7416014)(376014)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	lPL5nrIbpvKM/xsEkUz7xe7iYh80Fz715UxJawmwmyH524TLTv4neFgWpSRevstlXsVSz2+XB1R9DHJ1xGSxdmfF7IvgV/L44HysBb/6XhITl+uk4WarD/i/eEKC7nWiFfwTgL61ICLRLy3ADPNBSb/ybNurvCVSTwbm29eYH0ssQGKal03KkC+EzH4hkVERUx4tpm8mg5kKE3zovGZo41C2DJ3YvlJlxOnLHaCRulOMdh2vTO13iTJ7XDmCd1Vh4v+e0II9KcIb/C2uEvitToQbBdiMzu/F3/B9kybhd2sKPt4pppxHCLys2I1cIN7ciEYBYTkExXa/sRJca9h6zpuN7SACdxDTefZroPwJtGWR05IKLyvTfvZ+E6VMSdxgVyoEAsxJvrCH8vk0MF5g+Q5dRitAVBLECPPa9D6ahmxv+O0CWTj94ESQAEw8TZwZ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 05:25:03.0549
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 4c859d49-42a1-4103-13c8-08de831c604b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017099.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6405

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. GCC generates a:

  movz  w1, #lo16, lsl #0     // w1 = bits [15:0]
  movk  w1, #hi16, lsl #16    // w1 = full 32-bit value
  and   w0, w0, w1	      // w0 = w0 & w1

pattern to tackle arbitrary 32-bit masks and the same was also suggested
by Claude which is implemented here. __runtime_fixup_ptr() already
patches a "movz, + movk lsl #16" sequence which has been reused to patch
the same sequence for __runtime_fixup_mask().

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
 arch/arm64/include/asm/runtime-const.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index c3dbd3ae68f6..4c3f0b9aad98 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -35,6 +35,19 @@
 		:"r" (0u+(val)));				\
 	__ret; })
 
+#define runtime_const_mask_32(val, sym) ({			\
+	unsigned long __ret;					\
+	asm_inline("1:\t"					\
+		"movz %w0, #0xcdef\n\t"				\
+		"movk %w0, #0x89ab, lsl #16\n\t"			\
+		"and %w0,%w0,%w1\n\t"				\
+		".pushsection runtime_mask_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		:"=r" (__ret)					\
+		:"r" (0u+(val)));				\
+	__ret; })
+
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -80,6 +93,15 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	__runtime_fixup_caches(where, 1);
 }
 
+/* Immediate value is 6 bits starting at bit #16 */
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	__le32 *p = lm_alias(where);
+	__runtime_fixup_16(p, val);
+	__runtime_fixup_16(p+1, val >> 16);
+	__runtime_fixup_caches(where, 2);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	unsigned long val, s32 *start, s32 *end)
 {
-- 
2.43.0

