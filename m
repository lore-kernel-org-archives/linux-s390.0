Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014114B2032;
	Fri, 25 Sep 2026 15:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790351739; cv=none; b=Mkr10HN9Sd9l30UZVAiU275m2M9BTsgyeZKT1sKJW8CYZBW2NJsXiha3VLrOKiuOGdsttdCo0q+TieUZxG/g9PFxi+v3Fmi6+c/BSAo9dlfZpB55MdbOcUFbC9jyyX4rGP+XqFHgrGcnlGqSwZjiknGcu/NI5ayy+Naooyv6Kc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790351739; c=relaxed/simple;
	bh=FUAnOnL6V10jOSR7OshyaGIs9GfhtiKG//E1rNMcSZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QNlc4wCNk0qnTdkwzElucIJ77QqTK1swPHMxXBHJbR02rWetM4c0kumPi6/vzziZI31JgBAiVzKVDXwIJsHwNmi6l8kRkju+kUsQWLKVkGwZHB6+yx6B9Zs01LAUSflKW1CeKh9h5kfo5BH1T34j5h3T/m1a02HTX00lbtv/2g0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oyn1KGeD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oyn1KGeD"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68P4Zm8R060711;
	Fri, 25 Sep 2026 15:55:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=jR6Cn4
	++J2tNuS7Ui51d1lp51EcBHBFL9CZMmeD+oIY=; b=oyn1KGeD+/laB0hjnHF8da
	+iRQMmBPleiVv4iNuZlal5GwhjApYecjN30OwhrC63t+9R9kUl6iLK5ClpCHkH4x
	+WcTuhbJLwGGikOlqM3Z6cyHOL3nn+Oi8e4qp4NPPWTLK1SUIswWs1p6fZmTV9bV
	8jXtTyCxgvRkV6INtkA5z8RiDIsnxgDl1+2RdTQgNn+Km8t1pRR+OBwbr41utwfE
	tIdKiAi10OZkeAwWTu0MqNUh5td7wYiILxoN6T3l6QTgkTvulbxECGU0RZEG81Ou
	CdOhM+Fw2qCk3xkk0TbwO2g7ABkpv6FOyvTw2YUuhGnfpjTRTF3pNDVVVd1CYh0w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskgsqunn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:55:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68PF0ArA3296991;
	Fri, 25 Sep 2026 15:55:35 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qu14r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Sep 2026 15:55:34 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68PFtXJS3474032
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 25 Sep 2026 15:55:33 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 278425806A;
	Fri, 25 Sep 2026 15:55:33 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 883A05805D;
	Fri, 25 Sep 2026 15:55:32 +0000 (GMT)
Received: from [9.61.86.59] (unknown [9.61.86.59])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 25 Sep 2026 15:55:32 +0000 (GMT)
Message-ID: <42ebe5ed-e37e-4d6b-b6a6-defc87fc83ef@linux.ibm.com>
Date: Fri, 25 Sep 2026 11:55:32 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 6/6] s390/vfio-ap: replace guest-reachable WARNs with
 ratelimited warnings
To: sashiko-reviews@lists.linux.dev
Cc: Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, kvm@vger.kernel.org,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260925124551.665448-1-akrowiak@linux.ibm.com>
 <20260925124551.665448-7-akrowiak@linux.ibm.com>
 <20260925125953.DAFAA1F00893@smtp.kernel.org>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260925125953.DAFAA1F00893@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=V/XoQuni c=1 sm=1 tr=0 ts=6ab69977 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=QwavuRJzDsQgA1XNSssA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: lysq3Pril2m63OGKxGXi7hvxJR5Wi23s
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX+3Of+1LeVa84
 uuFBp6YUmv6iNFaG/jOt7svD4AeWWMvqfe58B4q2BXByL/svap8YX1HjAX5B6qmrirUJXf58Vj2
 yOr7s/6Zl5zrtwuPMkI57U5kLvwvb/Qo/d3ipZyo3iQuBXW3x8Vky30Kx7Up05kKHzyOfyEyspx
 7hIhF9Yle0JSzsgWpty+PNkx0mXiMrn0Wgvb67u4FUTlwagjnLRlOhuO5fvNUyABe1TPiPLpBcY
 1+styakE3HNVid4g99SWdJCMaquPuvyJyM3zoh2yXS/SSwKY/t4TIoFQ6xnCieZbQiaYWdeUCbI
 82I8w476hVLmkcpH+By8QYbkOwoZScPs4Ao6cMqSe+4T7m5ZoX/vjVVQKht5q83BVDkKuqQ8Tpx
 kY6jZLmjWlZYYSParimYNa77gVJ5JaJWbrLdsvBNnGpiy5/2YH3QmN2D3VMU+Fpl9+9ZNMM+A9N
 IuBdmOKp9O6V1+gVeCQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2MiBTYWx0ZWRfX9auDYpMMuDjy
 fDiNqAoCZ5HybGQCwJ0BfXrb+6bPvKDz9tugQ+XNA4HmbUTV8EwQ+JlmLWAr4+aWOc4P52BqAEA
 AfI8qJ47wFKff8DGy4lTpCZI3GsFqRA=
