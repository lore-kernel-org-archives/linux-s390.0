Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71544ED180;
	Thu,  8 Oct 2026 15:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791474330; cv=none; b=dd+ViTAtGPXkB7MxIDkPuxXN0lXrLuIVZRrOzWA+j8a01BeBWMiaVpHerGP1m1b/FX1kTskY7LXX3/TIDrmY/UhO9LHEnu9pi4rtLj9K0+ABgHUiUX7oUEXl3pMLpmUne6URmIVr8hRhT3uqFFrGM0mAYcC8Om7BOPnh5iWqtAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791474330; c=relaxed/simple;
	bh=5sBCWGaBSjG3TFBBejS/+re1nFuFtm96luahmJvQ+KY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nhhyUOZXkMyTf95cWWn90WNoa+fDTYpfjtjffn4xZYGW334bc3PmcH6qTJBOK7e9JLEBONxNLfdOpwdRVkac4g1tHS8RmfyKk4+5guS/b3qh+vZMuBkTEcdPMreWPdKH3shID9IKkER0xhea/pByUHQ08q3fNy1HkBdRcn4SZ9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=gKHkr4PB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="gKHkr4PB"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698EZVAh1466259;
	Thu, 8 Oct 2026 15:45:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=xeQwlr
	W/+1nVfqm9gbeCQRDTngf4F0m/2NkzqmA9nIg=; b=gKHkr4PBJVMuX8cQFL3SKY
	a5uPZKPm3NlVM1uJW5/quJDLiz6SpXE/i1iEETfwuQyG5JvQYAt2oFq8VDZe6hi5
	LD/sk2V1vsXAjPkmK1ELq6uqTKNzpnFSpZnQxPOiA90WTNNmEzHQIWvcihcNpeVu
	2rc9gU2Br//HEN+o529B4XgEtakGoDf6igZ2PlqVyGwhbIzW8ISEdNf1nK/FM+7b
	jOLgxT7AvDUmRXKwyL+3DonmrjqszyQvfGu/LGHSKH5/fEABMblu/jzUQqkhEUkJ
	+9ETdJsAmsFNpYh9C2xx5+9mPSRx05z93vBdMxL+QsAj4g45ABNfRpjFUDFjELwQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw4ejs-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 15:45:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698EXi5U3636995;
	Thu, 8 Oct 2026 15:45:00 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh3u3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Oct 2026 15:45:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698Fiubs51380644
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 15:44:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 678812004B;
	Thu,  8 Oct 2026 15:44:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83F1A20040;
	Thu,  8 Oct 2026 15:44:50 +0000 (GMT)
Received: from [9.39.24.38] (unknown [9.39.24.38])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Oct 2026 15:44:50 +0000 (GMT)
Message-ID: <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com>
Date: Thu, 8 Oct 2026 21:14:49 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Mete Durlu <meted@linux.ibm.com>, Andrea Righi <arighi@nvidia.com>
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
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX9p+27eT+c3LU
 WQL8oKSBUiSp1Xui9GsYGE9O1PLYMlBPARFrY1KSMBxbXVyYnbLA6SvPQMa0kP6qolXa4ZKt/jC
 PasjP78PVIznmQbCcDa/zrmwd8cKWxM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA2MiBTYWx0ZWRfX+yHcUWZItqrg
 zoQdAeVVm1Q8QL3PdRBA/brAuSya0TQjrf/yUGwYbwotD9pFe9flQPFdq6Zl5eO/8eXTspvQG44
 n+4cVtjDguwlEoCd9acLrX6fK9Ch/cV3s0YBrPXI7pi0etJ7Jd2EkIxdq+ehmjazwDIyyYq1Zz4
 r22e+wZmvFZvhDYNiCvCmXJ+N2CDvsyyRkLGHohwOV17VHKYNkOPjvm4xOT2oOIVUOZhZavQP1B
 DQoBjVD+XXy3h62o7KMUcNeIn8gGO1ex0cp3qaGYK5u5ghIxNQhxjpTzSzbcqt2QkQofiGpxU3X
 4F/KAFBHM+Pem4hFANGVVmU7jiZMssGwJuBoFEhBfB4SD4cOQO5eqwXnIATlQ/cbBQqdovYg4hj
 lykbQ61LXeFlg63A6wdoYA4TmOqZdk7f2YFlHIZgLz4xPlnDj03iMizcoN381FVk790XT81+ZAq
 aG7QiAWFvc9TmXogPOg==
X-Proofpoint-GUID: gnxaxdKc2L2CZEgiCR-nVucj-y5veYT6
X-Proofpoint-ORIG-GUID: usQ03y5t347PP8nHsz0H3CoaXOKoGj2I
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac7ba7d cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=3p4kgI1EqHq8VEk02gUA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_05,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080062

Hi Mete.

