Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FE2A47255A;
	Mon, 12 Oct 2026 12:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791808405; cv=none; b=jBgk0bI8BL3f7hMIbOSeoBV8gK3q7NPwWecI52+PQSSFqSimURImSqowO7SQkVCkTL9zzvu23BCVlb87aMsWtfXF9viZRrJ07BzzbgIl7+7tvBqvgl7c1hxR+U0lYiDWIca91Lh9HGVx5twpLoyfL57SXUue0yOsDcB4MsEj2Is=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791808405; c=relaxed/simple;
	bh=7vTfPz8fNhJWn87an4pITaOOv8N3fWD28RpTcB3AByo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sLu8vAZaEkAE2H8qoaRDwo4P003VcHe1MSMl6VgX+n6klNcQhXOQ2J15mknWycqnEgGIXoPd+nTMBYA7/9LmKt/pGa46th3cp3jRhXbu+XKEOpJlAWcxuhJ0Xcph8XF3UBgYqGxACkxa2OQz+YTcK8HaqALOM8ZsgEg5X1WMrKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CuPVwyox; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CuPVwyox"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCEUlk073775;
	Mon, 12 Oct 2026 12:33:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FyWUeM
	JNFB4lUSeSpe1i4usJzcakGpj2RGshi8Ors5s=; b=CuPVwyoxABGLapm8jXXYQU
	rA+B1xxZS6m1iVujQLTbHFSTafpIro1tNrHVVUIBpe9WEGoXnECGZxteUV+R+FCW
	xEasaL40LCu0GqePfJycGcvQ7jkKBH1z3oYjpkAAOdryUHH6/lcB0f3n778p1ujA
	GhQMl8AyZvSu//gUbIedx6H1cS2LEGY+QJ3x1wf8jZuZAThI+rFn7P+AMqFnpqGi
	DChO5YlbNqTVxT0Xz4iozTKrP63fH5QYkb7ojwm1T7SAUcUjc29wu2iH7BTOxDGW
	XdNwAifLNZqtLNBEViVXgxg7TN2l0lANZTmdxVKGCbc2EZ/HJWJ+x5oZBBQhR0SA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhrjbq-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:32:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4s2f1286752;
	Mon, 12 Oct 2026 12:32:58 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gw1xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 12:32:58 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CCWsNe47579490
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 12:32:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EA6C20043;
	Mon, 12 Oct 2026 12:32:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C0CF120040;
	Mon, 12 Oct 2026 12:32:53 +0000 (GMT)
Received: from [9.111.15.190] (unknown [9.111.15.190])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 12:32:53 +0000 (GMT)
Message-ID: <6c4fcef6-6ff8-4733-a451-53744d2c821d@linux.ibm.com>
Date: Mon, 12 Oct 2026 14:32:53 +0200
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
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com> <askERc5Xa9NhAfk_@gpd4>
 <effe96a4-c995-4da4-aac6-bef195df36c2@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <effe96a4-c995-4da4-aac6-bef195df36c2@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX8ofZe4vNB00l
 HAFwQFHRnAlekgIpOe8SLLc8xdJM7Gnd7aU5mow0xyyLBiSFUALaAu0T3O3TR0XtJfG6KK+/o9O
 fs9F50cu3qZAGD97hHH8ETK6Egp3ykDIWTRfhpZCn+PinntHVAeLg6ru2luc+IeP1vKSq+IRZjR
 sHQTsf+N0C888Hn0ESedz12t6DRfCLTVCo8NLUt+iqRzX/biMSSwKxMaTbUf2h3BxrswFU0V7l6
 IDIs8Ksu0pOxSEavcoxj7xvWPtj3TtYkgbRlykidf+cBZ/7AGaT8Oo8gCgoBLFj10Y9vq+WaRp/
 VZHe+0eyBh5lsWjQ+Wegz747A/6Z5qR8/NozmzSI0FTxrq5mTpPxkAB0IarhwaVUgUxw1kZiCAi
 m/J599wa+e0tAhnsFAM9sgjYcZxsSqDiI+0JGIXQFGmNTHBbLuiEfd7r+Tgp7+djnI7jgI3WE7N
 P6SGLBKYBmyvyMhn3Lg==
