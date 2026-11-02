Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793631485;
	b=Au2Gcuk9nTMrqpegwF53ATozrAzTNizi0B98b1Z+04ltW3VJ3rc2Y22cOcZcAFsNUk6z
	 1mp0ZZWKkTlpPLXcbFXqI1FJsEtYkLvzPwzaO0jXwHcJqrK6SmBS/24OG9cKLRDHS2uip
	 XRVa4nVw6fguJOvO1tvaM971gIj9hO+bemgCnp6etECgs/3Bwdkp+4TnFjGFUZhYRfl67
	 99SP+hZRIAARQZAfE8e9b8w1swngch3sYkGiaMXYoD0SeKPBNAtTqKhZw3ANZC20GiaOp
	 fbPzbn10FHRZjOUCsG7G6RGpHdecJ9R718spWj+trSiAe6IFdd7aLMDslO7KBmOyCpQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793631485;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=3cdW/b1h/0yGn+S/02n8p0IHMjXT91/Rr39ZjELVX98=;
	b=oA4rJtmuUouLixkswRasUNEv6PpNWViGZsTeDTKRky1jIiJGFEglPVVo/e03r9Vqzf8U
	 N9mU7+PUihUH3E2Y19/Bj6n44fXj7wK3S3i56HVRhLr5+gK2Zs84iJkJIYksTKmciDe23
	 DOw8a8tVFckLLafitEuO+Q8CtQl2OPRxRVTH+TN1P9Z3KvxGjTl5v+IRwCIuvNvXe6XOp
	 2TstWTjdqdgg7pRUezz17aW2tZU14A1zytvfq70VRdyfMJF3JnTHhnIDsg0tLqgqKeomG
	 F7/5Yd+2YnOfMx2QILmVjCyzxI1k8xZgCq6/+1CbJXwYDU2gMWzwxSqh8ZkOV7lLKQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kaG9lXDo;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D77B606F238;
	Mon,  2 Nov 2026 14:58:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4D77B606F238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=kaG9lXDo
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2EEFgb3044394;
	Mon, 2 Nov 2026 14:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=3cdW/b
	1h/0yGn+S/02n8p0IHMjXT91/Rr39ZjELVX98=; b=kaG9lXDo8F6gDWv51Civ8O
	xN15WIQ97mYjsr6bUZapKR1sJSrqsI+V5vYsd/IfVnlVyiSVcnc/Q4TSZ1do4Pn8
	D5ppnQHyAb9KclBn7T+nhDMZFqtwQ02yo2mReqeajATyc2BsXrkpQZTxV5AFu+bi
	G9B1ir1zJmBV4yicRbr9J3kRtaQ8e7DQV0lK5foFOYFMnfaRb/hiHOfTOGjKrM5p
	HMhXq1v253v6BLOnGfX7wC05iMcqAdXwk8ZIofpnBy1vRQMD/hCKlh2jnv7qH/tb
	hUZ5AHrN5nNkcIMOZx913byus2mu/YurNu6Q4wA+etWX3/tDCKEMKBfbatde4YqA
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhhagk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:57:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2E610u1034521;
	Mon, 2 Nov 2026 14:57:29 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnu1veeps-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 14:57:29 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2EvPUN51053024
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 14:57:25 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1286920040;
	Mon,  2 Nov 2026 14:57:25 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 92E732004B;
	Mon,  2 Nov 2026 14:57:16 +0000 (GMT)
