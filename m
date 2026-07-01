Received: from CH5PR02CU005.outbound.protection.outlook.com (mail-northcentralusazon11012068.outbound.protection.outlook.com [40.107.200.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54ED33F44CA;
	Wed,  1 Jul 2026 09:08:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.200.68
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782896891; cv=fail; b=OjLlvdKoJnQ5zbDDJ/mOgbDR/A9TXgJVm73pX226Q5qOz3cEn3Fnja6ORjpav30/4ak01q044WFmkeETIe+Td658y1F2hn8c94zMXM6Y5cyftGh5npvW4tQwe6cjYLS5YxygM/Qz7BkPn9WU8gYxQHVyzNCQBJqoQPJzOt1LZaE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782896891; c=relaxed/simple;
	bh=h3kzZXCq+dGtfSOY396j50UNM4/IYMbSVl9QM4k35Vg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LSJDc/4G9HoiyoVi6PwRyQ8gluSTcEJhVilUc/6H7lOyRPxOFHET0nO2E16cGBStym+aOWep53HNIqLnV0iGKQ+JlxfHiOHL3tgY+a3vwX+UjzNxYoC7VcoQo4obDE/K+LWJ8oVnoZWbbvfEf80KRt52l0JdB+GPjkxXw3KI3z0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=E+Bn6CML; arc=fail smtp.client-ip=40.107.200.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="E+Bn6CML"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=RBcRXoYU6Q2cs2rwItSzd3Ze3fko0RLEP3AOeVw3WYTj5udw4vYTP33QTVbGnwchDcRfSZKC40vXymyvbHBPES13M7Vr+KNxAgCjP6hHmpqLhpdS8dL0YHJeFX6lxCQEIrq5YAkgA/tUH2q+YrD432nnIK96/kaK9vOSiJHyVhHECX5TOvCTv9pZdxbE8EBjJ7Hbz7w7QwYAPRggWxKKamaLyIByxN03yVGZBebn0AY2NNjUVEnPjsepH4d9kXWilP0Dzbvde95ouyEHpStA3+3qjW+uMOYGWXJ1M5mdY8mAvdqS/xcsDRQ1wAyjwRW70Yx1fVwcHAGGz0MPMnvf/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g1/TDN4Zyz4o7+1roVy2O8d48myj4Wdvt3h8XPdnhnw=;
 b=kaDRLGg/j7f7hjmSV3G77HvoDn6KyfqbAN7O3AowOCWLySAYuVDD2madtK3X0BvDgdZ6BkI3VzqugDnnmAgGGkpfR+j7Tkwu++ibhyJ0Pos+hkcwz+oSIufXJnu8hNveXQt7qYfcSSgpw7ZLIDHpvY3HbzqwewmigXPFErXK7n4HlzTJEs8BgDQBSyEH5Ur5G8kL/47fA+CifKRrVEn/Pz4aNGzD4J45JOR47qY1bLP6gebR9B2jKOaZv9ab1QU8IMkg1SIYf3Mlx4bRJdnCTVgSkExMjqqy7p5a+IS8iBgGyiB93zR0aO+tAIVCvdj4uD8U10nfgAwMSPoyfEbVnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linutronix.de smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g1/TDN4Zyz4o7+1roVy2O8d48myj4Wdvt3h8XPdnhnw=;
 b=E+Bn6CMLLuOpHnAyC2nbyEZzooY0NISJihogc2hlgH15KjiFdC1WFnSS0r4FCvToAKLIrXHCvKXHosOiwNuV9GHnQ6eq8ke1NgyPjBEGuyA18mEhF33tTQ70fTugnY2T2sFg2GK4hTwor0d5cIU8nYC2PUNNwTF6f3L69oJI/e4=
Received: from BY3PR05CA0057.namprd05.prod.outlook.com (2603:10b6:a03:39b::32)
 by CY5PR12MB6431.namprd12.prod.outlook.com (2603:10b6:930:39::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 1 Jul 2026
 09:08:02 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:39b:cafe::14) by BY3PR05CA0057.outlook.office365.com
 (2603:10b6:a03:39b::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Wed, 1
 Jul 2026 09:08:01 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 1 Jul 2026 09:08:01 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 1 Jul
 2026 04:07:58 -0500
Received: from [10.136.39.208] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 1 Jul 2026 04:07:50 -0500
Message-ID: <38239f40-1673-469f-baa3-4a343d2aa4c3@amd.com>
Date: Wed, 1 Jul 2026 14:37:49 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 8/8] futex: Use runtime constants for __futex_hash()
 hot path
To: Sebastian Andrzej Siewior <bigeasy@linutronix.de>, Peter Zijlstra
	<peterz@infradead.org>
CC: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Paul Walmsley
	<pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
	<aou@eecs.berkeley.edu>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Darren Hart
	<dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Samuel Holland
	<samuel.holland@sifive.com>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Huth
	<thuth@redhat.com>, Sean Christopherson <seanjc@google.com>, Jisheng Zhang
	<jszhang@kernel.org>, Alexandre Ghiti <alex@ghiti.fr>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20260630045531.3939-1-kprateek.nayak@amd.com>
 <20260630045531.3939-9-kprateek.nayak@amd.com>
 <20260701075714.GP48970@noisy.programming.kicks-ass.net>
 <20260701084150.GNOeboLw@linutronix.de>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260701084150.GNOeboLw@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|CY5PR12MB6431:EE_
X-MS-Office365-Filtering-Correlation-Id: 1bfc53b6-a014-4a70-2098-08ded75040c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|22082099003|18002099003|4143699003|5023799004|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	kJxdKYokYZS3EIDHBQtFESDnvoU+k1pJzGafuFnINUKWX5rZ3QUmqN+0EtIrimyDV8yHvQdYXKbzXv4/+AoDQECO5GTsio5NHiJRLL+YzDAr+YnLVCyHDh+z8xbbmdBPboj2PXBRc41ZSUT6WJeDLFwN5av8C9Ff2jcRkpYknNXy0nlJ+6/h9vbWF9U+lnn2PM7RFO8MjsUMmoUlhdV7ms/n0TYrOWtj9BqpdhlvdKS/okwxsE8SQoJDiCZYNRJPxOeGvKH50JBnh04DDUIPcJIbbGQ01nyYFbOCej54CmGuTdmie6JMXYFlYfygioAn71GJrpb45i35WqBjq6vdBQ0Se/5aNeZ29JI+L4t9bYVwVgjAcvg3RV/m0Su2t4GzjQr77yslTGMsIq2N0iJX8zahtN3VIoqjHQ0NLJRSceswPhKJULFfhELsWtPN2Qr9NoLfpoAh09TZNw6qTQQbdRq6Un+RShlQyR33PMWaf8WrjF0DBCNYAs6gJR0Q0tT7M0ZzfckeC1/8UNfxxXrgwnJvTG/oSXtZ45o7BnQ1eflUk8CIcL7tzsgAE+91lz1Hv9POdP1O1pVhXLRxwDZ5KRWO2xgO/2fcNGvGipkwgp6/LL4kCbCo6MaY7eaKU5gqgJRS5wGp+SthGXFy26o9/+NofegVYFQv3dhHTxYHsa0o+d4B5Dvwtze9PNmjFU1BOoKssPjuihld0SXaHhmkFg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(4143699003)(5023799004)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	HVjZr8VEub2Nq1ykpJ5IEyRcCFymMpo7JAcX7xWamGawFw1Y7sXIlMFEhHIPEqQdrdUbNUDPpoLH4gelRsbyxjhtuhnrU7ilBgMWftiUgVO36srcn/Y9FXnDemLVeyKMPuHajCGX1IG++a2XUTBZCINASagcKeADV2O4/igG2ZVjGLqeGqgyl18HFRATzRYzF+7mQ1TAdNulhVDQ79FnVchKLo82LLd5walCTaYfFug41R/CdZQaFlTsd0pX6lpXxDshdxcbpZv2BXj7HwDo3KkUKqP32j97LSOM9Oa0Xsy1lbq2NsBq5tTLtMb/pkfo/ocalG7x/sdNwnHbtkrwR2tjLMHMSDfpoLH4BIWZc7xsk57OPnG7rqGR99NVl/TxLmm3DWSr421aeF3C91JqECwML8HuNt06Vntw1xLcFjqnRJjy5fIm8jNMO226psgJ
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Jul 2026 09:08:01.6128
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1bfc53b6-a014-4a70-2098-08ded75040c4
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6431

Hello Peter, Sebastian,

On 7/1/2026 2:11 PM, Sebastian Andrzej Siewior wrote:
> On 2026-07-01 09:57:14 [+0200], Peter Zijlstra wrote:
>> The big $1M question: does it actually make it go faster? The whole
>> point here was performance, right? But I'm not seeing numbers showing
>> how awesome these patches are.
> 
> I did complain about the about the size of __futex_data which is blown
> on distro kernels due to CONFIG_NODES_SHIFT=10 on Debian for instance.
> This makes it go away at no extra price but yeah let me boot a big box
> and see.
> If the performance remains unchanged it is still worth considering due
> to size savings on the average box with 1 node. The biggest box I have
> access to has four nodes. If I remember correctly, Prateek was saying
> that AMD has "normal" boxes which would require =9 for normal operation
> and they do run distro kernels so lowering that value is not an option.

Rationale there was with CCX as NUMA, we have 32 NUMA nodes on chip and
with CXL, there is a possibility of 2x that so I suggested NODE_SHIFT
of 7 or 8 should probably cover almost all real hardware without any
added NUMA emulation weirdness.

To answer the million dollar question, I see the following on running
perf bench futex on a 3rd Gen EPYC (2 x 64C/128T)

  +----------------+-----------+-----------+-----------+--------------+
  | Benchmark      | Kernel 1  | Kernel 2  |   Unit    | % Improvement|
  |                |  (avg/5)  |  (avg/5)  |           | (K2 vs K1)   |
  +----------------+-----------+-----------+-----------+--------------+
  | Wake-parallel  |  0.01614  |  0.00456  |    ms     |   +71.75%    |
  | Requeue        |  0.26394  |  0.24644  |    ms     |    +6.63%    |
  | Lock-pi        |     34.0  |     57.2  |  ops/sec  |   +68.24%    |
  +----------------+-----------+-----------+-----------+--------------+

Kernel1 is tip at base commit and Kernel 2 is tip + this series.
perf bench futex hash some insane bimodal behavior on my system with
both tip and tip + series so I've left that variant out for now.

This is only from 5 runs from a single boot. I'll try to grab a
bigger system and check is it makes a difference there.

-- 
Thanks and Regards,
Prateek

