Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010038.outbound.protection.outlook.com [52.101.84.38])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C1AB425CF7;
	Mon, 20 Jul 2026 13:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.38
ARC-Seal:i=3; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784555445; cv=fail; b=YDlT2rVZWMnbGZ+UIuadgpHd9opl2KbeY2QaPVhqg6rdjnYyVLS8APnrCQ8p3WaYzTCHF4UB0TTdKFEauzdNmqCrmgGiqeDKyoVU9KVD7vZYV8lvXmTQT+TXnspN3BlRRvKTnJmlT2imHz2hWa3Kv/T2k2ncHlDpduRN4vsu8II=
ARC-Message-Signature:i=3; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784555445; c=relaxed/simple;
	bh=gcwPAXNAyTwKOt26luml2okpRnO20HBKQmtIHQFqMO4=;
	h=Message-ID:Date:Cc:Subject:To:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=hrEam98SKMprqSID6T/bMMUWzjsb53k2zh9gaRc+vKu6WKpYsD131FSmNvyVjh4Uizq6c/G2IdIHPAmauxiOtWpFc5x0NgzMenl1NUmivD0XgLLZK58OUEj+vY8TL2c+bpmWVU45MqRyxvXiJBEHSUampe1ubN2rGbVUhJhtKxQ=
ARC-Authentication-Results:i=3; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ApfJrpyt; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=ApfJrpyt; arc=fail smtp.client-ip=52.101.84.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ApfJrpyt";
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="ApfJrpyt"
ARC-Seal: i=2; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=pass;
 b=u7yfmCkKgMIKPFurmsTvtJjYWat6k/DiKtNC18XhHXbO4F/NCKdxP5m/d947FLzcS6JHmq5jm5+CIME5qZBXRHuOfxw+Wg+51YVgUzf1VmWTfeVJsJWiccWSpkcbfViXv7+PbO4UcjhRMHRlmB9GBLFoyj+3lgnJKBU/1pDEs3T8e+VTlV4E6/5FCYSTWJjs3e47tZdNSUuC7BOfUJ8I7d9SGe8aJJTEW2UsNk4jRCqn6E4EjMNfkBCfaa+eBhxSqireenUZ9MXtx8HfClHOmoR8/fmQphimm6udLcRT6zzVfq730o8/RyEV9rpF8JRwN7JJRrso+1mME8g0RAKbgw==
ARC-Message-Signature: i=2; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5Vj+4K1C7Z2h2OUZT1qL6wS65aMAXd5DMGiSI0bhtQ=;
 b=tFm0Kvci0DnNSw7/OwQgAEI7nVXGzZVdYx3Cvh8KoG0qoOj5rzK5OLkOv5nYBpIScwZRc3iTkYUV8EJDz/8Wc7j2mhIOq2lwANk54ootJROpSWluWvToprYgZSldARy6ojSi1iHqUYzYt7M4DfDbWBWe+dQ8g88fMTW3tvmSS5cxh4uITRlx/GF10cejQyftkOnnbkjeg/20OnzuCnWwV44qp2kW2VaTWvMaLqBx+kIuy4F+PvpdM7Vj/5fYibkE7ljPKC2ToZCLcf+1iYntpcfXQcSIZ+71+0i0hUZSwLn9/fappBLK6nxE2LP5DVSGFO09eAIoYQYxO1UkdMFcpg==
ARC-Authentication-Results: i=2; mx.microsoft.com 1; spf=pass (sender ip is
 4.158.2.129) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=arm.com;
 dmarc=pass (p=none sp=none pct=100) action=none header.from=arm.com;
 dkim=pass (signature was verified) header.d=arm.com; arc=pass (0 oda=1 ltdi=1
 spf=[1,1,smtp.mailfrom=arm.com] dkim=[1,1,header.d=arm.com]
 dmarc=[1,1,header.from=arm.com])
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5Vj+4K1C7Z2h2OUZT1qL6wS65aMAXd5DMGiSI0bhtQ=;
 b=ApfJrpytz/7fIV/Ty55iUVAxgwpGXZ1mUjs6GWLNXgX4xGIUCbaKWiq+9hEAxsKIJhDwRuC1wrfpqJmcNPazJY0mPQqVrKhRWMK2zIxzqxHpwZ8K+dB4X2lbpB3V8ViF7GSOyw7JEcWouUb0vgqdeKsus/OXI/Coe68tnrWoh1A=
