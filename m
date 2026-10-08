Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 252254DDB5E;
	Thu,  8 Oct 2026 15:25:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791473128; cv=none; b=rrwf/Pcjq+m5q+CbbzTC3/XbG+5nkdtGPoF5b3suosWZtxD85KGKD85lC6FgV+6gg8oZj1X+SLQnvKdq5JqEND1tewD1ImYBIR8fBEFepSRTeinRjy91Ri7bK5ROfMUJa/7fYaZoizYx4fpCUzwIFegs0rliCH3dA11Yr50WPe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791473128; c=relaxed/simple;
	bh=qzA+CnpV0uZy5WY/xHiR3kvedwLglhUPGsIscSVUSiY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUotqQRNmjd9Q+NoK1bFDO8FzFRkrkOo5LV5F/OFJvXrH9YoS5b0vVCuNHTmRG1Q5l5Cf5zIYtFPIbESsvZbJnhg+HbrIkDGrz+ASjya2ztQubBZQmfncBD8dFETmjvxM9mOTHLiSGF/nY/wYVYUbn/Dq1KQibgXo2DWZ4rHINo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M52b1/ww; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M52b1/ww"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EZddw1466499;
	Thu, 8 Oct 2026 15:24:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Ihc/VC
	MLJPRL/rsDVJc3FGJurErXTdf3yr0pnt9Dc8c=; b=M52b1/ww6uJ4ZpXDnRrpqi
	2oKc6XLtEW9LKd3BSOKqS7pmLmqD4expM6g2rW/0aLVk7XO8Q6QCdyRahkQYBsuV
	zH96NTI5GZ8qAEpyyQLovWvzpOfkuUS7iYucwJNqXLkxU0VV0iUY4XtNIfYwaizN
	5yz4qQ1myuK1TS3xSgSIHF01H5HDkPPwlJfK07Wx5fLG5bpnQDnb8gQZeuL1Bv5E
	ObpaGkTxTwkCvvxTTijVHBxu4HNJH0IDpVfufwAbOJGOmPWpDdaN2b9bYvB32Eg0
	vo+k+W/YXPxUrDdycYxH4TRK5DhaHsiB4VHSDwQH5+NTt3xF/YPHqxR8Y0y3JXgA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw4awa-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 15:24:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698EXhUg2355485;
	Thu, 8 Oct 2026 15:24:56 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h5f3txsa8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 15:24:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698FOqCX54985094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 15:24:52 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5404D2004D;
	Thu,  8 Oct 2026 15:24:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB0DE2004E;
	Thu,  8 Oct 2026 15:24:51 +0000 (GMT)
Received: from [9.224.76.67] (unknown [9.224.76.67])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 15:24:51 +0000 (GMT)
Message-ID: <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
Date: Thu, 8 Oct 2026 17:24:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Shrikanth Hegde <sshegde@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>
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
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MCBTYWx0ZWRfX1kFqbR1NsuQk
 T3e9xGNBrKw+CvWGb8YNWMlilq6k2vlDsAVq6gcfiJczoa9MU3Om6OtRjH863B2WN/qqdL6akhN
 FkuxoYPq0g8bv6JUXMP60jFY1HhrsTU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MCBTYWx0ZWRfX/FSCnmQzx8OX
 V8dsQn71A1dpX8Q0E3FXfKeOOWBQgZND6cURoo5/4prD9CxRekq3J9Bu0mSPia+cMSPKQkndAUF
 G9j2krBa0PPOpgHtr2iPPZtKEUHTutn9Tgaj5Fsgtr8XVB9BdHWOdfl6tkgW6PLZCMBcGXnOfGB
 MvyOR9d1axSfKz1xm0A6XhgpaLYHgbuo92O5PIxePHMIyh40cXnxZeeE+0HQ4kCWCGCNloE/ja8
 RwZTlAhMQ3JbHSvbG1R42hjSHvxifBUgCxXnDEAvUJJykfl/QcF7fNpFuF3qjkkQF5Ea85uoPhk
 h+g9dfMwndiT9G1HpP/ivKpytma4aYhyHx93lAGpIiLWEgt7JbKfWTNAkBmEx+YVyx2tO/+8aaj
 Th/rDWOVARF7k7yf1xgs29QTmSJGpHqJIbcAHvZe87wF4MhDpLO1Y9GzVv5NEey50SqYrSi+6lg
 YL12c0bOL4LdDbcB/Xg==
X-Proofpoint-GUID: 3QBBLIyyXYkC6eDv1gr4cmLeP1Sx1lMy
X-Proofpoint-ORIG-GUID: ELfwMHtu85vXieifXcWAyW8dozrolNQr
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac7b5c9 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=tSu9hKwbF8gy7e_CysEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080060

On 08/10/2026 16:58, Shrikanth Hegde wrote:
> Hi Meter/Andrea.
> 
> On 10/8/26 5:40 PM, Andrea Righi wrote:
>> Hi Mete,
>>
>> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
>>> Summary
>>> ===========================================================================
>>> On systems with asymmetric CPU capacities, the scheduler prefers 
>>> fully idle
>>> cores over idle SMT siblings of busy cores. This works generally well 
>>> but
>>> virtualized platforms where low capacity cores should be avoided are not
>>> considered. Introduce a new config option and arch hook to prioritize
>>> SMT utilization.
> 
> That's true only under physical CPU contention right? or is it always?

