Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6FC3382FC;
	Fri,  6 Mar 2026 14:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772808598; cv=none; b=QNEteHG4I+k5zgYCgDw+W2/y+MN8r6g6bUkoCEM3qEai7NjQs7zzv/1UQfyDTNxEloDbjWnvyOGvjCLtg1SMLeTFcCVZbeQxjLseymb3QmtPZSni/EHCcyE4dFTN6YG6834utbjxBq6+efsq6zcublAvERdzxywsMNo+pSAQFEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772808598; c=relaxed/simple;
	bh=rkixwexP5kUJiSbCHTqYNIyLJZPjx46H+0DQXY3+t4M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VUKFGc8YvdOZ1hEF9oka4EFYenpYrddVoRemRstnCqjQ52esg75/pUL9c23Fyi0RnPfXwsstGm11u5o1XLP7NEhEPV2vjoyWOgWdOozt11jwfUQ8iZe7ZYPdo0KCzQMEE7u2PDhg/5eFMAVuivkxdSo8PrBBMd1oPOJdz5v+IFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=loSxt5sm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="loSxt5sm"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6266KAcc2063768;
	Fri, 6 Mar 2026 14:49:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6Vi6xX
	gvhleqRrUETwW3v6Hy+5QskzOeK91st7CY5sY=; b=loSxt5smuk2eO3YH2oV5SU
	OoHz4SX69AevziSNAzRjPr4s3lZyWAsdLmpgpLrEaPz6iDb8D+44Md3qa86Z/IQ+
	+jXhMBGZOjQ2ZUHMoEXhR5l+fV5jhhiO5eNHMFO+z3/SKNSZinKbQ8oFPPLHiiOe
	p88SIZ4wulIRflymEX7+zWIoKPq/XIPx7yjV+rytDx4WjlE00mOdriUhq7FNDkki
	EZ3V32BCQR5X82skQNG4SKrihbGEz9uzYDmX2qsDAu60W/YZoO5+SwmaONlXTFjA
	5aKYpKs70UnlZrt8y+oXD24P45tnv/IZ5aDxokSSErUV3lto/yxm4Kil+vHMQMZQ
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ckskc8dnk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 14:49:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 626Cg44r011200;
	Fri, 6 Mar 2026 14:49:50 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cqau2vtpu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Mar 2026 14:49:50 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 626EnnPE13632054
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 6 Mar 2026 14:49:49 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1663158063;
	Fri,  6 Mar 2026 14:49:49 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFB4258060;
	Fri,  6 Mar 2026 14:49:47 +0000 (GMT)
Received: from [9.111.152.90] (unknown [9.111.152.90])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  6 Mar 2026 14:49:47 +0000 (GMT)
Message-ID: <4df383a6-2046-425d-9405-86889187644a@linux.ibm.com>
Date: Fri, 6 Mar 2026 15:49:46 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390: Revert "s390/irq/idle: Remove psw bits early"
To: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20260306111919.362559-1-hca@linux.ibm.com>
Content-Language: en-US
From: Mikhail Zaslonko <zaslonko@linux.ibm.com>
In-Reply-To: <20260306111919.362559-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ua_189ymX7QSuYLlFPynUJWjhHTBAK3t
X-Authority-Analysis: v=2.4 cv=b66/I9Gx c=1 sm=1 tr=0 ts=69aae98f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=JfrnYn6hAAAA:8 a=gC04ymZ0DmD80M8TATsA:9 a=QEXdDO2ut3YA:10
 a=1CNFftbPRP8L7MoqJWF3:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA2MDE0MCBTYWx0ZWRfXzJ1gZ6BlNI2Q
 pY4OlPcUERcjMgQIM5sDE9ZsVjgcFztlSUCbp87eA4ja0zmf5TZ4h2OBBM3MfRuJaKMDWeEd+Ko
 8yMICPx60f5XjCfN1sdNbyb7hBOK8yp58mjxpI9LBTKqaSMM4y3aYyJTE55LxkyyU8wQQCFI8jd
 t7w2dcS+1jn832zccO4DGmIo+Ji0e+kMnoMkhTzrOBoJH0s6i37ZMpyb6Jt0dwVq5RN5FiXIN+X
 nwd+UFUp2acg9h/AhXq558Q6oeBYKLG+ggUGNtVXuZx2f8P70xK+mt62Iqa3IITBcB2+FORGdAe
 p/uU0qBSqP73+T6+gn4DzPzLbW8OI07xCNCk+9v/9D5Xslt/cGGL8FFlruqWjVqHuaFhz/RPUGO
 u9uli7pfJyF1ZCqg2zExpp8Yv1LRVcJ5/vmTtZZ6w+cN+yaKWV7toztb7Qh1lyflj6TY4FDZqiB
 No6b++ZEhQhryvzAOxg==
