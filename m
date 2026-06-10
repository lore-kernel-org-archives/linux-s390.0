Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D5937BE86;
	Wed, 10 Jun 2026 20:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781123063; cv=none; b=qAcFAFjGBlCn3Cxiy4jAVpdza0F0hYlDQpe9ksblQzbJehbOL80vIYzFgmxiCDB7P/gZNfeaoDpHw37md+gL8ksxGyTSb0clx54Wsk8hBj19zdUpunY0df/6NmC2EUzNGf0Dw1MksT/Grr5VxJ+aVwiU4nlU4mLHfGWh0YZPUcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781123063; c=relaxed/simple;
	bh=ZX8/DGWMK8mrWMc84OmpS7gL/zo3tphrttM5gpWyj/E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=e5FBPlPsJrzIjKKVTmuTUjWVRplftaP8WYJFDD3mtwxKMJ0h0Jon8xh4iQ/sazgR3OPazr6IlUT/8crRQQzKOKb/w28qrcsvNXbqcDCpsmZiC6tXOiT11qlRJkkL7VPM8liZXyCMDBEoxkdl5tF7yvdTNzAUCDkAXXopOlcTlao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KPM0oCIx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KPM0oCIx"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65AJu4ok677350;
	Wed, 10 Jun 2026 20:24:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rGoHMk
	mZH/+Ju66MkY4hMuu+MyzHUnqEhxPvRkPn6ps=; b=KPM0oCIxxJVIhiIjZGJwuY
	J4u6NdAbGkATWt9862CnevNRkcYzAZZX9swHAxJi8DDRfrIhnvZ2fXVc9A2xKRCq
	T9wK6Zry0T/GU57EQI+mLK93GcvYeDhbZFgH0QAr+8TLQI47MzICDcv2Wn96Jf7l
	Yy6ejn0n9yM0dlpHsqHQgDR1bI5o6gi0QqkUAJMvETRrnxCK+lZT/Khl8wlV+SIS
	HkVKNJqcpgksbTxtqJqjiokCrnbafWnh3z5eZreoj/Pa4M3Za3nCrcmzHNCD1QPh
	8Z1CGyEaCxn9z5BtyhYnBE/sHNPQF0Dr1uxMD0mUhJ+f6JVRswKwRTxvjA1CebpQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eqe8ag58h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 20:24:02 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AKK6Rj011529;
	Wed, 10 Jun 2026 20:24:01 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eqe09g792-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 20:24:01 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AKNwFR50528604
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 20:23:58 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ED27B20049;
	Wed, 10 Jun 2026 20:23:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 14B9320040;
	Wed, 10 Jun 2026 20:23:57 +0000 (GMT)
Received: from [9.111.33.159] (unknown [9.111.33.159])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 20:23:56 +0000 (GMT)
Message-ID: <93743121-2f6f-441b-8675-4eaa92647b4d@linux.ibm.com>
Date: Wed, 10 Jun 2026 22:23:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
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
Content-Language: en-US
From: Mete Durlu <meted@linux.ibm.com>
In-Reply-To: <0e6ff23c-b509-40eb-87f3-7b04fb066edf@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: a64jb7OPVaPTb9YW1SlOnVKfaxn_65Q7
X-Authority-Analysis: v=2.4 cv=TdKmcxQh c=1 sm=1 tr=0 ts=6a29c7e2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=sbA5G8EigutXl4nyLPcA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDE5MSBTYWx0ZWRfX82fPQqibcwq1
 zVKuSQDWHwssRo+7rMM2zfPJmcuxZWwBOQyq55AQAHpa/R0cIsY3BWiBgT50s4D9/kmD5nU5t+x
 KeSn76MgjXWLMeYeVObFkYpU7QPHnuSHDxRtiBju2Qb7fqoLALbSIbYB+jN6MOwclg6V+xEimDL
 TgrRr1DecbpIiptZ8ovqcnfiY5wPax58TOYIEySmwuqFzs7jU5OOZm9TIEdyfLgIJyR+BICUKn4
 o06XmJatBYSAM0rZ/M26GubCT6YJ8DdzCB3oXR/UySoX5wC1Wgvp8MD0L9+elsAwcykR652cD46
 fXcf/0peVZHrB/8VRLuRDeM6Z+VweRfX3eU+5IXtI6N4LA7bhkQIFI0i0pmp1s5pMU8LunONbH1
 aIhVzFaby5bP+JlnLwmGaab6e/tP1ophxK4HI7lf4Jk4HYzdT5l4m1E7+3T98FOP1Z40dPmI7Lq
 VOUkCA6qyTkszA0BIrw==
