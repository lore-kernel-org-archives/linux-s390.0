Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 878463A9D90;
	Fri, 18 Sep 2026 12:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789734872; cv=none; b=NifkjfKJtp3trwtZdLrUf4kVgN9dC163tK6e2BY/kMZm0V7T1i2gPcMjCDpOlhb+C0KxbZ1euFhUaaepabb8qYbCWlDITtASZfrcNiVeuS0IphAAyNBQZsGLmOvMCYNwESOWEKC+JxZgGwB772GqR97ZTfyJGiD9IbuLeIsVW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789734872; c=relaxed/simple;
	bh=YJCGw6ARIMlU4eqdYHhFU36jxlQadfYzdfc1tAz3UVE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R7dN+5tnDOD65mNu4J5R1pxRAZFw4vdv2gEEj3+LGHw1Cq04sfjHKIpwQOL+ckDPJKbsQui/oZYNG1/ei4lFjSGkvuIy94/LAqmXpx1KbwyraOk/maZr1o98UbTpaT0QSwJxFA6zZjQPwP1uZsVjf+9OM0klyoCZ12Si776SUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RQQLG0oS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RQQLG0oS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68IA1Tge3274371;
	Fri, 18 Sep 2026 12:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XEnm9l
	smNkTOj/yTn0lARIh6WtbQHn/KXNA0qViss6U=; b=RQQLG0oSmyxMem3nXnKf/b
	o5G8D0pNWtXaFhM3BkYGsdJwnQFd/cTTsHBSvFOM9Y1v3hNqyF9bFxPmUrR5HP6r
	WB+B3UhpIOW3P0F5/pPtyaynseB+nFWmWLiY2EavTaqk4ZnJXiGVx+q8G9zEQzW3
	5T10fiip17flRqOvohVT1qqBn99GB5KKePfuB0Mz5idva8NDbBRboj9hlbUueIq3
	DeCjP94AT6M5YySbCS4hWX+uTJohzMr8TZIS8t/9H35YzAwjBxxnCqPgzFvDSWUA
	etS+ikpMz4POOyM/vwARTYGTJM11LBOF+38huPwc41ude5XgbC9PfcRk4R0IY1IA
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxdqr1xe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:34:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68ICIenH651175;
	Fri, 18 Sep 2026 12:34:28 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gs56q81k6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 12:34:28 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68ICYOHi25625284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 12:34:24 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8D2D52004D;
	Fri, 18 Sep 2026 12:34:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6262C20043;
	Fri, 18 Sep 2026 12:34:24 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 12:34:23 +0000 (GMT)
Message-ID: <212bee82-346c-4c29-96ac-bcfb51b32bba@linux.ibm.com>
Date: Fri, 18 Sep 2026 14:34:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] KVM: s390: Improve floating IRQ injection behavior
To: Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc: imbrenda@linux.ibm.com, linux-s390@vger.kernel.org, pasic@linux.ibm.com
References: <20260819190408.247843-1-frankja@linux.ibm.com>
 <20260819190408.247843-2-frankja@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@linux.ibm.com>
In-Reply-To: <20260819190408.247843-2-frankja@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfXygyTrQWfHwnC
 UuFXX+LHmIw2XUINi+bcYytOsFwujW3lM7ujyosHC8gxU3tD3VpLPyXPtd2SO+BO6K2EfopXdsS
 meYTrPCtzGh7u9fkr0MhmI5dy/hsAo4fv14z5Yj2vRcXOV8C076SNkTSdG3ur5baolO4feDYlWn
 f82ioV3qDb9Iu+tn1RJ3OxfXrcu0t+saDHBLGfOcklMrCgKRKxT7XgKLwScLxfW+OENPtwgDZto
 E/WVsFGaAXdk/9u+o7ZLWhNBUM5oYAL8oiJz6DdNrGdx8hcjVD2xZmH721wf4eHy9lx6TRqCBtl
 oFWNuz3txjrAueSfNN+5OvjXAhPYDbsGxOH1OcPwFmAbZUb+qmbe8DzsVavxKZCrm9I8/QxW5GR
 0julC/EHd9qhytML8bOgDyRg2TQScqWbsRP6nhnarnZV2Uc9LeTYSLwehGf1pYlpBVUEjD3WMtq
 WgPzjU1dS9k1GTG0UIA==
X-Proofpoint-GUID: lV5ZFqWW9ra0UoMSXFh2rodazu7fKqiy
X-Authority-Analysis: v=2.4 cv=DobDa2/+ c=1 sm=1 tr=0 ts=6aad2fd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=8tCnNV-NJCoGdqYrY4sA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lV5ZFqWW9ra0UoMSXFh2rodazu7fKqiy
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDE3NyBTYWx0ZWRfX42P0wMXDxRgh
 xkkStKJG+xFtkjVgr6CxfobxTwtKw3PpZnJzWTCvf8BQJ9PzXqgeI3wTPq4TjE1Yz0qjQ5C5Dks
 EqoAaUL2enO+EHpTsJZZYCgp60YQF/w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_03,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 clxscore=1015 adultscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609180177



Am 19.08.26 um 20:41 schrieb Janosch Frank:
> Floating IRQs can be handled by any VCPU that opened its masks. The
> current design does not check if the mask is open when a floating IRQ
> is injected via the FLIC. It will wakeup the last VCPU that went
> sleeping hoping it's the correct one.
> 
> Improve this by checking if the VCPU has pending IRQs and if not try
> to find another VCPU which can take the IRQ.

I think I misread this multiple times. with "has pending IRQs" you
actually mean: after the inject the new pending interrupt is actually
deliverable on that cpu, correct?




