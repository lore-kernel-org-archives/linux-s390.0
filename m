Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C19339D6CC;
	Wed, 17 Jun 2026 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781726916; cv=none; b=npHtJBT78EVxNkIZkYvMBzthC9PX+w7XjS2t0CUJenAxqxyI9z7grH04l5MsQwyDhvnfiRx1Y5+HQDs53/+YUwCBRPm+5mi9VvLy+hI43XKxKNaa8TJWx+/SDLckFxMqQxMpTuARw3i5aB3vRr0s4QTfcID6Ope0flkhh1Icxmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781726916; c=relaxed/simple;
	bh=Bx3c/jVMOi+VWkgH3lSqEykOGl/1yjattbwOytTnvIU=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=slPadyOC3ao8jX/bImBkBDswp0hwunDjF7/y0FxBOEPvl6TP0tzT6kvrjFapaCy2jI8Ak3DgFn1OsjAbucw53TwlO/9g1U1HQ+MYbVLL2rUWz+RjflTCLx3879IK4QE5b+BjOBWslqdvvjm7ypgoksLSb4ElGGAEUloW+K0IKeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oRSqcmF7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oRSqcmF7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65HHmAE21082426;
	Wed, 17 Jun 2026 20:08:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=7UQEpH
	WNsKftPRwZXxQFgyNyPF/VXA7QJEhrt+D70R4=; b=oRSqcmF7CTcIiuFx+XYYfW
	ZoFjOEQzox4kjanxaTjwMF01pv/7fjbdegzp170SNQPaaS8IfBbDQB0XD44XyV2Y
	6Vhk54vsPTwPdBnaUq9rHccz1UcYLQwrmifiIEXZkxpJjX3HiZ+kb5aQZqpdPqRl
	B1iO0hMNWtEFjHdEFeblHjJQ+semmlnTo2p2AW/pmcglDQOr9KJ6Ye8Uwh/THLTv
	r54dJAq9NWJd6hrze8uCIq/53umxqsg0xx2Gswt7rboDRk+5wzIMR8ZWEXsLxivJ
	0PcoBEAvY/DYfYJjwCaolYnnZeYO4yWLP0ffPwQAQZTgaToXl26J3wrKr2CzzAow
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqvvuef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 20:08:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65HK4etx031748;
	Wed, 17 Jun 2026 20:08:13 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ev17209pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 17 Jun 2026 20:08:12 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65HK89Br9175410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Jun 2026 20:08:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4478D20049;
	Wed, 17 Jun 2026 20:08:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C487520040;
	Wed, 17 Jun 2026 20:08:07 +0000 (GMT)
Received: from [9.111.3.213] (unknown [9.111.3.213])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 17 Jun 2026 20:08:07 +0000 (GMT)
Message-ID: <8d4e52c4-081f-4e2a-a940-cb76d578324b@linux.ibm.com>
Date: Wed, 17 Jun 2026 22:08:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Mete Durlu <meted@linux.ibm.com>
Subject: Re: [PATCH v2 0/5] s390/idle: CPU idle driver
To: Christian Loehle <christian.loehle@arm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Anna-Maria Behnsen <anna-maria@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20260609-idledriver-v2-0-21c2f581d11f@linux.ibm.com>
 <0e6ff23c-b509-40eb-87f3-7b04fb066edf@arm.com>
 <93743121-2f6f-441b-8675-4eaa92647b4d@linux.ibm.com>
 <445a6ab5-3574-4493-9187-701ee7ea7c28@arm.com>
Content-Language: en-US
In-Reply-To: <445a6ab5-3574-4493-9187-701ee7ea7c28@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDE5MiBTYWx0ZWRfX9fgtdsvL8xAf
 hsmUtT2MrTa3lHoqUiFNSMjyeW+yIH83HS8ppvS0RPUID8zLv0hzbEpd3r7+4or/Bj8XsNOpusA
 FvORX4XduBVE5ve3vb/6/P4U8ms97Ck=
X-Proofpoint-GUID: D5tx-Rk4D_kdU22zI-BrKrfM7TMxB8D3
X-Authority-Analysis: v=2.4 cv=bMgm5v+Z c=1 sm=1 tr=0 ts=6a32fead cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=_9OfSwnQwpgjHCh1ApEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: D5tx-Rk4D_kdU22zI-BrKrfM7TMxB8D3
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDE5MiBTYWx0ZWRfX2OwsS+IbUwq8
 g++jtd/xxhRb9A8xAgggoU5cxOEyNv1pZsVejIXrOQzXVMsjXu58mUIl5wPs5by2NHiVBxvkPeB
 r6DI3txQCMj4HFBd4n6cQwdzsqRSeDfu2Twh5fU0C4Wl/+ED/jRsvtH5KL+19cX1q0K2cLlPGd5
 lZj/c7KKoNm5UnJlO/n0CVHUdw5CQzkVuUPY2FpiNAFgePefBttikO9voCN7FhDMFt3bkEVZzP4
 PKe7RAkjByNkNIQiCNW5RdQpqvb/3ujZQoF0iktKpxRQq7TPtN+7QnPZ1vR8CU31bxbUNHJS4KJ
 0Sw1geMHvc+JR5Dcxisdaz5yX6nC+edM43iogfKgWn0sPRmNpJU7pgi1iCdnfBuHU7TtEFOZsmq
 l8I1cGK4fdkBWkmB9qA95ciHH/Ftx9S1DooItbke/2Hh4ToYTQH9gBNgoctqC2l0MhTSPC7Jt8f
 Jgn0K591DTgfjJOo2lQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_02,2026-06-17_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 priorityscore=1501 phishscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170192

