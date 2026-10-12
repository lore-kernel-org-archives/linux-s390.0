Received: from BL0PR03CU003.outbound.protection.outlook.com (mail-eastusazon11012018.outbound.protection.outlook.com [52.101.53.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CAF83546F4;
	Mon, 12 Oct 2026 02:29:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.53.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791772199; cv=fail; b=HuMYGCJGvGheHaMzSG4GZKlO3V5DAUhlaFJcA96xYSZmoscmG+bBT5YAChKOZbM/ikXrsPpTR/UHcXcdePqDT1Us2OYK0LNSZ5aRBdMTh58N/mr8dSPVUruC/qrFpLhKBWQYy3Ck+hlh+vvJY6W254yZ9W6gNyb2DTGpFS1p0RU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791772199; c=relaxed/simple;
	bh=kayeahorkkhySwyB0nfG2kkrC4gZ5cdlbIBsOjJYDl8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gs93JLU7dLMPBzBHv8FYFjVSKo4TPoItNIdDZUlqud2jo+pTmyTYtEvt4dyrxnS9GzvzliSoW7TvpSyAwJSHgGyJb+Avx1ifFb4/DS6Ql+a9FpmOCT87PGEPsbXoAIw2sPfpdkLmou+0ahOKrHoW7NN0jB4ETOJqNqYGAVlmCAM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=Wh4+N8vW; arc=fail smtp.client-ip=52.101.53.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="Wh4+N8vW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=s8t6XxfKxRZVeUYjGdjefm3+E86nyvnxtyQCRLPLaWLi84J8M32999AQfX7RGhks5/lN/eMhXG8eHOyiCsPi2yG0TlQrtarq7HnrjAoWJ21GQ9hHIi7kkA8lEK067webVgcko1ZdfIMA5IfBpqAtKmlNw0dUc5FJ7WlQ3S7J/Y8s//KKV2V5WzQpfabPAZwICSJz2X/QZ7DjfcEOKFXiFs5bVfuFMmew4PcozeeDlqu/LK2q62PlB3WRfMW6orYRee0mM2B3Sui7yHFodNG3wDQNAoF9tL6OMikDygWMdYP3UEUCcjhSv3bsvhcARvnwHOsOrVgwTsXk8lQAzy8e4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=biPO4041oltA6pcBUqVZAyuxffsWf2Xem0eqGjZWbfc=;
 b=nwNtP3lI41MngxXi+5u5hMSzz7w9p2MerBfY75I/AOfPbpqlLed1uYHhZ+p/Pltqs62ltHdOSVydjygBeNEShu95ElNWxyuJt4G7AMzDnbk/rfLdUgGdmXg1ARvCQMv50z0DW/2piaTzQ+Npxdblr508wng/3BdgNwz8rgivH93R3UrEAFW/g2MoW0XnWK1rmmLrpe/X98J9u7WapBT9BDP4A8rracmoFHD8ETmwmsflzaY7CN6p5uDH9KuFek9Dwmer45MWSeDmddQWXgOBQVHGA/B/1YFOJWKai/2r1dEIFR2X8pwhZ9glOhkFD8HAFJKOL5RstV4EBUk7bNZC0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=biPO4041oltA6pcBUqVZAyuxffsWf2Xem0eqGjZWbfc=;
 b=Wh4+N8vWXE0pB1KE0u++H5tdBHnhbpg4DV5L3KgYHLHB+e7/u0hENZAAO5FPvSqGXjoNFepGGrrGArqeh+NT7YfIRPW0baHEPxwyK404mgo/r/vUR//owdP5Jb6KuFTxjfBKOlurW9g6+4Pb6akrl7516HK0o0UCDdNrXyFTyK4=
Received: from CH0P220CA0011.NAMP220.PROD.OUTLOOK.COM (2603:10b6:610:ef::13)
 by MN0PR12MB6173.namprd12.prod.outlook.com (2603:10b6:208:3c6::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Mon, 12 Oct
 2026 02:29:52 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:ef:cafe::7f) by CH0P220CA0011.outlook.office365.com
 (2603:10b6:610:ef::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Mon, 12
 Oct 2026 02:29:52 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 02:29:52 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:29:46 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:29:46 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 11 Oct 2026 21:29:38 -0500
Message-ID: <801adad4-fbcb-45f8-9283-c35676cd4d63@amd.com>
Date: Mon, 12 Oct 2026 07:59:36 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 06/13] powerpc/setup: Initialize sbm topology based
 on coregroup / NUMA topology
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Peter Zijlstra
	<peterz@infradead.org>, Michael Ellerman <mpe@ellerman.id.au>,
	<linuxppc-dev@lists.ozlabs.org>, Madhavan Srinivasan <maddy@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Chen Yu
	<yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>,
	"Arnd Bergmann" <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Ritesh Harjani <ritesh.list@gmail.com>,
	"Srikar Dronamraju" <srikar@linux.ibm.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-7-kprateek.nayak@amd.com>
 <61b01870-ddcf-4c4f-8604-dd63aa4a07a3@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <61b01870-ddcf-4c4f-8604-dd63aa4a07a3@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|MN0PR12MB6173:EE_
X-MS-Office365-Filtering-Correlation-Id: 23a9f0a2-b7c1-4c8b-0673-08df2808b245
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|376014|7416014|23010399003|22082099003|18002099003|11063799006|56012099006|4143699003|10067099003;
X-Microsoft-Antispam-Message-Info:
	3nfhdf2Nopv53PQXfvy6t4oS5YcTQ4EsozTFUfYjbc6gOF4AqqCNidgTv2wTi8pyEkGtMGhT17Jo1tpMm5a+2LwUwryCzeAYMdPQfcyWbST9GGWexkQQHK6xCL9Fdl6tCxjHXcnLujZTxBo4RLXiBPv8hmsiUmz2pXw4LSHOzsqePwTpXJZbR158vsfkAh9MJmqv+58zv4yQ36uqMs2reQ5Jkm32ee3nreRqH0z9Vmx6LRBuaZ50x9KoPJDC4ASWSWrkkSMr73Wo63eaglQB0+l8Lv8QzENVsDsPHFTNjrkpZhaQdvl//rS4FCkjzDP9pLutwXQEt2h5GC+ZMTjK0y+qH5msjSkH3GkD+S4TAmG86JTB4Hr1g3fOvlXUUxjtMjf2bvV8Tw8B503eBzJLmglakRYyYY41PQ2tIWSz3zQ5T65BRMAbVAtwyIJIBkHMOjbFom13wUcjMtQpUKRoj7yvffdR4o1b+yl9BXLaMV2qDOtrdjG++v8VQ2Lq35TYRZ/MfPIkb6pCeZGLcPQluEw3G0ZwCO1Ea+g4bbTa0kmMuVZJXvyVc1aGhhcQWuJhOpcc+dtJ57Y5YzfO8o/Gnrsz4gxVr/FFrgD1HNMi9oZ6wB0WDfauF9Zqf0sazgGsTnYdIhAhmzlRRherAlyyiB5kCDUOcPeaIpW1UxHcrFLAv1m2BI0VXteQLgMWfUy1Fjbm7eqmmsssQzMDIHd5ng==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(376014)(7416014)(23010399003)(22082099003)(18002099003)(11063799006)(56012099006)(4143699003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	kf9AiQhl//3lnaN1h0NHHjRINv+s4GJq027bktm1OCnUJFtoH9M4pPTxnsAVnJP4hCMqvPL6VvQ065EPS2skTwcGlS0hRbaxMHeesyCcNAOgh5YOrS4+sI0LNIOhs/QX0UjziLmnN3X9lmUuYIN43gfRsdXf0ONoZKSLPH7pYuohrHC+Y9GTyS7V+hKrR6IqE003lhvXwmMGo6gptJsRDb7FiJsi4U3s8RKIPPw7+mRcLCrcV/naolvM0PDDsdI/1C0vNXJByl1rNyor5PZNwlseCQWSkBOZW+X95bXO1HYvl0qBk8ZwZW/hke0Snbs7vPvyTZMsED47/0RmUvQ1fJ5uMNgF8dtByDcamE0g1N+6db6B14z8grLaJLHV33cnm4+1WJMtOcaMlszTFynAoSQ+D+Pchjwq5OY4eJICd372IDrXfNvswKA2LeTOnGc8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 02:29:52.5073
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 23a9f0a2-b7c1-4c8b-0673-08df2808b245
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6173

Hello Shrikanth,

On 10/7/2026 8:13 PM, Shrikanth Hegde wrote:
> Hi Prateek.
> 
> On 10/2/26 12:58 AM, K Prateek Nayak wrote:
>> Initialize sparsebitmap (sbm) topology based on the coregroup
>> information. Each coregorup gets its own sparsemask leaf.
>>
>> pSeries and memory hotplug are interesting since a hotplug can place a
>> newly added CPU on any online node. This requires special care to allow
>> estimating bitmask size considering the worst case scenarios - each CPU
>> onlined is on a separate node, and this is a new N_CPU node.
>>
>> Platform may enforce a stricter standards for the CPUs being online and
>> what nodes they can be mapped to but the current implementations makes
>> no assumptions and considers each CPU can be onlined on a unique node.
>>
> 
> I think this suffers the same fate as structures which are allocated at boot
> time such as runqueues.
> 
> So your fallback option of putting all the disabled into singleton node may be
> sensible option. (If you are not doing that already)

For pSeries I allocate a humongous chunk of memory on sbm_alloc() and
control how much of that memory needs traversing based on the set of
online CPUs. Not ideal but yes, I will probably pivot to doing
something like what per-cpu setup does by using ealy topology +
assuming a few things about the rest.
> But yhea, will see more into it, this changing node stuff is new for me too.
> Also i need to read your patch series too :)

Thank you again for taking a look at the series and early testing.

_Me goes digs down on couple regressions I've noticed_

-- 
Thanks and Regards,
Prateek

