Received: from SA9PR02CU001.outbound.protection.outlook.com (mail-southcentralusazon11013020.outbound.protection.outlook.com [40.93.196.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0103B46C4AA;
	Thu,  8 Oct 2026 12:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.196.20
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791461585; cv=fail; b=ugTqeaP5XQreCruaX+2A5+Hc4RAh4hkSA6jJGEHmT/GA/aKMWyJuvsIkBOD/orHsc2NT7OvvoqF5GKk4eYRVXcyvSsIvjeyjUIu2Yc/ONUrsoVRGqqzL/99l3yqMIKECgqLgxm8TskM4+NMUwMmwiTtcf5/7wRnTbsrMSoenX+A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791461585; c=relaxed/simple;
	bh=tgnFCK51/6qFB29EuWN7iOtbqttAgBtxA6yNguPpstk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B3tz19Hsx5ZXWghFGzUSCPXvvRtVNDhKLZjTWCki2FLcKZbtRsuHcPkh+PXe4p+joWUx3Tk9cso1SSFbcpDVkFGa3BB8hImAr5ka3Fs/mn//HbqoNRZX1cMAbuyxbCsxCadBQVJzoNp7nS+AI0ev3xyZvdQHHRUcm1tI+nXgL/A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=OnNwtVV2; arc=fail smtp.client-ip=40.93.196.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="OnNwtVV2"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=DU73b9zNipkoPCEzmwGlzWcIZDVttjqVSSg1kG1+xiSGHDUPEnXd616ACV63fe9jZac5FZJqYC72EPHL2w0Y+Cs+VrlL+M2ys7kmPCu20Zk2jUyfbAnaq2c/AaTciyJUZJA0OhOr9XjCm2R+lHpDMOXdi6jb95xLG81g/mZZQ2o6vmys7GM4m75Nn9k/TeNtp5p+mD0LyT9+dDIa1UpmO9nd5hlulWNLwXdL+rhcmDt71af/9/R8baRiXCuCzesOKtnCnPqcP5YKk3Z0QOY9cnN2ajUa/v5Z1xI8sdYsMWBpYo1r/HdAx9H1dx8l/6kUpiZjxWqMS9rs37Jwr/9jxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XPVSwjHbAzazOpX1LuNSk8LgraHLFpH7IylsEqLXhFE=;
 b=FWfBZ1vPrZBqHepRWDQG0iivdgPs7OFX4NsV3xM043af1/mNLBJ/ShMT/y5zQp8axqmzZ7Oz70AanddkLKGRWthujz3E8anJuGvhO50oh3NAvRgnZPW5JktaJPTOv/pOJxllYWCysBME85vCpAKznKByDDoVmGostMmPiWhmgRicf3pQwpp4RjTsnIyJnIbdJb3ybHs90/sjML0fmpu6fi/OD1A5snU7THZbs6uv5Cb4SCTZsl8OJDIfHIdK2CwaG0deQEzIkubq9G9wCX7z7O0v1V9q95rjhBYLESZcLWMRV164cRNURiznBA2+1fJU0hpDSgCfU4DcL8eaxgeADw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XPVSwjHbAzazOpX1LuNSk8LgraHLFpH7IylsEqLXhFE=;
 b=OnNwtVV2vFAA4jz6wYnc3R2ATwz18C2OWTVNylcm7bmyHEsg9gJGHSsQEUXy4qX4z+FZRZrwkHmLRb1nar/PIRhrjCWDcwEjjrGiNT9zOEyaxRWRZydkJXIN8wxoG854eP9FJJZKXOvEnWyKAITaEm4iQuflEqplrnTb37l4gMJ0iNAJULs3FDPTtQFLVGaJQYaIPFgCnrF06eN2mzStThvPu8btst6sAz7YNexNnd1SFOKXVqxwotKxr45NZ5fTsfU/XqJ8VAh3dPoXGD37602PdrG7j8Tml8zWJA5B5dN3Y1mVM+428lD1MV7LU6rf3ZdIN+6oe7VNenMJ4skJqQ==
Authentication-Results: mx.microsoft.com 1; dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL1PR12MB5174.namprd12.prod.outlook.com (2603:10b6:208:31c::19)
 by SA5PPF3C36BFCB5.namprd12.prod.outlook.com (2603:10b6:80f:fc04::8c7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.451.18; Thu, 8 Oct
 2026 12:12:59 +0000
Received: from BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9]) by BL1PR12MB5174.namprd12.prod.outlook.com
 ([fe80::58de:822b:868:96e9%6]) with mapi id 15.21.0496.015; Thu, 8 Oct 2026
 12:12:59 +0000
Date: Thu, 8 Oct 2026 14:10:38 +0200
From: Andrea Righi <arighi@nvidia.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Shrikanth Hegde <sshegde@linux.ibm.com>,
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
Message-ID: <aseIPhrDGCYFtJNE@gpd4>
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
X-ClientProxiedBy: VIVP296CA0014.AUTP296.PROD.OUTLOOK.COM
 (2603:10a6:800:357::10) To BL1PR12MB5174.namprd12.prod.outlook.com
 (2603:10b6:208:31c::19)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5174:EE_|SA5PPF3C36BFCB5:EE_
X-MS-Office365-Filtering-Correlation-Id: f1b0d07a-6dd8-4340-f312-08df25357e39
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|366016|1800799024|376014|7416014|10067099003|56012099006|11063799006|3023799007|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	rXV/duYfxtUzBCWKqUokH3QvbHzxfEG4IZYZAjdAIHZ4f5mavEom806ZrRPl0peGbyLKuMmj9QFHb0cOD6hsYZiHfc6W5M6TlygQ6O+WcOvDYxAoyEcnWADpIg5QIlnORT+bDRa9Ut+pZjEZ3ffxs+db6Aj5C3EDsvpbo8rHBZcRzhlXFWHqTD5FBQj9wGe4zm0xfxMsgT/KZSOpdsO5mvdLWUUYjxBtcNOecg67EqIxzenNrKyRx72UxBFUtv79ghzJN6ylU2Hzqf2umU+ZOaLlTfHkwNeM6YnE1CLNqOGzz/DfP30xp74cJOR6qyoxtabxvJKgkxnun9F3wYWFqfA0gKVtDMuVQp5LIT7ba5MaZUP4Yh5pW4C8E021Wthmion9U12ix3DYaGfoWeYlilDiN7j6dtZxiA6KllQxvnpymmtx0gIaUw6pt642XB/uyiJI0U904bkh5KPKaUNNqsJVEptw414mEoC/Jmqov4grqVQbwEm+T5xu2tHb0HS6APMgOcuAFjV1vcQYHOu+n9RhoA9ckAHnSXdoDHLyWA4usa6z6JRPLxK3b/F7t73fM7UQ/JCYhBTocafWNFlR8vtmC0GrOaJcJ+Ty/lHiRvQwc+2QKnKJo8/4alX7OiAseNzUVhP8IyFe+pOBBnO5pxILt1snVIleuZuXE17Voko=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5174.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(366016)(1800799024)(376014)(7416014)(10067099003)(56012099006)(11063799006)(3023799007)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?qPqcFsab8eLJoDCEXl+3kA5qEz5YePUrRVSz+1L50AxPC8vQbjASE0UprJRW?=
 =?us-ascii?Q?ic7KeHVLMqmOW8ddYxFWkmZdgtBDQkBqW6sEqBUprjBMViE6IR+SX+ukhwzK?=
 =?us-ascii?Q?sX6L1OmkV18FAMOGlPjhjJbs2zIkZe3C9wUEI62Y7N6OWJZRLE4UeZ412Rm0?=
 =?us-ascii?Q?MdVbLWWORRPtY82uplywCg4CZH7Gvr6NuG+FyMQYjITB7mu4fI0O3k9NbVz5?=
 =?us-ascii?Q?fnnafts0hl85yNPmVmK2C6QLBoTr53tXEzpq/Hybptb0b6aiBh/I0S4XatI8?=
 =?us-ascii?Q?Fd+xtwqHFxQr/M9j5UDosfYfMq2QXNXCZLuw55Pk5T+G6Fs8uPMXpYeq6bHP?=
 =?us-ascii?Q?oiy85jk9au5axEziQdN2Zr0/pOeUOy4GHVbe2IJsE6D16zZqiltD00C7ocuK?=
 =?us-ascii?Q?rzZglNlHV4wEe6pdZy7rmdXEMEQolC3aL6mI7ZjfbcGE+3LUm23zVkILoNBY?=
 =?us-ascii?Q?E+OzL42pQZtTQZMjyMiezQW2YqTwt3eQKjlNTJjNNGZLK8Qzed1tTBB9Lqi+?=
 =?us-ascii?Q?G+HQIJoPF4FAdQxgrG9TkFUu0U0081oVRaVv8CruM0mPrq346G1U8LxKkDIz?=
 =?us-ascii?Q?d8B0V0/Mw6fo5R1Y1gWKnXhRH98TcohpOKIIBNKxmMQNGq0zHTiq1E/C8wyG?=
 =?us-ascii?Q?dwczBsp3ZDAxO0EKheKOeIbfyfMxudrQd1FhnQ1YYr8HEQHqUHIggWJ+EY0m?=
 =?us-ascii?Q?cgInrQJWCstVAEqWU5Uc2uqyhNRjo46FbfpPivCF+OzS6WxGRVo5dK1vRFCu?=
 =?us-ascii?Q?nTKj/XmgnKWTGxbuCDOCl/xmyo6T6FYtrzkHCfEIcDUwcsuXwpIKhwb9onGt?=
 =?us-ascii?Q?cZe46/e5e26BXC7kpNZPLvOCRJuzV5NTeIy6LHZWPK25PQaRUxEvcg1nkFgF?=
 =?us-ascii?Q?WGTIJ/h9MQv/axDkyrxQpaBPY2upgY8fAAS0iQDigiqFFXA8BXBaYDYK7RVO?=
 =?us-ascii?Q?2s8qUHyxbOwA6S9TLW5McIwyLC1lan0BJwjyxz/CcxewNJo6OdL2LC7xDqO6?=
 =?us-ascii?Q?6BEAu2ocpbkmy4OE1Qs2V+jOGnDsVTkDTUN/ndZAPJq6373TGBugb0s1aFaw?=
 =?us-ascii?Q?roDrPCsvoUDfWQdbxyExs/jFFTSzy9FigzICtts6xBKWmguHuzdiMWTqORIJ?=
 =?us-ascii?Q?9bdA3lgEMXmlOk7KdlyucGH/GeMtBTvzL0mjRZ0zJM6r0CfIVKuuowxt4v9F?=
 =?us-ascii?Q?S61g78xGOmrhu0EFc3RDCl7WmYnMr1fI986dC8FvrkcZxi6rPTDRtoffsEwc?=
 =?us-ascii?Q?jKbUttcIoYJMQMK/tncjfYSfzBSSiO73LOoiq2QVGKq8n+Ub8t1X0E/kkyyx?=
 =?us-ascii?Q?lOf00PJd58y0jq8NA2Ny2ekRHBFppRPA+GerC3XvntbApyWLxsAAsApnjBHA?=
 =?us-ascii?Q?trUqi0yScbQIp8oTrPGCsqTs5h7X4HrL15ABFbgxIPvgoZGn5lwFUuFEbTp/?=
 =?us-ascii?Q?BfyQTDNXLfNli4JMlZZPjNnl+4zOyQCUMOX4gXGbq2Y8Z8lQ2OHAGTOX0SWe?=
 =?us-ascii?Q?iiNfmeEkxYQPB25k7tj3fkRIgVgzx0G/UIEsQh/8XHMZZTTnWrghCOFm6/2K?=
 =?us-ascii?Q?kcuGwlXdx/r6zpE8/E2YXmg5tN81CKUOVQSlUyHXJrOJgN2Qi230JtwcMlui?=
 =?us-ascii?Q?SveV6QIYuapaP1zjpr4cHC54s8gvhcZ88MqvyF3EwYUTGCfaearBPGAiSIdT?=
 =?us-ascii?Q?wQHIdaeadSPfHAdQ5qtEN502dYcrwYjfS/HNj/bd+lXbLFwrdM/wjPG91xuc?=
 =?us-ascii?Q?PFdRzypGKg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1b0d07a-6dd8-4340-f312-08df25357e39
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5174.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 12:12:59.6955
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /ZcCA++4wpz9dQ2Gy4dldfOv+9D6QhNjVEAHxgHG1OnWv4qtqREZtE53vu2KEJsuf/DpI/GmuvjIoFVB/pnWMw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA5PPF3C36BFCB5

Hi Mete,

On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
> Summary
> ===========================================================================
> On systems with asymmetric CPU capacities, the scheduler prefers fully idle
> cores over idle SMT siblings of busy cores. This works generally well but
> virtualized platforms where low capacity cores should be avoided are not
> considered. Introduce a new config option and arch hook to prioritize
> SMT utilization.
> 
> Background
> ===========================================================================
> The scheduler has been moving toward better utilization of fully idle cores
> and avoiding SMT penalties. This trend (notably after commit 25a32e400a14
> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selection")
> broke the behavior s390 is relying on to concentrate workloads on its
> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
> entitlement assigned by the hypervisor. The idle SMT siblings of busy
> high-capacity cores start to perform better than fully idle low-capacity
> cores as the whole machine(containing the logical partitions) starts
> approaching to a {fully,over}loaded state. Grouping load on high-capacity
> cores keeps shared low-capacity cores(which are shared more aggressively)
> idle longer, reducing noise to neighboring partitions and improving
> overall performance.
> 
> Approach
> ===========================================================================
> This series introduces SCHED_IDLE_SMT_PRIO config option and the
> sched_idle_smt_prio static branch, allowing architectures to treat idle
> SMT siblings of busy cores as equal candidates during asymmetric capacity
> load balancing.
> Static branch checks are placed at paths considering fully idle cores
> over idle SMT threads in presence of asymmetric CPU capacities within
> scheduling groups. Inserted checks mostly override hints for idle core
> selection or cause early exits favoring idle SMT siblings.
> One more static branch check is added to new task path in order to favor
> high capacity SMT siblings during initial task placement, therefore the
> tasks are immediately placed in high capacity SMT siblings instead of
> considering most idle but low capacity cores.
> 
> Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
> implementing arch_needs_idle_smt_prio(), which is evaluated during each
> asym_cpu_capacity_scan() to track the state as runtime topology changes.
> 
> The second patch enables the feature for s390 when running on
> hardware-backed topology in an LPAR with vertical polarization active
> and system is approaching to a target state.
> Otherwise the branch stays disabled and the scheduler falls back to the
> standard idle-core preference.
> 
> No functional change on architectures that do not select
> ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO.
> 
> Performance Results
> ===========================================================================
> Since this change effects the {fully,over}loaded state it is difficult
> to test at the moment. Therefore there are no concrete numbers or
> metrics for now for s390.
> For architectures which do not opt in to this feature, no performance
> change is expected.
> 
> Considerations and Open Questions
> ===========================================================================
> The main goal for this series is adding a simple mechanism for
> architectures to switch between idle core and idle SMT priority while
> keeping the introduced footprint as small as possible. But there are
> some ideas and questions to consider;
> 
> 1. Should arch_needs_idle_smt_prio() hook be removed?
>    The architecture hook is there to allow for any sort of logic to
>    dynamically decide when to flip the mechanism, but it can also be
>    removed if everyone agrees that this behaviour is not something that
>    should be dynamically flipped. It can be simply tied to detection of
>    asymmetric capacities and selection of Kconfig option.
> 
> 2. Is there a simpler way to implement this mechanism?
>    The proposed approach is chosen as the other features effecting the
>    scheduler's behavior, use the same method. If there is a more
>    efficient way to implement the same mechanism I'd be glad to use
>    that instead.
> 
> 3. There are no performance measurements *yet*.
>    On s390 the ideal conditions for this mechanism to be beneficial
>    usually surface when the whole system is fully loaded and resource
>    sharing between the logical partitions starts to get expensive.
>    Creating such an environment requires time, therefore no benchmark
>    results are available yet.

I'm wondering if we could build on Shrikanth's cpu_preferred_mask infrastructure
to express a "soft preference" for the s390 higher-entitlement CPUs. Unlike the
mask's current behavior, soft preference would allow tasks to spill onto other
CPUs once the preferred CPUs have no idle threads available (we have something
like this in sched_ext's scx_cosmos).

That might let us preserve the general preference for fully idle SMT cores while
searching in this order: fully idle preferred cores, idle SMT threads on
preferred cores, then non-preferred cores. This current patch series seems to
drop the first distinction, allowing a partially idle preferred core to win even
when another preferred core is fully idle.

This would need to coexist with the steal governor's stronger use of
cpu_preferred_mask, so I'm suggesting it as a potential direction to explore
rather than a drop-in replacement.

What do you think (Mete / Shrikanth)?

Thanks,
-Andrea
