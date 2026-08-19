Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E9F2DC76A;
	Wed, 19 Aug 2026 12:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787144252; cv=none; b=JAFSLEHiYkpD5yY6D8xGrIgJ39tpM6IivsIwNYfAkVmdzlHtkMB1lGbQBXbmijtYz2S0gY5/SC8/WJ7lRoovTBXlRRGNdBBK+Md5fldh3bDXNWtz91uw2sI8K0bHc6iXZcGzA3TCaXfXrvAzA6fi1Tc5BA842YLj4bWaPWJCCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787144252; c=relaxed/simple;
	bh=WV6/+lhv6TRuTHevXktPrcrgEWzJmvnj1i/h3kNJHdM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UkmRFgzxyrDX6ODVciAmpLfyktztnS0Dspk/eV1sCgqkWiHdk4K4f3IsjrSiY83YQqseSwC+VmM/LtGgfYXASIuxZd9kr6eRjmFzdLIQqGEOCy1RinWqq2qs3spZIOxFV3v5vMtZBdU429y9+6xwV3p2R1ckenXDXW26Ld+TthM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mCKOKwZI; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mCKOKwZI"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JAWAQD3192395;
	Wed, 19 Aug 2026 12:57:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=KgeNqT
	tkTHBZEiOBX/odEZ/5qIL4OWHZZ6aJJTHY28k=; b=mCKOKwZI1JpWsqv9mylaKa
	ft+UUFGpWdXjyUss5yzIzi4kDaHaXtAiX2mAHfXTGZ1BaoAoTO7AAy/VGTo7mFap
	VFR/iOxI3h0HBEqrC2wq+5ph4Ucz+zcHJOWtLBYrtyYmALWRNQPFHvyYVd0BmkeB
	SrCqTYFMFk8yEF8vRe20W+B0QmxvwCED8GSb4tbu4sRzK5r5F1ZP21RH/jB+eNZz
	TZbuHpM4q3yT+kVn2lCmwLEiCoNWY03G/3WnhKv44J85vO2dC2GUGqicuta550D6
	m4+OpxE2PKCTgPLE3Yg6MLf8M1n9DX0UQ11oqBlWhb+1bqncvMyMwZpF0G6zkLxg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0brv7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 12:57:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67JCufA7024009;
	Wed, 19 Aug 2026 12:57:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw92f2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Aug 2026 12:57:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67JCvOpr44433822
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Aug 2026 12:57:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 87DF620043;
	Wed, 19 Aug 2026 12:57:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2915020040;
	Wed, 19 Aug 2026 12:57:24 +0000 (GMT)
Received: from [9.111.16.238] (unknown [9.111.16.238])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 19 Aug 2026 12:57:24 +0000 (GMT)
Message-ID: <f4f4f72d-981c-43b8-a72a-e5ce26734277@linux.ibm.com>
Date: Wed, 19 Aug 2026 14:57:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
To: Janosch Frank <frankja@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>
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
 <30016a7a-85e8-4a66-99e1-a1545f7fe323@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <30016a7a-85e8-4a66-99e1-a1545f7fe323@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a85a839 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xfipzss6hLhKbsZSbpMA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: WewK6kkK3O1uMf-TFT8is359xBy2cERe
X-Proofpoint-GUID: WewK6kkK3O1uMf-TFT8is359xBy2cERe
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfX+VJndvnaLnYx
 UM6FSmq2OTonGU5YsYp8xVrJlj3yWe+tKLBfxDR8nhTTNdXVSxOeAOyYZAcDpxMTzNYIALGcYHs
 FXUpYvoJk65K4jwb/RQhJuzjab1w7y8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE5MDA5NyBTYWx0ZWRfX29MDhw1ueBax
 G9QGJRmEx2TU8zbfgdMmSQH70PweBIqj594KhzwqXRoJtb0+aMkpyBfScM5OvcshLiueAh3QxT6
 Wf2hrfSo8GDzwWfb7Ssm+3zuT8NzfT3615gCVynF3o17nrd7HKKlyQPcJJU/0xutFpvZr/HLUHz
 zP5AFDPsazNNzsThFW+Zg8VU8qxX40T/pVeArn5KMwSfANeDG6GAbTnl9S+efB5O7FQ5M41WrvW
 xUy2Ak8UeaeUbWkg+z9JomqYW1zm8XtzwxiucSe45ShOCMIQP/pgXQeOj6FcMd0h8h5Buoj2cf9
 1lRaIiiLkzSK9k+rmIqXHJ192El2BSBpMIV3oG02lopClV2xjyRK4S2JoQ/OoVloll+BTMPXCXx
 gBJjiEmEwxDzNLHyeOdgegeCv32xxJFCIa37jS5s1VBm5lUqNVGAia64ZTVt7A/D1Mlo81JVyHz
 0Bgx7PDW0Z12ffHKEsw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_03,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608190097



