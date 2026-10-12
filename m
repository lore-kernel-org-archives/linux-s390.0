Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88B1451991;
	Mon, 12 Oct 2026 13:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791813034; cv=none; b=S8wePFl2RvfWz1B5ZtgvJ8HgDYWcxq8lbvWTN6rDOviMJ0twv6PgzG+WhFo4YhL77J0uj7zewcq7cIrli7+xUXkGLyOKAgIkjr+hZacsj/Bxo1SF2wHZpYpUE506vVksInpfhCbhw1FNwsEh/kjz2DP4gI7Lvf8nEcXNKNpDe44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791813034; c=relaxed/simple;
	bh=saz7bni8UyZZ2wuWhgBhDzCLXiD9M7QD1xEEe3ZCbR0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jAI4dPRK9HmiiMbQFBBIRsOJJ5GBKn/NsN4XPpxirVpiKoozDdeGtJMCsSc2YxAyDHs1ND0I694a3eKUZJghXvQL5mMxdnOjYdqhoUq3Cq+KpVIfRwSgifcR0hRZKbM7yrWVSfv82+0bP8Z4tG9/TOKv3dEQgwmaaneq63BguVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jMoCbSR/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jMoCbSR/"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69CCE8Z6316315;
	Mon, 12 Oct 2026 13:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=m9XrfL
	lFdOfMqg6YGcL8czVCbU54w9IACGSuHuF0dhQ=; b=jMoCbSR/8HZdhPfPr8fPAf
	5pUpAWDSJifL2ek8USrhXy5Ew04zgQBcvmOeyIaRTCXIDoaKxwV1bCYuf2H5rcuL
	fOoBtnwmj+ucbXkMl11rHxN2WfLsKQlhjvR2oBO0+jDiBoxfAUy+2LGH99xX880W
	B4buULBXbAvqAtILimUp5A9TnLDmX8gUm2OxAgRecpmm5Auz7VewNzguDPQEWUp7
	9UtP0u1aogizTcMEYTu5zogoyFiyU2QqWpvafq47Cs0tm/9vx/mn2Od4rBP5I8Ew
	pOPln+X/a9o3fdQOWAcvpHgmRlwyJcQdaZbhbFxURvzzEzu0NXJT7D+VMMQ0nZug
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dug96rg-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:50:08 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69CC4xFm1287098;
	Mon, 12 Oct 2026 13:50:07 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h816gwb9a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 13:50:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CDo2mD42926560
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 13:50:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC95A20043;
	Mon, 12 Oct 2026 13:50:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1C24E20040;
	Mon, 12 Oct 2026 13:49:58 +0000 (GMT)
Received: from [9.124.214.197] (unknown [9.124.214.197])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 12 Oct 2026 13:49:57 +0000 (GMT)
Message-ID: <58c8e6cd-3fbe-4975-a0f3-9a16d5b7c604@linux.ibm.com>
Date: Mon, 12 Oct 2026 19:19:56 +0530
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
 <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com> <askERc5Xa9NhAfk_@gpd4>
 <effe96a4-c995-4da4-aac6-bef195df36c2@linux.ibm.com>
 <6c4fcef6-6ff8-4733-a451-53744d2c821d@linux.ibm.com>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <6c4fcef6-6ff8-4733-a451-53744d2c821d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Cr0q4X4D c=1 sm=1 tr=0 ts=6acce590 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=TxRU7OXsotaLDgitQIgA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 6TL4JQImcHe9Bon6KYTJfWfszdZ7tWGt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfX6f7hc69ezFQZ
 b08qtdln7LJ7KW0F08ltZ3qTWYO0KN48SCeBs5AF8uIUFd39969BuurY/l9HVmHczVn6QdJ2g6t
 M9w+/S6Xqzq/E85UjnaEWA7TIeycDJhUa2Ztp+yGpu8OsHrr8TnC4y9YhSWPI+KOV1hsNV/Yrnk
 tNnkJ2rzLwQO8QAQBHNp1juQadVWuYDDZQmJe2e/vx5wY0GbQIdYk/iCAospJg2ns5hOD0AwiLZ
 1Gx9DqJDjx0+MMWCa3qGOuLleVNQ1aW2QCgS0Len5PS7AxCQPdU3xd+q/bKUFxFevPIeCCokJRu
 RPYTBP38qXo1HT1mx4/LTzMsRx4Mxxd7pEW4I8yFclUg042kuYrHT1vrW8CMTWn+XC8fKxxGARj
 AtO6v/CaNi5k8cZNCkUU7FTnYA81vl3Mhtst7xy5sSN4sJAQW2t/jSnmFinUwtc11QA21KbQh5c
 hDi6cl7otIle06XbQhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA1NCBTYWx0ZWRfXxWf70FXxiqDU
 1FZvAq56sas8LzVj4Bw6b0Ap+c3yQ9CLGplm84LlrNxlR111AmefTp00UHMdtHq0SS891eK8QKe
 PknokOzcruXactiQtDEifDmBjvt8YEw=
