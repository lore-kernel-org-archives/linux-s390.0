Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010043.outbound.protection.outlook.com [52.101.85.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA7C3CF69D;
	Mon, 16 Mar 2026 17:11:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.43
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773681092; cv=fail; b=C0ivwuw5n6BmopkHpnNnMBLLjim6IFYcgaFot9g/RYEw0K/U+GLTx/2kPrUm/83XrIp5jskLZdbtKkAc4g8u+iYuJ7XtauQc39p0qAJ22iBbrn8YyT6p+uh49G6FEPcTNZKw7JJnBYLQ0yuVlGQ3bJhvfadBNkc8nZ0fJlVO690=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773681092; c=relaxed/simple;
	bh=9ZdNYM9vUnFRmiTQPyQk2Ir4gJ/cVVvD6suyBHtn/do=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=pllcwjEdP8Hpe5QSkrAHh/+NufLEte01wh1gTi9jKfJSrXhAK+2vqRdQncRMLG9bhF0GYBjKA69typvfNXKCN8MOiQtmApsTAxDC/6GVccRplV8S81eD3h+LVyzlIQwCFPRyyBhbOkkRlmM4rHnnCBrhGbGP/Jl3wAVdoZzpGkg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Yo9wlirc; arc=fail smtp.client-ip=52.101.85.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Yo9wlirc"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=NeT7EwgjRJViFM5cwsMSo0WVV0Z5f9IN4a7j5c78u6spExqaRFVIB3MDxIGWIdn3vBGIvTaTR+eJlJouBmVyWww5sL1885FM/WVlDJk/qrX6SPzJMQwC3vxP09CVCjx6v/IrpXcKFIBiX7RxdH0rhxYwTjy/xXzEyxdjQIKxCHOfdiThu3H3gHWMlGmzMkzpQGV7/pBEAJs2sdqwSuHRUxngjg5gEyaIo0hUoJATKWMHpD3lrZbrVt9nJBdB7id1/IjhYq4+b4MLWad5TSWS6vUg5CDklt+2u30KnqkNt0+JUngAsN0N+jC2eWqX42hSYyZQSqdsnl6s2HseuGS5Gw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=97SEDHm0tXSSa7Nsjc+szSoNFuHXH6zdsdvOoT7fITU=;
 b=GMEGIXNASnzWv7Ahkno0t1sI4bIiIwFiuTSKiVGUwRtTPTDz44Vh1xwNB0HhXQggVLZXOLAI/hnUrTifI0RQspm1sXcZrSyMYHjgawhg996F88fyfXLhF2Ctw1wKrz7uvQDXht4XzhEo8YyFk0nI5x24UeyDXqqx/2ZN6uccszGJ6Uw0kVWn9MTAnvu56rvot4GAsnHcCrdkCdHlIPlssDQnGZeVIpWy4Dq5OqC00iUUhAFN8jLATLi18QMlkSnaZYpDMRD47xLtQVLJBK9kJz7JrrG3czQmqkruGMF6LMTaCQhsDDTYm7IOfCcnyLBIEAibTTbUqD9Dk78Cm8bcow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=gmail.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=97SEDHm0tXSSa7Nsjc+szSoNFuHXH6zdsdvOoT7fITU=;
 b=Yo9wlirc+pj0bvSej7pRcu4cZa5csT9ogK0r2J40IUL5dPKs6/CTn/ViszF8lHPamuK3/t6/LS0Cs7FZqlBErcVRCQEuiMPqMKQMGFpdi7+pGNllt+ha3h+eBmpEX1I49d5B53A5CHaWNAn/fTOoBv7G4OymXNjlEDtCk52bFsU=
Received: from MN2PR15CA0050.namprd15.prod.outlook.com (2603:10b6:208:237::19)
 by DS5PPF6BCF148B6.namprd12.prod.outlook.com (2603:10b6:f:fc00::652) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.7; Mon, 16 Mar
 2026 17:11:27 +0000
Received: from BN3PEPF0000B371.namprd21.prod.outlook.com
 (2603:10b6:208:237:cafe::58) by MN2PR15CA0050.outlook.office365.com
 (2603:10b6:208:237::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.25 via Frontend Transport; Mon,
 16 Mar 2026 17:11:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 BN3PEPF0000B371.mail.protection.outlook.com (10.167.243.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9745.0 via Frontend Transport; Mon, 16 Mar 2026 17:11:27 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 12:11:21 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 16 Mar
 2026 10:09:39 -0700
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 12:09:34 -0500
Message-ID: <c7066e5f-ebb0-48a7-bc36-3d849cfc8234@amd.com>
Date: Mon, 16 Mar 2026 22:39:33 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 2/7] arm64/runtime-const: Introduce
 runtime_const_mask_32()
To: David Laight <david.laight.linux@gmail.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Darren Hart <dvhart@infradead.org>, Davidlohr
 Bueso <dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?=
	<andrealmeid@igalia.com>, <linux-arch@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-riscv@lists.infradead.org>, <linux-s390@vger.kernel.org>, Jisheng
 Zhang <jszhang@kernel.org>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-3-kprateek.nayak@amd.com>
 <20260316115030.6988ad62@pumpkin>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260316115030.6988ad62@pumpkin>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B371:EE_|DS5PPF6BCF148B6:EE_
X-MS-Office365-Filtering-Correlation-Id: 992b7fe5-1303-49c7-4165-08de837f0f79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|7416014|376014|36860700016|18002099003|56012099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	OEcg2BZB8WWCxUOAQHWn9+bRpYcx9SE47HpYLfGGp2lHARvWRlFHo8N9jS4Qk7VpTPE+yLC7Br4iNBfhtsWsBEIdXVM/KcswdXFWcSMQ5Ga02Py/Yd/hTIItpoUjj+V4G23IZiuc1pHHNjzv499J3XaNWoa1WZmb9sNQJoLgK96QpxSbWrkvcUEt+aC3AlVSvnppG6iGDebTk5HYAko9let7Xy4VMXuO3+NsaHnBi4Ivkr6q9IRnA6SrAP6PijsWq7f9rKbw+jCG7Qbxu8da69r90/CksLHHT5a9h1cNnPMvYW9uP8TsW8Xe2dcnZaBoGeXijRUBuC/Tznpg8PB/JwKI4e7hnu7/XFYu3KOOTP+kWJXsJ5HnSmnUQcOitCXr+3SWh9muTI+Fj2p3BGUeXIF1L61ak3GgrJUNejWB0r6ybX06m76psrqKfbE7EHgCecn6FjNDF6NDtVBW6b8RWpyxD7piFf9O6D3dVTXIlDklrbSN7nVr+szf1G3COCRDDnUIo/Z12tHuX6CJBNw2EWa2I5idxrrx7MMEG6xc/xmaTXH0F7HxZlOQfs3iBhN4ulFM9uvz/iumeRzReKOI2xSsfHdZTBZBPs/snvej2z6aiEicrAb5S15XbwGcQd5K7TmVc8j7Kb0A7oLNK3pecJ/p+UU5IzxCC6EgC3cUrdShKjA76hrZtb4V1wRY2iYNe/5zUBGlhHFmzE2n4SczjXHC65E7Tr2LL8FBArrQmSYuTPYix00XUlOFlaqauArPAkoht2p0GYBYrTA1ouQaUQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(7416014)(376014)(36860700016)(18002099003)(56012099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Pa0TL+Gwecbi6n4l/inszoPebhxj8tD9p1z+GT/p7K4TS0o+BVE3poEDss/XdKWrjUeRcvmTmpye6bmJopajNVxqVvTYFhsYkUQUky4U+BH9wtduh1mB1uMMgmoFP+ATxTLSfobRBsHHFZeXx91ydgHytJpiwt4/hdStnXPpOQOO0VsqyqVYM2HQzuXSFkFl7/NRTNRwxCNovTCyrGESwkKAUmDtMF59teLr9hZUOq9uwYNdlk04I473RcXr/gyDiBnWUNCmW+e5j4vobNW2SbCRVENjOwl/F5Xef5nGB4y5k3XraBeBM1acjhWPv2f1QPX3/8S4ewoYAwZ+1vo1NSzSad909fg6SqG0LviuCwrLR1jdY1tNFQnzU9xMhFE7G+XANwOtWVYzkYKXW5nUItlk3AChHKW0wEvweAV8KPxtH2ZktBLOjrCf2Id8iMkb
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Mar 2026 17:11:27.6423
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 992b7fe5-1303-49c7-4165-08de837f0f79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B371.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS5PPF6BCF148B6

Hello David,

On 3/16/2026 5:20 PM, David Laight wrote:
>> Introduce runtime_const_mask_32 to further optimize the mask operation
>> in the futex hash computation hot path. GCC generates a:
>>
>>   movz  w1, #lo16, lsl #0     // w1 = bits [15:0]
>>   movk  w1, #hi16, lsl #16    // w1 = full 32-bit value
>>   and   w0, w0, w1          // w0 = w0 & w1
> 
> I don't thing the '&' needs to be part of the asm block.
> Just generate the 32bit constant and do the mask in C.
> That will let the compiler schedule the instructions.
> It also make the code patching more generally useful.

Ack! That makes sense. I'll update it in the next version.
Thank you for taking a look at the series.

-- 
Thanks and Regards,
Prateek

