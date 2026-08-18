Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10B3937D100;
	Tue, 18 Aug 2026 20:44:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787085847; cv=none; b=RJ2EGNqnYEfLmDidlTdnCBuwRojyh7cMfYG224dl9E3cH1cHOGpX7z2ZjO39cBmYaSjZqB4zhiiqyHcVtKIr+c9qourw/XEb0/0X8n5eUaTEqmSsHR9jRdKV9PwqydRmIDzR9einZqu2pp4ipL2et3dAMPjiayj3wkjPotz5Xfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787085847; c=relaxed/simple;
	bh=Z7ZlvHNN+uT/g3W2zJOSvlcAMzmx2DLJ1ORjKL5kCOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ph0uoiO81kvOCdQihZgGI/kiJMOWw6iYN/LLWA5C57uvRZgrTjC+mhY2RC1F0gJdpMwsSntfQbf+U/EPtZs4jhMfZ1U3rZe9E2tCTwERMjOp7xAjHjW1euVLWdNynUzjnXKF5eJWXBya43UQmEBbyTiQAYpHka8kgMMITWJ/eYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ktNhVOU9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ktNhVOU9"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJVu0L1210575;
	Tue, 18 Aug 2026 20:44:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=erZ8hz
	bT+OBjVmZlnoqX5tGmnaNkahSolE0j2rhpxmw=; b=ktNhVOU9Bsdh2nBqwZqF0L
	pSCtg2XuL2bWAUdP6yh89tR/GY9uItW/EYdWlK5uKt8LM6vHsLjNnLqxdcanW8mt
	SRsNL7wGDrNmOTYYXVBEMMGS5PJYkexeEu7RODWBroXA4w1iUi5tHDL4Knv9R5z3
	JtElQIewmFw8SRSqXbSU8st+VmjVqpGn6NsQzGzZVWfq3IhZy6VEhhYyIax/dkUL
	5+39FC3tbee7SNcAwq7bg0VTUeuRNNmVrHBToga2VlprdI8r6J/Fzo0Py8+CFt7q
	Z92GpHHt878nKBWF28k//W6YpluU0Tjop8WBIUSPY1C+36PmmMLZuBCzczl6DKMw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fm3tu06-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:44:03 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKfNDD012492;
	Tue, 18 Aug 2026 20:44:02 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33xh5c5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:44:02 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IKhLtS50463092
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 20:43:21 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503355805F;
	Tue, 18 Aug 2026 20:44:00 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C82C5805A;
	Tue, 18 Aug 2026 20:43:59 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 20:43:59 +0000 (GMT)
Message-ID: <f3fce9e7-f59e-4cdf-861a-83ca44d3bc68@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:43:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com,
        Douglas Freimuth <freimuth@linux.ibm.com>
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: PyrFmRkyfLPw6O-RdWhFK_UM6cRx4yiM
X-Proofpoint-ORIG-GUID: PyrFmRkyfLPw6O-RdWhFK_UM6cRx4yiM
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfX40fVJWPjNk+u
 05agxNXaFIY0yKyKApAFp8jakFi+YLo3tplfsoed4V5JTE6kLMu4sPr3FfNLb6ROVF5dEcogFnJ
 07KXE4wCP1ZulokhrUdtRKEkN7i/1iY=
X-Authority-Analysis: v=2.4 cv=WtQb99fv c=1 sm=1 tr=0 ts=6a84c413 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=3qhqli0Z9PzkQMhm4CIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE1MCBTYWx0ZWRfXxLDFDT4bBSox
 yifcbJZn2w/45O71PM/o2MG2toNhHjxEzJiSY1PYpjA2Q9oa6i6C0eQKcyr/KviLiVvKEm7E9MA
 lwkFOAoCQHTn2HFh8vSvoEfkHPGVrYlJlYSlQzS9rll40YXcG7LOA3utdZSC4XdooXbuY2UcxAJ
 khOl73r27ySULXfD0yHhGHoqHbA9wgigKkSXe80E0PQqRvPeOteSNtkEH3PLtS9umatixWtcpts
 aLkJSujOLx+u8FN+E7UcJlDR1hSNLXZUilXH+nuffrkSiBZnY66X0Uz6xGXW5kkSe/zN69NPjE5
 lClMfEHmGUyyGWG6jW6MjHhdf3+b2vKV6EbQJsPURg0+0fEQbW5or8821p064veeIdKR+pOdFr5
 SUxlvfXnbZntPrKe4R1d/1sih7/noESKgUv2doG+YBreAKOndI+/O/uJB8qlmDXJ9MjtSc5vXlv
 laYJYHk6AVCOzwrQc6A==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 priorityscore=1501
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608180150

