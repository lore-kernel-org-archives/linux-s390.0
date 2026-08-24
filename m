Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63AD43A80C;
	Mon, 24 Aug 2026 14:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787581568; cv=none; b=sav1dD14IgCeSV/xGiSi54q5UeykEruBWcwu8P5fv6Hu8OSHzt8FNRib5CAEKTAkm48YdeU5UNft8a1eHMF8JeoUD0w8Ydaeldqww+F9npqV2pauB0OWtU9H+kperv/iSdTdg+TZMkh8qUNJipUkHT/HGSWvhDp6Uj32ZlWt3/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787581568; c=relaxed/simple;
	bh=LpvcFgmQHoKOSfGIGKjBgBZeyCmP4G2ENSXC5I4RHfs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fajRk2yzKaveDo3OxGIhsK+Q3BnYRsV8N3A9RjlZGVSuG+0HOLpZPz48tQfu8h2uYdbTp1XZExHfGtcPzk1LSXDqX5f4WjWXoqG0dAe2DLJFl4LudU4lqNCF4x9O9vz+XvP5CAfIiOOlVFNOKiPaj9RYZHzFKyPBHvI9/ZxjF/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bEQOQoBZ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bEQOQoBZ"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1ilg827038;
	Mon, 24 Aug 2026 14:26:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+YGDIG
	Y8i+NTM0/skfULOXQg2R7khvg5kz5eLGyhw+Q=; b=bEQOQoBZkbOFTQqOOm3N+X
	VKmLHoTrgMm95wF46wvaO7SICG+UD63crdM32ILVqad9gVEmAxUGtHKTB8PHMFYY
	ncx83cxn74Ctix91IM30M/aL5T1P3ZpM+Ger87ripaQLztjrv+ttQCy8pd7zM7LF
	D5XGN186eEzT8AoufXCInF/JXqJq4paSw7Uibin2PNGn3Gh4SJVu3D1gbqVapcaD
	/woRP5EXHlKc+Ik/W4xRnE2LyBm6kezA9UZteT2gHrVe3boL3Vu+9hs+dNAwi2nI
	S+Jv2v7w2DcQYFm6FlSSKDtlBLBx1FJ2bvO1ThVNWxRern3FLqZRHbHjg0t1+bmQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g726e9y89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:26:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEBQSR011539;
	Mon, 24 Aug 2026 14:26:02 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7pfvxkt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 14:26:02 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OEQ0oJ61669740
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 14:26:00 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7ADD658059;
	Mon, 24 Aug 2026 14:26:00 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD9E75805E;
	Mon, 24 Aug 2026 14:25:59 +0000 (GMT)
Received: from [9.61.252.179] (unknown [9.61.252.179])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 14:25:59 +0000 (GMT)
Message-ID: <eb54104e-e295-4b73-a27b-fb42deaebb56@linux.ibm.com>
Date: Mon, 24 Aug 2026 10:25:59 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Matthew Rosato <mjrosato@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, borntraeger@de.ibm.com,
        frankja@linux.ibm.com, david@kernel.org, seiden@linux.ibm.com,
        nrb@linux.ibm.com, schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
 <f3fce9e7-f59e-4cdf-861a-83ca44d3bc68@linux.ibm.com>
Content-Language: en-US
From: Douglas Freimuth <freimuth@linux.ibm.com>
In-Reply-To: <f3fce9e7-f59e-4cdf-861a-83ca44d3bc68@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=TfimcxQh c=1 sm=1 tr=0 ts=6a8c547a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=j0IwUgC9Fpla6kIixDQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX9vtjDv0Oe9vI
 Ny75ZnvmFb7E03BLv1WZt6RcxqDa4br+2i6hky5UXGixEnVPc41rhXd41fRM0L7Ecma1JvGFKak
 ms50ZZpacnJzwKr4FH1+IIhtrcTaPHY=
X-Proofpoint-GUID: HdNg7eQiWzbG0VV-7xcwwOJ6zw6H_UVJ
X-Proofpoint-ORIG-GUID: HdNg7eQiWzbG0VV-7xcwwOJ6zw6H_UVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDExOCBTYWx0ZWRfX6ux7X9mEopa5
 P2zKxJkfUpX6VC3J9vy2sp8Awpo2MchUKK3fVwC2TIypkQZiXMvsMbBEzzfBjaixUSuEmqB5WH9
 VSCCdVV7+lulLEYLS8ePh8LxZoFxOEzC1Q6YIiaZHgZT1q4rJJtvMh144b/zOQopQvrGsqHDNtS
 vFvFkASGRcj4LmExHhvT77UQGvI4GhyEEit1y8tC2FDc0Kc8v6/kx3g/7b3KCay15Lpq9oQXqsP
 8vCiwIkMU4qAC4yW3szKb7NEjRXa+XfA/3lIRbp67dFoaayR8MF5PUKOeldLKrw7huWD8T6lvk7
 M0X604qBwYV1inSSWe//8NwUsJdRnUEkuX7Y/ySj5gFZdnwUKe4pt+BeAt+aHwGbJaeBlO+ZW2X
 scve20clYerPzUIpUUHSqgWhybV+nAdgsRdRC7aVDXN9jKfms9NCfQoNuKbV5zeew5bfLnZS9Dm
 FUFAAw44y8+jonspYNw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240118



