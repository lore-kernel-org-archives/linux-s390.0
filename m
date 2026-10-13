Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DF63E7160;
	Tue, 13 Oct 2026 10:25:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791887110; cv=none; b=N6eO+nBydzPciznJ/P46kbxMJoJs1mCPadWBUecnNc5cnIQXDjv9kYn0yMH80t/4/RxvBJV6TXL2Ej658XD6FOhD8RDqORIOnRkx1EQX16SGO2KibIpdVkVeIcywX9R7RwdMhy0QIz1HyrnEdAuqPUfOUpu7jwAEJlRzBRrZ6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791887110; c=relaxed/simple;
	bh=BesGa+ZE6vlglbtO/iwDKisX92xov84fto8sWY9CkRA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JB5zRxQZAMC6Lw9rtB0qi0pyjaNqfVPjjirPDJlq9X8ywO7pu1fSV/TeP2yBMclzAVfKmulomcQSpcThXlDiiqBVcMctiTW1aGfGmqk6bxxo6Wt6X+DrpWQQZHlB2FPeKKvHxUcYxnrgdwugqjZ6WNh7QMFbH9oDHb0ll0vJ08w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p0kEhrah; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p0kEhrah"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EI3N1774555;
	Tue, 13 Oct 2026 10:24:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=QMG155
	OrXkbNDZgeHu5GM4zQOFcLYOJPsd29E5WNifU=; b=p0kEhrahRA4ZlPBJvpE97f
	1OVuaZZOnOt1o22uH/6r3US369NZtuK8nASngjhtARhp2+vWHxDKvym1g1N0qX9Q
	6R9CPUjb16MDgEGbJhosNyev61vPHZb+dFgitMOXs/36T9psSMzOjItjx6wkOz32
	TOw24RpN0Ug5YjcTczO4JgUSCMHaB7qfwa5pCgx8BV/jKowIrwGbeAi+hWWaQA+Z
	9zqYbn8jQ2thRBnBJQhcdcvnv/v/eg8AFBhWOnkQ1l1HRNS5oCLHDNRKXfHIf4Y9
	qo9C/UKWDCYAmu+DSIgR/+kRH89SX3C+MxxhPPEmZw1fZbFWH8/4dEcsQE39QnBw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dwhw1xx-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:24:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8ToTi2712646;
	Tue, 13 Oct 2026 10:24:42 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h82cyh007-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 10:24:42 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DAOcS051577336
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 10:24:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 083BA2004B;
	Tue, 13 Oct 2026 10:24:38 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309D520040;
	Tue, 13 Oct 2026 10:24:37 +0000 (GMT)
Received: from [9.87.128.189] (unknown [9.87.128.189])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 10:24:37 +0000 (GMT)
Message-ID: <e7fd7d50-b124-42a0-ac19-ec12cca532bd@linux.ibm.com>
Date: Tue, 13 Oct 2026 12:24:36 +0200
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
 <6c4fcef6-6ff8-4733-a451-53744d2c821d@linux.ibm.com>
 <58c8e6cd-3fbe-4975-a0f3-9a16d5b7c604@linux.ibm.com>
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <58c8e6cd-3fbe-4975-a0f3-9a16d5b7c604@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX+mwglDS7TlA0
 wEOkOvzNGSwn9cxj6/6q3nOm1D/HjiqEiV469Z0JMtfPSChA+enoplACmsWS0l+Ab1MdG2VEXnt
 Q3TE7i4vPXhX1eNtK+StkyGKDajRQmjUc2JDvnObDFumst9z7HAk1Iv6nTgdh2vPuIZdUrlxMHJ
 F0wSfpOV2OcHJsIoUGDot1f5V6RjmES3RyBrWCd246XAeCuRC50phSzadrjjO3Ei0/6Rlm5RO3p
 yFvnDbglCbuyKnDKNHfpyB17nFiFB89WtDeWo0wk879xWtIxFpZr065FvWpCy0u60tmFgMY4VlA
 94Bzy0JMF3/GuXVqFfEJiPMRzqbwxphrHoaWl57rBpxMCDcU65yV+QF8beQEzfuWMr/rFhQNOE0
 pKl+AaD58Ug/2OdjG1pzSg6fNP55hfT7HWngxcRkRYZzC2y22RqObj3NAs3e5++TB8VdmCXGtZA
 IOxOlBSQE3TBpp8o48A==
X-Proofpoint-GUID: NBk7Xm5vPZSzoleDnEaVakd7_MUC9CHa
X-Proofpoint-ORIG-GUID: lv6dQPorUed_3kQ1HVn8JFsOWKitL826
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA0MCBTYWx0ZWRfX3B3tP216irDv
 u9bV1fsqw74Mhdp5fqZF/iGmQMK+Nh3smCeveP0MrCl6TVlzmyTZoSFn5p1VMsrjFe83paO0htU
 qg6V8CohJbdPwNryf9u2RZS/xfBb5kU=
X-Authority-Analysis: v=2.4 cv=btHZl0ai c=1 sm=1 tr=0 ts=6ace06eb cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=nSUF7N_Uqdeu1bfaXI4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 phishscore=0 impostorscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130040

[..snip..]

>> Andrea does this resemble what you were describing;
>>
>> 1-) (steal time == 0)
>> ====================================================================
>> cpu_preffered_mask = active_cpus
>> cpu_soft_affinity = 0
>>
>> All cpus are available for scheduler to pick and use.
>> Idle cores are preferred in case of asymmetric capacities.
>>
>> 2-) (steal time > 0) && (steal time <= initial_threshold*)
>> ====================================================================
>> cpu_preffered_mask = active_cpus
>> cpu_soft_affinity = entitled cpus
>>
>> In this case entitled cores get fully filled (SMT siblings first)
>> before spilling load onto the rest of the cpus on preferred mask.
>> *Initial threshold is a value I just devised. Ideally arch specific
>> and dynamically configurable, setting it to just 0 should also
>> be an option.
>>
>> 3-) (steal time > initial_threshold)
>> ====================================================================
>> cpu_preffered_mask = entitled cpus + steal governor's modifications
>> cpu_soft_affinity = entitled cpus
>>
>> Carrying the logic from case 2 but shrinking the preferred mask
>> according to the increased steal time value.
>>
>> Shrikanth/Andrea,
>> does what I describe above make sense and would it make a reasonable
>> addition to the vCPU backoff mechanism?
>>
> 
> I am confused. Are you talking about
> 1. picking CPU to run idle load balancing?
> Or
> 2. actual task placement decisions?

I was talking about actual task placement decisions. I didn't really
consider where idle load balancing should take place tbh. On s390
even if it takes place on a non-preferred CPU, there shouldn't be
too much of a penalty. Is there a specific reason why you are asking
for idle load balancing case? I might be missing some conceptual depth
here.

[..snip..]

> If it is 2, I am not sure. getting soft affinity is kind of tricky with 
> load balance.
> It puts maximum effort in spreading the tasks. Since you have steal 
> time, there is already
> enough tasks to create physical CPU contention.

I am not fully familiar with vCPU backoff yet, but couldn't the
soft affinity be implemented in form of another cpu mask. We can
traverse the new mask to make decisions there first and after its
resources are depleted there, we can then move onto cpu_preferred_mask?

> PS: Steal governor provides a tunable named low_threshold, which means 
> any steal value
> below is practically 0. So there is no soft affinity there.

Right, my initial instinct was to have an initial threshold like
the low_threshold steal governor already has. I am not sure if it
is a good idea to just use that with a higher default value but
I need to think about this a bit more.

What do you think, does it worth exploring?

Thanks!
-Mete
