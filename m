Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B754230594E;
	Mon, 16 Mar 2026 15:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773675713; cv=none; b=V0NTNKSz8dZTGpfgBwSX1xusNQ7JqwcvcO0WpFf+hJMc78EI38GZwqNzf7PmlbuHt8H6wTk7WR3smWPbAMpYrY71t54/d0E74uYIbpc4W1k5tQwou2nkgHJVNwuVVpfDyIV8vMOPt3/+t4TFXioQVcY4o83DAz6r/SMz67JO0mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773675713; c=relaxed/simple;
	bh=3nksQSMM8K/IdNN24XkSyMWYvHzMfjnm/A4Rsq9cweE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SaAulVTThRmoYZw/mA4WbryaqfFu/ukuMMh682oYz2TDsEYY7nnZHXTlQy4P/4fL5WzvxCcquzTD+d+kPgjFkiGbGEVogp1qmtATiU+/SdKtGHtXC7/RxRm7L/v7nsvY1SvJSBBePrz4WH8NKnXrSvNyknaKoRY44RwqcGlR1f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UBfx6G52; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UBfx6G52"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G14pU61189728;
	Mon, 16 Mar 2026 15:41:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qlSPyh
	iNeci9JwRa8X16ZPwEmj9uPiM6PQhRbrWjnKw=; b=UBfx6G52SJYqh9qGxrsgII
	Sj+Y1obCVNlATmwN4t+XN4vbmKOQcGMVJcAWSxwVVHXXUJePPvqj7kt25r+uSJii
	64/WIvMV5Z6uxKMyIqrFlY0CdIP4uPaipS1y4S1FrbDtTIV+p8V0HbMbi2F4w4zP
	HR8XnOJswmwNNy9fBcc5+Ct5GhMFq6BqDfCkLoHoUmly0CoqHe2qpZ+Y5WNa27kI
	Ss77DOil9bYQ31vMY31+dhdJzXO/leGzzwhrxUd4ZtqwoVNxV07Yj9L9Bebt+Gqa
	T1uJ4LGffzILk6oOVkrXBktuzhULHW1zaZOZt/lyF9XTLoLpt050/jgBYXuK+k6A
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfav77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:41:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GFCRGA028765;
	Mon, 16 Mar 2026 15:41:48 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwkgk5ap9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 15:41:48 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GFflJE29623006
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 15:41:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A6958056;
	Mon, 16 Mar 2026 15:41:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20E958052;
	Mon, 16 Mar 2026 15:41:46 +0000 (GMT)
Received: from [9.61.145.197] (unknown [9.61.145.197])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 15:41:46 +0000 (GMT)
Message-ID: <c32d602b-e1c9-4e95-958f-243dea236a3c@linux.ibm.com>
Date: Mon, 16 Mar 2026 11:41:46 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/3] Introducing kvm_arch_set_irq_inatomic fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260308030438.88580-1-freimuth@linux.ibm.com>
 <20260308030438.88580-4-freimuth@linux.ibm.com>
 <e0f9d530-c691-4d1f-ab82-33b5456fca9f@linux.ibm.com>
 <2116b7d0-0cbf-4337-823d-986d0521982b@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <2116b7d0-0cbf-4337-823d-986d0521982b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gD-w9fTyGu7vzMSL-IHtokGJ05KXRIT0
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b824be cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=LoBUVOB9bWH3AYvLrq8A:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDExNCBTYWx0ZWRfX8xlA/21ztg4p
 9y9XrNG6MKdwicvBXfqnme765D5+wuKzZZ4Bn8EGHh/t5VhWxuo8XAl3aVReEnEPdQm7CcCpLAO
 hhuJ3O8tqS/28JJzSXVZQ6+HIpS3KSU6MnoD1DYjWfTiQeSA2bvEiyDdZQ8Vb6mr25stGK4IFHH
 o82jnLswOdM8cl53v5qQC8xVMVzgdlXxT5Z+1WSpAHcCtEv50WqhHGvv2RogKkc5ejKk3voSOmX
 kG6JkJuVZL56Xt+riTsdXi7yC0gsLV9WIoLvi5g/OYnr+UBp28hJDgXo+COOq8bhmkLrMhCi4kk
 Cek3VMDv9WZKW7XH6WgdhfwSyIO4rIYTXDnRNFZ627d8QqkvK1PzfPqSr4n1TwDKrXxyQ71+DLq
 uLpILKZ+pClJNRcTepkx91ghWucNXJauSaVO3x/YTgWtk+rw4l0in5FricaPM0Mc8co5zi7PdR6
 xdiTU5jzh6E4HcqYBig==
