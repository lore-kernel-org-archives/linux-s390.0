Received: from BN8PR05CU002.outbound.protection.outlook.com (mail-eastus2azon11011001.outbound.protection.outlook.com [52.101.57.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FAA3B388E;
	Tue, 28 Jul 2026 05:27:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.57.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216450; cv=fail; b=oKLzwtmZFBh1qpeQVxn6mCcwkUAo03nUsb9GY3n2ADadmg4mdHMPi8Z12hwvJ0sH0OTmFklWFaOdRCeTVDDPAxYFQvfGJlTFxI1GeH7QxKhW15gKAMG/aIIu74jsPtxitHBRfUxKmtaXYTrzLdYk42EAIJIFGCV3QPjqaXcYpP0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216450; c=relaxed/simple;
	bh=tmEm65HLWm8aWaZyX/8wuuD14JkV32LQ2VXPO4wskTg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fNmXylku2Y26vE+Q24MAFgMjdiUAtvjkZvtyRu3Lgy8YrtL1in66iekBcPy2KsFF/r90F25fOBIm/lK1vmvb8gfWZ6Yf6+MU2BX+WzALFgBI1CSxuFcwbx85Rdz3o91KSH2r5tBgq9t+tME6hi0oC1YWWG/Hlkjfc3AtMlXBHQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=QhOYPknk; arc=fail smtp.client-ip=52.101.57.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="QhOYPknk"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=uHXvwBC3aV3Sll/PWbhy43Ws7lJdkEGOboxHYZ6p0iJRxCJRXEtonHFonI8YgsSuOmG2lonCdG8Z0wPmwv2/9MF/tYN8xmmkMRJuwUBbPz086Q3NqgUGkLmS9iM3AM0KSl/m+jmsE1KZv7g53JpfX662q2KjWpBiCbct3qnpzkVrjwcxImwG66f4x8kSzHwLmUAzNAYaZv9cZ9NhDFkOlsuCPQ93Frx2/88MJ/9ktLgUhAufQcPrWPio4V26o4Bm+bf4btNdXSRe0/2DwNXDGiz1zErr3CTFQusMZSJL2KAAGYN0eIBItzZrlgDGiigkxjjzO/Sb3zWi348G+kPDTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CtpzmEzQvn5xRXFFWmRk07oAtx5sfR2PdQViSkq1RHw=;
 b=p1zCNQvGqrgVzs7uRUlp85OxaRj9H16kvKipUngxgJZISVXaLjAaqYOovNYgYatklw3d+JjbcfJwTPAAg+S28QnHXgRK88vQRMokWKoh/jLjbJPT3q27H12fRZNIGFu5bAi1i/02up2Cs9fYMTaHUCl1pe5zPc5MC1Inj00jHtArQ5vdueDQAy0ZHKWRwQuc5LnQoOo7hiI32XxpK1jj1TL7iZ/gnpq7PKMxlcm9bJBznL5p2lw6JIK+zHT4nylWbxG9QQKbE3vgFxJokzRocjooT6PKbsQQPyQqnWHbgI9t4049EBa4jOwbU3Vx+Wsgsk5doPwhc4456QuZsndQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CtpzmEzQvn5xRXFFWmRk07oAtx5sfR2PdQViSkq1RHw=;
 b=QhOYPknk8agr6egRMHHkeYkiUhkeUJgprrAuAFUKYuVZDRJG4F1RwftEJUA6N2czUloUcRwr2pCscj44MCVAB9Kw/Q2HElz1SQYVR1Rj3JTXqvDIqMFHjqZzOKmqFNzsW6C5a1/noD6SuhsVy0ZSyN3KjAAP3HljzD43k/zyFoY=
Received: from BL1PR13CA0268.namprd13.prod.outlook.com (2603:10b6:208:2ba::33)
 by CY8PR12MB9033.namprd12.prod.outlook.com (2603:10b6:930:71::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 05:27:24 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:2ba::4) by BL1PR13CA0268.outlook.office365.com
 (2603:10b6:208:2ba::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 05:27:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:27:23 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:27:18 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Jisheng Zhang <jszhang@kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>
Subject: [PATCH v6 3/8] arm64/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 28 Jul 2026 05:25:35 +0000
Message-ID: <20260728052540.4728-4-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260728052540.4728-1-kprateek.nayak@amd.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|CY8PR12MB9033:EE_
X-MS-Office365-Filtering-Correlation-Id: dd6f166a-7952-4c05-b0a0-08deec68e7a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|36860700016|82310400026|1800799024|13003099007|6133799003|10067099003|11063799006|56012099006|22082099003|18002099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	SjonYxm9bvmtppxldLt6BSD4tMEbsrv3gbIpYPQ9Ex68g+rgm62G8Czzfaj31WCr9xOrpMhIVQpyYJ5kBTFMK2s3XAoEGFBP8A5Q5m8l7YhfRndc3/1OVCpBRobrDBHuUDMaBsJLJ4eH+0hmACN50qiSyV0Z6iy+kn1UGLFXzY/aKu8w6WTGWgDm4Mgg2QZO70vP+Y0yPt/NyrNHdiQsF8THg90lkcnpXA8o91tRmhDCkhzzsC9dL39CkCsbxPBr4+RDkN0PdnAkbx0ycSRY1LYzB45vi9XmtCmaPZJQoEI2Q6xnY/3u1nVHdPPkiccXwoe9MMhet1gtKx1qrMWZFg2uY46s2B4vbRCXC7+4mEuz4HJ8Trsfg03i9sNhIHlZlcj6KV8uaSz3n2I5ryQasxWLPe5t8VC0DFW91wxjPClyGY9a2MQ2PpfXl1qK9ILyZnA93wBKekvXrjoGRH5wmERIXPgCvezged9OrevNMfEnIQOEltjdReHIl00rUzyPCg2uICkxHyRyVo/GG/v3BhTIwQCnGl9scUwLfWnfOW28Vxx3fmGDJ1XXrnjPw4oV3r/hB/HxFCBUo10e+0fFhnUPY9mv9Nk6svY1doHByUsgZErOIK/RWmPdMf94ecT8TyvH9HyaN3q04eOIQ+rg62c+dNtllqFo55FXNwmO3Qc=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(6133799003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	l5S3iQnWDXCRgiaaQb2wv/XHEeHaJPkm8pLVF+F/4aaj5fN+7YCokYcdcJ0nExjlXrx3Twxjt/iO83oSR10e4gQrQcBbbtyY4YL9rwYeNwLuFfu4m54BVde6RRaUkHihTZUZxZ2hUZuydNAP6Rvy9n4gs0EzCIaGniZz+s5ExAd0Vq5/juAVH8pT0lxCWgmASoktWbPNAqF+RVnI21172UHaVeUfmSa3n8jbC8KEM8peJSCBE4Qdagxyaw05rFAjPyossZuyTr21axIBZcwrKMJhnezqM3OyULsePL+GNPZKHSkQTKcAY1IqxTZ8Ps7e9OzfdeU2oNFmjlL2rR7pywUZVmcSQAAlRPGvkzbzXIBVlQkd7tVUvzBWypvOYoBGvOhuegBHBSDJWt6BuxFcCD4oN4yTHuxJzByoIl8tU79o1/PFogEka0jhwMr/JnJx
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:27:23.9770
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dd6f166a-7952-4c05-b0a0-08deec68e7a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY8PR12MB9033

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. Since all the current use-cases
are of the form GENMASK(n, 0), with n > 0, a single:

  ubfx  w0, w0, #0, #widthm1     // w0 = w0 [widthm1:0]

instruction is used for amd64 to improve instruction dinsity and
performance.

"Arm A-profile A64 Instruction Set Architecture" manual, Sec.
"A64 -- Base Instructions" [1] for UBFX instruction highlights the
immediate "width" is encoded as width minus 1 in imms (Bits [15:10])
which is patched by __runtime_fixup_mask() once the mask is known.

If a future use case arises that needs to tackle arbitrary mask,
consider using:

  movz  w1, #lo16, lsl #0
  movk  w1, #hi16, lsl #16

to patch the 32-bit mask in the asm block and return "__ret & (val)"
from runtime_const_mask_32() which allows compiler to further optimize
the logical and operation. __runtime_fixup_ptr() already patches a
"movz, + movk lsl #16" sequence which can be reused when the need
arises.

A possible implementation for this alternate scheme can be found at [2].

Assisted-by: Claude:claude-sonnet-4-6
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Suggested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://developer.arm.com/documentation/ddi0602/2026-03/Base-Instructions/ [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-4-kprateek.nayak@amd.com/ [2]
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o Picked up tags from Charlie. (Thanks a ton!)

o Check the val before using __fls(). Flagged by Sashiko for potential
  compiler optimizations that can consider val !=0 after an __fls() call
  and then silently pass the BUG_ON().
---
 arch/arm64/include/asm/runtime-const.h | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index 838145bc289d..e221a868c48e 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -36,6 +36,17 @@
 		:"r" (0u+(val)));				\
 	__ret; })
 
+#define runtime_const_mask_32(val, sym) ({			\
+	unsigned long __ret;					\
+	asm_inline("1:\t"					\
+		"ubfx %w0, %w1, #0, #32\n\t"			\
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
@@ -73,6 +84,41 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	aarch64_insn_patch_text_nosync(p, insn);
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	unsigned int width = (val) ? __fls(val) + 1 : 0;
+	__le32 *p = where;
+	u32 insn;
+
+	/*
+	 * XXX: Current implementation only supports patching masks of
+	 * form GENMASK(n, 0) (n >= 0) using a single UBFX instruction
+	 * to improve performance, density, and covers all the current
+	 * use-cases.
+	 *
+	 * When the need arises to support any generic mask, and this
+	 * BUG_ON() is tripped, consider using a:
+	 *
+	 *   movz %w0, #imm16
+	 *   movk %w0, #imm16, lsl #16
+	 *
+	 * sequence to load the 32bit const mask, and perform a logical
+	 * and outside the asm block before returning the result. Fixup
+	 * can simply reuse the existing __runtime_fixup_16() to patch
+	 * the individual mov instructions.
+	 */
+	BUG_ON(!val || width > 32 || (GENMASK(width - 1, 0) != val));
+
+	/*
+	 * The width of the mask is encoded as (width - 1) in imms
+	 * which is 6 bits starting at bit #10.
+	 */
+	insn = le32_to_cpu(*p);
+	insn &= 0xffff03ff;
+	insn |= ((width - 1) & 0x1f) << 10;
+	aarch64_insn_patch_text_nosync(p, insn);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1