X-Proofpoint-GUID: a64jb7OPVaPTb9YW1SlOnVKfaxn_65Q7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjEwMDE5MSBTYWx0ZWRfX2ioqo2TlI/gY
 380HWgVJQ+llyAzWWRCfS9SE+z+rmh7E5lt5b0QeJATBo3XeAQeiv4Q36Ms1sc0hLrQ6yuJlfXN
 IirYCk6SpKzj9jHRXNTUoYY7vinSPiM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_04,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 impostorscore=0 adultscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606100191

On 6/9/26 5:47 PM, Christian Loehle wrote:
> On 6/9/26 14:24, Mete Durlu wrote:
>> v1 -> v2:
>>
>> * Add idle driver enteries to MAINTAINERS file (Christian Loehle)
>> * Remove extra line break left in drivers/cpuidle/Kconfig.s390
>>    (Christian Loehle)
>>
>> This patch series introduces a CPU idle driver for s390
>> architecture that leverages the existing cpu idle infrastructure and
>> TEO (Timer Events Oriented) governor to optimize idle state selection
>> based on timer events and interrupt patterns.
> 
> So if (according to v1) there's no data (yet) that teo is much preferred,
> I would remove all mentions of it in code and patch descriptions?
> A cpuidle driver requiring a specific governor sort-of violates the
> abstraction.

True, s/TEO governor/idle governor/g + s/TEO/idle governor/g should
be good enough.

> In case teo does work much better for you, which I wouldn't doubt for
> a second from what your system looks like, it would be nice to present
> some data on it. Additionally I think setting it in the defconfig alone
> is probably enough?
> 

I ran a quick menu vs teo run on an LPAR.
There was no significant change between the results of the benchmarks
except for slightly higher cpu utilization when using menu governor. I
can put it down to the cover letter. The only noticeable change is on my
micro benchmark where I use epoll_wait() to make two threads on
different cores ping each other.

micro-benchmark |   teo    |   menu
-------------------------------------
avg time        | ~21.6sec | ~24.3sec

Idle framework tries to find the specified governor in the driver struct
but if it can't find it or no governor was specified it uses the next
available one, so setting teo on defconfig and disabling rest of the
governors can be good enough to pick teo.


>> - Configuration
>> -----------------------------------------------------------------------
>>
>> Idle state parameters are tuned per hypervisor type after benchmarks:
>>
>> **LPAR:**
>> - Polling: 5us target residency, 0us exit latency
>> - EW: 5us target residency, 5us exit latency
>>
>> **KVM/z/VM:**
>> - Polling: 1us target residency, 0us exit latency
>> - EW: 1us target residency, 1us exit latency
>>
> I think this would also be useful in cpuidle-s390.c in particular the
> different residency+latency values for LPAR and KVM/z/VM and what they aim
> to achieve for you.

We can put down a comment like below;

/*
  * After various benchmark runs the tuneables for idle driver has shown
  * the best performance with the following values;
  * for LPAR:
  * - Polling: 5us target residency, 0us exit latency
  * - EW: 5us target residency, 5us exit latency
  *
  * for KVM/z/VM:
  * - Polling: 1us target residency, 0us exit latency
  * - EW: 1us target residency, 1us exit latency
  */

Is that what you are looking for or something more extensive to cover
what sort of behavior it causes and why it benefits the performance?
I wouldn't really like to put down lengthy comments here to be honest.

> Additionally polling is initialised to 0/0 by poll_state.c, so I don't know
> where you're taking these values from?

Having a look at the implementation of poll_idle() in poll_state.c.
The polling time limit (target_residency) is acquired from
cpuidle_poll_time(), which tries to find an enabled state deeper than
polling state and returns its target_residency. Since we only have two
states, it automatically means EW state's target_residency, or
IDLE_POLL_MAX if it is disabled.

If I am not mistaken governor also uses the next enabled state
to calculate the target_residency of the polling state.