X-Proofpoint-GUID: ua_189ymX7QSuYLlFPynUJWjhHTBAK3t
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-06_04,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 phishscore=0 clxscore=1011 adultscore=0
 bulkscore=0 impostorscore=0 malwarescore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603060140



On 06-Mar-26 12:19, Heiko Carstens wrote:
> This reverts commit d8b5cf9c63143fae54a734c41e3bb55cf3f365c7.
> 
> Mikhail Zaslonko reported that linux-next doesn't boot anymore [2]. Reason
> for this is recent change [2] was supposed to slightly optimize the irq
> entry/exit path by removing some psw bits early in case of an idle exit.
> 
> This however is incorrect since irqentry_exit() requires the correct old
> psw state at irq entry. Otherwise the embedded regs_irqs_disabled() will
> not provide the correct result.
> 
> With linux-next and HRTIMER_REARM_DEFERRED this leads to the observed boot
> problems, however the commit is broken in any case.
> 
> Revert the commit which introduced this.
> 
> Thanks to Peter Zijlstra for pointing out that this is a bug in the s390
> entry code.
> 
> Fixes: d8b5cf9c6314 ("s390/irq/idle: Remove psw bits early") [1]
> Reported-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Closes: https://lore.kernel.org/r/af549a19-db99-4b16-8511-bf315177a13e@linux.ibm.com/ [2]
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/irq.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
> index 7fdf960191d3..d10a17e6531d 100644
> --- a/arch/s390/kernel/irq.c
> +++ b/arch/s390/kernel/irq.c
> @@ -147,10 +147,8 @@ void noinstr do_io_irq(struct pt_regs *regs)
>  	bool from_idle;
>  
>  	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
> -	if (from_idle) {
> +	if (from_idle)
>  		update_timer_idle();
> -		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
> -	}
>  
>  	irq_enter_rcu();
>  
> @@ -176,6 +174,9 @@ void noinstr do_io_irq(struct pt_regs *regs)
>  
>  	set_irq_regs(old_regs);
>  	irqentry_exit(regs, state);
> +
> +	if (from_idle)
> +		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
>  }
>  
>  void noinstr do_ext_irq(struct pt_regs *regs)
> @@ -185,10 +186,8 @@ void noinstr do_ext_irq(struct pt_regs *regs)
>  	bool from_idle;
>  
>  	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
> -	if (from_idle) {
> +	if (from_idle)
>  		update_timer_idle();
> -		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
> -	}
>  
>  	irq_enter_rcu();
>  
> @@ -210,6 +209,9 @@ void noinstr do_ext_irq(struct pt_regs *regs)
>  	irq_exit_rcu();
>  	set_irq_regs(old_regs);
>  	irqentry_exit(regs, state);
> +
> +	if (from_idle)
> +		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
>  }
>  
>  static void show_msi_interrupt(struct seq_file *p, int irq)

Indeed, with this revert no more kernel-next boot problems observed.

Acked-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>
Tested-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

