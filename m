Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F071B351C2A;
	Wed, 12 Aug 2026 07:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786518680; cv=none; b=lkeUc/cFOqUlJMsn5BBD0iaSZ+eG44QzAkK9ha/Tl7XB+9nvVgpAMCJ+qGbHXvOESPtaiYU8MRcEW7IJ9pGmsaiNEnrrooVo2eU01MKuzUSgdN4IuNQRUbzE8C9Kyl2Xic2hqiS4rBzRTO0Cc4RnLZJLQ3HfP3yLdoXffE+RxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786518680; c=relaxed/simple;
	bh=7U+aCcXKhuBjbZ33CO9UhJem+aDViM6DBGjhOd/dMH4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MCSdiKzkXz24KBU9zKn59eFS1B/k57ErGCzNjMdQ0WMeYjN3Z5Fhw7Ihae0CmtabEAn6k8aaAW0Z1pJoRgJrWSwxT865WU4/DxfaaNRj12Ev4kX7Hb7K15vJwsuG4Nvm1obTIXvmzZVMhVkI7LTl7QoCQtJyflXxanaf/XJwfzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ezliiYVt; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ezliiYVt"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67C62gs92679117;
	Wed, 12 Aug 2026 07:11:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=TjekMG
	QHHpjZx5N5qygeo1Ozgm8PePbzLEyCOomLKME=; b=ezliiYVtOPUd9TbZ2dgLz4
	2l9z/5sAGr9W9LqR0CVWuocPP5ugnPoqWx66M/WnUTvPhVt5JdEHGlSjpmN0ts4W
	cTH/0voDdnbmJv1DhItyCkX5hiRkWMxVKthldeGLoOsZbtnJfSWSlZrUBMKHyklh
	mDjEmGaCpMx8NXllpaQr1aY9oR5DKxZBMspVSWqCH/smdsKxURS6nXUjuzPT0LWy
	A7b+DzK48+S4HjsFqZyB1AjiFXgVv7aQjjjIIkMIezc1JPUlUpR2tZ9BqsMupfQY
	drKXt1mHas1mP50rUyGlibf4RUvB0MPuOn6dLKPLDpdLSIgH878U1iuKLK3RS4pQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9saaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:11:16 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67C7BF1V032363;
	Wed, 12 Aug 2026 07:11:15 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxesq5483-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 12 Aug 2026 07:11:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67C7BBhZ38338986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Aug 2026 07:11:11 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD46D2004B;
	Wed, 12 Aug 2026 07:11:11 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7BC7620040;
	Wed, 12 Aug 2026 07:11:11 +0000 (GMT)
Received: from [9.224.77.173] (unknown [9.224.77.173])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 12 Aug 2026 07:11:11 +0000 (GMT)
Message-ID: <6cc80fa3-f506-4fff-970a-2cbd66d9ce49@de.ibm.com>
Date: Wed, 12 Aug 2026 09:11:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 03/11] KVM: s390: Fix get_all_floating_irqs()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260811155641.219777-1-imbrenda@linux.ibm.com>
 <20260811155641.219777-4-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260811155641.219777-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX0rgP9pieLQA9
 5KA44ENBewZ8OPngdxrieqJ04nkYonsQeX2VDWaS8oJzaVqb/muE1EH8XdhMak5MZXklBNBUTt8
 D1QqCwYDJsbIBwYRhesKCs/TdC/EKvrbC6atWt0OIR6PEjvNAvc7N8oJHo+kYufeKXjXDE2bR+1
 0aIasBCIPMw0HNG1X8uRJxt/1F9MPqWUh2JzzghRXVF6C2g1hXr/w+V1XN4gCvzLwwF6liwlK8F
 x/Sh3E/8h1N3hxcegfNb+pu0VdgYOfMoYXzFebDhMDlJk7S9X0o/p+vKUeb/DFvNl3nmVzWa1cJ
 loVK83uzsvxlip27yA5DHNAc5xMPiyIe2731Q7bHXIuOiy5zX/BVaSNKz/quGNJc/QAA0L/4cLt
 216ILhZbooN4Ecik73mNOjgT072ZGmg05mSXY4LNHeKLaXYTDzLqsCG/xpT/d2vL5G1hwFkrlLI
 rJ8909wLyZblTWgduZQ==
