Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E10DB371890;
	Mon, 18 May 2026 11:54:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779105263; cv=none; b=bNElJCi70xnQYB57340r1ocixBD4QrF/GfVQKfWdrekABuP+T5chRDlV6s+8hDqOMVvtmr+iHpJ/rCXmKqjYsz2o+t64qy2DKXYj5O0WzcK5FUTQ6RDdbnA9wYFQj4/EiWjn3RiOHklPNMq0R4AsXN96UovW6fKS0Ht5kecD++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779105263; c=relaxed/simple;
	bh=XqvnvXs2Q7MLNIoxLceTcnZzRpVIuY210zH4bSuCqXc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EwEB/q7dYpNZ8j3eIkCfCz+MnmsblxYmMMXZXFrS6u342iS2lWEwkOxs7HHmLjID1+X9K3OawzM7Tc4DgC/LDe9q755LMUgfi30qN/fVtxTQ0PdwYzp98/nY299wB2Edlk1LBWPGG4zLYROk/sm7AXyhInq27e1c0/HW8hZ8S2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=FP6BR+DY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="FP6BR+DY"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I6DbvP470901;
	Mon, 18 May 2026 11:54:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=qp9DDs
	oMvuTid6kv29Cp9an5NHTiU01Zc1n+hur3vQA=; b=FP6BR+DY1Zp4bShA9ZbsIH
	OWTDC7VJnqFLEUBdzczOcxpI7tkEOTSTzLijG7PyB2ezHxYUX7qSbDOqNe0ozWjH
	0hzrhhYSgb/Ft1KphpEz6AD6oSl7YDmMZ3ipE0HxA6xc9M6bjKaW5+2/qeti1lTJ
	h2nACXzqjA4uM/L5dB03TKndkFxUpIxMI+sGRLEjIlGRDwK0lbwubp1c6ciDWB0Y
	NGReyHVRY3+DudbGgjk/S3Lqb2/jZrllMtBbvx05GE4wLxC3V7bFag97oHoqpO7S
	eCyXnTXWvvjdWJgX7j/4amZ7mmkKl4OyUkeZeBFrqLXz4s7oNoyu+GhxN1WUu7vg
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h887cjm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:54:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBs9lM016751;
	Mon, 18 May 2026 11:54:17 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754g5gb7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:54:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IBsEat44630338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 11:54:14 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 598E520063;
	Mon, 18 May 2026 11:54:14 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 247002004F;
	Mon, 18 May 2026 11:54:14 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 11:54:14 +0000 (GMT)
Message-ID: <3bfd73df-3107-435f-953c-80b6bed4b1f8@de.ibm.com>
Date: Mon, 18 May 2026 13:54:13 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] KVM: s390: vsie: Fix redundant rmap entries
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-5-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260512175251.300882-5-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: BkXU29UYvMSZcp9K8EZ2BGm8I_5Y0odV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMiBTYWx0ZWRfXxxPEPX5u0Mbt
 S9EyOlU8u73DdaSl90RmeqlCjdtfiN34xwXmowa/4wbtGlAtlSGgdbgl2JT48PNiUEwOZv9UCoH
 EQJvtJi1BRuEVRu7yUM8L9yYpkODVHgrH+/fFpoEEqe5g1NWnwFUUVXcW4AP7RiI9z95qiLfLRO
 O0C4A0aKl67J/Kwaqa6TrDK8SajaG976FgGLqaYPBFsI6AwTQLYdFklC1w7CyfxDIrROGzJ6Zrd
 IvHY76Fp9RPkYeSvVfrQ11bW4P0y0nM4gKdUePYxW+Tn8MrM678y6VbfWT0dhMGssuA0JXAdlJh
 duV00UYVxzEm5poE4FJPzRAINq2iWB7KkpRFTkL0XD/HzOcsCFL4m2s7VQpbnzGaC2KPZt7/QjU
 5PCXyFBy+eYx6ASLnWqzl9z1AwHyMCtPMiTzROgSeuB3PKnrhZjsaUdblf7mREvZkn9l7D6BvAU
 77KxesfwWhm6PDrKu/g==
X-Proofpoint-GUID: BkXU29UYvMSZcp9K8EZ2BGm8I_5Y0odV
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0afdea cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=jY1TkyeXnooduRb_QtMA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180112

Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> The address passed to the gmap rmap was not being masked. As a
> consequence several different (but functionally equivalent) rmap
> entries were being created for each shadowed table.
> 
> Fix this by properly masking the address depending on the table level.
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/gmap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 8cff0cf5ce24..957126ab991c 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1025,6 +1025,7 @@ int gmap_insert_rmap(struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn, int level)
>   int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gfn, gfn_t r_gfn,
>   		      kvm_pfn_t pfn, int level, bool wr)
>   {
> +	unsigned long bitmask;
>   	union crste *crstep;
>   	union pgste pgste;
>   	union pte *ptep;
> @@ -1041,8 +1042,9 @@ int gmap_protect_rmap(struct kvm_s390_mmu_cache *mc, struct gmap *sg, gfn_t p_gf
>   	if (rc)
>   		return rc;
>   	if (level <= TABLE_TYPE_REGION1) {
> +		bitmask = -1UL << (8 + 11 * level);
>   		scoped_guard(spinlock, &sg->host_to_rmap_lock)
> -			rc = gmap_insert_rmap(sg, p_gfn, r_gfn, level);
> +			rc = gmap_insert_rmap(sg, p_gfn, r_gfn & bitmask, level);
>   	}
>   	if (rc)
>   		return rc;

