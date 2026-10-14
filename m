Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7E2C21D0;
	Wed, 14 Oct 2026 05:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791954393; cv=none; b=Uj8DqUCFMzfoBnItkh65o1Ky8aldKui7lMwBl3UdTgGs3eGepBDn4IQE9YeMd/utx8Ncy1VMYaoW3WPBtfMhxaOX/6HtCKQHp8W/AeiPT0sjgYuZAayQFcGxbj+15WfFq+9zNRt6lgLzuZQhzDoB1WQBBK46lhS25q0eowGlmRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791954393; c=relaxed/simple;
	bh=e4PlIKrYIwGQ2ac+RbxktoD50jkKDGkejgVX1+RE4bw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pB/PfFTTuxLcT5bc0DSKazhryZpCbxu7X9Y0mfSN4TG4joQ/l5eO0JSXyYodecAQXOCx99S/ags50+jY2TPrrmBgnNy2PD9mW5XyFQ7vN2bwxsDaiX7LUlUSh3rlxtcz40+7ERfJYROqAu3+anLunAFL9jQSe0zn+p+tVbnCeZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ARc/J4E3; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ARc/J4E3"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69DJqV0r149292;
	Wed, 14 Oct 2026 05:06:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=W74vbS
	v4TEGBMXH8XYOaaaXCfb1gpMTANOnSCyn5N7s=; b=ARc/J4E3CXOeMtz0JTkZe+
	gVZRcvv0e49FF33nHFIAQrfUdZkZayCCzDXxK0iKGrW+DATMsXqZT1V88dc6eQs+
	Mm3wr1g7E80DxBzldchoQQ9lWvZ03MHjPsURGI+Id8moFbgBfZTmlJsn/UtSO0cW
	ZLTpvhFOoQYfUmMjjhsucWdADimObutg5lWAeMGRXsn3hjP71HChSEbBXCnACu0z
	pRAsmRbollg/6Hek5/sdy2tPN5+pbbWTE6G2w3wT0LQSV3qsDR21LGk+b1Wg7kf0
	Qn9laTLb+xDXvrxCNwqsG+mslekGP6Y8HUSQCB1y9SqMz6G2awrNwDTvkoBRrf6Q
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhjfhm-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 05:06:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69E05KYr3149863;
	Wed, 14 Oct 2026 05:06:08 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h9pb3kgtt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Oct 2026 05:06:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69E5633P28180966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 Oct 2026 05:06:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EC6120043;
	Wed, 14 Oct 2026 05:06:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89C592004B;
	Wed, 14 Oct 2026 05:05:58 +0000 (GMT)
Received: from [9.124.213.187] (unknown [9.124.213.187])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 14 Oct 2026 05:05:58 +0000 (GMT)
Message-ID: <e6807d57-35af-4b4f-8b81-cabe0dfe99bd@linux.ibm.com>
Date: Wed, 14 Oct 2026 10:35:57 +0530
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Mete Durlu <meted@linux.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>
Cc: Andrea Righi <arighi@nvidia.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
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
 <CAKfTPtCianGNWSu0s2J_B_aO_rtKWO17k9guYmwgXXLUHQE+SA@mail.gmail.com>
 <d412d939-4704-4246-a9bd-b49b457099b8@linux.ibm.com>
 <CAKfTPtAGiesy0FZQ3aOny_1QkqaX0P2MCOdkE42ERdihRJL99g@mail.gmail.com>
 <ce85388c-3ea0-4363-8c89-fe2bf71b284a@linux.ibm.com>
 <1ca4fe52-29df-444f-beab-3b141ca89129@linux.ibm.com>
 <c702be6a-dd7e-421c-9d58-69c5a47bee06@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <c702be6a-dd7e-421c-9d58-69c5a47bee06@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfXyuSZ9qvpB/1R
 YyBCu6TuH4jx3YvjSTEUuVruDg/RC8Ykna7cuWXIX4zu8fofi2po0fjOoywXYF414JSU19DmuBv
 AeN7uZ/ccDTf2MqQEIRuxsK6sPcVl6c=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDAxOCBTYWx0ZWRfX06eVgtlj/Dsn
 +aYK1q7WnypU0DyJf5oEGBpXmQisnadJ/KTMIhWUrSm6Nwc1hnssQ1sICVF08m/TLbE/TI2LoAo
 FoK5KWU+l1om17j5XY7lVzCw+FT7z3EtBbAnTBzClDz8iueXWL/hWBrh3r7cGwufVygZwCk1A9I
 C5CF3kRfuh0Fibnhc8gfgTXBD/5Mg4RpHWgfUdYwMYfRHscDuX8kaIPu9DhahTb1/kGXOuyDsat
 Bxa1+AvLEUverWgb5yj7RAstcULHjMKC0ozfsT9AUX5hO6tVkHvSyXou04g31jDrRztxlf4rhRs
 R9nEjdE7hQXm/ob2Pa/G9jOFJKGC9rVV/IwDmEtDyuWmhuQ0GwkuUzGOcTdY3i7f7F3o9+xSmNQ
 lC5sRPWKLYcN/FobvK/l33ar441/+bR7gu6KJGv51JFriy1cd5pHHHiEpSKGv2iQWgkPseRWvEb
 S2RbQVq8oaOt/whNbXw==
X-Proofpoint-GUID: 3KrHNrIyFRRQtfMM7_aBHxZ-da0vIkPd
X-Authority-Analysis: v=2.4 cv=RoFQvymK c=1 sm=1 tr=0 ts=6acf0dc2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=sVqhROGeVYfk99SstBQA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ydJ5WBUKUoANdxElhUhRrU0s5xMM-UDv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 adultscore=0 bulkscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 clxscore=1015
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140018