On 10/8/26 8:54 PM, Mete Durlu wrote:
> On 08/10/2026 16:58, Shrikanth Hegde wrote:
>> Hi Meter/Andrea.
>>
>> On 10/8/26 5:40 PM, Andrea Righi wrote:
>>> Hi Mete,
>>>
>>> On Thu, Oct 08, 2026 at 10:30:46AM +0200, Mete Durlu wrote:
>>>> Summary
>>>> ===========================================================================
>>>> On systems with asymmetric CPU capacities, the scheduler prefers fully idle
>>>> cores over idle SMT siblings of busy cores. This works generally well but
>>>> virtualized platforms where low capacity cores should be avoided are not
>>>> considered. Introduce a new config option and arch hook to prioritize
>>>> SMT utilization.
>>
>> That's true only under physical CPU contention right? or is it always?
> 
> Right, because of that s390 treats all CPUs as equal and starts to
> assign lower capacities to CPUs with low entitlement once a certain
> steal time threshold is crossed (aka physical CPU contention).
> 
>>>>
>>>> Background
>>>> ===========================================================================
>>>> The scheduler has been moving toward better utilization of fully idle cores
>>>> and avoiding SMT penalties. This trend (notably after commit 25a32e400a14
>>>> ("sched/fair: Prefer fully-idle SMT cores in asym-capacity idle selection")
>>>> broke the behavior s390 is relying on to concentrate workloads on its
>>>> high-capacity cores. On s390 CPU capacities represent the CPUs runtime
>>>> entitlement assigned by the hypervisor. The idle SMT siblings of busy
>>>> high-capacity cores start to perform better than fully idle low-capacity
>>>> cores as the whole machine(containing the logical partitions) starts
>>>> approaching to a {fully,over}loaded state. Grouping load on high- capacity
>>>> cores keeps shared low-capacity cores(which are shared more aggressively)
>>>> idle longer, reducing noise to neighboring partitions and improving
>>>> overall performance.
>>>>
> 
> [...snip...]
> 
>>>> Considerations and Open Questions
>>>> ===========================================================================
>>>> The main goal for this series is adding a simple mechanism for
>>>> architectures to switch between idle core and idle SMT priority while
>>>> keeping the introduced footprint as small as possible. But there are
>>>> some ideas and questions to consider;
>>>>
>>>> 1. Should arch_needs_idle_smt_prio() hook be removed?
>>>>     The architecture hook is there to allow for any sort of logic to
>>>>     dynamically decide when to flip the mechanism, but it can also be
>>>>     removed if everyone agrees that this behaviour is not something that
>>>>     should be dynamically flipped. It can be simply tied to detection of
>>>>     asymmetric capacities and selection of Kconfig option.
>>>>
>>>> 2. Is there a simpler way to implement this mechanism?
>>>>     The proposed approach is chosen as the other features effecting the
>>>>     scheduler's behavior, use the same method. If there is a more
>>>>     efficient way to implement the same mechanism I'd be glad to use
>>>>     that instead.
>>>>
>>>> 3. There are no performance measurements *yet*.
>>>>     On s390 the ideal conditions for this mechanism to be beneficial
>>>>     usually surface when the whole system is fully loaded and resource
>>>>     sharing between the logical partitions starts to get expensive.
>>>>     Creating such an environment requires time, therefore no benchmark
>>>>     results are available yet.
>>
>> If it only under contention, then you probably don't want to use low cores for
>> anything right? If above is yes, then using steal governor would help to avoid low
>> core if you mark them as non-preferred. (which i guess you guys are exploring already)
> 
> IMO it should be dynamically adjustable depending on the contention
> level. But yes, on worst case low capacity cores should be avoided by
> marking them as non-preferred.
> 
>> But, find_new_ilb isn't aware of preferred CPU state as of initial patches.
>> I had thought of making a change to pick a idle preferred CPU instead of a idle non-preferred
>> core for idle load balancing. It is not done due to below reasons.
>> - Performance numbers didn't show any major improvements with real life workloads.
>> - Code becomes quite complex for find_new_ilb.
> 
> IIUC, find_new_ilb() finds an idle CPU that can do load balancing
> for other idle CPUs. As long as the tasks don't land on non-preferred
> CPUs, where ilb occurs should not matter. (At least for s390)
> 

If that is what you want, then steal governor is the right choice.

Even if idle load balancing runs on a non-preferred idle CPU, it is going
to do the idle load balancing for all the idle CPUs. Including preferred and
non-preferred. And actual load balancing bails out early and does not pull any
task towards if it is a non-preferred CPU.

>>>
>>> I'm wondering if we could build on Shrikanth's cpu_preferred_mask infrastructure
>>> to express a "soft preference" for the s390 higher-entitlement CPUs. Unlike the
>>> mask's current behavior, soft preference would allow tasks to spill onto other
>>> CPUs once the preferred CPUs have no idle threads available (we have something
>>> like this in sched_ext's scx_cosmos).
>>>
>>
>> cpu_preferred infra won't allow to spill over if preferred CPUs don't have an idle CPU.
>> It rather enforces packing onto preferred CPUs even if it means rq has more than 1 task.
> 
> I think what Andrea has in mind is something similar to what he did with
> select_idle_capacity(). Depending on the state of the non-preferred mask
> and other factors cores and SMT siblings can be evaluated as ideal
> candidate somehow. Wouldn't it be possible to extend the
> infrastructure you introduced to achieve this?
> 
>>> That might let us preserve the general preference for fully idle SMT cores while
>>> searching in this order: fully idle preferred cores, idle SMT threads on
>>> preferred cores, then non-preferred cores. This current patch series seems to
>>> drop the first distinction, allowing a partially idle preferred core to win even
>>> when another preferred core is fully idle.
>>>
>>> This would need to coexist with the steal governor's stronger use of
>>> cpu_preferred_mask, so I'm suggesting it as a potential direction to explore
>>> rather than a drop-in replacement.
> 
> I think this makes a lot of sense. An approach to first fill preferred
> CPUs before spilling to the non-preferred cores until contention
> forces the evacuation of non-prefered CPUs.

Well, when we see steal time, it usually means there is high contention and
we are using more vCPUs at this moment than possible.
So we mark them as non-preferred. Note that they are idle cpus. But non-preferred.

That means preferred CPUs may have more than 1 task. If we spill over if there
is idle non-preferred CPUs, we will be back to square one. No?

> 
> Shrikanth, would it make sense if I try to find a way to extend your
> current implementation in this way?
> 
> Thanks!
> -Mete

