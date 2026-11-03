Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705257;
	b=J/6EvmzPnt6+xiUTabR3hJVYTpbGbDclovm9GY152g5qG2ZmoTvZaJNXpb/0x4yQGZd4
	 q1juT4q20hSpZDZcIp7UUgoD1fcjBEWorghK+cREPPCPacw4mmdjDuUyy78lZpX65nFxS
	 pEvdBUR7I4/FBsBRQz+cmdJvCo2j6Ws1FBxnwjCDmBrxcN0MZgKTkWqTbhPtau4MoPl7H
	 RtidQ9zPCTHOkdMTMVkB+9Ue2uTO57LAWRtrCx2TvCpDKZaSJ+8Dmg3twe3Wq3qPaznnB
	 lpiWJYPk77E4T1k8a6JrVnR7dcfsJ1JL3lfVLhdTSBSiVofXGe8+uUsg2ODKntnW79w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705257;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rdeZ06dwGGmY/QwWf76g3Da/9M1uCJcGZLUFle0KWsM=;
	b=SSJglhapnTPfdBPSHA9uC20yZ7jqe6cjhR4+pl7Z6fzW1SyL14+HtZWmngV3Tt3rXN9A
	 ieXI42fY9gKVVfDE05tr1H9+JymgmaAB110h6jQ7vQpgHqKvcM81FcEwI1T7nWOlJVp0v
	 9jNcN+u5/XbOiOS9MgkVdycxTuJ4plr6/5jeadLgIzAWEYgb8+TFLzRaTodW4R1BGIj33
	 kSAOifytrgyQd0sADJGSo2aBt8fWWJaqUnvuXloq/Dqnx4OFA0l2+A9qfE1aFDSEd1BXf
	 i6j/gY4v76NtVstNNoc8iF/Z4ijVOprb9McjvckYZ7CV+u6rAp/W9nQE4qMeAcIUepg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jj2SB5v6;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D1B606C579;
	Tue,  3 Nov 2026 11:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 27D1B606C579
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=jj2SB5v6
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AEOaK1469905;
	Tue, 3 Nov 2026 11:27:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rdeZ06
	dwGGmY/QwWf76g3Da/9M1uCJcGZLUFle0KWsM=; b=jj2SB5v6WZkONt0SJTqRCC
	Hz/ijjYn4MSqixv1cn7iF6hm4s/pno7nUssy+vOrqQcf9y0bh6B6ZUpodnnjIEpq
	a7fjNF07YL1fg4+WocdQecEmOVvMShVzGuIuzxIUSiCxw9TA3y08jCOKv0cIoImI
	13cHkytUBo8V/bU7cIiB2nwW0pPJ59tuEMg8fQBS0yrGd1q5fl12SJFh6A6coacG
	Mfo2MOIPcjzfk7m/Q3xU5DaMbxKUZEuPPOy8yv48RaNQeDPI7OOIlL6zhbHZ/DL8
	hrdwewUaaJuDeIgk/0HVa4gAHwCzr8VjTpj+5ItwDN7Lp1kvkHoP5M8v7toeAAWg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrw3h5-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:27:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AJtqt2282456;
	Tue, 3 Nov 2026 11:27:04 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hqcrc8g43-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:27:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3BQxHH46465314
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 11:27:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C37FC20040;
	Tue,  3 Nov 2026 11:26:59 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 715B52004B;
	Tue,  3 Nov 2026 11:26:58 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.93.113])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 11:26:58 +0000 (GMT)
Message-ID: <aecd7142-ee54-4cf9-80aa-3546cc2661e3@linux.ibm.com>
Date: Tue, 3 Nov 2026 12:26:58 +0100
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
To: Shrikanth Hegde <sshegde@linux.ibm.com>,
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
 <66ccd713-5571-4c1a-b59e-29adbc9852e3@linux.ibm.com>
 <efe1657f-b1c6-4096-8868-fb53097b1847@linux.ibm.com>
 <439758ce-c807-4b5b-b2e5-31fb9f1c6f11@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <439758ce-c807-4b5b-b2e5-31fb9f1c6f11@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae9c509 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=oJnVKXGyT2hUOC1DUX0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfX4x5CM/VRX51m
 Cs6hQT9hLAxXY1mwSEybJA5XpzOozuwnwmV9EN3AwINwQoKrbVKhGn+b1vAJdJ59oLhigDYWBv/
 6LsJqiADjFD751/XQjAv7GFndKb9seU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfX8CHKgJvEjz+4
 3XBejx1XgkO8h5WG9B+SPvnosCTqG7pzkbVeYTpo8iOY2Gy4ookgbNubyqU1rz7xw5kaWZdrMuG
 BYd3uIrIYqSK/ow9vZvwu2/BdSvSQfOJ06LxrprdfzLj4BbFoGfF0P0gvVdshx1ihnun9dxfF1n
 1qgMbogwp2zcKojJG47JUfShvYJMms/OSFMoUOPLiMl1/1NDtdrWxBDJ8Ug5H1qvZeHNjS1QmYN
 URWiIe4CUUBwIImeDiovR6hLuifDdQPDe1LclNubVE3grTxtdcQkLjKqZXrBPWVFAoMzrEk2djK
 c3ZikBKyky8zFFHrRBmNrqEG9hb5RdpR3rSQOZ0ZW71A+NNoi/gyKCzW/iaURjtY3x8BjiGnI4J
 1kdFh79Ia/HmS5Ub9UpKBFf5noJnfJTN6qhOzm6v9OFUg5P5NINnH6aorRRTGr1vYvN6XRS/NxI
 LkLYP3Iq8sWLctpTmAg==
