Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4727277CA5;
	Thu, 23 Apr 2026 13:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776951373; cv=none; b=ijAOapazN5v41aazRzyFQByCi4oFQOkqCGHyVoz2mcjRM4OCubLf4mbzsUaEQpL5zZIdIpEKW6Q7DMhlTfJYwk5U3L5k7nvWNJ98zPkocCcfzR8XssSDpR0AT0FuLaHkm0l4eE2ykji7XhstR1JHlo8KATGbVGr2/hQcrL1fg+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776951373; c=relaxed/simple;
	bh=Lu5uMbDHf8gytuZoM7h2GZWcycJO249Q34tRUIQehMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=euZHkKEIb4ttWCEwW/EEuWqaUt+SRAEkqS7PwrtVn4MZet2ndzrd4fbZvvCCA/Acnd6VOx0+sKOtj/GggFmObophBCw/OuCuJBjL29yQRfqc2P/ljG5INnx7IdwfPbeglR4FLm4jLM8FjPNGwyffcmU/eeafUcweAcFBODmbqzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ii4V1pOF; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ii4V1pOF"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63N7vBvH3658063;
	Thu, 23 Apr 2026 13:36:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=O+brqgOmY8+geDtZHKWXpeKu9bn+hx
	/4naoM3SDUdvM=; b=ii4V1pOF/ybPvxE089WkaEKeNLdTnROi3nI2TyDL4jQ9dm
	bsy+cZvx6BC0THnoVEY4bcT6M+j8KZVqY18aYREomPiuMo/7nI7rc/BbJSWkryd7
	n7MTE7VbcYTG88cq2e6MENyh3PtOyvt1hKopsNxCML3lWcY+OtR/W8gTeOo66+1G
	WvKYrYlEFGBwZGREwW1R2/OAPDV/z01/P67+/7thd01dDHSnt9frWhpBwn/oIq2I
	xhwA56YLhiRWWXrQZZ/s/dvcu/1BFNVrbl71fTklS5bJDszcUvN/e+MpwQHA4sUC
	pnOWtebQi3WKRlZPt2OTWw+VJyiuxNPHIwli1O9Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dpeu7raja-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:36:10 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63NDZTrY003130;
	Thu, 23 Apr 2026 13:36:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dpjkyest5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 23 Apr 2026 13:36:09 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63NDa6XH21758534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Apr 2026 13:36:06 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE1F20043;
	Thu, 23 Apr 2026 13:36:06 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DBC0C20040;
	Thu, 23 Apr 2026 13:36:05 +0000 (GMT)
Received: from osiris (unknown [9.52.214.206])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Apr 2026 13:36:05 +0000 (GMT)
Date: Thu, 23 Apr 2026 15:36:02 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Janosch Frank <frankja@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        borntraeger@linux.ibm.com
Subject: Re: [PATCH 3/3] kvm: s390: Fix lpsw/e spec exception ilc reporting
Message-ID: <20260423133602.10371F31-hca@linux.ibm.com>
References: <20260423123902.14663-1-frankja@linux.ibm.com>
 <20260423123902.14663-4-frankja@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260423123902.14663-4-frankja@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iuBwqEvlR5y63W1TYyqBL_V9-KuPuibK
X-Authority-Analysis: v=2.4 cv=Ksp9H2WN c=1 sm=1 tr=0 ts=69ea204a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=bbwGFtJDcqejF4BoOksA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: iuBwqEvlR5y63W1TYyqBL_V9-KuPuibK
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIzMDEzMiBTYWx0ZWRfX+0sCGVVGU1B0
 WCMg20nasmX+vb6lfKH9gZw3BsRHVFOh7xffyEVZElBf3JrGiBOhQCfOi0jdiQ/LRUNNIJFqd/V
 GJyTOTkQ8l1uKhUyGlG+AhJ2vapCXiEzQhBVRNAdvjXl3gJcuTuGfV/HOw/JukCu9kTJB5mTh93
 ajmgjn8ahT3lf2wZQR/y6XEVFUQAoKc1FxohqAWH3dwnbNS0dRDEN46hTItM46UCP3iZrZ1WV/T
 2cSoPD8jOlgAXS6BtI/tDxX2w4AUL0UB1zvaouBD9cywmhUv0icr+NdOVGt6UgckuGJihQ5sPDL
 aSAqFbAx9ZHk2iPqGLiqDl5ZbB8kTf7yRs2sSa+gynn7JjpOJR3QE563lecA0anO06TbTEaFp5s
 BiarJTO7ArWeHn48Q0OP9ONKDytfvpvHR4nKc++PS2LVSZoB3YIAqvQzxjjRjvfkVEvv7VB7TGa
 AG9TFjXIQwNcz3XMd7w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-23_03,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 suspectscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604230132

On Thu, Apr 23, 2026 at 12:36:04PM +0000, Janosch Frank wrote:
> On early PSW specification exception the ILC has to be 0 according to
> architecture.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Fixes: 48a3e950f4cee ("KVM: s390: Add support for machine checks.")
> ---
>  arch/s390/kvm/priv.c | 16 ++++++++++++----
>  1 file changed, 12 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/s390/kvm/priv.c b/arch/s390/kvm/priv.c
> index 56e63679f9d1..9fd7d3f1d1e8 100644
> --- a/arch/s390/kvm/priv.c
> +++ b/arch/s390/kvm/priv.c
> @@ -713,6 +713,7 @@ int is_valid_psw(psw_t *psw)
>  int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>  {
>  	psw_t *gpsw = &vcpu->arch.sie_block->gpsw;
> +	struct kvm_s390_pgm_info info = {};
>  	psw32_t new_psw;
>  	u64 addr, iaddr;
>  	int rc;
> @@ -738,14 +739,18 @@ int kvm_s390_handle_lpsw(struct kvm_vcpu *vcpu)
>  	gpsw->addr = new_psw.addr & ~PSW32_ADDR_AMODE;
>  	vcpu->arch.sie_block->gbea = iaddr;
>  
> -	if (!is_valid_psw(gpsw))
> -		return kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
> +	if (!is_valid_psw(gpsw)) {
> +		info.code = PGM_SPECIFICATION;
> +		info.flags = KVM_S390_PGM_FLAGS_ILC_VALID;
> +		return kvm_s390_inject_prog_irq(vcpu, &info);
> +	}

Hmm... looking at the architecture: an odd instruction address in the PSW
does not result in an early specification exception, but a "normal"
specification exception. is_valid_psw() however also checks for an odd
instruction address. So I guess this is still not entirely correct.

I'm also wondering if the above implementation is correct if PER is enabled
when the specification happens...

Btw.: you may want to have consistent short descriptions for your two
patches. That is consistently use upper or lower case for "LPSW/E".
