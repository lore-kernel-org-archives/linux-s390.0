Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5543C25A2B5;
	Mon, 15 Jun 2026 12:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526273; cv=none; b=fHFhEkHyC2ARb25GJs/1r4WhEyonJkD9vujXWtHspdyt99ZJAZndA8BuA0pZiHveWVwDUNBYgAPtlsFafxMe2L18bCMG+5MB2pJfOS9PSs2GkYT7Dhc1rmKLwGcMq61mGs49iMO2b37jwnFZaWvr8a80S7ZLvj7MESBBr42No2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526273; c=relaxed/simple;
	bh=leTtsnbQUSBuYpbxmDpPKrMDWRwumYam6boqCKVbK44=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=N+z4aQyoxS/ojy369iBaqswSN5iYQ9cQ+NtaksxEa3hPC7vuhvLLLqfwXZmieHgehWarUTUxFMxiD9YTLhASP6JmvbqJCygwJ1ji1+ByZDVYV7ds6AnNRlFNikeVAtcJBFHWKCGcHULe3taRUQBId2916S/KR7XYJa1JK4nsdkw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V3zubmfv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V3zubmfv"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65FAnx3x2208632;
	Mon, 15 Jun 2026 12:24:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=43zrG/
	lqIja6Nj1gFOnMtTe6Ilzxo6wGMINxqkkgKOg=; b=V3zubmfvXoKeeYVTvE+AMG
	5FlQXSWNK+5NhaYiikDo+IarXs/9vrCyQq2Df1XUVc4lj1c4YO3FX4v7ovFy7aoN
	RRfPbslBL5d93xWxu76CGpn4BHCVOgKpse8WsgMrRDkuQuK1ltgSdfAQqmnm3YJB
	5VqckMphGaP26igsfPLpZY+g3X09U270HM5W3qcjUXdNmoOVWsVvhN1qgn8jQIrn
	u0qmoHaubQZaX5WQB/kWsJ4dZUirER3Ht2EWHn/sqqQ2erETwv0Hb/CD7VdmV/Ti
	C99dqC/PzgU0daBVPKQdhsMX8UBybxVp65+9uqRKc8pcEY07v71wYnpixYD3qDog
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es1wm0djg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:24:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65FCK0e6021832;
	Mon, 15 Jun 2026 12:24:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4eshwvxkjr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jun 2026 12:24:22 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65FCOIBV30015824
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Jun 2026 12:24:18 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4236D20043;
	Mon, 15 Jun 2026 12:24:18 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CDBC20040;
	Mon, 15 Jun 2026 12:24:17 +0000 (GMT)
Received: from [9.111.18.219] (unknown [9.111.18.219])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 15 Jun 2026 12:24:17 +0000 (GMT)
Message-ID: <be2ce509-044f-423c-8193-a362406e06fb@linux.ibm.com>
Date: Mon, 15 Jun 2026 14:24:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/5] s390/idle: CPU idle driver
From: Mete Durlu <meted@linux.ibm.com>
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
Content-Language: en-US
In-Reply-To: <93743121-2f6f-441b-8675-4eaa92647b4d@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXxTOQwqV2ivc4
 x5bX+DAyYDGy6s9NcQoQvstlqFnYoMY56G0vXEtxrqBLoj7YXvRxxNBg0WvER7mEeX324q6GDOM
 M32JagLKh0ILc4gmK92phcm8p7swTyI=
X-Proofpoint-GUID: fOaqiFr3-Qs4U0EJ2k_hqnriqGqDle0Y
X-Authority-Analysis: v=2.4 cv=SY/HsPRu c=1 sm=1 tr=0 ts=6a2feef7 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Tj-U9SRQbjztqdnpS5oA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDEzMCBTYWx0ZWRfXzKGpeOQl47Ul
 l6CArIdR9cMGXl+XsJK96lqBQtDCRuxr48sr8QUDeODf+ed+6myXS0LXy+asWf/RcHralkFsDlr
 o/sQP8FwAD5aU4GTIsQjmMjzMeRnwIQIpZpU2fRW8tAtSxs3Rc4BZxSy+CMYXVqPiIKnXKBUPC1
 yAXjtoPxsx6Zg7YLgj05QRO7IUx61mqEynXG7+OIXXeOv9SGS9gyXjQVpd5NkOLkARABkurYDpV
 dG1cKOv5IUXd1tsAtmx69rD8abHzlYMmMizD8ahE+gJc03AIG713WQdylY8/8tPe+uzZUUyutlG
 uI8NsYhL5jVNu+CPyk7ctdP1gPRvSOoLlrspFjjPJvzbq+QAR1XlNza3Ke9RmTZFKP3Sl04r9yt
 fBSJ7nki7Zzcx7Ng/REIDmrsVmgzwpugmPq+Ln1wtxazpZ1BTjt6W7xIrHcLZsZni1asBXlNJIZ
 OzYg7dAJqojkST0ArfQ==
