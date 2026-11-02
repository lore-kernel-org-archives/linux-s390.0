Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793626937;
	b=0gKA5ZWFldDZ+g4J0jRw84+Y/uMZ97J6PqEmrXfLDkCd9nUTkFslriCZn9albCFWH6GT
	 2slFg8xUAygnJ+56MHscjIkdtmyB2xO3SDCXpMRVI2kdBw9wF/4n0zQ67Qsdi+kWiJZaQ
	 irdg/haOhSavHbmk9S4f/uQ3sCtgfSYqy5FS8Xxk0IxgTmuhC9f2J16mTjps1s5JcQKt1
	 py3Z0aw9CsdV+wz09CxjDrtUGdKDj0MB3kEIP4NMtQLodU0Qz9C8xX7z8J8yjtyqXTicC
	 RqhzVviYVgDpzxi6uUXXrHtLYEP7WdBR3vh9xW3IgVGND/X3JyRNuH60CIwpR9GUviA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793626937;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=UEpcSuoFqEU8xXewyaWkpW5bmOJntelIEVu5k49doYk=;
	b=ZB5hLZcIkXOXq9EpvMyXDfrDOH/CQjMBgq0PI+DpoMJsag+hXSFB2oXG7svbvXxmj57T
	 7J6akg8AI6Y+L2+lqCsLef++/qRzDDvpilAIOqK3tlDF4Q/oUf8/B7d6MBkacfWGGirHE
	 uw/JI4tEOjf06KybFgg/uJ2r3kXwso8VDIeTfKJIdgAZ46Z+y6D6fk1gRihqhoDQsOOYT
	 J38iJZo5/j2vHyBb9Z9bOHlape2avxZc81akREOzd+ACQgJ5GUHsHT/IrsLfWDD5ZPEd2
	 SegOvDuGFmyeGmgn4UAmAPJFwnsX7ArfVVkFG/eALJNJJEcvCG6UaEuxQ80y7dqJmxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WGDyMGgm;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0B84606A326;
	Mon,  2 Nov 2026 13:42:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E0B84606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WGDyMGgm
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DEgSR2988247;
	Mon, 2 Nov 2026 13:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UEpcSu
	oFqEU8xXewyaWkpW5bmOJntelIEVu5k49doYk=; b=WGDyMGgmcCIA+EQ+yL/0Fx
	CFnXpp6JQ+mK4Hm6Pjcpo+j0r9Hya4GbG1gg7J9UohE0VkWJYq5kbt0JjrNT5e1z
	UuYsU3TnDkOwgM/D+EQA6YhQpLBgsFPjpTH7Uqlf4dWstNCDXUeUXM085Av/9K+K
	nxjVk11rhS5VAsHPBSxioSkJx+jjJL0KwBwEzh0uDWRlUkuh9GA6zjaXLJ6lHy77
	Mex79E6OIX8mEjeb2qUk0jCeRO0BEk4OGCZrUfPm5U2AnrIcqJlfn/lE74f4Q1xn
	NjhUSsYDotCWFZoZeJtkBoQChiklmYvVTwRKOYQCORt3v4XFzOBgZ9XTDNMijTEQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn7yrrm6q-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:41:44 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A2DJsRu3980386;
	Mon, 2 Nov 2026 13:41:43 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hnvvfnug1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 02 Nov 2026 13:41:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A2Dfdg747120682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 2 Nov 2026 13:41:39 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9EC720043;
	Mon,  2 Nov 2026 13:41:39 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 665E820040;
	Mon,  2 Nov 2026 13:41:38 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.80.131])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  2 Nov 2026 13:41:38 +0000 (GMT)
Message-ID: <efe1657f-b1c6-4096-8868-fb53097b1847@linux.ibm.com>
Date: Mon, 2 Nov 2026 14:41:38 +0100
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
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <66ccd713-5571-4c1a-b59e-29adbc9852e3@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=Mcr5KJ/f c=1 sm=1 tr=0 ts=6ae89318 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=2ZLY2jDhLclDGvpxdKIA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfX69IfUWuXTaKy
 lgapWBy+4j0Db8jWpHuOaqVb4/k38jkUggDwHhkZ+cAL0qa1YWqK60q+fkWAeF1iHPjJdwi9Bno
 cnUMwqkCtBYs4YPzMDbRtGQoDYASDpk=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAyMDA1MiBTYWx0ZWRfX8ehtqKALxD9L
 ST32w2EwWwZB9HWoyUnI+Y5+AuZNgSWl8N//MyjhJXxqXie2DwTc1GwxexF5GN6UeoomF/T9fj8
 aFHCHE85Imccbx16229F9mqbt0kZnr+uriGgUaNpX8vzKCb2Yn6oABvg7yTP2c61Leh0acbPxqU
 Hp+lqnxFw94BYVd2LLCeotULH//5XnbuETrISaCjIN2Q1+BTxZcQLhqKnf+sxi5qf963kk7SxZ1
 RkxRybBpfjXtkiz+k7opRYDIsXwI2xy0FpIl8N+AlHxQcJAJjovoYEL66PFxqtZS1usCBRs27aQ
 kNt3z0jmxUcbti8u0dDHSEgmXohJEwChK7TfQzcBvrwHvteajRbglWn9LgQ/0pND6l+ZKQ1Suyv
 yZPc4ORAkqxZHvXnDhLXr6/VCllJ1nK5Yqu0Eh68nUv5J2edaUCBhw50N8/LrjtTbnuGbfjcJBZ
 wMLsR1pdgyxH40C7iyg==