Right, because of that s390 treats all CPUs as equal and starts to
assign lower capacities to CPUs with low entitlement once a certain
steal time threshold is crossed (aka physical CPU contention).

>>>
>>> Background
>>> ===========================================================================
>>> The scheduler has been moving toward better utilization of fully idle 
>>> cores
>>> and avoiding SMT penalties. This trend (notably after commit 
>>> 25a32e400a14
>>> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle 
>>> selection")
>>> broke the behavior s390 is relying on to concentrate workloads on its
>>> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
>>> entitlement assigned by the hypervisor. The idle SMT siblings of busy
>>> high-capacity cores start to perform better than fully idle low-capacity
>>> cores as the whole machine(containing the logical partitions) starts
>>> approaching to a {fully,over}loaded state. Grouping load on high- 
>>> capacity
>>> cores keeps shared low-capacity cores(which are shared more 
>>> aggressively)
>>> idle longer, reducing noise to neighboring partitions and improving
>>> overall performance.
>>>

[...snip...]

>>> Considerations and Open Questions
>>> ===========================================================================
>>> The main goal for this series is adding a simple mechanism for
>>> architectures to switch between idle core and idle SMT priority while
>>> keeping the introduced footprint as small as possible. But there are
>>> some ideas and questions to consider;
>>>
>>> 1. Should arch_needs_idle_smt_prio() hook be removed?
>>>     The architecture hook is there to allow for any sort of logic to
>>>     dynamically decide when to flip the mechanism, but it can also be
>>>     removed if everyone agrees that this behaviour is not something that
>>>     should be dynamically flipped. It can be simply tied to detection of
>>>     asymmetric capacities and selection of Kconfig option.
>>>
>>> 2. Is there a simpler way to implement this mechanism?
>>>     The proposed approach is chosen as the other features effecting the
>>>     scheduler's behavior, use the same method. If there is a more
>>>     efficient way to implement the same mechanism I'd be glad to use
>>>     that instead.
>>>
>>> 3. There are no performance measurements *yet*.
>>>     On s390 the ideal conditions for this mechanism to be beneficial
>>>     usually surface when the whole system is fully loaded and resource
>>>     sharing between the logical partitions starts to get expensive.
>>>     Creating such an environment requires time, therefore no benchmark
>>>     results are available yet.
> 
> If it only under contention, then you probably don't want to use low 
> cores for
> anything right? If above is yes, then using steal governor would help to 
> avoid low
> core if you mark them as non-preferred. (which i guess you guys are 
> exploring already)

IMO it should be dynamically adjustable depending on the contention
level. But yes, on worst case low capacity cores should be avoided by
marking them as non-preferred.

> But, find_new_ilb isn't aware of preferred CPU state as of initial patches.
> I had thought of making a change to pick a idle preferred CPU instead of 
> a idle non-preferred
> core for idle load balancing. It is not done due to below reasons.
> - Performance numbers didn't show any major improvements with real life 
> workloads.
> - Code becomes quite complex for find_new_ilb.

IIUC, find_new_ilb() finds an idle CPU that can do load balancing
for other idle CPUs. As long as the tasks don't land on non-preferred
CPUs, where ilb occurs should not matter. (At least for s390)

>>
>> I'm wondering if we could build on Shrikanth's cpu_preferred_mask 
>> infrastructure
>> to express a "soft preference" for the s390 higher-entitlement CPUs. 
>> Unlike the
>> mask's current behavior, soft preference would allow tasks to spill 
>> onto other
>> CPUs once the preferred CPUs have no idle threads available (we have 
>> something
>> like this in sched_ext's scx_cosmos).
>>
> 
> cpu_preferred infra won't allow to spill over if preferred CPUs don't 
> have an idle CPU.
> It rather enforces packing onto preferred CPUs even if it means rq has 
> more than 1 task.

I think what Andrea has in mind is something similar to what he did with
select_idle_capacity(). Depending on the state of the non-preferred mask
and other factors cores and SMT siblings can be evaluated as ideal
candidate somehow. Wouldn't it be possible to extend the
infrastructure you introduced to achieve this?

>> That might let us preserve the general preference for fully idle SMT 
>> cores while
>> searching in this order: fully idle preferred cores, idle SMT threads on
>> preferred cores, then non-preferred cores. This current patch series 
>> seems to
>> drop the first distinction, allowing a partially idle preferred core 
>> to win even
>> when another preferred core is fully idle.
>>
>> This would need to coexist with the steal governor's stronger use of
>> cpu_preferred_mask, so I'm suggesting it as a potential direction to 
>> explore
>> rather than a drop-in replacement.

I think this makes a lot of sense. An approach to first fill preferred
CPUs before spilling to the non-preferred cores until contention
forces the evacuation of non-prefered CPUs.

Shrikanth, would it make sense if I try to find a way to extend your
current implementation in this way?

Thanks!
-Mete
