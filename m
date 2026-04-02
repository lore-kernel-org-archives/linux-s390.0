Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013056.outbound.protection.outlook.com [40.93.201.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F8BF3B52EF;
	Thu,  2 Apr 2026 11:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775129142; cv=fail; b=g0g7m24AHEkrhSukno3AhQYzsk5tqf48J9gH3gmDlu9XMFGz+nSf4oZC95zLSfu65DzhBr3IFUI7y6qkoCR4NaKlXVrZDCikxrE54uNrsmzw2W2sfnpydoF9u5sweGMaaf4U1FFZ1qTPyXnnkOC4cZ4Z6pmil4HvWQnjFSX2ZXY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775129142; c=relaxed/simple;
	bh=7uLdhrwqEP5cyieH1s3lHw6Gj94g6/MJ+TU9/HHm4ZU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=I793a988gzZF9PtNri+FIdd7WSYM2gQTpXQPTTZGrRRT5e9OGaax9sGyTe5oE71Y8negw1aa1rWc7BjXLJz84P4QoPlSYegbGilTaSB6jUnistEtuvV0cxZOHwlEyVO2KRRuz52b5/gH0tpDLo0XJ1eMJq0C72Sc3KN2kHeqASg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Zxl8Fo6V; arc=fail smtp.client-ip=40.93.201.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Zxl8Fo6V"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=wgLlivLg+Y4WGwlQNo1O2W0Cjch3fPPWVjdKstdUMS0QArEFQYtVfhFJHHjRhjSKeNwDLXuDFq3toXoQLs7i3W52yiztKZJjH0RVVHCbbPhcip3oav5E14VWH+uiIvucfeLa4laWFXLQIl8aGUNqa5WVQroJ2bNMPfwcjRJp+srwl9oaJFgESE4zINxyU0V7B7Jt70geijOGbdYv5JOyfs2HEpQhYaCoFgKFhgckMaT+f9jwOiMdK9n1lTOdSP8TyHnjuJ3ru9+z8BRAeqjYGEXeB62fFYjqeoNX0PwsAm5zxBhumnxPd0ugb+mv+FauRRuOI58p6ZFjhslm6esPjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=W9yVkfs+D03aaONZyxxaxc0QmtRrPMgVegcfzsL6+Xo=;
 b=D0IGddRj8XabXbsP7pC9q44wAGUkPeWPrsprmZt/Wniy7VNJbQD4FWNu1bL0GCQbgY7Yf3Iw72QQoraHkS6R1MbY1p0Z5VJ6HHvWmVX935ObbCxosK5GT2ghx6Ctvb9MJBV409eQI1BgOAAgid24dBeIgWUYhI1zp/UWmjN/XYrYKke2SOwX4jYpIyJZz/sW7YawnwyRu03HLekFHqzokqgQh87nxIAa+sGIvRNS5Zri9X2M1X8RcDJpGj9m+PSdZG5Omsrg/JpaipGT8pA8lGOqTtxWOZtbRZOe1uSUwbY0L+JsAFjSzSZCZ0tCjNqqCVaSF34k08v5QYI25NJ3aA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=W9yVkfs+D03aaONZyxxaxc0QmtRrPMgVegcfzsL6+Xo=;
 b=Zxl8Fo6VCr83VjpglJTrcXlhdh4nw8x7sUhq6/0EDGGMvrAFflDRcT3j4VfEYEilMF28VDzKRou13XiMTdmD/fbiojwRglyhXjMsXeLCKiBypGoHPH9h3K5HpYoaNFBZUAElTv+eIVche1amOrmZ2SmCZLRTJoyb3z9Rd1MPbmQ=
Received: from SA1P222CA0002.NAMP222.PROD.OUTLOOK.COM (2603:10b6:806:22c::9)
 by DS0PR12MB6584.namprd12.prod.outlook.com (2603:10b6:8:d0::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.20; Thu, 2 Apr 2026 11:25:25 +0000
Received: from SN1PEPF0002636B.namprd02.prod.outlook.com
 (2603:10b6:806:22c:cafe::4a) by SA1P222CA0002.outlook.office365.com
 (2603:10b6:806:22c::9) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9769.18 via Frontend Transport; Thu,
 2 Apr 2026 11:25:25 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SN1PEPF0002636B.mail.protection.outlook.com (10.167.241.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9769.17 via Frontend Transport; Thu, 2 Apr 2026 11:25:25 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Thu, 2 Apr
 2026 06:25:20 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, K Prateek Nayak
	<kprateek.nayak@amd.com>
Subject: [PATCH v3 6/7] asm-generic/runtime-const: Add dummy runtime_const_mask_32()
Date: Thu, 2 Apr 2026 11:22:49 +0000
Message-ID: <20260402112250.2138-7-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SN1PEPF0002636B:EE_|DS0PR12MB6584:EE_
X-MS-Office365-Filtering-Correlation-Id: f799ba95-1bd5-4bf6-d63e-08de90aa895c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|13003099007|22082099003|56012099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	6fh74lxNwIFNj4RQJoO7IaesS27K/FgiOYx3nHBeXokf4Gyspr1nDjKG/PT2D/ymbT1GnGzSZy95uUId7H06BCJ/hCFIu2x2LjhAA9FUPoFkGHra8Dei/OGvSfUOVmCPv/cW5rfQIOhvt6JJef2SErFgUNXgyPpy/R7ldtx1hN2rD3l7CO/yIHMr19RDyP8+GgLn0wyhC29wJU76Tt6DZKrN32xmq1/w4twBK1CBk94Fmh6NcTTAuLhLcLiZvnVT+aTOcGmQVCSw5wNrVvn0H3DeErvjmqSQQ3qEY0SSwLbqdfv3XUEB33rncCKz/ci8chU0jc2gCIGMN3SsKrbEfKGAjV1Zqw/p4FY0LPRPVQoc7Oa6HkB/hAYFgyLhvAxIesOYXBha/YKJBN5vuy89RZY+TKy+JHfzybaLocxwbZvfXgvLPgZMjkXVmK0Rveq9KuARkfn6isavvZHq/ty0n9qTPa3Ip8fj8Kvg08tLKKzBZYeYl+CXzSpjMSIBDZ2KKZZiVEpYCrS/K7L9moJ6ol4Qf0Ot8RMnDiccaRe5MD5XFYUjT+vLpWso98TL8IunVMeUziWs+sXzCkOAm5axBtt5uz6bgjcKm8bej5gbhcBcL8tLKBoasSId11bqpcVj6kh1fNYQ4Oqtm/EbvvajD2C/uHt7nLRmtkd7eMVCk7ap21HU/pXOhsV+kpbmjnijej0jKEKrVBmrNxrdJrnd0rpbN5O1qg3xGsd29VDOSyE=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(13003099007)(22082099003)(56012099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	WBfCpFsXxdU2gtIpC3ch0rVAgO7hbVQrAmhQ76nY20PWP1pTg3PYGdXrJLB7OOdnx11LeykW4hx7OopatURYcBZjxp1fZdWikOn/0YC4rBXQPqga5X3VdxddBVY6pMjaMoE4i4JmvZWQtuPNhjMGeYQi5k7ZnOthJUXGAFbAUencEHkewCbVNQOEDaqIR/RhLTEbkFZxyT2fVpPYJFpXpQz2qSyrfEi/7qzv4uWRFmPK8LqVuvEQEBfzmV33MuMGYNjIBhIF2UZA0efXh3cGSHeUFh2ac4a1r+68YWXJDpKG4SUJT+z/D5R6smIS2HexSaiCjE/ZbjkdhGbyeYQjuJYqJxjXz9RW3PQfsDH6uJx7vsyr9itrfDWfvLmDtp755oscYbX0zPAh19664u0PmQBxmu/Y3jGtgYGRwjCrQNrHUThrIcypUbPg4DPyTMvN
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Apr 2026 11:25:25.5969
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f799ba95-1bd5-4bf6-d63e-08de90aa895c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SN1PEPF0002636B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6584

From: Peter Zijlstra <peterz@infradead.org>

Add a dummy runtime_const_mask_32() for all the architectures that do
not support runtime-const.

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
---
Changelog v2..v3:

o No changes.
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