X-Proofpoint-GUID: WV_hIbVvQLek2yXOApJDBgykXKFSyc_m
X-Proofpoint-ORIG-GUID: A8u9pJY9wVFah2z3BUYt1cdxZpJkRdOT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-02_03,2026-11-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 adultscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2611020052



On 11/2/26 14:00, Shrikanth Hegde wrote:
> Hi.
> 
> 
> On 11/2/26 5:04 PM, Ilya Leoshkevich wrote:
>>
>>
>> On 11/2/26 12:00, Peter Zijlstra wrote:
>>> On Mon, Nov 02, 2026 at 11:16:30AM +0100, Ilya Leoshkevich wrote:
>>>>
>>>>
>>>> On 11/1/26 20:21, Yury Norov wrote:
>>>>> The IBM s390 doesn't enable PARAVIRT config for their hardware
>>>>> virtualized Logical Partitions (LPAR). However, the steal time is
>>>>> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
>>>>> is enabled.
>>>>>
>>>>> Preferred cpumask doesn't rely on any feature gated by PARAVIRT 
>>>>> config,
>>>>> and requires it to minimize the configuration space and runtime 
>>>>> overhead,
>>>>> with the lack of non-paravirt user. Now that s390 wants to adopt 
>>>>> preferred
>>>>> cpumask, there's no reason to keep it coupled to paravirt.
>>>>>
>>>>> Make PREFERRED_CPU a user-configurable option, even if 
>>>>> paravirtualization
>>>>> is not enabled, and drop PARAVIRT dependency on the steal governor.
>>>>>
>>>>> Keep the default module selection conditional on PARAVIRT so other SMP
>>>>> configurations can opt in without enabling the governor by default.
>>>>>
>>>>> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919- 
>>>>> bf9897181834@linux.ibm.com/
>>>>> CC: Mete Durlu <meted@linux.ibm.com>
>>>>> Signed-off-by: Yury Norov <ynorov@nvidia.com>
>>>>> ---
>>>>> Can be applied independently from the rest of the series.
>>>>>
>>>>>    drivers/virt/Kconfig   |  8 ++++++--
>>>>>    kernel/Kconfig.preempt | 12 ++++++++++--
>>>>>    2 files changed, 16 insertions(+), 4 deletions(-)
>>>>
>>>> This is really useful to us, since even though s390 is nominally
>>>> paravirtualized, it does not technically benefit from defining
>>>> CONFIG_PARAVIRT.
>>>
>>> And therefore removing PARAVIRT is the only possible solution?
>>>
>>>> Specifically, steal time accounting happens by
>>>> computing a difference between wall time and CPU time, and not by
>>>> explicitly querying the hypervisor.
>>>
>>> Nobody explicitly asks the hypervisor, that would be horrendously slow.
>>>
>>> Something trivial like this should do.
>>>
>>> ---
>>>   arch/Kconfig                           | 9 +++++++++
>>>   arch/powerpc/platforms/pseries/Kconfig | 1 +
>>>   arch/s390/Kconfig                      | 1 +
>>>   drivers/virt/Kconfig                   | 2 +-
>>>   4 files changed, 12 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/Kconfig b/arch/Kconfig
>>> index 1163736de1f9..8980054beb52 100644
>>> --- a/arch/Kconfig
>>> +++ b/arch/Kconfig
>>> @@ -1080,6 +1080,15 @@ config HAVE_IRQ_TIME_ACCOUNTING
>>>   config HAVE_PV_STEAL_CLOCK_GEN
>>>       bool
>>> +#
>>> +#  Archs that can account CPUTIME_STEAL; normal route is through 
>>> PARAVIRT which
>>> +#  selects HAVE_PV_STEAL_CLOCK_GEN. Directly selected by s390 and 
>>> PPC-LPAR
>>> +#  which have their own thing and don't go through generic cputime 
>>> accounting.
>>> +#
>>> +config HAVE_CPUTIME_STEAL
>>> +    bool
>>> +    default y if HAVE_PV_STEAL_CLOCK_GEN
>>> +
> 
> Can't PARAVIRT_TIME_ACCOUNTING be the kconfig we can rely upon.
> s390 can add it to the config (similar to HAVE_CPUTIME_STEAL)?
> 
> I guess it is selected currently where the steal time reporting happens.

Looking at update_rq_clock_task(), s390 would still need to provide a
pointless dummy paravirt_steal_clock() implementation in this case.

[...]
