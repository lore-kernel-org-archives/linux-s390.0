Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013004.outbound.protection.outlook.com [40.93.196.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2141B12B94;
	Sun,  4 Oct 2026 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.4
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094398; cv=fail; b=pIJ/QQFv5SqDFiwfL5Df17d4XW5THyXiV7PDeNrQSdYImBqeGiUA4TvF4hcyLibWWz60y4eg/5SDVj4+zVcnx0IGePF0jrABtCfCVUPWvlz8GigBMt578GmFg3SsGHBnqjyXzJQy1Cq8/Rdog2MbzKXR5z8PrFaZzGUvULlmKJ4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094398; c=relaxed/simple;
	bh=vzYG003jc72LObNq1Nm6r1yZVdeWqvbj9MGIQj6cXBM=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=E5sKLBiaVvqgAHtOqj9MxHM3kIsiI4wXbS/L2I9Y//3dBr20d2TY+7UVL6BwyKamLqVHDamaqKalXtFf/dT1JaAjm5eOjPqy7L2R8opJwaJpocvgEFlC3DVhVb8jtdazjgXRJswSylE8lNbgyk3dFiz3JgIwKg+sBglRs9UleMg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=TNvh2viW; arc=fail smtp.client-ip=40.93.196.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="TNvh2viW"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=AgbGUQNc4pYUFd+oiJU9vkPP1uydSjwsafgssv67Sg4zL0t/Fofw2Ldvs0bzLdbr9f1TPn01iehCCrY8lx8TCZlhbSUY2XLbKb5MaGVN1G8BVVNBkCGW6wT6j7mChlYJ5MJ+9Fbrw+TxZgcgNPNiLgMTdyuETGWHCzKr4HcMietKZ5e9OuXA/vyqF4i/okjSxe42jSwzDlHd460qPhQWmnYRLen70Lqto5oHNtTWJuBt3JT/ZX5zCUBf7jJzsHrGNIJIshBgHLLht0TNxo8HtfhdYmLXkEXM68xFlHS2rTrkzWzf8oFBz6ZDcSrIIw0gfMnsqG+vqiOaekSLopcu5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cr91y+Tu130DpA5XoHQ+2v5faKf/WQoFlRdgGMUbxBU=;
 b=tW7mvQUZajD+8e3IczH3G7IEySGvXQCvjQ+zBFJ1YP3+ObOl1EzTF7oj3U186hnzVQ1fYGRFgYbjP6VOnK9WQCR/PXu5KoPnJN8bgLrbEycySaUdtOcVdbeeJ4k9l1GexRD+TgIqYrjj3feon9ztAn3DzvKBphGfO7BYkxfAQ6ojTCrXRHNn3vQttbtCzbsCsO7De6ABymPJNMkbwF3qdlVQykwODFo6Mjl9BFMw+j0A0gccU4J8ve8rRa+l3PQn7vBDgqmXBdXkcaiJV0UJ8iFWhukcWpHBAiaeOkcqK++sTqHnrZn/HzoUJPy/o+bxJ0hIO5MmQYr2CsS6I5mh7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cr91y+Tu130DpA5XoHQ+2v5faKf/WQoFlRdgGMUbxBU=;
 b=TNvh2viWqm3kbfkfEqzssrk/NUAAbuU5or7Jxn7TND+9xRhKBs0SKTrrbUXlLW7b2QN7nKJYyWy+Z+4AihsIf7WG/tY4l4mkk693PgbAoXpmhX10rDh/mysDRrc7XRlOVhTp/trCmA4p90YWn8rcJImVGgHesbbcjWRgwzLlXks=
Received: from BN9P222CA0028.NAMP222.PROD.OUTLOOK.COM (2603:10b6:408:10c::33)
 by CY5PR12MB6201.namprd12.prod.outlook.com (2603:10b6:930:26::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.23; Sun, 4 Oct
 2026 06:13:11 +0000
Received: from LV8PEPF0000005B.namprd02.prod.outlook.com
 (2603:10b6:408:10c::4) by BN9P222CA0028.outlook.office365.com
 (2603:10b6:408:10c::33) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 06:13:11 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 LV8PEPF0000005B.mail.protection.outlook.com (10.167.245.136) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 06:13:11 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 01:13:10 -0500
Received: from [172.30.0.12] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 01:13:03 -0500
Message-ID: <08df1d81-7671-425b-85bb-51ee79c2eac7@amd.com>
Date: Sun, 4 Oct 2026 11:43:02 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 00/13] lib, sched: Introduce sparsebitmap (sbm)
To: Chen Yu <chen.yu@linux.dev>
CC: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Tim
 Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Andrew
 Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Sudeep Holla <sudeep.holla@kernel.org>, Greg
 Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki"
	<rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan Srinivasan
	<maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik
	<gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, "David S.
 Miller" <davem@davemloft.net>, Andreas Larsson <andreas@gaisler.com>, Thomas
 Gleixner <tglx@kernel.org>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, <x86@kernel.org>, Dietmar Eggemann
	<dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, Ben Segall
	<bsegall@google.com>, Mel Gorman <mgorman@suse.de>, Valentin Schneider
	<vschneid@redhat.com>, Shrikanth Hegde <sshegde@linux.ibm.com>, WANG Xuerui
	<kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <asDGbBEHkDouWOwC@three-body>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <asDGbBEHkDouWOwC@three-body>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV8PEPF0000005B:EE_|CY5PR12MB6201:EE_
X-MS-Office365-Filtering-Correlation-Id: fede44a0-39df-4ecc-07c2-08df21de9119
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|376014|7416014|82310400026|23010399003|11063799006|56012099006|4143699003|260925022911599003|260925021911599003|260925021311599003|10067099003|22082099003|18002099003|6133799003|13003099007;
X-Microsoft-Antispam-Message-Info:
	9s9Y8a88riut8/izZPthm/lVlNLeqLHu/ZRy3XDqB6mApbsnrStOR1rLgsGW3uMbGtmR1iODKFvYO+RuQtGr7SDSGmHqttb/OGI127fB2Cvohzmid56b9uWu27NqFmaUCSPZgUJ82zbeMxeuZi7dr8ZvjYMt93kRhA1eL5lViWJW1U51eXNZMxxxK7gfOQpkYhyvOLXYStkawDR7FzkssXZBrthrWZmO6qhUXozs34w7gGkTscZgwGgcAvIQyUj+JxYNS0Vye2Wif0baw74Aftp8uEAoo3U5SrhNcV/6PhaYEP6GVh4WUBtKuxnlIiVWvd8IVKwgyaScZ5Yi/W4lpSzLh8EVolapa8UAl/A9CkdhaS8vQDD03Pon0zBpHDQUKQ11lghHaDFathKF1zXfUBAAiQ905UKvxUoEGoDxJrQRMc0r1CrXutgMlaKSPBZn9HiEPLLOgANsmza4BF1262TxJagFLAAdkisLMypqgL7roJgd5KXQr4SAJYp1dp64tx/MnQqOsrsPqMN/5Kv0P0IK6yHQ+s2iSFsaQSKbVVXeX3B6HKmgxvKmU+PDawQCJkbrMm0yVzha7V9TnQB71VW2YDNaD2sTV4rFzY2Qdtz468bjkR5aLiKSB0bygmNFcQAvTWTqJDNB6DdpSDsxs6R7XIde2cyo8qiQReq70fM=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(376014)(7416014)(82310400026)(23010399003)(11063799006)(56012099006)(4143699003)(260925022911599003)(260925021911599003)(260925021311599003)(10067099003)(22082099003)(18002099003)(6133799003)(13003099007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	erS/vExZES4Rjw9K84yq94xZPDF4JeShklnbnyS8RINT/xJXKTOWSZQyEVPgpNx0CUsAdo1IpQeQA0erhePGot1Gkey3XlmdgJDkSgajRtSMYO9NVUsSLGf4SeUHiqjwhBVR+huqgVZuFXRdCEo6wXSwhHkUSKYfF/gc+fOdtKeQjcUgYSMs0vbziV0hi6Mbp9K8cBAdQ2AfHOxqbjUFaceZ3F5+L2hVDcnvVrofg4/M5uuMPM01DvpVqxAXCNQR9B5V3wo3Vs9p6HxBexYEpyxArk0FORGIiOA35x3GwNpZRuFT3+ixmklv/qw64ouPuGN6TsEkoSUSZT1Vb0NQK2fPtTsYUI03Ny9Gw1KcuyicUxBEb8Brir7GjbHKn+oBmeI0As0bSJ27/EU2DMKEH7R2EjsI7gei9viZ57B4fomfMSl9rfQksb74CuEufJ2d
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:13:11.0250
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fede44a0-39df-4ecc-07c2-08df21de9119
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	LV8PEPF0000005B.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR12MB6201

Hello Chenyu,

On 10/3/2026 2:40 PM, Chen Yu wrote:
> Hello Prateek!
> 
> Thanks for bringing this interesting topic,
> 
> On Thu, Oct 01, 2026 at 07:28:36PM +0000, K Prateek Nayak wrote:
>>
>> Problem
>> =======
>>
>>                                             %cycles vs global mask operation
>>
>> global mask                                     : 100.0000%  (var: 3.28%)
>> per-NUMA mask                                   :  32.9209%  (var: 7.77%)
>> per-LLC mask                                    :   1.2977%  (var: 4.85%)
>> per-LLC mask (u8 operation; no LOCK prefix)     :   0.4930%  (var: 0.83%)
>>
> 
> This shows a significant latency improvement, especially in the per-LLC (u64, u8) case.
> May I know if schbench / sched-messaging were used?

No, this was a custom benchmark with two threads per
CPU - one setting the CPU on bitmask, and other clearing it,
continuously yielding to each other.

It gives an idea of what the worst case looks like when there
may be short idling followed by a short runtime going in
cycles.

> 
>>
>> Future work
>> ===========
>>
>> o Interoperability with cpumaks since sbm lose the crucial optimizations
>>   that come naturally from for_each_cpu_and() iterations.
>>
>> o Different data representation - using the u8 variant for updates and
>>   then perform a "gather" operation to build a dense mask.
>>
>> o Extending sbm work to help in wakeup (and possibly resurrect Mel's
>>   optimization from [4] in some form). The current sbm is still far away
>>   from being used for wakeups since  updates  to sbm leaf, even on a
>>   16CPUs per LLC system is visible in benchmark performance (~8-10%).
>>
> 
> If we leverage sbm for the wakeup path, it is a per-LLC mask, there seems to be
> no much difference from Mel Gorman's proposal of allocating per sd_share
> unsigned long idle_cpus_span[]?

Ack! But the current form is still pretty expensive. I see about a
10% overhead of just maintaining that mask which is what I'm trying
to reduce.

> The frequent update to this mask might still cause
> c2c latency within 1 LLC. A wild guess is that maybe the u8 version is more suitable,
> because it has only max-to-8 CPUs touching the mask at the same time?

With a 64B cacheline, single cacheline can contain data for up to
64 CPUs - unlike current sbm that uses first 8-bytes, this used
the whole 64 bytes.

P.S. All versions were tested with 16 CPUs per LLC on my systems.

Going from atomic u64 to plain u8 writes probably avoids an
expensive atomic path in the H/W making them faster.

> My understanding is that the major case that sbm could fit is turning the global bitmask
> into a per-LLC bitmask, because it mainly avoids CPUs on different LLC/node writing the
> same cache line frequently (nohz.idle_cpus_mask set via nohz_balance_enter_idle() on
> many CPUs, etc), which might cause a costly cache RFO event storm. Meanwhile, with sbm,
> at the reader side, _nohz_idle_balance() could start scanning from the current CPU to find
> an idle CPU, so as to avoid the costly HITM event - the reader is on LLC1, while the writer
> is on LLC0 - so maybe:
> 
> for_each_cpu_wrap(balance_cpu, nohz.idle_cpus_mask, this_cpu+1)
> 
> could start from this_cpu's LLC sibling first, rather than this_cpu + 1, because this_cpu+1
> might not always be the LLC sibling of this_cpu.

Ah! Good point. Let me see if wrapping within the bitmask leaf
first and then going out makes any difference. 

> 
> I found that in the current code, there are also other global mask:
> rd->rto_mask(mentioned by Pan Deng when running ffmpeg[1])
> rd->dlo_mask
> tick_broadcast_**mask
> maybe they can also be converted into sbm.

Ack! I was juts getting started somewhere to see if there is an
appetite for sbm :-)

> 
> [1] https://lore.kernel.org/lkml/a3207ebf537bbe5605ff5454f63b5604d83a04a0.1753076363.git.pan.deng@intel.com/
> 
> thanks,
> Chenyu 

-- 
Thanks and Regards,
Prateek

