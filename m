Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CA0D427FB9;
	Mon, 17 Aug 2026 13:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786972972; cv=none; b=PwwJgrrjUYncquWJ9ikU+Uj20OK0yt65P07PUJDhCz/X4tncId56Nx/3q+VPDjkHdDa+K/ilYR/jHn/oKWF/udsktXw4kJg/2JGmpXOfTtZZ9v9kvorFk06hpSk1yx0SO419uG7dBXIZ2ZSpkPgcwwHESVuiiaSIHcBkHo4sn0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786972972; c=relaxed/simple;
	bh=NwkIJyp62K5Sry63b6U1TrRBI/rESheSoYCNV0kHCNs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hSVUxhZEod7ZI6eiKkLJ6lYi6LUq8gr0+UEE9TxCRlMEMcpDbiVYjXfDGSLovAg8g7CrsqKLs1lnRIeAuy9PaHwh+EpXRPSVtZwbWec7b1n6/toyreffGzOCy6lKaIi/vFw4EjDEszVIYAvpFJ5KsNhgbz/iEESrDA4/sQZboxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rdrIciDb; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rdrIciDb"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67HCVk1X1348197;
	Mon, 17 Aug 2026 13:22:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=iJCB4a
	P3cM0QdWlCYmglTLIaMbI9mMvSPOREAYvsEcQ=; b=rdrIciDbrUxmC916enMTdc
	CZi+kVmRIk/huWvVZR7hWM1wcgwKcrGgTJ3GWgQAikIxyKTRdMUO0r1O3g5MFb9G
	T6+tL86WncvtVxP9vcYJQ45cfz+ZYtEZBjcejgHY93rMnEYJfWY8BcNctXXlx3ZJ
	Rav0ZYka3j9ecTYnj/W9rx3alt6y7V6XjuJePFLYJ0seOLuXNvoFXU34BOAzRfJA
	n4rfRwhW8paq+bJnA6w7YJT8VI4rxc1Td++jKJFi0KfjNT2fvSdErYxLb2CCm1DE
	5lzLX9tMQ/zZ3lGXDtXNAsj3YyyIH9kftW8vjkY0aDRGT3f1fyAaRlsSMupA0O+g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3jf1v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 13:22:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HDBJCB030993;
	Mon, 17 Aug 2026 13:22:46 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng5y8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 13:22:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67HDMg9642009074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 13:22:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A50F2004B;
	Mon, 17 Aug 2026 13:22:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E80A220040;
	Mon, 17 Aug 2026 13:22:41 +0000 (GMT)
Received: from [9.111.33.235] (unknown [9.111.33.235])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 13:22:41 +0000 (GMT)
Message-ID: <3562788b-150c-4387-a840-60d9e6b6e49d@linux.ibm.com>
Date: Mon, 17 Aug 2026 15:22:41 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior
To: sashiko-reviews@lists.linux.dev, Janosch Frank <frankja@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>
References: <20260817121631.159451-1-frankja@linux.ibm.com>
 <20260817122849.9F8061F00A3A@smtp.kernel.org>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260817122849.9F8061F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ahNw6tuOEfvyQD1zBFTl6SWsOi71RLrN
X-Proofpoint-ORIG-GUID: ahNw6tuOEfvyQD1zBFTl6SWsOi71RLrN
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA5OSBTYWx0ZWRfX4NkxVBWRQqYE
 gPn+Ng4RK1D/MT/wI7QQ8Cjdww3Yxp3viw+W0AMZjwQG6RowdfR3xrTVqxXduuRRsNfA2vMO0D5
 xZKaBoTjCCGjTDOAHRBnoV41QGIdHkQ=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a830b26 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=iJzyzStbehPcAwzxuyoA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA5OSBTYWx0ZWRfX2wML+iM9sy38
 KU2mfUf+DPBjuvB78DEKIeGCLvxdDCGNbAr1MpY8G9XQYSJ8zG/mqeWFxpNsxZqejEb1chZTRZY
 +CiUH3GZw1u0TxyymE01Ksug+Igk2dlAd3SD1bSI2jGrecqCKs/6dfpRhuvBGYMNrFQvIsfetEc
 IDLkB3miETPqci70S6tNIJdvjSS4EJHZDXugqo25S19lj3DRayPYOOosg96eHoux9QskTKHLrTY
 nj0CscyUfarNPRWbKPgnE1DKMLKUdGzkA7eBM9sXKHoYeoiXiWCNCK0zS+cFPDNBkUJYNFQxGqF
 bK8UMvGd86RYtcM3BU7dHyAF1gaMHKGUhHFI+EZ2BhvKEoeDtZyTPZ3bQ+dhmB3h/KGI4lehLw1
 H1iXg3ALd1A88BsLMDKHJ0BC47Zs0oOYZStUf1se8QTq7YvAndpUbLk8XAIFlGUG59aHcpTlyl0
 vqnwnWIQDYQ1yUsejvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_01,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170099



Am 17.08.26 um 14:28 schrieb sashiko-bot@kernel.org:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [Critical] Use-After-Free of `inti` when injecting floating interrupts.
> - [High] Missed vCPU kick causes lost or delayed floating interrupts when all vCPUs have masks closed.
> --
> 
> --- Patch [1]: [PATCH v2] KVM: s390: Improve floating IRQ injection behavior ---
> commit e7cb031c2f46e8290e932cd848faad5eec943d11
> Author: Janosch Frank <frankja@linux.ibm.com>
> Subject: KVM: s390: Improve floating IRQ injection behavior
> 
> Floating IRQs can be handled by any VCPU that opened its masks. The
> current design does not check if the mask is open when a floating IRQ
> is injected via the FLIC. It will wakeup the last VCPU that went
> sleeping hoping it's the correct one.
> 
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index 8f24bcd1a6d36..e67cdedb5aece 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
> 
> [ ... ]
> 
>> @@ -1915,22 +1946,48 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
> 
> [ ... ]
> 
>>   /*
>>    * Find a destination VCPU for a floating irq and kick it.
>>    */
>> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
>> +static void __floating_irq_kick(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>>   {
>>   	struct kvm_vcpu *dst_vcpu;
>>   	int sigcpu, online_vcpus, nr_tries = 0;
>> +	u64 type = READ_ONCE(inti->type);
>> +	u64 irq_pend_mask;
>>   
>>   	online_vcpus = atomic_read(&kvm->online_vcpus);
>>   	if (!online_vcpus)
>>   		return;
>>   
>> +	irq_pend_mask = inti_to_irq_pend_mask(inti);
>>   	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>>   		sigcpu %= online_vcpus;
>>   		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
>> -		if (!is_vcpu_stopped(dst_vcpu))
>> +		if (!is_vcpu_stopped(dst_vcpu) &&
>> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>>   			break;
>>   		/* avoid endless loops if all vcpus are stopped */
>>   		if (nr_tries++ >= online_vcpus)
>>   			return;
> 
> [Severity: High]
> Does this code drop the interrupt kick entirely if all vCPUs currently
> have their interrupt masks closed?

I think this is a corner case but still a valid finding. We can probably consider this
slowpath and wakeup/set cpuflags for ALL cpus? maybe after doing 2 rounds instead of one?
