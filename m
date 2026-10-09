Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9946C363C73;
	Fri,  9 Oct 2026 15:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791560145; cv=none; b=ELY0v0ejKeILFV/8tkN4MLYNU/Jp1pZ1yYD9hC25OUYsgK99Q5MxU2K6Uj29FxB+vfvc+5HLwelLhKWIh2gAf6MtZZJvD1afYELXMiVb49bdG48NtxQrP+eiy1G3vDfgRyfbP7YqymZtm7frxIdwjX1wkpq6a4utz6jo9pzwPzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791560145; c=relaxed/simple;
	bh=eLZFGAp13tbRG1UhFvfLm9RO4YLoFjiwBTeGubytHuI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=elwkb7E1Th6vAoZn8+NFjGA7KGBLyLp/xKwsujjn7ZtIHiwbkHnrd6kBL0n7R6MZy7uhwsOpmRGxyhmM769Aqo49tnKAt9mPryLkf6PJmNUb0YJXyXfD0Ee/Qmsnc6rcFdh/+52/iA601tB1cljbUGbIW/CtIuhwFiQWqvmaUAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=INA5QMCv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="INA5QMCv"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 699DaAFH305810;
	Fri, 9 Oct 2026 15:35:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=WlPjZj
	mMn44WezTz6ULIHTUUpzAgVDFvMdTSxpDLqfQ=; b=INA5QMCvNZb82pLFZcMzG1
	NMlSf2e+gMBCRUnW6gxD7BtneGDnRaCrjLiHuwmV87sR0MYbXFWAjParepWQOOvR
	v0J8x2g8aShJ4O2Vpiuupr40dhW+CpFiQ92d4sC04tuBznsTkljY8YD8/rCuPAVy
	ATgUHsjP2izSHf/UQzbStpAi7RFVZ6BAGCkuEPb2hKqoNoZOFs9L/WRt+LwYAZSb
	FDgeCVoS99QMApQVEsHvEKC0UMLZ/wmLe4+jKHtealn0Cbo2m0KuTc/RGYYXl5JN
	9IDLp5ImZcrhgx/LJ79Ixh3c3IHPxXCFyUbGj5Kw4HeeuUA2QArJsEI6pkVASCFw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw3j7y-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:35:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 699DWVaw965690;
	Fri, 9 Oct 2026 15:35:16 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h6x1y93uk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 09 Oct 2026 15:35:16 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 699FZDvH24445648
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Oct 2026 15:35:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02AED20043;
	Fri,  9 Oct 2026 15:35:13 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10D0720040;
	Fri,  9 Oct 2026 15:35:07 +0000 (GMT)
Received: from [9.124.216.87] (unknown [9.124.216.87])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  9 Oct 2026 15:35:06 +0000 (GMT)
Message-ID: <effe96a4-c995-4da4-aac6-bef195df36c2@linux.ibm.com>
Date: Fri, 9 Oct 2026 21:05:06 +0530
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
 <aseIPhrDGCYFtJNE@gpd4> <90454932-1d82-450a-ac4c-499acdedb9d7@linux.ibm.com>
 <ffbeae31-0e93-4386-8e0e-dba13960b283@linux.ibm.com>
 <cc926e51-7223-4d3b-9896-3ed8955b584f@linux.ibm.com> <askERc5Xa9NhAfk_@gpd4>
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <askERc5Xa9NhAfk_@gpd4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: ADF9aGqePrJFifpQJM--f8dgn-aiqiNQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA5MDA2MiBTYWx0ZWRfX7XgyzD5TkpeV
 af2Uc8dJbvslTJn4j6cwkfCTaUrRhfgzlkiFm7X1ayNefn0KXvRd9o1u68JzMAkdAs/5GApsuo6
 CTeUCSOWbtB6FflGTROwVjx0YCgVkCFIusvJlVv9Us5GM9GYKZB1gmUrAnPtqeuBd8u6PfYLn3F
 DG6hP68fhgIsMVkqvs6cBHqDS9fi5BKLKzLwnFH29gmB96gFGz8jZpPVD2A2bwHW33mcKmUUqx3
 /AoB4NylfgKEBFs8GacqYe8EEuCwTC6KQVDmb9HYDyK4i7fkbJcaJYU9kLzrkCc/sGB5Hpo/qG7
 FOeZ+LGIWo+KKXtAQ08GiqwSkL9nzBgWQccBHjgA6fPUHzG12CyIYsOrHHFYPBdAshstxuwmJ0X
 aGbG8dVdHYpc/GujDuzqbZXMEue+S91siwIUx1y7W69omQZjiNw+rUIPBj/7m5z/ZTv2rY5TfU4
 941CxcNoEGswC53cBhA==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA5MDA2MiBTYWx0ZWRfX9zpy7SGe1VC4
 eDCNX9Ha0MATz/bF5veW2Qc8J0O+OCn/eqprvnNKH7H6hAl7TfGRQKVvBGdMBGWwnGleLxehC8t
 /z2Q1HBL89VGzLoi7am4229VGDS9qpg=
