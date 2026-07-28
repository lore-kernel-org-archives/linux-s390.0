Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012009.outbound.protection.outlook.com [40.93.195.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F16B13F4854
	for <linux-s390@vger.kernel.org>; Tue, 28 Jul 2026 08:21:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785226888; cv=fail; b=jod6eMi+5Xsb0OqCzl5Z/iC/1EXqtI/+lVrF+hKK/kZsmKqfq5F213n6xaUfTF6GF9JiJbMcigmugvu2v7ZIm8QyCpbJCCqg87MeVyD9+2/SsNEacjerkeeuvb8Q6kXr9CvMklQTBucNU6AJGKXHpOjLtQGh9yKVoWmiBhwavxQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785226888; c=relaxed/simple;
	bh=30eWy3lK8HNuUNffnedjZmnrDq8D8g5foMWP/mOrNyg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=CazkD3Tef3KzuPLzYdE+247rUw+3qQvTKFhfC0g+a5xa8wtTtn5pMWqnRih/jU7IT1hxk1MUr+Yu1aYiyS+bTYfcdnXPNXeU7SKSxxk/C9jipUed97afGi/6HlixSIaTHlFaJ9HKYBT8qeFct4qhhclkA/qvfMRdBPQp8VqHwRk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=mzq92/8S; arc=fail smtp.client-ip=40.93.195.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="mzq92/8S"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=P8HaSOmU8MMruydp5AFXR9c5y89s2Iw1CipMUw2eJvnaFcMS9aDl/2jSUvS2pFiQ46S9IOKk7feMrm633YRSPDR6ear7hBrMp8dFagfjZZOl0DfrCxaMMf9b3ZMbWbx5gy9pYKpLrULZ7u82uliJj/vQdPCl9PSUOre79zc6wtQN/f6K+K7HuNEf1I56rY/Txdg70+XSsOJrFx3kGqYAhzVFkr2OTTA+UYCxHc/GLnzb7KMJKKQthjVUtTfYtxaKWWJlklt+JZbvDF9iXldZ0ZUo4gRUznR7FYPBpWG2Q+ANVfSaujURSWwYeimnrK/w6F4Rjy4t92Qu/E6Dc8rUyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=M6fhEShDUkXRwIdkSmgEsYaQwyja1JBji4pfhQcuvc4=;
 b=bJtUxNxWCCwZoi9i8jsxDSDGAP5VDm6dQVSxOedI/Z0ulR7YjFbtxV3zxA4l2WN9gR0Bnl147I78tfRpRuda927hz34++alYk9qES34DIKqe9AXVhjobeMeRzXOYbW2sZeXnP3TtCFUF2Dz1aXVSys5dTjFraGdNb+hQxSx6nNCkDeDFDl6ScMQZJq6Kl19fd+XHuiJsirThIA+eIlUc07C6OxPxyB2viVEqAFd67dxM65TsGkC/vfWomeiaWQ0og6kdGAGHxpg2aLQ/rggr1wGwQp8UgQQR/p8+G8UWSkAz0rngNsHkef32VLfTIFMZ3H4526z1KMBfTWmAlVfR4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=M6fhEShDUkXRwIdkSmgEsYaQwyja1JBji4pfhQcuvc4=;
 b=mzq92/8SOicVolYFczL6DCJ+Uwc/Lqcc0mW77NKoYaTVFWgDzIczIBXfFvewGAQOpy1EbNOIoGaDxVa6VeOjGr78BK8sjClTydiwuSnf3jVMcpcCNwO+El8NCO9/uwE6LWZBqZPMC/XpAXuLdUIRsSvjRxQD6pfkVjBm+CmKjJ8=
Received: from MW3PR05CA0022.namprd05.prod.outlook.com (2603:10b6:303:2b::27)
 by CH2PR12MB4247.namprd12.prod.outlook.com (2603:10b6:610:7c::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Tue, 28 Jul
 2026 08:21:21 +0000
Received: from MW1PEPF0001615C.namprd21.prod.outlook.com
 (2603:10b6:303:2b:cafe::8) by MW3PR05CA0022.outlook.office365.com
 (2603:10b6:303:2b::27) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Tue,
 28 Jul 2026 08:21:21 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 MW1PEPF0001615C.mail.protection.outlook.com (10.167.249.87) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.292.1 via Frontend Transport; Tue, 28 Jul 2026 08:21:20 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 03:21:20 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 03:21:20 -0500
Received: from [10.136.36.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 28 Jul 2026 03:21:18 -0500
Message-ID: <5d658a42-edc9-406c-a755-281e1884a61d@amd.com>
Date: Tue, 28 Jul 2026 13:51:17 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] x86/runtime-const: Introduce
 runtime_const_mask_32()
To: <sashiko-reviews@lists.linux.dev>
CC: Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
	<linux-s390@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-2-kprateek.nayak@amd.com>
 <20260728053722.832811F000E9@smtp.kernel.org>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260728053722.832811F000E9@smtp.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW1PEPF0001615C:EE_|CH2PR12MB4247:EE_
X-MS-Office365-Filtering-Correlation-Id: 61536a60-53ac-44b1-c222-08deec813485
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|4143699003|10067099003|11063799006|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	ctlr2sMyy6qXxo4Ob5N9jsd2aWJfDUW0wzYuXPefCaaSr7wa2JVyHlPWQiLnDp/2lojV16d55DnT/nEVuuVF+SxIq5MPVfGMuheK0PwEyODb78PxiSYZdBcrEL/4LGRDYK/5zG/i1piITwTVLk77moUQuCEw6hNJ0vU2jjqk80GXx8ZUM/eJ4j/F1JeGdkETZxTrxGY3oVPffzNvdm2592dYVrGrjLBx7huxSCq+2RrsnERbC/ZFB/3spsZfG+nzx2PbqQM8yfrgD2xm1DTgfPXarPyz9q2OLf5gkogNwLT93PBezKkkbP69Ny9VHQBI6TCVGUGv+BKUAsZF5Qcade9UIrp4K1XpXWaGN1As+IYk+WiYQkTBYUoE2xf9o+m9Foa+S7NJgxZ9nJW6Fh5CVfh26rwloZNMrIkxUIE0hJto7XVjCeufDPovghDgGLwFynsVumtvtx2wehENO1LyFMB0Ts2YiyNZ9LajKoWwVSxML/PjDLOITrpZY/sA1576QGG4CThsc8ZZ/P1ZDCryo9YSDEaoMrt4rJVGk4g9hXgwn5gvi/+Jz6M9xNpPcdEvulBWKgFFIuJdylPfP9Sag0PEnb8RzAf3oihm3mcICw6yCTZerOMZ2eeNGaPx15Tn2pSvGjjt7fzHZOaWKvqjNGNpAmtzW+Pw6cENFICDyco/chnELxA6X9CQ75/9zwcuM696M+7pD3n8ruFyP8H9sg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(4143699003)(10067099003)(11063799006)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	hJiKmuGv6lmP2LX4aa67AwLLYNZ/M5XyxJ8OMQlHb6zPATvdbkA3MYFCUd5bIrPYhNO6JSqfaasFQUt/cQPKz4lMb7annN5dBx+PRvQxjpI02TFT7kqgS9i//ZDWa1/XtDCmTN9PhrEEKbnO/SO2EY4G46NtVBsdZWXSXVsHC1MoKAt75hCf15IO6xQVr98wVKTmpduoX9wvKLdBnPOvw3VJ1QoYeyjaikjHh7DNhIzNMzb+GIP09ZJ9By7I4yf1P6Dm3XJcKdx2Iaf42bBbsxK3GxwmLxb9y+GUb7hAYNnhq8hf3xEmjLBl9pTulAJQ/vxY++IEyaoUwhHIGjMoCXvvdru/nHUCrJIeUH4lxuo062YbwSnpcVUQ96PStE1X37Wcx1KEuidHz37Nyt/twSK40y0MGKm3SQ7onp69mUtMzAQc5umUcdQRVRCMJ+XY
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jul 2026 08:21:20.8517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61536a60-53ac-44b1-c222-08deec813485
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MW1PEPF0001615C.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4247

Hello,

On 7/28/2026 11:07 AM, sashiko-bot@kernel.org wrote:
>> diff --git a/arch/x86/include/asm/runtime-const.h b/arch/x86/include/asm/runtime-const.h
>> index 4cd94fdcb45e2..b13f7036c1c9b 100644
>> --- a/arch/x86/include/asm/runtime-const.h
>> +++ b/arch/x86/include/asm/runtime-const.h
> [ ... ]
>> @@ -41,6 +41,15 @@
>>  		:"+r" (__ret));					\
>>  	__ret; })
>>  
>> +#define runtime_const_mask_32(val, sym) ({			\
>> +	typeof(0u+(val)) __ret = (val);				\
>> +	asm_inline("and $0x12345678, %k0\n1:\n"				\
>> +		   ".pushsection runtime_mask_" #sym ",\"a\"\n\t"\
>> +		   ".long 1b - 4 - .\n"				\
>> +		   ".popsection"				\
>> +		   : "+r" (__ret));				\
>> +	__ret; })
>> +
> 
> [Severity: Medium]
> Will this cause a build regression on non-x86 architectures when the generic
> code starts using runtime_const_mask_32()?

That only happens at Patch 8 and by Patch 7, we have the generic
fallback. Everything is aligned before the first user is introduced.

> 
> The commit message mentions this will be used by the futex hash computation in
> a subsequent commit. However, there doesn't appear to be a generic fallback
> for this macro in include/asm-generic/runtime-const.h.
> 
> Without a generic fallback, it seems architectures that don't support or
> haven't yet implemented runtime constants would fail to compile once the
> generic futex code uses this macro.
> 
> Should a fallback like the following be introduced in
> include/asm-generic/runtime-const.h alongside this x86 implementation to
> maintain cross-architecture compatibility and strict bisectability?
> 
> #define runtime_const_mask_32(val, sym) ((val) & (sym))

Done in Patch 7. Bisectibility is preserved by having the plumbing
in place (in some order) before first user is introduced in Patch 8.

-- 
Thanks and Regards,
Prateek