On 6/17/26 9:15 AM, Christian Loehle wrote:
> On 6/10/26 21:23, Mete Durlu wrote:
>> On 6/9/26 5:47 PM, Christian Loehle wrote:
>>> On 6/9/26 14:24, Mete Durlu wrote:
>>>> v1 -> v2:
>>>>
>>>> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
>>>> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>>>>     (Christian Loehle)
>>>>
>>>> This patch series introduces a CPU idle driver for s390
>>>> architecture that leverages the existing cpu idle infrastructure and
>>>> TEO (Timer Events Oriented) governor to optimize idle state selection
>>>> based on timer events and interrupt patterns.
>>>

...

>>
>>>> - Configuration
>>>> -----------------------------------------------------------------------
>>>>
>>>> Idle state parameters are tuned per hypervisor type after benchmarks:
>>>>
>>>> **LPAR:**
>>>> - Polling: 5us target residency, 0us exit latency
>>>> - EW: 5us target residency, 5us exit latency
>>>>
>>>> **KVM/z/VM:**
>>>> - Polling: 1us target residency, 0us exit latency
>>>> - EW: 1us target residency, 1us exit latency
>>>>
>>> I think this would also be useful in cpuidle-s390.c in particular the
>>> different residency+latency values for LPAR and KVM/z/VM and what they aim
>>> to achieve for you.
>>
>> We can put down a comment like below;
>>
>> /*
>>   * After various benchmark runs the tuneables for idle driver has shown
>>   * the best performance with the following values;
>>   * for LPAR:
>>   * - Polling: 5us target residency, 0us exit latency
>>   * - EW: 5us target residency, 5us exit latency
>>   *
>>   * for KVM/z/VM:
>>   * - Polling: 1us target residency, 0us exit latency
>>   * - EW: 1us target residency, 1us exit latency
>>   */
>>
>> Is that what you are looking for or something more extensive to cover
>> what sort of behavior it causes and why it benefits the performance?
>> I wouldn't really like to put down lengthy comments here to be honest.
> 
> Why not?
> At least to me the values are hard to follow and without knowing what they
> represent.
> For example is this actually the worst case exit latency for these systems?
> Also from a cpuidle perspective residency == latency isn't outright wrong
> but certainly always a little suspicious.

Since s390 is running virtualized machines, the values are not
deterministic. The values picked here are the best estimates backed by
testing. That is why I didn't want to put anything down initially but
of course the comment can also describe that. I'll add that in the
next version.

>>
>>> Additionally polling is initialised to 0/0 by poll_state.c, so I don't know
>>> where you're taking these values from?
>>
>> Having a look at the implementation of poll_idle() in poll_state.c.
>> The polling time limit (target_residency) is acquired from
>> cpuidle_poll_time(), which tries to find an enabled state deeper than
>> polling state and returns its target_residency. Since we only have two
>> states, it automatically means EW state's target_residency, or
>> IDLE_POLL_MAX if it is disabled.
> 
> I agree that cpuidle_poll_time() can derive the polling time limit from a
> deeper enabled state, but it only does that for states with
> target_residency_ns >= CPUIDLE_POLL_MIN (10us). With the proposed s390 EW
> values of 1us/5us, that state is skipped and the poll limit falls
> back to CPUIDLE_POLL_MAX (TICK_NSEC / 16).

Ah missed that CPUIDLE_POLL_MIN is 10us and had it wrong as less or
equal to 1us. For 1000Hz CPUIDLE_POLL_MAX calculates to 6250ns
which is close enough for LPAR (5us) but for KVM and ZVM case (1us)
it is a bit off.

Although, the benchmarks didn't reflect a problem. To verify I did
a quick test run with the following applied on a KVM and a ZVM guest;

--- a/drivers/cpuidle/cpuidle-s390.c
+++ b/drivers/cpuidle/cpuidle-s390.c
@@ -72,6 +72,20 @@ static int s390_cpuidle_cpu_dead(unsigned int cpu)
         return 0;
  }

+static void __init s390_cpuidle_poll_tune(void)
+{
+       struct cpuidle_device *dev;
+       int cpu;
+
+       for_each_present_cpu(cpu) {
+               dev = &per_cpu(cpuidle_dev, cpu);
+               if (machine_is_lpar())
+                       dev->poll_limit_ns = 5000;
+               else
+                       dev->poll_limit_ns = 1000;
+       }
+}
+

This causes cpuidle_poll_time() to exit early as poll_limit_ns is
already set for the polling cpu.

The results are quite similar to original benchmark results I collected,
therefore I don't think it is worth adding it to the patch series.

...

That said, one could argue that the value of CPUIDLE_POLL_MIN could be
reconsidered. Looking at the comments above and also the introducing
commit 7a25759eaa04 ("cpuidle: Select polling interval based on a 
c-state with a longer target residency")

```
/*
  * Min polling interval of 10usec is a guess. It is assuming that
  * for most users, the time for a single ping-pong workload like
  * perf bench pipe would generally complete within 10usec but
  * this is hardware dependent. Actual time can be estimated with
  *
  * perf bench sched pipe -l 10000
  *
...
#define CPUIDLE_POLL_MIN 10000
```

- On s390 "perf bench sched pipe -l 10000" results in usecs/op values
in between 0.9-3.5 usecs.

- On my x86 laptop this range is between 1-2 usecs/op.

Based on that observation and reading the commit message I'd say
there should be some improvements possible there but, this should
be tackled with a different patch series. In fact I'd like to give
it a go after this patch series.

Thanks for having a look. I'll send a new version shortly.