Received: from AS4P190CA0016.EURP190.PROD.OUTLOOK.COM (2603:10a6:20b:5d0::10)
 by MRWPR08MB11758.eurprd08.prod.outlook.com (2603:10a6:501:98::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:50:38 +0000
Received: from AMS0EPF000001B3.eurprd05.prod.outlook.com
 (2603:10a6:20b:5d0:cafe::18) by AS4P190CA0016.outlook.office365.com
 (2603:10a6:20b:5d0::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Mon,
 20 Jul 2026 13:50:38 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 4.158.2.129)
 smtp.mailfrom=arm.com; dkim=pass (signature was verified)
 header.d=arm.com;dmarc=pass action=none header.from=arm.com;
Received-SPF: Pass (protection.outlook.com: domain of arm.com designates
 4.158.2.129 as permitted sender) receiver=protection.outlook.com;
 client-ip=4.158.2.129; helo=outbound-uk1.az.dlp.m.darktrace.com; pr=C
Received: from outbound-uk1.az.dlp.m.darktrace.com (4.158.2.129) by
 AMS0EPF000001B3.mail.protection.outlook.com (10.167.16.167) with Microsoft
 SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.5
 via Frontend Transport; Mon, 20 Jul 2026 13:50:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dTdVj9RUVcaNpZnPQwkAePhiUm7g8ndLcuBM+BH5vbqa165TFENgxFJZkPpauFqc9sQuxbAOjKrM6kULAZ4Cr5AShcWp7ltRpvWUczAqLoKtO2JAePk6VL84SmU+KqK0yXXYtVMJqmJP8ibi/IGewvYvKJIPf+eaxXs5C6W4MikOvjL2P8PTN7jG9LRLeKlFAXdY7EtwfRw5JAsNw04y2YkruPlOtLp9Lo69Byv5hRVotC8rk5G9kjVMIeTdk77Y2PgJa7dbGIGTTUrhKwr4C7b9yf3tvIjUVyMxEs4DJUH6jLhkiV3sgIrT0+jjnSKEanVB29i1UoySQyUwTA+q/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=j5Vj+4K1C7Z2h2OUZT1qL6wS65aMAXd5DMGiSI0bhtQ=;
 b=qnN3ybug1VfQM4ys/Y381oT5DzM+Owb4pdWx9pGoiNKxHBW86+0I/9W51hoJ8ULm8nNPoYaIDRroLGNkGQ1seBg8ZtJ8vGvealZCkXqlyo6SrR7YhQ/d4f18S4TmoSKZyo/lCk7lnY2YWHm7P9o32bK9pIpK39NtnxWyT+GCujuSDAFZ/dK143G3PhTW3/eMA3AC9pq3czk4rM52nwewHlpIRmaqFHijadOW9koqVbOIpo87JUnwSj/sULYUfffYz/vvUmgUhZ63ed2ZG6YrTaPcoKubzXojR3gNXv+zJ1T1yVv6tRfrqvcrosZtu7Gj7s3O5wGzJ4phxlmO6sW2Jw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=arm.com; dmarc=pass action=none header.from=arm.com; dkim=pass
 header.d=arm.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arm.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=j5Vj+4K1C7Z2h2OUZT1qL6wS65aMAXd5DMGiSI0bhtQ=;
 b=ApfJrpytz/7fIV/Ty55iUVAxgwpGXZ1mUjs6GWLNXgX4xGIUCbaKWiq+9hEAxsKIJhDwRuC1wrfpqJmcNPazJY0mPQqVrKhRWMK2zIxzqxHpwZ8K+dB4X2lbpB3V8ViF7GSOyw7JEcWouUb0vgqdeKsus/OXI/Coe68tnrWoh1A=
Authentication-Results-Original: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=arm.com;
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com (2603:10a6:803:80::16)
 by GVXPR08MB11699.eurprd08.prod.outlook.com (2603:10a6:150:312::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Mon, 20 Jul
 2026 13:49:35 +0000
Received: from VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4]) by VI1PR08MB3421.eurprd08.prod.outlook.com
 ([fe80::e079:6bd:fbe0:89b4%3]) with mapi id 15.21.0223.015; Mon, 20 Jul 2026
 13:49:34 +0000
