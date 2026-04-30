Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012003.outbound.protection.outlook.com [52.101.48.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85A3AEF3B;
	Thu, 30 Apr 2026 09:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.48.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542525; cv=fail; b=YQCo4pcGQ3pbtssyNJFUzUFNs0RKKjNjeAppxBhOEQI9e4x55j20qyEnSV5mJgLYLUe3HbBlAxxyvnfJP40nqPhiVqZNnDpr+aF2FGtC6uRViqqUJp6Von6DNEZ9m3GrlJxRM4SbbCEEVrindSUZHKEHSzaj8tBsrcJ01x1nDTM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542525; c=relaxed/simple;
	bh=Xr5f6SHtDc9g9vdyYjn7Wc8AQKhRrJBq3ydmY/Kg7SU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RfC8aRQZ2/fqe/sj+uBLyfiMlBf9o18kksUVcH5TfBcRoGJYRlWZHCiUqnONKwyzBPQgrmbrbuDeshL7DYYuj2IbDTXDQCcoeZIsZTB3WoT7pCgcx67eSMPWUTnatgkIglbx3KcyZ8UZjKFZUIUOHO24K3KW2ECf3h6IGsvFNic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dhnPIJQs; arc=fail smtp.client-ip=52.101.48.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dhnPIJQs"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=h1S66jaFfxxmka6+wZ7QsH8+Wt6UWNkFYKrKUTXRvbEzRVVOKNPCizU8hozOZnoztFkbcjqqTTnlzf4Qt5B8T9RyCCnEd/bRnOcd5VWNGS5T5J8oOE2dtghPiv9SpLHTa18caJ/l2waYvnGQOPRlIzlvobhabXHRua3cDIOUvFUgaeSdh/U9xapcfjKoRmtHzhzfXyUua5nolEyNLJQH7q7DgtowtUau0ctjvt+jf+cCHSymTXdacBE/m2WRN6BndLvCCVemkHLfxXRvEtlAWcqLmwdWKHewuQUs1C6ZeCXth5VOSvCZxKG8cbk3f7BBazLJEcftQc1pOeEGsmX1Vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=r8kWqZd6+m5x2yHLoEbaR535LOxrBvPL5BSwnZOjrJg=;
 b=N1iPiD6UcnYgSq6BVYhVEOBqsBg1Zeq2gY6X6gaRhS4nzATDCbIQIRmqOhhtVTjFlyZ5RFSI8wSp5JrYjxkzJzJ4Qfz6aZC284bVJxtEqxKw+VR5TCdRbFOhspPCfT1TWbehK7kC67TB7LiRpews7MO4TJoTvpbn1lSEvPL+aZP2Dd59vvr3JnmuWXnO2qBf1sARWw34wvWJcVlm113hga7B9slGQJxea7BW2WPU0DhoG5B2Wnlw8zjw8DS/rPFKz8ykOqpqQuLtRZx3A/D53/1J/KRHPzLUI1vYMbzzR7eV26jOf7xPMz2LLgohdwKnwxr2/vYOCB5imN2dnuyyuA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=r8kWqZd6+m5x2yHLoEbaR535LOxrBvPL5BSwnZOjrJg=;
 b=dhnPIJQsb6uSQsnnPUcDO1GzxcK6pChcBW9dLI5NDrLIqlOmmXubV482n4uL42QYPSSkoVBNBNV6t76ASdmnFw3c93gYZVXJVLmKffSR+DJKxkpPwNmGTrNk5iJWB2POR+Kd7Te34j608zsT/qa81pM3NskpquM96ih+aQhRGCs=
Received: from SA1P222CA0193.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:3c4::10)
 by DS7PR12MB5717.namprd12.prod.outlook.com (2603:10b6:8:70::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:48:39 +0000
Received: from SA2PEPF00001504.namprd04.prod.outlook.com
 (2603:10b6:806:3c4:cafe::ee) by SA1P222CA0193.outlook.office365.com
 (2603:10b6:806:3c4::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:48:39 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001504.mail.protection.outlook.com (10.167.242.36) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:48:39 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:48:34 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Jisheng Zhang <jszhang@kernel.org>
Subject: [PATCH v4 2/8] arm64/runtime-const: Use aarch64_insn_patch_text_nosync() for patching
Date: Thu, 30 Apr 2026 09:47:24 +0000
Message-ID: <20260430094730.31624-3-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001504:EE_|DS7PR12MB5717:EE_
X-MS-Office365-Filtering-Correlation-Id: 6821caf6-6476-4e73-ef53-08dea69da811
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|7416014|376014|82310400026|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	nLMhX3xXKz4+rjaLpvDSEc8kP+gddcfGon+/3hEVpxo57YOkwJ6TyRT2Rp2zf+U1lAR3eUB/IgFt2xS/PgzWpNLCxXfeRChwxhD4AfMtLx6Q1gtR7X8LaihZFU8Npooz5Q9RtGnuUL9cMBr3ijbNzqpz0RR/uqLw0XRtQe+KLCqQK0XhDjLVIC6vglCEvQUsJizpz+Etwx45rVpOF48Avr3LzvKWzn0rwsmdBtDia1z210yavUlbExNfj4SeANHA3UkrnJ7KRGxloY4JGn4Szmw59uc76LBVb9j16T4cpZqmUHVUQ35YgSIif3299Qa0FDWj2vb/HoAzV8fr6mKw7qW9BsyfPmDKtwOuHilTDBYvQH3f8RbojUKl9FwoS9VUM1x5jn0Ev9gBzQ1C5Y8DsKW7Ii8hCMACDGpoOnmrizexb6jjm7IYq4hrPZXHXPws1ypxuMt0Bukzx87ele9EhwG89KdXQhAYZml7np1tc/QiUdh+Wzina+qYYbKVTEVB9Kv5FRxmbAeLg1Um8i+aanx5UquPjKf3py95mPOo7BW4p0O0T4z4EqVXRC3LCiTBKMZlx3kZpq0sgdhHiQ3IAggVws4zu+sb1XFdHj+TP6t6yxoIgg2mSISIwPFOH5oRb8LaNN8fm0mvVCi8v90/On+t5wn4Skv2q67u6vFHsGbhmRKTmXI/F6bqohucaUmESgNlE46a0n/QUep3xdHGT3mkbfOcbY+/6BhEuYoMf1Oakb9wII8rMDXx6KzjBTNMDPxFjWQpPpu7dg6168jrRA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(7416014)(376014)(82310400026)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	dSH3mtRUfCX+2UgU0EdOKvShp1gn7ba2RxKyTbSo1SA2cZC69PMAfotQJT1Wq4gObl+jZAeYEWR0oCbPrDSIjA3zAI6KKW9Qo+ChDEWWjy/ZevCVMwoD8/sSSdCzxnBtNMvXO+NkdbCUwljk51LFe4DBbZHvNMbagX+7kOHOtvpsJ8oxAyFLwEW2Q4jf9lyVSyo/I8xi6sIG9LGSBLeA//EBdWrRwZMDqeDj6ssfP9aVGw3sf0xfXsjq7f9V5lYW+yEEwJiWDXMSKLudykzoGAVbvGzjRW6N1YxeBp4YGyaTSHbdEpMLSOoCrXxva+73d9ML9wgKd3XKtUE0wupF8aXO/9ywcehXYX4OjI27KD2Gj1nB6kQWK3Fg9pJMtE01CQ6tx2TIgGs5K3uoYQmgara6Psi9AWqMSyUOsNJ/1WIJpJyyCFsDWnovNTVo/vAs
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:48:39.2646
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6821caf6-6476-4e73-ef53-08dea69da811
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001504.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR12MB5717

The current scheme to directly patch the kernel text for runtime
constants runs into the following issue with futex adapted to using
runtime constants on arm64:

  Unable to handle kernel write to read-only memory at virtual address ...

The pc points to the *p assignment in the following call chain:

  futex_init()
    runtime_const_init(shift, __futex_shift)
      __runtime_fixup_shift()
        *p = cpu_to_le32(insn);

which suggests that core_initcall() is too late to patch the kernel text
directly unlike the "d_hash_shift" which is initialized during
vfs_caches_init_early() before the protections are in place.

Use aarch64_insn_patch_text_nosync() to patch the runtime constants
instead of doing it directly to allow runtime_const_init() slightly
later into the boot.

Since aarch64_insn_patch_text_nosync() calls caches_clean_inval_pou()
internally, __runtime_fixup_caches() ends up being redundant.
runtime_const_init() are rare and the overheads of multiple calls to
caches_clean_inval_pou() instead of batching them together should be
negligible in practice.

The cpu_to_le32() conversion of instruction isn't necessary since it is
handled later in the aarch64_insn_patch_text_nosync() call-chain:

  aarch64_insn_patch_text_nosync(addr, insn)
    aarch64_insn_write(addr, insn)
      __aarch64_insn_write(addr, cpu_to_le32(insn))

Sashiko noted that aarch64_insn_patch_text_nosync() does not expect a
lm_alias() address and Catalin suggested it is safe to drop the
lm_alias() for runtime patching since the kernel text is readable. The
address passed to fixup function is interpreted as a __le32 and
dereferenced as is to read the opcode at the patch site.

No functional changes are intended.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o Dropped the lm_alias() and use the patch location as is for
  aarch64_insn_patch_text_nosync(). (Sashiko, Catalin)
---
 arch/arm64/include/asm/runtime-const.h | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index c3dbd3ae68f69..838145bc289d2 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -7,6 +7,7 @@
 #endif
 
 #include <asm/cacheflush.h>
+#include <asm/text-patching.h>
 
 /* Sigh. You can still run arm64 in BE mode */
 #include <asm/byteorder.h>
@@ -50,34 +51,26 @@ static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffe0001f;
 	insn |= (val & 0xffff) << 5;
-	*p = cpu_to_le32(insn);
-}
-
-static inline void __runtime_fixup_caches(void *where, unsigned int insns)
-{
-	unsigned long va = (unsigned long)where;
-	caches_clean_inval_pou(va, va + 4*insns);
+	aarch64_insn_patch_text_nosync(p, insn);
 }
 
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
+	__le32 *p = where;
 	__runtime_fixup_16(p, val);
 	__runtime_fixup_16(p+1, val >> 16);
 	__runtime_fixup_16(p+2, val >> 32);
 	__runtime_fixup_16(p+3, val >> 48);
-	__runtime_fixup_caches(where, 4);
 }
 
 /* Immediate value is 6 bits starting at bit #16 */
 static inline void __runtime_fixup_shift(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
+	__le32 *p = where;
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffc0ffff;
 	insn |= (val & 63) << 16;
-	*p = cpu_to_le32(insn);
-	__runtime_fixup_caches(where, 1);
+	aarch64_insn_patch_text_nosync(p, insn);
 }
 
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
-- 
2.34.1