On 8/18/26 4:43 PM, Matthew Rosato wrote:
> On 8/14/26 12:33 PM, Claudio Imbrenda wrote:
>> When the indicator and/or summary bits are set in the guest, the
>> accessed page was only marked dirty in KVM if the access was performed
>> using the slow path; accesses through the new kvm_arch_set_irq_inatomic
>> fast inject path would not mark the page as dirty.
>>
>> Fix by adding/moving the missing calls to mark_page_dirty(). Note that
>> for the inatomic path set_page_dirty{,_lock}() is not needed as the
>> page stays pinned; the unpin path correctly marks it as dirty.
>>
>> Opportunistically reorder the local variables to be in reverse
>> Christmas tree order and refactor to use guard().
>>
>> Fixes: 1e95e3bc6b05 ("KVM: s390: Enable adapter_indicators_set to use mapped pages")
>> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> The code itself looks good to me:
> 
> Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> 
> Doug, can you please test (w/ lockdep enabled)?
> 
> Thanks,
> Matt
> 

I did some testing (not exhaustive) with blkpvt and stressed with 
stress-ng to force paging and I didn't observe any lockdep messages.

>> ---
>>   arch/s390/kvm/interrupt.c | 40 ++++++++++++++++++++-------------------
>>   1 file changed, 21 insertions(+), 19 deletions(-)
>>
>> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
>> index da740a378a8c..fc4d1f8193d9 100644
>> --- a/arch/s390/kvm/interrupt.c
>> +++ b/arch/s390/kvm/interrupt.c
>> @@ -2984,12 +2984,14 @@ static int adapter_indicators_set(struct kvm *kvm,
>>   				  struct s390_io_adapter *adapter,
>>   				  struct kvm_s390_adapter_int *adapter_int)
>>   {
>> -	unsigned long bit;
>> -	int summary_set, idx;
>>   	struct s390_map_info *ind_info, *summary_info;
>> -	void *map;
>>   	struct page *ind_page, *summary_page;
>>   	unsigned long flags;
>> +	unsigned long bit;
>> +	int summary_set;
>> +	void *map;
>> +
>> +	guard(srcu)(&kvm->srcu);
>>   
>>   	ind_page = NULL;
>>   
>> @@ -3000,14 +3002,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>>   		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
>>   		if (!ind_page)
>>   			return -1;
>> -		idx = srcu_read_lock(&kvm->srcu);
>>   		map = page_address(ind_page);
>>   		bit = get_ind_bit(adapter_int->ind_addr,
>>   				  adapter_int->ind_offset, adapter->swap);
>>   		set_bit(bit, map);
>> -		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
>>   		set_page_dirty_lock(ind_page);
>> -		srcu_read_unlock(&kvm->srcu, idx);
>>   		unpin_user_page(ind_page);
>>   	} else {
>>   		map = page_address(ind_info->page);
>> @@ -3015,6 +3014,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>>   		set_bit(bit, map);
>>   		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>>   	}
>> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
>>   
>>   	spin_lock_irqsave(&adapter->maps_lock, flags);
>>   	summary_info = get_map_info(adapter, adapter_int->summary_addr);
>> @@ -3023,14 +3023,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>>   		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
>>   		if (!summary_page)
>>   			return -1;
>> -		idx = srcu_read_lock(&kvm->srcu);
>>   		map = page_address(summary_page);
>>   		bit = get_ind_bit(adapter_int->summary_addr,
>>   				  adapter_int->summary_offset, adapter->swap);
>>   		summary_set = test_and_set_bit(bit, map);
>> -		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
>>   		set_page_dirty_lock(summary_page);
>> -		srcu_read_unlock(&kvm->srcu, idx);
>>   		unpin_user_page(summary_page);
>>   	} else {
>>   		map = page_address(summary_info->page);
>> @@ -3039,6 +3036,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>>   		summary_set = test_and_set_bit(bit, map);
>>   		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>>   	}
>> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
>>   
>>   	return summary_set ? 0 : 1;
>>   }
>> @@ -3048,26 +3046,29 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>>   				       struct kvm_s390_adapter_int *adapter_int,
>>   				       int setbit)
>>   {
>> +	struct s390_map_info *ind_info, *summary_info;
>>   	unsigned long bit;
>>   	int summary_set;
>> -	struct s390_map_info *ind_info, *summary_info;
>>   	void *map;
>>   
>> -	spin_lock(&adapter->maps_lock);
>> +	guard(srcu)(&kvm->srcu);
>> +	guard(spinlock)(&adapter->maps_lock);
>> +
>>   	ind_info = get_map_info(adapter, adapter_int->ind_addr);
>> -	if (!ind_info) {
>> -		spin_unlock(&adapter->maps_lock);
>> +	if (!ind_info)
>>   		return -EWOULDBLOCK;
>> -	}
>> +
>>   	map = page_address(ind_info->page);
>>   	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
>> -	if (setbit)
>> +	if (setbit) {
>>   		set_bit(bit, map);
>> +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
>> +	}
>> +
>>   	summary_info = get_map_info(adapter, adapter_int->summary_addr);
>> -	if (!summary_info) {
>> -		spin_unlock(&adapter->maps_lock);
>> +	if (!summary_info)
>>   		return -EWOULDBLOCK;
>> -	}
>> +
>>   	map = page_address(summary_info->page);
>>   	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
>>   			  adapter->swap);
>> @@ -3077,7 +3078,8 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>>   		summary_set = test_and_set_bit(bit, map);
>>   	else
>>   		summary_set = test_and_clear_bit(bit, map);
>> -	spin_unlock(&adapter->maps_lock);
>> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
>> +
>>   	return summary_set ? 0 : 1;
>>   }
>>   
> 