Am 19.08.26 um 14:54 schrieb Janosch Frank:
> On 8/18/26 6:58 PM, Halil Pasic wrote:
>> On Tue, 18 Aug 2026 17:14:52 +0200
>> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>>
>>> Am 18.08.26 um 16:32 schrieb Halil Pasic:
>>>> On Mon, 17 Aug 2026 15:22:41 +0200
>>>> Christian Borntraeger <borntraeger@linux.ibm.com> wrote:
>>>>>>> +    irq_pend_mask = inti_to_irq_pend_mask(inti);
>>>>>>>         for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>>>>>>>             sigcpu %= online_vcpus;
>>>>>>>             dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
>>>>>>> -        if (!is_vcpu_stopped(dst_vcpu))
>>>>>>> +        if (!is_vcpu_stopped(dst_vcpu) &&
>>>>>>> +            deliverable_irqs(dst_vcpu) & irq_pend_mask)
>>>>>>>                 break;
>>>>>>>             /* avoid endless loops if all vcpus are stopped */
>>>>>>>             if (nr_tries++ >= online_vcpus)
>>>>>>>                 return;
>>>>>>
>>>>>> [Severity: High]
>>>>>> Does this code drop the interrupt kick entirely if all vCPUs currently
>>>>>> have their interrupt masks closed?
>>>>>
>>>>> I think this is a corner case but still a valid finding. We can probably consider this
>>>>> slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?
>>>>
>>>> With GISA, I think the FW is supposed to deliver the floating interrupts
>>>> without dropping the vCPU out of SIE. I'm not 100% sure but I think we
>>>> can rely on that mechanism for the CPUs that are in SIE. Without GISA,
>>>> I think, it is reasonable to assume that vCPUs don't keep running for
>>>> ever. It has been a while since I have looked at this code, but I think
>>>> the SIE exit path would catch this. If that is true we would not really
>>>> lose initiative, but just see delayed interrupt delivery.
>>>>
>>>> Sleeping vCPUs on the other hand are not of interest in this context, I
>>>> think.
>>> This is all corner case handling. Imagine one CPU running with IO disabled
>>> and all other CPUs sleeping. If now the "opportunistic" wakeup fails the
>>> GISA IO interrupt will never be delivered unless there is another wakeup.
>>> In reality this is a will not happen, but see the latest kvm unit test
>>> patch from Janosch and it might also create latencies, the "pick one CPU
>>> to deliver and wake it up if normal processing does not work" obviously
>>> has a hole in specific cases.
>>
>> Right, but that is not the "if all vCPUs currently have their interrupt
>> masks closed" case that Sashiko is talking about. Or did I misunderstand
>> that?
>>
>> Yes, I agree there are holes, and I was hoping to contribute to a better
>> understanding on where the holes actually are and what are the
>> implications of those holes.
>>
> Yesterday I managed to find the actual problem behind this code for PV guests:

Thanks for digging through that.> 
> Non-ev Service IRQs are not allowed to be injected on re-entry when SCLP emulation has finished. They can only be injected when we receive the instruction notification for SCLP.
> 
> So having wakeups for service IRQs in the flic is useless. At the time they are injected (after SCLP processing and before SIE re-entry) there's no way to make one pending for a PV cpu.
> 
> I've since created a patch to kick cpus in the handling of the sclp instruction notification and that "fixes" the problems with the firq test.
> 
> 
> 
> For Linux we'll see delayed delivery at most since the masks are open most of the time. My guess is that the IRQ injection actually happens pretty fast. There are other OSs which might benefit though and we should generally ask ourselves if good enough for Linux is the right answer.
> 
> The stat counter did actually trigger a couple hundred times on an IPL so we're hitting the redistribution code path. Let's see what insights we can get from the performance measurements.

there are also ideas about disabling IO interrupts on some CPUs (e.g. vertical low)
and other OSes like zOS have the concept of CPUs excplictely disabled for IO
interrupts. So we better have a least a KVM implementation that works in those
situations.

