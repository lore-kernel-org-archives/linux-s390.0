Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34B7C30BF4E;
	Wed, 13 May 2026 16:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778688984; cv=none; b=NkzR2afQ7nIGgEjXyDcQ29qxLtfliMwuIqDdO6hPFjbx56QLNlvjQ3bbQyukWJz0Ibg2HyAfsxhzBz4wlufkzV6XMm8O2ZBaGtVTWMbb6OOqyKvChajpIXsxmwXzoB43l1mk74Z7K79J7DiuGAhnrfS4OPf/Id7VEGFQXgQu7fg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778688984; c=relaxed/simple;
	bh=L8jrsYHVTEE8zLHGgLHY9zKU0T0C7rnFaCcc1HD1P6k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TLJmt5QgPU832GGzvR4G68FcSh39U6BA0Qp5kpll0CR+5k8jdvSwIsvfH54hO4YokmlxXRjPC6E5YMAAelISeCf9EURcS5kkRpdMIyA/d7CrLgJIOwPKi9dUF/l/Jqx8liNj/k/k8pHK5ORLYfIRDgtk5DNXhS37MCcF7Ei+6+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GY/1GeDr; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GY/1GeDr"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64DEhlG52758961;
	Wed, 13 May 2026 16:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=MzMxz1
	HePvB4ExTKcFNTUwgHTY03v2TR1E06+VOdB1g=; b=GY/1GeDr2O47EYJX+Omltr
	dhCOPNlsz/nXWxVL+mqi/1aINIrebpgTunb1MJX9cKapmOL9rgXG0w8gKnjpcCgB
	0KiaEn/SG0zBp21YbV92xc735nuyvcQ6ryN1wfnsM6BvtB+maqUcsuWYWvYNzkaq
	0QXXa/s4o1ykAS3+MvnZMGfUjVjrI65LQ9dio5L4B3hZUAtNbKwYr5w9VnFTaQ8V
	JvnN7Bi8UdLmBclXUOsX872f2ZUnBwPwY0SSva8F28OEtFPzqAm6jGYG5V2wrDdv
	NwsI4iLkiYZr7n1uYo5TPrJ3WDuC78cFAlovKzDg+AjDmkUmhm4Di0pfuRau6FZw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6r8b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:16:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64DG9vlf026614;
	Wed, 13 May 2026 16:16:19 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgrgjj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 16:16:19 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64DGGHSf28574312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 16:16:18 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AC37D58058;
	Wed, 13 May 2026 16:16:17 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9F4158059;
	Wed, 13 May 2026 16:16:15 +0000 (GMT)
Received: from [9.61.44.159] (unknown [9.61.44.159])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 16:16:15 +0000 (GMT)
Message-ID: <9c83dbc9-51db-4ffb-83d2-638128c3b422@linux.ibm.com>
Date: Wed, 13 May 2026 12:16:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/4] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260511161451.209464-1-freimuth@linux.ibm.com>
 <20260511161451.209464-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260511161451.209464-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 4gWdGzTY3ZbxHVtj5kxVu2M_YV36Ewc8
X-Proofpoint-GUID: 4gWdGzTY3ZbxHVtj5kxVu2M_YV36Ewc8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2NCBTYWx0ZWRfX5Ux4h4zeINto
 I37aDLYNhaDboyCGTnlJScWlMf2fve02HBfuBgcL1UXesWnwjE1uQSm97KJU9ofoErbg58+Iv2K
 XQpPsdHM17/u8+kaepoYEJa5cjX0uFijZ5a3Dhkn/hGv0wJL271b1aPa11NawZUsKhYtgV40gKo
 aEg4yEv8THCRdFnYmA4pkeAsUZtmruz7Iv+eKfCeJF5HcOTiJ0oZWg40wtr8mMn419tWAgOzHxX
 7Z3mynX0XxECRrMWrDRgEyoZ2aHU7oxECGfZBC7c2YZ1w6is1C/+BbOEqYXVkRipVqWxTpPgkGz
 ivSovR8GJM3vsw1yo85KkF5Mi1IMisvgE3/K72E322c7VwimRfJynYJmDznice+vcdUuYqqYnVY
 sqxka/KyZcIMCT/HcD0D4zo7ftAAocirBuoeGnjfj6LvjkIqs+sE6C22QR0gsg9JygMkA6Xa7LQ
 TuIriOXkQGFwEpmx7eA==
