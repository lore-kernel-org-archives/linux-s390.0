Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAECE313E0D;
	Wed, 19 Aug 2026 12:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144056; cv=none; b=a1OPZtme0UPMQHTgMzUcrlRM0mShqD0Amo+jEA+gfaD0L1cZFSuW5v6938Zsz3e3yNkmH9k97UB5kdHhMRKYoVkqP6Da3dgWyABX0X/Ux344za57q1sE9XOkHRRMUPzZ0RDU77G9QloGTiTpHZLb3KEqeirvkkEjo1S2f9rQYsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144056; c=relaxed/simple;
	bh=qoh9CGoqJL9ddLhxEmYa5KQW5jXwOhBfEv/h11lC/nk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=afzZnDZ6fccO6v3Sm1CsUtXa0Ol7kawUvS33XSpIqYGA0xiy9y/r989W8X3vltjB+uDrpvf3vpxx7woLkJLy6Ou7D3mua+KFM2v9Ns5mlzgPp/yTIeDh+FmrsrK5lpF9OpUpYFANU7ydzOW/uWsXniLfFIlERVry5t4wuHErQGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b05RYFlT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b05RYFlT"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAVXu21323346;
	Wed, 19 Aug 2026 12:54:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=B33aBh
	T/x5rDeUfzoyZLvQRbhosrjkoNYtdwvyw0JAg=; b=b05RYFlTMtN1UaHJbSpxZ0
	w+dYKLH31UquTCqIVPPwy3VnLnPiaPOMfN/vtujN2NF3ZCGFloY2KxEAX+Oi80bJ
	SPXSfjtc3EHfuZujRBa1uPSSVfdeg/78/Vtk9QXFuaHhyVyjAqmdpI4PIpZMQ+Bp
	wkAgVwmTtGJZTAE1kIvajQxti3gyK75RkxgANC/QkZrxIVU1xMGJ15qugZn4IEgu
	BS29gOcDYN5tkGhN8zoJn9KB6FtijFeHydWy3GI/TsLoxfbB9GlwqGUtZ+fiIJrX
	F8xLy75jtbSHmu4H46+NXXgqvBsfj07X/C1bfdRbIaQ1zQUR/qjFxzB1rrJmXcWA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu03r5t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 12:54:13 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JCfMKt001940;
	Wed, 19 Aug 2026 12:54:12 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh8w74-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 12:54:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JCs8Xj49545706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 12:54:08 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E8282004B;
	Wed, 19 Aug 2026 12:54:08 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 406EF20043;
	Wed, 19 Aug 2026 12:54:08 +0000 (GMT)
Received: from [9.111.18.61] (unknown [9.111.18.61])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 12:54:08 +0000 (GMT)
Message-ID: <30016a7a-85e8-4a66-99e1-a1545f7fe323@linux.ibm.com>
Date: Wed, 19 Aug 2026 14:54:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
To: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: sashiko-reviews@lists.linux.dev, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Michael Mueller <mimu@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
 <20260817122849.9F8061F00A3A@smtp.kernel.org>
 <3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
 <20260818163226.68c6bea4.pasic@linux.ibm.com>
 <4f233ae1-2a30-4498-bd5d-2a001c96b2d8@linux.ibm.com>
 <20260818185850.0a522630.pasic@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260818185850.0a522630.pasic@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Y0Cg1T7baR8dZzo7yeixy3yVWly7UZbq
X-Proofpoint-GUID: Y0Cg1T7baR8dZzo7yeixy3yVWly7UZbq
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a85a775 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=LUfT0kCOqNB-ZUmkrjgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfX8Qch6xn+8lAv
 KJAaotuNFe0FKeihJfTD+FDIHPko42mLlbtIMNoXvJAKG/kDxJVDZmCbV46GYEOqnasu77HBpV8
 gH3NzVGU0vDrBotQ20TB+H+CB7OvHlU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfXyk8hqpFMO/50
 OOhq+K+u+CO/SJJEv9L0wIUrVX52nVzL3hCJdyejUovSxqy3Z3b1v/SbiC1BtxTgqyDp8CtliGw
 JcUb2fN0HsYuzGOTaqjedzg+O/pR8yQfGXSfevDwHiD4HzRnprY2vzFROSsrPQVh/xxy0JbYHJY
 GLXT0JeebZwdYi92Yalzth55BDcn+pw4kSZGLxpKfAhe1fxmpi8rXdrNoNYZZCFC17AQZdY3uLr
 zd33r2nFTaPOTmmqkbaXZ06I7goag+Lpxo5tTwW9gwGNkd+yUe7RYBBRQYIRBcFdimHjqCqQDGB
 UlcQbdPFMQlO9kUj9FR1GatExl5bhuF0itK52X0TEdMSHiZ7v6kJJjdpqjtL0ZcnyifiVdEa44W
 Quk3jzHjkaWVSRPRiCrZX5E2kFQUUqV9fNXq31Pig6c4wwNCqwJ4NPZfCXri9GmltGehX5DEWiL
 BYuAYtGPJe+4peuUQLw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190097

