Received: from CO1PR03CU002.outbound.protection.outlook.com (mail-westus2azon11010034.outbound.protection.outlook.com [52.101.46.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39A4D12B94;
	Fri, 16 Oct 2026 05:14:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.46.34
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792127642; cv=fail; b=qGqCL9qmF2NlhSmsAtLg9WUUVpira1YJFtnJIMRLNerA9LDLSNqh9i7kb5t94OjhVZmMunS+oRRbJksGe9u1p+DU1BYFa4CaAe9zHPZqxRy4tsqrax0zz9hAiIqElIzu5NQbLKUI5pZLZAaqyOM/11nxd+rbUxvzXfgaBlxjTe4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792127642; c=relaxed/simple;
	bh=PdCCSsGJWK1pMRQKg/ykfW/X0elUEr173YFOYIsN9dg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=fcVUvF5tmcKACsn7BrlKY8VJtTNAwifRD/8BdzHzjQZuyYtZy6UkDWEjupnGNhfX5QtwtkPDOm3r7hugxJIXkcShkktpBy/HuMkbWJPaqy+M+zXX4cIa608XYfQ1C2PsLSKSSMIQzC7tFIMjjUjVtoqlODBZSjRa+GmQvK2I/JA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=2s38Nen4; arc=fail smtp.client-ip=52.101.46.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="2s38Nen4"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=nZWjmSqZa10ohE1nh6lef2E75fEbL+CkyX1LPIufRShIeUaNHMxYjvrlBQYYe2Tl1YpZCh4pfWhRilHSvur0XQSrVY8dpSn7iX6FNuEcrpKPrH9Qv8SeiFG3N7hhtDYosgA30ApPeWPq+ClL9ThjLb5a760P5y9ZBWMEoOGTvvgkYg73ovdBngnOMorBAf/ZSOfQsux1Bt34tkZVyBuUP8pVCnE7JvsY0lGTlE7lKt+B/4kxE1nrlTlxMA3vfYn4iv2256ov3VybuU7UjCJ9qp5A4STdpvzfopqbz0zPCL/QIRPNt//ZmqhvAHDoi6NfURvf5kbOwi2/td8DLxhCUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFMqxUntDVfo8rrLcinoMWYMsfMbUZbwdbriiwpUiy0=;
 b=IKCAqMLEVbtmLiEvmmlNRcX+mZ1Lz46hRILDs2d6Pbmz9Jyjum3Gld99VhubN5b3NvSyOjG7cSRvagZ+t6R+PnFkaLb/nqWqbSPSdpi7ClgaRGAJtfMzQACGZX49YG5P5q0SX9ZPgQI+gmzTCBlml41KvGDuP1K8SPj6SS4xn2R+IJuDj7THzRrxbG0zThYGLOtE9Qug/CWByAt8t3iRJlvxxxhH5b2aN/BGYUY/dA4A/iumcagHY4UONUCpyNk0KvzXVBVgS4B7UcZTfDUCHqA0FIzeuHIQy1NrmnX/oBzQq4i+NkI+zazJ73bHuu/VH60RhNTiNpWe9+kaOinBrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=arm.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFMqxUntDVfo8rrLcinoMWYMsfMbUZbwdbriiwpUiy0=;
 b=2s38Nen4fuVXVtkKycH2T3lZr71/vlgy2euKTuwyOS0z0xMKlklUgrwwahd3pjvMX8CLP41njUsdOH7BCj0D+oRFG0RtIuh8M3InHFgMYSA6CLM9W5sR1nfJ6YYlUMYCK2q1jn+6lMn0JpVC/OKoBL7T5AwN0HodnaSEr6BMkiw=
Received: from BN9PR03CA0777.namprd03.prod.outlook.com (2603:10b6:408:13a::32)
 by SA1PR12MB8600.namprd12.prod.outlook.com (2603:10b6:806:257::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Fri, 16 Oct
 2026 05:13:55 +0000
Received: from MN7PEPF0000014B.namprd04.prod.outlook.com
 (2603:10b6:408:13a:cafe::9d) by BN9PR03CA0777.outlook.office365.com
 (2603:10b6:408:13a::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.17 via Frontend Transport; Fri,
 16 Oct 2026 05:13:55 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb08.amd.com; pr=C
Received: from satlexmb08.amd.com (165.204.84.17) by
 MN7PEPF0000014B.mail.protection.outlook.com (10.167.254.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 05:13:54 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 00:13:48 -0500
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Fri, 16 Oct
 2026 00:13:48 -0500
Received: from [10.136.45.168] (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.53 via Frontend
 Transport; Fri, 16 Oct 2026 00:13:43 -0500
Message-ID: <b1981a19-f28e-4ccb-b17b-eb5e835485dc@amd.com>
Date: Fri, 16 Oct 2026 10:43:42 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] sched: Replace nr_iowait_cpu() with a bool accessor
To: Christian Loehle <christian.loehle@arm.com>, Ingo Molnar
	<mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Juri Lelli
	<juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>
CC: Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt
	<rostedt@goodmis.org>, Ben Segall <bsegall@google.com>, Mel Gorman
	<mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, <linux-s390@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <cocci@inria.fr>
References: <20261015083317.3733733-1-christian.loehle@arm.com>
Content-Language: en-US
From: K Prateek Nayak <kprateek.nayak@amd.com>
In-Reply-To: <20261015083317.3733733-1-christian.loehle@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN7PEPF0000014B:EE_|SA1PR12MB8600:EE_
X-MS-Office365-Filtering-Correlation-Id: 54f8f4f8-387b-44d6-76cd-08df2b44467a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|7416014|23010399003|82310400026|36860700016|11063799006|56012099006|261009223027099003|22082099003|10067099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	T8vtwa1BNwE7nnLfaLtYgmLVsFc2JlZf33qLYwb1lCjlvkPPzM9IJdRArIUjdVth/hGHWIVPCLhvrjeMcWXa2uUkdHStJT1ZL0bIFif0E6KppPNmm5tL8yqmM8pDwdkEVjJz7zWZVGoBk+tcRq2W60ErFq8FQ7b8owVBCY9ywoUD0RhlxpsJZO8sR7f44vn+FsFbTZV1PYWG1icA5vvF7MfQCafH8BH2ltBl7tvtOoESrjeff+hvLuUzjVhUgjzdaR1RJqW2tOkq8uHvxjh7S26QdFttj0Z/cLXQOITorRil+e8TJ1jwevuGmgHVN+vp7HfH6TLqdFYJU5KZ595GM8n6EHveRygF0rxwHA9us1afTWW5uhFApWId75g2b5FpamO4G2BCKqAtaoCYkEr09XXmJfd9E8oHZvRwz6pJzk0eQMqt7Ny1amt2o3KCl+njAfH7L3I7pRPLw0T1J1YeSLulTP7zFUxnHflAxsIaa0pvwnm+whZRjR9tA5d0P5n64AzkwFSA+5MzrZbZyrC5AguAFu+xDDmDeEnYel7Z91objodelRlAyFIt8g0ebstZB0/QZV4wihiav1sHxZdUvm3jxLmQ3chcZ3WMCs4oD9RA120hv/r9SeblgXkM4biT/Y02vYv+/bjeIhK15Dr8hEL+SbXVjkhq39OKK/Qzds7YXM3IgcyoQma8Oto+qJQf2j2vD8b6rgweB5tvpSiMCA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb08.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(7416014)(23010399003)(82310400026)(36860700016)(11063799006)(56012099006)(261009223027099003)(22082099003)(10067099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VQx7vR/t2Tygw823fK7vwDgNCugsSZtVtSMLo6XM65fodW9PAcGDfCbkmQ+fE437b6W6CJGuvBHlkLE5WtAEHvMobrmwjhEGGNwmpCjgIJosWkV/DWi+GNX1U5LhwMcu0mmtk+X/IJFF2rtWZ0XeMB1U9Leg5ukenoAjbSHmB3MemwX9Uo2w1ENBqTNVQE/iee+vCfpT8G+XTqwQJcZamcH7g9uYy9/nFZ+ES6yGJR0bk2e/JkZbpuF9cDgufRP1mKUpQgMCIRkc4lF3KutR3QVbRc9KO9I4W33APcXGtSlQCMHnaxTv4JlSPvEJGhxmLcH7QGPO+bn9J+ayYYX5U9IwncLEVwLfATyCiLOTZ13pkpIy6iau4CsRrPMsR0Mf/GDN/KAH2heLoejNJw7K2rmXBCnynS9Q5sBA0FqAlHrHH8NPxuDeE1hg29DM9gNa
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 05:13:54.9667
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 54f8f4f8-387b-44d6-76cd-08df2b44467a
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb08.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MN7PEPF0000014B.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB8600

Hello Chris,

On 10/15/2026 2:03 PM, Christian Loehle wrote:
> The menu governor was the last consumer of the per-CPU I/O-wait count
> that needed its magnitude, apart from nr_iowait() summing it globally.
> Commit 38f83090f515 ("cpuidle: menu: Remove iowait influence") removed
> that use. All remaining per-CPU consumers only test for zero/nonzero.
> 
> Replace nr_iowait_cpu() with bool cpu_has_iowait() and update the generic
> and s390 idle accounting callers. Have nr_iowait() read the counters
> directly so that the global total and existing accounting are preserved.
> Replace the stale menu comment with a description of the predicate.
> 
> The conversion was done with coccinelle:
> 
> @ predicate depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu) > 0
> + cpu_has_iowait(cpu)
> 
> @ callers depends on patch @
> expression cpu;
> @@
> 
> - nr_iowait_cpu(cpu)
> + cpu_has_iowait(cpu)

I think few more of the open-coded checks for cpu_has_iowait()
can also be converted to use this wrapper which makes some of
them a tad bit more cleaner IMO:

diff --git a/kernel/sched/cputime.c b/kernel/sched/cputime.c
index 1f3a9c1dc853..e9c9fbfb0269 100644
--- a/kernel/sched/cputime.c
+++ b/kernel/sched/cputime.c
@@ -226,9 +226,8 @@ void account_steal_time(u64 cputime)
 void account_idle_time(u64 cputime)
 {
 	u64 *cpustat = kcpustat_this_cpu->cpustat;
-	struct rq *rq = this_rq();
 
-	if (atomic_read(&rq->nr_iowait) > 0)
+	if (cpu_has_iowait(smp_processor_id()))
 		cpustat[CPUTIME_IOWAIT] += cputime;
 	else
 		cpustat[CPUTIME_IDLE] += cputime;
@@ -1109,7 +1108,6 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				int cpu, u64 *val)
 {
 	struct vtime *vtime = &tsk->vtime;
-	struct rq *rq = cpu_rq(cpu);
 	unsigned int seq;
 
 	do {
@@ -1152,11 +1150,11 @@ static int kcpustat_field_vtime(u64 *cpustat,
 				*val += vtime->gtime + vtime_delta(vtime);
 			break;
 		case CPUTIME_IDLE:
-			if (state == VTIME_IDLE && !atomic_read(&rq->nr_iowait))
+			if (state == VTIME_IDLE && !cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		case CPUTIME_IOWAIT:
-			if (state == VTIME_IDLE && atomic_read(&rq->nr_iowait) > 0)
+			if (state == VTIME_IDLE && cpu_has_iowait(cpu))
 				*val += vtime_delta(vtime);
 			break;
 		default:
@@ -1251,7 +1249,7 @@ static int kcpustat_cpu_fetch_vtime(struct kernel_cpustat *dst,
 			}
 			break;
 		case VTIME_IDLE:
-			if (atomic_read(&cpu_rq(cpu)->nr_iowait) > 0)
+			if (cpu_has_iowait(cpu))
 				cpustat[CPUTIME_IOWAIT] += delta;
 			else
 				cpustat[CPUTIME_IDLE] += delta;
---

Thoughts?

> 
> Signed-off-by: Christian Loehle <christian.loehle@arm.com>

Feel free to include:

Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>

-- 
Thanks and Regards,
Prateek