X-Proofpoint-GUID: _JrJZRvpmo8oYe53wukS5d-WTtq08AcT
X-Authority-Analysis: v=2.4 cv=FLCOVOos c=1 sm=1 tr=0 ts=6ac909b6 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=XYZa9crHKDZnBR3tAk8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-09_04,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 clxscore=1015 bulkscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610090062



On 10/9/26 8:42 PM, Andrea Righi wrote:
> On Thu, Oct 08, 2026 at 09:14:49PM +0530, Shrikanth Hegde wrote:
> ...
>>>>> That might let us preserve the general preference for fully idle SMT cores while
>>>>> searching in this order: fully idle preferred cores, idle SMT threads on
>>>>> preferred cores, then non-preferred cores. This current patch series seems to
>>>>> drop the first distinction, allowing a partially idle preferred core to win even
>>>>> when another preferred core is fully idle.
>>>>>
>>>>> This would need to coexist with the steal governor's stronger use of
>>>>> cpu_preferred_mask, so I'm suggesting it as a potential direction to explore
>>>>> rather than a drop-in replacement.
>>>
>>> I think this makes a lot of sense. An approach to first fill preferred
>>> CPUs before spilling to the non-preferred cores until contention
>>> forces the evacuation of non-prefered CPUs.
>>
>> Well, when we see steal time, it usually means there is high contention and
>> we are using more vCPUs at this moment than possible.
>> So we mark them as non-preferred. Note that they are idle cpus. But non-preferred.
>>
>> That means preferred CPUs may have more than 1 task. If we spill over if there
>> is idle non-preferred CPUs, we will be back to square one. No?
> 
> I agree that CPUs excluded by the steal governor should remain avoided even when
> all preferred CPUs are busy.
> 
> I'm wondering if we should have two levels: cpu_preferred_mask acting as a hard
> affinity constraint and an entitlement-based soft affinity within that mask? The

That not what entitlement usually means. At least not PowerVM. when one creates VM,
they assign VP=Virtual Cores and EC=Entitled Cores. and Hypervisor ensure at least EC
worth of cores are always assigned to that VM. There is no need of priority within that
entitlement.

> soft affinity would prefer high-entitlement CPUs: first fully idle cores, then
> idle SMT siblings. Once those CPUs are busy, tasks could spill onto

I think when one has high steal time and hence reduced preferred CPUs, there will
likely be no fully idle cores within preferred CPUs.

Note that current logic takes out last set of CPUs and find_new_ilb iterates from
the beginning. So if there is idle core within the preferred CPUs, it will be chosen.

> lower-entitlement CPUs still inside cpu_preferred_mask, again preferring fully
> idle cores over idle SMT siblings. If all CPUs inside cpu_preferred_mask are
> busy, tasks would queue there. The soft affinity would never override the
> governor's restriction by spilling onto CPUs it excluded due to contention.
> 
As we were discussing, as long as threads don't end up on non-preferred CPUs,
we might be okay. With the above, find_new_ilb will becomes very complex IMHO
and I am not sure if it is worth it.

likely what we need is,
- Fully idle preferred Core.
- idle preferred CPU.
- any idle CPU.
