Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ACD332B133;
	Tue, 13 Oct 2026 12:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791895242; cv=none; b=VPRfHJq8I+vkqNElKnszch+55YNHYfo4Fm5XHca41HFAZZPU8X8rXwxQHDfayJ5O8kPnMJqPWRN99kCu/9i5NEdHYewTCYu7jqdj2Qh098ynkc2NNOAe6PlY03JJuqP/Invj0Ygb9UykgMfU9/tbZtih76U8mEvKAF+0GB18IM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791895242; c=relaxed/simple;
	bh=LKF3bKi91hcMSa0BeF4MKgWTsprydREmjX3Ak18qwlg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u3RRfCn9oibNyWurnmriFreZc224JzIUod8iE9qvYT2QQAkkCbR9HjMihRZc4QOJhWTtcgj4JuYAOi2VJPyS31UoqQFqk1jS4u25HqvQild0h5KMLLR2i9CKOlOz3Pahm567vZfhT+xunlrjwM95dNGAbg8hgip5jOc+ryQSoRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SQuBWpLb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SQuBWpLb"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EGp41891030;
	Tue, 13 Oct 2026 12:40:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pkVL53
	WN/4s0X8Z/MUMa0CqQex9K+rz4ihQCEZhkaXY=; b=SQuBWpLbrJCepLWhqQfHkU
	RdrGaebwXgxnnlDuB/ceVcFKLS3Ks43NSrstCZUs97pUYtjbcZ/zR+WKCmFmP74Q
	wVTuR9vOJBgXjo0AJIcsQZwyyWaFEHoJGNpsHWQLI4OgyW/Bh+gt1NWbjCTmjIhY
	+EZxy7PD+Kyv91GtDmhPL8YqjjOF3RxGl3UaFb52sPfsqwI2kgbIsU/zZBwNnM71
	J2ZFV3De/F/p5zmXJc90qcYgghEhJCsVM4DDPlnV2sjPE8qTS8BheFyI9wVlqZW5
	V//PNle7nyvzE30d51gzVxYLfQXP7KH/i1JCNkjI+c5xBxrDO0pAqH+2jwVKb2Iw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv3e0d4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:40:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCQVg82713069;
	Tue, 13 Oct 2026 12:40:18 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyhhhh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 12:40:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DCeDFm31392242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 12:40:13 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3E3E2005A;
	Tue, 13 Oct 2026 12:40:10 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E12C320043;
	Tue, 13 Oct 2026 12:40:09 +0000 (GMT)
Received: from [9.87.128.189] (unknown [9.87.128.189])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 12:40:09 +0000 (GMT)
Message-ID: <c702be6a-dd7e-421c-9d58-69c5a47bee06@linux.ibm.com>
Date: Tue, 13 Oct 2026 14:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/2] sched: Introduce idle SMT priority for asymmetric
 capacity systems
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
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
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <1ca4fe52-29df-444f-beab-3b141ca89129@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: r3dcj8Sq0AndnOUH8v0c3wotG_06EK0z
X-Proofpoint-ORIG-GUID: AK_owYCSd2kPxsRRKRS7gssNeazH8--D
X-Authority-Analysis: v=2.4 cv=aqInmiZV c=1 sm=1 tr=0 ts=6ace26b3 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=bdwL7orZE-3m0DtujhgA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfXzXTAiBY/Lcv6
 zEObkpVpAzTxLeC+iyxk5Gswv74SUU8G+AxpY/997BOUwgxAt3sd1wwnESHAtOgp3PjeqF4hmzE
 Hz2NlxOWKl88iQAPMHppyHUL/r9VGEI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0OCBTYWx0ZWRfXz0DSk9/niQDJ
 T4g+DoEpNYsrN2Dx2DKWy8WVSFRRL/aQBR0H0vI2L80bzulOxY/8KSYGsYdN4NxG/cIv6pSpFhZ
 UfZAHhIsm9fjm/aRR83u6ARXpP8x8LZFxXmqWIfeRiYj5OX8272p/mAGWqDAjOPMarUmOvRtR3V
 YYw6ff0ZIuo51uGQqR/q7n/Sw1t7Rzj5XyXoZRlZ6kSsDOzqH27vyXDiD6CytMbRYU+cDIYrZkw
 mFFgXct89R68au9FBsUOc6muFDSJKN3/cSURCAEGAp6KGM3VJYTnKljCpGDypv1jK0ZQEmhUrp4
 yI497UEpxtSyNlVvyyvSuM4Oab7rxI21aozHjl+iD8xrUYTrqAqDDcNBgzqy1eNn3/RbVPdWh8Z
 EWUIR9wukKh0YYFJbENDz+751rnrYCUZ81z2mwKqa/OIbh0qAXeEx6FWdr1cDTYcZNWwe3z/+aB
 gMbNKUE1apXLvPEOFrg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 adultscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130048

