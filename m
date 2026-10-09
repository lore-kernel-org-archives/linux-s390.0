Received: from CY7PR03CU001.outbound.protection.outlook.com (mail-westcentralusazon11010047.outbound.protection.outlook.com [40.93.198.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39FBE3A4F47;
	Fri,  9 Oct 2026 15:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.198.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791558748; cv=fail; b=ogPQ9GgK5vm/2iXt26Wjnm9KIyrl87JP6AMmVt3cOFZvKgK1ExZSL7AYt/89jy55pWfWc4/Om4xI7V05W1cHya94f9wwwkCSP1A7ci/IlcfKjIQMVHDl8GxLXGe7/joti6ekAgNYn93vevTpd/NilBNG6oD9toTR/HEwzwHJsb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791558748; c=relaxed/simple;
	bh=Kd13XS+IllmUs726NETAM+SvNho3gyNBS1N718i+SEU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=dQ+9I+tiUudBDrtXQ/D9sM2RglQaUw3QJiv7H8UGrBlEhlSYbSmdgjXiGW8FVKYBtlXlQ+MfWlZIGWfuVETxyDpuHnazKrE1xJb3a2PuRyjes5fAjBiuRb2QGBbLV3tEicgjziS7DWWD2668gT8fKz1x2oSbMEQQI2DW7AbsZcc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=P9YP7wr8; arc=fail smtp.client-ip=40.93.198.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="P9YP7wr8"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=v0R1n/yZLC9dbHmv/CJ9OJCFeUosYtJvY1vlZh4zL8jWAC1qlPXXo7SyyjXKO8/Cyk49bK7/Ba1PFe8GJrvPpX0n6mZY6tP3P391PZVbreBW+6SiFp+kfEWvVxM5KYFG1xP3Xr8Y6YLSVe1Ix15mbiRyldmQiAVo/vNkCytruayTaCa61RaWXRhT3i6524Plz1dW5+HG/UNhlmPEAfUFlsXlSrOqerVeCFScukq4n4JgD9W+k2fk57+YY1zTSJ36RqqcD8IaIGrGHDOFNdzU1VjFWNvO0o6eQLZJ/HBLXuD0pSTPhu/4Mkgs+rm+i2bGsAFMavvw+K5P/l8/rv8CFQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s8cFf4svrcpxlLMnNwcZASzpsorFHskhSLjkniJWG9c=;
 b=Jmt8DzTE5tbNpbxGqOW+UHk+0Bq7pMDW9PL/c15NEVceP77Vvs/J0f5VJ3XNzUrmnkFnvwqoaVawQzs5BN9QnwCSL+py4ibe1LsIjAotoQ0M0/7VLMhTUNnQhKFLBM4GdFLXsDOKD0xPN5DibdKWoJIyHn5uU7qY9rq8jjRyZrsR8gudJ15do1JqMA8XWd03bSyx6m9Xt6A+iSMH6qa572c5m4+O6BHMtg1gqxOnQzptYbY9ku4gCLxxfiXT/bLDTJ/xZeVUzWcXHd947mkSerJM4uRAX9oXxbFJVg8U+QqyK4bgBJmwd952hva/xFS2rqhH0ocN3mnfl27WxjEVvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=s8cFf4svrcpxlLMnNwcZASzpsorFHskhSLjkniJWG9c=;
 b=P9YP7wr8ajx/tz4U14en3YxUrfxPcY46mokH41niKHVq8qSf14DAyciYpKZB8ke4Lk0JzBG7SmDYLyasbTKPKBYpL8QbnyM8AOkgwkL/2v4NTBbVDU7J1ioOtIK8kq2Zv/927SuqFtPmnceUzOfJ3vRjkjPxFWcSNeLM581i04I+cfLNntcIJNk8hZcrzQDSd7HxRfXvigJIf1PrzEI9X8HihOoJL1Jpd2PazMTLZ+y5Vx3xrCGthKnGJxMVkGLIlCFSlv4grildXEb2doYDCbrd0YokFBPLkmon4rfGafrSbpkVHkdxjORCK9WEgirKClQzIFnF0fSCdNyl6xflpA==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA1PR12MB7344.namprd12.prod.outlook.com (2603:10b6:806:2b7::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Fri, 9 Oct
 2026 15:12:16 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Fri, 9 Oct 2026
 15:12:16 +0000
Date: Fri, 9 Oct 2026 17:12:05 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Mete Durlu <meted@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Tim Chen <tim.c.chen@linux.intel.com>,
	Chen Yu <yu.c.chen@intel.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for
 asymmetric capacity systems
Message-ID: <askERc5Xa9NhAfk_@gpd4>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4>
 <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com>
X-ClientProxiedBy: MI1P293CA0022.ITAP293.PROD.OUTLOOK.COM
 (2603:10a6:290:3::19) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA1PR12MB7344:EE_
X-MS-Office365-Filtering-Correlation-Id: 932284a5-358e-4312-f695-08df2617b419
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|7416014|366016|1800799024|18002099003|22082099003|3023799007|4143699003|11063799006|10067099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	8v0PPMPIgf59pQw1tIulNiDCih1pQR+ZywQlJfEoma1TM398FjpPbHNZhdYbchSLbgrpbZoUJ7FYkR1Kl7FFJRQjqtD28Vu5RHYFgg0E6UiFPalC644ewyGLOE71rBEDKrd/FVlxHb3IPs3eBF9sKNovkjo4Crd4Y5mi/eeAkctbDmhoDZ8BQxqjcspM2ksYqZ44BIUlqkrL/cDm54keLU5oJ9L9fk+jf7oCHHKyn953byFXxmGZ2eF5ZKhCO5fHz6/FACArF2eRZ4JaM2jEx1eO1DDMKpj2ERsfAOcLLutHEtKX/ScOCJCxqkqF4Mg0xHn/T1Kx01AXjEz1uVtffEOY0GQnCzb8mBRIvUnG+pxZV64fVj4FwepBWDOe9h2KKk9vEM74HGAOvyKUYZxLFalqLHEtWU2/RYA7iuAqfsi5rWJPUhOyEWcAnxlsrTzTPkGEk/P+0EjiNszOguTJQkU/FnT/gGLHIjHU62c1/UPvLoR+6ZBLEd7E98Pk5RkldST/p5uWaRBJVLw9DffamPoz0HdDkeFvvRePeJ2xaqMRitwx3vzC/axXRX8IBK3yK2CvbS40Qbrhlgp+zTO1FmW67/pO3E3iEJzn9STNAxlsAfD/2VK1/E6Ery+zUTWHrxNabg3JTKGJEoKSypkMlDgbkGLhaDn1zgpwSF9H6LA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(7416014)(366016)(1800799024)(18002099003)(22082099003)(3023799007)(4143699003)(11063799006)(10067099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+wb3SqGTeLCiKiOEkUveesaIbWHMPA5/6t5H6WPZhIcOukiN0BT6DU0Lw31J?=
 =?us-ascii?Q?ZfNTp5ghcj6KCgK/0n1hV93A/kgKOKDyli36oBLEreG9SRCy1bA5gx6s2lEJ?=
 =?us-ascii?Q?MNnj2umNSK+YJnQ1SagpCwDymYvXjevRZfdPrrpr69uXF5s3EnTVwoBEELlv?=
 =?us-ascii?Q?/cOm5C0Vi/desYDc6ViWZidhM+ZE3mvVbLLT/HnTScuAgBSwL13eFg33Q4AP?=
 =?us-ascii?Q?A66Uo3hf9ZsOvGY0yZXiKOeiVwkFX4PEn83rXReyI4GPuzbPXHbJzlZpg9dH?=
 =?us-ascii?Q?NYMng6ZgZQvO/NHGorgA0UQlfnQssqBvToBUtcR3Fi+Euq0IA3D7TQGypulJ?=
 =?us-ascii?Q?oSbYRQHUqedkbAHS3a6k8JQK2VnVnsZDuCNsWmZK84hFUBZ3dOXywTnHF2/k?=
 =?us-ascii?Q?igOYepE2KTyNrLd7SSK8FLLyclVszKSsKTWb2YNc8EL3YXQnO1hi7BNu2eGT?=
 =?us-ascii?Q?1ifxTfst+qW/MrMzQ1+vO9FaLzp1G4zoMqHSNANHnKQrMFpTfpa3zy1Pn8ho?=
 =?us-ascii?Q?ZT6+b4lXZIWQUuYwITjOuEjj/oj1cygCpHNlIWje4E1BayY7UJPDSJVxNEz0?=
 =?us-ascii?Q?5uRT7ZlivPG8hDZmYU8cTSg85OMl1yZfEPsO7rRw0Zdmsmr7VVQ0JdmR4c9e?=
 =?us-ascii?Q?UY+hNTQSv52kgM62uNtDLptu6Kro5SDR6jCCUP8HA6tbr34ce1MGakh81qsT?=
 =?us-ascii?Q?MTtPOt3iPALmdHjfHehiBIR2mwuqW8lvGTB27JRotrlUKBDi1Bxf3hiDIlv6?=
 =?us-ascii?Q?LxGbxZBm0PFcp4I+FiBeivZ9/ql7WUnFoAnj5AxUhI6xis11/EgJqIm6cCr0?=
 =?us-ascii?Q?JeU/cKql/U/p5zVZzCBRLY+nVyza7U5PfWy7DZ9xtZxEHiZ+mYqvvqQOf7SR?=
 =?us-ascii?Q?PE3vPSqBNWebSiCLRjKBzbXfngeOGldh1nwFra5+yCt93eNvRqw+cw1G8PI8?=
 =?us-ascii?Q?016Bw+11aso6dPWJHTlnAfLWmK98+oPzpiy74TA26z2ijAknH/tfO6c+Zoz/?=
 =?us-ascii?Q?t6xy+W/Zr+2o2ihJE3ejZk7OaU+gZbOxY/giRBijxU26DFAJWg+E05nHNBpb?=
 =?us-ascii?Q?LSOXFmKxbdpmhupebdEtjZJ1iT3nCuWaUgMoBUA5h9Fq8mFBAWwRoaSW746v?=
 =?us-ascii?Q?P2gKpKCWnbS6jC+AEv8PZotBc08aE14W6UfzXF2cvLXfb7TGOMaTBm89Ek+b?=
 =?us-ascii?Q?mbAvb2pHeDi+7xdkLtcO6Zemky7IfjWh39v+kEgZGPwz2hWIzo/uMvpbloPD?=
 =?us-ascii?Q?EPoSmk28afEV8AEUg5fXSkvdrEvbPvKhDMlUlnKqbUcrGx82Fs0AY0LRKnS6?=
 =?us-ascii?Q?oYcEJjHtHDdby+x65byBxh8vlP8ddFGNefjqib2C2wlg4Tt0ccBqDX+UQjHU?=
 =?us-ascii?Q?3rI1mvCO4Hu68iZZ4Y563kArLOUVPzdG5p54U8Po61NdjFLgaxQssizzmLm0?=
 =?us-ascii?Q?qxD8EQpFFQeLFyNJHH73h4fi/n44rCp7di5elsF4RcaYIl6q2Bqn4in9/pKq?=
 =?us-ascii?Q?H16v3V74ObFh2ZtTneDkLwFuiAepL30bpkuyzTJfyZ3nuCz/M/4XMaK38GhG?=
 =?us-ascii?Q?OvE5dZvEyVCbmMjm4G+Z7av9nH7tbzbzlSDjm7pUiLdIvPKF/VUAH3Hv2rWb?=
 =?us-ascii?Q?6IMBiKFqYU+gKVTfwZx2+ivTgsZtrhbFjYfaaSEkYuBejfWEuR1us8nDyG1F?=
 =?us-ascii?Q?eQhW2rds8MYu2/T5mi6sbKZzu03McoiwRDCsjW0ieBB2eascVDfPWhqUQzrn?=
 =?us-ascii?Q?9x8/DWg6xQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 932284a5-358e-4312-f695-08df2617b419
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Oct 2026 15:12:16.1531
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uHoHf1vR6cJ+QbUSFmnY/w7CEYhrZ7F4CqGMeDRYFBfEq9fpLF6C8OFV7RGGNues43exK0jC48Xbq/c4MOplag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7344

On Thu, Oct 08, 2026 at 09:14:49PM +0530, Shrikanth Hegde wrote:
...
> > > > That might let us preserve the general preference for fully idle SMT cores while
> > > > searching in this order: fully idle preferred cores, idle SMT threads on
> > > > preferred cores, then non-preferred cores. This current patch series seems to
> > > > drop the first distinction, allowing a partially idle preferred core to win even
> > > > when another preferred core is fully idle.
> > > > 
> > > > This would need to coexist with the steal governor's stronger use of
> > > > cpu_preferred_mask, so I'm suggesting it as a potential direction to explore
> > > > rather than a drop-in replacement.
> > 
> > I think this makes a lot of sense. An approach to first fill preferred
> > CPUs before spilling to the non-preferred cores until contention
> > forces the evacuation of non-prefered CPUs.
> 
> Well, when we see steal time, it usually means there is high contention and
> we are using more vCPUs at this moment than possible.
> So we mark them as non-preferred. Note that they are idle cpus. But non-preferred.
> 
> That means preferred CPUs may have more than 1 task. If we spill over if there
> is idle non-preferred CPUs, we will be back to square one. No?

I agree that CPUs excluded by the steal governor should remain avoided even when
all preferred CPUs are busy.

I'm wondering if we should have two levels: cpu_preferred_mask acting as a hard
affinity constraint and an entitlement-based soft affinity within that mask? The
soft affinity would prefer high-entitlement CPUs: first fully idle cores, then
idle SMT siblings. Once those CPUs are busy, tasks could spill onto
lower-entitlement CPUs still inside cpu_preferred_mask, again preferring fully
idle cores over idle SMT siblings. If all CPUs inside cpu_preferred_mask are
busy, tasks would queue there. The soft affinity would never override the
governor's restriction by spilling onto CPUs it excluded due to contention.

Thanks,
-Andrea
