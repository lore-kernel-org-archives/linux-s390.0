Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013011.outbound.protection.outlook.com [40.93.201.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D6393FBEA4;
	Thu, 30 Apr 2026 09:48:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.11
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542507; cv=fail; b=GtFUw9ycYcmItwjPcKIBdfUMqyKDDu4LYC+eUsMyyCi5KVLCE/C4azrL360NmUZG4GGDG0goDM7ObskHup3tn8S+A7iyvN29dUWcO3j1/BwFhdOhxEmk/+ppkpzyrH/W1JH+AoMuwCdaSZvMceRCNjuiM51prKXZzDgq+Tb18oA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542507; c=relaxed/simple;
	bh=ARRbm+w7acZXiWXh7w0eoW15fGNZHDpr6RPKaFXH75Y=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YD8fE2mjLFJYQBs3PEbY4kHW5eWS3/JZ0BCuYCRnN+/n9qwoARKlX+VLiAjcFALoGAGWybeh4enhcUzAo0sYvBlBfQfnFWYjquKzEVmBC2D1Z7KMB1FkSXDBqlE81TVQGrMJP0gFkqDEeaua9v0vxrYQdL/PLeqHfKdndD6ObjQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=wN5QZNjC; arc=fail smtp.client-ip=40.93.201.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wN5QZNjC"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=XTx1HoGLJBTvlE9px6bbQK5uSunq+OTGXBSeaRowCuxN6Adw1ilbiaYMo60Ed9hbfGwZZMHymLNFTmkE9SDVYETzcZyMzoof0vSzgFImo9bZLYaB3zVNqODc/5aYkHJAz2SqpeTo2WA4LbJ5z9wwzUJdpDJ298Fnq7wc4zdzgJChAQlulqDGRildPBixakIU3pMz0mcN91ygwwzFnVlMZR+Z6kIO5SBt4raRCgrnHEX2LuApohXgtqPq1Ip1VryJ6XoiCdAQ3L2S2XoJ+td60Gkko4jK+mhWGLLa1yj/NZ7JTfQAusmHcg9YL7OwJAx8fAQzc/PUoufxSIEZwnyc1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=CUr40PlmRY39YGug+XLiTpQBcY0QfG0XM5XIpB5A8lY=;
 b=qQeITwCjmvVBIp2DZoN44MkZ5MGQCGkTqJtE34ApqTqD1GTJO8N8N402gVznlOIyjdp64m49lUU/Le7ryksHDH/DReR4Kfske//VSh3moMQeFDoA10/vLFQcF+201g32qYEz8EX+deQSYpn01dLPyrDfJ1ENGHurBN4Rp98Anctem8yilqOB9rkAEH6Co7XIRNYU5IrdjSPKjb0RVcufH1ZL6bSAF2t3c5yyXqE03sUxm/rF5RgMIxI5PaeWSq5kWsFp4OlZ3tl8+kUS4niqt2czjwPvfC9g2sqD1FSvr0EUa5bOGNxY8IiHqkWFN4sM0sRjxx/KAOQo5oagq4iNHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=CUr40PlmRY39YGug+XLiTpQBcY0QfG0XM5XIpB5A8lY=;
 b=wN5QZNjC/TsXKhhoGb3yWPcLgVkQGLATGF56xk/klVYNCBYeyc2hLfr8kYc+GXiuZGAF8MtFeVioeeUfO5frJsffS8efaV7i1ZmnaxEIATTLCtI38WGHfhKwuaQfxrPnPpFhyIjPRbWr+uybLgRpUTniKoHNcjiL41RWAU9fIY0=
Received: from PH8PR07CA0011.namprd07.prod.outlook.com (2603:10b6:510:2cd::19)
 by BY5PR12MB4164.namprd12.prod.outlook.com (2603:10b6:a03:207::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.20; Thu, 30 Apr
 2026 09:48:22 +0000
Received: from SA2PEPF00001508.namprd04.prod.outlook.com
 (2603:10b6:510:2cd:cafe::18) by PH8PR07CA0011.outlook.office365.com
 (2603:10b6:510:2cd::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9846.30 via Frontend Transport; Thu,
 30 Apr 2026 09:48:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF00001508.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9846.18 via Frontend Transport; Thu, 30 Apr 2026 09:48:21 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 30 Apr
 2026 04:48:15 -0500
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
	<kprateek.nayak@amd.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Huth
	<thuth@redhat.com>, Sean Christopherson <seanjc@google.com>
Subject: [PATCH v4 1/8] x86/runtime-const: Introduce runtime_const_mask_32()
Date: Thu, 30 Apr 2026 09:47:23 +0000
Message-ID: <20260430094730.31624-2-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001508:EE_|BY5PR12MB4164:EE_
X-MS-Office365-Filtering-Correlation-Id: bb15d2f0-59d5-448e-fdb8-08dea69d9d6e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|376014|7416014|13003099007|56012099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HrI+Qz/UaBQw/cIMYpjOzt9QXh79Pk66Rbmk/Sd2HnnTaf7+8emiyYqhZBEXmeqmmRclHpUFYtojBgJmyoafwAYNCuhhhBSeR5YtAVAZZYc8EE1eR3ViBUx/vld0adY5rdpjLTCPB79+0xAsuZcuHsMb5co4syRf1+YfqBmm+GgFEwCrSKb2DcniJTLzBDH2JxbigXHXRF/C65gO9G7pGZRgcqB7xtZ8pvp5dlbhNmm6M2u5sDL68DGj78W3+MZXRK0soG2yivl8EE9Z1wdadIEo+gtFPKwhpjbj5cmhlb3hm2+cY2cYGz655sQ9i/XMl2B3zqT7ayP2iHPwrV6fUTYxfDDBOIMaY784pZ1DcFf1oibzRwljvcSH1k/B1Lcr7U+7Ax60ydf9vWiZrOeM910MxY5au/ytAb+aVPHZazsXg6q0xWukCEkGEJOYMvH7rBZXAOMVnx9P3v57C9nSRZ7F4mYUFN6ADvYVJZpj/lgCFjNdT6UAi51gdIgj+bpbdm/zXeVkbj1jNFRxbUag+izYHAx1CfoqDLEAYAfJ4G80A6WArN48QA7ymffFJAw0jlSlFjOkJUYRNAj8aMjdsA0HJBXXC1tucdcON7n07zMYOMLpt7+Pu969CVBFWjdqTEO0Yp5BObmAWdq717IrILMdWz1it+FNir3ZDcHBhEGhjANwgsH878/MHNfsMIkv6ixhUpxuQSlcR4deirmwdNoBEBZ5E7Tp5dFWOd+sVIw=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(376014)(7416014)(13003099007)(56012099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zG1pbYHHtqqPtsI6A0/Ib3m0GKzLF1IKSUloTvflUjZJAT79xytmFQBsseNtLOxfPpVICT0Hkfqc4z3aAJJJOa17jiP/LpEn3SYPC30dYrImo3ctdy0An4tHPPGcaqkT2kro9qU0VCIiTmYlN7l1+/Js2XQxLWiJSHpM3IpDz4mpYUg8IaHfh80WGiM+wegraydX2IP6pr8qrAr/6rLk4MvRMBABhFPY7AKG3eYHndvJ6DFgWkQ1t9ydXmsQtwcFG9JBVyhjbmripLR0/8nQ+IRcXLjhWvr5jUoWhcrJIzQ0WIvl3/JEfnGkJm+IgU3C/EyIhoKHszEq9wneQQEx5Q9wui7fYcFjqKY6SW573qo/JPq+xWX4aG+zjCzXShK331vtOCzTOuTm5hYSWXTsKjR+cgez+Y+SlJeoSW4IBx+deSmzsXlNQobCc87IvUHK
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2026 09:48:21.3886
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb15d2f0-59d5-448e-fdb8-08dea69d9d6e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001508.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4164

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
changelog v3..v4:

o No changes.
---
 arch/x86/include/asm/runtime-const.h | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
index 4cd94fdcb45e2..b13f7036c1c9b 100644
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

