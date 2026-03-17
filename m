Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87C13C9448;
	Tue, 17 Mar 2026 13:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773752825; cv=none; b=oinN3E0U6ghEnsBE07F/HfsQ6cv258aQqFLKDWZze9V6xbtCVqX6r1iZRereHrd1wc2zHo99GUSjJxutRb/Sz6+U3be/EIM+eQw/WsRX+eDD7z78ak/eoVTnlmzX85fufdIjKaEKpuzrzhshZGH2Pk+HuRhak/l89UhliM6l2fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773752825; c=relaxed/simple;
	bh=R2aaEOqjXu6UnnDb9n0r14GDAjKMWwrMEUepa0SjQyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=IM30byFFAOhoxefYoyo7Cw4Y2o8mw0+L50UTAm+9yHe34u7ujQoRrKL2o98B23Iir9qxD5gyVjatK/RNGLNvMi/93unr8Q+0kPUpXA7gzMlu+Tvd2wzoSgeYnduKNKg3jYUIA22MB1IP9u04wWuORa7RDUkKXuxaSyeuLIWhHes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DZpm2vSK; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DZpm2vSK"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H5uXl0617441;
	Tue, 17 Mar 2026 13:07:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=fdz/Fv
	+GJkHN5htsWUt/QQpfEutaCj7f/1SqkH4eSpg=; b=DZpm2vSKgC7K2F45xSq2yM
	jBZ6jra/7/IrQ866br/7hKh7T4qHVMPyxAXw6g4Gvj8TnMZGlh9e/QSAWJlHD6eP
	zGK6tKbigjZvYE6zjnp/pdLwweorDfUPIRyS1TcmzaDRFvpWaxY+1+sLCQ1jkilE
	xWX14I39F/LwCnravwvRXjo+GMUAQCOn1CtcAmAL3v6PMtHUNPhc0gslOFHr+EZc
	Z81urk9t1wxp7JiywA8uWcYSd2kQ3ex1g1DSI14OVaNPXjO3J9MdJxqSNdchaoXG
	3HjFMz/6yyveOE42YjTa+xtll89xrKIZCpmPYpVxDuvBp47Uu4x5S+RbOAALmwXg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs4tt0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:07:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HC6N5A028459;
	Tue, 17 Mar 2026 13:07:00 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq191r7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 13:07:00 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HD6waF33751754
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 13:06:58 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C1955805C;
	Tue, 17 Mar 2026 13:06:58 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64F825805B;
	Tue, 17 Mar 2026 13:06:57 +0000 (GMT)
Received: from [9.61.247.193] (unknown [9.61.247.193])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 13:06:57 +0000 (GMT)
Message-ID: <b3253698-a17d-4ebc-ad43-ef4ef5490e47@linux.ibm.com>
Date: Tue, 17 Mar 2026 09:06:56 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Introducing kvm_arch_set_irq_inatomic fast inject
To: Matthew Rosato <mjrosato@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-4-freimuth@linux.ibm.com>
 <e0f9d530-c691-4d1f-ab82-33b5456fca9f@linux.ibm.com>
 <2116b7d0-0cbf-4337-823d-986d0521982b@linux.ibm.com>
 <c32d602b-e1c9-4e95-958f-243dea236a3c@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <c32d602b-e1c9-4e95-958f-243dea236a3c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b951f5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=ZhnCa72NlnlG362mXRoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Ve6GyIijTOCi8WdRerUcI0O2aTOreN-z
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDExMiBTYWx0ZWRfX0UgiuvX7qI2C
 vPV7+ScHbexHYEiKTqkTqniNo1gIKu3pa3G9UOfqdYcWSsg6HFMaaqI9Y1b+DV1cNUI8dLd2+Mx
 TL391PLhg3G6Z75cJiB2/WiM4/dfzVMHX9cSR/iZR2Sx0rjwQqNAHexKgaoeLajYubpHmrX88R9
 R1u+ltsSLbJhmgr1TWW6VGPrR3whx+F7/El3byt6bbwPQomDOBLFfM9O3uSo1f+dgCYMVoYZeHA
 HnsHU2t2JcHgpY+dRNI+0nuJtCIYQiEUhW7k31xEbECXWmgVIzklzthF3UpovvIa5RbMwGBf1r2
 pmja+rl4Xe68i2NSy9xR48L23ZJtqRnmS8SSFLj1F3HXDjG9crEZChCptiw4cDn6MDAENQ6vWgT
 zxwpJVTap0rMX7K7u3aGLb2xZy/K2qo8ZUICtdPDh0YNsudev0sZ1N3rBdjYOJgzLgpYWASnKcX
 H/mn4GmFLNAQaHhLUaw==
