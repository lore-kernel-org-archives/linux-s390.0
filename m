Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010014.outbound.protection.outlook.com [52.101.201.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A673DB62E;
	Thu,  2 Apr 2026 11:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129112; cv=fail; b=rWDirXwqgIwg4gCMq5W+YMh70MRbjfNzH266Yv8ejzLozhukFFQDj7cH8exskdJnxw5LAVKdHK8tT2X1VuXLSURPWHBO810aIWcLk9RKg6hGsSFJPj+BFATox2XyCwgy+XMTNmBMDc6nr3BUKpDXxZncyN07/zHVicskL4Zp4aM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129112; c=relaxed/simple;
	bh=aa72g+kjmtrkaOUdelUMgIkbkvLcyaYu2EkrafpBqnk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I7bdIRF31Za6eZ/6x2vfSRz/7+LQlN9h041033DPNZaJVR/GEj0rROzURXg2BxYGtVa+pPXiaAVASptUjzZGPFeg+YI6NaE+o//5Dw3Sj7RmFf/PsV9h6mXMUvvSxwRa9KfE/ppJ3EZDAOBbYUmyFWEj27NPh2F3adaehiP+7Xw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=oAGg7lkA; arc=fail smtp.client-ip=52.101.201.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="oAGg7lkA"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=R2OalziUPqlOmTU4ufr2SJ6pnXmZJ97o9g+b1pVl8+/7C2znnVZwQu9HEz1qnYWt60a/dRd5KrTgDz8F05N32yIsLR7xHFyw34TI/NyIamN775jocD6zjW9aynZOERNj16apzt0CqZ123QTjDijZ/N+G2SVpfN50/He7fdK3dJwGOV0MGLrKkPZNs2qDq1+VCZCU6APARK3oGzs4U1nQ3PW32V/66T+AmxeOUFFVw5ye+ZR3ddVtsLlr5UJT+fyJLRRhVyR+jUgXcORytpUFa4Hga+lr6vSw+Ez8Cweq0FrAcvKMZzsh8pERtIVnbre2HA3MxRiAIeyBHIKd8gAiew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RHSa+xo/iTViJb7JDvDPIatbIaKCf8lHcG1QohC93pA=;
 b=GpsN/7VPlFvjhEhooiJYcbCadHd4c0Iue+G5hXnkLiF7SHJjXuGClx6ifyxqC3uPxLQ3Kod6lQnyL6x8ffCw5ent+jswuAQNvv8lj+daJBqevSKbzXnoMt0vkQHilHIN2Q3fsaSTfQaBzriNq20F05Yo4NdGyU2MGx+bsT7/gfN9WeBaXnY6L/+2ZDgX30nAMh42V3DTvUqNlOknn2wQ0G5PBD8Kqs2FNTLBubkQwc38595J6g2zbGrPzm2/7iFND49uFqe5J/351UnqM9tMSyKLOMWu29E1KPl+9BPE9FDLlbFm/OZgMsaF/upWAOtb52GpYFT5KpmqBroOX/A4Rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RHSa+xo/iTViJb7JDvDPIatbIaKCf8lHcG1QohC93pA=;
 b=oAGg7lkAaeBy5aAWHPDrNT8ymzVfdkc/oRo4eYCUj9QPg7U1BHBQzRH/Kp/HBkzVcdzn5CN0FsHR5Md+6c0YeMr6z5XrmIVv8RiP84oJ82EtlzPgfqkN6ZIFuLny7QKnnlkTL3+T7TXTDcJtOjB/yT1qQsdywEf4Pb8BxWFL5AA=
Received: from BY1P220CA0017.NAMP220.PROD.OUTLOOK.COM (2603:10b6:a03:5c3::6)
 by MW4PR12MB5602.namprd12.prod.outlook.com (2603:10b6:303:169::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.17; Thu, 2 Apr
 2026 11:24:56 +0000
Received: from BY1PEPF0001AE17.namprd04.prod.outlook.com
 (2603:10b6:a03:5c3:cafe::c6) by BY1P220CA0017.outlook.office365.com
 (2603:10b6:a03:5c3::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.20 via Frontend Transport; Thu,
 2 Apr 2026 11:24:56 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BY1PEPF0001AE17.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:24:56 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:24:37 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, Samuel Holland
	<samuel.holland@sifive.com>, David Laight <david.laight.linux@gmail.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Alexandre Ghiti <alex@ghiti.fr>, Charlie Jenkins
	<charlie@rivosinc.com>, Charles Mirabile <cmirabil@redhat.com>
Subject: [PATCH v3 4/7] riscv/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 2 Apr 2026 11:22:47 +0000
Message-ID: <20260402112250.2138-5-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260402112250.2138-1-kprateek.nayak@amd.com>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: BY1PEPF0001AE17:EE_|MW4PR12MB5602:EE_
X-MS-Office365-Filtering-Correlation-Id: 9b0bab9c-1928-4b5f-9d81-08de90aa780a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|376014|1800799024|82310400026|7416014|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	mYliQQmrJ0DDcAY29ITT+0LdcXRBob4luygG382bGZorqfCuDPnd9ihz2Y9W3ZwS+5wCRq8hPihix6qul8PpR2OmYsMelsOwZdIWZs8yHozCpfiW3J23CUCBWnjsoBYalpcFwcwKvkDPrlVNKn4ckEwDdlxj198ulkriL7dSFj/khGr9wDjMejsIgSb0CYXoM7HDivDc4U0uKQx5mc+eH0/QtNlDIvfXwYYcwNS4TcgBtccRlyFwWGIJ51lXLJ7hDMbMFD+aPqi+BUFBPtbx6PdXgi/D9+DR6Fl3tBNkMVjxARkX0TEFGJeiLilC61kt96IVVbZblQT+rDtg+ZHVj+wVopMRPOget7qYaIiNBz2ZbEBLwo9j5PN8nMikFqRV3r81JJmQ/GlQ+YAPOzTeEm3m2QSyDuxBgoBWoKL+Xeo6Pt5+khwMT5wj80YRLT7dumn5Onvn/6uTNQcxzCy8V07+oVJT2FZPZubu0p0TwKtXRTBmkXqFzG1IolJjVsbPke3WSi4P1p3niBIAKvy9LxfRmhOSrxun1cUlkR7UTLVmHG6EV9kaFJhduuXsRymOHlHhVZpwTmH9BfeneNcUBdcglgE9Y2AhNM83JSw0RtYzToI3Rlsl4IVjUJcFUQRV47eAcVAfGtLXyOY8P9DZCItNv+CvqCEf9BNY10O0mjJJuuxWZJQ2IQYmZgeD9QBKux14hlPuP7/pICuJMU8xJ/6NXrhN4DoS7DtWCadKrWnBoxkdBXRLvHPA1GlxboBZeitnxUue5IUEEe2rUBnCbg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(376014)(1800799024)(82310400026)(7416014)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	aKLCGsXlrPY0ulIXhwYdqgSAbafUs5KqMVtton1feddH2iliF6orIzjQRlx9+wM3G7fMOvQebn3qY8ocgEphomQRmKUFdxYqx/sJGZb2i4XoLAf2AqQit3ZYk1RV2+eYZ0PsszWd3RlmLmik839jiEg/yB0Ht9j8N0yld28ItOgPX/qqfaKZhcZCVS98WoeA0HdXOI6SXrB7fjm0RqKVAwptyfs9Up3svwsszgyuB+8Do6CzlGVk86n8wbH2NWRXGoGJcTn2RhWvs543zS8icTux4oTip6LfI4bhUdYoGywxyIGWT39u6nvyoz9cWiezEddf4XLQz+fF0PbC7/J4WGK0LbFDuzzQ++uvXBOVCS4Yl1f7gwMYlaZ/LzGEZrw+J4Om+Ux3D0l++17hKOYNyFrZfdRESLrhHOVkp7E+/YKPwHpXb14HHtTW3iTFjMS2
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:24:56.4585
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 9b0bab9c-1928-4b5f-9d81-08de90aa780a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF0001AE17.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR12MB5602

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path. GCC generates a:

  lui   a0, 0x12346       # upper; +0x800 then >>12 for correct rounding
  addi  a0, a0, 0x678     # lower 12 bits
  and   a1, a1, a0        # a1 = a1 & a0

pattern to tackle arbitrary 32-bit masks and the same was also suggested
by Claude which is implemented here. The (__mask & val) operation is
intentionally placed outside of asm block to allow compilers to further
optimize it if possible.

__runtime_fixup_ptr() already patches a "lui + addi" sequence which has
been reused to patch the same sequence for __runtime_fixup_mask().

Assisted-by: Claude:claude-sonnet-4-5
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v2..v3:

o Moved the "&" operation outside the inline asm block to allow for
  compilers to further optimize it if possible. (Based on David's
  comment on ARM64 bits).
---
 arch/riscv/include/asm/runtime-const.h | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index d766e2b9e6df..85efba8ecf12 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -153,6 +153,22 @@
 	__ret;							\
 })
 
+#define runtime_const_mask_32(val, sym)				\
+({								\
+	u32 __mask;						\
+	asm_inline(".option push\n\t"				\
+		".option norvc\n\t"				\
+		"1:\t"						\
+		"lui	%[__mask],0x89abd\n\t"			\
+		"addi	%[__mask],%[__mask],-0x211\n\t"		\
+		".option pop\n\t"				\
+		".pushsection runtime_mask_" #sym ",\"a\"\n\t"	\
+		".long 1b - .\n\t"				\
+		".popsection"					\
+		: [__mask] "=r" (__mask));			\
+	(__mask & val);						\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -256,6 +272,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
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

