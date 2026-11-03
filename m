Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793685010;
	b=jMlyYUr2ONHzm5WjCW56tdlNg8y/j7ehPqhw18YmTP0zhTeRKFShOMKS8GgtWMuFEcYw
	 6+rkRRM5m4fRYLbAa8X7Twobi1Ynh/QHhJurqPQ8Am6pYdKuNfysKCDMM9LrFpNzOPG8R
	 QXYKB+rtYXnNuD0ZE59yJ98EaW+hlL3hOfF36HUwnEaG03JMX1jrgE73cEsW5mTmitGUo
	 zTFyk7EQ668jo8une4PpC7G2g4IF5Em7XuqS7mVkDwPPcZhHfi9+AJzYXdNnyFa407GmW
	 QKDHLvt2vF9lUYWfZCnokOEIFkye3M4vrZPJbukYbIt/MWXg8M4gZZjQe5wvtTp6EmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793685010;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:Content-Language:From:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:
	 X-Authority-Analysis:X-Proofpoint-Spam-Details-Enc:X-Proofpoint-GUID:
	 X-Proofpoint-Virus-Version:X-Proofpoint-Spam-Details;
	bh=oEZv5xTdgeP9X/uO6g9HMr199joVAXGoTWQpcGadm9Q=;
	b=FpcZbfG/Y305fUTIwfTcZq+qPZnB7NTxNm8IlM6d4OpYyAnLlU32aDmHF1HacT29NJBW
	 TDNvCBZiTrwWeRGRIBUWioxOZPHc9V6YB6kf05SMllIR89ADekyB4LjweSUgOCkuNetbk
	 ZDUv0EeIlxgJHnZ2zlUOH+d0ps6slEJ0Q+7cybEHYgLIEq+HFLyueBkIG6xWC+UjFR2vk
	 CJEZe4eaBUOeq9N5OJLXjOgncmqwf5B1G1Z7yhdo/t1+BGqcz1O0YLLY6i3nQaqXP+CF8
	 a3zcEMPbOG0scLAdY6kNqN14OStGtKN4NkQKLJsVDXEam0c5wdSFOwaGJxgZ7XzeQfg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyeccGag;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED223606A324;
	Tue,  3 Nov 2026 05:50:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org ED223606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=UyeccGag
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31iMpg236041;
	Tue, 3 Nov 2026 05:49:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=oEZv5x
	TdgeP9X/uO6g9HMr199joVAXGoTWQpcGadm9Q=; b=UyeccGagKpF3KDWFh2ldnI
	/xZ1H+rduhEzrfXwYRxKUigqihnzqdOJo3rDA5qxn2M8AFwl/9QEHqwvPbM4XoI5
	ObTtOrZ2pTpzrqBFbamngc634lvSKtbcjyYh3fierEknos57sWtkSzNAG0UssTaj
	NpA1Mi327z71LrVLhOLOxV8BjpJyaYKtum2JUzWyE80yCv6l6M/4hqJ15LjVCB/v
	LNx+wxOpCxy2vPDIVRtDlNvBIdZPwsaHopXQMPNwwY9M9D+oOnPW/s5gfntxpgSE
	EObzgZXvkSC4Jzv+jL7n6wu7uhLs18277iVfZfH+dOXsB0eyTStCfdRwV4X6TGCQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hn5rhm4py-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:49:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6A31ntH51870571;
	Tue, 3 Nov 2026 05:49:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hnv5grwnd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 03 Nov 2026 05:49:42 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6A35ncNO16777672
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 3 Nov 2026 05:49:38 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 090CA20040;
	Tue,  3 Nov 2026 05:49:38 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F02F020043;
	Tue,  3 Nov 2026 05:49:30 +0000 (GMT)
Received: from [9.124.212.4] (unknown [9.124.212.4])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  3 Nov 2026 05:49:30 +0000 (GMT)
Message-ID: <439758ce-c807-4b5b-b2e5-31fb9f1c6f11@linux.ibm.com>
Date: Tue, 3 Nov 2026 11:19:29 +0530
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
Content-Language: en-US
From: Shrikanth Hegde <sshegde@linux.ibm.com>
In-Reply-To: <efe1657f-b1c6-4096-8868-fb53097b1847@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: 06K1uN32fnwmS5VV0MjvNToEtF3khrN2
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfXzZ+xB9otBfCh
 DtoReLZhszPxKjeckAJBG7TNsvIUf76Titegnm5vZ9s9fpMfU2XMPlWTSfJjrjGJ0k0aUC7QRT1
 IYIud+R9ZTZ7/+5aFuWk9Y5UmiBrKjQ=
X-Authority-Analysis: v=2.4 cv=LokHWXdc c=1 sm=1 tr=0 ts=6ae975f7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ikd4Dj_1AAAA:8 a=A7k3Bbt6i4iCUiqUcE0A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTAzMDAyMiBTYWx0ZWRfX47H2TT4fxrNI
 dKcIaIIeiJH9WxrreMDUuKl+r+YZQPLbvcPHZm59MJAiVJtqWCcoA6/+neZkv12rgfiFE9xhgl1
 Y2503FTMcL4YzATlfyp55RJpCIpFgPNwMauaLgKIaPB/8Adz+HVDeWrFYrs5kydYZJ5Jet93h7r
 GMJSskgxvLawv29TZz9/BFatBAhwO7faGOsa9YTnP38gcnwwnFIMpPVP2sDf4jqlrOIGXgtmunT
 RdGxNSGiYO6lIuBIUNQBRU8Y2aojfYvw7vOwS/SZ5g5mZKnfZQeSinV8kNU+L2EFyawcc7A/Hzt
 B+9C8I0QC/0f+wCBRNerHWGFzWqLaLIIG0dVeeEKAPCQR1yPDaCnlXsHERKxD132Z5hXjK8oYma
 bpV01sLxXIZuQySojJN4Lfj+IVmsfbs0fjUvTpFDXRPX9oqSQRBRqajtWKFVvlwc5nqW6UYQ9pV
 UMX9uQEZYGfvHyytQIA==
X-Proofpoint-GUID: wzujVa4uD6spEvCaJi-IgRNS-FcdMrr4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-03_01,2026-11-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 priorityscore=1501 suspectscore=0 phishscore=0 malwarescore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610300000
 definitions=main-2611030022

Hi Ilya,

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

Other possible option is, you could use CONFIG_HAVE_PV_STEAL_CLOCK_GEN which
defines the dummy implementation and you don't update that method. That way
you may implement PARAVIRT_TIME_ACCOUNTING mostly with kconfig changes.

But it needs the arch to implement static calls. I am not sure if s390 has it.
