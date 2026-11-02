Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793624519;
	b=K2Qs+vE/rCR6obJ0MNgIeUTPBAYHyo48PSzJ4d6W/vKP9OL4RCmkppeRN/wQUqDX8gZP
	 H93+ZPMif0UIcQHsuDAX/nZB3LAagmBNAe1Rjej4adBeNxQmI38MABYUYXrH3EIVvGxto
	 VyHGE5tpfFyS32ouIAua6FEBwtOxknr325kAYr/FV5PsX8gy3Bf/XRyhPaOmJcEoIA8wF
	 DRgQ0ZcaTNfubRtkwJqyNo5DsDKRgOqbJP2ZbXRGOw/U7AN+6XyusGah3HRpvxmaaW4DV
	 bjigoigmdV0G9VYxJnMSy//YZ6HA9OUy9VlzoSMI3paQhS02BF7kBhVIn8cUWTi9PRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793624519;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=2W2cWo3uXPAbaEwXMsjPtD62QlF6or4emsdQLJHxWK4=;
	b=zEB0mBKT4IJ2aq0CskcCcie8EA9VSQdpfUCg92XpbWUGFfDnqgd0KglY/oZRWzGWKm49
	 1R71BAvKalrM6hbTom96zbM+U79IthKq/EMsRO3KDjL85JzSbETRCVwpXAusig5ImrAUT
	 EHVSJuptFwtdD4mcgZiYqodHngHQYnfFzNB6BFZH5jDhvSlcnPEdK/tdkIOHmViwXHUIi
	 iEvKiCgyvxArCNEjfc5b+oCq2aukIeXZE93gg3ZR+lZO47nNqIi5hWPT6VgloEtF9LlNM
	 6XC3XNXgvHMN1g+e5yatp0s6cNsLGRY7eXN/v9/IKe2rplyX1eCemUuRZwx1Ql/Yykw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M9gGLV+3;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA57606A33A;
	Mon,  2 Nov 2026 13:01:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AA57606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M9gGLV+3
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29EDRp2429580;
	Mon, 2 Nov 2026 13:01:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2W2cWo
	3uXPAbaEwXMsjPtD62QlF6or4emsdQLJHxWK4=; b=M9gGLV+34HWQCSjn2fnzix
	0KtiZDZzU82i8e2XRZPalyfBRSJw1JRVCmVWRJSwul8a3Synz3COzl0qPzWnBHNY
	BqB2pSIXWm2ZixA3jRU4sneHxlTv+m013HQ8rDrhUMnuW/rKoG/r/ColDtcoIR0H
	/+9v9uIMbMMRVwWrov8B7Omer0JMLOiGTLP6FHIsk8qqr+nDvWf7d6jA4eBOUsRO
	shL29zPvd0QdmJTvTV+Zap9LQMk14jPUO0MtVy5OeA4Av3ISyvg9nmYsSuOrfg5g
	iy7FYyHHfpgLHp1Rme4KlxAe2PRUogssa90aKeuLzD+//N7205Xkbd7P5uq5Fj7g
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhgpwv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:01:08 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A29ZCfU730591;
	Mon, 2 Nov 2026 13:01:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vdwry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:01:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2D13oM37749108
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 13:01:03 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 584BC2004B;
	Mon,  2 Nov 2026 13:01:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C43020040;
	Mon,  2 Nov 2026 13:00:56 +0000 (GMT)
Received: from [9.124.210.123] (unknown [9.124.210.123])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 13:00:56 +0000 (GMT)
Message-ID: <66ccd713-5571-4c1a-b59e-29adbc9852e3@linux.ibm.com>
Date: Mon, 2 Nov 2026 18:30:55 +0530
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in
 Kconfig.preempt
To: Ilya Leoshkevich <iii@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mete Durlu <meted@linux.ibm.com>, Yury Norov <ynorov@nvidia.com>
Cc: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Yury Norov <yury.norov@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Andrea Righi
 <arighi@nvidia.com>, Ben Segall <bsegall@google.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Danilo Krummrich <dakr@kernel.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Steven Rostedt
 <rostedt@goodmis.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, driver-core@lists.linux.dev,
        linux-s390@vger.kernel.org
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-2-ynorov@nvidia.com>
 <388636ac-4521-4523-bb5b-b6bc71591ff6@linux.ibm.com>
 <20261102110026.GG1813469@noisy.programming.kicks-ass.net>
 <9273846b-d815-4c40-a7a0-960281515878@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <9273846b-d815-4c40-a7a0-960281515878@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: qU77n7JZ2HH830HkwO0bh0WO8uhjgO_U
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX+boVVfYoh5pU
 uSy2Xet2uaIK8F8jcnLEz9KvVlwHt4/nzaouvwJwgK+WHXl9MM/bLSKTKPh6AwJ1fArqPd3qKmU
 UZsRhQNicnN5ZSdFrf1BXh7lG3tJgxQ=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae88994 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=P4Rk32GvQtOlVBIN6qsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MCBTYWx0ZWRfX3TPH1gWhup/2
 hNf5WzFq5tTCdMXFbS+JYJM1TtSbJvAD40Cpf1WxAWsgOKtIxGCVesiN3BGHnitOAbGab2koK9V
 2Cn9CXcYYpVc2X9LVCsUb+TixybIHwpVXj84G9WQU4tKX0lVX4NkodW0UWzvIKsIYG047QJyOU1
 mGAGAQGJ+cuCeHETQ9HmDhArHR8Begyb8huoiWDDvIzTL9RJPI8V9RwKEmi3pG8uQVCWjJeocpg
 7hD4hgF9q+JQHZnxHd5oMOw8jRH2REZT5Mr4Gs9Y3YvXlRcJzi7bO4bKupBflC3DERBx+u3QDH+
 belhz225nMoZu/cPv3s+z0Wg1+ItSKuMktPgB4kv0qWBy7FZQnnL7DVRnE90NfNl/Kaop+uiM4H
 8NRCtVwDzfrK+yToXMExJHVUWyckrBrt0JNUCsKSsF4I18uksfBZxdd7kVOy4lW7UvbP4JqMyza
 gzE4YqaNRR4vxVeAH1Q==