X-Proofpoint-GUID: iVb9FMcT0SbeTSyvJCgFGTQf-6bshjdL
X-Proofpoint-ORIG-GUID: NrZ5GDOAGjp7ev5lS-xIwRPbO877Skqm
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0OCBTYWx0ZWRfX0L9p4DoUKT5Z
 oqYEPWq+8xv9u3FqlHgP+RsVjkUJE8FTJqIxcA+FzJoT9HVE9mGgM13TQ8FkcN9EL/2enEqK7qJ
 iLUAavy30gt4pFjKsashxULWv1RMvvQ=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6accd37b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=tkh5zrSn6ICSXLwhzbEA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120048

Hi,
sorry for the late reply, I have been sick since Friday.
I though about what has been written for a bit.

>>> Well, when we see steal time, it usually means there is high 
>>> contention and
>>> we are using more vCPUs at this moment than possible.
>>> So we mark them as non-preferred. Note that they are idle cpus. But 
>>> non-preferred.
>>>
>>> That means preferred CPUs may have more than 1 task. If we spill over 
>>> if there
>>> is idle non-preferred CPUs, we will be back to square one. No?
>>
>> I agree that CPUs excluded by the steal governor should remain avoided 
>> even when
>> all preferred CPUs are busy.
>>
>> I'm wondering if we should have two levels: cpu_preferred_mask acting 
>> as a hard
>> affinity constraint and an entitlement-based soft affinity within that 
>> mask? The
> 
> That not what entitlement usually means. At least not PowerVM. when one 
> creates VM,
> they assign VP=Virtual Cores and EC=Entitled Cores. and Hypervisor 
> ensure at least EC
> worth of cores are always assigned to that VM. There is no need of 
> priority within that
> entitlement.

Wouldn't it make sense to first fully load entitled cores before
moving onto virtual cores on Power? On s390 we would definitely
benefit from it on some cases.

>> soft affinity would prefer high-entitlement CPUs: first fully idle 
>> cores, then
>> idle SMT siblings. Once those CPUs are busy, tasks could spill onto
> 
> I think when one has high steal time and hence reduced preferred CPUs, 
> there will
> likely be no fully idle cores within preferred CPUs.

Shrikanth, wouldn't something like below still make sense?

> Note that current logic takes out last set of CPUs and find_new_ilb 
> iterates from
> the beginning. So if there is idle core within the preferred CPUs, it 
> will be chosen.
> 
>> lower-entitlement CPUs still inside cpu_preferred_mask, again 
>> preferring fully
>> idle cores over idle SMT siblings. If all CPUs inside 
>> cpu_preferred_mask are
>> busy, tasks would queue there. The soft affinity would never override the
>> governor's restriction by spilling onto CPUs it excluded due to 
>> contention.
>>
> As we were discussing, as long as threads don't end up on non-preferred 
> CPUs,
> we might be okay. With the above, find_new_ilb will becomes very complex 
> IMHO
> and I am not sure if it is worth it.
> 
> likely what we need is,
> - Fully idle preferred Core.
> - idle preferred CPU.
> - any idle CPU.

Andrea does this resemble what you were describing;

1-) (steal time == 0)
====================================================================
cpu_preffered_mask = active_cpus
cpu_soft_affinity = 0

All cpus are available for scheduler to pick and use.
Idle cores are preferred in case of asymmetric capacities.

2-) (steal time > 0) && (steal time <= initial_threshold*)
====================================================================
cpu_preffered_mask = active_cpus
cpu_soft_affinity = entitled cpus

In this case entitled cores get fully filled (SMT siblings first)
before spilling load onto the rest of the cpus on preferred mask.
*Initial threshold is a value I just devised. Ideally arch specific
and dynamically configurable, setting it to just 0 should also
be an option.

3-) (steal time > initial_threshold)
====================================================================
cpu_preffered_mask = entitled cpus + steal governor's modifications
cpu_soft_affinity = entitled cpus

Carrying the logic from case 2 but shrinking the preferred mask
according to the increased steal time value.

Shrikanth/Andrea,
does what I describe above make sense and would it make a reasonable
addition to the vCPU backoff mechanism?

*Considering guests with hardware based topology and underlying
hypervisor scheduling vCPUs per core;
I'd expect this approach to allow for guests having a smaller
footprint for longer and steal time to start appearing later than
usual as the entitled cores are fully utilized before touching other
cores.

*This is the case for s390 for example. I am not sure if it is the same
for Power or any other architecture.
