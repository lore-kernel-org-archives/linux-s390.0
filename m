Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794460191;
	b=YydkyqvNq6SAM9C6jAzwJfuInIkHWrGhRY8dr9lGA2ng/dCmD54fXrfStY4HMyhL7GoC
	 KwckVDk2lYluMLXSAeIbOjnCT50A7Q0osCF5gYl6+oyBzsSPtlw3Ask8IrIj6DBhmJ9ws
	 ANIMxJcNhFrdoDJ4Idh+8tCQcAor7ExaUbxHVDUowfXJuDN4ZxCgTv0+7PcT688zwrcUM
	 zTETx1GSZG/Pil6gDqyg8K6tBTt3j27S8YleL1j1dwyMUpSujJloHnJP5rKKfjBLc281b
	 aLZCOsqgkTCVaompuDvCNcfKBN6EQluPmgs1dDGlgNjyrnJfb2GepUaVsXa/+ij/Ewg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794460191;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:Message-ID:Date:MIME-Version:
	 User-Agent:Subject:To:Cc:References:From:Content-Language:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:X-TM-AS-GCONF:
	 X-Proofpoint-Reinject:X-Proofpoint-Spam-Details-Enc:
	 X-Proofpoint-ORIG-GUID:X-Proofpoint-Spam-Info:X-Authority-Analysis:
	 X-Proofpoint-GUID:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=nVVIfN4BTkm5Q9xCDqSEMw7hlfWL7ACUPVcuHFZ/o3g=;
	b=SMRLO2xDlwSiozn82XgngJ0sTR3wFJRpnzbX+GMa9mjZY3l6xUGOSDKeTqGXDJGGReor
	 zMFlYNWv5fX6EStLQrTBu0h0pKkYbgefLOfuxKU0Fdoy+MkRDMyGuO9HfQG5KJnm3ZLLp
	 RTyr3IwGbEY9j2aSSkkQs7KclFAL4q1oET6JxVKZvYJVqSZ/5TOkbTsrJldH8TTlYHvxt
	 3p7H05MREg250goVGsOd9e/PSiU6kanAHGo4Iz3UfFhnOGXB41ZB3oAU8hA3RVJohvBx+
	 whb5ZgPZS+ztejstWh4RiUbEm4jpVG1Gk4bqDs7Ky6Y8lM/ZxGvlExHH6jtKsYCHGLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OlG5tUX1;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D2E606A31C;
	Thu, 12 Nov 2026 05:09:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 84D2E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=OlG5tUX1
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2iXeY1214888;
	Thu, 12 Nov 2026 05:09:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nVVIfN
	4BTkm5Q9xCDqSEMw7hlfWL7ACUPVcuHFZ/o3g=; b=OlG5tUX1O2ww6cm14macBK
	cjdgAgo854InLT7kSM7FJBlU0ki9XlUW6NlQAycQTkwTh+HDjEbPX3cQvzHZs6zm
	KnoQoE5MO47PSQIRmChH5gDaAm9K/vycIVK8ulHnbbe34AuQfZMIap6DN3IU+DQM
	GO/fMKgGYq+U0XuXx4v9P66yTDkWnjRlghuRnxmZ9dc1CDTzNVm2qSsqPBD5tJ3t
	CcQiv8l0f5RD/w4Z2iA1PaZL4IYYH1QMQ04qiTZdeL789Gt31X7YKUe2nLm8FHvj
	PuYoaETiuPCHOcTWdYaJRlNC42SnLcgUac7/sq0B8YOEJLPfRkLftjJ6sxwkxnew
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hsuntdwak-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:09:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 6AC2ZnlC016704;
	Thu, 12 Nov 2026 05:09:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hv3327f2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Nov 2026 05:09:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6AC59DeP48890152
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Nov 2026 05:09:13 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F1720043;
	Thu, 12 Nov 2026 05:09:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CA882004E;
	Thu, 12 Nov 2026 05:09:04 +0000 (GMT)
Received: from [9.39.17.134] (unknown [9.39.17.134])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 12 Nov 2026 05:09:03 +0000 (GMT)
Message-ID: <1d170fb4-7e78-4c8c-9cd0-642973dd9163@linux.ibm.com>
Date: Thu, 12 Nov 2026 10:39:03 +0530
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
Subject: Re: [PATCH 0/6] sched: Expose writable interface for preferred CPUs
 mask
To: Yury Norov <ynorov@nvidia.com>
Cc: Maxim Kuvyrkov <maxim.kuvyrkov@grdncc.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
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
        Heiko Carstens <hca@linux.ibm.com>, Johan Hovold <johan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        K Prateek Nayak <kprateek.nayak@amd.com>, Mel Gorman <mgorman@suse.de>,
        Mete Durlu <meted@linux.ibm.com>, Randy Dunlap <rdunlap@infradead.org>,
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
 <A2B09626-39F0-4EC3-B57D-CD83D77DD208@grdncc.com>
 <1d1b22ce-fdf1-47ad-99ec-8c9925ea7275@linux.ibm.com> <avSorfTkB3pZX2ic@yury>