X-Proofpoint-GUID: lysq3Pril2m63OGKxGXi7hvxJR5Wi23s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 malwarescore=0 clxscore=1015 phishscore=0
 bulkscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250062



On 9/25/26 8:59 AM, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> - [High] s390/vfio-ap: NULL pointer deref in vfio_ap_free_aqic_resources()
> - [Low] s390/vfio-ap: format specifiers truncate DMA addr and corrupt log
> --
>
> commit bb0d1a9a828269662641d7a1b6f445a55a9d0e1d
> Author: Anthony Krowiak <akrowiak@linux.ibm.com>
>
> s390/vfio-ap: replace guest-reachable WARNs with ratelimited warnings
>
> WARN and WARN_ONCE macros in code paths reachable by a guest
> can be triggered repeatedly by a malicious or misbehaving guest,
> flooding the kernel log and potentially impacting system
> stability. Replace all WARN and WARN_ONCE calls reachable from
> the guest AP interrupt enable/disable and queue reset paths with
> ratelimited warning functions.
>
>> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
>> index cd4a436c43194..4b6e64daed253 100644
>> --- a/drivers/s390/crypto/vfio_ap_ops.c
>> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> [ ... ]
>> +static void report_gisc_unregister_failure(struct vfio_ap_queue *q)
>> +{
>> +	if (q->matrix_mdev) {
>> +		dev_warn_ratelimited(mdev_dev(q->matrix_mdev->mdev),
>> +				     "APQN %02x.%04x: Failed to unregister guest ISC %c\n",
>> +				     AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>> +				     q->saved_isc);
> [Severity: Low]
> Could this result in missing or mangled information in the kernel log?
> The guest ISC is printed using %c, which will output a non-printable ASCII
> character for the numeric value, rather than the integer itself.

Will change to %d

>
>> +	} else {
>> +		pr_warn_ratelimited("APQN %02x.%04x: Failed to unregister guest ISC %c\n",
>> +				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>> +				    q->saved_isc);
>> +	}
>> +}

Same here

>> +
>> +static bool verify_free_aqic_resourcers(struct vfio_ap_queue *q)
>> +{
>> +	bool verified = true;
>> +
>> +	if (q->saved_isc != VFIO_AP_ISC_INVALID &&
>> +	    !(q->matrix_mdev && q->matrix_mdev->kvm)) {
>> +		report_gisc_unregister_failure(q);
>> +		verified = false;
>> +	}
>> +
>> +	if (q->saved_iova && !q->matrix_mdev) {
>> +		pr_warn_ratelimited("APQN %02x.%04x: Failed to unpin NIB page %08x\n",
>> +				    AP_QID_CARD(q->apqn), AP_QID_QUEUE(q->apqn),
>> +				    q->saved_iova);
> [Severity: Low]
> Does this truncate the logged DMA address? q->saved_iova is a 64-bit
> dma_addr_t, but it's being printed with a 32-bit format specifier %08x.

Will change to %pad

>
>> +		verified = false;
>> +	}
>> +
>> +	return verified;
>> +}
>> +
>>   /**
>>    * vfio_ap_free_aqic_resources - free vfio_ap_queue resources
>>    * @q: The vfio_ap_queue
>> @@ -316,17 +398,13 @@ static int vfio_ap_wait_for_irqclear(int apqn, struct ap_queue_status *tapq_stat
>>    */
>>   static void vfio_ap_free_aqic_resources(struct vfio_ap_queue *q)
>>   {
>> -	if (!q)
>> +	if (!q || !verify_free_aqic_resourcers(q))
>>   		return;
>> -	if (q->saved_isc != VFIO_AP_ISC_INVALID &&
>> -	    !WARN_ON(!(q->matrix_mdev && q->matrix_mdev->kvm))) {
>> -		kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
>> -		q->saved_isc = VFIO_AP_ISC_INVALID;
>> -	}
>> -	if (q->saved_iova && !WARN_ON(!q->matrix_mdev)) {
>> -		vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
>> -		q->saved_iova = 0;
>> -	}
>> +
>> +	kvm_s390_gisc_unregister(q->matrix_mdev->kvm, q->saved_isc);
>> +	q->saved_isc = VFIO_AP_ISC_INVALID;
>> +	vfio_unpin_pages(&q->matrix_mdev->vdev, q->saved_iova, 1);
>> +	q->saved_iova = 0;
>>   }
> [Severity: High]
> Can this lead to a NULL pointer dereference or a memory leak?
>
> In verify_free_aqic_resourcers(), the logic couples the validation of the two
> independent resources. If both resources are empty (q->saved_isc ==
> VFIO_AP_ISC_INVALID and q->saved_iova == 0), the function returns true. If
> q->matrix_mdev is NULL, vfio_ap_free_aqic_resources() will then unconditionally
> dereference q->matrix_mdev->kvm, resulting in a kernel panic. This path can be
> reached when an unbound queue is removed from the host AP configuration.
>
> Additionally, if only one resource fails validation (e.g., kvm is NULL),
> verify_free_aqic_resourcers() returns false, which skips the cleanup entirely.
> This prevents the NIB page from being unpinned, leaking the memory.

Getting rid of verify_free_aqic_resourcers() and doing the checking in 
vfio_ap_free_aqic_resources() with a fix that eliminates the NULL 
dereference.
>

