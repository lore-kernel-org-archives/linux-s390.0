Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013046.outbound.protection.outlook.com [40.107.201.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFD533FE05;
	Mon, 16 Mar 2026 05:26:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773638778; cv=fail; b=AVAh4sN4sJQEtCBbjcebjIk2zH23F4wtzX4f5mvBL/p0DXMAe9JXq1iIackRP5e8WKSLnUL0EEW4F81zDaN8D5ZBiy0ou0f/fKXWFWCndvr1Rc4/IAuyiiRi9x6wuAed0XUuQeyF++zYP+vDxM6Ho3EjRQ81mm8cDA3f2x8Fdzk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773638778; c=relaxed/simple;
	bh=HU2UH3ordm1mRlxrEsWanAKSD4o+9Th7H/BVXp3a+nM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lM+c41s8GI/E6qM/CUo5SfOgqkisaKXZEzXePKmFC9Z8rzp1KvoGe73LBniJZccr2Rvzq4xm9n4zakeLVVX/pyH5sIi493L47u6dvq4z1qBImIxTcru+pxrPJT2c8gLr/Z8z9KF0aZLgUexrLjjafYBpjjQEVJHporVPOPk+ah0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=XU8SI5cb; arc=fail smtp.client-ip=40.107.201.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="XU8SI5cb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=g0S2sUCRCNgR+iDDh8duOaKEUrNViLrrU3OspdG/7QMny+CP2c1h8k5bl3Mb5R2mMzqRJPprOaYyj7LlOBc6WyQO+wpF4K109M+8C+Eju2JWYJN1sSes5ER/esMfJnQpa7/KRu2KVrb+9bwWdWcw3nF4roXSSRsn+z6eSDCMcydAv1x/8gO+Sv3wO9q3efNQ90ALq+tvYvSL7bN6KUhLoJOEjAizRTJbeHU7oROhDSc/gEaUG43XY+hG2gfsHgoX8Hxjn9vewNexcrQ72RGzxhQSOB5GVfozW3bC9oZV7qJeeOuD+a7nVInjHc2A7MycZiZMH/In0UIS5Frt+zOvjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yjh/keoUIjr0567Q1/PvQ2pqHVXECc7ZdVYKuZ+LU+4=;
 b=lMC+1SD50R9jaOTxv2JIaIYLuRo10ndq5R9MS2sj7REMayHgSNrdhWXov8EFXFf+z9a6NREsYO18Zm80sEFKUW2Mm+tynoegGt4jh/N5/heh2swsgD8w2VVNPPQQPeyCrjADQiE1ssGKyTIkfqTCxZTqNCnagTopmzaVa2CD5yiu3qM061hS2yyGT9vxv8oqCObsTVYN7pgQGokfim6i4I1AQOHxhi9faXN2wGBsbTa30WhiNamale+R12i3oVbiScWS1RQE1SwdFfWKlWCngyU8++/ndrYayMwjSnVniHNJhh8EjsyO5BU1L2bWhzwnWFTfZXtcw3fbDrf7TcLedg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yjh/keoUIjr0567Q1/PvQ2pqHVXECc7ZdVYKuZ+LU+4=;
 b=XU8SI5cbc26zQmCFJtmROjcAxst8/iUSLNLblBZzm5k5ytPGXjANZG1qPRmUpXm0tMCjE34o5vrZWBYc9wE3aInZ/SYfi6zaYI12d2IJJLO7L/CTCXyG26YjCMHJLxw+rvnQp/uzaeDxDh6qbmZp4h86YTZr16U7rbC3C0bVW48=
Received: from DSZP220CA0001.NAMP220.PROD.OUTLOOK.COM (2603:10b6:5:280::15) by
 BN7PPF7B4E3DFF8.namprd12.prod.outlook.com (2603:10b6:40f:fc02::6d4) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.8; Mon, 16 Mar
 2026 05:26:14 +0000
Received: from DS1PEPF00017097.namprd05.prod.outlook.com
 (2603:10b6:5:280:cafe::d1) by DSZP220CA0001.outlook.office365.com
 (2603:10b6:5:280::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 05:26:22 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017097.mail.protection.outlook.com (10.167.18.101) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 05:26:13 +0000
Received: from BLRKPRNAYAK.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 00:26:09 -0500
From: K Prateek Nayak <kprateek.nayak@amd.com>
To: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Arnd Bergmann <arnd@arndb.de>
CC: Darren Hart <dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?q?Andr=C3=A9=20Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>
Subject: [RFC PATCH v2 6/7] asm-generic/runtime-const: Add dummy runtime_const_mask_32()
Date: Mon, 16 Mar 2026 05:24:00 +0000
Message-ID: <20260316052401.18910-7-kprateek.nayak@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260316052401.18910-1-kprateek.nayak@amd.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
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
X-MS-TrafficTypeDiagnostic: DS1PEPF00017097:EE_|BN7PPF7B4E3DFF8:EE_
X-MS-Office365-Filtering-Correlation-Id: 055ff733-061e-43dc-87f6-08de831c8a46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|376014|7416014|36860700016|1800799024|13003099007|56012099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	dlLsy3EfZmYgxd3A5ysPKPB6kpfpDkSKuKcbF1qyyYXkUo8Y7euhsBIScIm7tJ7GllO0Adk55tJQRH+Ym1k9NwdNHjvGz+e9Nd2vgXPTZ4/ZHQR6sD1/MspKw13dHw7E5lSu2CC3cpjzMAxw0xZi/BTSlHquksKOg9Gn45D6gVzXKT/KavAQ3GUBH8BotHFTM+07dEcJT/3oQiagS0uxolC7OdmEiVshY8hkaotkCOJAQ6oZk2yajhkZPtG5Kkakid1fqvImB/fno4x27G0746B2TFvcqfAL1+oJWkioP3h2HShoqv75ecvUaP0db0BbAnFWRfDzjo7xgeiDq1HFn1SHJvXUJV4J45F8Zi6czPLnMKmIltTs1AFX1S6gOdR8Iojsm+cbaM6JZWA4xURbL5SIMZEWMqVtW5Rx5dEGQQEbgxjW4dXfP/SCtVwaAzw88yUMpo2Py1LIP4X8mVDJqFYfycmTgpJTCp1ihkplIIRnZ4w+8veb/14RcyuxFJ38k+D5ULOAWekrLUvNCSKPFLLqh+gGoimWb2kwmYECjEKGbrQUbN345XrW6KfWDF/T/J8O3vRuBvSLcAwAS0Po0loJ955H/dSryREln/C/1g5slT4IlUazDmv9oYwLE0zUDmwdxrGpa6RAG+wBuv19FB7FDIIhHXEVdqgfDfPpzJJffNfph+qyQ2uBYHPyjSq6aackTpoI4SIRK8eQEYcx17MHZi09tokdQ7UB2fxbo7k=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(376014)(7416014)(36860700016)(1800799024)(13003099007)(56012099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zpXiLPCRms0/32x6ItmrB8tkAMRblQWSCkdfULfgVYVBCab9Rq7WKD8mJ4dnvDjWjzYrxamgZXmUXPWe9xHeyl2WzvaJEZK7YXINzMpVdR7S8B1VP1RGoCGDa/IyYlZ4drUWhco1LKBoxqj52LLY1ExfdtQ/uKRRXtyZ4cjPYMRgcSXnrBi8rJoZ8NeaecCR11+YWo4vqkzb90JheKMpg2bcL5jPtUFDTE66i2aMqQAL5/fWxaYX9u3JaCv9EPyUDs2wZiBm+/X6twGSdj13knETY4I563sBppd/SkjlwCoEt2qooxRgRfqJacEQOqpuDSBeKJx/DBR/4rF+NfwW3/HK+Yvx3FVFSmXghWHPidwAA5dCevv/PpdmPAUzOou4Pp96rX6XCg5/Z9+1qzlha9TJmG2/nVi/rYI++PNn2PFlosuiKOOmNykA/k1GdCiD
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 05:26:13.4658
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 055ff733-061e-43dc-87f6-08de831c8a46
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017097.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PPF7B4E3DFF8

From: Peter Zijlstra <peterz@infradead.org>

Add a dummy runtime_const_mask_32() for all the architectures that do
not support runtime-const.

Link: https://patch.msgid.link/20260227161841.GH606826@noisy.programming.kicks-ass.net
Not-yet-signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
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
2.43.0

