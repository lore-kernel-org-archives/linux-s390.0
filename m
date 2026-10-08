Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2406D4D597C;
	Thu,  8 Oct 2026 14:59:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791471578; cv=none; b=PftGZxpB1KqsC1gwp3l2V1y1I7OxWsYMhGnoshmb1SL5dsVcr2tJx+9VuatpOr7BjLOszoz4wrXSRzHMtavCx+aN4krtvLmiirxRH2TwWH1nEJ8OIBauR+3GJERcdKhIJEUgWrA+Dy/DFguCSy0ihgND6Kjs1jjwhzrt2U/1FmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791471578; c=relaxed/simple;
	bh=vVIH/ykRQZnSi5D8f60kZRFD4FiepEDAr1QoX99oHg8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sma1Zht/Sf7dhjaem67fKEheaEO3orz7ojxkg/dQAiJ+TzSnZH2ofKcFtg7FPxFIMDnDmwjDpahEuUseR2yo4G4HYisxD90zFZ0gI6crDkmhDgaehWxYZzIqJa8x7d0EMyWnjl+oGwA/riGwp20L+x4NXa7H/gGO7G0vSODIUyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SRDJ46YQ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SRDJ46YQ"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EZjpW1466892;
	Thu, 8 Oct 2026 14:59:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MmMCvz
	0ZBj7+hPczNU0lnfoORCtnuYINBuhg+PiTzUE=; b=SRDJ46YQsbGMKidNvbe243
	lrUQL2J0Y4Z1+MhNJX70PXkHFvCUc2a7Pf7OnKNaAnZUaqejwaGK0iZS5erYSjRw
	25AOUfyxIDDJDmmfn6ca3Vj0fpyNoaTrDVuuLDWiHc+SRUP6cS4xmHMs7ECQLfGG
	QAMBp29Z7dtvwoiZZQkaduQSK8aGzX8LLI18Cu8exWWxM5IVInQBJjvzbT7QkUJj
	0HLa8tZi/wAb8W3dMjiPAy0I0eC3+ysfATfwwdDcu/3SnUxFqdVPVZmpF6wK8u+2
	mrEe/yfvtY1mrtI0gHDp6xOQYDBK+UHrFbK9E3IUw15uF4Zc4DdAB5a1/baVDdRA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw45s8-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 14:59:02 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698EXgWV3574128;
	Thu, 8 Oct 2026 14:59:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5qxvm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 14:59:01 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698EwvVL49545516
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 14:58:57 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 709B720043;
	Thu,  8 Oct 2026 14:58:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4405A20040;
	Thu,  8 Oct 2026 14:58:51 +0000 (GMT)
