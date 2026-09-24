Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81081254B03;
	Thu, 24 Sep 2026 12:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790253984; cv=none; b=ZI7/yWQyfVIPttHWsKm5eeJ0Q4n4IAE4xgdkP4q3cdOkweIB3osFYF/OPCIxa2tl8bjL2DzIlhMZZYyC5gYSpPLhIXgPnTPnBlRn+4OA/t/qMhHJDT1po/d4+QTT1R0Ft5v2mlib4AEebh/caKEHeXem096E6blJJuKQFu48zRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790253984; c=relaxed/simple;
	bh=woPiFzpOJ0G566NXe1D6gTY4O9zvGoaqRizHF7K/zG4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ml+Sh/HrRRmm8oV4fnBhirfpOUjudW+YQY54IT7yE1BBY7pOgUKCYBtYFXjpLVEvHQbyKMcT3Up6J26Dz9aSExr61MqgRXcBSMMhoaZ1y3UAu+tUPwW0yGr0r3ss8Pb1RM0a0SXPSa1ri+yk3Iz25qF7++B+UIuk/A8SW73J34k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mgIrcEHF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mgIrcEHF"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC637G2182984;
	Thu, 24 Sep 2026 12:46:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Kr1DIt
	6Ri1+aennY4JTGAwtlFkIygFdN74drYrU054Y=; b=mgIrcEHFc7FALmOwG4Q/VI
	Gw71TEDOCxHpOPB1f8A6mxLi9/kIAb6P0Km+Yo3PsQE5AEaPfsN6HgpZFPF70szS
	cvrDYRnU7GNQ8NY09aQhR4vvv5MXBBpSoJULvk0WhK7wJQY5VTrgDnvDhqboES01
	7oiQIhhqT4tE+G5D26jLBWSdrc5Qn+ENM8p0k9+agDo05U8pPaxmU37dzHbdF4sV
	pt2FX5YPVAN/I0lJbccktNoIdxurfN7bkc116qCLOxOOfiGRIO9dHsaFhLgltA06
	5vXSvVNcvDy2aIHJ/QDNRkTAdFAPm31r1XKg+QFPfZkOrgvbRMr4TqgnDbWF/zrg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsh239-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:46:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHYJV2060501;
	Thu, 24 Sep 2026 12:46:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qnsty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:46:18 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OCkEPA39321980
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 12:46:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A94932004D;
	Thu, 24 Sep 2026 12:46:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4D27F2004B;
	Thu, 24 Sep 2026 12:46:14 +0000 (GMT)
Received: from [9.111.22.143] (unknown [9.111.22.143])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 24 Sep 2026 12:46:14 +0000 (GMT)
Message-ID: <9ea2d72c-279a-4ab6-b2b8-9392f070a3b9@linux.ibm.com>
Date: Thu, 24 Sep 2026 14:46:14 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 14/21] KVM: s390: vsie: Add helper to pin and unpin
 multiple guest pages
To: Christoph Schlameuss <schlameuss@linux.ibm.com>, kvm@vger.kernel.org,
        linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Eric Farman <farman@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Nico Boehr <nrb@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, Sean Christopherson <seanjc@google.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-14-f39806eaae37@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260918-vsie-sigpi-v7-14-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab51b9b cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=-ZQdvhKmTahj40bXq3EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: yxcCaiAY_VP1hxeDCzN291mhdm1Aq_Mr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfX3rzU2v9zZsva
 ckI+uXfHpapuObKJ3LmjsNibVxvp/0pl2shNDqJoZUpwDVuzGt2o6FHtVcs/LavblZcKsDzs69W
 KlfLqwRyKuZ6shOsEU3yaXAnZ+xhQNWwmSXOS2mvPi36imnFHL7qpDVOPz/8ttHTg7EGCCNp1dm
 0dhSvYPPYQrrhkKSoM97YN3rUWz1LIUKvnWmXPub0wG0F1dAOklwi1oIv7K8BFCfw4vIQcBQog7
 0mnP1bjngAQu1wA2WTogiGdljGZCqMaoeyiXAi384aTdP17ySQPXeSRyZAJ+S46YOo/1/DjDe09
 LQbOnyGIuv06ynEiRlDx2BzP6GmrCDmWVmSXNTIDe2srI81GseL+tLNOIKE4fhvLd4zYbK85HqW
 Fx1Oz0F72+ANiRfcQC2aDlCWvjo5I0jJL7unOUcLJrHEBoAE2zGol8stjF9MEBGwSNNozBITzDl
 LJRIubA3DoGBCfyZaiw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfXxygBcKvK781o
 SNR0gdAjO8wwXwdueIWAiHzF3Rc/McdVwbN842D7LwAHtRhvI+jzitwR4NgCeVNAaREiI+uxDk0
 kPv0PYefdA/wH/gVM/15wOyLKa2y7co=