[..snip..]

>>> What you describe really fit into the prefered core that Shrikanth
>>> Hegde has developped
>>
>> I agree, but Shrikanth's solution can not bring some of the
>> behavior changes required. cpu_preferred_mask can help
>> direct task placement away from low capacity cores but idle
>> core first approach still places tasks to fully idle low
>> capacity cores. This patches proposal tries to move tasks
>> first to the idle SMT siblings.
>>
>> Consider the following;
>> On a system with 2 high capacity and 4 low capacity cpus.
>> steal governor of vCPU backoff mechanism calculates 2 low capacity
>> cpus should be taken off from the cpu_preferred_mask to decrease
>> experienced steal time. cpu_preferred_mask has 2 high capacity
>> and 2 low capacity cpus.
> 
> 
> In this scenario, do you still have reasonable steal time or no?

steal time should be sitting between low and high steal time
threshold values of the steal governor. (no adjustments)

>>
>> Current behavior tires to place tasks to fully idle cores first
>> even if they are low capacity cores.
>>
>>        c0(high) c1(high)  c2(low)  c3(low)  ...
>> -------------------------------------------
>> SMT 0 task     task      task     task
>> SMT 1
>>
>>
>> With the proposal, the fully idle core preference is circumvented
>> and the most fitting SMT thread is selected.
>>
>>        c0(high) c1(high)  c2(low)  c3(low)  ...
>> -------------------------------------------
>> SMT 0 task     task
>> SMT 1 task     task
>>
>> This is beneficial because at the time of contention(system pressure)
>> low capacity cores could perform worse than SMT siblings of busy
>> high capacity cores, even if there is not enough steal time for
>> steal governor of Shrikanth's vCPU backoff to mark said low
>> capacity cores as non-preferred.
>>
> 
> I read this as tunable problem of low,high thresholds to adjust
> preferred_mask same as high capacity cores. No?

No, because cpu_preferred_mask would contain some low capacity
cpus as the experienced steal time is not high enough to exclude
all low capacity cpus from the mask.

And any new task could be placed on them like below as they should
not cause an increase in steal time. See below (for 6 tasks);
(non preferred cpus marked with X)

        c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
------------------------------------------------------------
SMT 0 task     task       task     task          X        X
SMT 1 task     task                              X        X

The soft affinity should come in as full utilization of high capacity
cores(and their SMT siblings) before placing tasks to low capacity
cores (for 4 tasks);

        c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
------------------------------------------------------------
SMT 0 task     task                              X        X
SMT 1 task     task                              X        X

>> Andrea came up with an idea to extend Shrikanth's mechanism further
>> by adding a soft affinity to a selected set of CPUs. Task placement
>> would first fully load these CPUs before spilling load onto rest
>> of the CPUs on cpu_preferred_mask. That would help achieve the
>> behavior I describe above if the soft affinity covers high
>> capacity CPUs.
>>
>> The discussion is still on going though. If Shrikanth thinks this is
>> a worthwhile concept then I'd be glad to work on the implementation
>> and provide the patches.
> 
> What i don't understand is.
> - if there is no system pressure to use those low capacity cores, why
>    not use them if the task util fits its capacity. If the task utilization
>    doesn't, it won't land on them anyways today right?

Current task placement looks like this (5 tasks);

        c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
------------------------------------------------------------
SMT 0  task     task      task     task*         X        X
SMT 1  task     (**)                             X        X

Even with lowered capacities task don't migrate away from
fully idle cores, cpu selection prioritizes fully idle
cores before everything else if i am not mistaken.

The proposal with this patch series tries to circumvent exactly that
idle core prioritization and uses SMT threads first, like below;

        c0(high) c1(high)  c2(low)  c3(low)  c4(low)  c5(low)
------------------------------------------------------------
SMT 0  task     task      task     (**)          X        X
SMT 1  task     task*                            X        X

*the task that got placed to SMT1 of core1 instead of fully idle
  core3
**where the next task would likely land.

After high capacity CPUs are fully saturated, remaining low capacity
CPUs in cpu_preferred_mask can be utilized with idle core priority
once again as there are no distinction between them.
Utilizing high capacity cores(or entitled cores...) should lower
the footprint of the guest and allow less noise from guests.
Steal time(or contention) is expected first on low capacity cores
anyway.

Does this make sense?

Thank you!
-Mete