From: Shrikanth Hegde <sshegde@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <avSorfTkB3pZX2ic@yury>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX311hCVMLD0Hc
 Kt4HlOAhsQOnWUC78GYq0edsRUwn/hPsvXRE3OjmQrYBWkTXjJYTVt//CaMzQmiyJiFcEeQt4dq
 vo3NkFb+W8PLaZnW49I/NRYDGE9AFmQsWN780tb+WzHjhYt7Ch9fNLotNoO3RYhwzKaCzd7+N6B
 /c4T1cKQhIBP1tyR2piSpOenZ8vV6pDAPEY4Jny41DxLMvLJ/d9RdrCu4v5NImh0fjwgko8Ww4R
 k02HM7PxH0hpwyse1d7IJlrZ2QYsCAjR+uh2DTSX+4lfHqxFlmTA2fEpmACYtQyummjm59IghOZ
 KB0fLOcg8MW5xJV6vsKAuKhDvJGxXWuY33rCcHefh3ifSIoe5Rh4qXTT3MGTLAJvo2uBfJA8ipK
 2BhVQr7fsdkOVlneP2+PTyDyqKDyn6Be1T5jFxK1ITZ2yxdTZp3hA1RowSimbEnYHk/anYWRRmI
 ZCD8oJrRiuO6BsiXcjg==
X-Proofpoint-ORIG-GUID: mwJVrk1495EbgCbioZERqcZZWLE3v8di
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEyMDAxOCBTYWx0ZWRfX90f2Q/uxeZHe
 BwIB1tOEwf31qkUi5OKpqWym4bFrZxa0Gc7VkteZXl9nM1Kv2x61K2UKk2Wbk43/y8QCoyE1H6x
 avmCGoBVhmICPW77VY2mhOr/bWo8nnI=
X-Authority-Analysis: v=2.4 cv=euZKXYpX c=1 sm=1 tr=0 ts=6af549fe cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=Ikd4Dj_1AAAA:8
 a=9Qk1hqGbzmtnogXl2ysA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: eD0RfhbmiDm4gZvmVYr9UM_KGr6YPB50
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-12_01,2026-11-11_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 suspectscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611120018



On 11/11/26 11:11 PM, Yury Norov wrote:
> On Tue, Nov 10, 2026 at 02:45:58PM +0530, Shrikanth Hegde wrote:
>> Hi,
>>
>> On 11/10/26 8:45 AM, Maxim Kuvyrkov wrote:
>>>> On Nov 2, 2026, at 08:21, Yury Norov <ynorov@nvidia.com> wrote:
>>>>
>>>> The preferred CPU mask currently lets the steal governor reduce vCPU
>>>> demand when physical CPUs are contended. This series adds manual control,
>>>> opening more use cases.
>>>>
>>>> For example, setting CPUs aside for selected fair tasks at runtime while
>>>> steering other fair tasks toward the remaining CPUs.
>>>
>>> Hi Yury,
>>>
>>> I've been trying to do this with crutches in user-space for a long time.  Thanks for implementing this in the kernel, and with a convenient user interface.
>>>
>>>>
>>>> A user can mark a CPU non-preferred and pin a workload to it. Fair tasks
>>>> whose affinity includes preferred CPUs are steered away, while tasks
>>>> whose allowed CPUs contain no preferred CPU can still run there. The CPU
>>>> stays online, task affinity is preserved, and the selection can be
>>>> reversed without rebooting:
>>>>
>>>>      # rmmod steal_governor
>>>>      # echo 0 > /sys/devices/system/cpu/cpu3/preferred
>>>>      # taskset -c 3 ./my_workload
>>>>      # echo 1 > /sys/devices/system/cpu/cpu3/preferred
>>>
>>> My use-case (being a compiler optimization engineer) is to pin benchmarks to specific cores, and stop the system from using those cores even when the cores are idle.  This prevents L1/L2 cache pollution and makes performance numbers more stable.
>>>
>>
>> Do you change it when running workload based on any signal/event? or you set it before starting it?
>>
>> If it is set before starting, you might as well offline the CPUs to achieve the same. I assume you are
>> managing the preferred CPUs manually with write interface. You can do the same for online state.
>> (Though it takes a longer)
> 
> How that? I tried, and offlining destroys the affinity, as it should:
> 

You are doing "hotplug when workload is running".

>    # taskset -c 3 sh -c 'while :; do :; done' &
>    [1] 380
>    # taskset -pc "$pid"
>    pid 380's current affinity list: 3
>    # echo 0 >/sys/devices/system/cpu/cpu3/online
>    [  115.767634] process 380 (sh) no longer affine to cpu3
>    [  115.772881] smpboot: CPU 3 is now offline
>    taskset -pc 380
>    pid 380's current affinity list: 0-2,4-7
> 
> Did you mean something else, maybe?

What matters is how/when you start the workload.
 From the use case, I see it is about using only specific set of CPUs and there is no explicit affinity assigned.

Sequence1:
1. You are setting preferred CPUs.
2. You start the workload. Workload finishes using preferred CPUs.
3. You set the preferred same as active.

In that sequence, offlining the CPUs is going to be similar. You are managing preferred CPUs, you can as well manage
offline CPUs. Most of the workload check the CPU state before assigning any explicit affinity or spawning threads etc.

Sequence 2:
1. workload is long running job. Lets say comprising of warmup/steady/closure phases.
2. You only to run on specific CPUs during steady phase.
3. You fallback to active during closure phase again.

In that sequence what you said about offline breaking affinities is very much possibility. It is
good to set preferred CPUs in this sequence.

but reading maxim's description it fitted Sequence1.
