Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 276BA1BC08F;
	Fri,  8 May 2026 02:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778208419; cv=none; b=QJJLrRWRMm0ROAuIQWWFOQoKdWQ/ynauzCJYlFrrctx241TiwkazEjn3WNIs2LVql3+1eqstyLXcYKZzh9W5BWiY6MLGiAxEJgXxVMNRJpjBloCB0E+qGOBXOYoT9C/hQGZDjpKqP5SLaLw+eGGDboCRCqBvxA22O9yLMda5FFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778208419; c=relaxed/simple;
	bh=0wuHm2DBUjZYY1XQ/rksav11ry/G6vzwstfa20sKkdc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jv22AwYSA3l6+GPslee9PuTPjwVbH+Xj+ZvAeBulkanECdG82s4hL0EVa4om++xBVKr7pDCpPCBKF7iSBSyLfEeN6xSz3MhJ+Gocc/poUfACLJd6QrSGWV0x0E7QAjw1uCjYq74wURB35BH3ykMZt/vj0VyYRFWKiTpCsXbvH4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EWxXkMei; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EWxXkMei"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6481pWuD001076;
	Fri, 8 May 2026 02:46:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=JZAHB8
	zZ+ziDSkZyyHEh8/JAi5IvuvURq53YKwydD5o=; b=EWxXkMeiZMED7+llHDdjOq
	sagTzLbViAqWRiphB/l2gsU3DbVoi5PRYjS8YYFKaFrCMM0zRDsRdhE8pAKF9Lb2
	QLLdpYeo9b717iCYrEXdslkuNB7F/UZZfssM0MdhvsM6h0aKhN1EYRa9xTYGysXv
	rFe+3cvfZP86J6B1AC8cvi/RWtrjmWZzpex6r8jnEQEVIpbDaljCPZDSqq6RAHJo
	YjEZ1gAddpnhlUG9J5LcJ9+QVbHvUyt6JGq9aHG0Vqo8DOwSexSY5lqDta0kKxbe
	On5bhgBRvCkTvSoQkrpq6uy/lAeO5JPoooRE68JI1SEA2RJFmm5NnFkpPWpqiUgA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dw9y1sq9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 02:46:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6482dPhF008099;
	Fri, 8 May 2026 02:46:47 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dww3hec0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 May 2026 02:46:47 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6482kkL77078790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 May 2026 02:46:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 49E3F5805E;
	Fri,  8 May 2026 02:46:46 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0629C58059;
	Fri,  8 May 2026 02:46:45 +0000 (GMT)
Received: from [9.61.252.91] (unknown [9.61.252.91])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 May 2026 02:46:44 +0000 (GMT)
Message-ID: <a2a8205a-18b0-46d2-8334-c59d08bad61e@linux.ibm.com>
Date: Thu, 7 May 2026 22:46:44 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] KVM: s390: Change the fi->lock to a raw_spinlock
 for RT case
To: Heiko Carstens <hca@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, imbrenda@linux.ibm.com, frankja@linux.ibm.com,
        david@kernel.org, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
References: <20260505173728.160562-1-freimuth@linux.ibm.com>
 <20260505173728.160562-4-freimuth@linux.ibm.com>
 <20260506045734.11230A02-hca@linux.ibm.com>
 <d39c54bc-1984-490c-9457-5eff63edef56@linux.ibm.com>
 <20260507095630.10395Aa0-hca@linux.ibm.com>
 <191a1272-1f8c-4a67-a01d-abfdb89fcaf5@linux.ibm.com>
 <20260507144549.10395C64-hca@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <20260507144549.10395C64-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FzpwB4_BDhZn1ujneS2Wu-HporDlLmdH