X-Proofpoint-ORIG-GUID: vdSyvfyDEq_zLzJySC5aI7GopwWz7OjH
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDA1NCBTYWx0ZWRfX6ECAPHZtWgMk
 3RQ5fckuptZOB4rlGuOGoD3VKS1P7XjUaFRhNfQV9s5rA2jqx+iTAHoSaWd9h7Vw1GBJk38Gf9W
 TAxwZ/ToMyMiPu7OR38Sb3YiWESEdPY=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7c1c94 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=pAbas-_hZKfkuAVQ570A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: vdSyvfyDEq_zLzJySC5aI7GopwWz7OjH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_02,2026-08-10_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120054

Am 11.08.26 um 17:56 schrieb Claudio Imbrenda:
> When attempting to report all pending floating interrupt to userspace,
> the GISA IPM bits are atomically tested and cleared, and the
> corresponding interrupt description is written in the output buffer. If
> the output buffer is too small, an error is returned to userspace, but
> the GISA IPM bits are now lost.
> 
> Fix by moving the GISA test at the end of the function, and keeping
> track of which bits have been cleared. In case of error, set the bits
> again, so they are not lost.
> 
> Fixes: 24160af6cb28 ("KVM: s390: add GISA interrupts to FLIC ioctl interface")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

this looks too complicated for a fix. Now what is the semantic of this?
This is used for migration purposes, and the doc says:

Documentation/virt/kvm/devices/s390_flic.rst

   KVM_DEV_FLIC_GET_ALL_IRQS
     Copies all floating interrupts into a buffer provided by userspace.
[...]
     All interrupts remain pending, i.e. are not deleted from the list of
     currently pending interrupts.
[...]

So even the success case is wrong. Why not simply add a new helper that
reads the GISA without clearing the bits?

static inline int gisa_test_ipm_gisc(struct kvm_s390_gisa *gisa, u32 gisc)
{
       return test_bit_inv(IPM_BIT_OFFSET + gisc, (unsigned long *) gisa);
}




