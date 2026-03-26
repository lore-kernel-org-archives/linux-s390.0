Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7BA3FD158;
	Thu, 26 Mar 2026 15:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774540629; cv=none; b=tg4HaCs4rfP6vSaLc9ac0pHelrItZy7e/nG+iNygWPrlvZZQsixJzqsgiBk0mEQCPWlvxejLfkx+OI7a8mEi0TxyN7KcZOxFMo2RbXwl8TOxITGJYRL2W7tvEPOg3EUnBlVOM6U4QCvqV0lHo79KOpdMrAyI4wcewfe+s/CCgH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774540629; c=relaxed/simple;
	bh=EoIBWatrpTNgOezpFLcnKWsHt+vPBHaG7l//oftGlAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mCl/ufO85fIentzCGVyjZrZavAaA2dwgpOAnrUrVl1myrTREWDm6/M192TS6TmIf9yJUMNMMvGaNYkAvS0DDSckflBinJowdHHd4b22RSpA5W+qUOa7F74iwbjLt0gGMzaqd3/TQsjGcd/yVFMFHYs3/BO831WqCEkKDKl8Caxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SKQQuQks; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SKQQuQks"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62QAr8253729349;
	Thu, 26 Mar 2026 15:57:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=pd+qIV
	L1R2p2sWOp/TtlbpFG75LxF6MfMPhF7Fxl5f4=; b=SKQQuQks+tOnP+DCUPHhND
	fEpQJp0jfsYXI2LxBKMd8IEZUQPLIK6P1YqkktTp2axFCcY8DBSfcKKvS5Zn9xFP
	Fa/3mSUB41+30xpEsfAoQQ3F5srPE5H62i1ozDcWzxrO46/bJMO/uJr86A8SXo/h
	ah2KtMbevjslLEMEMmcK7D8GpXpc/rHHmQSFY7Vn297EN3zjIwPlwTLrWop0MOON
	t9v+LV9tt5I56eTUmliVhLgrRjtR4r9atgqIE63N3fgjFxe6bZIeIFLcG66Mhwaf
	dloEhaflXqFzWjD9FuSwo4skeASu6pGo9RLhJEmoKjJOGeAEbe2pOnaJG6+Y63Bg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwa616n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 15:57:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62QFEwtk009143;
	Thu, 26 Mar 2026 15:57:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d26nnumx7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 26 Mar 2026 15:57:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62QFv0nQ51446094
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Mar 2026 15:57:00 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AA3F20043;
	Thu, 26 Mar 2026 15:57:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C027120040;
	Thu, 26 Mar 2026 15:56:59 +0000 (GMT)
Received: from [9.111.95.142] (unknown [9.111.95.142])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 26 Mar 2026 15:56:59 +0000 (GMT)
Message-ID: <259c135b-2c1b-4f43-a177-925d7df8b909@linux.ibm.com>
Date: Thu, 26 Mar 2026 16:56:59 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] KVM: s390: Add map/unmap ioctl and clean mappings
 post-guest
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc: mjrosato@linux.ibm.com
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260326014247.2085-2-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: s_FRowJC5lzBhSqTr2p0z9TInQ_DpV0V
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI2MDExMiBTYWx0ZWRfXxkwy5B+aQPiu
 hayQ0LdBQSA0KCFP+Hqs9bmHyOpJlfxRuhhlc7xsV/twLPPOfT8uIIR2DJa6RxNNJRsVXE3DLhR
 pvy2sKt2xzB+M/jUHAAhHB0oHWrg3+wkMIYTpnEbFEUvVDKaGamPhBSadXFTVkRFpZfHVyqR7E1
 2YwnywMkqGOKaKCsIKHtDiCtYsECb6fky1HxVv1prd/eUmxt2o+Or3TbMS8unzcEZYnKyew45oX
 BGOyIcfFtME8WQtkUYfJS8ZT3YHpMRZdC3Oc0ZCZWPr/dcq6qAAkRtyIQzGQnnlhBN/AX9RVDzD
 qRoUJ0FyiGZjKI/+r3Ih+EWAAzlOaWZrG9UwEKWj5vWwAcEMVr0iI2lc0PzxyVA9xkTQMQj7qLz
 1Sz5/DGsz9DmyaFvcZBZkOnawLI1bBvBmndwjkIKgutW0+TV78XpyRFT6vHxAXS+MMnlcrAJ0qc
 yd3ivJVfkh63g2cb/ng==
X-Proofpoint-GUID: s_FRowJC5lzBhSqTr2p0z9TInQ_DpV0V
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c55751 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=p6cV8aexzsmYh0Kl35UA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_03,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603260112

On 3/26/26 02:42, Douglas Freimuth wrote:
> S390 needs map/unmap ioctls, which map the adapter set
> indicator pages, so the pages can be accessed when interrupts are
> disabled. The mappings are cleaned up when the guest is removed.
> 
> Map/Unmap ioctls are fenced in order to avoid the longterm pinning
> in Secure Execution environments. In Secure Execution
> environments the path of execution available before this patch is followed.
> 
> Statistical counters to count map/unmap functions for adapter indicator
> pages are added. The counters can be used to analyze
> map/unmap functions in non-Secure Execution environments and similarly
> can be used to analyze Secure Execution environments where the counters
> will not be incremented as the adapter indicator pages are not mapped.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---

Looks good, two nits below.

[...]
>   		if (ret > 0)
>   			ret = 0;
>   		break;
> -	/*
> -	 * The following operations are no longer needed and therefore no-ops.
> -	 * The gpa to hva translation is done when an IRQ route is set up. The
> -	 * set_irq code uses get_user_pages_remote() to do the actual write.
> -	 */
>   	case KVM_S390_IO_ADAPTER_MAP:
>   	case KVM_S390_IO_ADAPTER_UNMAP:
> -		ret = 0;
> +		/* If in Secure Execution mode do not long term pin. */
> +		mutex_lock(&dev->kvm->lock);
> +		if (kvm_s390_pv_is_protected(dev->kvm)) {
> +			mutex_unlock(&dev->kvm->lock);
> +			return 0;
> +		}
> +		mutex_unlock(&dev->kvm->lock);
> +		idx = srcu_read_lock(&dev->kvm->srcu);
> +		host_addr = gpa_to_hva(dev->kvm, req.addr);
> +		if (kvm_is_error_hva(host_addr)) {
> +			srcu_read_unlock(&dev->kvm->srcu, idx);
> +			return -EFAULT;
> +			}

Alignment issue

[...]

>   static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   {
>   	const bool need_lock = (cmd->cmd != KVM_PV_ASYNC_CLEANUP_PERFORM);
> @@ -2503,6 +2522,7 @@ static int kvm_s390_handle_pv(struct kvm *kvm, struct kvm_pv_cmd *cmd)
>   
>   	switch (cmd->cmd) {
>   	case KVM_PV_ENABLE: {
> +		kvm_s390_unmap_all_adapters_pv(kvm);

Shouldn't this be located after the check that's below?

>   		r = -EINVAL;
>   		if (kvm_s390_pv_is_protected(kvm))
>   			break;

