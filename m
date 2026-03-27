Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A9583126C0;
	Fri, 27 Mar 2026 15:25:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774625142; cv=none; b=WdjU0UQzbt48UgT94Fut0shWbprh4LUASXdDcgPt7uguO9LQcL2y43ibhLjPNyyJCWAAN3+wJTqw1ciitR/tuBzMNi8eCe0eJ2KI78K1v+VF09nnx0NRA9yNdIU9Y8krSH4RvkXKH9L2sHcyqjc3L8MpXrbfEUumphBjWiFVd5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774625142; c=relaxed/simple;
	bh=4U/fd6fhNMgzcVA5cmddCzc7TUPWHQTNJpAhIX7QpgA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=B9IsS5DyFMLZ7TCPWfREj2CpO8Snocj4MpaD27CuYLa2LvZACcauF2RdOuNOu1VJxw8fgTuru61IYhs1V9CLzZ3NCxW2wibtFbDvuU2vwCLw167rXo+dUfa8dNBzBPhcE/0LWGmVPofLguzpQ9CCGBc2brPwmlCUp66dFX26iko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eLglGArs; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eLglGArs"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62R5P9aw1455972;
	Fri, 27 Mar 2026 15:25:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=XMEsHc
	MXBwEoKrlIoViTNfyyOE1xLg3h7GeVsBXaZ/A=; b=eLglGArswzZgFjuEEY0SLu
	9xmofs1wfVrQNJh+vAwKXe5D6zeEyETOCO3Rrn2dsL55RpcBnTJiJQcl60OipXto
	w70ltf82elXAexjN7pP72OaL9/y8Uk3KBl1I4+y4XVSxM3hoGeLYSL6gYIDzZ/aC
	nfqr15KZu9ke6Xb6GxuEZw4MeK+IzAssRCUnFr+nMdLqmDMowcDpkv/jY4lgmDyH
	vchBWZaxv/TyqUoiu67XSxHEf3Pmiwjjfrs6mVJuXgI/qi5X9YB2arcz2w7tT/ng
	wFs7R+LEQdGaMBLjR3M6NB6n033PSADEzaAsYOOrdh17Zj8IJwGvpqS735B54AGg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1kwaau77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:25:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62RB0GCh026797;
	Fri, 27 Mar 2026 15:25:37 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m7x0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Mar 2026 15:25:37 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62RFPaum33555074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Mar 2026 15:25:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FE2A5805D;
	Fri, 27 Mar 2026 15:25:36 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7A6B658058;
	Fri, 27 Mar 2026 15:25:35 +0000 (GMT)
Received: from [9.61.87.139] (unknown [9.61.87.139])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Mar 2026 15:25:35 +0000 (GMT)
Message-ID: <38452644-a097-4e03-a4b9-902c8c8d23f2@linux.ibm.com>
Date: Fri, 27 Mar 2026 11:25:35 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260326014247.2085-1-freimuth@linux.ibm.com>
 <20260326014247.2085-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260326014247.2085-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: VUcdl6ptUuLAdShsLrZW1ITAXMFYfpCe
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI3MDEwNSBTYWx0ZWRfX5z5Ft9dAr9ov
 o5oqZKHPA4BbNjzIDALM7Wt0+ocaOeNhliYUdiSlAcuW/zBnyNUxoa8HAdGkNBr+cfmVQGG40Iu
 768Z6Es5Oq0hvg+zStqGf9v18rU2uWYzAsEE2U5/FK5s5xpRuuarHTu9c/1Sl5wrnaUhYWtITFY
 Hs7Oq4l/0gWGUVkRxt+FFOSePizeSYItA/53AhqlsV6MBhhNh3GWAlpEgeGKxLcU7FBS1mE0avx
 bswBhimD8x+ghngMPz0ctXGmMBk4pM0wngPEyx4eH/IUyaGfRklyLadEFKR5ewABNVDOixIVwc1
 LJM1GWvALmA7P42OhjK7YpM8S/50OPBU3D6+YsVxj4Tt3vk5iL2BOjGoXRzXSgjERARMjfjCYVN
 Wd6umhzfHETyV6cnsl+HzNUj9nofJ1dF5urhXrab01nnJa8bm36S4uliZ+igBPoujqeQd465zne
 UhpsZM6Kyf47YuznSZA==
