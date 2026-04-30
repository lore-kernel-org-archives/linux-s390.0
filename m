Received: from PH8PR06CU001.outbound.protection.outlook.com (mail-westus3azon11012032.outbound.protection.outlook.com [40.107.209.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6C163A5E7D;
	Thu, 30 Apr 2026 09:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.209.32
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542582; cv=fail; b=nXH93Is6YVb5Ubj6B5oSqxKSwXbHKeRdi+vSgyLB5ThR+YsGc1tydH4BDAtFLU0W2gW9g8E0Tb3ynHCvjB+bzIMohpti6t9cliKuExRvLHkxpikgEMDJ//jC4oH7GF2rp3VnjDGEOW4NxMzlrgO8LA7x2UtuJPDrJA3LUy+ZtZY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542582; c=relaxed/simple;
	bh=+6mVT8/JCXNEiwDLlPROqzN8uyKRTEiqyea/7rcLPyc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSnJmOLPyoqU2rzKQ+6944UA0rpQVF25/MZZ4gNfjEN9R6d2hO7aUzobdjYJhD7qqg/R1WUNXZd3hqb7GHQTXfzsi8xcfP2YyAGMkmnKM+AiL+Hfoqzq2xF/T3sacSSX6Ds18K+ctkR5IY+U44+aV+r8Q2EQXeWyqdySFCYZCmI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=hHUyt0A2; arc=fail smtp.client-ip=40.107.209.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="hHUyt0A2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mtCCX2WdBqMowhb//xoAqb2opfBcB+f5YcN6xmPaDg9leh+ffcWrr7+S534gtx1KpWfTnts4pYf9wGpvwpsJ+zrWNdr31L6a6WPrFD6Rp0mcPiknnKWGvhudhcj9DoVjhZpZPkYX+qWxm20B2bOpGhcnO3FwzwymwyMVbb3OQUjQAXGAqPhGxQ23LQ2sZQI7fbmr8FgMBtkfD45niz0RULjK+68SO/XQw8x1U0PkSvsSlUQhv7xxYbE1XEFBcsOCuwKxaRrSo2J6JanqlimjefbQ37VeMr9Stou4d1QvdZet0f8c+DuLY7x9c6SLNjR4qC3T/LZSjR370xgunYP74g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JisPYYQgf5XYS6EwaE6wrVLU2G06yMemARwURYYVaJw=;
 b=nj1vUHIRdDbwt1QDeYNbaEYQn5n54ECa32JbI0v6T83BGJtteMjgpdWrvw0Csc6QppL7xSqZPLucf+2XDtpoX1YLAtvhXLjcDFOckgS8j5a+WyoizSv9yKkpyjCcslyKhMs+pwlMwqs1lSwogVL+zBJjTzdQQ3yf6F8xB+7WgcdQgmvTUhgFbe2HlaUnh/+gzGAtD4z3j3RG9CNjIQciywigfw7aGu4YFDKrfkqxfdZnEL1vfa7eLRaHPfGTqaYcyS8WXNuVAWlB1N4E33JCiNRmg3H08d4q+dmusVnWWMytyfLFm8V417EOAYjAQ/tcCaMFIKrGz2dqhse9uR1VtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JisPYYQgf5XYS6EwaE6wrVLU2G06yMemARwURYYVaJw=;
 b=hHUyt0A2GNxYinvqbzyAZcNoJA7mVbk+/gmgL1eeny0fEqdVKoM68IpUvwC6Pi1LltUJxOWIIMdDaUeLiQyYZHHaMqpShKoDQpcy42Htz/XRLcooN5twYT0wVdoe7/bYBrenSvGjRtaWBo3OjHFhi9P4bIvC5oylBQToseTAla4=
Received: from CH0PR03CA0070.namprd03.prod.outlook.com (2603:10b6:610:cc::15)
 by SA1PR12MB9470.namprd12.prod.outlook.com (2603:10b6:806:459::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.15; Thu, 30 Apr
 2026 09:49:35 +0000
Received: from DM2PEPF00003FC3.namprd04.prod.outlook.com
 (2603:10b6:610:cc:cafe::71) by CH0PR03CA0070.outlook.office365.com
 (2603:10b6:610:cc::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:49:35 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC3.mail.protection.outlook.com (10.167.23.21) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:49:35 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:49:28 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Guo Ren
	<guoren@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins
	<charlie@rivosinc.com>, Jisheng Zhang <jszhang@kernel.org>, Charles Mirabile
	<cmirabil@redhat.com>
Subject: [PATCH v4 5/8] riscv/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 30 Apr 2026 09:47:27 +0000
Message-ID: <20260430094730.31624-6-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260430094730.31624-1-kprateek.nayak@amd.com>
References: <20260430094730.31624-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC3:EE_|SA1PR12MB9470:EE_
X-MS-Office365-Filtering-Correlation-Id: 8e1fc142-143a-45d9-56e5-08dea69dc96b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|1800799024|7416014|82310400026|36860700016|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	yLGlxJEX9K6sL+df1tjnrqey795aVxmMIvgX+jSOmwItNaFVUeYwp9bHQi9d76ALlFS85a3PnOBI6SLQsYvfto0BMpz+GX2bG9EFGMuh6o+EGmW6M6OV/W54gG7T30OCb168ZPuYFJlAAi+JHk9Tm7u78vTI6kV5nOylk46A5G//BahnjIKCO0QlEgLqnOwE9D+Gc9ByLO9+RximaMVr/lcGF8T8nFjo/unY1EyhxF+1nE5IivJt8JmtOChV6bqA0lBL4hN0fYKMl9noneH+780veJY3fKqWk/pyxs5MReRKQbUV/JHZMYp92+aZiKPWkK6YP4MZ1H7cuIfrJ0xReTkvpnZ3nRD4uRC64y0O/cfowf9ZXsshEtGIIPtQmLApMPN1pzYlVpBF1kROcKybtv9sa1I/w9pseiFCrJQ5zp+hWtqKGdnMBI0Hkws9QI3zFr6s46Oks8Yd7lcgAOOvKOrc0+yaKA1+SUUK+RCptpOcO/nsvDKYkkCH5Ud8EyJ62W/QiUgRg1HxeUhsfnYfciNlNgRSw8osKqjZDBh34LApKosQbu1kJ8Az8x0zcv3DO8CML/MLFyNP9JoRUZMRvhMRUvOtQSVCMw1yO57O+DhquRlngBHoWQxBEoN2FLsYHpeyZWHN5A1Zfw8RADxv0/N9diGdxRgFbA+smvI35or6Vg3AuxLmnE+JxvAsyzaRz1vJd4Y1Hg1CFWZCWn4l7sxuiBNjs9xfc2wLkuVyM3+BA7YQ5pQknmVkVo+7anWAqkyXPU2UGxzLD/tBS5P2EQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(7416014)(82310400026)(36860700016)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/qD8qY+l0A/YXTiI+KV9iIAdyy0HbICx6N04dKD9CsdX24Ocag2lVF822qfvN5EyJwoBKWACmuCpZiFTHnGIvxBYB3FGAR0JtHemUABfkfrNac+NYeK8nQA82NcYSNLDIEV0ZgQAjICYkWTdryjWMpEf0WFf1iY9jPExHlNrWsATTv2eJ6h17fnz9Tk+Uw/313KS/Uqxgb+jgEkGpG6L7eUkz5jbJckjt6F9uTUbknSoLwSIMw7lNyqXDiD4OhyC/GNCmC0A4fdf6XVUkoD1102xzBbpr5dSoCrfg3Yb21Ckm9klG8lwtcBdxe/HX31hVVCQGN2t09j6GYsjGRdG8Pj+C91KQvB+7dr6U6Um7s33p97wjJV82DmdJy6kY3ZQOMGQIoXVn4dgVHSEO6ZOJwGQHeE7cwaPsl7zWXmjanHxdPdgBH2uZOpbIJ82DgH2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:49:35.1959
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e1fc142-143a-45d9-56e5-08dea69dc96b
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC3.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB9470

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. GCC generates a:

  lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
  addi  a0, a0, 0x678     # lower 12 bits
  and   a1, a1, a0        # a1 = a1 & a0

pattern to tackle arbitrary 32-bit masks and the same was also suggested
by Claude which is implemented here. The final (__ret & val) operation
is intentionally placed outside of asm block to allow compilers to
further optimize it if possible.

__runtime_fixup_ptr() already patches a "lui + addi" sequence which has
been reused to patch the same sequence for __runtime_fixup_mask().

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o Reverted back to using __ret as the macro variable to prevent
  collision with local varaibles at callsite. (Sashiko)

o Separated out the & operation to prevent any confusion with operator
  precedence id "val" is an expression. (Sashiko)
---
 arch/riscv/include/asm/runtime-const.h | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index 1ce02605d2e43..684641cb0fe82 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -159,6 +159,23 @@
 	__ret;							\
 })
 
+#define runtime_const_mask_32(val, sym)					\
+({									\
+	u32 __ret;							\
+	asm_inline(".option push\n\t"					\
+		".option norvc\n\t"					\
+		"1:\t"							\
+		"lui	%[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"		\
+		"addi	%[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t"	\
+		".option pop\n\t"					\
+		".pushsection runtime_mask_" #sym ",\"a\"\n\t"		\
+		".long 1b - .\n\t"					\
+		".popsection"						\
+		: [__ret] "=r" (__ret));				\
+	__ret &= val; /* Allow compiler to optimize & operation. */	\
+	__ret;								\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -262,6 +279,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	mutex_unlock(&text_mutex);
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	__runtime_fixup_32(where, where + 4, val);
+	__runtime_fixup_caches(where, 2);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 				       unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1