X-Proofpoint-ORIG-GUID: fOaqiFr3-Qs4U0EJ2k_hqnriqGqDle0Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-15_03,2026-06-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 phishscore=0 suspectscore=0 spamscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606040000
 definitions=main-2606150130

On 6/10/26 10:23 PM, Mete Durlu wrote:
> On 6/9/26 5:47 PM, Christian Loehle wrote:
>> On 6/9/26 14:24, Mete Durlu wrote:
>>> v1 -> v2:
>>>
>>> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
>>> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>>>    (Christian Loehle)
>>>
>>> This patch series introduces a CPU idle driver for s390
>>> architecture that leverages the existing cpu idle infrastructure and
>>> TEO (Timer Events Oriented) governor to optimize idle state selection
>>> based on timer events and interrupt patterns.
>>
>> So if (according to v1) there's no data (yet) that teo is much preferred,
>> I would remove all mentions of it in code and patch descriptions?
>> A cpuidle driver requiring a specific governor sort-of violates the
>> abstraction.
> 
> True, s/TEO governor/idle governor/g + s/TEO/idle governor/g should
> be good enough.
> 
>> In case teo does work much better for you, which I wouldn't doubt for
>> a second from what your system looks like, it would be nice to present
>> some data on it. Additionally I think setting it in the defconfig alone
>> is probably enough?
>>
> 
> I ran a quick menu vs teo run on an LPAR.
> There was no significant change between the results of the benchmarks
> except for slightly higher cpu utilization when using menu governor. I
> can put it down to the cover letter. The only noticeable change is on my
> micro benchmark where I use epoll_wait() to make two threads on
> different cores ping each other.
> 
> micro-benchmark |   teo    |   menu
> -------------------------------------
> avg time        | ~21.6sec | ~24.3sec
> 
> Idle framework tries to find the specified governor in the driver struct
> but if it can't find it or no governor was specified it uses the next
> available one, so setting teo on defconfig and disabling rest of the
> governors can be good enough to pick teo.
> 
> 
>>> - Configuration
>>> -----------------------------------------------------------------------
>>>
>>> Idle state parameters are tuned per hypervisor type after benchmarks:
>>>
>>> **LPAR:**
>>> - Polling: 5us target residency, 0us exit latency
>>> - EW: 5us target residency, 5us exit latency
>>>
>>> **KVM/z/VM:**
>>> - Polling: 1us target residency, 0us exit latency
>>> - EW: 1us target residency, 1us exit latency
>>>
>> I think this would also be useful in cpuidle-s390.c in particular the
>> different residency+latency values for LPAR and KVM/z/VM and what they 
>> aim
>> to achieve for you.
> 
> We can put down a comment like below;
> 
> /*
>   * After various benchmark runs the tuneables for idle driver has shown
>   * the best performance with the following values;
>   * for LPAR:
>   * - Polling: 5us target residency, 0us exit latency
>   * - EW: 5us target residency, 5us exit latency
>   *
>   * for KVM/z/VM:
>   * - Polling: 1us target residency, 0us exit latency
>   * - EW: 1us target residency, 1us exit latency
>   */
> 
> Is that what you are looking for or something more extensive to cover
> what sort of behavior it causes and why it benefits the performance?
> I wouldn't really like to put down lengthy comments here to be honest.
> 
>> Additionally polling is initialised to 0/0 by poll_state.c, so I don't 
>> know
>> where you're taking these values from?
> 
> Having a look at the implementation of poll_idle() in poll_state.c.
> The polling time limit (target_residency) is acquired from
> cpuidle_poll_time(), which tries to find an enabled state deeper than
> polling state and returns its target_residency. Since we only have two
> states, it automatically means EW state's target_residency, or
> IDLE_POLL_MAX if it is disabled.
> 
> If I am not mistaken governor also uses the next enabled state
> to calculate the target_residency of the polling state.
> 
> 

Friendly ping.

