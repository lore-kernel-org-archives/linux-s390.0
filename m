Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012043.outbound.protection.outlook.com [40.93.195.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFF975809;
	Sat, 11 Apr 2026 19:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775937296; cv=fail; b=sasVwnPr1RUqFIenXuDpoGqbRdipw0rp3oMhsoIDZs9uSK1JVC8kuEZxfQh5GRecttZTFwRSak9bVo3QYzrqZyqubV5hbQjTqjHVytsYxERA+MZqvY7mknhlRKXkNz8/kgKwjN0Y0UCaWpppgSsQJDWO8ppGg9qyhNrx2boTRkM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775937296; c=relaxed/simple;
	bh=AZr8Y7N13UyOIV2M2pUxaEQCUlrQuV2J9K4y8KXuIEA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=oPKHB2SXlvvIa6UbImdooQdq5WTd1Kg+30iqYfud41HGHvF9ENx8YbW92mZnCFR4EtjwXOz1u5BCHarYE3BrYI99aj8UH0DDMfw/i2p3CBNcdtoNj9JG4TNBs4c1LOZXQYpMJlUF+pMAUnOz3DU6Cy+KJPeS4EA4r1W7hOGlen4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=J/OhpU+j; arc=fail smtp.client-ip=40.93.195.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="J/OhpU+j"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iVWPveU44VVv7YbPBl3zdoDCfxdJvYWqfwib/uU3CbrB/lbGA3ka+MEUYd7VmqcFhEmwuLSRZ1kBWHT2zR2thIcGW5Nh3zAVu6+26I3PRBHs1RZXqEGNH+dzeyb6VnFfC6LX8nXKKrITR86yuSm3Pxt8+cxNcCMprqmaJCvHvwzbN/KFnnKVGTqeFlkXuEq8UZaZZmFOYYGcvpXwnhQg6kDlRhPPLsv7m1rc91wW2Uf3rmNPfmcr9wm1oqNuzWf/XA68h3os3feGJrF4oaejwjgSvVS7mjPP+QuwIYV1eC990pVnBQldP6r3xE7bolDSJbnncdL9CDUWccTATe93+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=vNX2LeApEj4s5J5aXKcawswCbi4C1Db3gEN0t6QELng=;
 b=sZJ43lx1rJxzzwZVDM2yNKHgLszxUHEANCbF5A4Lgf3kyuDjg3SIxoYww32hYnJ04+HKJVnkfYnwYFeWdu97U6Aaml/tyosE/YOofcST/KBytOn9O5IsaH1X/Jd/GVRlKp0mHuhbBcuuVe4dZLNUUkSDGeJtGRh6MIBIqHLZQEW28LvApVnmDJDctERfgsLTBNVrHGpu5M3ciw9L7ACqAYBdRgkjEljcn8NFjQqB5FA5D3MdgZ0+x/FEjh6O4rnEOXt63wjGwOnrNg1srOgCw7a7GLTwlGVAVBFXxKyBH+O9S8cm+9+3WnhRF0kyBZZ0b4mGYtv8Gpal092cVOLfGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=vNX2LeApEj4s5J5aXKcawswCbi4C1Db3gEN0t6QELng=;
 b=J/OhpU+jDn/xlbni285P1keskgIctQQhaRVMoIaCIeqhzNvwfB9Kt3v6pIXTaOaPyZNeV7NDpPF63BPPLNN87238fX59bUwVAH9+lCSGgDYva98bIsskGCPHFEcWoXXYIHrwn6nCuCp7cgAmNx0lW9nnSMVw1rLtdZ36iMtMqyg=
Received: from BN9PR03CA0572.namprd03.prod.outlook.com (2603:10b6:408:10d::7)
 by IA0PR12MB7722.namprd12.prod.outlook.com (2603:10b6:208:432::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.44; Sat, 11 Apr
 2026 19:54:51 +0000
Received: from BN1PEPF0000468B.namprd05.prod.outlook.com
 (2603:10b6:408:10d:cafe::53) by BN9PR03CA0572.outlook.office365.com
 (2603:10b6:408:10d::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.47 via Frontend Transport; Sat,
 11 Apr 2026 19:54:51 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN1PEPF0000468B.mail.protection.outlook.com (10.167.243.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Sat, 11 Apr 2026 19:54:51 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Sat, 11 Apr
 2026 14:54:50 -0500
Received: from [172.31.178.191] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Sat, 11 Apr 2026 14:54:46 -0500
Message-ID: <c45ede13-f8d0-4b6a-b2ed-f06af4882ebc@amd.com>
Date: Sun, 12 Apr 2026 01:24:45 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
To: Catalin Marinas <catalin.marinas@arm.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Will Deacon <will@kernel.org>, David Laight
	<david.laight.linux@gmail.com>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
	<andrealmeid@igalia.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-riscv@lists.infradead.org>, <linux-arm-kernel@lists.infradead.org>,
	Jisheng Zhang <jszhang@kernel.org>
References: <20260402112250.2138-1-kprateek.nayak@amd.com>
 <20260402112250.2138-3-kprateek.nayak@amd.com> <adjE6WzFM7NogzlU@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <adjE6WzFM7NogzlU@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN1PEPF0000468B:EE_|IA0PR12MB7722:EE_
X-MS-Office365-Filtering-Correlation-Id: ff1b5bf3-a56e-4a81-61a8-08de98043183
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|36860700016|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	U7ldQmJMXOfFzNsS5tZsCnecmPycVVOMmMQFvuXm0vbunvvCAaBO/qVJ9av4kEeeddL3A6Df6Tn3pRa+YacQgB8McBCHmDFLXe99IJ4qOQgYIjbzs398Sx07m3jWvjfiLN4Id8MWBVTM8jlkQynnJDnHIo+j3mO4jlF404INnmAsi2AJi3cs2wP9iB+94DEJifWAbCaYwfKH4EHyJtjf8SP1yyG6x7E02QQD4t4HyN6FtO8mHgmZdbEBz1WfoVBLCZ3qd2SmVyjoX+vsoh1BquncvLARwjX+t7q6DkJhvMswjThwaVyHfgImvcCrh5rdnFGkHXBVeAIquSAzVLhCvNUXQ8ZKyz6cntfTtVP467qkfmk1vmDgUJJXM5fC7Yh+UVqhq+lHW6oQ4qRlsXdl6ML2T/RNlCVVlM4G0rm5oE62nOSckiRpvYwk9jPW3E8lWzgYVBYIJlZXhUvPeI+y0gNv3CKPj/wolX+B2V3/RTakFOECxRXMEaYn6/IWSEPlErfE8YsKeu4hIurAskoiPZT0AF1e4IfBBb2NToiBxJw9eNilYBWjaMvFmAO3tL3rQV8/Rhi321glzsTsl1yyxMjqFhAiairptSp5VyDp7POM4eUCUk95jGFStyODAPHrJcwJQRAbtTJaRDBIBjLgvj+eij7REBn8pnlkBcDs+4VKAidL+f5O7Nc+0al2c6dr9mQY555Sfo59MJ+9s6xhug==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(36860700016)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	mGhjP1GQx8cFqG/km9cRq/PSCz3nzNKgvloTNlQwm/uq0pQ3+yZXOy5Ii9818eXsvRnlVNM2MiZKL8VBf5jtiwHnGafbRYkPUxgPm00g/qoT3ADFnVGbmJWpCqyQa1euNXNfrac5gZJn+MTcixyb+gZSxPDUHkz8wqL1YNmKQJIA6zLBAEhmFeGmB2+LQNU8kArMSgfRFwfglrcwc3hPqRPuz2cmL0OLueLeqUkoS1Sv7vdNDochSgSF2tyBdrfs55aJ/sKq7PcdCpRfVojJw+UH0pVs9ptRDvaNgyZIDRYbGGumT0TrSsCboZJShJLqvo0KG98mlGEiql4b+UE72Lk2yZfF9IGHQT8VP8Xe/A5EyVC5zkL+UDlEVU5dO6lqDWnzVGMQrjCM/mrveau/PpYR8aoExIjNkFswqBGEAMxPTNbFiYAOFwHlhmbHhHfb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Apr 2026 19:54:51.0768
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ff1b5bf3-a56e-4a81-61a8-08de98043183
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN1PEPF0000468B.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7722

Hello Catalin,

Thank you for taking a look at the series and pointing to the Shashiko
review.

On 4/10/2026 3:07 PM, Catalin Marinas wrote:
>> -static inline void __runtime_fixup_caches(void *where, unsigned int insns)
>> -{
>> -     unsigned long va = (unsigned long)where;
>> -     caches_clean_inval_pou(va, va + 4*insns);
>> +     aarch64_insn_patch_text_nosync(p, insn);
>>  }
> 
> Sashiko has some good points here:

Ack! I did check the Sashiko review a few days after posting. I think
I'll probably start replying to Shahsiko's inline review on future
threads on LKML to keep the record like some folks are doing.

> 
> https://sashiko.dev/#/patchset/20260402112250.2138-1-kprateek.nayak@amd.com
> 
> In short, aarch64_insn_patch_text_nosync() does not expect a linear map
> address but rather a kernel text one (or vmalloc/modules). The other
> valid point is on aliasing I-caches.
> 
> I think dropping the lm_alias() and just use 'where' directly would do
> but I haven't tried.

Ack! I completely missed that subtlety of passing "where" to
caches_clean_inval_pou(). I'm still surprised that it didn't
blow up in my testing.

Anyhow, following diff, on top of the full series builds and
tests fine and has been blessed by review-prompts:

diff --git a/arch/arm64/include/asm/runtime-const.h b/arch/arm64/include/asm/runtime-const.h
index 21f817eb5951..d3f0dfa7ced0 100644
--- a/arch/arm64/include/asm/runtime-const.h
+++ b/arch/arm64/include/asm/runtime-const.h
@@ -57,21 +57,21 @@
 } while (0)
 
 /* 16-bit immediate for wide move (movz and movk) in bits 5..20 */
-static inline void __runtime_fixup_16(__le32 *p, unsigned int val)
+static inline void __runtime_fixup_16(void *where, unsigned int val)
 {
+	__le32 *p = lm_alias(where);
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffe0001f;
 	insn |= (val & 0xffff) << 5;
-	aarch64_insn_patch_text_nosync(p, insn);
+	aarch64_insn_patch_text_nosync(where, insn);
 }
 
 static inline void __runtime_fixup_ptr(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
-	__runtime_fixup_16(p, val);
-	__runtime_fixup_16(p+1, val >> 16);
-	__runtime_fixup_16(p+2, val >> 32);
-	__runtime_fixup_16(p+3, val >> 48);
+	__runtime_fixup_16(where, val);
+	__runtime_fixup_16(where + 4, val >> 16);
+	__runtime_fixup_16(where + 8, val >> 32);
+	__runtime_fixup_16(where + 12, val >> 48);
 }
 
 /* Immediate value is 6 bits starting at bit #16 */
@@ -81,15 +81,14 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	u32 insn = le32_to_cpu(*p);
 	insn &= 0xffc0ffff;
 	insn |= (val & 63) << 16;
-	aarch64_insn_patch_text_nosync(p, insn);
+	aarch64_insn_patch_text_nosync(where, insn);
 }
 
 /* Immediate value is 6 bits starting at bit #16 */
 static inline void __runtime_fixup_mask(void *where, unsigned long val)
 {
-	__le32 *p = lm_alias(where);
-	__runtime_fixup_16(p, val);
-	__runtime_fixup_16(p+1, val >> 16);
+	__runtime_fixup_16(where, val);
+	__runtime_fixup_16(where + 4, val >> 16);
 }
 
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
---

I'll do some more sanity checks and address the rest of the comments
before posting out v4 soon after the merge window. Thank you again
for your feedback. Much appreciated.

-- 
Thanks and Regards,
Prateek

