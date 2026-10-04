Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013013.outbound.protection.outlook.com [40.107.201.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8546F3B6BF4;
	Sun,  4 Oct 2026 06:17:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791094634; cv=fail; b=LHD0Yekvb2ISPNriYN5myblE6p6JneOz0wVCiW3UlkSUsLLygZJHdMoanIK/u8uhr/TJ5Rg4BPu6hNyYdKwdOpBWzk8NebbST9C3Le7Sxh6cUpJqygVf/ph4SMy+cyK2a09iepcuzesipq5bNZ70lbjvnS9SE4p9CUEqNVrqT+0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791094634; c=relaxed/simple;
	bh=vnYrxwZegkDAHKKXxWdFHxNd34svS8aPUUHzPaSgDG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=LEvlD+haOPXo3TwyR5beDd20DuKvQUC/is+ZmYGQSj6QOnV/kwdw9eOUessux4ZNyjNOLgAKqxHSICHLxnfqhbcxmO7hjcgFh61pEoQRhDYSSZuBKLXLEtu4cO5NmEELvVqC/0qIfHJUrxfwOyqPPfzzLAKeKX2QM+rB2nCDE7A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0+QJ61+u; arc=fail smtp.client-ip=40.107.201.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0+QJ61+u"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=mYuY6iYmiS/NQLJxKOWQa7rQLGfSR+8x463KKc/zBP69fbPSQs+obqeO5cmoEO0vlWleawjwgW8cVVgYTgp9T11csjxsF3DZpLpxS7PFkzEfVY7OyiThX8Zgf9NeGQBx/Ug1I0peMjQ9cLXxCCB3eNlCwS0XQ4t2mJr1oc8PGuZn8J81p7Ke9QUMZOijVjNgOZ5zuMsSmkXX/ZWN3laFNgg1zeBrUxSX44diMV2v7fMVEOGW72Cxhw7SUYlraT+KA3wL/gVWkRPYX4KiTKG0pF18CUfk6naG8Ae3UueUDAKJJG10epvn2W2aNGuWH+gx3/pZ4kIHkjjnYtePvG3x4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ku8CI7n4fain/wPasM8PBLT2hTEvR9BKwe1pCJJTKL8=;
 b=h75BBEaIxV7ML2F0T44sVycDVXJ+tkJFC9qUbhQQWUgx3hg5OWM8dzyeYgJCy9oVER//nAzumrh4FNOceFHt0+GBR1q0lqsp3ME1/O1cvbdS+7xXAtRm84Aa6H3RcQYRRZFPL+sB3thLHGQBim9AuZOka3/JUNjfIphIEY6K0ToAfpFliGM5hSxW53twrPve+rYWW0hOIfbmu0nhr4dBpdovByr6pQdJByNRVhPA02+rJSU25Plf+eXu3vFlWBdq0AJs1aKZ5/GM+bCApmW1bUQLSRsFU1rJ5uuNjIHZZPsWjEj00cQK4/SWNPaQ7bEwe6ZtXyKJJ4/8Me09Akt9xQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.dev smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Ku8CI7n4fain/wPasM8PBLT2hTEvR9BKwe1pCJJTKL8=;
 b=0+QJ61+upzSwSWep/+tRpPqO/jCB5HN1HYNcl3Zs2ZOV+dCAt/161fQAJt36OTV9GFsrY8QNVgDeNVsbT/XdUwW+HuSPA/sFIATCnglwg67eE0pJPgyeR3MePVRhZHsCvmeFqMHGpFZtV9vPmA0ROII9H1ns84FHqJ+RMey02TY=
Received: from CH0PR04CA0116.namprd04.prod.outlook.com (2603:10b6:610:75::31)
 by CH4PR12MB026689.namprd12.prod.outlook.com (2603:10b6:610:506::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.472.20; Sun, 4 Oct
 2026 06:17:07 +0000
Received: from CH1PEPF0000A349.namprd04.prod.outlook.com
 (2603:10b6:610:75:cafe::23) by CH0PR04CA0116.outlook.office365.com
 (2603:10b6:610:75::31) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Sun, 4
 Oct 2026 06:17:07 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 CH1PEPF0000A349.mail.protection.outlook.com (10.167.244.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.472.14 via Frontend Transport; Sun, 4 Oct 2026 06:17:07 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Sun, 4 Oct
 2026 01:17:07 -0500
Received: from [172.30.0.12] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.49 via Frontend
 Transport; Sun, 4 Oct 2026 01:17:04 -0500
Message-ID: <aec728b2-b8f6-40e9-900a-0e16fc3524ce@amd.com>
Date: Sun, 4 Oct 2026 11:47:02 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 09/13] x86/cpu/topology: Initialize sbm topology
 after topology parsing
To: Chen Yu <chen.yu@linux.dev>
CC: Peter Zijlstra <peterz@infradead.org>, Chen Yu <yu.c.chen@intel.com>, Tim
 Chen <tim.c.chen@linux.intel.com>, Ingo Molnar <mingo@redhat.com>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, Andrew
 Morton <akpm@linux-foundation.org>, Arnd Bergmann <arnd@arndb.de>,
	<linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-s390@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
	<linux-mips@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<driver-core@lists.linux.dev>, Thomas Gleixner <tglx@kernel.org>, Borislav
 Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
	<x86@kernel.org>, Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Shrikanth Hegde
	<sshegde@linux.ibm.com>, "H. Peter Anvin" <hpa@zytor.com>
References: <20261001192849.74788-1-kprateek.nayak@amd.com>
 <20261001192849.74788-10-kprateek.nayak@amd.com>
 <asC8bgvYsVkkcVlO@three-body>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <asC8bgvYsVkkcVlO@three-body>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH1PEPF0000A349:EE_|CH4PR12MB026689:EE_
X-MS-Office365-Filtering-Correlation-Id: d707e28a-ea2c-43d5-b4bb-08df21df1e24
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|376014|7416014|1800799024|36860700016|22082099003|18002099003|10067099003|13003099007|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	FctTICb4hkLVQL8lNHUMe8SYsHrgUgn/85QYDHI6/UOs0CslYog24vcBxQRMMGt69Hwr856XIhheiWTtzHYfuMXpNNLpTTcmGVQr/pfIKzisu7iefj7dKXgAwqYhlql7vcpwMdPqCuieA1QxmhRbKl72BMSTSfeeVV63ub9kyWbgnDBbvngT1WahYvD7sF9oIabALvf71ipVeQtqgYBXlCrL84ZdISeB7dqym1LlTbXiwls68frEEJMlqO1kd12DQyZlcDOyzrBNhRpOB0XJps+v2kf0OGMiFDnfOaUFapBn55XIB6hypAgUAy27+PiGA1tODILHbkJvrHVitO/YlYuW8Aq1/vqmDPB6D4eYIYr0+ODIu1C2KhQkRrs9ZT+AX5WQNfvpuBabKRLA9hMIQIQ8dsdM0XzGJ2LoceOB2kjj2Ty4O52Usw5SZhyPMyI89DgDjSUzjXM4bIxz3npuxfJGpWXp74selmb+d03wyw7RVGtfvR5HnIAPUFvSrAeLmhYfXl6Zv1Nn5awbAbruLc5Ta9NoVdGH9ia9Vwuk784PSJ07snryiCtgPtB/F0wA40Dx+c9L2agithIp0hlHkaCPBNWo//VcSm4lSkQP4ajgelUmjkrFX1DKn2hLFm7KeHfzx3TSP5Oy6AmGuy3dftOJ8WnzNSXkNWjLbXB1jGU2F5I1M2OBCGbBYVQks6MBauhFzwEVaphn5yksKk/CQg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(376014)(7416014)(1800799024)(36860700016)(22082099003)(18002099003)(10067099003)(13003099007)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FdAZv9hSsL4UJyE9LfkOJebz6PdP5XcXzBl/DkMMjvhgMLedr1DXM7TPdgS6ySgaVOAN/Xr9ufVRrlgkuUaJSDHYCdAIZHBcK/W/N5ioSoVNE3xDyCdV6fYHLNtE+Em1UeZcLHfnwUvMPVv9NC27dTLi0UoAK5/XCOLTG7XpvBufZn/dkvt6ibnB1/oe1JLg3OBBBg8UdH3Kgirg+Jb0gcfIFbf0FCJ0MSHvpe0S5TwoHOdggRsgI8Kdoxjl720JpSGYdgZdanjSOUtIVMCzCykRB3L4VSrw2S/bxxInliTtpjHYJsgPWQLaeN/xTnzeGLvYWZMmP+ZLNvAyogf5YRv4ZpZyzouAHLeG+Yd8NXWKYtj8gnDFXNlKfcp0FsffEwFpfcJbEngiIA7LDIK+zSH/9qZPxGxdFqVzP+1mZaz/qW0VItH4rjJyLxMsYe0t
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Oct 2026 06:17:07.6415
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d707e28a-ea2c-43d5-b4bb-08df21df1e24
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH1PEPF0000A349.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH4PR12MB026689

Hello Chenyu,

On 10/3/2026 1:57 PM, Chen Yu wrote:
> Hello Prateek,
> 
> On Thu, Oct 01, 2026 at 07:28:45PM +0000, K Prateek Nayak wrote:
> 
> [ snip ]
> 
>> +static __init void init_sbm_topology(u32 max_apicid)
>> +{
>> +	u32 sbm_shift = x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1;
> 
> As sashiko reported, and also mentioned here:
> https://lore.kernel.org/lkml/20260510155920.2587431-2-yu.c.chen@intel.com/
> Maybe x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN - 1] ?

Ack!

I was testing this on a 2CCX (TILE) = 1 CCD (DIE) machine and I
failed to notice my mistake since:

  x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1

and

  x86_topo_system.dom_shifts[TOPO_DIE_DOMAIN] - 1

were the same.

> 
>> +	int num_sbm_instances, max_threads_per_instance;
>> +
>> +	/*
>> +	 * On Intel systems, memory controllers are present at TOPO_DIE_DOMAIN.
>> +	 * On newer AMD and Hygon systems, LLC is at TOPO_TILE_DOMAIN so use
>> +	 * that instead.
>> +	 */
>> +	if (boot_cpu_data.x86_vendor == X86_VENDOR_AMD ||
>> +	    boot_cpu_data.x86_vendor == X86_VENDOR_HYGON)
>> +		sbm_shift = x86_topo_system.dom_shifts[TOPO_TILE_DOMAIN] - 1;
> 
> Ditto.

Thank you! Will make sure I pull a VM with weird topology next time
during my testing to see if everything is correct.

-- 
Thanks and Regards,
Prateek