On 8/14/26 12:33 PM, Claudio Imbrenda wrote:
> When the indicator and/or summary bits are set in the guest, the
> accessed page was only marked dirty in KVM if the access was performed
> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
> fast inject path would not mark the page as dirty.
> 
> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
> for the inatomic path set_page_dirty{,_lock}() is not needed as the
> page stays pinned; the unpin path correctly marks it as dirty.
> 
> Opportunistically reorder the local variables to be in reverse
> Christmas tree order and refactor to use guard().
> 
> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

The code itself looks good to me:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

Doug, can you please test (w/ lockdep enabled)?

Thanks,
Matt

> ---
>  arch/s390/kvm/interrupt.c | 40 ++++++++++++++++++++-------------------
>  1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index da740a378a8c..fc4d1f8193d9 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2984,12 +2984,14 @@ static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {
> -	unsigned long bit;
> -	int summary_set, idx;
>  	struct s390_map_info *ind_info, *summary_info;
> -	void *map;
>  	struct page *ind_page, *summary_page;
>  	unsigned long flags;
> +	unsigned long bit;
> +	int summary_set;
> +	void *map;
> +
> +	guard(srcu)(&kvm->srcu);
>  
>  	ind_page = NULL;
>  
> @@ -3000,14 +3002,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
>  		if (!ind_page)
>  			return -1;
> -		idx = srcu_read_lock(&kvm->srcu);
>  		map = page_address(ind_page);
>  		bit = get_ind_bit(adapter_int->ind_addr,
>  				  adapter_int->ind_offset, adapter->swap);
>  		set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
>  		set_page_dirty_lock(ind_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
>  		unpin_user_page(ind_page);
>  	} else {
>  		map = page_address(ind_info->page);
> @@ -3015,6 +3014,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		set_bit(bit, map);
>  		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
>  
>  	spin_lock_irqsave(&adapter->maps_lock, flags);
>  	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> @@ -3023,14 +3023,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
>  		if (!summary_page)
>  			return -1;
> -		idx = srcu_read_lock(&kvm->srcu);
>  		map = page_address(summary_page);
>  		bit = get_ind_bit(adapter_int->summary_addr,
>  				  adapter_int->summary_offset, adapter->swap);
>  		summary_set = test_and_set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
>  		set_page_dirty_lock(summary_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
>  		unpin_user_page(summary_page);
>  	} else {
>  		map = page_address(summary_info->page);
> @@ -3039,6 +3036,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>  		summary_set = test_and_set_bit(bit, map);
>  		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
>  
>  	return summary_set ? 0 : 1;
>  }
> @@ -3048,26 +3046,29 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>  				       struct kvm_s390_adapter_int *adapter_int,
>  				       int setbit)
>  {
> +	struct s390_map_info *ind_info, *summary_info;
>  	unsigned long bit;
>  	int summary_set;
> -	struct s390_map_info *ind_info, *summary_info;
>  	void *map;
>  
> -	spin_lock(&adapter->maps_lock);
> +	guard(srcu)(&kvm->srcu);
> +	guard(spinlock)(&adapter->maps_lock);
> +
>  	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> -	if (!ind_info) {
> -		spin_unlock(&adapter->maps_lock);
> +	if (!ind_info)
>  		return -EWOULDBLOCK;
> -	}
> +
>  	map = page_address(ind_info->page);
>  	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> -	if (setbit)
> +	if (setbit) {
>  		set_bit(bit, map);
> +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> +	}
> +
>  	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> -	if (!summary_info) {
> -		spin_unlock(&adapter->maps_lock);
> +	if (!summary_info)
>  		return -EWOULDBLOCK;
> -	}
> +
>  	map = page_address(summary_info->page);
>  	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
>  			  adapter->swap);
> @@ -3077,7 +3078,8 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>  		summary_set = test_and_set_bit(bit, map);
>  	else
>  		summary_set = test_and_clear_bit(bit, map);
> -	spin_unlock(&adapter->maps_lock);
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
> +
>  	return summary_set ? 0 : 1;
>  }
>  