X-Proofpoint-GUID: _icac76lLjQsu45EzWiXFNesX10Jm2sf
X-Proofpoint-ORIG-GUID: CmF2rKtHhWg7BhRdX5pqglBCzCSQGfSn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030044



On 11/3/26 06:49, Shrikanth Hegde wrote:
> Hi Ilya,
> 
> On 11/2/26 7:11 PM, Ilya Leoshkevich wrote:
>>
>>
>> On 11/2/26 14:00, Shrikanth Hegde wrote:
>>> Hi.
>>>
>>>
>>> On 11/2/26 5:04 PM, Ilya Leoshkevich wrote:
>>>>
>>>>
>>>> On 11/2/26 12:00, Peter Zijlstra wrote:
>>>>> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>>>>>
>>>>>>
>>>>>> On 11/1/26 20:21, Yury Norov wrote:
>>>>>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>>>>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>>>>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>>>>>> is enabled.
>>>>>>>
>>>>>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT 
>>>>>>> config,
>>>>>>> and requires it to minimize the configuration space and runtime 
>>>>>>> overhead,
>>>>>>> with the lack of non-paravirt user. Now that s390 wants to adopt 
>>>>>>> preferred
>>>>>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>>>>>
>>>>>>> Make PREFERRED_CPU a user-configurable option, even if 
>>>>>>> paravirtualization
>>>>>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>>>>>
>>>>>>> Keep the default module selection conditional on PARAVIRT so 
>>>>>>> other SMP
>>>>>>> configurations can opt in without enabling the governor by default.
>>>>>>>
>>>>>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919- 
>>>>>>> bf9897181834@linux.ibm.com/
>>>>>>> CC: Mete Durlu <meted@linux.ibm.com>
>>>>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>>>>> ---
>>>>>>> Can be applied independently from the rest of the series.
>>>>>>>
>>>>>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>>>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>>>>
>>>>>> This is really useful to us, since even though s390 is nominally
>>>>>> paravirtualized, it does not technically benefit from defining
>>>>>> CONFIG_PARAVIRT.
>>>>>
>>>>> And therefore removing PARAVIRT is the only possible solution?
>>>>>
>>>>>> Specifically, steal time accounting happens by
>>>>>> computing a difference between wall time and CPU time, and not by
>>>>>> explicitly querying the hypervisor.
>>>>>
>>>>> Nobody explicitly asks the hypervisor, that would be horrendously 
>>>>> slow.
>>>>>
>>>>> Something trivial like this should do.
>>>>>
>>>>> ---
>>>>>   arch/Kconfig                           | 9 +++++++++
>>>>>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>>>>>   arch/s390/Kconfig                      | 1 +
>>>>>   drivers/virt/Kconfig                   | 2 +-
>>>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>>> index 1163736de1f9..8980054beb52 100644
>>>>> --- a/arch/Kconfig
>>>>> +++ b/arch/Kconfig
>>>>> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>>>>>   config HAVE_PV_STEAL_CLOCK_GEN
>>>>>       bool
>>>>> +#
>>>>> +#  Archs that can account CPUTIME_STEAL; normal route is through 
>>>>> PARAVIRT which
>>>>> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and 
>>>>> PPC-LPAR
>>>>> +#  which have their own thing and don't go through generic cputime 
>>>>> accounting.
>>>>> +#
>>>>> +config HAVE_CPUTIME_STEAL
>>>>> +    bool
>>>>> +    default y if HAVE_PV_STEAL_CLOCK_GEN
>>>>> +
>>>
>>> Can't PARAVIRT_TIME_ACCOUNTING be the kconfig we can rely upon.
>>> s390 can add it to the config (similar to HAVE_CPUTIME_STEAL)?
>>>
>>> I guess it is selected currently where the steal time reporting happens.
>>
>> Looking at update_rq_clock_task(), s390 would still need to provide a
>> pointless dummy paravirt_steal_clock() implementation in this case.
>>
>> [...]
> 
> Other possible option is, you could use CONFIG_HAVE_PV_STEAL_CLOCK_GEN 
> which
> defines the dummy implementation and you don't update that method. That way
> you may implement PARAVIRT_TIME_ACCOUNTING mostly with kconfig changes.
> 
> But it needs the arch to implement static calls. I am not sure if s390 
> has it.

We will get non-optimized static calls soon [1], so this would be not so
great from performance PoV.

I think HAVE_CPUTIME_STEAL is a good solution. It allows to disable
PREFERRED_CPU and STEAL_GOVERNOR on systems which do not do steal time
accounting, while, unlike PARAVIRT, PARAVIRT_TIME_ACCOUNTING, and
HAVE_PV_STEAL_CLOCK_GEN, not prescribing how the other architectures
should implement steal time accounting.

[1] 
https://lore.kernel.org/linux-s390/20261026102952.4153711-1-hca@linux.ibm.com/