> 
> This is not the final fix around this topic but we'll eventually
> inject a pending IRQ. The current code can easily deadlock a VM and
> with this fix we work around that.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   arch/s390/kvm/interrupt.c | 86 ++++++++++++++++++++++++++++++---------
>   1 file changed, 66 insertions(+), 20 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8f24bcd1a6d3..3af060ec5be8 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -1915,49 +1915,93 @@ static int __inject_io(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>   	return 0;
>   }
>   
> +static u64 inti_to_irq_pend_mask(u64 type, int isc)
> +{
> +	switch (type) {
> +	case KVM_S390_MCHK:
> +		/* Only repressible machine checks are floating */
> +		return BIT(IRQ_PEND_MCHK_REP);
> +	case KVM_S390_INT_VIRTIO:
> +		return BIT(IRQ_PEND_VIRTIO);
> +	case KVM_S390_INT_SERVICE:
> +		return BIT(IRQ_PEND_EXT_SERVICE) |
> +		       BIT(IRQ_PEND_EXT_SERVICE_EV);
> +	case KVM_S390_INT_PFAULT_DONE:
> +		return BIT(IRQ_PEND_PFAULT_DONE);
> +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> +		return isc_to_irq_type(isc);
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/*
> + * Setup intervention masks to catch running vcpus that hopefully open
> + * their masks soonish and kick sleeping vcpus to motivate them to
> + * take IRQs.
> + */
> +static void vcpu_intervention_kick(struct kvm_vcpu *vcpu, u64 type)
> +{
> +	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
> +	switch (type) {
> +	case KVM_S390_MCHK:
> +		kvm_s390_set_cpuflags(vcpu, CPUSTAT_STOP_INT);
> +		break;
> +	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> +		if (!(type & KVM_S390_INT_IO_AI_MASK &&
> +		      vcpu->kvm->arch.gisa_int.origin) ||
> +		      kvm_s390_pv_cpu_get_handle(vcpu))
> +			kvm_s390_set_cpuflags(vcpu, CPUSTAT_IO_INT);
> +		break;
> +	default:
> +		kvm_s390_set_cpuflags(vcpu, CPUSTAT_EXT_INT);
> +		break;
> +	}
> +	kvm_s390_vcpu_wakeup(vcpu);
> +}
> +
>   /*
>    * Find a destination VCPU for a floating irq and kick it.
>    */
> -static void __floating_irq_kick(struct kvm *kvm, u64 type)
> +static void __floating_irq_kick(struct kvm *kvm, u64 type, int isc)
>   {
>   	struct kvm_vcpu *dst_vcpu;
>   	int sigcpu, online_vcpus, nr_tries = 0;
> +	u64 irq_pend_mask;
> +	unsigned long i;
>   
>   	online_vcpus = atomic_read(&kvm->online_vcpus);
>   	if (!online_vcpus)
>   		return;
>   
> +	irq_pend_mask = inti_to_irq_pend_mask(type, isc);
>   	for (sigcpu = kvm->arch.float_int.last_sleep_cpu; ; sigcpu++) {
>   		sigcpu %= online_vcpus;
>   		dst_vcpu = kvm_get_vcpu(kvm, sigcpu);
> -		if (!is_vcpu_stopped(dst_vcpu))
> +		if (!is_vcpu_stopped(dst_vcpu) &&
> +		    deliverable_irqs(dst_vcpu) & irq_pend_mask)
>   			break;
>   		/* avoid endless loops if all vcpus are stopped */
> -		if (nr_tries++ >= online_vcpus)
> -			return;
> +		if (nr_tries++ >= online_vcpus * 2) {
> +			dst_vcpu = NULL;
> +			break;
> +		}
>   	}
>   
> -	/* make the VCPU drop out of the SIE, or wake it up if sleeping */
> -	switch (type) {
> -	case KVM_S390_MCHK:
> -		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_STOP_INT);
> -		break;
> -	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> -		if (!(type & KVM_S390_INT_IO_AI_MASK &&
> -		      kvm->arch.gisa_int.origin) ||
> -		      kvm_s390_pv_cpu_get_handle(dst_vcpu))
> -			kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_IO_INT);
> -		break;
> -	default:
> -		kvm_s390_set_cpuflags(dst_vcpu, CPUSTAT_EXT_INT);
> -		break;
> +	/* Nobody was enabled, time to wake all of them */
> +	if (!dst_vcpu) {
> +		kvm_for_each_vcpu(i, dst_vcpu, kvm)
> +			vcpu_intervention_kick(dst_vcpu, type);
> +		return;
>   	}
> -	kvm_s390_vcpu_wakeup(dst_vcpu);
> +
> +	vcpu_intervention_kick(dst_vcpu, type);
>   }
>   
>   static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>   {
>   	u64 type = READ_ONCE(inti->type);
> +	int isc = -1;
>   	int rc;
>   
>   	switch (type) {
> @@ -1974,6 +2018,8 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>   		rc = __inject_pfault_done(kvm, inti);
>   		break;
>   	case KVM_S390_INT_IO_MIN...KVM_S390_INT_IO_MAX:
> +		/* Grab isc here since __inject_io() might free inti */
> +		isc = isc_to_irq_type(int_word_to_isc(inti->io.io_int_word));
>   		rc = __inject_io(kvm, inti);
>   		break;
>   	default:
> @@ -1982,7 +2028,7 @@ static int __inject_vm(struct kvm *kvm, struct kvm_s390_interrupt_info *inti)
>   	if (rc)
>   		return rc;
>   
> -	__floating_irq_kick(kvm, type);
> +	__floating_irq_kick(kvm, type, isc);
>   	return 0;
>   }
>   