Message-ID: <e98b0529-4f70-4e69-8d71-7b89f20cad10@arm.com>
Date: Mon, 20 Jul 2026 14:49:33 +0100
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@arm.com, linux-s390@vger.kernel.org, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linux-sparse@vger.kernel.org,
 Claudio Imbrenda <imbrenda@linux.ibm.com>,
 Kevin Brodsky <kevin.brodsky@arm.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>, Chris Li <sparse@chrisli.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [RFC PATCH 0/4] mm: introduce __ptent sparse attribute
To: Alexander Gordeev <agordeev@linux.ibm.com>
References: <cover.1784292223.git.agordeev@linux.ibm.com>
 <e50fb51d-72ac-4ace-b532-5cf32ecd80f1@kernel.org>
From: Muhammad Usama Anjum <usama.anjum@arm.com>
Content-Language: en-US
In-Reply-To: <e50fb51d-72ac-4ace-b532-5cf32ecd80f1@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: LO4P265CA0120.GBRP265.PROD.OUTLOOK.COM
 (2603:10a6:600:2c6::7) To VI1PR08MB3421.eurprd08.prod.outlook.com
 (2603:10a6:803:80::16)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-TrafficTypeDiagnostic:
	VI1PR08MB3421:EE_|GVXPR08MB11699:EE_|AMS0EPF000001B3:EE_|MRWPR08MB11758:EE_
X-MS-Office365-Filtering-Correlation-Id: 629d9904-16c7-4dcb-4687-08dee665e1a6
x-checkrecipientrouted: true
NoDisclaimer: true
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam-Untrusted:
 BCL:0;ARA:13230040|376014|7416014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info-Original:
 ByU8VC+h908f+DwpmaJWLFjce1JGtwa3qIZH564Z5zcvXZ9dlbw2uKv+dwcP9mg78k6YFWRAB+OUlZ5Evp/HGJs9yso2M6R97YKOmedboITp5gu9ezrolboHyyY1KQzDORJM6g1tWbkfYSqSwJ70WeyxZOSmfxDdKmTUlmWb9M7Pa5q5oXCzPev89OKK1OJocg99Sv1eIyO1iyz/thu4n8+HMXwBpQ8pLZZmLMLoMJ6mu1GpYuYa/UhKpdbSL1b5e9No+5V2iBiiMenEyfu3Tbjow4daZyppkD4vGjoIaknVsquUEo2+6+i9D/IzVZkP5KxQvSr512DfsIG2JGvhXg5ACFPe6Na6eyZfxXLzhbiBQPzi3CoVpEAEveQjvWCaFyGXHn24phz9ng2bTmZUpBoIlEhuQJTGXYDDbndyJaj5uUD6wwWinypUw4yg3uZln1o3t2w4PdANseIKITJOX58ARs+lhnO/+twVdcMxmNOieuxFMqR8ObDL3N6qXmT4wY/BfDNUipQ5iiNg/6oN6fEXko6A2hvqpPTriC+1ue0yVUFvSqOkCUrKawZ5QJd9shBoPS+AGERVaaaMMUh/acgw1dxQBzMRu6N00v5u9ousBeRpRYiLk/D/9hlHThN3+O43rmdS2WXpGex4kEo+M5pAs6DOgawOCoKGTGvl91Q=
X-Forefront-Antispam-Report-Untrusted:
 CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VI1PR08MB3421.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-Exchange-RoutingPolicyChecked:
 dXZF6Lj+mj9S+EAyAxcFwViBsWoCSutFUS5EGeCF/YzIwmqH55YFiKYhDsO+PwaPAjs2Ul3bdvXD9IbnaCuCbUfmr7Mayi08MelnpzlSNxdtPlrRLnAIaQswxH3wlhXgD17xP1xyKu+EmetZspA2nZGL6YsQDjS+UXV3TbajyGpPeGbP9ahtFmm329xzdUTb5xoPSmsyR2EYeKeFGrOeatI7rE1MiUzS3Elgv02tCDwOJBqvt60byG3SmTdkbPBP8s1na/FJu8l/I5u35LZe0G0KsFd+x+0UXOxDL776aHLB5+mfgYk2qGIy00fn+qi0yvq2dqvcx59Ky7JSO90NIg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB11699