X-Authority-Analysis: v=2.4 cv=P8UKQCAu c=1 sm=1 tr=0 ts=6a04a3d3 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=yJ7A1TyqSRYUUuSQqjIA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 phishscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130164

On 5/11/26 12:14 PM, Douglas Freimuth wrote:
> The S390 adapter_indicators_set function needs to be able to use mapped

Nit: s/S390/s390/

> pages so that worked can be processed,on a fast path when interrupts are
> disabled. If adapter indicator pages are not mapped then local mapping is
> done on a slow path as it is prior to this patch. For example, Secure
> Execution environments will take the local mapping path as it does prior to
> this patch.

Slight tweak to the commit message:  adapter_indicators_set doesn't
really _need_ to use the long-term mapped pages.  It's an optimization
to do so, while your will later add the _fast() variant where it is
a requirement.

Maybe re-word like:
'The S390 adapter_indicators_set function can now be optimized to use
long-term mapped pages when available so that work can be
processed...'

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
> +	unsigned long flags;
>  
> -	ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
> -	if (!ind_page)
> -		return -1;
> -	summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
> -	if (!summary_page) {
> -		unpin_user_page(ind_page);
> -		return -1;
> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
> +		if (!ind_page)
> +			return -1;
> +		idx = srcu_read_lock(&kvm->srcu);
> +		map = page_address(ind_page);
> +		bit = get_ind_bit(adapter_int->ind_addr,
> +				  adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(ind_page);
> +		srcu_read_unlock(&kvm->srcu, idx);

I think you can simplify some of this unpin logic by just calling 
unpin_user_page(ind_page) here?  You don't use it past this point
and you aren't holding a raw spinlock ...

> +	} else {
> +		map = page_address(ind_info->page);
> +		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}
> +	raw_spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
> +		if (!summary_page) {
> +			if (!ind_info) {
> +				WARN_ON_ONCE(!ind_page);
> +				unpin_user_page(ind_page);
> +			}

... Then you wouldn't need this !ind_info logic, it's safe to return
immediately

I also don't think that WARN_ON_ONCE does what was intended.  Looking
back any my v3 comments, the idea was to catch a case where we map
indicator pages and set the associated bits but cannot map summary
page.  That means if you want a WARN here, then something like...

if (!summary_page) {
  WARN_ON_ONCE(ind_page || ind_info);
  return -1;
}

Also ind_page needs to be initialized to NULL for that to work.


> +			return -1;
> +		}
> +		idx = srcu_read_lock(&kvm->srcu);
> +		map = page_address(summary_page);
> +		bit = get_ind_bit(adapter_int->summary_addr,
> +				  adapter_int->summary_offset, adapter->swap);
> +		summary_set = test_and_set_bit(bit, map);
> +		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> +		set_page_dirty_lock(summary_page);
> +		srcu_read_unlock(&kvm->srcu, idx);

Same here, unpin_user_page(summary_page) ...

> +	} else {
> +		map = page_address(summary_info->page);
> +		bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
> +				  adapter->swap);
> +		summary_set = test_and_set_bit(bit, map);
> +		raw_spin_unlock_irqrestore(&adapter->maps_lock, flags);
>  	}
>  
> -	idx = srcu_read_lock(&kvm->srcu);
> -	map = page_address(ind_page);
> -	bit = get_ind_bit(adapter_int->ind_addr,
> -			  adapter_int->ind_offset, adapter->swap);
> -	set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(ind_page);
> -	map = page_address(summary_page);
> -	bit = get_ind_bit(adapter_int->summary_addr,
> -			  adapter_int->summary_offset, adapter->swap);
> -	summary_set = test_and_set_bit(bit, map);
> -	mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
> -	set_page_dirty_lock(summary_page);
> -	srcu_read_unlock(&kvm->srcu, idx);
> -
> -	unpin_user_page(ind_page);
> -	unpin_user_page(summary_page);
> +	if (!ind_info)
> +		unpin_user_page(ind_page);
> +	if (!summary_info)
> +		unpin_user_page(summary_page);

... And then you don't need either of these checks/unpins?

>  	return summary_set ? 0 : 1;
>  }
>  

