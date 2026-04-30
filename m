Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010030.outbound.protection.outlook.com [52.101.85.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63FF93E5594;
	Thu, 30 Apr 2026 09:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.30
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542600; cv=fail; b=a8c/N6Z43wTd/LVKpGtyhvQgi/FI75gPZl1ZgV/PI+sUS6KZfD3s+l7WJQPWWn74KdtSiEJGfCmXZ0c8R8RZ3IJw05vgrZf/HRwvg7i8MOOXwMw6iS7a2KLYq3TUbyo6W0uVJsPy6XkTKc953UYCUwkjHQ4pYUf+aVK1uX/T/FA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542600; c=relaxed/simple;
	bh=1VlDujQSODkq84Pjs54F33j5RCWQ8VqyYJ//uRnxFgQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ApparcbhUplbT5Ukeh9FpewlzRjSMKEN+ueHy+0hIQSBSAasr/XKiB0nkFTNS3AZEuiHjuRu3SP54hgB1QTtlpCRPHEjjPGoUqudWFOarmDBKK7K2ui/HTww/yZ7yUZdXBgUheAesdJJLAoE0CnOKvM1Rxe+Nyb9G04yQHA8iRc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=xOINo2gP; arc=fail smtp.client-ip=52.101.85.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="xOINo2gP"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NDNLFObzT4xRAHFKJNV0lPraPqqYP6fSIfNSQ2bq0XOSr1MiL6kBPHwcy2B98eVq1blLhNxgeU7MfxIvdMZha/YO7GEWtwk8k9vWzGpcU0N9ojGbrLTQpcEvKKaraizTBe5Vudp8KjTQK4XRPmMicW1U5jMTPICKaAS7NRmuOp8zp+Vj0CGmu/U+AcFmYlriVeau359VmU33IlOOtd0jDuHhHRjY6ly0ECtJlq7J9EgS8ZGJR08fhd+Q/X68StRudkU503ygbzkieA47FFFF/QykkBAumi4wKe2amG/B1MeeriKkx180DH763vhHDIjD6HTXGCYs7n1QTpd2kKF+KA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UwTW1xHOo2oizqfjQ7Ki/WYgZnEp7QbFPkRmy6Ukhjs=;
 b=D9bcZG05CwDo3cRKaZy2M0BakeOxTxK1ZqRlcIZC4X8bqqnBtuOcFvtaFNgA1C3tEmJdt8vk34CuUMU/FPFZrBYIxfjYOwRJx8+WTWAgacsHPvkzKDvMiBSgupIpyz0v0JqnxGUQJNtLS4DpwzbS2qCBZLbhPZBlmWryyaluUoadJIKqn5WecRsZhd2PJBwej4v/IMjotDUYO6/7tYk2z2C5hgHEBWDIhX2WsBfbBFZVZuEY75rk4+yDUM6hY3uL26S4DylDY/wjUf6Y+2BFP/qJHC4l9eGR2WK7BVSUQgYfHnTxdbWxxOMNprfHC0xS9HVX1Wrv1cf4Dr3h0xxI5g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UwTW1xHOo2oizqfjQ7Ki/WYgZnEp7QbFPkRmy6Ukhjs=;
 b=xOINo2gPCRMaq3bkIOv0wrXU+XbSrNk+TniuDEKaXRucv1CI9QVeLJwEeFVZXQJPIAd3rTDjjjUbYIl6CqDhXez9PVU6D4S1fN6qi145Vx89R3xNwH/Z+ckRTUqpbnv5U1XL8OOzwysQ3jtEUpXn+OUxvlOBdGRhNCv/Zy/zIVU=
Received: from DSSP221CA0003.NAMP221.PROD.OUTLOOK.COM (2603:10b6:8:3d5::15) by
 DM6PR12MB4058.namprd12.prod.outlook.com (2603:10b6:5:21d::16) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9870.20; Thu, 30 Apr 2026 09:49:52 +0000
Received: from DM2PEPF00003FC8.namprd04.prod.outlook.com
 (2603:10b6:8:3d5:cafe::7b) by DSSP221CA0003.outlook.office365.com
 (2603:10b6:8:3d5::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:49:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC8.mail.protection.outlook.com (10.167.23.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:49:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:49:47 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>
Subject: [PATCH v4 6/8] s390/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 30 Apr 2026 09:47:28 +0000
Message-ID: <20260430094730.31624-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC8:EE_|DM6PR12MB4058:EE_
X-MS-Office365-Filtering-Correlation-Id: 1000ca8b-537c-4aaa-ae80-08dea69dd3d4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	q7smMEh5ZqZFwRHTlgC6lPyJVEgHxjeFLzRygw2DQUj4Ix7wc4D36TbJM27jxFJT8spc+dncpscgAVm7ytxv5Ma3c9M65mzQc2dchEWY9Nrv0C4aGRluHe9ojLXnCIUcC8hMy4FpWVtrg4Ib4yiCJFjdRw3MoP/egrixFco+OsAXlUjjk3SQddBagbQr25sP59GafFYlNRkuBPg3v4Oy9OkiyxsNySHpcUkHxKwQ6hUg3KFtWBFXrJWBVvmYDbF3eb5Qmvk5g/htGBRhNuzdiQbugR4wyPgFvi3mT9UctY0sS9M+cs2tLHvhRCmJrroMa1kmlvYdITEZINQ9UBNHa4JR9ayUvXea+L9uFUEaE7UG7N8M8/P/Nc7tTkpU3vRD0U05mo2aZmTnEX40xMsPlvckWkyXq4a/FktNJ+VBXiR0n6MXIqgEZhxUg/k5RB2MYIQXWKglu2TfEp7puhhW+qcY3DCLudV5JodLanMN8W48DvapLrwNsAnSdYTdfDW19mAHJTC5YehMp6CuA8tUy1KrxQLaZNRLYWVuMW6LkgMeNbAPwj2QoCv2JOGGIQvXOnYUId0g/GMqCP+JRoJ6vVHHBnDaQWoljm/aG+7boMhj36hRxZ7SC6DD862w6YomA7h5jFueiGr6s9XnXaDltmRB2iLEJGUsmJorZMdfzpmdIsz2xxj2SZE+1COc2jzPaF4W97Yo13B/8SyaB9tjAj9HjHgQd6dskEYA4xgrjM5yrGmBKma1SEUpvPHtGqXTdFDsNEqT5eoGq7PBXKUNbg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XSF/ome2+NdtrT5Sufq3AVigsB06yzHZVeK76tD5aLaOA9WHPP9cjNEj8BB/mrI8Sq6KZR55DMCFFkOWWfgFOtz9GwNrGV415VpQuzH3M55UTFS8K9HZktEvOPcEg2Sm1aDu2XvMcaz49va3/tlAB4Cb6Biew/NV4pfBtVrR87P++QZWp8ndZDtu7a+Q2AKSxzTfo8ccRfgHaKrBuElcJfb10YExGZLYjxh/lWrrFmJwF6Uj+XN+2SHQIsyDduDYj3yoqJ5InpWKVtXXxc4ROetcDAM5t5kPQsA1XZfgWmhNtuSj/HDagAXRWP4FnTU58OgdaQJgosPHxvH0wYqnkFD5M0JUEVe7e2e1H0GaUly58SY/m0M3uH2HszmMr3yM4MFaZxgLvSmHc2x5WLK+HMhdYmIz2tE0I2erbOpVtxbWT3pyK150mkiaAlq7U0M6
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:49:52.6380
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1000ca8b-537c-4aaa-ae80-08dea69dd3d4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC8.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4058

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
changelog v3..v4:

o No changes.
---
 arch/s390/include/asm/runtime-const.h | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/arch/s390/include/asm/runtime-const.h b/arch/s390/include/asm/runtime-const.h
index 17878b1d048cf..7b71156031ecb 100644
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

