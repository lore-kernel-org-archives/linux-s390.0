Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011004.outbound.protection.outlook.com [52.101.52.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 215753E172B;
	Tue, 30 Jun 2026 04:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.52.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795460; cv=fail; b=IaGZQfBcpNxFQFj9t1ZJY261kSRwMEEn9jcUqLaRHciRD78ERpvx//P61003HU0uavpyBHQtwRQykCKVswP1Lh5z6v89B8fENvj/THX6jYxGx7SfN/bujVWhdOfcwU4HXBfjNavYCLkLwA327drgj4xffUZYj0b3Wk6o/wrGyaI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795460; c=relaxed/simple;
	bh=TRiP9I/1OAwx79p3N8zhTIR69tdvnGN7v87bSYfjb38=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ovGcg/Xk3K30DsdJKUyXWk4FDBL1zGMoPGcOBtcxCtnYQVvi6Y3kSRtMsvt4V6JQ5ss754O63HLFrBK9qfI6BDyhnxL/5X/aikNwXPwGI4a9l4Ym6+C6sxbhxOSO8m2z460QsSPDpWlGOLm61PLlUVbGCNacrhVLDuopgq54YQI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=41i1odBd; arc=fail smtp.client-ip=52.101.52.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="41i1odBd"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GVr2qT7bBR1k8IrFxPH2tLVRyvlIZ74p+Nm6aPNrYJ2zGQ95hRi8huHI8lVmTjA58obJGNEhTSRcjZ7em6Wsmbpz+8yMiJCBWQLOaQhjHzOcPyGfq+6YeZajlE99TNxiYfIvC0zl8M9laZfxT30eh7S9WnSFMsd27IJyzYMtxFo9cQfLurHU/0WZKG1ZlahPDt6lYDEAd+UnC7utxcE+LC/HcAmZWxhuB6Y/y+Nq9amPljkfQpTkREexrt5CjXr4YjFwkKhnLM+I3PvLsd/yrMpzXt6oeNTKH4YaG6BMFNKc4XsWLbQMRv02LTybH22LiWPzspqAbX0nBtRUsROGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BLi5cWdrZKNXb74YwNt56Ysltzb+K5q1wRxD7Bb6754=;
 b=Bokcg7Y4d5z4spDZDU4cZ6diG/EPDC14xHV8tX0VCTL7Z3iY6cQWb60Fjn1go4+Gf2e6IDLE+tDO89V/1yHzU0sE4iiEd+OjUbHv2nL3Mbjf+nqfzdNlN4fjkooPwM0CjM0J9Su/A8FmRXigVOVeJ5wtZlpxqRgxySkczlb4wYC+cESSk4ntXTwncrjFiu6uj+0YHi7+3eybZoPRfQyr8uHiBPbjfwYjxq3PdgiCAX/SK/uhLicjhsq1BcifuP78kgy3j3W9HTX7OL+10050FdrD7VZv+bRxlV/thK3mSV5AaGwSTPBkjCqsfmgWkEjyZvsMlneHq35lSU06h6sMfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BLi5cWdrZKNXb74YwNt56Ysltzb+K5q1wRxD7Bb6754=;
 b=41i1odBdCdbqVAdYnWMOrZNkGIdZHd7zG41Bm9kMCzjDfOzAbvKUBAKdICxBv6VwlQLp4HSfVsM1ci/x0hI1i4rsGkjo6IW6fXPIU/JXPFDmj25QbOgzlZsiF9gWmqYHD3HmhB6evSIC3D8Z5afCFVNmKETlIOimWi6vxMPnuZg=
Received: from SN7PR04CA0064.namprd04.prod.outlook.com (2603:10b6:806:121::9)
 by CH0PR12MB8507.namprd12.prod.outlook.com (2603:10b6:610:189::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:57:32 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:121:cafe::89) by SN7PR04CA0064.outlook.office365.com
 (2603:10b6:806:121::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:57:32 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:57:32 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:57:26 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Jisheng Zhang
	<jszhang@kernel.org>
Subject: [PATCH v5 5/8] riscv/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 30 Jun 2026 04:55:28 +0000
Message-ID: <20260630045531.3939-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630045531.3939-1-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|CH0PR12MB8507:EE_
X-MS-Office365-Filtering-Correlation-Id: 03acfe11-7572-4487-f6ac-08ded664184a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|1800799024|82310400026|36860700016|13003099007|22082099003|11063799006|18002099003|3023799007|6133799003|56012099006;
X-Microsoft-Antispam-Message-Info:
	cD7KB8CAN1QGfXDepOF3GCWoAOIZeEJmeCXjRSxEit0MRFjCzZvqyo6wuvWHjz8xtEXzhjihL6ia9Bp/Y7sujx3Oqdr7DDptx79S9EOkwEO7MeeomWK0MHHuwMEooBknR+RAezuhmgI5WJRmBf8/tWlF5YtT3g+JPM5QS3R7gFVZ4crojHeYwuXe031KbXo7UZchvsgg+0y4nDKoeJlEWqbhqruMSZstcb0b+0kMh7OhO9ZjmQlhR0omZKKtqjdu8zYed5mHkd1Bu9u/6qS0+QlmLtaaKFjQr4TihVYNHzSbf8g1vE31Hjc4t7pkligBlUpbrwdZybM5UaxbdinsD+YlgLo3cmlzp5QV9jDp3A0W4G91B4fNzsOnj9NLo58ewJdtGN4rkZySw4NvEOkHOEjL3PLSBv+AYFGbKq+85SJ1aF03n17d637r4Eri3gKjd/W18mAA6brCiF2AzGeSWiIZ8/hrDEXa/bErPkvhBoPy2VMq+ykMj0vjKZUYFggqIkHIyCJ6Tf7zc6PQl7Z9R6lMFLHAA6sKiRZKkfu49vCfyOjuvMYF7Xryy7adxBM2VRUXJOr3y9uPx9B9vIgEmWqn3ODGBsyCg1uB2OfwtiCob8fNfFIBGVbcEDysJknY2oCeXyTv9cyP9DrU6BQLW85S+yjRzDEDsKUB61+eqx0=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(1800799024)(82310400026)(36860700016)(13003099007)(22082099003)(11063799006)(18002099003)(3023799007)(6133799003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	R4NJ/Q22Sq5RBktTQyYjuwYlN6BG0R4dmhgiKamVeAHfYAwFBNiGWxyWEFQbAVQJqa2GRAa7oVuZ/nIUd+F62C6DQxg0OYAA62iOFmrZ9VY8qU2D84QNqhs9anFwKeoEeFxrUdinc+uYRTTG9p9zjcw7tBFZkvUH49hAgVn7BAb2ZUaVtKLBovCf48jTc557xglLPFmyoygB95ibk5kZoR9q6xlouTWmYGGAZ+oalxBDKJwsAd7WYGXmfJOJV2VsNP+QtvAMVqusJKuCGWQNVSk5+E/C04OlT9bF6W92+1cJtMKLkPKUvxIdo0iWkk/HDrOJSVhoy/EQ1IC4imP2tWRjMEpF9OXbqJrs4xddRaepFn+rEOhh0gqFJlIUqKKU4aH8hqsgnOY367ZaWLFWTkpoajTRuFowY4J+9tjJu23jgmsKmHwFFwhsb3JFA11J
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:57:32.5373
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 03acfe11-7572-4487-f6ac-08ded664184a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR12MB8507

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. Since all the current use-cases
are of the form GENMASK(n, 0), with n > 0, following sequence:

  srli a0, a1, imm
  slli a0, a0, imm

is used for RISC-V where imm = (31 - width) to improve instruction
density and performance.

"The RISC-V Instruction Set Manual, Volume I - Unprivileged
Architecture" [1] Sec. 2.4.1 "Integer Register-Immediate Instructions"
notes the immediate shift for SRLI and SLLI are 5 bits wide starting at
bit #10. __runtime_fixup_shift() is reused to patch the immediate shifts
for the two instructions.

If a future use case arises that needs to tackle arbitrary mask,
consider using:

  lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
  addi  a0, a0, 0x678     # lower 12 bits

to patch the 32-bit mask in the asm block and return "__ret & (val)"
from runtime_const_mask_32() which allows compiler to further optimize
the logical and operation. __runtime_fixup_ptr() already patches a
lui + addi sequence which can be reused when the need arises.

A possible implementation for this alternate scheme can be found at [2].

Assisted-by: Claude:claude-sonnet-4-5
Suggested-by: Samuel Holland <samuel.holland@sifive.com>
Suggested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Link: https://docs.riscv.org/reference/isa/_attachments/riscv-unprivileged.pdf [1]
Link: https://lore.kernel.org/lkml/20260430094730.31624-6-kprateek.nayak@amd.com/ [2]
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v4..v5:

o Pivoted to SRLI + SLLI sequence for mask operation to extract the
  lower bits for improved instruction desnity (Charlie, Samuel on v2).
---
 arch/riscv/include/asm/asm.h           |  1 +
 arch/riscv/include/asm/runtime-const.h | 44 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index e9e8ba83e632f..b8bf842d4c136 100644
--- a/arch/riscv/include/asm/asm.h
+++ b/arch/riscv/include/asm/asm.h
@@ -34,6 +34,7 @@
 #define SZREG		__REG_SEL(8, 4)
 #define LGREG		__REG_SEL(3, 2)
 #define SRLI		__REG_SEL(srliw, srli)
+#define SLLI		__REG_SEL(slliw, slli)
 
 #if __SIZEOF_POINTER__ == 8
 #ifdef __ASSEMBLER__
diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index 1ce02605d2e43..dbf96c937dbb9 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -159,6 +159,23 @@
 	__ret;							\
 })
 
+#define runtime_const_mask_32(val, sym)				\
+({								\
+	u32 __ret;						\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		SLLI " %[__ret],%[__val],12\n\t"		\
+		SRLI " %[__ret],%[__ret],12\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_mask_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__ret] "=r" (__ret)				\
+		: [__val] "r" (val));				\
+	__ret;							\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -262,6 +279,33 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	mutex_unlock(&text_mutex);
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	unsigned int width = __fls(val) + 1;
+
+	/*
+	 * XXX: Current implementation only supports patching masks of
+	 * form GENMASK(width, 0) (width >= 0) using a SRLI + SLLI
+	 * sequence instead of LUI + ADDI + AND sequence to improve
+	 * performance, density, and covers all the current use-cases.
+	 *
+	 * When the need arises to support any generic mask, and this
+	 * BUG_ON() is tripped, consider using a:
+	 *
+	 *   lui  %[__ret], #imm16
+	 *   addi %[__ret], #imm16
+	 *
+	 * sequence to load the 32bit const mask, and perform a logical
+	 * and outside the asm block before returning the result. Fixup
+	 * can simply reuse the existing __runtime_fixup_32() to patch
+	 * the LUI + ADDI sequence.
+	 */
+	BUG_ON(!val || width > 31 || (GENMASK(width - 1, 0) != val));
+
+	__runtime_fixup_shift(where, 32 - width);
+	__runtime_fixup_shift(where + 4, 32 - width);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 				       unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1

