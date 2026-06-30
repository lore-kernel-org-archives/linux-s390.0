Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010020.outbound.protection.outlook.com [52.101.201.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C7943E1CF0;
	Tue, 30 Jun 2026 04:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795421; cv=fail; b=p8I1CxJcLflxpTUQDt9QMb770ImOnha6QKPn6MlVtvu5RKruhTuQs7ypNgZRr9dm190aSQ8IS7xtyxMYTYEfqMkhukCWaq74AnioEdrwuNkUTVnCuZXXWZ0MA+7MHJgPAXf96hTf4s1/Tdz6ZvtXkxFRrBvLZOL+tCr3pyerhGc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795421; c=relaxed/simple;
	bh=4CsjeFSmcvpWjxXf0DIMQHYaG1AliJwaU+JIYjpA7R8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=HPkV4y7PnJlkRRaALITs7da29iGzVlxIGaMxfVDuwXTtyVmnNku7dbOT3f5UBIOh9J+ycdSlS25+pyMuWOGK9Knjcu82Gxx2+/biTYSeR43DF6Mwi4dJJTty3smP65w1nbJ4gQAozLeZpwBBZVH3TLwOMIFIRyYE6dOtg1UyTyg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dtXvjPUg; arc=fail smtp.client-ip=52.101.201.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dtXvjPUg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=l66zFbY9P89ZjMT6GhNxkO3JvO+eWOPrBYBb2D7N63VeqTuK8agGKjI4l7nF4fbr5I1RHlVnSVE1IMHZcyt3v9dXYnt2mDHeMJQF4Z2P7OZE2l+KMJ/QoLpw4LurhHgbKY5A3SeI0mjNZgUMmPt/Wn/zBKb05QtAhEvnDsih0kgf9I496CUzAQ0UdQltxcZ99946EkRzIRZxOp1Ozm6RkHaL54LZSA6NL9MzgyJruY5rq8r/AGq+2XTG00EjIuaz1mOQm5P269/vTV/zoiqGpb+9h5ebmhsAnC65vz19XINh9uc1Mfrnj/maqQ+H16NF5bHu4kT4HFAwlrICx0fgVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dUF7uwZtz0KZ94cCUpC+w1MMbJqikQF60rR8A4vED/0=;
 b=nYUslO5dipiJ3TcRAswGT3qGTHH9q+PiVGijKOvjG+U0r1xV3gpZ0oo23aKCBgVy7KJOaSA5yqRDb95AmQMnCAm7hYVJB1o6ZNCdQ2SvGAKf+JdkkU3Q85FmQQYqyedz6QspKFU3/17jvGCmChgWnkvMKhWy0h2kTR7E3h0WcyHDLUhW80ttBPUBSk2Uz7vlDy+z8tTFjM9IVSUFMDBa8myk6GaM0D1fWCg4ayLofOQR8C9vmFZp8qAc25MFFrQcWlD8q9XOufQZUAOxo9+P7+hvXj/mKSLWEzzquSzApYnAFcmyXl6qir2iwH3XyPe+1MxhqRezV7K+WhQNGwnStw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dUF7uwZtz0KZ94cCUpC+w1MMbJqikQF60rR8A4vED/0=;
 b=dtXvjPUgFs1ms3COPTYHCRQrnU9UamPnfn4MjWrws40JspSTP8TETeE8wizi+CCIM/YziIynyiUCfLT2M4QMYEkjWTbQsCLRuYf8u2Id9mUMp8/ri2u05isyBvxjHpMxpnglSeoZYFapQsGsf8JC1ynWhs1h8Nfq6EugmGakN3I=
Received: from SA9PR11CA0018.namprd11.prod.outlook.com (2603:10b6:806:6e::23)
 by SJ2PR12MB8061.namprd12.prod.outlook.com (2603:10b6:a03:4cb::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:56:56 +0000
Received: from SN1PEPF0002636D.namprd02.prod.outlook.com
 (2603:10b6:806:6e:cafe::2d) by SA9PR11CA0018.outlook.office365.com
 (2603:10b6:806:6e::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.159.19 via Frontend Transport; Tue,
 30 Jun 2026 04:56:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636D.mail.protection.outlook.com (10.167.241.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:56:56 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:56:50 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v5 3/8] arm64/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 30 Jun 2026 04:55:26 +0000
Message-ID: <20260630045531.3939-4-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636D:EE_|SJ2PR12MB8061:EE_
X-MS-Office365-Filtering-Correlation-Id: 465e43d2-2412-49a4-1e7c-08ded66402a0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|82310400026|7416014|23010399003|1800799024|3023799007|6133799003|56012099006|11063799006|13003099007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	CU1J2mXMNd619W5PSJrqDF0iEqDmQw2wN2IUdRtyou/qrr51NmzQVyASgGoABLYUquwbn5k/Q5rK1ROK0Df0uDGgLZssIeF2YDv9hnyWh3UE2gqrGwe8lItfpDHEBvWkQhZXXosLFPvjViyVPnlz496VFKrvNHsmYhS7h68Lf2ZiWgwsqT0faY6i2XbHaXNIqEmfVWia1Pb5lZyyIixyXPGuj5JeA0/UHOZ4BRlts1XRXUhvDCtUa/FsbMGWZTtNo1bzyHXefZ3O94s1XU6nzgkJOp5mfj7BIuBxh5LyrUm3iTuaDX2uH2kg2V3Gdme0GITgB2D7RYHuM7sfuijkJVEWP8Z9JYWRRTV/DTU/2ig8BBE9NxYps/MCxn7LP+89NbJ6WXrcc2DuSTZISeg78Tt6jWbV9I4X6L+nlkGyVtCvFZmh67BYF4TJ57hCO/dW9hoAQsOZfs/+UcN1hkFtEomwYTJqq0PaCdcI9NUfhsmMTgK5KHe0DfawFJcDPNTKk/0BYOLBLadr9Tc37Yhqw5iP9hnO0MPwrstOqagniXhp59Bve04lV0rMbVt02fPQTYltDNsRNA3gdUJuOz3+YKhro7vux9psby73E/LFWZMXrx1nuYqP1nvy4KFVwN631QBYDaeR8QQInEs6tyNMI/MAygGQWePYyEDAVFiEsUPj2uOg2zZ1vxbRSrelRcJgmf0GL4FUJ0ZfBX9imiClgQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(82310400026)(7416014)(23010399003)(1800799024)(3023799007)(6133799003)(56012099006)(11063799006)(13003099007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tiAvd51zvr+0Du+widjlElD7vE2rKcdoQiw+Wr9AdU9cwnaCPhyRw8HjTUNy3FWXSBJkskZWJDladZ9b9QU9IAAp/fbWhCB+hL7YQIM9OytB66H//tHYT0o5vKMSda4SOQP4B8ePqS1hCcbShackGF/wXZnJLkFg2clzPezfA5nVHq6aw32AFVjqzIwz2PXrLt4OJMw6TUB8ZxgisEQktGE08YeMd7i3qNZimWJppPM//I5/cfRWLqRJOvdiz1yJ3cPadfaHU4bZ1jSa94S0g/0GtXLYckragF481YBRBWbUDFCsv9lGmVyHVkYDxR9w+YYes7Cb6oVnHdYfBfUE4SlKquS8rIgzTEvy556SFBSmCo2Fokb4ik1OnrAn8iRbJDQr0yYQPv75LtJniNLI4jQ4msCq3vcgfNQcjv9ebUoREe6VEDloDu7ZNARiKDLb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:56:56.1682
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 465e43d2-2412-49a4-1e7c-08ded66402a0
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636D.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8061

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
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v4..v5:

o Pivoted to using the UBFX instruction for masking since the futex
  use-case use masks of form 2^n - 1 (n > 1) since there was enough
  interest to improve instruction density for ARM64 and RISC-V.
  (Charlie, Samuel on v2)

o Dropped Catalin's tag as a result of changed approach.
---
 arch/arm64/include/asm/runtime-const.h | 46 ++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index 838145bc289d2..371c9a4bc2d4b 100644
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
+	unsigned int width = __fls(val) + 1;
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

