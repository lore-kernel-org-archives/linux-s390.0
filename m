Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D76E945A2B7;
	Tue,  4 Aug 2026 13:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785849908; cv=none; b=rojPPzzZ7W71jexo8nGlA2/8eKE4wXPwEyfFr/l98ueAm5LLkflyZWYt76GwF3aVZQxZ3BfsWgiDtP2Hml917gxj0Mxaes4WFcd9Pb/8HtZFCaIDZqjHxUCfH0PB9LYizrGsHIH/orIE7jmYqMWy74QGmhiWrfl5mDFPKvjFCdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785849908; c=relaxed/simple;
	bh=qvUPSrxQ/cSwnshU8PGtRTnmZqE+qRdjMK8VdbsrmHI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=abSIvMwweAZN1WpfgtCSirLq4IZG9dkq5E7aNGSoNm+Sat5yX2bPXQd6hkkHrn7teQYip9njGUMYK/7zG+S3kCi3w7WljgZQhC+SlhhpAHXL2ezhi5pFSDOC5n9OS3/ezxJ6jQVpLqOgteZnEYKbPRuqkxv4tyddAYdrTgdHP4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=j8easyaS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="j8easyaS"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674ClaSn894265;
	Tue, 4 Aug 2026 13:25:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=j3KZQv
	XP2T4O6ROhmJaOFIqs8DmSyqiyYt5vCRdip1A=; b=j8easyaSfIScmEaYXSsat0
	iWXfX4OoCgz9tkRYgB26ETBvEpR3oIDWOPsKJ/ftEt0pJB41/qElCPLSCRVnDhbK
	0W5JBVCOEZ+Bz7iznAposT3hPgWPSzV07b4F+y9C47OLWhtal3lGeUZW+vft0LR0
	hKM/4LTsGI9oEhFylByKV2UTe8rX6BGjfrA2ueogVs4/XyHG4tEPnMKq8U0dNa7O
	vuXUNqLYfp7ldlI7Zbz1M73ZNs7swJ46kxAG7qyCa0dhFGkanv1izZVMbmcXEUoP
	uJx0aaFlFfBUJ9QOp4fdWRKcpYVaNe15AqgvyeIvEFvtgnPZlOFGMOVIRAsoAncQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4x13n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:25:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674DBK0l018123;
	Tue, 4 Aug 2026 13:25:04 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyhv1j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Aug 2026 13:25:04 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674DP3oC33096194
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 13:25:03 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 037BA58051;
	Tue,  4 Aug 2026 13:25:03 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4DBF58060;
	Tue,  4 Aug 2026 13:24:57 +0000 (GMT)
Received: from [9.61.86.222] (unknown [9.61.86.222])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 13:24:57 +0000 (GMT)
Message-ID: <6fb7b1d4-b331-416b-a398-8885a6efdceb@linux.ibm.com>
Date: Tue, 4 Aug 2026 09:24:55 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] KVM: s390: remove user triggerable WARN_ON
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        linux-s390
 <linux-s390@vger.kernel.org>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260804120631.736919-1-borntraeger@linux.ibm.com>
 <20260804120631.736919-2-borntraeger@linux.ibm.com>
From: Matthew Rosato <mjrosato@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260804120631.736919-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfX4nApmo2266jO
 UsNc5tNO9GuMGHhnPdq4nm0IcAKt86ccSm5AR4rYRl0KpFYZRkzKQwT+UtLR73/NuxUCRjuuAqI
 20b6PP9Xfi/WTEknSnNto0OpSoAdyBg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEwNyBTYWx0ZWRfX1AzP48l4HD+w
 ZhiXxC28L9K4jeuJ4SkgLbsaTn/R3qGXK1PNM/+/ZAOtA2MlAXwXsQ84tdJ3AIwSHzXz+d8YBlX
 gQfTfSGoFRwlDkJE+uMNx+tPLy6EcFmwWWZr5N8VZMzypJTbw3N5IpBir4Y0YrMEkSLm0J5h09v
 UHGlSPa9pd/biQMcwDCNn8OxYDk/Gzmg/kJOP29kuao/i5ryEBa/yRKmOeWqaOZDyq7X5LomsO3
 BZkHpWXfp7gK1ySCxqb/d1POkq8VoEj7wKPnwmwO78b/NbqmQfxvVl94HjnIMfi5AsCxjfhLh8c
 1TLaeMVlM2Aj6C+CZbOwFjcGDghg1W4dyknFpkcRg1qxVQOg9g6N9GEA9hbOZUyyYVEruF7NEs3
 LU1WNUXCMkyL1PuFR9lEFrJDrHF116hWvlW6IYGvAYaPoPw+VTDzXKD1R3cG4aQnvjBsKqbyVH8
 64G1QhjAX9qgblPNTGA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a71e830 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=lX-YC4pWN2LiOlmBrIwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: -nIsic6z_--CZb4825WNda0dmFuzwrdX
X-Proofpoint-GUID: -nIsic6z_--CZb4825WNda0dmFuzwrdX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040107

On 8/4/26 8:06 AM, Christian Borntraeger wrote:
> pin_map_page() fails legitimately whenever the userspace mapping behind
> the adapter route has gone away, e.g. when the VMM unmaps that memory.
> As this can happen without a kernel programming error, remove the
> WARN_ON.
> 
> Fixes: 8c0141b7c13c ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
> Cc: Douglas Freimuth <freimuth@linux.ibm.com>
> Cc: Matthew Rosato <mjrosato@linux.ibm.com>
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  arch/s390/kvm/interrupt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 8f24bcd1a6d3..23f0e0821474 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -3013,7 +3013,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>  	if (!summary_info) {
>  		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
> -		if (WARN_ON_ONCE(!summary_page))
> +		if (!summary_page)
>  			return -1;
>  		idx = srcu_read_lock(&kvm->srcu);
>  		map = page_address(summary_page);