X-Proofpoint-GUID: FzpwB4_BDhZn1ujneS2Wu-HporDlLmdH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA4MDAyNCBTYWx0ZWRfX3qaeNsV3x9gV
 Yyq7hpm6pcVWA5C53xCTok9FmMaKGObAO1mBkdz1SEdm/Nb5F1vKHah6q3mmCETu2BnOg4hOzt8
 cT5cwnXqNXriJyF+K006IP4KeqP4RY/85aQXC5ZRZZENxy95DlJzE/VuF0HxxBdcPAQrlJ8UZjE
 HJmqvxl1b+qblhKj8LV+ig4MKJuC6I89kcPtu5GYnZcbxgfxKWl6BzTC4wXCProsl7noR5tB5Rz
 pTYnQ3ylEJxQClnGoLeiFHAGXQE86OeU3lCfqsWcfurVutb7N0oxFDAohSUlrnAbXpFVQ82twWf
 kN3HU3CWS6BJH8Xlt1d4Aq5w5HkrRblJHks7dQRTtXVUf96XoHJ/dt2WE2zQVRsuq4vFJE3LqcL
 Su2jR7Lco8UHJpGeXeGkZ7UrkbPK98aIncgVUUt9G75WKlNxTDk/GZbq+9IWPwwz1eLQea/PNk2
 hVWn16QN5TDU3Jsr1rA==
X-Authority-Analysis: v=2.4 cv=UbFhjqSN c=1 sm=1 tr=0 ts=69fd4e98 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=wfSCA59WKBiZBFrDZ7EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 malwarescore=0 suspectscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605080024



On 5/7/26 10:45 AM, Heiko Carstens wrote:
> Adding Peter :)
> 
> On Thu, May 07, 2026 at 09:17:00AM -0400, Matthew Rosato wrote:
>> On 5/7/26 5:56 AM, Heiko Carstens wrote:
>>> On Wed, May 06, 2026 at 10:50:52AM -0400, Douglas Freimuth wrote:
>>>> On 5/6/26 12:57 AM, Heiko Carstens wrote:
>>>>> On Tue, May 05, 2026 at 07:37:27PM +0200, Douglas Freimuth wrote:
>>>>>> s390 needs to maintain support for an RT kernel. This requires the
>>>>>> floating interrupt lock, fi->lock to be changed to a raw spin lock
>>>>>> since the fi->lock maybe called with interrupts disabled in __inject_io.
>>>>>>
>>>>>> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
>>>>>> ---
>>>>>>    arch/s390/include/asm/kvm_host.h |  2 +-
>>>>>>    arch/s390/kvm/intercept.c        |  4 +-
>>>>>>    arch/s390/kvm/interrupt.c        | 68 ++++++++++++++++----------------
>>>>>>    arch/s390/kvm/kvm-s390.c         |  2 +-
>>>>>>    4 files changed, 38 insertions(+), 38 deletions(-)
>>>>>
>>>>> s390 does not support RT, but I guess you are referring to a lockdep splat
>>>>> which you would see without doing this change, similar like we have seen at
>>>>> other places.
>>>>>
>>>>> Can you include the relevant parts of the splat for reference, please?
> 
> ...
> 
>> AFAIU it is only problematic if we (s390) should ever want to support RT
>> in the future.
> 
> I don't see that coming, but nobody knows what happens in future.
> 
> ...
> 
>> My original thinking was 'well, it won't hurt to use the raw spinlocks
>> in the new code' so I set Doug down this road with my review comments --
>> I did not consider that there would be a need for additional fallout
>> like this patch, which means increased chance of regressions (see below)
>> to accomodate a feature that we don't support today.
>>
>> If you are saying it's OK to simply not care about RT for s390 now, then
>> AFAICT it should be fine to just use s/raw_spin_)lock/spin_lock/ for
>> this whole series, drop this patch and then ignore the subsequent
>> Sashiko complaints about RT.
>>
>> What do you think?
> 
> So... after having given this a second thought: we do not have
> PROVE_RAW_LOCK_NESTING enabled in our debug_defconfig (either we missed it,
> or somebody (cough) thought it is not relevant for s390). That said, I
> believe we should enable it, fix all fallout and also make sure that new
> code does not generate any lockdep splats with PROVE_RAW_LOCK_NESTING
> enabled.
> 
> Rationale: even though it is not relevant for s390, we also change common
> code; and by ignoring PROVE_RAW_LOCK_NESTING we might cause problems for
> other architectures by introducing incorrect nesting of locks in common
> code. So yes, your thinking is correct.

