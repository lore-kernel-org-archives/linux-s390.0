Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705474;
	b=WYsulPTMrhNLnJoCpSkXfZ7uWQ4g9+BbHxU5PmZHWJNgE4FLP308BBLi7Ip7efWesIbL
	 XO0SYuX0ORmECaxBZmQL26wAJdFw/khRkTK75U+0Ai3ZFaEVDSwZDAYWZe5agueEDvkfn
	 Y3b4b2EVfqf9o6Keb/s5M+WOe0Gj/CuyAc1JRBLIHXQ4Lm32KiRFayQoFP0FNcp6SN2e3
	 vwV1uXvnMUQSVwge3FtVU4OmZPCfpxeb74pcg5ioGYDsxiin/+nNSuLo9rZxuijZmuYR5
	 Kvt2boK/tAsoKXiO1LruHE4bAVUb2JWL70WtVIpa/tCyeAt39EjhZzqctc1pPokpSOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705474;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:From:To:Cc:References:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-GUID:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=O1JZvTFraPtP3QzvAHnEQ2a+1nCTtawi4htjRHO97d4=;
	b=zA2w+SteDPUiZZWgwWvshno2APMOVdhjTquK9Vw6NMQBz6c8j1IBKZCS0xA3qmttzL1J
	 GC7y2yjFlUVHTOozwL06oKQg8tRqK+I6/FeI3bbXyAtK7BniQxiYeiETHLaL57zdl4iP4
	 aOCKPCmRH75SJBi4rUiOFCaMPGM3SpYVmcDWD+B+GJMHfNA7weNBFFPlYSBsvmLQQlkqi
	 D56TYPehCNuNbf/tF/hRwlaBuj3I0EdL5fvV0iUO6pAxt6IFtMs7Na5dE64sLBbR5gLaN
	 ED/BlY3bo0JrqEmOx2dLA6+wS/PUq8BvFP4B+iF+wWwSmrT9ygmck7shcebJ4UOZ7zQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mv74Ya4N;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8655E606A324;
	Tue,  3 Nov 2026 11:31:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8655E606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=Mv74Ya4N
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AE1WZ4044449;
	Tue, 3 Nov 2026 11:30:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O1JZvT
	FraPtP3QzvAHnEQ2a+1nCTtawi4htjRHO97d4=; b=Mv74Ya4NNEq39VVxQqO2U9
	7m21RdajLItguPM0OK8/pZRuV951qG8kgfG0L3PJXy9F3+roLpr2r1cJPqbAr7hv
	Nab73d5E1KEsQvnxhD3O4EeqfHhxeTIp0S6v+0oGfL7OCKVuLBlhVpdNfdPCC5N1
	HOdD5KxfW0sh7pO9cQJb/9YPFRgI17bAn22w7JlxNkBJXn2ifH6BENA9xdzx2fY8
	14nKtKospsU8/45bpleFL5WIevEXqbKoosQ1YaSJT8iHleaaThnUbRuHvzdOJoG7
	1KC8Y+zZ78cunQ+JWhqOllQ3/a7+ia99XkRB5oY3oSRiTeTBmmilay3IiBSihVjA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn80snbgf-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:30:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A3AYovl2376725;
	Tue, 3 Nov 2026 11:30:27 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1vj6x1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 11:30:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A3BUNaE46203318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 11:30:23 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02B482004D;
	Tue,  3 Nov 2026 11:30:23 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A36362004B;
	Tue,  3 Nov 2026 11:30:21 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.93.113])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 11:30:21 +0000 (GMT)
Message-ID: <a21a0cbd-cc77-48c9-b158-ccd14636fd66@linux.ibm.com>
Date: Tue, 3 Nov 2026 12:30:21 +0100
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
From: Ilya Leoshkevich <iii@linux.ibm.com>
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
 <aecd7142-ee54-4cf9-80aa-3546cc2661e3@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <aecd7142-ee54-4cf9-80aa-3546cc2661e3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: _x9SqjpgHY88d0_Sk4v_Zp7BV68BVJmQ
X-Proofpoint-ORIG-GUID: dG1vFU4noVIxlSmSo9Z-mPu8Dk2sB7dR
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfX1rQ8Gd2xYRG2
 DAjcLJd19Xs2+CCmwzWjpRXPs0tATFhBOXFMUaSh2bQqsy+ZaTBlbi28YwDGZMw/pP2IFi2+aYX
 j12PegQwSGbjJ9TrbK5XTl9bDEHsVVHhlp+P6LeoWS8FCxrBAs+SkJ95YdjQ/9DlevH+Na8h/bU
 t578K62dsmTbE02HRIMgM/KF+6wCMs9mRUcvSFJAuvEyTSWDFmc/B6uVTHnnx5WU1pbhiE0+i6B
 On9aG6pDwlEoscswK/X4Wh+n+M7+dttDDCbqvOU3xw707yXxY1TDc4cdBfoGJ/i/oWo7vcthj1Q
 Q9AgT6hlH55OAKerSesp/sEXENyyR8bH+4M1vn+EMhtNUOUlHs97vuB1Xx+fE6iROdm80BXeg67
 MwhPPrGhgZpkjs3vmOQl/gGp5K2SOyCT+jYz53MG+0wq+baErp9KpaMXIrvAdtYLgLYFGf8fDLn
 Vxz8yx7cvGxAefyeH6g==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDA0NCBTYWx0ZWRfXwyqrXCz1KKlB
 CGhgxiMT3NUThEDMyIO9Kv9cqxG99fU52TEkXBGB3rG53/Xz4cil4YGJwqaZ22itvvFAvTEWA5n
 9dblDwCPX3XD9PrCL+j3rceZwTZJntk=
