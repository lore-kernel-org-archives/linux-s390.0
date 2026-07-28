Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973E744781A;
	Tue, 28 Jul 2026 14:28:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785248931; cv=none; b=sgm0L6OXAKBWlaKYmPVroh6ecEE4++spCUNN+VBB+U7Y/mtIdefR9Jaz1k5ylRh4HgyjsKNJkg9TOgY0xRc0AybsROqI+R9rCXZjnBcTPiozkOccfI8DnoSqOx2D16LFpXtn8e5qjM98M0QgovU7AIx7reHk9VReFG4lEML9gjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785248931; c=relaxed/simple;
	bh=s++qewmSlGd4YBhexaz5OiohnxxsvIn42mIc2atFuqc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NDWec/7gM7UQS5X2uPQ1yTxyqio8J0uVtnLLiXptPimj4pHT+RihEBYid1DkbuJcwiVxQsbWEIrT62TOH886aAUCX9jM3U8WMGUX8eaH6lETpAeOm4D1+pOVgvm1VLSrECl0KHF7exEealmlJLIJmhhWFggQ5t3ePlVEwZZi6n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PKjOJwo6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PKjOJwo6"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66SDlqR53644599;
	Tue, 28 Jul 2026 14:28:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vQzoLu
	7nQ7+e2DUIm36h6l3pUZbdK91IuK9W0akcb14=; b=PKjOJwo6KZ6kg1NbtLBEmv
	bWH5LqmLj0pcLc8nNriyAy37HH3O6/XTqyq/hscrZkEZv1Vs6jlIj5lA5fxs00IR
	meoAvIYHI5ypDqc/WKtspHOoU2gVeRnD4IBDumcJfmNnlqybS6yzZA1MjGcr/nhs
	eLPSGsrTSWM9x0Rsju1sPA1MEN23SheEPbuq4ZlqWkvTV51nl8/jU8t7lcrkydX6
	pi0qJTqpkvYfIeI0gS2WOJpLpKXgWrhPv+SMxrbAZl3VzCgf7flT0AuBH58LKKf5
	r3JhNUGGgYd7g5iW+bpYG/NTxBakQQ9GdWa7ViV6uR7tDNmO55CSdJ4SU9HcmcVw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycdnmp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:28:46 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SEQHHe005189;
	Tue, 28 Jul 2026 14:28:45 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5y1xug-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jul 2026 14:28:45 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66SESd2j29557044
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 Jul 2026 14:28:39 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 080DD20043;
	Tue, 28 Jul 2026 14:28:39 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C04BA20040;
	Tue, 28 Jul 2026 14:28:38 +0000 (GMT)
Received: from [9.87.138.40] (unknown [9.87.138.40])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 28 Jul 2026 14:28:38 +0000 (GMT)
Message-ID: <1f9d8fb4-3b38-4495-b8f3-cdb51ba1318c@linux.ibm.com>
Date: Tue, 28 Jul 2026 16:28:38 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/10] KVM: s390: Return -EINTR if a signal was pending
 while faulting-in
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260727150254.236021-1-imbrenda@linux.ibm.com>
 <20260727150254.236021-8-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260727150254.236021-8-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: EJwHFcwvyBqXXv8GunrKtp49_4f7RVtk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX8tDCP0MQ6wTH
 1fyFXAwqPexqHKe9570soY+iycBioJrofLaWk1PCHIEfWYBKu89GfB/MJ56AaRg2+omIZMMg5Qt
 kZp6OZXP/HGKWFdUVJ3/vqH+GJnaIQAaiQQiiNGJQJtHlLC1VL8LaXVD/FNH5HjmBdlITRB4FYN
 ADFIFalDCuu25FWzwodVH6w8pzZNitWNeiCqDScb/Ywo2/bUM4Kx9W6d1h/NnrZfXRFFc1lp8I1
 sUzXYc5B4qMUY8bvrXg9BVGc7KkVSMv1Vw01Liia272GR0ktslVvSgeGd8qifmIieLNOpuENMZ6
 Z0zUtbGrFXz1g4+xuURZE0Uw1w6KyTS0aPGttVvvbnuAm8QzpG16Dho4cAoOVavQBozLy/iX3s2
 N7juljQiztNag/6ZAtrm9QfLT9QmhR4leNqefg89ozBV4JLIvWa7OdfXEHvhD27iWzHW+lSAtZG
 t9DkeXIoWg0hqPwmisg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDEyNyBTYWx0ZWRfX2x7M2r7z0Scd
 o64wDKS79F6rYj1279q3rEG3hDce7wotS/DTii01l+BCQMUKmTWEM67KIX6GfaUCSURSstJbfLz
 rZYMBkf3pejCgRy7Z+lD2IsHycpT2ms=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a68bc9e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=vc5uE6uYo8RvJNRDSLcA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: EJwHFcwvyBqXXv8GunrKtp49_4f7RVtk
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_03,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280127

