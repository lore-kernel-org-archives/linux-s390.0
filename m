Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012050.outbound.protection.outlook.com [52.101.53.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C1AD3B3896;
	Tue, 28 Jul 2026 05:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216490; cv=fail; b=X/XDd9rfDjSM2nSXxfArAMjRJa501PwYCX6K1SMqQ+J+8H+VZUwODXLwS9w/Qp6pTHFKwMQJuBd1IDkYGBucHmLiV44kTozZUYsy/3BHoo3V9fxbdxoy2y6Smk6pOet+wwHqOYQZlHct5hmSgJRSHIVqLpB5ESU7krWVAAlRV6M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216490; c=relaxed/simple;
	bh=nZVe5q2942oP+aSpst3sMexFmRXwy1RZ/JVxt+51qWY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tbxeBrJeqTH2fhLmq6DfcB2wbe+Htu0vHoTXFL/GYRNReGP5wC8bcghThrLRKUTktFlRbJdXTZobFwh4Fabl9NpWUxpbIkRiULx70NVrT0kpfk7/raXjcLqWv4GBF1faf68zfE9C9DpTowYdiPCtvbiw5YXpP7kjFtqOzlyIIMQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=m3lRfsUV; arc=fail smtp.client-ip=52.101.53.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="m3lRfsUV"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yjp7QUA7Oyn9A0anqmKLw4xEbVsfY+o/54YndNi9UPAzEjf4Sm8+CRL8DU6WR73KL/9FUJ9OZ84WAWY2NrA25MZmnT7ac1pTlSTZLgpn2o41hEsPrH9dT3HigmDeXnLFH+VnvUn5xlvyjLNt/c5qQOVaNNxfG5YyA7R+ZG7/YXrDQ6UXWgIDuDsBt/nLiGX476sgqUMayE+Y2p7aWi5lOudqZP+0B2Ze9ehKrKC0oSRbaZghFBYKGypSz3GMa/o4biKfQq3g+Qqe5M7DSUw7PVGXlDKVYc/zJrYHX1AZNnTD0S1Oxe/8stFnvVighVfFSkHPYDhwyG6iFfIMSRT7vQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zFcdVEPU5NV+tAUh8A4Lt8Cfk0BiTJUz9G2Jv8UAAU0=;
 b=yvMm1A2faXnOvcnayh2JJeEgMT2WZD0s9isLbEBh94mkm6kD2jjxTPvWpnRMCG8TUUTW8/DFUOCldo7uPw0Ps9yz8IyIEp6IG6oWNJFGGojwLK50JyE+5oqc7kHMb6UHK3ba458460HW9CbCI1fEX3fgDpMzwNGd9Fsb1vfmy1nct4Ou8DK1YXOXEmqVCuHQooA08VpRqkOdD9nBGp6Dk/g67I/XluC6x7YWHowAU0of3pXx/cZslV0a8RqgkdgpLou9BiqPd7N80wIsRSLWakkTDQBAO0VV7Z8MMzKVNvbv+5FBK6LRvBKZ6TUbqQaO6rX+FbkR59AEatJ0Znu9eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zFcdVEPU5NV+tAUh8A4Lt8Cfk0BiTJUz9G2Jv8UAAU0=;
 b=m3lRfsUVWY4HROGVDkY8F4v9soM/PXUYOhlWS2w1oWYnE16xGBKgXCBca5SwhuShYo3SXxnYshoV/sJ8J4wdHXQpcoXjOKf4uSuwrFN8n+Z++CJhrZWoRK8mMMTqyTGBCtsMX0KgoIjodVkcKMiTyYaLix5+I4GT5Z8U2derFsI=
Received: from BLAPR03CA0019.namprd03.prod.outlook.com (2603:10b6:208:32b::24)
 by SN7PR12MB7836.namprd12.prod.outlook.com (2603:10b6:806:34e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:28:04 +0000
Received: from MN1PEPF0000F0DE.namprd04.prod.outlook.com
 (2603:10b6:208:32b:cafe::4e) by BLAPR03CA0019.outlook.office365.com
 (2603:10b6:208:32b::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 05:28:03 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DE.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:28:03 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:27:55 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Ben Dooks <ben.dooks@codethink.co.uk>, Thomas Huth
	<thuth@redhat.com>, Samuel Holland <samuel.holland@sifive.com>,
	=?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@ventanamicro.com>,
	"Jisheng Zhang" <jszhang@kernel.org>, Guo Ren <guoren@kernel.org>
Subject: [PATCH v6 5/8] riscv/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 28 Jul 2026 05:25:37 +0000
Message-ID: <20260728052540.4728-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DE:EE_|SN7PR12MB7836:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb096fa-1b15-44aa-3888-08deec68ff18
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|1800799024|82310400026|7416014|376014|3023799007|11063799006|10067099003|56012099006|6133799003|921020|22082099003|18002099003|13003099007;
X-Microsoft-Antispam-Message-Info:
	iRmEY08OcIY3RDU/qPpHGDAp/hazWoy6XiELb6Cr2y14c3JnmsKoXMrivwVNqJYkXWYJrZT+nHK/p/fDSnvySYuBTu9G7Me/GIe5Wchf5AT9inAWDzV7Q6jZG1fqvQIhV7VZBsIAq2cR7wuPhg+ZgSOjzcQfNC/eZ61HltPtTfRQ+Ra37ehH/wDgsr7ECFVIvuwgTr1FW4PBvzKselWAfx7x1ptexXD+McQDbqxdtTMjYKE2Xrq/w0REPJ9/IdRreSE5DqgxcHqGCptiH7wUPJQf20Yl2oi1NUe9eCkk1zWTmAWaFJRpG+Pbs0/C4kaYzbSxSKr1e527GK7cUXdvSQav4/eL6uhc+4PrtTUh0XXMLgCAXUmaTY+/nfKQv4ysi1foatygN2Ju3Kvp/u3EWxZ4c7OZjV/tNVzfM2NY12uGPjZbhrDHn38ev2uo92ecxYRREa/nhKth9cc1vYhDRcDQf9bbdFrGGk+TV7FrLFOrbI5Lt2SfEC5ulRIEWwRmdnamK6UvvwXn/RlbhKpO1Geb70IwYjaVWqE2okuDRp9/Am6sN9111v/GrH7eUV2XjUEnu83xgEwUDay7mgKVtMkYf/KWr+jj+Wtu0bS5fqyICzXeSaOJxYCe9A9isV4WgxmgI13T4i0z3dc2EVHrM2wzScRKOAx7bzrFfgysqAFWCYa/bYN7Dl9BWU2XfksMzcPMAQz30VGy9y9QcB42NQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(1800799024)(82310400026)(7416014)(376014)(3023799007)(11063799006)(10067099003)(56012099006)(6133799003)(921020)(22082099003)(18002099003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dLSDXFbmssKinX+Irkv9QyWfmzM8MDiSgd9gYPyqVPPPlRe3yYxaFVGtODsB1adlCLW9uve9qE3AboXiIUAx8QyVVOB2ueFkg3kTOEViEXI7sBxggHzNkaC4lxJCGER2bfNZ548CGK3Nr8A6dN/f/wf4//ykfJKNi+8fpCozFbCWZXJKKUxJHh0OISDuhoAvZLVq9ROCqMWtXkjXqq8uq+kNEftK9+26I23wbeoBjePoDNRzUiC+MvWfo14R/JWuk0zhWZYpbk8F1DjbB/xOYvHXSw6st+OtL8XNKjqWMVlFGsU/u6XBFz+JpYCcJZwBa76a0aQvLUaKJrTnlt2wTvxGJNbyIqlLWmPGaunkjn2yQKoO4zLNgN6WK+SwCo3to0dGUO89hD9xrt8YW+ipp9iGY+9SoGT9s2MoG18HQAO80dLGTjk0wCT16nGd9RaL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:28:03.3296
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb096fa-1b15-44aa-3888-08deec68ff18
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DE.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB7836

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
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Signed-off-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o Picked up tags from charlie. (Thanks a ton!)

o Check the val before using __fls(). Flagged by Sashiko for potential
  compiler optimizations that can consider val !=0 after an __fls() call
  and then silently pass the BUG_ON().
---
 arch/riscv/include/asm/asm.h           |  1 +
 arch/riscv/include/asm/runtime-const.h | 44 ++++++++++++++++++++++++++
 2 files changed, 45 insertions(+)

diff --git a/arch/riscv/include/asm/asm.h b/arch/riscv/include/asm/asm.h
index e9e8ba83e632..b8bf842d4c13 100644
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
index 1ce02605d2e4..a472ebbf0971 100644
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
+	unsigned int width = (val) ? __fls(val) + 1 : 0;
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

