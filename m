Received: from DM1PR04CU001.outbound.protection.outlook.com (mail-centralusazon11010052.outbound.protection.outlook.com [52.101.61.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8968338E8BF;
	Mon, 12 Oct 2026 02:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.61.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791771122; cv=fail; b=P6gMbHOWk+owUJFKbRduyISwlam8wrZXkalfWCglOpWi5fuJBkr/ZiCFiijb2UUJADzAz6BKNsjRvVZ5OqFxYeBGL6nDJQ6lkF62LN8AIZbynFJP2sPllLyrkaQa/i+xuthSjY8HXmBYoe6q4avFNxe++XDcIH3pEs37bZUikUw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791771122; c=relaxed/simple;
	bh=bHkB7I3ddlR1weq6t8jTGHxjxbBVAS+9FkIQZodk67I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=L7LFjE9+Q7ueas61Ec8ZGMr7WvNXBB7Dbwc0bAkFoe/AUlvZOPLfVr2H4wYbGkk5cxbpmuRLAz4PqXuUE3JvrXNGWa8wlQh+CqkRY3ipje3Ft6QHzciPx07XydrBLNdYxKSe1CuuVpMCeDqgpD48YD6Z0g/Hi6o8l4Gsdnlbez8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=DWG2/aOT; arc=fail smtp.client-ip=52.101.61.52
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="DWG2/aOT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BRO0BUyOwwHVyrfVzi8IKnw1tULvYik2EXlxuZH5kH429kCd9BnYr9yZCIxj4big3p3Lnuew+fsXy4dbqOO+85AK2I3B6qHtSSx8us/i06EfIbHKMV5a9mqncqh/Iiq4mBf9d2fLWQpUgpcqFtSluwebxRI4V/4+zxwHnNpf6DfcX7oc96s8YyqVcWpxGmylOr9D5xydl3pOEmR1ahUrq9TuB5rgiB3oRJbQ42CVwORHuYH/Dw8AOZhAcOiB5fHEvcH+/vrUnQ4ju3XBA45bO78B/mPRiEfBwnLD2ULaYduZtjk43eV3EtBUibPBEWlqQE98FssVSk+bXawaC2Pilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YBlxl2+OFlv5puE9NS7I76ORqmDZwiZJ2i+jnKrKsuk=;
 b=Mu7rD5QJSswQH3+QFzeKPuQcsEAhVp6wsaSAR1tN7FwR6QMKGzQIVUrZhi8jD7eUwbbAjoI4xTn8wQyp7I74M61fDivtIfICdtCKNsPbFcxo72seM1+RpA7XRt5VLQJfswFGOnt0qC9njsxRtIVtp8JgofvjTTQbNoTOwzRVSMDT5FjkhVbBPhsQOKpimnPX8sUO6sEoDhyNr7m6D176J/NZIWIR5skRiXkgjOb2/p8wLctX8QlcrbGBepvYSq69h6APgLbp0TZGH4i46Ub7/6sDmSHcKMAXN5BOyfQVNPaG0OKF6Id5EY+x9EY5DkCt5t2MldtsNy/UJThb/Q3GAQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YBlxl2+OFlv5puE9NS7I76ORqmDZwiZJ2i+jnKrKsuk=;
 b=DWG2/aOTla8MCbxgEG7wLDZeIYjxaZNSUkhCY+g6KHlvYj+VHnEIOnxJ9qJ9TAeiQI8oZhD0aQV/2bfrkBrT/YMO6lHmnVRDXV2fXziWJk3CYQ+OzhO5GVdQXkKvO0+CSUfynJvAeb70eA6mNnXxm23WhyMJZdyxNh8Hj0iyb40=
Received: from SJ0PR05CA0098.namprd05.prod.outlook.com (2603:10b6:a03:334::13)
 by DS2PR12MB9797.namprd12.prod.outlook.com (2603:10b6:8:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.21; Mon, 12 Oct
 2026 02:11:57 +0000
Received: from CO1PEPF000066ED.namprd05.prod.outlook.com
 (2603:10b6:a03:334:cafe::95) by SJ0PR05CA0098.outlook.office365.com
 (2603:10b6:a03:334::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Mon, 12
 Oct 2026 02:11:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CO1PEPF000066ED.mail.protection.outlook.com (10.167.249.10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Mon, 12 Oct 2026 02:11:56 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Sun, 11 Oct
 2026 21:11:50 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Sun, 11 Oct 2026 21:11:39 -0500
Message-ID: <a92f172e-7a3d-4fe5-94ae-b6768581a5c0@amd.com>
Date: Mon, 12 Oct 2026 07:41:38 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 01/13] lib/sbm: Introduce helpers for architectures
 to configure LLC properties
To: Shrikanth Hegde <sshegde@linux.ibm.com>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, WANG Xuerui
	<kernel@xen0n.name>, Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin
	<npiggin@gmail.com>, Christophe Leroy <chleroy@kernel.org>, Christian
 Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
	"H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>, Chen
 Yu <yu.c.chen@intel.com>, Tim Chen <tim.c.chen@linux.intel.com>, Ingo Molnar
	<mingo@redhat.com>, Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot
	<vincent.guittot@linaro.org>, Andrew Morton <akpm@linux-foundation.org>, Arnd
 Bergmann <arnd@arndb.de>, <linux-kernel@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-mips@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <driver-core@lists.linux.dev>, Sudeep Holla
	<sudeep.holla@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>, Danilo Krummrich <dakr@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>, Thomas Bogendoerfer
	<tsbogend@alpha.franken.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>, Madhavan
 Srinivasan <maddy@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>, Andreas Larsson
	<andreas@gaisler.com>, Thomas Gleixner <tglx@kernel.org>, Borislav Petkov
	<bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-2-kprateek.nayak@amd.com>
 <bebd59dc-9932-41fe-9fa6-4d2cc8d15080@linux.ibm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <bebd59dc-9932-41fe-9fa6-4d2cc8d15080@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PEPF000066ED:EE_|DS2PR12MB9797:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b0a118a-34f1-4874-96e7-08df2806312d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|82310400026|36860700016|1800799024|23010399003|4143699003|11063799006|56012099006|18002099003|22082099003|261009223027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	WzSP5oJTy4QBF6mz6siizBpvABBhPvG4gO7Ju9m8YjRrC5t9RzuUFlKDFExQP7TDOD5IrnvdWGdfjtlKf2Z5yfgYS/7jx0WH5yhXXwfle6Ppi3d18Xvh8hDtGIo8uD3fcy316upgDjYRUvx0h6uoBAYjF+sRvLM63oFa6Y+Re4K+JSo7ul7e7568Iy2Hkb9C5iZU2ueWSaVblDSyqEnpuevNmZ3WeR0PU1cP3RkHU2FYWCjvMHEEP5SFQhY8T/KklOqoiE8viOs3LZWalOgB1DzUvAfa7YfGfmcohRkwQHMShb2pt36GO8R49rle6FFulTwxsQgOhPeF0JmCIq4daIuuGF0jWvhA9PO2tIkCpi9I53i9nl5oJ3DS2spLoXLvdARRD4KJbbs85umIuJIYuFsPaDl21QTTyTe50Tuu/iuRBhCAvUrrWBh3cQ7TaF7bxpOCfG83eXHlCPyxH8iB/VN5QS8JwPKvvhYnmzS38npRZ9IaUDH59KG18bQygXQswy0oKpyYv+/2zlnUKZ4F2vbCJtiC5p7CH0CTEQsmP8zj/UenHu5Oh5bIiANA+RNamxwz5B7kk+QiM0qjEPcybhvuuNH59EOa7epUI1LcaY/UyVMA4fjF09AG/V4nDv7gjvzwDeZZxW7o7UJLgt4oNBsD/jlUPLBHZrM+AY0NLdqQsmr7/09VQHJBntLOyOa3Mz3TZcweKqX5S+SU8xp2eA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(82310400026)(36860700016)(1800799024)(23010399003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003)(261009223027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	u8cudUGIMWd1kdY446WXLGgLVLJBygI3oVZ4GGvHL2xooEZ7RpwVnK67ZiYHo16oFsrUqQUeEYqd2hgReUWwMhuSOK6Pi/pRcWofXkHZZKWTRl8/OLbMmQPzGIfKhouUZHVI0ryZe8S2XsfRW18hsplbSN8BRRngxvOUKG2VX6jIKbE5d7/+ybybmtFjXkHuvG2XmxVNKkmaLjEa+pfiXwXKcmyqPHX+Vd9PNNYtX2nTpcd4A1rz4r9wyhMSDsLaxPZ4GKF7KZ4whtAVfmTBCdUr9/ak35n8i0/hRwbKMaXBy6Qq++460It8XPFBkuBDTOddkRwxTiJuwUE9dcfb/15XaIILggWiGcTF1ovwEGG2CqsNAu6nntu+ap67zFhsJhCc5gPT999YrvGTTajGhKyP55BV60ETzacT7Jaobhs+CsBUnQ5kYNYPJISSeUa8
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Oct 2026 02:11:56.8563
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b0a118a-34f1-4874-96e7-08df2806312d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000066ED.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS2PR12MB9797

Hello Shrikanth,

On 10/7/2026 11:13 AM, Shrikanth Hegde wrote:
> Hi Prateek.
> 
> I ran the series on 320 CPU power11 system today.
> hackbench shows high regression across the different number of groups and
> it is more severe at lower number of groups. I haven't run anything else yet.
> 
> I haven't taken a look at the patches yet. Post your talk today will try to
> go through and see if i can spot something.

Thanks a ton for the testing. Now that I'm back, I'll take a look at
few bits again, especially stuff for optimizing traversals. 

Can you please share what does your system topology look like and what
did:

  sudo dmesg | grep sbm

say when you booted into your kernel?

>> +void __init sbm_set_topology(int num_instances, int max_threads_per_instance)
>> +{
>> +    sbm_max_threads_per_instance = max_threads_per_instance;
>> +    sbm_num_instance = num_instances;
>> +
>> +    pr_info("sbm topology set to %d instance(s) with a maximum of %d thread(s) per instance\n",
>> +        sbm_num_instance,
>> +        sbm_max_threads_per_instance);
>> +}
> 
> nit: Stray empty line at the end.

Ack! Thank you again for taking a look.

> 
>> +

-- 
Thanks and Regards,
Prateek

