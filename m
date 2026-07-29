Received: from SN4PR0501CU005.outbound.protection.outlook.com (mail-southcentralusazon11011033.outbound.protection.outlook.com [40.93.194.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F24314ABE;
	Wed, 29 Jul 2026 06:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.194.33
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785307766; cv=fail; b=sdCYShzTWPPlQcY9knzTcrzVcYHqpiSoPWoBlPNlDDA1w1TZvOnC9UFc5kUfLXhpBbeKBaOaXJ38+YUIQthTv8dgDpau30PvL1NP/JN2A4iT8pziWNzgpZsCU381yNmQW4DCNfxTxxAnWJBSPeoWQleE7fBTI09Zf1Uz5+SmkHQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785307766; c=relaxed/simple;
	bh=JDXd2e5EmP/KRxqemm3dPYDkjnPn2ytW7ve58aS/Z1Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=kacGowmuEUPrZ09MwcpfBMH3koc8fT+b4tPeWv5uo3y9oNMSmq5U9pg3iYXZzh9mdFK+FyZ2ddDqEbWJscURioeIwYJ6du7NT4szVztLwFY7B7jgq68WuqCo0nZjEiA1AkNbptd4O9+Tb5I0BIv0DjutOYqcE+boOY9XshhD2xY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=YARCBOpj; arc=fail smtp.client-ip=40.93.194.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="YARCBOpj"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mItVBia1w3KAt+se6TllTL84ORTuIneb4VJl6hsx8x8yvrWhJQoVgeTEufg5P5S46OSy5RZu1TrC+L10PqjYDId1g4f3FhfEU2x7YYyAZCWbXl6s1uh0p1gtPsUCbNfJf03jWOeCUuzLeOihkgfLPdNU8YEkicQLe7mla2OQgW9G1E36WMsOCa01PqgUdwo9Hgjd7YxLkWEiOaCaS5Sqo8QQ0TgFS+Kus4eL6FKLOhtx3/JllzM1nKUFQuD9Xaa3VLqqjys0wtsmIUTrbhi6aaUkksAw88w8+pajQacFp7k1seJ0sKnUrGzQbTCqkCx5VT1CTw61EIaX5KVkz09lXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4uwk1C1ikhvUrPi/9dJVHUhOWvMR9EHPaiFhoWQ8IN4=;
 b=AkdWhIVYbfaMk/wEygg0wblD74UpVIIMpIwUU0KkC/uF+SakzQObewUu5G5riW4n+6KI+8Z3T3kAdsIwHJe0hRilZApwpZpQ+bXZQs1TUV/wiYGR/rhlW7BHm3LL+gCO8ff7dhe231WfrmS6Z/tPsToKJZFxDlpahTquFDEa66s6zrjxxOS5l1YaHIQDtlJCuw3/+9rcLmOvNftyabjuuCo9yGQFCSvx4bJSSPle3sX2D1ng3qZbuTu9KMuQLbCTFJQDStRx3VVwmZJrU7NUe46n80LFTGWB/cS8XvwcXsmLGbBtSsrM/krJ6jWqEicbWdXC0MYdNuEvD1eiRkCYWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4uwk1C1ikhvUrPi/9dJVHUhOWvMR9EHPaiFhoWQ8IN4=;
 b=YARCBOpjocDFtxNbR5eXuw/0tcYrAG0HkE9MgITBFlEZ0KqEdP19/dm/3h2+tLlxgFwksoroeLAwmlb4OeTRJyBmcrMf3wjZW2SKDV536V1vxC4tzAXGMErKv4z8z9m1r62a/ujKlbNVz7IF84h4IqqyVSqfRxn7rIj0HU9Glgg=
Received: from SJ0PR03CA0163.namprd03.prod.outlook.com (2603:10b6:a03:338::18)
 by IA1PR12MB7685.namprd12.prod.outlook.com (2603:10b6:208:423::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.270.12; Wed, 29 Jul
 2026 06:49:18 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:338:cafe::86) by SJ0PR03CA0163.outlook.office365.com
 (2603:10b6:a03:338::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.13 via Frontend Transport; Wed,
 29 Jul 2026 06:49:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Wed, 29 Jul 2026 06:49:17 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 29 Jul
 2026 01:49:16 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 28 Jul
 2026 23:49:16 -0700
Received: from [10.136.36.1] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Wed, 29 Jul 2026 01:49:07 -0500
Message-ID: <217c3e5f-1027-4086-80b5-a6fb82ff1596@amd.com>
Date: Wed, 29 Jul 2026 12:19:06 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 8/8] futex: Use runtime constants for __futex_hash()
 hot path
To: Peter Zijlstra <peterz@infradead.org>
CC: Arnd Bergmann <arnd@arndb.de>, Thomas Gleixner <tglx@kernel.org>, "Ingo
 Molnar" <mingo@redhat.com>, Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>, Charlie Jenkins <thecharlesjenkins@gmail.com>,
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon
	<will@kernel.org>, Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt
	<palmer@dabbelt.com>, "Albert Ou" <aou@eecs.berkeley.edu>, Alexandre Ghiti
	<alex@ghiti.fr>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Darren Hart
	<dvhart@infradead.org>, Davidlohr Bueso <dave@stgolabs.net>,
	=?UTF-8?Q?Andr=C3=A9_Almeida?= <andrealmeid@igalia.com>,
	<linux-arch@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
	<linux-arm-kernel@lists.infradead.org>, "H. Peter Anvin" <hpa@zytor.com>,
	Sean Christopherson <seanjc@google.com>, Thomas Huth <thuth@redhat.com>,
	Jisheng Zhang <jszhang@kernel.org>, Ben Dooks <ben.dooks@codethink.co.uk>,
	Samuel Holland <samuel.holland@sifive.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?=
	<rkrcmar@ventanamicro.com>, Guo Ren <guoren@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>
References: <20260728052540.4728-1-kprateek.nayak@amd.com>
 <20260728052540.4728-9-kprateek.nayak@amd.com>
 <20260728104653.GH49951@noisy.programming.kicks-ass.net>
 <20260728110806.GJ49951@noisy.programming.kicks-ass.net>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20260728110806.GJ49951@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|IA1PR12MB7685:EE_
X-MS-Office365-Filtering-Correlation-Id: f0b9db61-3843-48e1-118d-08deed3d82ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|7416014|82310400026|376014|23010399003|36860700016|11063799006|56012099006|4143699003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	HQXf33QzHjGUZRy6NszkV/I/NifViRH3k+0QIwAJvuiChnReha4FXV9Ea/0aCyUnmlloLgrLpme9BikGWGEkXAVgTB2rA/x4FWZ9lJMIxyoM5as1qCuMKANQJ8px38hkFxoag/LcK7cc2qWxtFtiDpkOH4qyeZmHJoMgELMCmKH5Fb/bCpEBbfswrDB2d8E8hw2X2Yvkg5CHDLyikdMaHGQhlou7BR6qsnOQ9Xjqi7Mi57tar2D8JYm43c1d1pKC72CsEjQGSM+IL+1wu3z5HwKefUPanfQdUKJfbi8zs9cxDHdBzhD6gpMz1FR44E2xVT7gU3MEaY2Qciv0DKKLP9C2BUEg0YDNUObEvGS0dCzAxziQ+9ZjThlnamUi/yJTk6ikRSYV4FxTJ5ltmgKA2jcUTkNOcr01Sp43c4Rp78fyfL2EqnFVASfu73FWqRmm96Zw0rKvnNTwi6P9/V44Wf3nu+l2UTtOvHQR3Jg3Evglm1GNjF0cXpjOvovXbOSQBvvb8Jp4G/Ix31zFqpTP3yW3abHjjDGrt4pFuth8i0dJvU4cCba3b0jBP7S9iu4RNRYS+u3vjnj9a+BXLwFjX/JyQuaBAELJcRMH7DOPBV4+/pYhUTtwjgE49ieFJLi28iYenNlXitE7D8ZPp6CVtHULEhzeZpCLSCyAMLJ8/492OwkNuT9fvm9FHNGml89HfILLKrhcEe0Y/L0izy6ptA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(7416014)(82310400026)(376014)(23010399003)(36860700016)(11063799006)(56012099006)(4143699003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	6zffBW3/80egRCzymoUF6dEpAwm0QYyJSkmiNx4Ig4ew+5s5CEOENT4ygmgScmJhLCns+F5rEdIH/xrbY9RMyudAJol8cOPCveUwELjrMMNSb+VqAFgyThJsNR3B2XCmy6UpVBbF0qwgyJ8+KN+3IcyICGu7hW3AdBHJbTI2rVXdFRtmAAFyxJzIW2V7uCFvVeDksTfEDDFLozObZivY89D1tEJlqgcsbSc3YPToJ9YV2+ysN32/7vgFhpAb/jGrJsLfmd+2+/L+ozFETw94sfdxMkHVM7N6UeTiNBVEPZG/5lyoaziGht2ZzpcdL9NrISVPpCiafxj4hN3EDBGNOvFzvs5mjADvCHAWJABtU1+abos0PXsWOb/xsKJ9OpVjMKo8KMdDN0I/4U6MYNH+5rc1TJZIU5iFlSLLEXLHBBadDDPT3I66caB5ddHSe8mi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jul 2026 06:49:17.3109
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: f0b9db61-3843-48e1-118d-08deed3d82ae
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7685

Hello Peter,

On 7/28/2026 4:38 PM, Peter Zijlstra wrote:
>> Right, so I also munged the Changelog in my tree to include those
>> benchmark results. I failed to actually push out those patches before
>> disappearing on holidays, but I recon I should refresh them patches and
>> re-munge the changelog?
> 
> With a bit of luck I didn't wreck things and this new version should now
> be available in queue/locking/core.

Thank you for fixing the changelog and refreshing the tree! I gave it a
spin like everything looks alright - x86 on baremetal, and others in
QEMU.

-- 
Thanks and Regards,
Prateek