Received: from [9.39.24.38] (unknown [9.39.24.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 14:58:51 +0000 (GMT)
Message-ID: <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
Date: Thu, 8 Oct 2026 20:28:50 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Andrea Righi <arighi@nvidia.com>, Mete Durlu <meted@linux.ibm.com>
Cc: Ingo Molnar <mingo@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>, Ben Segall <bsegall@google.com>,
        Mel Gorman <mgorman@suse.de>, Valentin Schneider <vschneid@redhat.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tim Chen <tim.c.chen@linux.intel.com>, Chen Yu <yu.c.chen@intel.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20261008-hiperdispatchfix-v1-0-73fe41081070@linux.ibm.com>
 <aseIPhrDGCYFtJNE@gpd4>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <aseIPhrDGCYFtJNE@gpd4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX2xXZK245SA8A
 wfOoIJM90Qj/arI4NAu5O9TtGK3abhHNqAmxS95z88QQU3DWXp5EjS29Vq/FgE6rXLdffdwfqg+
 ZcMtTOgf0CD+ak9a9pXHDGUavvCfYPE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA1OCBTYWx0ZWRfX6CTeMhGvgnNG
 Ln6fh/VuJg5jLAyY5dW6Qvs13ZjRZuAQ5oOZTo2Nhiewi0Ol6nkrpQ1NT8AfVq+OTJxH5nwxbQi
 dWRDBM3Sbb/x0ZZAYnk/k73jfImg2Z1NYQ9GkbwlMXLp4bKWNRj/+X91jH5ovasv5kFTLPgkSri
 KQ0SixSkAHLd2qvpOEhY7wDZwZTBvFOuwzLlcRfJRTaZBwKaUxTQJnwBaYULUc8DFq13Vg0YUSp
 Z9KIpwfuw3DuCUhcOQkKr2F0MqPRJWuKG1HM4Oi22R0gpRpPaZ/zvOfRvSFC7JnZogndUdqQLaY
 dkgPbno8sx9oOqofQCODjaeKVJWIOOMdGEzRiglhZ147hJ/GPfBXcyCxAo33VKSciDV7KNFXUnm
 ojdBa7w75IUiHq+RrCyLKJiKFojjJUVPkRcN7xlNo1wlNCH0XB4Gr/+03v1BvLXa2RfdeJIaaFx
 vjlvEVMpYO1Xswycejw==
X-Proofpoint-GUID: OTafGFsQRCYWfhxe5nA6N8PE3uZD3awJ
X-Proofpoint-ORIG-GUID: 2OmB2kYYj2a0dOZh_6fjxR2ArROMvoSR
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac7afb6 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=PqCiszBtB7BksAECbaEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080058

Hi Meter/Andrea.

On 10/8/26 5:40 PM, Andrea Righi wrote:
> Hi Mete,
> 
> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
>> Summary
>> ===========================================================================
>> On systems with asymmetric CPU capacities, the scheduler prefers fully idle
>> cores over idle SMT siblings of busy cores. This works generally well but
>> virtualized platforms where low capacity cores should be avoided are not
>> considered. Introduce a new config option and arch hook to prioritize
>> SMT utilization.

That's true only under physical CPU contention right? or is it always?

>>
>> Background
>> ===========================================================================
>> The scheduler has been moving toward better utilization of fully idle cores
>> and avoiding SMT penalties. This trend (notably after commit 25a32e400a14
>> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selection")
>> broke the behavior s390 is relying on to concentrate workloads on its
>> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
>> entitlement assigned by the hypervisor. The idle SMT siblings of busy
>> high-capacity cores start to perform better than fully idle low-capacity
>> cores as the whole machine(containing the logical partitions) starts
>> approaching to a {fully,over}loaded state. Grouping load on high-capacity
>> cores keeps shared low-capacity cores(which are shared more aggressively)
>> idle longer, reducing noise to neighboring partitions and improving
>> overall performance.
>>
>> Approach
>> ===========================================================================
>> This series introduces SCHED_IDLE_SMT_PRIO config option and the
>> sched_idle_smt_prio static branch, allowing architectures to treat idle
>> SMT siblings of busy cores as equal candidates during asymmetric capacity
>> load balancing.
>> Static branch checks are placed at paths considering fully idle cores
>> over idle SMT threads in presence of asymmetric CPU capacities within
>> scheduling groups. Inserted checks mostly override hints for idle core
>> selection or cause early exits favoring idle SMT siblings.
>> One more static branch check is added to new task path in order to favor
>> high capacity SMT siblings during initial task placement, therefore the
>> tasks are immediately placed in high capacity SMT siblings instead of
>> considering most idle but low capacity cores.
>>
>> Architectures opt in by selecting ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO and
>> implementing arch_needs_idle_smt_prio(), which is evaluated during each
>> asym_cpu_capacity_scan() to track the state as runtime topology changes.
>>
>> The second patch enables the feature for s390 when running on
>> hardware-backed topology in an LPAR with vertical polarization active
>> and system is approaching to a target state.
>> Otherwise the branch stays disabled and the scheduler falls back to the
>> standard idle-core preference.
>>
>> No functional change on architectures that do not select
>> ARCH_SUPPORTS_SCHED_IDLE_SMT_PRIO.
>>
>> Performance Results
>> ===========================================================================
>> Since this change effects the {fully,over}loaded state it is difficult
>> to test at the moment. Therefore there are no concrete numbers or
>> metrics for now for s390.
>> For architectures which do not opt in to this feature, no performance
>> change is expected.
>>
>> Considerations and Open Questions
>> ===========================================================================
>> The main goal for this series is adding a simple mechanism for
>> architectures to switch between idle core and idle SMT priority while
>> keeping the introduced footprint as small as possible. But there are
>> some ideas and questions to consider;
>>
>> 1. Should arch_needs_idle_smt_prio() hook be removed?
>>     The architecture hook is there to allow for any sort of logic to
>>     dynamically decide when to flip the mechanism, but it can also be
>>     removed if everyone agrees that this behaviour is not something that
>>     should be dynamically flipped. It can be simply tied to detection of
>>     asymmetric capacities and selection of Kconfig option.
>>
>> 2. Is there a simpler way to implement this mechanism?
>>     The proposed approach is chosen as the other features effecting the
>>     scheduler's behavior, use the same method. If there is a more
>>     efficient way to implement the same mechanism I'd be glad to use
>>     that instead.
>>
>> 3. There are no performance measurements *yet*.
>>     On s390 the ideal conditions for this mechanism to be beneficial
>>     usually surface when the whole system is fully loaded and resource
>>     sharing between the logical partitions starts to get expensive.
>>     Creating such an environment requires time, therefore no benchmark
>>     results are available yet.

If it only under contention, then you probably don't want to use low cores for
anything right? If above is yes, then using steal governor would help to avoid low
core if you mark them as non-preferred. (which i guess you guys are exploring already)

But, find_new_ilb isn't aware of preferred CPU state as of initial patches.
I had thought of making a change to pick a idle preferred CPU instead of a idle non-preferred
core for idle load balancing. It is not done due to below reasons.
- Performance numbers didn't show any major improvements with real life workloads.
- Code becomes quite complex for find_new_ilb.

> 
> I'm wondering if we could build on Shrikanth's cpu_preferred_mask infrastructure
> to express a "soft preference" for the s390 higher-entitlement CPUs. Unlike the
> mask's current behavior, soft preference would allow tasks to spill onto other
> CPUs once the preferred CPUs have no idle threads available (we have something
> like this in sched_ext's scx_cosmos).
> 

cpu_preferred infra won't allow to spill over if preferred CPUs don't have an idle CPU.
It rather enforces packing onto preferred CPUs even if it means rq has more than 1 task.

> That might let us preserve the general preference for fully idle SMT cores while
> searching in this order: fully idle preferred cores, idle SMT threads on
> preferred cores, then non-preferred cores. This current patch series seems to
> drop the first distinction, allowing a partially idle preferred core to win even
> when another preferred core is fully idle.
> 
> This would need to coexist with the steal governor's stronger use of
> cpu_preferred_mask, so I'm suggesting it as a potential direction to explore
> rather than a drop-in replacement.
> 
> What do you think (Mete / Shrikanth)?
> 
> Thanks,
> -Andrea

