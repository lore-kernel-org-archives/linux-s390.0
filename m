Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013023.outbound.protection.outlook.com [40.93.201.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 421343C1992;
	Thu,  2 Apr 2026 11:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.23
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129120; cv=fail; b=c78RQTNobHr6bZbM9/RQe5Qob/kGP2a7TfglQS+NXjkPQd8cRUzv5ZD49FBBFVz7F/BF4TumwVRS5WaH+68LAiAYnR56EEZYNq7TyiRfbzfjKlvowooiPHAi27tS0h79UEgMrLVqxEtQbHyDBjqRDfQBSXu/jtrBvy3UcB/7JDQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129120; c=relaxed/simple;
	bh=u4Pm+rhnDGkXq5chjgU54nOWObWJe0SA0j2GOuZExxo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GCCpwVvR02YixBUJj1X05KUndt3IEKuNDYrCSozgQCAGyNUMwqmNz8AbuHhJ6IG0+D/ECn7+zTFtuKThWbZEi2Pcu2eDlAfrt8uWivvWyN7PP/WTC8856hKYAsbyvtp1sBgIQdXYW98jSMONb2CnqwTLMSuVToroa8b7eWBnuyQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=f4/X6LIq; arc=fail smtp.client-ip=40.93.201.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="f4/X6LIq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Gsx2qf4YUQ0n+uSvz8CBURF6ngDm4I0NYKfmlCDa+zCLeqlIav/+qSZR6XiMQJQzQX8e9v5/qnd8p9v0hMVscX0LAqC/BdSvDqHAcgwYc2MVis5VBQ7PSJOwY0GaMnJjk7RbFXRSDDq4gEqYEa/Q0XHBqkQC+3vNZs9Od1nCsPrAfsYCvvpWxRMhMuyabr0+rum2iJRpqC6Q/PYNgdvZavtCTXojiVi4+LWbfP89Q7yJBOaNbaich6dzpKkbPNbKcz/7AWhWp/5163zkHmEvIf8SvikEytlGaNkK7qg/vf+4xclE0exb4kPyjQR7GAmXF/o5i5kNCE1W9NgjvM13Qg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2g8iV9LAM6qau6Y/Bj5XnlgP3GqkVABvY4LMWp9IStk=;
 b=BuNgINBrThAoPSL6JuvqqQm/FzY7mLz6Ijuiyaaldcp6flV1PX10Tz4nDUu8LGyLpksJA9AtQ1vhW22GubUYRq+eWUkACZLthRcrl6aZA+kGgpNZMJs6AxKPTxTVVlCQVvNAcR01qu551KCmSXKYZOa6tYGlQDtNvSJ7CEfV0dZHfWXpx9IvmG1pJBm5G9171JVEO2piHSqxzH7c+unRyztLOKE4ZUZZZANuki7rplEMjZ4vtLgN2zkeRUe+C90L6ayGI1LADtrE78rm15xwqojySubNJX745tHCrZXrhorK26q9DmJRMQ2JQRnUquwJbDeGfJfon1VgWI/g1NQ6hQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2g8iV9LAM6qau6Y/Bj5XnlgP3GqkVABvY4LMWp9IStk=;
 b=f4/X6LIqeAFTNnZO5E0gCrNWOFhhDcKnR+/fKkYahkdtqzKRGPUFsjeyGfa+mMYQWAhcLs4ExY7ZZI0CJjStOCKApTg7FkDasNo+wfoLRh1bBEmEm5EyVa2PMUClzQkguduKVp4HxVT4aYA+mbdv1P6ERLMpmQC5TGOvG2RvLso=
Received: from SN7P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:806:123::14)
 by SAVPR12MB999143.namprd12.prod.outlook.com (2603:10b6:806:4e5::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.16; Thu, 2 Apr
 2026 11:25:05 +0000
Received: from SN1PEPF0002636C.namprd02.prod.outlook.com
 (2603:10b6:806:123:cafe::74) by SN7P220CA0009.outlook.office365.com
 (2603:10b6:806:123::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 11:25:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636C.mail.protection.outlook.com (10.167.241.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:25:04 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:24:56 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v3 5/7] s390/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 2 Apr 2026 11:22:48 +0000
Message-ID: <20260402112250.2138-6-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636C:EE_|SAVPR12MB999143:EE_
X-MS-Office365-Filtering-Correlation-Id: 915c3c05-c1af-4830-19db-08de90aa7d14
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|7416014|376014|82310400026|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	uzK+rKcm9Au4cQJUgs5WmQQL4yd57I96V3eLoqKW8ouUM955a3c/lWVnPdjr/CO2Tz9K946IPj5c5OJpO7DrOv5JwNWJlaiZD1K6qdDeIvv6O7pcxJ/lQ6DiHgiQQbWCQp7wUQqUt9Ubp7VmKJDErbTsWcWW6Kp7yYno+BAIstXb+JcdRtfm2WVK1Now0Cvmkuw0izaWYEtA8noIhuyb+89qaQ01iILpJRjKLavlKe/1SKYX6uYfFoC4ApGfzQL4zZGbzXq9VNv6ImgQCVsjvTUFrTODO3sNlDU+kMQOvfTAh4TMPNmM1dNDKn428u6UGzEaAeXF9l1+zIMU2xms3Bz1NlpjUfSGbDwotn+96uy7skgo9d5jmVB2N37UJbaRvPpUv3BGoGblr0t3gAiQvMM6+xCVhVBfKBihsyj5wAP4C8hQU7zYQ1UUa4MgEOYbHiYMyu8nsXmD6TJdvLEntiari7SvHDOMgQcBGHIzC8KGFQtYCno0XODeRr0Wu63OcO1fa8ePhl47gLBEvTGt5HT6DuQ/8pm1uSkwhMXAbYPFoijNzqyD3jTNyS1800H61mi2satOH1WbwggiMV/2UeDOBsAO95ZuJp8kmjIDy1he7JLHtVZvSycLO1hhf55y9roH7LT5d5iQZhNwhwjAi89Y0bZLKdLR4ZSoj5o2cC6ty16g2k6/+q3ZSAFivxpOveJJjwLOBaM8X/wmROvKMTDhRe+JrOVpHEquqTwqjWd03KkbaaokxTKLhXixDG2TzMY+MTRVp/6BD7eHHhTKFA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(7416014)(376014)(82310400026)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ioXQ4y4yHhbk6gz4Mz+/SH2pX+GTFAO+MQRYxHIsvCZx9E6Gln5i0rs0Ar3GLwDUG88uOn3sm78phW9cIjYDSaPZULGvsvCTWVomuM1PytRvZp2+Mbi6qaZBxX6OmuhCm8to5lf0dAA3cQJf9Vs0zrp779ibzvkKsmqkN2IeCoZDeRzzDAh7dp/X89z/Q475PK2U+PCDUF/ADh6iT5JlW1pARccc960lmon2taDg06Gbz+HUbTg6MkmPhfWK4fq8o71be2r8yfzcJhzymmWlvtZJn6E+1nq9neTFlsxKsBebIAQ0EXp2aPo3saVPwEFMZ5LONl1avRkPGUVS/LvwcFbdUNoYNASexYrHzOPeaMfbXHZsC6XS2cD8yt/mVrBLrwSesTHgrFSTr9wW4/hKozlGEPI+wkJ1Mp1DCuSXnPK/dawWxw2lyCkKG8Cm65uL
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:25:04.9840
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 915c3c05-c1af-4830-19db-08de90aa7d14
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636C.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAVPR12MB999143

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path.

GCC generates a:

  nilf %r1,<imm32>

to tackle arbitrary 32-bit masks and the same is implemented here.
Immediate patching pattern for __runtime_fixup_mask() has been adopted
from __runtime_fixup_ptr().

Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v2..v3:

o Collected Ack from Heiko after folding in the suggested diff. (Thanks
  a ton!)
---
 arch/s390/include/asm/runtime-const.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048c..7b71156031ec 100644
--- a/arch/s390/include/asm/runtime-const.h
+++ b/arch/s390/include/asm/runtime-const.h
@@ -33,6 +33,20 @@
 	__ret;							\
 })
 
+#define runtime_const_mask_32(val, sym)				\
+({								\
+	unsigned int __ret = (val);				\
+								\
+	asm_inline(						\
+		"0:	nilf	%[__ret],12\n"			\
+		".pushsection runtime_mask_" #sym ",\"a\"\n"	\
+		".long 0b - .\n"				\
+		".popsection"					\
+		: [__ret] "+d" (__ret)				\
+		: : "cc");					\
+	__ret;							\
+})
+
 #define runtime_const_init(type, sym) do {			\
 	extern s32 __start_runtime_##type##_##sym[];		\
 	extern s32 __stop_runtime_##type##_##sym[];		\
@@ -43,12 +57,12 @@
 			    __stop_runtime_##type##_##sym);	\
 } while (0)
 
-/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_32(u32 *p, unsigned int val)
 {
 	s390_kernel_write(p, &val, sizeof(val));
 }
 
+/* 32-bit immediate for iihf and iilf in bits in I2 field */
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
 	__runtime_fixup_32(where + 2, val >> 32);
@@ -65,6 +79,12 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	s390_kernel_write(where, &insn, sizeof(insn));
 }
 
+/* 32-bit immediate for nilf in bits in I2 field */
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	__runtime_fixup_32(where + 2, val);
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 				       unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1