On 8/18/26 6:58 PM, Halil Pasic wrote:
> On Tue, 18 Aug 2026 17:14:52 +0200
> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
> 
>> Am 18.08.26 um 16:32 schrieb Halil Pasic:
>>> On Mon, 17 Aug 2026 15:22:41 +0200
>>> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>>>    
>>>>>> +	irq_pend_mask = inti_to_irq_pend_mask(inti);
>>>>>>     	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>>>>>>     		sigcpu %= online_vcpus;
>>>>>>     		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
>>>>>> -		if (!is_vcpu_stopped(dst_vcpu))
>>>>>> +		if (!is_vcpu_stopped(dst_vcpu) &&
>>>>>> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>>>>>>     			break;
>>>>>>     		/* avoid endless loops if all vcpus are stopped */
>>>>>>     		if (nr_tries++ >= online_vcpus)
>>>>>>     			return;
>>>>>
>>>>> [Severity: High]
>>>>> Does this code drop the interrupt kick entirely if all vCPUs currently
>>>>> have their interrupt masks closed?
>>>>
>>>> I think this is a corner case but still a valid finding. We can probably consider this
>>>> slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?
>>>
>>> With GISA, I think the FW is supposed to deliver the floating interrupts
>>> without dropping the vCPU out of SIE. I'm not 100% sure but I think we
>>> can rely on that mechanism for the CPUs that are in SIE. Without GISA,
>>> I think, it is reasonable to assume that vCPUs don't keep running for
>>> ever. It has been a while since I have looked at this code, but I think
>>> the SIE exit path would catch this. If that is true we would not really
>>> lose initiative, but just see delayed interrupt delivery.
>>>
>>> Sleeping vCPUs on the other hand are not of interest in this context, I
>>> think.
>> This is all corner case handling. Imagine one CPU running with IO disabled
>> and all other CPUs sleeping. If now the "opportunistic" wakeup fails the
>> GISA IO interrupt will never be delivered unless there is another wakeup.
>> In reality this is a will not happen, but see the latest kvm unit test
>> patch from Janosch and it might also create latencies, the "pick one CPU
>> to deliver and wake it up if normal processing does not work" obviously
>> has a hole in specific cases.
> 
> Right, but that is not the "if all vCPUs currently have their interrupt
> masks closed" case that Sashiko is talking about. Or did I misunderstand
> that?
> 
> Yes, I agree there are holes, and I was hoping to contribute to a better
> understanding on where the holes actually are and what are the
> implications of those holes.
> 
Yesterday I managed to find the actual problem behind this code for PV 
guests:

Non-ev Service IRQs are not allowed to be injected on re-entry when SCLP 
emulation has finished. They can only be injected when we receive the 
instruction notification for SCLP.

So having wakeups for service IRQs in the flic is useless. At the time 
they are injected (after SCLP processing and before SIE re-entry) 
there's no way to make one pending for a PV cpu.

I've since created a patch to kick cpus in the handling of the sclp 
instruction notification and that "fixes" the problems with the firq test.



For Linux we'll see delayed delivery at most since the masks are open 
most of the time. My guess is that the IRQ injection actually happens 
pretty fast. There are other OSs which might benefit though and we 
should generally ask ourselves if good enough for Linux is the right answer.

The stat counter did actually trigger a couple hundred times on an IPL 
so we're hitting the redistribution code path. Let's see what insights 
we can get from the performance measurements.
