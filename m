Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012003.outbound.protection.outlook.com [52.101.53.3])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A68F3B2D38;
	Tue, 28 Jul 2026 05:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.3
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785216528; cv=fail; b=bz/VC1dOOKMhE2kihN5yBmpIWtNQLBUBcZuliYZRQI0Ow6fVhVSVa7XNZJH/0gGUYfJiBGegKM1+P1xYAvou7OqwcTfmdMqSc9MSAW925kt6deWZZeRueSP2x8+fyiuwkwNF/wjT0YWcxwPICNcgQrOOL9MfWCRVAJvlb1evgX4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785216528; c=relaxed/simple;
	bh=fvTLbRmf8pyr45TW2shs7e9eF2Xt1jstoTGlj0uKDM0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ctkqKVgaAFAvqS3iSYCZmh40sZus9TkZMZ2+5nEVBhN8EpwrlMA3724rXADgxfhkJzO95oFVCCCi4FAQFg435MeDWAkxUnEdJmNRa4HW07Wg1QINlus+tx0hyprX4ZbajtBGtMf3WFtb2UOCIDxg5xdDBU8KcLSJfoUX8Tr4Jo4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dqNZhzfg; arc=fail smtp.client-ip=52.101.53.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dqNZhzfg"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=GbdD7Ry9anC4OJ2syWlMy0ZGq5yiX0l3d3WKPRrP82/nNBOwD779iaIc9A6Q5tk8dg0kfDpuKr74Cf/LwNbSP9WbTPc0f8O1iapSk3r5/p4ZcYU4tVmfgw4YcS1ZvxTISt7FzXNniI7AUU6CnLZVTHuYPvm19WW+mC4JluWnx2/CiyrTHEVhF5rwPDxY8WnnUq6RH16VPYt7Wn7oYm7zeFAMYSi1pKzdo3GtaYTk2aTx04GJl6qQbRZ1KRp4yh5GU1QxS3T7LupvBS0qqcyAztxoHm44W7k/H/6RLa/hWazQsdPB1/qig1g6luHL+ly6SpjTTWSXdjAQY+h4fiMyRg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOTiOEMREblqwh/rZ9AxXKDQ2ztOuHslt6jqY/NQqsw=;
 b=Nt3nj88Z+aUsDro+UZuKbyYi/aFVSzmUq29lBNN7uV+t8wx4YIJOF9Iu0vE8V0Zwcw7P1nrTytJJQtRxKHi2hb1sfycrspPN652I731sUZd7EltwLv7PwDTMxVYESynFvnZg/AiMSGoM5NU3aNsuAYOx6W155LNDJb1DnkW2ajNZYr1JZjrFDmNgdbOoNMDfO64ZiMo/kMolhQNG1ez/A+eas92LA2RNfzzt36+4gMwLidymb9uu8DEK8HuAH+36/PK498Ylk2RUX8+9muzlh3+z3GsS6cGS/kpwjPDkZaVIC06JZocXFtxOo/GjV/6imy+e9FoUMNPBGJba40ZcKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fOTiOEMREblqwh/rZ9AxXKDQ2ztOuHslt6jqY/NQqsw=;
 b=dqNZhzfgc3Ur3bjLa6Fy4yOq468YMiS4G8fJ5QzChb23Vpcu1zmdgDPqbV0qqBRiSG1Q4fY1IqEADgB174v+PQIVMEivSpC5FsTT6fMPUsTAzFGH+nP0HGo1Z09LZ1+zkpS7maWM74A9VlViSf9cQw+BVQ7vEN/vHkbpPqEaDS8=
Received: from BLAPR03CA0123.namprd03.prod.outlook.com (2603:10b6:208:32e::8)
 by PH7PR12MB5617.namprd12.prod.outlook.com (2603:10b6:510:133::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Tue, 28 Jul
 2026 05:28:40 +0000
Received: from MN1PEPF0000F0DF.namprd04.prod.outlook.com
 (2603:10b6:208:32e:cafe::69) by BLAPR03CA0123.outlook.office365.com
 (2603:10b6:208:32e::8) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.13 via Frontend Transport; Tue,
 28 Jul 2026 05:28:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MN1PEPF0000F0DF.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Tue, 28 Jul 2026 05:28:38 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 00:28:33 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>, Charlie Jenkins
	<thecharlesjenkins@gmail.com>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v6 7/8] asm-generic/runtime-const: Add dummy runtime_const_mask_32()
