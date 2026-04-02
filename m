Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010045.outbound.protection.outlook.com [52.101.85.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077723DBD77;
	Thu,  2 Apr 2026 11:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129043; cv=fail; b=XJ0e1+qfwA/y3I0e8bECEt79n8Djav3G28UrOf62e32iirlXHz8BjOSLlLcf0ko8eqsUnQk/z58h0Jz9/S3v2c7DNmTpa6hAQwIfl2OZywXzZdEWqVaoAGXfPqyRa0+44xRVHGRcwzwaT9rqViGCmC7dlTq4xQX/98NTfjcw4qg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129043; c=relaxed/simple;
	bh=Da07juv+zBrc2dBIMH7jHgDcmgx8/ZOHCqOtnV0CDpA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LbkEpI2id2zZ8vhGcmCWGZ+HVZO/WCZVXvobQgoSziF7y1jevkMlSBmhFPs6VKstEUDg8Ej7CxE7ZnIMY4+9fNtA9bLeL5FGu0T1EcKpcKRmoOfygWirqo3WzmcNXmoZUApIvEPDlBm4jJIEKNC6EOqTpjE08AZS5Ap5kzyjBQM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=NFKHCRrM; arc=fail smtp.client-ip=52.101.85.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="NFKHCRrM"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=TZZDXgk3f9e/8BZObCr83LKhMEkCsRtvol81Cu83ysvuHxUlMpJOtLlhhvDtpz+548wIC7NOu9vkzdW+n2Pbb3w/u2EdsbNHAz5U/ABgjmxdMjX5tS9A1zJqnDSfJYeoVyxPGgy5RbrzSWiWTA5006kmDgxbXm8PN9efQxShFUiJwZuj4hn5BqJsKzfZDazQ8PoWkgb6vTnCXltruNTwwzjwL/xDwtJOK3jxr8Zqh4DEbM9CctrxeC4tIhR6BxSsU+8m2zATxITMJ6WHVbhzfmXQC8gKG4n/mvdJ+QBR2PxOLWEra1y0NvUwx4CsdsY9BE3G9AlNZRBu9kOeKaNFgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RWzVcVka8vdMp49l9TneevMDQw/RlcqNsmTol/lDRZU=;
 b=M/yDesAihEK/NfoNk1DUWC3xCCB+derSOADX50/TkafwmjMKUqL+sPKpoD5cB1uFKFUf8HKs7kh448I4EYaxoNQwQJlLa8MNyPMRG9HntmE8ySZNxwXZvYTD6OTk4yLQFLp9VWKt/F1y8Ac8X4/itXXK3NCBxrhG98eMCQtbKF914bGLmKH8ePPSjeh0KSdbzoHmWngc01rbZJKu6pSTCSrd/VuXWLsip46StJhjcsx70aLOBrZlsokfJRhUVmkYOV+vTNOlxZvq6TlyqTSKKB4l1cwZJM6kQGKG0DEiWBPoavpuhtSv1cGzBVqCyzReF8YuzfuDsuYDz2W4oEcVng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RWzVcVka8vdMp49l9TneevMDQw/RlcqNsmTol/lDRZU=;
 b=NFKHCRrMsbajMULhu2YdweS5YsWeb6nFXGaCBo6gIFWEnzivrx+JLWyA6RqdB61eZ9+4cPccztls0I9ombZMQNn1AG038He2enjXuXdKwLbQJ7/E6csQHtq5/Q/zGhL0gCvEZ2sCAheCk67s5//tPJsteUSlO4WF6TcG2rS4wNw=
Received: from SN7PR18CA0028.namprd18.prod.outlook.com (2603:10b6:806:f3::11)
 by DM4PR12MB6009.namprd12.prod.outlook.com (2603:10b6:8:69::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9769.19; Thu, 2 Apr
 2026 11:23:44 +0000
Received: from SN1PEPF0002636A.namprd02.prod.outlook.com
 (2603:10b6:806:f3:cafe::3b) by SN7PR18CA0028.outlook.office365.com
 (2603:10b6:806:f3::11) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 11:23:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636A.mail.protection.outlook.com (10.167.241.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:23:43 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:23:38 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v3 1/7] x86/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 2 Apr 2026 11:22:44 +0000
Message-ID: <20260402112250.2138-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636A:EE_|DM4PR12MB6009:EE_
X-MS-Office365-Filtering-Correlation-Id: 6269188e-c658-4a53-830c-08de90aa4c8d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|36860700016|82310400026|1800799024|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	hDN4xww+2Mh5DXtTqZlUXFbdIAwaVBlnYkB5ncfxuKVdh1AOj0a3/TwF8/7eDWgeoU/sWCwz+9On1Ec1w4GO83Op7L3b1oMvzGi/KWPNL1k7X5fOL0Vlf28CpfCxSPpSg4hsHesrxTpy/VnRns1q4FCR86kuH2w4dfB95HKncgswRTsL+K3s3mrwm4XsCJ9ACzZz8jT68T2wqoRaviEqnt1jzrBpU8KK25W/RhIwd8TbdQtCMJAVCLoRF6WjcqkZOgpoPPXoMAR5v2Z0ykU38RC1zcKfImGKFGzinxLutoraqOqS7Msoagt/V2mWpb2iolMm6H+aZgqdjVjY9/zERVOnAv3yFCeFSIhKI6EXO0dw11pMWEHjqQmyM8h/X6uX6fxCX9wDRLt3XUlKoq2W3fXzj77jQeryFmQ0LI7GBJ58JpOrwkv8W8h1S7sAhE5w+vvOXN6C/3gHg/9vhUNBpx2ZxX0iEh9oQNbQFf3n12Nh802NUOdCckl7udjsXcc4f6yB8XB9mJybqG0MucArPKJxBAlj5t5OwRr/1mnCQ95RTtw0+hpcL8L1yOp1Wlk/OMCQSnWYEFYcYNxZlN5v7FlJ03pHn+RXUsZXPmz2X3wWf+yZSmEREYQWF4lsRcAK9uRjO343G65ysCCB1WF1ACQClNLVyxuJ3Sv8xlKJyIQiG6UFJ8qDKEfCGMCZ8dldNEJ2aiOozwUffLJALyQTzLVz9SjTBBg7y4/q72srgKg=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(36860700016)(82310400026)(1800799024)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SIHUoJ62BypWPsuudTNDfHK35aZSMa1qfzBVlJzFDYKwLdt6j/SVBVyDKp4bD41S9dw5yNf7VtlFsdHNdOsI1j05FVCxDq7Z5KItPkKijybAt+4aj3X/E/hB88PYTT0Q8Dff4Wy8Iu3Y/aAP6MfVmor3A3N6yyUjIDMXw2eF2SqY9axEIj1l9Hpr0BO3XlBPD+/QxsD2mVr+guep+JZA8V6/NwcVebD3KxEkVkfrElMrc8bRtKBsC5a08k7BCGaF/YPyEMxCan5Gzrh1VK+0F1QUQ4vttI6nkYThg8RwqGfVtlQDLs9ZdvZVyrV3BDlcht2Ud4jkRiuvBCMYiuvf2/AzV0pSfz5w0B0NEX7MxorxuIm5CUzBkLycMgyFg+cRNeTMh+OJl76rGt7l1kmJqnyZLMSGFMgKagFij9shkYMfO8FABjkQITmZVeVvXARf
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:23:43.5718
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6269188e-c658-4a53-830c-08de90aa4c8d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636A.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6009

From: Peter Zijlstra <peterz@infradead.org>

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path.

  [ prateek: Broke off the x86 chunk, commit message. ]

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v2..v3:

o No changes.
---
 arch/x86/include/asm/runtime-const.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 4cd94fdcb45e..b13f7036c1c9 100644
--- a/arch/x86/include/asm/runtime-const.h
+++ b/arch/x86/include/asm/runtime-const.h
@@ -41,6 +41,15 @@
 		:"+r" (__ret));					\
 	__ret; })
 
+#define runtime_const_mask_32(val, sym) ({			\
+	typeof(0u+(val)) __ret = (val);				\
+	asm_inline("and $0x12345678, %k0\n1:\n"				\
+		   ".pushsection runtime_mask_" #sym ",\"a\"\n\t"\
+		   ".long 1b - 4 - .\n"				\
+		   ".popsection"				\
+		   : "+r" (__ret));				\
+	__ret; })
+
 #define runtime_const_init(type, sym) do {		\
 	extern s32 __start_runtime_##type##_##sym[];	\
 	extern s32 __stop_runtime_##type##_##sym[];	\
@@ -65,6 +74,11 @@ static inline void __runtime_fixup_shift(void *where, unsigned long val)
 	*(unsigned char *)where = val;
 }
 
+static inline void __runtime_fixup_mask(void *where, unsigned long val)
+{
+	*(unsigned int *)where = val;
+}
+
 static inline void runtime_const_fixup(void (*fn)(void *, unsigned long),
 	unsigned long val, s32 *start, s32 *end)
 {
-- 
2.34.1

