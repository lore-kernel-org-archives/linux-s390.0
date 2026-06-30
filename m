Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012007.outbound.protection.outlook.com [52.101.53.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A0233E170E;
	Tue, 30 Jun 2026 04:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.7
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782795495; cv=fail; b=qs35IxL67k3vBLe91VB8LfZYIY8h4xHk050UXPEgFhgQvAOMydMCztHVBa2Dqi1Pu/XghVxnP/p748aEfajxDZ2c+cDl7KYArYkDtO47gOVyOJuM7wGSci0W7BzHrmtl+bWlwRVRz3OeNmp3GmtTFAXUab59S+I5FpzfAsBxcis=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782795495; c=relaxed/simple;
	bh=0qa2nb59Vg1jiqqgs0CW8ljeUS4kwvKr1c/KbSQFydQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rpcX27d1At6MJm/G2xLiw0pC93Ax1x5uLnz4ZBuzU/L1lI52jziV93BevN4H0iFldY+W6nY8IHMPO2icSdaVp2RLtB9miGmQXSd/6xcxEw5FXESfNV8JK9L19BIlvRoPCrw6L4h52mlqM3JGzbHy75YghhWulny1Xq2iHDkJ5hk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=FieBjttq; arc=fail smtp.client-ip=52.101.53.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="FieBjttq"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xKwjE12MqE7Vn82wvJFQzxU2M80Yek9TBhzjP8BwQ7hD2CayX8np18VDbJGqz35DDRgUtgnMLs6dWlQaDvhDhZReFnR2HeQ+v/dblM7MPG7fNJgd5k9A/GBfzSXQZS6H6tNKH1oRNkjjuM7tubOSylDUenLDyHzbTmxqEpxCW0SkyOB0ulg8GikcgHilGr+61dH2J9qtWa+cyu5mga6uNoHYB3Z/XPKJoUNMai2+0PhihcwOYusPHbIaLBj3NLs1ZbplABajEyUkQyeEQKgfioUIrVzdzzye22dmjGf13RoK+VOXhWBWjC/rNppYO+VDmaXV736d9kocaE1RZgrgbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aysRR87v6pz9WttepGyeFsACEanROhELe6zx1c7a9+s=;
 b=wYolzUphsIaL7JGRSNgn3MGjTxilOx1W+ufWnoVZBRJ4dS6hP8sM9gcOvlLunpzeFMB8aAczwtyqzAcHx4JkFmnEEcBnb6Xo0tNyguDBoK0ChXGJSIktwtypKpis64JhrL21G8foeNR6Ar5bFxugzjSQrahekjU3YU5NY1TC7hTFf5sHuLVIwgGhZUaIoIu7OWVRHKTb78/DcuhhXWPIJAfizFx8uWm6MNf2i3hIA5QS6sd0aqubiycEuI3npvMmEKbZIugcMQb7dMdCs0fQqwz5wreojdwijMd9V3zgOrnwb0dDug2RSKGkkeppVz8MWGw2QCkh/N0Q9tkX4FwUrQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arndb.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aysRR87v6pz9WttepGyeFsACEanROhELe6zx1c7a9+s=;
 b=FieBjttqkS8s9bVpLpeo7DhUKrjPKcmTS1xwmuoL1fs2BhR3a3qXdlz5wLnZf/PCJmy8PPDUbMNPtOtcXlkNPHDyL7X8yy0EICZC0XWjKxVhPW/7i2LPGtmAGbi43sj2Cvq1lqKyl0Jw1MEHjXswuGqzgFbevp+IAMXeakx4KsU=
Received: from DS1P223CA0008.NAMP223.PROD.OUTLOOK.COM (2603:10b6:8:453::18) by
 SA1PR12MB999229.namprd12.prod.outlook.com (2603:10b6:806:4db::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 04:58:10 +0000
Received: from DM2PEPF00003FC7.namprd04.prod.outlook.com
 (2603:10b6:8:453:cafe::48) by DS1P223CA0008.outlook.office365.com
 (2603:10b6:8:453::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 04:58:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DM2PEPF00003FC7.mail.protection.outlook.com (10.167.23.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 04:58:10 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 29 Jun
 2026 23:58:04 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, "Sebastian
 Andrzej Siewior" <bigeasy@linutronix.de>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	"K Prateek Nayak" <kprateek.nayak@amd.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>
Subject: [PATCH v5 7/8] asm-generic/runtime-const: Add dummy runtime_const_mask_32()
Date: Tue, 30 Jun 2026 04:55:30 +0000
Message-ID: <20260630045531.3939-8-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260630045531.3939-1-kprateek.nayak@amd.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM2PEPF00003FC7:EE_|SA1PR12MB999229:EE_
X-MS-Office365-Filtering-Correlation-Id: a77fbc63-5dc8-4a1c-2c27-08ded6642eb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|376014|7416014|1800799024|23010399003|18002099003|11063799006|22082099003|56012099006|13003099007;
X-Microsoft-Antispam-Message-Info:
	GZO6cuigAWGBzrIeyYRxVjNDjjlvnREIAJe0TSfd/+u2/cs+IRXwNaFkH0yPO+8AHF16R4dg75HPn4MKhK54IrYfXmQkd3WxNwwF5dzoJCYoRFIsJ23GZmBaKz9YdbNaiz9W/Rkmukky6OgGOvCibRi5sDHBkB2ABiGkr1ezJGz8McGGNTJrzB9hu2B8asTHj4N9ioXKIbpPlQnNM2nF+6wdxgj6Ziv0X8hWIYihZKep9TGI2bBSKqXUddpL/A82L8/WF2a9hDiK28Io+q8QPG2pD7houBrEftpEZatnVj/rSXIft0WauzwRRb6HCvzQbtGVe0L6kXxKvG1xUD79qIBlWu5+J9Rkk1bkjM0cKUkl6Y5WjlJJuzKEjJyPPGrXpT+VpSkWqS58C5LZUbzSbuADwGc5NvP9oxuPHUgegCTCL1oKTcvXNaKZZGWhherSoie7WID8OA41ScEcSfErxJIe3NoqXawZT39i27+/4BcK6W6/R3ljxX6zEv2fm7IZBbIVp3rOA3R8IcSQGjZYhevnh3+vrbbcNPFnMYVpEFh5xZ6GQ+n2C2KF+mzlTOIPC0iQGhAA1XB1+Vb5B70+YJa2KG/Qym8ajyG39hmrbzPZgrNibE4wVYYPI26oZmeU/WvCATcmluNuuo8k5yIMMRutyBWhgWxn6DTX4n+uAW8=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(376014)(7416014)(1800799024)(23010399003)(18002099003)(11063799006)(22082099003)(56012099006)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OET/SnLVwS7AlRCBnlmlf3Xn3godwsf7oORVjA+IVVW469VhjTYzqyqdDSJ9nOFWqmsPffMjbJKDF8PhFsf6hgbSQhHw+gjZpAHOUn/xmpq3glY2AQv2qCNR8dEAdTufMkiEDAiDYGq65VfOiHI6X6t92wJb63I3Gy+OOUfX+VQ9T6mfE+VGhZjZoMEPpRB1Brc083cg/BLB4OpYkgiLAp4Gjmxl9zH6MSOm8b6ks5srS4tYs37vsGggg5pqMPO65bY9NFSFqLzk5dLglio/R5N++XwtGP019mZ9Yw47wJlOXBgmMbl1bgeOwS8+y0hsJ7sVeSK92Ia1TcYDO4TYPlt+nDeayBRTBi6P09GoHDnUUsOz2hewFQm+Znrdd0LfMM2rGMVdUO1WFNok/cXIFlp+6y15mW7hSvFFCa8Op3pFE7X9MTNe4oAjCcIeP/7v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 04:58:10.1577
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a77fbc63-5dc8-4a1c-2c27-08ded6642eb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DM2PEPF00003FC7.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB999229

From: Peter Zijlstra <peterz@infradead.org>

Add a dummy runtime_const_mask_32() for all the architectures that do
not support runtime-const.

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
changelog v4..v5:

o No changes.
---
 include/asm-generic/runtime-const.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/asm-generic/runtime-const.h b/include/asm-generic/runtime-const.h
index 6704994595145..03e6e3e02401e 100644
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