Heiko, to be complete, I went through the exercise of enabling 
PROVE_RAW_LOCK_NESTING. I created a small hack to generate a 
__deliver_machine_check to trap the nested locking issue. The requested 
splat is below. Here the floating interrupt lock is a raw_spin_lock and 
the nested call to local interrupt lock is a spin_lock thus the nesting 
issue. No other nesting issues were found.

Now we need to arrive at, do we keep the raw_spin_locks to cover the 
possibility of future RT support or common code? In that case I also 
make the li->lock a raw_spin_lock. OR should I drop this raw_spin_lock 
patch and back out any other raw_spin_locks since we dont currently 
support RT on s390? And end either choice by testing again with 
PROVE_RAW_LOCK_NESTING.

[  187.278926] =============================
[  187.278927] [ BUG: Invalid wait context ]
[  187.278930] 7.1.0-rc1-gb8e991a47d4c-dirty #6 Not tainted
[  187.278932] -----------------------------
[  187.278933] CPU 0/KVM/4263 is trying to lock:
[  187.278935] 000000c7448982a0 
(&vcpu->arch.local_int.lock){+.+.}-{3:3}, at: 
__deliver_machine_check+0x44/0x1a0 [kvm]
[  187.278976] other info that might help us debug this:
[  187.278978] context-{5:5}
[  187.278979] 3 locks held by CPU 0/KVM/4263:
[  187.278981]  #0: 000000c7448980b8 (&vcpu->mutex){+.+.}-{4:4}, at: 
kvm_vcpu_ioctl+0xb8/0x9b0 [kvm]
[  187.279001]  #1: 000000c73a75b108 (&kvm->srcu){.+.+}-{0:0}, at: 
__vcpu_run+0x46/0x4f0 [kvm]
[  187.279024]  #2: 000000c73a758dd0 
(&kvm->arch.float_int.lock){+.+.}-{2:2}, at: 
__deliver_machine_check+0x3a/0x1a0 [kvm]
[  187.279046] stack backtrace:
[  187.279048] CPU: 10 UID: 107 PID: 4263 Comm: CPU 0/KVM Not tainted 
7.1.0-rc1-gb8e991a47d4c-dirty #6 PREEMPT
[  187.279050] Hardware name: IBM 9175 ME1 701 (LPAR)
[  187.279051] Call Trace:
[  187.279051]  [<000001cbdd2e7eea>] dump_stack_lvl+0xa2/0xe8
[  187.279054]  [<000001cbdd3ecd98>] __lock_acquire+0xe18/0x15c0
[  187.279057]  [<000001cbdd3ed62c>] lock_acquire.part.0+0xec/0x260
[  187.279059]  [<000001cbdd3ed84c>] lock_acquire+0xac/0x200
[  187.279061]  [<000001cbde401528>] _raw_spin_lock+0x58/0xb0
[  187.279063]  [<000001cb5dc5e734>] __deliver_machine_check+0x44/0x1a0 
[kvm]
[  187.279082]  [<000001cb5dc6057e>] 
kvm_s390_deliver_pending_interrupts+0x7e/0x990 [kvm]
[  187.279099]  [<000001cb5dc49934>] vcpu_pre_run+0x74/0x2d0 [kvm]
[  187.279117]  [<000001cb5dc558e8>] __vcpu_run+0xa8/0x4f0 [kvm]
[  187.279134]  [<000001cb5dc56400>] kvm_arch_vcpu_ioctl_run+0x140/0x320 
[kvm]
[  187.279152]  [<000001cb5dc35cc2>] kvm_vcpu_ioctl+0x142/0x9b0 [kvm]
[  187.279167]  [<000001cbdd7d0bda>] __s390x_sys_ioctl+0xea/0x120
[  187.279171]  [<000001cbde3ef868>] __do_syscall+0x168/0x750
[  187.279173]  [<000001cbde402d1a>] system_call+0x72/0x90
[  187.279175] INFO: lockdep is turned off.


> 
> Peter, I just added you to cc, so you can correct me if I'm entirely wrong.

