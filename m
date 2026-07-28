Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010060.outbound.protection.outlook.com [52.101.46.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20293A6F1A;
	Tue, 28 Jul 2026 05:26:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216418; cv=fail; b=nXNsr77+pUZ6u0Fq8Eyg2vdu1PB+CcEUiZ6SVXKm+4Igos78rj3ZdW5WK0prjrbjJ3zjLGiDsV/mq1yKjuOqOGixUY6Tv4vUOCUKQZA/haHsHNmMjsM03LOrdvoTPX90BgmlEBnNAyVIAGRfXhrt4KWCzxWNDEL7iut9p/OOkwk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216418; c=relaxed/simple;
	bh=0Es6Y25gNTlahtnTeRA7tK8Bvjj/dftHGCZMkXdIpK8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Nr4r8M6/Ak/gsmH8Y4mr3p0woDw0rF22Q+y3+bjjjjeE+xBlIBqvm8fM0g0f0qRPKXR8mrKTdiFJl2th263EM3ylXH58xPmGUfRBCikoZjUWBQn6EA1Ayk24f9QLH4jfJukOiFTSk1YZYSaXmc7QwAU/JnVpXpdyca4tiZxIebQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=JHxorO+D; arc=fail smtp.client-ip=52.101.46.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="JHxorO+D"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BEuuvSCfhHfS0UtifFNLOUMi+qqG0tawB2nNdjor25BNFCOM2MBdFVXZZ8SzkdhAUvM89gWe2emdIBidAT5cmXL7eKIQDbGHQJom8Ba8SmQSXHYGkY5mVcfFDIRNQSQjmpk5ZCLpHAIstq3HwL1Fnau3N21phcVgpXekc49QUYHYjVhyxJLxFuBbKDbt+0OlwAVhNsNFptgzAZngpLIMcan4EWliZTpis144npVUpLQ2hEg3X6ErB20Uzxr81qkg3Pp+iKfm0ryNQcDbGd3hTIUE60CZ1jN7MBC0ZCUY32HK8Pw+akkABZpdQaBrATo/UfY6cIr+t/D9ReBCxCN7Hg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ntTVkd5SGKj6jEVLrnXOLIStGUlzrXjM0IU1KQ/Mhr4=;
 b=tf4Rqgds3VpbUTO7+jRNsVWfjXY65SlH7eObFGJ/uw5v7XoHjs7ZAQrkiQGFTt7sQDxN3jNr/eAwpnJUuJOWqqVYOQk7CX7eK9hDuyBFaVwJXUMF2F8ruEQsV0YZn46cW/pS0LJq8S1EIOojKzeyQb88e6wWKwm3h6VkYMB7EU/rQWPcyf95OnFLcGyNOVvmSjDrHZnRJinsE8ZUCX0pEXWKRMYSMAbtnh9JDs7GDzWzabgPPWHFUGY9bbih1MhcMDyQPw21gA6EeuHBF7EbW6x0q4d+TMtjDl+DTPyUu/6F6o6f/T7qsWHNjs3Xo3ZGSheISQWgmK9Avt2/Y7ERtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ntTVkd5SGKj6jEVLrnXOLIStGUlzrXjM0IU1KQ/Mhr4=;
 b=JHxorO+D2DzEXu5AVb9E7gpd8+qERwDZvOC+z1brX88UxEJ0rR/zN98fhMm0Ye+/tZhgIgOOgNPvWwPU5zrdx99vBfOSBr4LvXklRJJCIyS5/ldEkWHFHuSdtwGdztbHW189heiDa+Xf0FVi7Do23lPMf+Lvdqb7TgTTNB8G8NE=
Received: from MN2PR16CA0054.namprd16.prod.outlook.com (2603:10b6:208:234::23)
 by SA3PR12MB8810.namprd12.prod.outlook.com (2603:10b6:806:31f::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:26:52 +0000
Received: from MN1PEPF0000F0E2.namprd04.prod.outlook.com
 (2603:10b6:208:234:cafe::5f) by MN2PR16CA0054.outlook.office365.com
 (2603:10b6:208:234::23) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.12 via Frontend Transport; Tue,
 28 Jul 2026 05:26:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0E2.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:26:52 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:26:29 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, "Sean
 Christopherson" <seanjc@google.com>, Thomas Huth <thuth@redhat.com>
Subject: [PATCH v6 1/8] x86/runtime-const: Introduce runtime_const_mask_32()
Date: Tue, 28 Jul 2026 05:25:33 +0000
Message-ID: <20260728052540.4728-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0E2:EE_|SA3PR12MB8810:EE_
X-MS-Office365-Filtering-Correlation-Id: 3284c15e-85a8-4823-432e-08deec68d49c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|36860700016|376014|23010399003|13003099007|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	tYrJW3vpAtwRsxcy505et2pNfVr7wcvvgB6L+r0+h5G0mxYuoWZIQjCnLY02Z2hI3ImfGhA8D8pDUB6vZTpnWac/XTyQcuY7sxKiAU+L1sqPmReV/i7Xh4DYTU2oactv4BuA05WtmDiJqrjDpraN27UmjwSs4ztsqBFrnLnoyPfXQbVi/R44B/yOCH8I82JbFAYIapzMyCcXyNprnltf4wgEqohIrR0/jaxSh7vMmrkrvLa5KP3tCIFKFz+kfWOh1XoKcgEr5kGZ6BfjuM08CmwjlUSN8g0Xly9JvlD3WFLYacW1sqsDsatRyEmmIut2BLGHtpgpx+Kl/qGMEMb6CumeOJWRPiX4CKTQDxcSQCOl/GX9OzMHzRf5Jp/D/A/Y5GCa2Ouv1td4qpMU9YB3m1n6adisTK5U3gi+Xo/Wsw4RMTHpuQrHNZfzI01qNyibUmyDq3Jdh93adt4LGxfNHgtp8Td5js4zM5KWG/LrvuG5Doic7zDkomQFd5QLVIdLa6oewVw+aHLcpad22Y/qMu9+EQtNUgiUElS0niP+3gwzzA5o+1LA8UPsPZKFvuSF7eutgABr6aJPU+1a9eB0Ii5e2yRAt8pUzwOgd64qQqCE1nubTdcBwhZJvhB8vViPbqzFD6NVa5Tuup+mj8Jwc3Vny6Na5WG+Qc+6Wta028U=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(36860700016)(376014)(23010399003)(13003099007)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	nE16L/EIRSADkTc6ASmKmTgRK9ZAj6cEtTvXzZJ1BPk0cflNRqPvxSNneGIf7uV1LRqGfSpeactSHkVPFM80xuqUTS1ohdPD0x4ZUXVKeBwspmU4C0+5emwsheerxf0NDkPIMLdP3UbOmTqimWS2YQI7I4bH1y8l/UVgJQx4MsWyfb/usYBla6r560AKOoC/ifnyUkmlfTgSNJq9SUyPVybsFRRxKj0876WSpOgP+mmbiswGyj49kJvIivZXlGVT1vtmYktgvKeiSpUYwRfeMyPMGzK11L1sWZCMkWCkBeDZYdzr9JvZSPQkGzCNL6q/cDqAPga81n6rTeESYWXEui9CJTn6REOPepYLilS+aXooWjyvgwKK2Cpg5ntK7/hOjpenXgQj9VMnmUTWkId7yhJLtnqZ4KkNufVtki3MMGWHCFL2vHfw0JACSmDOCw2O
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:26:52.0595
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3284c15e-85a8-4823-432e-08deec68d49c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0E2.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8810

From: Peter Zijlstra <peterz@infradead.org>

Futex hash computation requires a mask operation with read-only after
init data that will be converted to a runtime constant in the subsequent
commit.

Introduce runtime_const_mask_32 to further optimize the mask operation
in the futex hash computation hot path.

  [ prateek: Broke off the x86 chunk, commit message. ]

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o Picked up Peter's S-o-b from his tree.
o No changes to the diff since v4.
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

