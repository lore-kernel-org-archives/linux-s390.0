Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013017.outbound.protection.outlook.com [40.93.196.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A99A3101B6;
	Tue, 17 Mar 2026 01:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773712540; cv=fail; b=FzMPmnJQM/YJVUZygPVP7qMk1MfawfuS20L9rDK5JQa46+SezMjbJcENPMgJSbLCmbu71oCxJLwLv50eKC/J9D99chHy1Xbz5OJr3FmHK7vWy7SX07aOzbfRGI9rfdvprX7cPieRxJ+OD3sFlQN3/aUM8N2bb40YNw0V2JpTD2g=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773712540; c=relaxed/simple;
	bh=AvP7DhuMS9xiWOTX8lgMfI6/i2qan63c0rM/JnHyjaM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Sti+hVM7wnwfBwfzMHmh3S2x8EEvKV4eMERE7hLI4QA5AXU9OkpmXzjB00hI8Nv0lnceUR1raDfDZpbk34bMQmrHomMNk/kl7IUHEKhgidQGMWVoxGkVoJxcdQTQj1FjmfjiOO9QV5YBhFG3TUZ75wVH6AYIH6zEi56DbB1vATc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=1uBJdr3n; arc=fail smtp.client-ip=40.93.196.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="1uBJdr3n"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=O+Vu/eOpfTzF2KQoXKeSj2SgiKCxMMy5GR7wQUChUc8IS3lunaqCk/KSo+McvAVUnLsy80Ty4mLHrnQ7NosfA1bQyVfU7G6XsBcGPn/885V2012iUMG+7qY++UFEeZK3+5bpNoh+XiEKf8ylKI6G/wMwtHhhdfATgx8DP6BazaCMr3bbvDkTeUotU/grn1LOOJPZJylWBOWrcsnyjHquS3CX4eBMH/NmTAiicT0aiUDDQz83Zu/0PuFRvmP6EwUPsLMUVTG9zUAq8ePG1SHZDNzq7IbNShPt6hZ8Dy5icTS7Ct6Gjk/raohDgGj2ACYWRrtXQiNX8KeTC/02ZE5//g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=iI/C0gsSslPlD4GdE2LcT43hHmTcYJQf9I5E3xpOyYE=;
 b=Dm/KzE0cuQU/EfgQEythgkhjyxOFQATErHqKlYzdcPPPAgsma9ws/Nk/z1Z76L2xa9X9UHaCWJN3AUy5mTqB2BuDhdr/t+QoeGK9noTf8MRSDCUmWXdGcRSI3VOFtWT8s8TRgae0jfsurcHo6ERTxiuZ0CSn42lOaAmODcU6bd18tPub5iWmcqJyuuEeuBC8rjUJKGfEKMMafFQNXxNm4XaTi86YIAURPYGFmwe/qxEXcETbo+zjPhIVu4JEbswrkZHo2zYJjzUI2pggn1+aHW0AHt0JiXS7/6IUgKm6uBdYn90KQ3IFaJXqTYcJny9nKFJxeuAolXxPj6opL0OTbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=iI/C0gsSslPlD4GdE2LcT43hHmTcYJQf9I5E3xpOyYE=;
 b=1uBJdr3niw3JeVF0OkwQlbiozUzz1lCHosDKdR4S/cWJEc5i9iNKp+XrHK4zQ/oA7fyUJ6+7970NkMC0TZJu8eZLJSv3TcNxaMehov7RUc0HzE22paGeIXDAIy7LzKsJxhy3F0sGMIi2IYXxbeB8nH0Z9xzF42Ujht0Wo7EWQBQ=
Received: from BLAPR05CA0033.namprd05.prod.outlook.com (2603:10b6:208:335::14)
 by CHXPR12MB999246.namprd12.prod.outlook.com (2603:10b6:610:2fc::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9723.16; Tue, 17 Mar
 2026 01:55:36 +0000
Received: from BL02EPF0001A100.namprd03.prod.outlook.com
 (2603:10b6:208:335:cafe::be) by BLAPR05CA0033.outlook.office365.com
 (2603:10b6:208:335::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9700.27 via Frontend Transport; Tue,
 17 Mar 2026 01:55:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A100.mail.protection.outlook.com (10.167.242.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9700.17 via Frontend Transport; Tue, 17 Mar 2026 01:55:36 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.17; Mon, 16 Mar
 2026 20:55:35 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 16 Mar
 2026 20:55:35 -0500
Received: from [10.136.37.230] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 16 Mar 2026 20:55:31 -0500
Message-ID: <94239f7e-49f6-409b-9c87-25fefd52b2cd@amd.com>
Date: Tue, 17 Mar 2026 07:25:25 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 5/7] s390/runtime-const: Introduce
 runtime_const_mask_32()
To: Heiko Carstens <hca@linux.ibm.com>
CC: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Darren Hart <dvhart@infradead.org>, Davidlohr Bueso
	<dave@stgolabs.net>, =?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, Christian Borntraeger
	<borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20260316052401.18910-1-kprateek.nayak@amd.com>
 <20260316052401.18910-6-kprateek.nayak@amd.com>
 <20260316191958.13160A9f-hca@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260316191958.13160A9f-hca@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Received-SPF: None (SATLEXMB04.amd.com: kprateek.nayak@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A100:EE_|CHXPR12MB999246:EE_
X-MS-Office365-Filtering-Correlation-Id: 72c1f9dd-97f1-4b31-c51c-08de83c8483f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|1800799024|376014|36860700016|18002099003|56012099003|22082099003|7053199007;
X-Microsoft-Antispam-Message-Info:
	yQ68oX4hReP3ygDCldcZdhKqe8BQ4M1GUPHDfZqh0gp8yGhZqbq/jCsrbgroDbz7mENje0YAHwj0xpoSpQ4dPDcDJqqKy9comVzjrr40fKupYYnM9c0Z48TuG5TSQl84sPkZX2Q7r6uXbKF2S17mFr2zTlWQHMcgYwpF0ocrMLfMv0BEapxCPGwNSmmbaqy9/JBm6Z24o+fAlSmJI9d2tAODJaUGoN9dXXbv0bdzSbbwdngmYZq29RriUagTHrIbW/syrNIIw2inRAXOoNVD0B5XqeLKOGxwBpMBeEj04oSaO1V9HjOAR+xy6IKS1m3GaIuoE/KnPr1FCvHldlIhsvHuDeJNqIOJASkv7JdRC5Qqd5Ysa5VY5DKN0LA01820Wy7kKeAS0nzQS77keaz0iunBO7fWmkFaFy7P7wlIiGuy/SvrN815dbkH+oHd2KGHXXZiD8KkLfXfmBIdkK7w2J0a8+hh1GkdDWx23ihXuWTTfB0AZWx1ICj6V43Pb4RelVsk6hXGkeS5EIyMgey36OGsaqJ/J/dZLxqMIFsmcDiP4+kw9T3XZ6tW6b4zdQdIdOOuk8/+nx/51iLXT8uLDoy+Vbg2POX51t1GRyUoP3oCOnK7Fi92SfRQTIRx4blscF5gm2+M6llYIie4BTwIFOTqWrUOmsmqGxnlzahBWW5Ldfv9OL/BoTN7quunLvhiX2yl5UHHGxfXFqvJm+Xl7SCU64LH47Bds/G43KKv3butX1Tulpb5iW+WaqPWByPdzice9wNbZm+TrXX+GSW07w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(1800799024)(376014)(36860700016)(18002099003)(56012099003)(22082099003)(7053199007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	OPW6o8O7R0KWwvWrG36EKa6KWP7hX6BDRZ+SEDAMEytZDnC8wMoD0uYID6tgz+pTqPRXQ1m9kv+nkaYWhLRPqP+Rr5sQy8E0azW2JHI/BrmPYTXG8ZUjXDU83DaRof0yUFh+1osiCkI0dGTMu5W3PFJujM/Io4eyqhpCPj9GaSO42UyR5Yufr5q2Y1GbkV7R/hF/YCX4PSc4ngX8VILVBV7Of34n1dNOSoAwLkq+07H5dsM35UB/6VvuGXGap3GvMysBRDbIq4zLkFgRHssHKWDRfrkltka1d54QWB4pzqE40OSTYuX3liU3luF0zZ4jrHzGt+aCwSs7Y30PQincee8scaFqHlyYk2GL00/TqxyLWH7C92uBQql4M28XUGNLpmn9i4cmimGeXuYxdiIaploXSkxkPvBjVZ79TL80OozSKUQUQPfYvgdcZNGl6OU1
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Mar 2026 01:55:36.1586
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 72c1f9dd-97f1-4b31-c51c-08de83c8483f
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BL02EPF0001A100.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CHXPR12MB999246

Hello Heiko,

On 3/17/2026 12:49 AM, Heiko Carstens wrote:
>> +#define runtime_const_mask_32(val, sym)				\
>> +({								\
>> +	unsigned int __ret = (val);				\
>> +								\
>> +	asm_inline(						\
>> +		"0:	nilf	%[__ret],12\n"			\
>> +		".pushsection runtime_mask_" #sym ",\"a\"\n"	\
>> +		".long 0b - .\n"				\
>> +		".popsection"					\
>> +		: [__ret] "+d" (__ret));			\
>> +	__ret;							\
>> +})
> 
> The nilf instruction changes the condition code and this must be reflected in
> the clobber list.

Thanks a ton for catching that!

> Besides that I would also appreciate if you would move the
> existing comment above __runtime_fixup_32().
> 
> Or in other words, if you merge the patch below into this one feel free to
> add:

I'll fold in the suggested diff when spinning up the next version.

> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>

Thanks a ton for taking a look at the series!

-- 
Thanks and Regards,
Prateek