X-EOPAttributedMessage: 0
X-MS-Exchange-Transport-CrossTenantHeadersStripped:
 AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id-Prvs:
	bf49d646-ef72-4213-0e33-08dee665bb5e
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|7416014|376014|1800799024|14060799003|35042699022|10067099003|56012099006|4143699003|11063799006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	c7o+IHj3ZasRFWKT1MoKOGKgX2o84dz7N6EIUj6RxjhrGLOGVLnoln36dS6AogxxbeKcRpUhZ05vUpwNthacZVybyjxzlVxYKxuu+/PMWyfvVrstHOhx/83m6sCiZRbuFFkt4a2dPCnC+3AiPWfH544D6Mo3UwQp4N7FolJN4rNmLGrdJcwwmToJtSPiFFOa5VtL8kEqDmF2ROXL0/lFkKfTuUkQKmo7WdLfMj6zsCEALCBCK+e9NNjvCoLB/KkBGaqhlf8X8nKAkZ0RUz283jF/wpm/lj0aQOMvSZd7IZpAhsaLmYmvIFhomApdLS0QnoAxG08QlF8LyBS36/FEt8KxZ5ryrby2+PTb+xzR8teg/LdgQcFt7FgFRpo3oROBpv/EDMrCC164L/jwtgpYSXzac8+T0Bku1b+jmS1GTLsNN5Mm1KWEakAhvEQ8xoGwzkh2psgK/eMXjaqTX29vm10kPK2Czl8RvHCTXn2vN5lZyOr3FvsUQV2ij1qNlU8cTmu11AgxGJIi1mtk5k9illnhUrhSTsP8NrUTCUtd41zRQjrdgeUnD8jQmWHoJcEJhyfyJB1Ce/pWyWHb3ga2bL1LkdO6LEnb3vBVrxtFgaQ1639UpO6NGf1vn13lblWrvYKcUQtF5wqES0oIB033onDMbMmlTDKK94eX99b22PNd0XEhwrBdumzL8fV1A0OeEgRe7vIhHpgrJjURNsJtAQ==
X-Forefront-Antispam-Report:
	CIP:4.158.2.129;CTRY:GB;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:outbound-uk1.az.dlp.m.darktrace.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(7416014)(376014)(1800799024)(14060799003)(35042699022)(10067099003)(56012099006)(4143699003)(11063799006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	8SBnZLBovMkn/8ejtC1xTHA0V6KceAmsxLb+J+DKcwF1m8m/qzO4j6jZXkfZU0iO3LXrQ6pdIgbhcluOzbjcw3Y7iTh47/01+FxknKGVmT+vBCHROQOBQUnv22NuVaN0jelNYyohfV9c3oR2NRG36liOaZCSFDELOJqqc7MIO9oGSYQIpV9SwtCpZKfqgzSJ3TjYJ1a6K1IX+CWKC5Mplh8MVMmE9U9WBOK74Sy7TxAtVfExrUprZqyzD0p0ndyvTyY+z+bvGr4K5yYDR/9g1Ung95lf0Ym4oBR57M3w1orbwAAz4Vu8toqdy1yQSIYpk2GvwCvXZGMKQZOyKu05JS4Bh9xfMvJrTB5KATvRhFfzWCRsUAO1dq8Clml+tAPqI8/xOvsX6VrFY+174g/N66ppo3QfcqDMeY+QZYjRRtk4lu4PbhzKQ7fKBSE3gJxD
X-OriginatorOrg: arm.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Jul 2026 13:50:38.4034
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 629d9904-16c7-4dcb-4687-08dee665e1a6
X-MS-Exchange-CrossTenant-Id: f34e5979-57d9-4aaa-ad4d-b122a662184d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f34e5979-57d9-4aaa-ad4d-b122a662184d;Ip=[4.158.2.129];Helo=[outbound-uk1.az.dlp.m.darktrace.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001B3.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MRWPR08MB11758

On 17/07/2026 3:53 pm, David Hildenbrand (Arm) wrote:
> On 7/17/26 14:32, Alexander Gordeev wrote:
>> Hi All!
>>
>> This RFC is a result the implementation of lazy MMU mode on s390 [1].
>>
>> Heiko Carstens requested some mechanism that would rule out direct
>> dereferencing of PTE pointers, which otherwise would bypass the per-
>> cpu cache on s390 and lead to catastrophic results.

This is the exact point we want to fix once and for all. Please feel free
to review and endorse the approach we are going with on the original discussion.

> There is some information here:
> 
> https://lore.kernel.org/r/6110202c-057b-4701-8c04-1a76ee7bb9ab@arm.com

-- 
Thanks,
Usama