X-Proofpoint-GUID: gD-w9fTyGu7vzMSL-IHtokGJ05KXRIT0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160114

On 3/13/26 10:01 AM, Douglas Freimuth wrote:

>>> @@ -450,6 +450,10 @@ struct kvm_vm_stat {
>>>       u64 inject_io;
>>>       u64 io_390_adapter_map;
>>>       u64 io_390_adapter_unmap;
>>> +    u64 io_390_inatomic;
>>> +    u64 io_flic_inject_airq;
>>> +    u64 io_set_adapter_int;
>>> +    u64 io_390_inatomic_adapter_masked;
>>>       u64 inject_float_mchk;
>>>       u64 inject_pfault_done;
>>>       u64 inject_service_signal;
>>> @@ -481,7 +485,7 @@ struct s390_io_adapter {
>>>       bool masked;
>>>       bool swap;
>>>       bool suppressible;
>>> -    struct rw_semaphore maps_lock;
>>> +    spinlock_t maps_lock;
>>
>> Patch 1 (re-)introduced the maps_lock, now you are converting it to a spinlock 2 patches later.
>>
>> I realize that you were bringing back code that was previously removed by
>>
>> f65470661f36 KVM: s390/interrupt: do not pin adapter interrupt pages
>>
>> but for this series wouldn't it make sense to just start by introducing maps_lock as a spinlock from patch 1 vs re-introducing the semaphore for the span of 2 commits?
>>
> 
> Matt, thank you for your input. The policy of individual patches not only compiling but having individual utility and standing on their own applies here. In patches 1 and 2 the maps_lock is more flexible as a semaphore providing utility for the patch. While in patch 3 the maps_lock has to be a spin_lock so inatomic can use it with interrupts disabled.

I would agree completely if these were 2 separate series, with some period of time in between when the semaphore is implemented and a subsequent switch to a spinlock. 

But here you are introducing a semaphore and immediately replacing it with a spinlock _all within a single series_, such that the semaphore implementation will never be used in practice.  

In the end, that just creates a bunch of extra insertions and subsequent deletions of those insertions all within this series.

Yes, the semaphore would be the preferred implementation if allowed to sleep but since the goal of the series is it implement kvm_arch_set_irq_inatomic then you can just indicate in patch 1 why you are already switching to a spinlock when you re-introduce these ioctl functions (e.g. in preparation for kvm_arch_set_irq_inatomic support which requires a thread of execution that will not sleep). 

>>> +
>>> +    /* We're only interested in the 0->1 transition. */
>>> +    if (!level)
>>> +        return -EWOULDBLOCK;
>>> +    if (e->type != KVM_IRQ_ROUTING_S390_ADAPTER)
>>> +        return -EWOULDBLOCK;
>>> +
>>> +    adapter = get_io_adapter(kvm, e->adapter.adapter_id);
>>> +    if (!adapter)
>>> +        return -EWOULDBLOCK;
>>> +
>>> +    s390int.parm64 = isc_to_int_word(adapter->isc);
>>> +    ret = adapter_indicators_set_fast(kvm, adapter, &e->adapter);
>>> +    if (ret < 0)
>>> +        return -EWOULDBLOCK;
>>
>> We know for sure that a guest that is running in SE will always hit this because no mappings will be available.
>> Did you test if it would be more efficient to check the kvm for SE at the start of kvm_arch_set_irq_inatomic() and immediately return -EWOULDBLOCK there?
>>
> 
> It might be slightly more efficient in SE environments to immediately return -EWOULDBLOCK at the start of kvm_arch_set_irq_inatomic. But the change would be fairly broad since it would require changing the mutex for kvm->lock to a spin_lock to allow checking if pv is present with interrupts disabled. I would recommend this for a follow-on if behavior in the field requires it.

Right, I forgot about the mutex.

OK, then I agree let's leave this for follow-on after this series lands.

I suspect that you could get away with peeking the value without the mutex held as a heuristic.  If we get it wrong it would be during a transition into/out of SE and either...

1) we -EWOULDBLOCK and fallback to irqfd_inject when we could have continued down the inatomic path -- irqfd_inject should always work.

or

2) we would proceed into the inatomic path and then get kicked out as we do with this current implementation: when we attempt to find the pre-pinned mapping (which is protected by a spinlock).

The questions to answer would be whether it's permissible to peek the value and whether it buys us enough to be worth it.


