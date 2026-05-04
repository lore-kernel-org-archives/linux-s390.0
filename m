Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013057.outbound.protection.outlook.com [40.93.201.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201BA333730;
	Mon,  4 May 2026 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.57
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777900757; cv=fail; b=L5xfFcQSMtvVK3sbaRjN9yfoShz88NNa4kuaTachBresWW6mJtvSpqRsfLIEsdjUc/0otwv+WpzaYY+yuXpCdmnG8DPjrCFBnugPLtApbZRv24Rm1qKHmds0q/sP5RLQIrUNmiuEAGlIo50lAUrAJdA9tFnHdTpnAhIilUvReek=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777900757; c=relaxed/simple;
	bh=5EOAN5yqg0cBhtIis2iSfzWGbcig9fOE60XiSMw8I/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=ol/DHKOwDcMniAfz1+srnw3+qp28sBg3Oo7HKCOr96QDISlf1YKAxS3hLIt1fZOZdiEYn1OWMnZobrSw49ZdPV+V46HbvmjRsLwgPXGtlegVGtf5f71mxZUaNanC75RBlXdw94ukzLhEkA8p+KS6ZVfbK9Uo4dgJ4Q6oL9NHdpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=H/MJ6yXT; arc=fail smtp.client-ip=40.93.201.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="H/MJ6yXT"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SZneXZmrGGstuXL3H9mfFuwXaWckerfn0PAMSf40Z8XxEE3wzS/hVxydjmnCmiYp10eC2iJ3Dfgs9NVLoLDBZ66GSLMtdpMB5sETvfkbP5qsgLnzDorG74ABGYgwHpHTCbiDh2SzMrcbLS4dbw8TXulK+krbuCESHVaWGfE+TgBiWFED8EyH7tUnqThDhSNzi7gTopYDnKpnHeFZ7D3dJOPfNxwC3O2Jv++ILNjs93xfeqf2lqMSVoDjNuvwm1+emBXD+nWzwFNpMUFCqYIFY9S/fae0/ugP23zfnBn1Xp0q14WNiT2c8RJAYVTSBMMT2PvHf4oP1EH3xWY4R4wYCA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b60p7ClerZ2boGbWAUStB/GhMtpVnTqBLtvd8tWQJvQ=;
 b=bN3ULJ2E1x6HkIi5mOsBTbXfQTOOKmlvsnATbfzmRWvmgZkt0szGl8I2PaJ0imXr7AtJ0zUKZR1ypFsMasQW8/M1r4pEZ/uYJfjpUxbPApF8luLYKw6UxAgnlsGJbXnx7bXmBUoe7r5ihFBRJ+laMyNtNsqUkzq7Yqlqv1mse6t26BLJ+E3yYn1D+WamUnEFLEd0UdeQ9elPjtfvqvYiez+Wa4tv9iRAjyzQENT77OUEVCxT+vsCAVv7azuHAwW59V7R4XY3CmzbgRC2BHL3n7q0rzxME3WjxEV+v3edLKgaWNGq05UmmL+2+IfEdeSQ2DMQ0RhFy6TYwUfi4oXf2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=linux.ibm.com smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b60p7ClerZ2boGbWAUStB/GhMtpVnTqBLtvd8tWQJvQ=;
 b=H/MJ6yXTfi06670numQJG+67yPGDTfvvPPSauHEQJbeQfLeYBdvrPulhDQFefJArdFh2T+5nWAJ0xXyqihrwtPk/Xjtd3N3CWKH4v0ukAt0yD9RRiAQ/nk73WrT2ZOEDMi1wRsTgw4cKx3Ww3lMUU5fTBycfiv4XlloqEvOkVDU=
Received: from BYAPR08CA0072.namprd08.prod.outlook.com (2603:10b6:a03:117::49)
 by BL3PR12MB6548.namprd12.prod.outlook.com (2603:10b6:208:38f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9870.25; Mon, 4 May
 2026 13:19:10 +0000
Received: from SJ5PEPF000001F6.namprd05.prod.outlook.com
 (2603:10b6:a03:117:cafe::9d) by BYAPR08CA0072.outlook.office365.com
 (2603:10b6:a03:117::49) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9870.25 via Frontend Transport; Mon,
 4 May 2026 13:19:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 SJ5PEPF000001F6.mail.protection.outlook.com (10.167.242.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.9891.9 via Frontend Transport; Mon, 4 May 2026 13:19:10 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 08:19:09 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.17; Mon, 4 May
 2026 08:19:09 -0500
Received: from [172.31.184.125] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.17 via Frontend
 Transport; Mon, 4 May 2026 08:19:05 -0500
Message-ID: <10282ce9-f4ae-498f-9b57-f4e1e61fffbc@amd.com>
Date: Mon, 4 May 2026 18:49:05 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] sched/core: Don't steal a proxy-exec donor
To: Vasily Gorbik <gor@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Juri Lelli <juri.lelli@redhat.com>,
	"Vincent Guittot" <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, John Stultz
	<jstultz@google.com>, Connor O'Brien <connoro@google.com>, Vineeth Pillai
	<vineethrp@google.com>, Joel Fernandes <joelagnelf@nvidia.com>,
	<linux-s390@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <c00-01.ttedd70@ub.hpns> <p01-01.g703486db8203.ttedd70@ub.hpns>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <p01-01.g703486db8203.ttedd70@ub.hpns>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001F6:EE_|BL3PR12MB6548:EE_
X-MS-Office365-Filtering-Correlation-Id: 82d9959c-9a79-43cc-1f62-08dea9dfba9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|36860700016|7416014|376014|18002099003|22082099003|56012099003;
X-Microsoft-Antispam-Message-Info:
	JsyFUOz7gQU/Dhvd+u1tVIuDoN/jgN5VsWWfZbrG4Kk4PLu4PD3N3W8NIrcz/H/gIqERVILRwRPU5cAJ4TiNkB9uZXnr6MfFLDjndp3EW5bZzVS9Wmf5WMnpnTiHuyL5hHmBEa1msT2QdqUnX9820DKCbbivmzAA+jkHYMbW4tkpjM0jtNty/oIv0EPwXYFwDNIiTjhoWj/8fLaY51himo93XNb+kJQn5TIPbLSr34uU80480OHlksN7mqmLdbB1MjlLSfF7npz51h9OsdOy0+TPFIbRiRm1I9MLno44qEFuUhBMRvHBU0PhgCUYbG2AoYKTygM9K4A7BPqlbX4Z0dNw4GD9MxT6vrB598PXD98EtjzQGVQ5vscU3wGPLY4Qhn93fDKGG+lMpKFQByHQdPtw6G9spsnHWuxrW+czC/Qna+FHJYTb4zCkuF2hB7STNCqXM1jqNZEJYqp629mg41sqBiGRJJYsEvztmickLDthEzjTHVqa0K1PjC6nYnVr9b7EdzvSvCWEv84NP9IdXkoSoFdq4XWuhfUkFWViCx33NfHMER/Eclzc4xNs2a7KptwXZ6fixIbL/PTtGzmVwluOZYydBy4+LWdZuM0dPP9QZ1VxiCCORuQrF0gMP13tiKg5HvMfrMo1LAy9mmXb4mQwPER0GpGO6HhdL0LHT8LTiiyQiRoJdtMiRfzfz7Iw5ktF60sFrQisvNCqwW+NIJ8syITH9IlzfgIijqrJKGI=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(36860700016)(7416014)(376014)(18002099003)(22082099003)(56012099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	XUsYPUumalcnYyTNBKuRU+Y+bAbx6KSBeOCeLOUKkUYx468T0TwznYMizkuys6VIOtIza3HhqwA6OO6RlgaKdEf+7eUyC6qUncoEnb7KTv9sLdUUGcYfzpJ2Ihvvnh3TY1m/IH0xaSGI3sGwtgofuXCnrirHW1Ezma5pgHA28fMnz1RlerRcG/OycyQIZA69o5rE05qEVVycDnGk1EQ2eUZlL3b6VXy6E0C4O6lwuaNyK1eeWI4FRy2m08f3kVBEvWAQFUhdbxysYOP2b257wZS8yrtbDfEqqbEDfTRwjqkziVDPB8co1QICv50q4xtHtuQnfJp8MpEVsJtWTSyVcYwP/KvRgQmIwrH2dzW9/lHEsuSSL6S63eZu1gzczsck7sHLZWUTFZlrhNWJnW12G004RfkqkXiap+9eZ9az6NaCsO5eqi4m+0+uoryLgzRj
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 May 2026 13:19:10.5495
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 82d9959c-9a79-43cc-1f62-08dea9dfba9d
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SJ5PEPF000001F6.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR12MB6548

Hello Vasily,

On 5/4/2026 6:01 PM, Vasily Gorbik wrote:
> try_steal_cookie() avoids stealing src->core_pick and src->curr before
> moving a task with the same cookie via move_queued_task_locked().
> 
> With proxy-exec, src->donor is the current scheduling context and may
> differ from src->curr. Stealing it migrates a task that the source rq
> still treats as current. For CFS, src cfs_rq->curr is left pointing
> at the stolen entity and the next pick on src hits the WARN_ON_ONCE
> in put_prev_entity().
> 
> Commit 7de9d4f94638 ("sched: Start blocked_on chain processing in
> find_proxy_task()") tweaked the fair class logic so that the donor task
> isn't migrated away while running the proxy. Do it similarly for
> try_steal_cookie() and skip src->donor as well.
> 
> Fixes: 7de9d4f94638 ("sched: Start blocked_on chain processing in find_proxy_task()")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  kernel/sched/core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index b8871449d3c6..3cf5fb70814c 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -6358,7 +6358,7 @@ static bool try_steal_cookie(int this, int that)
>  		return false;
>  
>  	do {
> -		if (p == src->core_pick || p == src->curr)
> +		if (p == src->core_pick || p == src->curr || p == src->donor)

Although this solves the issue of stealing the donor, I'm a bit
skeptical if proxy exec even works with core scheduling at all since
__schedule() can override the decision of core_pick and the CPU
may end up running a task with different core-cookie if it found
the core_pick to be blocked on a mutex :-(

>  			goto next;
>  
>  		if (!is_cpu_allowed(p, this))

-- 
Thanks and Regards,
Prateek