> ---
>   arch/s390/kvm/interrupt.c | 93 ++++++++++++++++++---------------------
>   1 file changed, 44 insertions(+), 49 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 6b3f97a7513b..30963e05e0e6 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2211,15 +2211,14 @@ void kvm_s390_clear_float_irqs(struct kvm *kvm)
>   static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>   {
>   	struct kvm_s390_gisa_interrupt *gi = &kvm->arch.gisa_int;
> +	struct kvm_s390_irq *buf __free(kvfree) = NULL;
>   	struct kvm_s390_interrupt_info *inti;
>   	struct kvm_s390_float_interrupt *fi;
> -	struct kvm_s390_irq *buf;
>   	struct kvm_s390_irq *irq;
> +	unsigned int tmp = 0;
>   	int max_irqs;
> -	int ret = 0;
>   	int n = 0;
>   	int i;
> -	unsigned long flags;
>   
>   	if (len > KVM_S390_FLIC_MAX_BUFFER || len == 0)
>   		return -EINVAL;
> @@ -2235,14 +2234,48 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>   
>   	max_irqs = len / sizeof(struct kvm_s390_irq);
>   
> +	fi = &kvm->arch.float_int;
> +	scoped_guard(spinlock_irqsave, &fi->lock) {
> +		for (i = 0; i < FIRQ_LIST_COUNT; i++) {
> +			list_for_each_entry(inti, &fi->lists[i], list) {
> +				/* signal userspace to try again */
> +				if (n == max_irqs)
> +					return -ENOMEM;
> +				inti_to_irq(inti, &buf[n]);
> +				n++;
> +			}
> +		}
> +		if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
> +		    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
> +			/* signal userspace to try again */
> +			if (n == max_irqs)
> +				return -ENOMEM;
> +			irq = (struct kvm_s390_irq *)&buf[n];
> +			irq->type = KVM_S390_INT_SERVICE;
> +			irq->u.ext = fi->srv_signal;
> +			n++;
> +		}
> +		if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
> +			/* signal userspace to try again */
> +			if (n == max_irqs)
> +				return -ENOMEM;
> +			irq = (struct kvm_s390_irq *)&buf[n];
> +			irq->type = KVM_S390_MCHK;
> +			irq->u.mchk = fi->mchk;
> +			n++;
> +		}
> +	}
>   	if (gi->origin && gisa_get_ipm(gi->origin)) {
>   		for (i = 0; i <= MAX_ISC; i++) {
>   			if (n == max_irqs) {
> +				/* restore removed bits if returning failure */
> +				__atomic_or(tmp, (void *)&gi->origin->ipm);
>   				/* signal userspace to try again */
> -				ret = -ENOMEM;
> -				goto out_nolock;
> +				return -ENOMEM;
>   			}
>   			if (gisa_tac_ipm_gisc(gi->origin, i)) {
> +				/* set aside the bits we cleared */
> +				tmp |= 1 << (31 - i);
>   				irq = (struct kvm_s390_irq *) &buf[n];
>   				irq->type = KVM_S390_INT_IO(1, 0, 0, 0);
>   				irq->u.io.io_int_word = isc_to_int_word(i);
> @@ -2250,53 +2283,15 @@ static int get_all_floating_irqs(struct kvm *kvm, u8 __user *usrbuf, u64 len)
>   			}
>   		}
>   	}
> -	fi = &kvm->arch.float_int;
> -	spin_lock_irqsave(&fi->lock, flags);
> -	for (i = 0; i < FIRQ_LIST_COUNT; i++) {
> -		list_for_each_entry(inti, &fi->lists[i], list) {
> -			if (n == max_irqs) {
> -				/* signal userspace to try again */
> -				ret = -ENOMEM;
> -				goto out;
> -			}
> -			inti_to_irq(inti, &buf[n]);
> -			n++;
> -		}
> -	}
> -	if (test_bit(IRQ_PEND_EXT_SERVICE, &fi->pending_irqs) ||
> -	    test_bit(IRQ_PEND_EXT_SERVICE_EV, &fi->pending_irqs)) {
> -		if (n == max_irqs) {
> -			/* signal userspace to try again */
> -			ret = -ENOMEM;
> -			goto out;
> -		}
> -		irq = (struct kvm_s390_irq *) &buf[n];
> -		irq->type = KVM_S390_INT_SERVICE;
> -		irq->u.ext = fi->srv_signal;
> -		n++;
> -	}
> -	if (test_bit(IRQ_PEND_MCHK_REP, &fi->pending_irqs)) {
> -		if (n == max_irqs) {
> -				/* signal userspace to try again */
> -				ret = -ENOMEM;
> -				goto out;
> -		}
> -		irq = (struct kvm_s390_irq *) &buf[n];
> -		irq->type = KVM_S390_MCHK;
> -		irq->u.mchk = fi->mchk;
> -		n++;
> -}
>   
> -out:
> -	spin_unlock_irqrestore(&fi->lock, flags);
> -out_nolock:
> -	if (!ret && n > 0) {
> -		if (copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n))
> -			ret = -EFAULT;
> +	if (n > 0 && copy_to_user(usrbuf, buf, sizeof(struct kvm_s390_irq) * n)) {
> +		/* restore removed bits if returning failure */
> +		if (tmp)
> +			__atomic_or(tmp, (void *)&gi->origin->ipm);
> +		return -EFAULT;
>   	}
> -	vfree(buf);
>   
> -	return ret < 0 ? ret : n;
> +	return n;
>   }
>   
>   static int flic_ais_mode_get_all(struct kvm *kvm, struct kvm_device_attr *attr)