X-Authority-Analysis: v=2.4 cv=FIqOVOos c=1 sm=1 tr=0 ts=6ae9c5d5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=naYFAUwE1L9fWVycxNkA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_02,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 impostorscore=0 spamscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611030044



On 11/3/26 12:26, Ilya Leoshkevich wrote:
> 
> 
> On 11/3/26 06:49, Shrikanth Hegde wrote:
>> Hi Ilya,
>>
>> On 11/2/26 7:11 PM, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 11/2/26 14:00, Shrikanth Hegde wrote:
>>>> Hi.
>>>>
>>>>
>>>> On 11/2/26 5:04 PM, Ilya Leoshkevich wrote:
>>>>>
>>>>>
>>>>> On 11/2/26 12:00, Peter Zijlstra wrote:
>>>>>> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>>>>>>
>>>>>>>
>>>>>>> On 11/1/26 20:21, Yury Norov wrote:
>>>>>>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>>>>>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>>>>>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>>>>>>> is enabled.
>>>>>>>>
>>>>>>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT 
>>>>>>>> config,
>>>>>>>> and requires it to minimize the configuration space and runtime 
>>>>>>>> overhead,
>>>>>>>> with the lack of non-paravirt user. Now that s390 wants to adopt 
>>>>>>>> preferred
>>>>>>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>>>>>>
>>>>>>>> Make PREFERRED_CPU a user-configurable option, even if 
>>>>>>>> paravirtualization
>>>>>>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>>>>>>
>>>>>>>> Keep the default module selection conditional on PARAVIRT so 
>>>>>>>> other SMP
>>>>>>>> configurations can opt in without enabling the governor by default.
>>>>>>>>
>>>>>>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919- 
>>>>>>>> bf9897181834@linux.ibm.com/
>>>>>>>> CC: Mete Durlu <meted@linux.ibm.com>
>>>>>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>>>>>> ---
>>>>>>>> Can be applied independently from the rest of the series.
>>>>>>>>
>>>>>>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>>>>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>>>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>>>>>
>>>>>>> This is really useful to us, since even though s390 is nominally
>>>>>>> paravirtualized, it does not technically benefit from defining
>>>>>>> CONFIG_PARAVIRT.
>>>>>>
>>>>>> And therefore removing PARAVIRT is the only possible solution?
>>>>>>
>>>>>>> Specifically, steal time accounting happens by
>>>>>>> computing a difference between wall time and CPU time, and not by
>>>>>>> explicitly querying the hypervisor.
>>>>>>
>>>>>> Nobody explicitly asks the hypervisor, that would be horrendously 
>>>>>> slow.
>>>>>>
>>>>>> Something trivial like this should do.
>>>>>>
>>>>>> ---
>>>>>>   arch/Kconfig                           | 9 +++++++++
>>>>>>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>>>>>>   arch/s390/Kconfig                      | 1 +
>>>>>>   drivers/virt/Kconfig                   | 2 +-
>>>>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>>>>
>>>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>>>> index 1163736de1f9..8980054beb52 100644
>>>>>> --- a/arch/Kconfig
>>>>>> +++ b/arch/Kconfig
>>>>>> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>>>>>>   config HAVE_PV_STEAL_CLOCK_GEN
>>>>>>       bool
>>>>>> +#
>>>>>> +#  Archs that can account CPUTIME_STEAL; normal route is through 
>>>>>> PARAVIRT which
>>>>>> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and 
>>>>>> PPC-LPAR
>>>>>> +#  which have their own thing and don't go through generic 
>>>>>> cputime accounting.
>>>>>> +#
>>>>>> +config HAVE_CPUTIME_STEAL
>>>>>> +    bool
>>>>>> +    default y if HAVE_PV_STEAL_CLOCK_GEN
>>>>>> +
>>>>
>>>> Can't PARAVIRT_TIME_ACCOUNTING be the kconfig we can rely upon.
>>>> s390 can add it to the config (similar to HAVE_CPUTIME_STEAL)?
>>>>
>>>> I guess it is selected currently where the steal time reporting 
>>>> happens.
>>>
>>> Looking at update_rq_clock_task(), s390 would still need to provide a
>>> pointless dummy paravirt_steal_clock() implementation in this case.
>>>
>>> [...]
>>
>> Other possible option is, you could use CONFIG_HAVE_PV_STEAL_CLOCK_GEN 
>> which
>> defines the dummy implementation and you don't update that method. 
>> That way
>> you may implement PARAVIRT_TIME_ACCOUNTING mostly with kconfig changes.
>>
>> But it needs the arch to implement static calls. I am not sure if s390 
>> has it.
> 
> We will get non-optimized static calls soon [1], so this would be not so
> great from performance PoV.

I just realized it's enabled only when CFI is enabled, so it's not an
option anyway.

[...]
> [1] https://lore.kernel.org/linux-s390/20261026102952.4153711-1- 
> hca@linux.ibm.com/

