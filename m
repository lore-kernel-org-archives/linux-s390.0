Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010071.outbound.protection.outlook.com [52.101.56.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C4833242CF;
	Mon, 16 Mar 2026 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.71
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681374; cv=fail; b=o8x8lH5QKki+XZixLkXkdulAI68+pmT2Tr6ZW7LisYZwqj9w/z+VFtbE9yCiXWTd3ez3HArDBtkM6dg5kDRwJW1oxpT4cD9D3UI9WrllPLtLPGSLRgQRD/ouUtzsLudH/hcMH5pnGMZJ3lZ7hUrzwWiJ/pXB8FL7oo9IsLn3H/4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681374; c=relaxed/simple;
	bh=sjM6wTGrVlx0bakTLeUy7+MQ2PB5M/tegTjwy642imc=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E0cEDZ/JLmIEe0uzO43BsQgwFOGlW221u1ku7t9aGryCyDK+Thim87fcmE1hms2jT9Um1zDwRXmm/0l7j/CvkNC90XHu30zpfg6kcar/nwgAAldSlhZuZ+/8MN2OObS5+myTmdDygksSPPUEQJ6H7Z3bEd3AJpdCTpOEU+GYblM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=tpDhTZjp; arc=fail smtp.client-ip=52.101.56.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="tpDhTZjp"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=VPeQjtS9l+RfeZB6KXK+8dXJ2PosPSe17xClxjhabHk2Q8VUBWhNBP05vrpcx2d+y4Hyt80XEiQZHgVIa7afjK3IUbsjTx/uXBv5Kb0JE1KfhFll96e6Cm6KFC9Q/swJpImfCGj8vLaT0fY0YbzIOuvVFgZGKuj4eHaoCdfxYx88mfO1HdIdvrbpRsK316bYzUuKj0fYAm49YGyHHmj5ZLWp/ZujdX3q3Twy/Vr0zoIM8508XNKQEb+b5F9Lz4JiJkTBLnnuVJOVNXIMQa4KGLWzPMXx95Zce4pM98yEwilkVHrzjWG1ZET+C/do805aNBHDYJ/IVjnQa1YucVvK9w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PSg+Oo9bKmxjcK/RACzBZ6TJ0H0VpiWej7UYa/J7534=;
 b=V9th9+gZLay+oPs6HTFohJvsxTYtDCj12Bjs55CD9ND7xZWz5YVY2ANZJ8Rrlfsh5zqYyHkd10AlipR6BFGsyiqzn8jciDYLABQXYpdt2dOfZa7cJUfx4WS+0OHBeIMAmIwySn34N8HB5W2JgSXUS6tIS6tDc2P9HVylHvxtUGnaHjokv+aElBOHSwRfUsVKpmQ77kZIOyCisAevQn4gQ02Z5KOiE3C4a+8ypud+QcTUsC/fzQUnueL6IWJ/XUCyoZczw/q8mxogJM87dpEP+4i10TvUgFXiDeaRq5uZ1mEcuHZKcKEjkf8gGt/l+0iX2b3VHxfPgEmV1SZXTNMJdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PSg+Oo9bKmxjcK/RACzBZ6TJ0H0VpiWej7UYa/J7534=;
 b=tpDhTZjpta9VAXocFnlQ7AFp4qrS9Y9Pw4vD8WwwvApeESE99rI7bugeIQxoj1clBoC1JrBPZ/CPPH0jNDBStKsgm/4Ls/zwX36PMDHaxB9kmpB4FxZ+1K+QCC8vNEygKJM6XNvD4p5Ptd4XvgQA2prUoCycvBPg69zK2wEQPdM=
Received: from SA0PR11CA0102.namprd11.prod.outlook.com (2603:10b6:806:d1::17)
 by SJ2PR12MB9162.namprd12.prod.outlook.com (2603:10b6:a03:555::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:16:08 +0000
Received: from SA2PEPF00003AEB.namprd02.prod.outlook.com
 (2603:10b6:806:d1:cafe::33) by SA0PR11CA0102.outlook.office365.com
 (2603:10b6:806:d1::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.24 via Frontend Transport; Mon,
 16 Mar 2026 17:16:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AEB.mail.protection.outlook.com (10.167.248.11) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:16:08 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:16:06 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:16:06 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 12:15:56 -0500
Message-ID: <9e84f85b-a86e-4a93-81bf-5c0951b8d81c@amd.com>
Date: Mon, 16 Mar 2026 22:45:50 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 7/7] futex: Use runtime constants for
 __futex_hash() hot path
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Paul Walmsley <pjw@kernel.org>, "Palmer
 Dabbelt" <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, "Borislav
 Petkov" <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "Arnd
 Bergmann" <arnd@arndb.de>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
	<andrealmeid@igalia.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>, Alexandre
 Ghiti <alex@ghiti.fr>, "H. Peter Anvin" <hpa@zytor.com>, Kiryl Shutsemau
	<kas@kernel.org>, Sean Christopherson <seanjc@google.com>, Charlie Jenkins
	<charlie@rivosinc.com>, Charles Mirabile <cmirabil@redhat.com>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	Thomas Huth <thuth@redhat.com>, "Jisheng Zhang" <jszhang@kernel.org>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-8-kprateek.nayak@amd.com>
 <20260316081429.FJx4fnNl@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260316081429.FJx4fnNl@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AEB:EE_|SJ2PR12MB9162:EE_
X-MS-Office365-Filtering-Correlation-Id: 521baaca-6f8c-417a-2289-08de837fb6e1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|1800799024|376014|36860700016|82310400026|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	Bj2UrZRAJjyE1feOpD1Pu5fBIcZBHYnUz3rO6HxdqIexW6Q0nd10LTk0J+bobi6e/IBwe0p45LcEF5dS6WLJovQYRUqlZkzv/27GK7GCEiY1Ba5O5uTFA7Q/9P4yyqzzv1i2Dp5Fwo+G4dIXpklc2i792PlsZGhAQlFXaPSNEzWK58qjfb0aQCkBg6KovNqv7VJRBMxLmuHbo4bqpIvJ0kFPLTd11j2NqvF8vsWDb0mnIFmSXGHGZ1WVnDySRv7WIaxX9bhHpEFubkiQDxctRQx5pZe37ui8gdSYYo1CR99N7pAVKxIxV8I47xpFTLlVd1VGvx++yD1BGxsDgpks2/IgcIhc7v6PI5Q+einEMmZicMEelncx08K7QDcMVJ71qK8qpp0tckEzacIYyEiErzIZdZ+IWjPfWbUEfx7vvxsstrxJV0qUE/itZQKY+7rvevFrEkBKJ3IuRILjRRA+UtFoj+O6RlSWt5yZOktq/So82VXYT12tWAqotmxH5uXaWbD9LT1mW5uenkoaYkuP0jF9nppYrasPQ2kVttXCngmMBkmBIbFOUoOS/rl1MjcyXPsjs4/J5iut1f9HQ04YLzID7X2CvObbex+JLnR55rgiSeJIL+fGkN6u2lEnF/oqyB5zmDyUDrOL1UdBX6NMZ+AXIFmEZ7kF+orK7kR8fNTxHTkQ3Xl+G0C+ZiMtefSiN+Lo3flcqW9xosOS+rhSMZ/pBG+/aWSc84TrUoL949qN9d78vjiXOqeTFptVkNSJD1HjJfHlhqf6bsyP+qFnDA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(1800799024)(376014)(36860700016)(82310400026)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	SbBX0fdv3hUdFhnyMqYxjYU3KnTxPWvwU/2crPFOICS2fYEJjH5G8HYA9fa350Ak1e+7+PUFYFofovlfFURH4Rcwdn/0yGkXuWnxrzKk+NxtrlOXHKCerLi8lew9/Tt6kpt2m/sJ5xcTbo722zXR2T3bA6qhG4VCknl7CSaPHVxjhLEEPTutM4a2tdB6Z3tbh0tVVSss0Gboe7S7HXbv77pqyTsk/rWOlxOfv7YWccRlFkuNVYL5XTnYtyA94Ulo0pvIdXDRyHlk+3WGelS2syNeywvHUjqlg1bQXN2nI33zqKt7zhxapQ/HXxMpDP1SHgMPAgPWFP4nlO09G4uYfk4F9D5vdh/IAfmsLQ3sUgeZiWtL8AZeK91H3yGiYXvZls/bDR32aAcu6IDpRsEOE2/IOXXFprAr5OjB8OeOYmi8FqcOTSGb+MBSafp5OJ8v
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:16:08.4867
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 521baaca-6f8c-417a-2289-08de837fb6e1
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AEB.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9162

Hello Sebastian,

On 3/16/2026 1:44 PM, Sebastian Andrzej Siewior wrote:
> This all looks nice. Let me look later at the resulting code. Thank you
> so far ;)

Let me know if you find anything nasty and we can see how to best
address those bits in the next version :-)

Thank you for taking a look at the series.

-- 
Thanks and Regards,
Prateek