X-Proofpoint-GUID: eaXrEOa_2hl_W48CdbEi2qTbeybgO7aB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240052

On 9/18/26 5:09 PM, Christoph Schlameuss wrote:
> To handle vSIE configurations with an ssca we need to pin and unpin
> multiple consecutive guest-2 pages in guest-1. As these might not be
> consecutive in guest-1 it is necessary to iterate over all pages and
> store guest and host addresses for later use.
> 
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>
> ---
>   arch/s390/kvm/s390/vsie.c | 45 +++++++++++++++++++++++++++++++++++++++++++++
>   1 file changed, 45 insertions(+)
> 
> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 1b88470efd4a..fa43b6c46bbb 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c
> @@ -71,6 +71,11 @@ static_assert(sizeof(struct vsie_page) == PAGE_SIZE);
>   static_assert(offsetof(struct vsie_page, mcck_info) == offsetof(struct sie_page, mcck_info));
>   static_assert(IS_ALIGNED(offsetof(struct vsie_page, crycb), 8));
>   
> +struct kvm_address_pair {
> +	gpa_t gpa;
> +	hpa_t hpa;
> +};
> +
>   static inline bool sie_uses_esca(struct kvm_s390_sie_block *scb)
>   {
>   	return (scb->ecb2 & ECB2_ESCA);
> @@ -251,6 +256,46 @@ static void unpin_guest_page(struct kvm *kvm, gpa_t gpa, hpa_t hpa)
>   	mark_page_dirty(kvm, gpa_to_gfn(gpa));
>   }
>   
> +/* unpin multiple guest pages pinned with pin_guest_pages() */
> +static void unpin_guest_pages(struct kvm *kvm, struct kvm_address_pair *addr, unsigned int nr_pages)
> +{
> +	int i;
> +
> +	for (i = 0; i < nr_pages; i++) {
> +		unpin_guest_page(kvm, addr[i].gpa, addr[i].hpa);
> +		addr[i].gpa = 0;
> +		addr[i].hpa = 0;
> +	}
> +}
> +
> +/*
> + * pin nr_pages consecutive guest pages
> + */

Why is this multi line?

> +static int pin_guest_pages(struct kvm *kvm, gpa_t gpa, unsigned int nr_pages,
> +			   struct kvm_address_pair *addr, unsigned int *nr_pages_pinned)
> +{

s/addr/addrs/ ?
Same for unpin?

> +	int rc = 0, i;
> +	hpa_t hpa;
> +
> +	gpa = gpa & PAGE_MASK;
> +
> +	/* the guest pages may not be mapped continuously, so pin each page */
> +	for (i = 0; i < nr_pages; i++) {
> +		rc = pin_guest_page(kvm, gpa + PAGE_SIZE * i, &hpa);
> +		if (rc)
> +			goto err;

There's no reason for the goto, is there?
If not, please inline the err label.


Apart from these nits the patch looks fine.

> +		addr[i].gpa = gpa + PAGE_SIZE * i;
> +		addr[i].hpa = hpa;
> +	}
> +	*nr_pages_pinned = i;
> +	return rc;
> +
> +err:
> +	unpin_guest_pages(kvm, addr, i);
> +	*nr_pages_pinned = 0;
> +	return rc;
> +}
> +
>   /* copy the updated intervention request bits into the shadow scb */
>   static void update_intervention_requests(struct vsie_page *vsie_page)
>   {
> 