X-Proofpoint-GUID: VUcdl6ptUuLAdShsLrZW1ITAXMFYfpCe
X-Authority-Analysis: v=2.4 cv=OsZCCi/t c=1 sm=1 tr=0 ts=69c6a172 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=JP7uVcWlml9W1eh-bEUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-26_04,2026-03-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0
 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603270105

On 3/25/26 9:42 PM, Douglas Freimuth wrote:
> The S390 adapter_indicators_set function needs to be able to use mapped 
> pages so that worked can be processed,on a fast path when interrupts are
> disabled. If adapter indicator pages are not mapped then local mapping is 
> done on a slow path as it is prior to this patch. For example, Secure
> Execution environments will take the local mapping path as it does prior to
> this patch.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---

[...]

>  static int adapter_indicators_set(struct kvm *kvm,
>  				  struct s390_io_adapter *adapter,
>  				  struct kvm_s390_adapter_int *adapter_int)
>  {
>  	unsigned long bit;
>  	int summary_set, idx;
> -	struct page *ind_page, *summary_page;
> +	struct s390_map_info *ind_info, *summary_info;
>  	void *map;
> +	struct page *ind_page, *summary_page;
>  
> -	ind_page = get_map_page(kvm, adapter_int->ind_addr);
> -	if (!ind_page)
> -		return -1;
> -	summary_page = get_map_page(kvm, adapter_int->summary_addr);
> -	if (!summary_page) {
> -		put_page(ind_page);
> -		return -1;
> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		ind_page = get_map_page(kvm, adapter_int->ind_addr);
> +		if (!ind_page)
> +			return -1;
> +		idx = srcu_read_lock(&kvm->srcu);
> +		map = page_address(ind_page);
> +		bit = get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);

Sashiko's comments about this area of code should already be addressed
by my comments in v1 wrt to marking the page dirty before unpinning.

> +		srcu_read_unlock(&kvm->srcu, idx);
> +	} else {
> +		map = page_address(ind_info->page);
> +		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +	}
> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		summary_page = get_map_page(kvm, adapter_int->summary_addr);
> +		if (!summary_page) {
> +			put_page(ind_page);

Sashiko has a point here.  It is possible that you may have taken the
else path above where ind_info != NULL and never used ind_page.

Initialize ind_page to a NULL value first and check for a NULL value
here before attempting a put_page.
Or I think you can also check (!ind_info) and only put the page in this
case like you do later in this function.

[...]

>  
> @@ -2890,6 +2924,7 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>  {
>  	int ret;
>  	struct s390_io_adapter *adapter;
> +	unsigned long flags;
>  
>  	/* We're only interested in the 0->1 transition. */
>  	if (!level)
> @@ -2897,7 +2932,9 @@ static int set_adapter_int(struct kvm_kernel_irq_routing_entry *e,
>  	adapter = get_io_adapter(kvm, e->adapter.adapter_id);
>  	if (!adapter)
>  		return -1;
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
>  	ret = adapter_indicators_set(kvm, adapter, &e->adapter);
> +	spin_unlock_irqrestore(&adapter->maps_lock, flags);

Another point for Sashiko -- This is almost certainly a fallout from my
recommendation to drop the semaphore from patch 1 and go straight to a
spinlock vs adding semaphore in patch 1 and converting in patch 3.

You can't put a spinlock here as you may lose control inside
adapter_indicators_set.  You resolve the incompatibility in the next
patch by moving the spinlock inside the call and dropping it before you
could lose control -- but you have to already account for that in this
patch.

>  	if ((ret > 0) && !adapter->masked) {
>  		ret = kvm_s390_inject_airq(kvm, adapter);
>  		if (ret == 0)