Hi Mete,

On 10/13/26 6:10 PM, Mete Durlu wrote:
> [..snip..]
> 
>>>> What you describe really fit into the prefered core that Shrikanth
>>>> Hegde has developped
>>>
>>> I agree, but Shrikanth's solution can not bring some of the
>>> behavior changes required. cpu_preferred_mask can help
>>> direct task placement away from low capacity cores but idle
>>> core first approach still places tasks to fully idle low
>>> capacity cores. This patches proposal tries to move tasks
>>> first to the idle SMT siblings.
>>>
>>> Consider the following;
>>> On a system with 2 high capacity and 4 low capacity cpus.
>>> steal governor of vCPU backoff mechanism calculates 2 low capacity
>>> cpus should be taken off from the cpu_preferred_mask to decrease
>>> experienced steal time. cpu_preferred_mask has 2 high capacity
>>> and 2 low capacity cpus.
>>
>>
>> In this scenario, do you still have reasonable steal time or no?
> 
> steal time should be sitting between low and high steal time
> threshold values of the steal governor. (no adjustments)
> 
>>>
>>> Current behavior tires to place tasks to fully idle cores first
>>> even if they are low capacity cores.
>>>
>>>        c0(high) c1(high)  c2(low)  c3(low)  ...
>>> -------------------------------------------
>>> SMT 0 task     task      task     task
>>> SMT 1
>>>
>>>
>>> With the proposal, the fully idle core preference is circumvented
>>> and the most fitting SMT thread is selected.
>>>
>>>        c0(high) c1(high)  c2(low)  c3(low)  ...
>>> -------------------------------------------
>>> SMT 0 task     task
>>> SMT 1 task     task
>>>
>>> This is beneficial because at the time of contention(system pressure)
>>> low capacity cores could perform worse than SMT siblings of busy
>>> high capacity cores, even if there is not enough steal time for
>>> steal governor of Shrikanth's vCPU backoff to mark said low
>>> capacity cores as non-preferred.
>>>
>>
>> I read this as tunable problem of low,high thresholds to adjust
>> preferred_mask same as high capacity cores. No?
> 
> No, because cpu_preferred_mask would contain some low capacity
> cpus as the experienced steal time is not high enough to exclude
> all low capacity cpus from the mask.
> 
> And any new task could be placed on them like below as they should
> not cause an increase in steal time. See below (for 6 tasks);
> (non preferred cpus marked with X)
> 
>         c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
> ------------------------------------------------------------
> SMT 0 task     task       task     task          X        X
> SMT 1 task     task                              X        X
> 
> The soft affinity should come in as full utilization of high capacity
> cores(and their SMT siblings) before placing tasks to low capacity
> cores (for 4 tasks);
> 
>         c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
> ------------------------------------------------------------
> SMT 0 task     task                              X        X
> SMT 1 task     task                              X        X
> 
>>> Andrea came up with an idea to extend Shrikanth's mechanism further
>>> by adding a soft affinity to a selected set of CPUs. Task placement
>>> would first fully load these CPUs before spilling load onto rest
>>> of the CPUs on cpu_preferred_mask. That would help achieve the
>>> behavior I describe above if the soft affinity covers high
>>> capacity CPUs.
>>>
>>> The discussion is still on going though. If Shrikanth thinks this is
>>> a worthwhile concept then I'd be glad to work on the implementation
>>> and provide the patches.
>>
>> What i don't understand is.
>> - if there is no system pressure to use those low capacity cores, why
>>    not use them if the task util fits its capacity. If the task utilization
>>    doesn't, it won't land on them anyways today right?
> 
> Current task placement looks like this (5 tasks);
> 
>         c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
> ------------------------------------------------------------
> SMT 0  task     task      task     task*         X        X
> SMT 1  task     (**)                             X        X
> 
> Even with lowered capacities task don't migrate away from
> fully idle cores, cpu selection prioritizes fully idle
> cores before everything else if i am not mistaken.
> 
> The proposal with this patch series tries to circumvent exactly that
> idle core prioritization and uses SMT threads first, like below;
> 
>         c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
> ------------------------------------------------------------
> SMT 0  task     task      task     (**)          X        X
> SMT 1  task     task*                            X        X
> 
> *the task that got placed to SMT1 of core1 instead of fully idle
>   core3
> **where the next task would likely land.
> 
> After high capacity CPUs are fully saturated, remaining low capacity
> CPUs in cpu_preferred_mask can be utilized with idle core priority
> once again as there are no distinction between them.
> Utilizing high capacity cores(or entitled cores...) should lower
> the footprint of the guest and allow less noise from guests.
> Steal time(or contention) is expected first on low capacity cores
> anyway.
> 
> Does this make sense?

The examples does make sense. But if one configures steal governor
settings correctly, then number of low cores within the preferred mask
must be very few when under physical CPU contention.

So I would recommend to see the reality of this in practice with reasonable
thresholds. (Default may not be the best for all configs) You can also keep
the low threshold to very low value to see if that ensure preferred mask is
same as your number of entitled cores. i.e you don't have any low cores in
the preferred mask. I agree steal governor is a reactive mechanism and it may
have oscillations which might allow a few low cores sometimes.

Also, IMHO soft affinity thing is bit tricky to implement and need
to ensure minimal cost for common cases.

PS: There might be significant delays in my responses.