Date: Tue, 28 Jul 2026 05:25:39 +0000
Message-ID: <20260728052540.4728-8-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: MN1PEPF0000F0DF:EE_|PH7PR12MB5617:EE_
X-MS-Office365-Filtering-Correlation-Id: ba2ffe62-9235-459e-3474-08deec691408
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|36860700016|82310400026|18002099003|22082099003|56012099006|10067099003|11063799006|13003099007;
X-Microsoft-Antispam-Message-Info:
	aAc4Lxz6Qo3S88e+lyTbeZI1k25VNq26SpJH9d2GfmNm1GuniaYS720//ZQ5DmNsokIdchKBGlk9wWPZowk7fhSm8XDeNRzP/kd6/6IY8k2Qm+fCRKFiXfoDXTVW2MNB5mtuxkJcmA30z8Pye0cEZQmRUmpWlNr6pPCE6sQkxtBy3E1o3SgdNRP62N0Q/QxupDjnjKp/ggbtAvTKAag4cn5nlicUxO0oyuKBuEN9F9QrNS4fUTJ+Lh0XvO2cyHrVn/BrS+LI+SyDjBsdS+7DxU1GIh5GcFc4h0J2O7G2QKYqtQ69AHwlbV7IurlIwO+t/NITOIaTwhMrxDDAjvFl0dXLEF1FfuP89gsbx9TxT2LWgJPuRQcCHb4TOg1An2LAenOPM+NKaJAqnFzXrgDi6t8h4apzy6kZGfzMKM69PpqHoYgNPZJkYpvyq5GmyvCWEXIy1i8HBRVMQ+SRY2m3j+VoLIs/Z+ALq6zZoZNL4ya43/vYosS9djPpePmi/LxepY3tTSMMz94AQFB0pcEhY1rRC0EydOT5x6m09TcJdM2eZUTxbpzTisNa7M3ImE5khLQ3M/Q+Zar1weVnEbPb32pgFT7DIPkABO/EQVdngPg4YGhXjoNgHt0Bm/qgbc2RS9Ylt1R8J0NdhueaoubqG8Sfvz17lM0STn9+tIFRlik=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099006)(10067099003)(11063799006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	b7KzRzgrjf8dUHekIyCSapVL2RmpqmOQIJ173Jh/udULTKYSF09GwVdQWE5oG+tOQYaRltxXRji1R+a5dgWRR1zrxBzYdc+u+bxoUB/RPLVQh+wVCk7FSBwTOvhLswxOgkv5jdfWjN9hR3DxVjRuhitqj7YVcFwkdds9PX3wAPx2Lp0XTVOzmgYncaAhCfZtaWOGTDhlPvvTR3EUEdq/JSnEmNgpDRmdE+tJuMtdOMQlfr0ymToqdu/KZ0dubNqlHUqYrDvajtBn98x5asIUArAeDM2CIAU6TNIP6MIsyYrDJDok2fjKWbuq1V0HyII4SNhOSNyHJxWPX2nNTP8aLRzi2vqwjxrudhrlxD8SOaBPIRqVQhQUeHhVGEANgb3cKu18TaoL+3qLjgnCHtuR9ap/RNzcxh+P2U3cLkuGoW6dj5O6QzQe103KCPNEJ9BO
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 05:28:38.4291
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: ba2ffe62-9235-459e-3474-08deec691408
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN1PEPF0000F0DF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5617

From: Peter Zijlstra <peterz@infradead.org>

Add a dummy runtime_const_mask_32() for all the architectures that do
not support runtime-const.

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Tested-by: Charlie Jenkins <thecharlesjenkins@gmail.com>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v5..v6:

o Picked up tags from Charlie. (Thanks a ton!)
o Picked up Peter's S-o-b from his tree.
---
 include/asm-generic/runtime-const.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
index 670499459514..03e6e3e02401 100644
--- a/include/asm-generic/runtime-const.h
+++ b/include/asm-generic/runtime-const.h
@@ -10,6 +10,7 @@
  */
 #define runtime_const_ptr(sym) (sym)
 #define runtime_const_shift_right_32(val, sym) ((u32)(val)>>(sym))
+#define runtime_const_mask_32(val, sym) ((u32)(val)&(sym))
 #define runtime_const_init(type,sym) do { } while (0)
 
 #endif
-- 
2.34.1

