Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 201AA3C73D1;
	Thu, 20 Aug 2026 07:25:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787210706; cv=none; b=bhUM69Bwfhl7kf028ZCE++e27JvmGlIf3FrO9sCaq34eP+vvbHwMpbSnrxcTiZaT1WLlI4Ee4SIDvgLvyRpjHPZra1VHmL2vmn9aug54A8jqvK8AqIy0a5ZzMixrG+59VDfDNxC0ZnMFT42bcdmQB1ckSa5QwDg3VeCDuRt8qBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787210706; c=relaxed/simple;
	bh=oFcVbW/OfMqBa3HKyrnMsvBL+MCFF7cbkBsPBg5nFMM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KZkQ2JiC+NWoXPiZaklDNF3dxUU+soLE3goV/og3jQYQz65CbKi37yvYxQFQ52H7y/ooRX0m8/g1NDimAgGoOuyc04gLLV9EqrmtPgIt4jAsvHXirPZdaUu9pQIGYwolWyNwTgjh0MU+0G1EG7Lkq+cfArwmxWu07tTOTjMMNq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLgS6h2O; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLgS6h2O"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67JLVUv6471173;
	Thu, 20 Aug 2026 07:25:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=GF9mNr
	3R5GlrQ3p5GBsbXkUO0RVeZCFUDIS2x3CTLQQ=; b=fLgS6h2O8li3y5VDWBXDXJ
	f3CvH5SgmKk/+HcBaVx8T+dFnAgTR4sNTvf86QDNRbsy+wNoL8Grz7ShdimtotDe
	ydWWSM4L54ALns8LfgbUzaZyy8nDwrljd3jeZQCeoUy1xpk4y41WjE9i5udM9kKd
	KzHW6FdfET3krM9wvpVlIxfL0z6t0zLquzro++U/xsrAT0AjeLLpvpQ9AV5kMSTD
	6t2IieHR4SIg3B/ApEj9yZyat6eFz1BMPpH//qcXrk7xT774rf+9KmpzMbM0d7Xk
	NRBNh5VV9y8Vk80Rh2okLBthWfvFlTbzJVn/aLiSh+Fn2ZtICHjX+ZrWlkoukNUg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0gqwj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:25:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67K7BG9K021023;
	Thu, 20 Aug 2026 07:25:03 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqdawe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 07:25:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67K7OxFb9765126
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 07:24:59 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 818F320043;
	Thu, 20 Aug 2026 07:24:59 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 46FDD20040;
	Thu, 20 Aug 2026 07:24:59 +0000 (GMT)
Received: from [9.87.135.213] (unknown [9.87.135.213])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 07:24:59 +0000 (GMT)
Message-ID: <43f7856a-dd03-407e-b8d8-a5534a9f10ca@linux.ibm.com>
Date: Thu, 20 Aug 2026 09:24:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection behavior
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260819190408.247843-1-frankja@linux.ibm.com>
 <20260819190408.247843-2-frankja@linux.ibm.com>
 <20260819191317.2C7961F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260819191317.2C7961F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a86abd0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=xrtE07GcD8d4jnkWsSQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HLgb8-yv2yQxduJGd74Ce5fqTyoivbL7
X-Proofpoint-GUID: HLgb8-yv2yQxduJGd74Ce5fqTyoivbL7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX3u2MdKsolsBe
 bje6O/uvOhtUgcAMbLxAABLt9QZujzRD9ayj+7/OpxPZlDgOJC1CVcP8zuuRKx16Be+wV0p8K0B
 rbvwS66wk9DGbM7M3vJ2H8gFXCoZly0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA0OSBTYWx0ZWRfX+5Dsvgna6CgF
 gCUZHyq+EcTi8E9WYh/UrsLbX0NlU3ubA7f4TUE3YgBTbpXFCoB6GhFckItGRJLI8Z/cSQ/H03Q
 zD3eAUP3CWbYH0KEl7Cr3rJQclOLfbVJkDMG14xUzFkpStev18kMX2grPUDGiAvrY77yn4dSlrk
 SOrFCEBrg0T6Wek+JED4mpf6SgZqyjMWq8iTFCXizxDsjtF7Tf8BkUSTm346PvGNii3USVRPn5F
 X14Fa45sUnv+rBkRWYvAetEP8dPs+OUUOeI1q96JgH6hbOyZ8U4KfjNTslxmqAgqqFuArdIErb+
 sO8ERgNAg6hbpOJNSL2DcN98DtizbfNezWzmCJ//z3r4iUMA9IQOygY23WAGQuEOYS0rakNRpM7
 U/XlZZDCUweHotFo5uKxkGI3FYZToV6ebIAWRGcawQH3OVm/wUst8TW6vEmB4P1ZDr/pa7t184x
 aZklDYzZvhaRjhGtA2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200049

On 8/19/26 9:13 PM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> - [High] Incorrect bitmask computation for floating I/O interrupts causes thundering herd performance regressions or lost wakeups.
> --
> 
> --- Patch [1]: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection behavior ---
> commit 8a0b82ce7a926dc2db73a2448ac2bcc105213707
> Author: Janosch Frank <frankja@linux.ibm.com>
> 
> KVM: s390: Improve floating IRQ injection behavior
> 
> This commit improves floating IRQ injection by checking if a VCPU has pending
> IRQs instead of blindly waking up the last VCPU that went to sleep. This aims
> to prevent deadlocks when a VCPU is sleeping without an open mask.
> 
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 8f24bcd1a6d36..3af060ec5be8e 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
> [ ... ]
>> @@ -1915,49 +1915,93 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>   	return 0;
>>   }
>>   
>> +static u64 inti_to_irq_pend_mask(u64 type, int isc)
>> +{
>> +	switch (type) {
>> +	case KVM_S390_MCHK:
>> +		/* Only repressible machine checks are floating */
>> +		return BIT(IRQ_PEND_MCHK_REP);
>> +	case KVM_S390_INT_VIRTIO:
>> +		return BIT(IRQ_PEND_VIRTIO);
>> +	case KVM_S390_INT_SERVICE:
>> +		return BIT(IRQ_PEND_EXT_SERVICE) |
>> +		       BIT(IRQ_PEND_EXT_SERVICE_EV);
>> +	case KVM_S390_INT_PFAULT_DONE:
>> +		return BIT(IRQ_PEND_PFAULT_DONE);
>> +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
>> +		return isc_to_irq_type(isc);
> 
> [Severity: High]
> Does this correctly return a bitmask? The other cases return BIT() masks, but
> this returns a raw integer resulting from isc_to_irq_type().
> >
> [ ... ]
>> @@ -1974,6 +2018,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>   		rc = __inject_pfault_done(kvm, inti);
>>   		break;
>>   	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
>> +		/* Grab isc here since __inject_io() might free inti */
>> +		isc = isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
> 
> [Severity: High]
> Are we applying isc_to_irq_type() twice for I/O interrupts?
> 
> This converts the ISC to an IRQ bit index before assigning it to `isc`. Later,
> __floating_irq_kick() passes it to inti_to_irq_pend_mask(), which calls
> isc_to_irq_type() a second time on the same value.
> 
> Since isc_to_irq_type() is implemented as `IRQ_PEND_IO_ISC_0 - isc`, calling it
> twice will reverse the calculation and yield the original ISC value instead
> of the expected IRQ bit index.
Rebase damage, will fix both.