On 7/27/26 17:02, Claudio Imbrenda wrote:
> If a signal is pending while trying to fault-in a page, return -EINTR
> instead of -EAGAIN.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Fixes: e907ae530133 ("KVM: s390: Add helper functions for fault handling")
> ---
>   arch/s390/kvm/faultin.c   |  4 ++--
>   arch/s390/kvm/intercept.c | 18 ++++++++----------
>   arch/s390/kvm/pv.c        |  2 +-
>   3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/s390/kvm/faultin.c b/arch/s390/kvm/faultin.c
> index fee80047bd94..4ff4c5970956 100644
> --- a/arch/s390/kvm/faultin.c
> +++ b/arch/s390/kvm/faultin.c
> @@ -92,8 +92,8 @@ int kvm_s390_faultin_gfn(struct kvm_vcpu *vcpu, struct kvm *kvm, struct guest_fa
>   		if (is_noslot_pfn(f->pfn))
>   			return PGM_ADDRESSING;
>   		/* Signal pending: try again. */
> -		if (f->pfn == KVM_PFN_ERR_SIGPENDING)
> -			return -EAGAIN;
> +		if (is_sigpending_pfn(f->pfn))
> +			return -EINTR;
>   		/* Check if it's read-only memory; don't try to actually handle that case. */
>   		if (f->pfn == KVM_PFN_ERR_RO_FAULT)
>   			return -EOPNOTSUPP;

The code above is what I'd expect from the description but there's more 
code in this patch. Are we fixing multiple things?


> diff --git a/arch/s390/kvm/intercept.c b/arch/s390/kvm/intercept.c
> index 1980df61ef30..08f2128db147 100644
> --- a/arch/s390/kvm/intercept.c
> +++ b/arch/s390/kvm/intercept.c
> @@ -369,27 +369,25 @@ static int handle_mvpg_pei(struct kvm_vcpu *vcpu)
>   	if (rc)
>   		return kvm_s390_inject_prog_cond(vcpu, rc);
>   
> -	do {
> -		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
> -	} while (rc == -EAGAIN);
> -	if (rc)
> -		return rc;
> -
> -	/* Ensure that the source is paged-in, no actual access -> no key checking */
> +	/* Ensure that the destination is paged-in, no actual access -> no key checking */
>   	rc = guest_translate_address_with_key(vcpu, vcpu->run->s.regs.gprs[reg1],
>   					      reg1, &dstaddr, GACC_STORE, 0);
>   	if (rc)
>   		return kvm_s390_inject_prog_cond(vcpu, rc);
>   
> +	kvm_s390_retry_instr(vcpu);
> +
>   	do {
> -		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
> +		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(srcaddr), false);
>   	} while (rc == -EAGAIN);
>   	if (rc)
>   		return rc;
>   
> -	kvm_s390_retry_instr(vcpu);
> +	do {
> +		rc = kvm_s390_faultin_gfn_simple(vcpu, NULL, gpa_to_gfn(dstaddr), true);
> +	} while (rc == -EAGAIN);
>   
> -	return 0;
> +	return rc;
>   }
>   
>   static int handle_partial_execution(struct kvm_vcpu *vcpu)
> diff --git a/arch/s390/kvm/pv.c b/arch/s390/kvm/pv.c
> index 1beacc841ca8..dc204b521052 100644
> --- a/arch/s390/kvm/pv.c
> +++ b/arch/s390/kvm/pv.c
> @@ -809,7 +809,7 @@ static int unpack_one(struct kvm *kvm, unsigned long addr, u64 tweak,
>   			return -EAGAIN;
>   	}
>   
> -	if (ret && ret != -EAGAIN)
> +	if (ret && ret != -EAGAIN && ret != -EINTR)
>   		KVM_UV_EVENT(kvm, 3, "PROTVIRT VM UNPACK: failed addr %llx with rc %x rrc %x",
>   			     uvcb.gaddr, *rc, *rrc);
>   	return ret;