Received: from [9.124.209.112] (unknown [9.124.209.112])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 14:57:16 +0000 (GMT)
Message-ID: <1789939c-4f7e-4f0c-b1f7-766a7025301c@linux.ibm.com>
Date: Mon, 2 Nov 2026 20:27:15 +0530
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
 <66ccd713-5571-4c1a-b59e-29adbc9852e3@linux.ibm.com>
 <efe1657f-b1c6-4096-8868-fb53097b1847@linux.ibm.com>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <efe1657f-b1c6-4096-8868-fb53097b1847@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: PzNuqnxmDt3U3OnuissA86E_7jlTI0If
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX30gNluf5CQQz
 hZtmUO7R4IShO4BYiSo022aBIRYNlCYNPjVfM4rVT0T4tirSYhtHVD8ePGEVq9hL/gWmpS2OWEd
 70Vw6kwDQsdqdyEw1CskcPahIjQZub4=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae8a4da cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=A7k3Bbt6i4iCUiqUcE0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1OCBTYWx0ZWRfX+9/9RTYe20PF
 2yCgsN1aUtH8aiC3piyOnOYf00O7RtY7QeRF9jj2TR5Nu4Wpq51A1ER0rM5NmmTBqVzlIPMnSOB
 L33N50L3BBl9WyvAoB9XsCwqdaLYc+6yDGYmn7gq5eC+21IBoufhmc9hjEWqyIC7X57TMaWCM6x
 h0B2LXw5dGekaWDuhy4e7EPXbPDHTbAq5esqbedxO2idFVR45ARLdNCsmTKYVHsCa6eJIChKyiX
 fAXPBm0xmchdUJPTPrmnSjtzCsrq7qWhKxryKmBb5obS8rZ/aat+Bqm4sFN8N+mIWDy6v9eAMtD
 JmJxIXcuVVgsoA0tlc1e5MQt/5vncDlsdVMLXJ+hPjRa4OnfI69LeqDTd/eUtbZvCoulqJrNVPu
 YNBSg5Wz9bciLueWM8D8EOty7etl4kmam844Hhv5NrGroALfs9uW+7ZWMdG3wqrWJNq7jsS8d8g
 LRYRPFIeuVA3sbIbdxQ==
X-Proofpoint-GUID: gXAq9qwuCryGKVFaKbIYnWPiOrAOJPJ1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_04,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611020058



On 11/2/26 7:11 PM, Ilya Leoshkevich wrote:
> 
> 
> On 11/2/26 14:00, Shrikanth Hegde wrote:
>> Hi.
>>
>>
>> On 11/2/26 5:04 PM, Ilya Leoshkevich wrote:
>>>
>>>
>>> On 11/2/26 12:00, Peter Zijlstra wrote:
>>>> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>>>>
>>>>>
>>>>> On 11/1/26 20:21, Yury Norov wrote:
>>>>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>>>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>>>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>>>>> is enabled.
>>>>>>
>>>>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
>>>>>> and requires it to minimize the configuration space and runtime overhead,
>>>>>> with the lack of non-paravirt user. Now that s390 wants to adopt preferred
>>>>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>>>>
>>>>>> Make PREFERRED_CPU a user-configurable option, even if paravirtualization
>>>>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>>>>
>>>>>> Keep the default module selection conditional on PARAVIRT so other SMP
>>>>>> configurations can opt in without enabling the governor by default.
>>>>>>
>>>>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919- bf9897181834@linux.ibm.com/
>>>>>> CC: Mete Durlu <meted@linux.ibm.com>
>>>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>>>> ---
>>>>>> Can be applied independently from the rest of the series.
>>>>>>
>>>>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>>>
>>>>> This is really useful to us, since even though s390 is nominally
>>>>> paravirtualized, it does not technically benefit from defining
>>>>> CONFIG_PARAVIRT.
>>>>
>>>> And therefore removing PARAVIRT is the only possible solution?
>>>>
>>>>> Specifically, steal time accounting happens by
>>>>> computing a difference between wall time and CPU time, and not by
>>>>> explicitly querying the hypervisor.
>>>>
>>>> Nobody explicitly asks the hypervisor, that would be horrendously slow.
>>>>
>>>> Something trivial like this should do.
>>>>
>>>> ---
>>>>   arch/Kconfig                           | 9 +++++++++
>>>>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>>>>   arch/s390/Kconfig                      | 1 +
>>>>   drivers/virt/Kconfig                   | 2 +-
>>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>>> index 1163736de1f9..8980054beb52 100644
>>>> --- a/arch/Kconfig
>>>> +++ b/arch/Kconfig
>>>> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>>>>   config HAVE_PV_STEAL_CLOCK_GEN
>>>>       bool
>>>> +#
>>>> +#  Archs that can account CPUTIME_STEAL; normal route is through PARAVIRT which
>>>> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and PPC-LPAR
>>>> +#  which have their own thing and don't go through generic cputime accounting.
>>>> +#
>>>> +config HAVE_CPUTIME_STEAL
>>>> +    bool
>>>> +    default y if HAVE_PV_STEAL_CLOCK_GEN
>>>> +
>>
>> Can't PARAVIRT_TIME_ACCOUNTING be the kconfig we can rely upon.
>> s390 can add it to the config (similar to HAVE_CPUTIME_STEAL)?
>>
>> I guess it is selected currently where the steal time reporting happens.
> 
> Looking at update_rq_clock_task(), s390 would still need to provide a
> pointless dummy paravirt_steal_clock() implementation in this case.
> 
> [...]

Ah. Peter's change seems fine to me.