X-Proofpoint-ORIG-GUID: hNTLNnEFM3yjKDViKzPbX2siEb0OsnF8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_04,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120054

Hi Mete.

On 10/12/26 6:02 PM, Mete Durlu wrote:
> Hi,
> sorry for the late reply, I have been sick since Friday.
> I though about what has been written for a bit.
> 

No issues. Take care.

>>>> Well, when we see steal time, it usually means there is high contention and
>>>> we are using more vCPUs at this moment than possible.
>>>> So we mark them as non-preferred. Note that they are idle cpus. But non-preferred.
>>>>
>>>> That means preferred CPUs may have more than 1 task. If we spill over if there
>>>> is idle non-preferred CPUs, we will be back to square one. No?
>>>
>>> I agree that CPUs excluded by the steal governor should remain avoided even when
>>> all preferred CPUs are busy.
>>>
>>> I'm wondering if we should have two levels: cpu_preferred_mask acting as a hard
>>> affinity constraint and an entitlement-based soft affinity within that mask? The
>>
>> That not what entitlement usually means. At least not PowerVM. when one creates VM,
>> they assign VP=Virtual Cores and EC=Entitled Cores. and Hypervisor ensure at least EC
>> worth of cores are always assigned to that VM. There is no need of priority within that
>> entitlement.
> 
> Wouldn't it make sense to first fully load entitled cores before
> moving onto virtual cores on Power? On s390 we would definitely
> benefit from it on some cases.
> 

Only when there is a high physical CPU contention.

>>> soft affinity would prefer high-entitlement CPUs: first fully idle cores, then
>>> idle SMT siblings. Once those CPUs are busy, tasks could spill onto
>>
>> I think when one has high steal time and hence reduced preferred CPUs, there will
>> likely be no fully idle cores within preferred CPUs.
> 
> Shrikanth, wouldn't something like below still make sense?
> 
>> Note that current logic takes out last set of CPUs and find_new_ilb iterates from
>> the beginning. So if there is idle core within the preferred CPUs, it will be chosen.
>>
>>> lower-entitlement CPUs still inside cpu_preferred_mask, again preferring fully
>>> idle cores over idle SMT siblings. If all CPUs inside cpu_preferred_mask are
>>> busy, tasks would queue there. The soft affinity would never override the
>>> governor's restriction by spilling onto CPUs it excluded due to contention.
>>>
>> As we were discussing, as long as threads don't end up on non-preferred CPUs,
>> we might be okay. With the above, find_new_ilb will becomes very complex IMHO
>> and I am not sure if it is worth it.
>>
>> likely what we need is,
>> - Fully idle preferred Core.
>> - idle preferred CPU.
>> - any idle CPU.
> 
> Andrea does this resemble what you were describing;
> 
> 1-) (steal time == 0)
> ====================================================================
> cpu_preffered_mask = active_cpus
> cpu_soft_affinity = 0
> 
> All cpus are available for scheduler to pick and use.
> Idle cores are preferred in case of asymmetric capacities.
> 
> 2-) (steal time > 0) && (steal time <= initial_threshold*)
> ====================================================================
> cpu_preffered_mask = active_cpus
> cpu_soft_affinity = entitled cpus
> 
> In this case entitled cores get fully filled (SMT siblings first)
> before spilling load onto the rest of the cpus on preferred mask.
> *Initial threshold is a value I just devised. Ideally arch specific
> and dynamically configurable, setting it to just 0 should also
> be an option.
> 
> 3-) (steal time > initial_threshold)
> ====================================================================
> cpu_preffered_mask = entitled cpus + steal governor's modifications
> cpu_soft_affinity = entitled cpus
> 
> Carrying the logic from case 2 but shrinking the preferred mask
> according to the increased steal time value.
> 
> Shrikanth/Andrea,
> does what I describe above make sense and would it make a reasonable
> addition to the vCPU backoff mechanism?
> 

I am confused. Are you talking about
1. picking CPU to run idle load balancing?
Or
2. actual task placement decisions?

If it is 1, we should do only if there is any good improvement with real life workloads IMHO,
as current find_new_ilb isn't aware of preferred CPUs. Even in that case just picking
an idle preferred CPU over an idle non-preferred Core is better than above i think.

If it is 2, I am not sure. getting soft affinity is kind of tricky with load balance.
It puts maximum effort in spreading the tasks. Since you have steal time, there is already
enough tasks to create physical CPU contention.

PS: Steal governor provides a tunable named low_threshold, which means any steal value
below is practically 0. So there is no soft affinity there.
> *Considering guests with hardware based topology and underlying
> hypervisor scheduling vCPUs per core;
> I'd expect this approach to allow for guests having a smaller
> footprint for longer and steal time to start appearing later than
> usual as the entitled cores are fully utilized before touching other
> cores.
> 
> *This is the case for s390 for example. I am not sure if it is the same
> for Power or any other architecture.

