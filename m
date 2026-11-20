Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795164664;
	b=3HVJTIMgnk6LFLAhAUGSQ0brBbLtHD/K4VE2cAuMKBHaInItCjVplcQOGIeM50qfbmnL
	 ndEW5Cy2E05qkfEUkB6JgnV15f5i93isNeuikTw8E18MHsafl0OhUZOnYN1+YyvFRE3X8
	 Jla81BtRR/r7Px5zi01qyYVvqTJdRRoGMrJU4GICKFl4brqZOhBI2vvh5uQGVCvWNO6Uv
	 hY8Mq4t0fvyHYmSM1W5x60GzCg4Zld5UGGt6FExNxapq4oXmGiLiH611Jy2Qy5HoqAmgs
	 UKkhgUZfna0XZDxaKEmIoiEcNKzBBx0NOea6mu36qo2cxCNjwTR5vaxITjw9qmfRG/A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795164664;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Authority-Analysis:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-GUID:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-Spam-Info:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=rQeV4mLH61WP4HKRkWH5RlX2hanHXt1wvj7nMXpNtag=;
	b=i20X++Gvtz9JlCaXhLFBRRrjmCc7TzBKaSyKK3xU9rLXJuW2v/V1en3DgLefRJTgfukl
	 Cpqly3uXuZwoKSwjSKhk0y172uHJ7vFtp7rce0af2NRQ0nPEwXjkNEHeqLGpnKKJUWiVL
	 /H/7ofebbS3aNa2Y96+Fs/tqlHzb8pcni5PnT/8ZHI+kxHcVWWZqVnihmC9pdHHnOtX7f
	 lnmWSB6bs7QX5FXLbLVf6Y7jEfiW34Kb6iCVqhVl/53fgPSi481z8DeGgZLJaA59fE+l3
	 LmkdchiSBUTu56WSAn7oy8vKUovQKTWO43aozYeB2rBF3stY/dpc1MI3v8PiYQwgyJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b="h/rwrOLb";
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7557D606A320;
	Fri, 20 Nov 2026 08:51:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7557D606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=h/rwrOLb
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7u0jJ2499599;
	Fri, 20 Nov 2026 08:50:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rQeV4m
	LH61WP4HKRkWH5RlX2hanHXt1wvj7nMXpNtag=; b=h/rwrOLbllz0Av07z3Ii+7
	V4H4XFRHRUv/hpACVSu28xiPEnLu+LSQBU3/6F1AoByidOHnDIYlepGcvdwjgBik
	vwz4p2mOGMrmf8TFr8FouCpM3FUGhacLYF/VdVSLRceIWzBjwiVktnLUVVhPkrc0
	eBEt6ES0GUFEXI57OoTHAd9GzAHFxQMHI/qaxwH2hABqbN26gbg+wEWd1Xm2ipi/
	jaXvBWWUcEayRExpfptQ6ct9RedDadvpxwBXXRiCVooTo5H3908+yX305C2xQgEE
	HznOD8N8iMLggaNm0ZQzIhE2olgUiWhtJVvoh9JQtMt4Ebj+JzksgTFTjPmA8Lww
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4j105tfacv-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:50:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AK7oG4a3921034;
	Fri, 20 Nov 2026 08:50:35 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4j1v9xf227-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Nov 2026 08:50:35 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AK8oUhC45482384
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 20 Nov 2026 08:50:31 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBE4220040;
	Fri, 20 Nov 2026 08:50:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5EEE42004E;
	Fri, 20 Nov 2026 08:50:22 +0000 (GMT)
