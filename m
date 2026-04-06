Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9DB37107E;
	Mon,  6 Apr 2026 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775492723; cv=none; b=nX40iYCnQCSkB3kE11BXrUXRyzSGxAy9ILBtuSqrDTO1/x5d72/yfe9iNhT9HwCZSGDiX2UhlIwoYPHAwH3l4MnSAEll9FaOcSOAUMZTOFNN0IkYchMOizVPw6aX0+dVQYuIVWAZd9Euom1xWHgy1gH5ymbJbWbizIj4A81iZv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775492723; c=relaxed/simple;
	bh=ngjDooXf5Pcr7k2d4p+jIIxG08B4RRHnuE+yPky4piE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R4uxgc/QlZ3/lbKCVwykbRCzEcZ/cZZzOX9ywloKVroKwbn9Q9nYGQRQvpvobvKii4fJZDlMTpXoEk1R4HkRLuYIvNsvMpv4suPyZ9nqWmTOnbwJojqkdsRYLPhNrYQCwmb2hRh+Exh8Kgk5Uc4c40Ud9TXMLBaunz6AnFvLaTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VeIRkCjM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VeIRkCjM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 635Mj58n3762569;
	Mon, 6 Apr 2026 16:25:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F4fi3c
	ahaAzJo5UH4AbwpD5GJc+roP979BKJ0AyitnM=; b=VeIRkCjMhdshtUTlEpvswb
	hco19Mfn7R0Fgyv5gclM4F8BxLBmk24DBU1P/njPsmZ1j6sx8JyYkBUL5WY9yk3J
	12x3KEfkjvVbJ66xf2ydxDMEWwX4sDoMPmSZVB9CY7c0MLjWFRJaXCnakigiVwii
	V/08bm5irbqdjPHJVWyiWkCUfYDI6v7o4Ovf2t3B1oyrLc1lV3IJALeURdsGiHED
	n90cvP16HdYx9cPIJv0YsDsKc5O3MG+0BO6sWnYMCI8PdUO0lwouWkhCRGLPu0V1
	tjOUOlbr0lOIUTt5A6V+Da4aqEsQi2Vnquud9Zwn3oPsvUuI+xJO7VZijZcpzclw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4datc2qg59-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 16:25:20 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 636FtoET018730;
	Mon, 6 Apr 2026 16:25:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dbcyswg82-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Apr 2026 16:25:19 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 636GPHCr27263682
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Apr 2026 16:25:18 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AF19958058;
	Mon,  6 Apr 2026 16:25:17 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DAE6E58057;
	Mon,  6 Apr 2026 16:25:16 +0000 (GMT)
Received: from [9.61.9.165] (unknown [9.61.9.165])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Apr 2026 16:25:16 +0000 (GMT)
Message-ID: <199fafb3-98cb-4ad8-bbb4-22a4149e409d@linux.ibm.com>
Date: Mon, 6 Apr 2026 12:25:16 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] KVM: s390: Introducing kvm_arch_set_irq_inatomic
 fast inject
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260406064419.14384-1-freimuth@linux.ibm.com>
 <20260406064419.14384-4-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260406064419.14384-4-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA2MDE2MCBTYWx0ZWRfXwwsIqtmQlcn5
 w8YKX9RTmlRj2HaDoC8a2cb5pDP/m2u17h8LgSnO64hDQjUUu/ozWrysciNIn7W78lHZcydiEcu
 Ksp77j3xiw4sCLeYF2GWufxSEXaOznd2RKn5k6WC+Y40Jen+TzLE2+bjFR4GWinFeoBdQfnKGkx
 14zM57iVZbw301RkaApMgML48MX7t1R5vuf7AG8+uNlHPqMA20aU6N9S6gf0jzZCqT3x6CraWh6
 HkQzfY2kUF1DtGKBk0v1N9ZfQdsmaJO0E+CXZlf3niKUu+348F0u+2rJfpqDFBXHsmTHTDADyry
 iO8FgQjDdYPScpe8EIWSIet/8BNxn2QTzlOJV4dbZA8dqmCG7C8WG3Am8Up1A+lyXooFCi9p/LW
 GtWSX3AEfyqe7qZB+jN+K464bvBiWB6A5TKm1Ui+csK9Msp5tmgan+r/AKWEuBnF8Avm46hH+qP
 wfm0KbdTdlsrXg5gQqw==
X-Proofpoint-GUID: OuIRqrYXVrJX16u4SeBVO8eTGfBH-YR3
X-Proofpoint-ORIG-GUID: OuIRqrYXVrJX16u4SeBVO8eTGfBH-YR3
X-Authority-Analysis: v=2.4 cv=HJvO14tv c=1 sm=1 tr=0 ts=69d3de70 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=0yhpOta31wJg_WYSZE8A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-06_03,2026-04-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 adultscore=0
 malwarescore=0 spamscore=0 phishscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2604060160


>  
> -static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> -				      unsigned long token)
> +static int __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
> +				     unsigned long token)
>  {
>  	struct kvm_s390_interrupt inti;
>  	struct kvm_s390_irq irq;
> +	struct kvm_s390_interrupt_info *inti_mem;
> +
> +	inti_mem = kzalloc_obj(*inti_mem, GFP_KERNEL_ACCOUNT);
> +	if (!inti_mem)
> +		return -ENOMEM;

You change this function to possibly return this value but you do not
change the callers of this routine to actually look at the new return value?

AFAICT there are 2 callers of this today in arch/s390/kvm/kvm-s390.c - I
assume one or both need updating, otherwise why do we need this change?

>  
>  	if (start_token) {
>  		irq.u.ext.ext_params2 = token;
> @@ -4409,8 +4422,9 @@ static void __kvm_inject_pfault_token(struct kvm_vcpu *vcpu, bool start_token,
>  	} else {
>  		inti.type = KVM_S390_INT_PFAULT_DONE;
>  		inti.parm64 = token;
> -		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti));
> +		WARN_ON_ONCE(kvm_s390_inject_vm(vcpu->kvm, &inti, inti_mem));
>  	}
> +	return true;

Since return value is an integer, return 0?

