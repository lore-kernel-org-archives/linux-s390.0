Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010014.outbound.protection.outlook.com [52.101.61.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15BFE3A5E7D;
	Thu, 30 Apr 2026 09:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542563; cv=fail; b=R/P87Wfrz5e9tZCidxterLahU7c1USLnTV0rDKomp2k1OdQ23Bjyu4M6XgpeIv74CQu/gRMVxdKzDyGJCsY+5i++AcVbKX/YXCCeSQvxcHR/6CfEWahs7MwsAKt1U9FSQgqjWg2HIFtOMT3/6PdNPSz02bf6isc1BOqmI4fcCCo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542563; c=relaxed/simple;
	bh=GdGxTKSRxGi8/Hhm3Slh0Ox6zn4CrWU9tR1S4WNY8q0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PvgqbOz2BWf+jkaea0lqeuijrsZRgnB+37hfWEpYOBdQU4n01QzuH5h/K+fL1fJVCnHjwkDVkyQVUo7gfvnglzG7h9BK9tMVRkDyFR2zOhsekd+BP+haWa1A2pWA/PW8qTg49zYsgTmNpNOriuC/zSUIna2SnlPK721s9Uiqme4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E3Qji80J; arc=fail smtp.client-ip=52.101.61.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E3Qji80J"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gIKWqG8bThhjrubQ8ctcralPibEwj3VRlw7dy2Q9xqCKz5c55ZNTgWdyJj5XAsIDByvXQ8UXwozhU5H82wDOW8rFXKqL+0Ekey4wgcv9Cy0ZPXkz7UTPjo3EMPWf9C51USJK+dgOnQaVvijDn+wrJoRCqDup3FIE2qWSFcze2oT9/PBU9Sf/SUsU0nnnjdlDZgCwRYNsTT/M06+QsG2ToWDINAaplbSX7ANqNI8yGclARUlfh8ZgLCPH0rhifRV6Gi3yKDaNp+20xdy9tyH6PWHnY1djNE/KZA6Tg1lJMdADrnpmN5Gein3ltfCAyYcOFqVkLVopFgRZrKAlS8FGlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+UVvn1r+l/OIdfArAmJcxXUc2I2C9WF9EPpGDuKnTqE=;
 b=uLL4Lpclj1vl4JSFooV8XqcV3iPpnZJxnLPbUGjZo9C814fDN2aC7+tZxq3u+xa94t/DSXjgyly0zgX09+XiYkjbPgrCB/AbwCYr5zRsZN6LmI+JNH/a9IFizdFcdenC7KpNK2uIEiAQfELEds5BBW19JkmaJXXzM3EQlJpbDxmKqh7fRZOUR4XioyApg21LHkE4rPX70WIAtD2nu4cD7xdimCGOZF+KEI8tLNYq2ps0JHCbgTtwvte4Nt+jikj+kbsGTxH81W4B6eIGeWx5IhQ1sfjiMf3LMRQUoQOVx9fFnCY1+3UBiNaNQHb1t56zzxNEyvlKZ02KgCGCLnfNqg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+UVvn1r+l/OIdfArAmJcxXUc2I2C9WF9EPpGDuKnTqE=;
 b=E3Qji80JoChBVfZJy2+bDFe3UvoVKaWnanRRpy+Xq2dedCH8sxCClDjWClnh/JCqG/ODOa6k5Tc798qM/4BQXZOuzzx8Wc2cTD9LjQeoNPWaYbF30Tg3p6diiwqTPDXpmKf7DW0OMA4on0jaiFqmGTTlqJnmo00UaXJsxczsSiI=
Received: from PH8PR07CA0001.namprd07.prod.outlook.com (2603:10b6:510:2cd::26)
 by CH2PR12MB4325.namprd12.prod.outlook.com (2603:10b6:610:a9::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.16; Thu, 30 Apr
 2026 09:49:16 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::4d) by PH8PR07CA0001.outlook.office365.com
 (2603:10b6:510:2cd::26) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:49:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:49:15 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:49:09 -0500
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
Subject: [PATCH v4 4/8] riscv/runtime-const: Replace open-coded placeholder with RUNTIME_MAGIC
Date: Thu, 30 Apr 2026 09:47:26 +0000
Message-ID: <20260430094730.31624-5-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|CH2PR12MB4325:EE_
X-MS-Office365-Filtering-Correlation-Id: 59474c43-b1d5-467c-0599-08dea69dbdb6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|376014|7416014|1800799024|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	xbbf/rEj2/AYaa4i/iKVxKWqQbzgHD5KINwE7eLwoqHTm77HBTGPbG2V4I+EtTu1sfG+HwyXlD0yRwokUGzOYjH6JAQIwbVPTqfdCfkb8NRq2j7ZJ7cZBTZekibdNyH7jsZdFkfKlg9wVtASlhEf2sd650egnSrNeAZI55O9ZwhRPEm0vgGYfRU5YNIdqPR+DWs/ZBr2MCbGZiP4Y0VNSJ39wzg7wtRn9Y8ho/ReeSYcHSsfuuz+9hs8bQi+lkD3BPM2cxSYtho9IrQ9kX0Z6v7mbhHqCaYXuNZ5SOjPOEC0l4LP/GcT+f4T+zEVa/bk7o2QJuxM4RKxouwmQpdQNRQzmgLEqmihKVQDZuSg0dVK5G/JqOjYdlTwg/iW5zil74yer898cTYnpxDHnn4gOJwLhG/jEs/mOOFA5hBMGJ52b9Wqq0ijKiS85UvEndJz9C/k6F05gzUlbZl1OzB+sht2cf+8fMuVcMKho/pwXFCIHNF6Zr8wqoXtcOKtOhDWMP3mh08Z/qfQMsLezs4mbq5h57JxpunhP+CWg7K9P1SGZzHlRVaKrXfm2orniwndH8Qmt6Xteorn382IH414njSG2pphE02NDnuK1+iP1Xvj7iYpKTD2CLFkMyPrJPu1ecr3SR6J2r/uT/7OAAWxlL472vpZ3zR0cdnpvTfz9GFVO6V5CxhXRCjndHVqHnoSEjbH1xYiUWMxmfvsAMJpeP3l+T9Ma1vjgSK6kqL0S42GULkPVyR5FhVtmZ+lZ0EO4DsVdvrhkVWQJ6gDuRCqFQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(7416014)(1800799024)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	ycNBThdW34lUxzm9ifF/2wy1BfoQ63RQWi3EaoFULtXm9e34bedgtIuhafkJAB8YZcLXHmEs5aUL1brZPeWGd81iEfLm0yyNaGG0bVHWSIrMH0Vhi+f9+9hcXuck5cby2lEpha597hv+Um7iL9R5PAutcyXu6WMkd3UFk0zM+PEfi3UOYxqxyWkH+8nfx51rTpTLcL5w3UEIZ5Al0gjpxsqLZsv65FbaqVwQt3KJPop7tM0krt11Fxx0EBk7wmBT5U9+PuPJFO4JEJ/uIp7o4jVe6h5nuwplsYMxLN1MpVIp6MRtsmAF5XrB/p0jVkGjCoo81JwNtZmRNRM+QdG9jqWLY1zKaR4o5vQyp3RnLiMW2czsuCajWWbOH4Ayqj/Cfd0QxS223eSoXlrnkAfVCO/DP0AvItSrvvbV0DszL7uxTQGf0pURHlDOJB57kc4z
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:49:15.5454
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 59474c43-b1d5-467c-0599-08dea69dbdb6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4325

Define the placeholder used for lui + addi[w] patching sequence as
RUNTIME_MAGIC and use that instead of open coding the constants in the
inline assembly.

No functional changes intended.

Suggested-by: Guo Ren <guoren@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v3..v4:

o New patch based on suggestions from Guo. (Thank you!)
---
 arch/riscv/include/asm/runtime-const.h | 38 ++++++++++++++------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/arch/riscv/include/asm/runtime-const.h b/arch/riscv/include/asm/runtime-const.h
index 900db0a103d05..1ce02605d2e43 100644
--- a/arch/riscv/include/asm/runtime-const.h
+++ b/arch/riscv/include/asm/runtime-const.h
@@ -15,21 +15,23 @@
 
 #include <linux/uaccess.h>
 
+#define RUNTIME_MAGIC __ASM_STR(0x89ABCDEF)
+
 #ifdef CONFIG_32BIT
-#define runtime_const_ptr(sym)					\
-({								\
-	typeof(sym) __ret;					\
-	asm_inline(".option push\n\t"				\
-		".option norvc\n\t"				\
-		"1:\t"						\
-		"lui	%[__ret],0x89abd\n\t"			\
-		"addi	%[__ret],%[__ret],-0x211\n\t"		\
-		".option pop\n\t"				\
-		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"	\
-		".long 1b - .\n\t"				\
-		".popsection"					\
-		: [__ret] "=r" (__ret));			\
-	__ret;							\
+#define runtime_const_ptr(sym)						\
+({									\
+	typeof(sym) __ret;						\
+	asm_inline(".option push\n\t"					\
+		".option norvc\n\t"					\
+		"1:\t"							\
+		"lui	%[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"		\
+		"addi	%[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t"	\
+		".option pop\n\t"					\
+		".pushsection runtime_ptr_" #sym ",\"a\"\n\t"		\
+		".long 1b - .\n\t"					\
+		".popsection"						\
+		: [__ret] "=r" (__ret));				\
+	__ret;								\
 })
 #else
 /*
@@ -46,10 +48,10 @@
 	".option push\n\t"					\
 	".option norvc\n\t"					\
 	"1:\t"							\
-	"lui	%[__ret],0x89abd\n\t"				\
-	"lui	%[__tmp],0x1234\n\t"				\
-	"addiw	%[__ret],%[__ret],-0x211\n\t"			\
-	"addiw	%[__tmp],%[__tmp],0x567\n\t"			\
+	"lui	%[__ret], %%hi(" RUNTIME_MAGIC ")\n\t"		\
+	"lui	%[__tmp], %%hi(" RUNTIME_MAGIC ")\n\t"		\
+	"addiw	%[__ret],%[__ret], %%lo(" RUNTIME_MAGIC ")\n\t"	\
+	"addiw	%[__tmp],%[__tmp], %%lo(" RUNTIME_MAGIC ")\n\t"	\
 
 #define RISCV_RUNTIME_CONST_64_BASE				\
 	"slli	%[__tmp],%[__tmp],32\n\t"			\
-- 
2.34.1