X-Proofpoint-GUID: Ve6GyIijTOCi8WdRerUcI0O2aTOreN-z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_01,2026-03-17_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170112



On 3/16/26 11:41 AM, Matthew Rosato wrote:
> On 3/13/26 10:01 AM, Douglas Freimuth wrote:
> 
>>>> @@ -450,6 +450,10 @@ struct kvm_vm_stat {
>>>>        u64 inject_io;
>>>>        u64 io_390_adapter_map;
>>>>        u64 io_390_adapter_unmap;
>>>> +    u64 io_390_inatomic;
>>>> +    u64 io_flic_inject_airq;
>>>> +    u64 io_set_adapter_int;
>>>> +    u64 io_390_inatomic_adapter_masked;
>>>>        u64 inject_float_mchk;
>>>>        u64 inject_pfault_done;
>>>>        u64 inject_service_signal;
>>>> @@ -481,7 +485,7 @@ struct s390_io_adapter {
>>>>        bool masked;
>>>>        bool swap;
>>>>        bool suppressible;
>>>> -    struct rw_semaphore maps_lock;
>>>> +    spinlock_t maps_lock;
>>>
>>> Patch 1 (re-)introduced the maps_lock, now you are converting it to a spinlock 2 patches later.
>>>
>>> I realize that you were bringing back code that was previously removed by
>>>
>>> f65470661f36 KVM: s390/interrupt: do not pin adapter interrupt pages
>>>
>>> but for this series wouldn't it make sense to just start by introducing maps_lock as a spinlock from patch 1 vs re-introducing the semaphore for the span of 2 commits?
>>>
>>
>> Matt, thank you for your input. The policy of individual patches not only compiling but having individual utility and standing on their own applies here. In patches 1 and 2 the maps_lock is more flexible as a semaphore providing utility for the patch. While in patch 3 the maps_lock has to be a spin_lock so inatomic can use it with interrupts disabled.
> 
> I would agree completely if these were 2 separate series, with some period of time in between when the semaphore is implemented and a subsequent switch to a spinlock.
> 
> But here you are introducing a semaphore and immediately replacing it with a spinlock _all within a single series_, such that the semaphore implementation will never be used in practice.
> 
> In the end, that just creates a bunch of extra insertions and subsequent deletions of those insertions all within this series.
> 
> Yes, the semaphore would be the preferred implementation if allowed to sleep but since the goal of the series is it implement kvm_arch_set_irq_inatomic then you can just indicate in patch 1 why you are already switching to a spinlock when you re-introduce these ioctl functions (e.g. in preparation for kvm_arch_set_irq_inatomic support which requires a thread of execution that will not sleep).
> 

I will make the change and note the reasoning in Patch 1.

>>>> +
>>>> +    /* We're only interested in the 0->1 transition. */
>>>> +    if (!level)
>>>> +        return -EWOULDBLOCK;
>>>> +    if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
>>>> +        return -EWOULDBLOCK;
>>>> +
>>>> +    adapter = get_io_adapter(kvm, e->adapter.adapter_id);
>>>> +    if (!adapter)
>>>> +        return -EWOULDBLOCK;
>>>> +
>>>> +    s390int.parm64 = isc_to_int_word(adapter->isc);
>>>> +    ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter);
>>>> +    if (ret < 0)
>>>> +        return -EWOULDBLOCK;
>>>
>>> We know for sure that a guest that is running in SE will always hit this because no mappings will be available.
>>> Did you test if it would be more efficient to check the kvm for SE at the start of kvm_arch_set_irq_inatomic() and immediately return -EWOULDBLOCK there?
>>>
>>
>> It might be slightly more efficient in SE environments to immediately return -EWOULDBLOCK at the start of kvm_arch_set_irq_inatomic. But the change would be fairly broad since it would require changing the mutex for kvm->lock to a spin_lock to allow checking if pv is present with interrupts disabled. I would recommend this for a follow-on if behavior in the field requires it.
> 
> Right, I forgot about the mutex.
> 
> OK, then I agree let's leave this for follow-on after this series lands.
> 
> I suspect that you could get away with peeking the value without the mutex held as a heuristic.  If we get it wrong it would be during a transition into/out of SE and either...
> 
> 1) we -EWOULDBLOCK and fallback to irqfd_inject when we could have continued down the inatomic path -- irqfd_inject should always work.
> 
> or
> 
> 2) we would proceed into the inatomic path and then get kicked out as we do with this current implementation: when we attempt to find the pre-pinned mapping (which is protected by a spinlock).
> 
> The questions to answer would be whether it's permissible to peek the value and whether it buys us enough to be worth it.
> 
> 

