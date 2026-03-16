Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013001.outbound.protection.outlook.com [40.107.201.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC99C1F8AC5;
	Mon, 16 Mar 2026 17:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681256; cv=fail; b=Wi3ed9BTH0mJkssh6OkA8S0vEWx4V1f7zwcHIi6Auwb2QR7g7ygNMIB4dzjyLQWh3V3TR+Fxh+DY/80zBeYrGwV0yhLi2VDjdfKwCNLEViJKJHFiPLT33AmIy///DByBgYZvFA43bfPaAvfDqgBgE1wUDs3Jz+8hioQ71NPvgKs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681256; c=relaxed/simple;
	bh=6M1t3UkkCNxTdBueb0HeXPsZKnjqKdsgwyWwlj6JVJs=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ro3yopPg0ZNSnQlYhAmKexpuzrhFZED7W06YB50ivyBi/nG7O12j+4W8YkZ4oG+ygCCiBBH7t4/W8+ow0SJreHJoI7Lr2HTdSy7BCtj1K0EZLbYwNewuwJ3yIluz/xnueDVs/hC83yJZigpVJesbec8V8E4RD+IMXRWuwHV8+Gk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=dy56puwc; arc=fail smtp.client-ip=40.107.201.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="dy56puwc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QDVSU3U4QO6GCyHfoMMyKWD/ERJ8mxM+j9zvXJUqr4axNhHXWsSIsx2lLSn7P+3lp/e5u7i0vxK2NgTUdSYQhyrIS4ZIeG5ciy7epvQ/uN1sArPVyIjY+pFBpugbLaMnlEZqUN/HTLi1khmpP/R6KzOg20XgyCetnYKhi2o52xUNCjkQby4KCpJGRPlZ1Z66RwSM5QKyBEDVPDd0a7kErCtdTPz2EgLCfaOhArnckTNn3s68JBHvAfu4yAg8ON4jE9YHY7WByvnJ4CQYI6FMCb/DSB10iSi6yyjdn1eCVLiKT/O7Vu31bUrnkYHo5r1r/WnM9PEbE46ov2iGGIXvLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7PDAmbvn3R6Hg5qlmBRj9+sb+ZgzmdTr8/Wbld8K1wc=;
 b=J034CaQFcfB+CYCjW7EnvHsV1I7vmfkemUrUs8X2qV5CVCbJpKTeK2v9aDmk7gvu9CV8uXuhzthQPy2andvY2sIswYOuglvlv6F+vVGLk23XRvBE9Ko5nh5cj2JZ8YXdN3rtbUZEXf0uk9Rm8DZRk+lZ1xQDsuKMyFSB0DECPJCGtopn/haHhRE4t1lAXTxJKfQ3xTdBJVC30O2zxLbNUHfdi4ov0D70EBAWuZDqR4WnQOaOEese2X7erivw9BNyEU1gqwBnN6g9teGbeFTxyM4fIUVwSQBRqeuIY2UVwn0lK0BvgGaHzJeM6kuax0i76dutma9/zECZS0cs7H0i/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7PDAmbvn3R6Hg5qlmBRj9+sb+ZgzmdTr8/Wbld8K1wc=;
 b=dy56puwchCp6S0fw1Vl8Rg+pyWz2jwvBSTK0Swjd1iOs6LIPZzVA9I75GifDWuRShyHhscXKVmXuKi0XUX3x0xpzljkmac3dAkwqkKHk56L0AvbHY3s0BNvwr4P4Fk83R2SdyemDBwO4gsXPOcsXp/WI052e1DoWzgrzfco7epw=
Received: from SA0PR12CA0022.namprd12.prod.outlook.com (2603:10b6:806:6f::27)
 by CY5PR12MB6179.namprd12.prod.outlook.com (2603:10b6:930:24::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Mon, 16 Mar
 2026 17:14:11 +0000
Received: from SA2PEPF00003AE6.namprd02.prod.outlook.com
 (2603:10b6:806:6f:cafe::a5) by SA0PR12CA0022.outlook.office365.com
 (2603:10b6:806:6f::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:14:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SA2PEPF00003AE6.mail.protection.outlook.com (10.167.248.6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Mon, 16 Mar 2026 17:14:10 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:14:10 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 12:14:01 -0500
Message-ID: <5fed07a3-71dd-4966-8927-e2c49d53740f@amd.com>
Date: Mon, 16 Mar 2026 22:43:59 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 3/7] arm64/runtime-const: Use
 aarch64_insn_patch_text_nosync() for patching
To: David Laight <david.laight.linux@gmail.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Peter
 Zijlstra <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Will
 Deacon <will@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Jisheng Zhang <jszhang@kernel.org>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-4-kprateek.nayak@amd.com>
 <20260316115224.036e0351@pumpkin>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260316115224.036e0351@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00003AE6:EE_|CY5PR12MB6179:EE_
X-MS-Office365-Filtering-Correlation-Id: d2a2d69d-0e81-40c9-f5fb-08de837f70c3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|7416014|376014|36860700016|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	CmKGdzZ1vTcWBcSFGTHEJ5WiruhtxytnCamwimMEf0qyjb/wZvcVS9WYZtnrncDPt3j18ia409+KWLRPNU7mydX91VEH596PKIXvNcHWy5juSFuF8kgpiQTPWAJXVKwmpO+0e4qzZeIc1B3WjAWv55OGi3ELO9kiKGlA3G7ctW4fcwx9a1hhKPd+mABh+kLNHuPpKdkaDyKlSIxqVlLZRhqHPhWh5UW8sVDiby2omiycQN9dGpS8GPhmcq+UHzVhMNWX0FGNyw0hAJI3IOtyr2NzI308X/JVADL47ess8qaXWqp9cNBm+cGgxFdZtp9BHReVVHl0yZeDrVb/kSb+de598DblE4HN0W1tDWbQ5e9u9v8KfSzuEBlbFBe1e2/2AENvdpQUg9NJohUs1J5TOj7qkULbRErIC3fxPVHKCUdYOofVFYkwSfU/u6HQcDh5fN5RRXoqZfB8gGUDZutBNgv2J0Lki2ASM2knmVBGQJUyus/ODsmcVe5MKWow9O08ljo1vTriEhJNk65ZM4ILJZfeSMm0rHGLPrkIDF8nXHCCpNb2inJGVAiAq2HmLsi7VTFEBpAnS7dG+w6yhugLvOwcB/1mDgdIqvFR88rLQdniubRhmgssAXb+ugUd9NXsvyUXnjnNCZvelVAgay7cEYXISaXDi/L8+Qyer5Q871yU5bVYsodWBaRzn9zIW2JKOJCBTo9mRp9WY7jMzGSP7Sux9lGG6trc6Bx0bn8rQRP9PoaMRR3K7gO4P+j9rQBiXIhK9A1moN8X/jVX2vA7JQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(7416014)(376014)(36860700016)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xaWS6fQEF+jpiUZw/EoN9IjNS3GZq8Owawa9QaOL6NkrimYtjFzQJgqWJi9YiR02d4iA96L+eQf/50hpB68+nz0y3tvboaWdnt2Z2ILrImzjxZmsoBeKuqeayhYrtvdnQNComwdkLkrYz8FQxsmmfVfw1PEjgaRJvltyWvSDF6f3xKDsl+lmvJXmqKxwFQUzqzhzGqUQ2ZwIm3bQjuIwx2uQqkwVafuxFEGXP2MfvByKZTa6SDjhBnwiV8Uw4g08zFy+LcVnHCZ0fU3mqaEpslx0QnMMkaDp9LqIHhk5Q7fLH6m2t2YXrxnSoVcty/mnqep55HIiWsCmEKlSExyVMnBsePXHu+7tLcZymYxSWcyBTbGDQMhDroH8mEoqz3PAtQDIoCV+SXSdvx68MDYvGAzd1z2g9HjCUhHsmQ6xcMwtAPj0kdGpNIkzxWNruX3p
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:14:10.8515
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d2a2d69d-0e81-40c9-f5fb-08de837f70c3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00003AE6.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6179

Hello David,

On 3/16/2026 5:22 PM, David Laight wrote:
>> The current scheme to directly patch the kernel text for runtime
>> constants runs into the following issue with futex adapted to using
>> runtime constants on arm64:
> 
> Doesn't this need to come before the previous patch?

My rationale was that this didn't make a difference until
the final futex changes so I didn't pay much attention to
how they were ordered.

I will rearrange these the other way around in the next
version to keep this independent of introduction of
runtime_const_mask_32().

Thank you again for taking a look at the series.

-- 
Thanks and Regards,
Prateek