Received: from [9.124.219.128] (unknown [9.124.219.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 20 Nov 2026 08:50:22 +0000 (GMT)
Message-ID: <0b449b4b-a336-426a-a72c-f6a560b5a8e5@linux.ibm.com>
Date: Fri, 20 Nov 2026 14:20:21 +0530
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
Subject: Re: [PATCH 6/7] virt: steal_governor: restart sampling immediately
 after CPU hotplug
To: Yury Norov <ynorov@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@kernel.org>, Juri Lelli <juri.lelli@redhat.com>,
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
        Heiko Carstens <hca@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
        Mel Gorman <mgorman@suse.de>, Mete Durlu <meted@linux.ibm.com>,
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
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-7-ynorov@nvidia.com>
 <37a30a91-bd86-4dbb-ad12-8cbb509f7c4c@linux.ibm.com> <av80SflNuKlReSEO@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <av80SflNuKlReSEO@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=IouL47/g c=1 sm=1 tr=0 ts=6b0009dd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=h26eGJ0Xg0KXshNN3FsA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: GolZFxeny-hTQ8ItVW_7LImiM5lsyRRd
X-Proofpoint-GUID: 9NzjNCzxe30-0qA4UebGSTWgkhUnc2X9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfX7Y4hh+K8EoUv
 k6Op5QfkkRdzNWRXVWG9xTy7/JydXtXl1vEaIFvfSPhF+3+X4XzoiJmWvzzUB+TzDcB9lfsJ9Ap
 VhPid8a3hit68OAnGovE5ZnE+gK/FwTn9rhXIybh5z2VCYHaQzdTCohfFptZ6xGkIcI1ler+qC8
 3dr7LN2WcQwKniq26NoWOTVPpei0ot+uP0JEiGTzCxJVuHcNAOtOU7lD15V84S7d5UcDGDAXwX2
 XbW8+XSB/a9iVwFT7HdvhynEtuKGlwmoPLj80ri3lkiBl+9ygRYyFpK3eRajKJ7jvA7LdSpWRaA
 RXLN4xhGCruFGmmZfZc248dQrqTkUEKdmC3JMACdIwvY5iwQzlqKDrKtdipIEXEXozrBYEcL2K7
 C0YdmrUzlTsFDw4hlTPtF+Az2p93OnCLmanHcqp4MwF0JZ3kQ2Chu4lTDS5dxx+zbB4QIk9ZJun
 Csq3l1+UhMbfBKMzj/A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDAzMyBTYWx0ZWRfXzQ6TGrODn+pl
 wpPMeZl7bZph4nVED4SRcN9vPe1OrXI3UcTb1x/ShX4G0WVLzmXZPpd1UMiyCYyh+Q8GOYVuixB
 44zDpx6OHugNRfxmvcxUqMzWGDKlZhE=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-20_03,2026-11-19_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015 malwarescore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200033



On 11/19/26 11:09 PM, Yury Norov wrote:
> On Thu, Nov 19, 2026 at 11:36:46AM +0530, Shrikanth Hegde wrote:
>> Hi Yury.
>>
>> On 11/14/26 12:12 AM, Yury Norov wrote:
>>> CPU hotplug between samples can distort the calculated steal ratio because
>>> the governor divides accumulated steal time by the current active CPU
>>> count, even when that count changed during the sampling interval.
>>>
>>> For example, assume a constant 3% steal rate on each CPU, with four active
>>> CPUs for 900ms followed by two active CPUs for 100ms. The accumulated
>>> steal time is:
>>>
>>>       4 * 900ms * 3% + 2 * 100ms * 3% = 108ms + 6ms = 114ms
>>
>>
>> This example is not realistic. If you had 3% steal with 4 CPUs, and if they become 2,
>> your steal time will definitely increase. It will likely double. So
>> governor likely calculates 6%.
> 
> You say it's not realistic, and then you confirm the math. So
> realistic or not?

I do not expect the steal time to remain consistent across after hotplug
completes.

Instead of speculating, we should to get the numbers from the actual systems.

Let me see if i get some time to get it w.r.t to powerVM implementation.

> 
> On my VM, there are 4 or 8 vCPUs, and the steal time hovers around 3%
> normally. Offlining half of them triggers steal governor pretty
> consistently.
>   
>> But yes, you can have realistic examples, where governor may calculate
>> the values which goes slightly above or below. But IMHO those examples are very
>> limited. Even in the above examples, the steal governor was supposed to trigger
>> high threshold since the steal time with 2 CPUs is 6%. So if not now, in the next
>> delta it would have triggered it anyways.
> 
> Sorry, I don't understand this. The governor is not supposed to
> trigger decrease_preferred_cpus() on offline event. If some system
> event skews steal ratio, the governor must adjust to that, or simply
> skip the iteration. This patch implements the 2nd approach, which is
> simpler IMO.
> 
>> Some examples are really corner cases. Maybe like
>>
>> 60 CPUs 3% steal, and then 40 CPUs 5.1% steal = 4.55%
>> (Below threshold, but should have been high). One interval missed. But if you see
>> large duration was in low threshold, so it is agreeable to miss it.
> 
> Don't understand this either. Can you elaborate on your case and math
> please?
>   
>>> The elapsed time is 1000ms. Using the final count of two active CPUs, the
>>> governor calculates:
>>>
>>>       114ms / (2 * 1000ms) = 5.7%
>>>
>>> This exceeds the default 5% high threshold, even though the actual steal
>>> rate stayed at 3%. Using the CPU counts over the whole interval gives:
>>>
>>>       114ms / (4 * 900ms + 2 * 100ms) = 3%
>>>
>>> Checking num_online_cpus() doesn't account for cases where CPUs go online
>>> and offline such that the total number of online CPUs doesn't change. So,
>>> implement the sampling restart on hotplug event.
>>>
>>
>> I am not sure if we really need to stress about hotplug cases. IIUC, when a user
>> does hotplug, systems are usually idle. (Atleast that is what we have observed in
>> real life use cases). And hotplug is really user driven, so user knows system is going
>> through some transitions and will be stable soon.
> 
> The follow-up series brings a real counter example: Android daemon
> running on Qualcomm SoC offlines CPUs on thermal event. So, it's
> automatic and the offlined CPU is likely not idling.
>

I wasn't aware of that. So is it userspace daemon or kernel module/driver?
  
> Thanks,
> Yury