X-Proofpoint-GUID: 2gVp4-yn7BK2860rxFA_OE5c206VNWaf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1011 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020050

Hi.


On 11/2/26 5:04 PM, Ilya Leoshkevich wrote:
> 
> 
> On 11/2/26 12:00, Peter Zijlstra wrote:
>> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 11/1/26 20:21, Yury Norov wrote:
>>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>>> is enabled.
>>>>
>>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
>>>> and requires it to minimize the configuration space and runtime overhead,
>>>> with the lack of non-paravirt user. Now that s390 wants to adopt preferred
>>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>>
>>>> Make PREFERRED_CPU a user-configurable option, even if paravirtualization
>>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>>
>>>> Keep the default module selection conditional on PARAVIRT so other SMP
>>>> configurations can opt in without enabling the governor by default.
>>>>
>>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@linux.ibm.com/
>>>> CC: Mete Durlu <meted@linux.ibm.com>
>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>> ---
>>>> Can be applied independently from the rest of the series.
>>>>
>>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>
>>> This is really useful to us, since even though s390 is nominally
>>> paravirtualized, it does not technically benefit from defining
>>> CONFIG_PARAVIRT.
>>
>> And therefore removing PARAVIRT is the only possible solution?
>>
>>> Specifically, steal time accounting happens by
>>> computing a difference between wall time and CPU time, and not by
>>> explicitly querying the hypervisor.
>>
>> Nobody explicitly asks the hypervisor, that would be horrendously slow.
>>
>> Something trivial like this should do.
>>
>> ---
>>   arch/Kconfig                           | 9 +++++++++
>>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>>   arch/s390/Kconfig                      | 1 +
>>   drivers/virt/Kconfig                   | 2 +-
>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/Kconfig b/arch/Kconfig
>> index 1163736de1f9..8980054beb52 100644
>> --- a/arch/Kconfig
>> +++ b/arch/Kconfig
>> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>>   config HAVE_PV_STEAL_CLOCK_GEN
>>       bool
>> +#
>> +#  Archs that can account CPUTIME_STEAL; normal route is through PARAVIRT which
>> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and PPC-LPAR
>> +#  which have their own thing and don't go through generic cputime accounting.
>> +#
>> +config HAVE_CPUTIME_STEAL
>> +    bool
>> +    default y if HAVE_PV_STEAL_CLOCK_GEN
>> +

Can't PARAVIRT_TIME_ACCOUNTING be the kconfig we can rely upon.
s390 can add it to the config (similar to HAVE_CPUTIME_STEAL)?

I guess it is selected currently where the steal time reporting happens.

>>   config HAVE_MOVE_PUD
>>       bool
>>       help
>> diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
>> index 7d125e288f6e..3c49baf606d7 100644
>> --- a/arch/powerpc/platforms/pseries/Kconfig
>> +++ b/arch/powerpc/platforms/pseries/Kconfig
>> @@ -41,6 +41,7 @@ config PPC_SPLPAR
>>       depends on PPC_PSERIES
>>       select PARAVIRT_SPINLOCKS if PPC_QUEUED_SPINLOCKS
>>       select PARAVIRT_TIME_ACCOUNTING if VIRT_CPU_ACCOUNTING_GEN
>> +    select HAVE_CPUTIME_STEAL
>>       default y
>>       help
>>         Enabling this option will make the kernel run more efficiently
>> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
>> index 7138d923d86f..03a884355218 100644
>> --- a/arch/s390/Kconfig
>> +++ b/arch/s390/Kconfig
>> @@ -291,6 +291,7 @@ config S390
>>       select USER_STACKTRACE_SUPPORT
>>       select VDSO_GETRANDOM
>>       select VIRT_CPU_ACCOUNTING
>> +    select HAVE_CPUTIME_STEAL
>>       select VMAP_STACK
>>       select ZONE_DMA
>>       # Note: keep the above list sorted alphabetically
>> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
>> index eeb84e578ddf..a3721d34a55c 100644
>> --- a/drivers/virt/Kconfig
>> +++ b/drivers/virt/Kconfig
>> @@ -43,7 +43,7 @@ config FSL_HV_MANAGER
>>   config STEAL_GOVERNOR
>>       tristate "Dynamic vCPU management based on steal time"
>> -    depends on PARAVIRT && SMP
>> +    depends on SMP && HAVE_CPUTIME_STEAL
>>       select PREFERRED_CPU
>>       default m
>>       help
> 
> I can't comment on the PPC part, but for s390 this works fine with the
> following addition:
> 
> --- a/kernel/Kconfig.preempt
> +++ b/kernel/Kconfig.preempt
> @@ -197,4 +197,4 @@ config SCHED_CLASS_EXT
> 
>   config PREFERRED_CPU
>          bool
> -       depends on SMP && PARAVIRT
> +       depends on SMP && HAVE_CPUTIME_STEAL

PS: I haven't read the series yet.
Will try to do so when it get little bit of time.
