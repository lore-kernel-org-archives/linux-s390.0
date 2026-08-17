Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79D853B42D7;
	Mon, 17 Aug 2026 06:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786949169; cv=none; b=smYS3SNvkgWHIp9uQ+HR15DEeBfQ2F1Jzh61ct2HGc6iSXOG4Ryx5C4Yqodq2VFVl4zccmjOAjzVaRxYibxQjS+rg05fZjLzcVx2bgJR+/f4xTsh8QGbOCwFcSyNcg2JrpFMpj6zpHCwUdM2dpcD0e3/fLFqymeS/mCJTlAqr+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786949169; c=relaxed/simple;
	bh=yBB4mhHjbhlAysmpJvvRGM6RRA5Di/bQ3nWACYr/0lE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HhSLalJxTqUCngvY3vzGXtbxWFIOosIvrjH+nCy/pDcC2ukmgZkSdRyXzVWmrj28tSbkTtYBzaL5B5pGhRGYWe1p4r6jjVvbqh2b8XaB4fM/1AXW6VYk0W0ydZIEtai1H3Gn22TayqV84dbQmuyS2QS/75WPstg6+0IGNAd4o2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Jf3Z9VgN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Jf3Z9VgN"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLVq723780591;
	Mon, 17 Aug 2026 06:46:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=OQmf4G
	Nhttx2LEZbNzVAnJu0IovQsxaI18I/OQtgivE=; b=Jf3Z9VgNKZV5POJdMBIkxp
	ni5qpc3yh/HsJLl5MW34qFLCPx7cJpgJN+CwovzsHn4J2gS8k6gY37W/Bqm3mIJ0
	Hjbr/jV9GmW/PiuMLxaBMq4urypG9IClUbMnZIHcy381824LnXRjD5bVdw0iZu9V
	LIjdWUqEzaDS7tRxtgUYhXrcDqXjM2UTaUyIBzVohHZlyEe5+Cn5QudCiIn+blQ6
	bL8Dg0F6TLgTuirHePNivdLv9TP975CyXj1Ic4uVRqvvfy6Zclo1OYBnQnedTA6j
	XTfrE1hjXIlvPvwwtVONhC6WUs2LiD/dtZMlzFrSfhMk7R8l8gb3/KbBigQIpG/Q
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt0chk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 06:45:59 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H6fJ1L032407;
	Mon, 17 Aug 2026 06:45:59 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejvp2u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 06:45:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H6jtxS43778546
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 06:45:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 07DCB20043;
	Mon, 17 Aug 2026 06:45:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8EC6620040;
	Mon, 17 Aug 2026 06:45:54 +0000 (GMT)
Received: from [9.111.33.235] (unknown [9.111.33.235])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 06:45:54 +0000 (GMT)
Message-ID: <d3e8c94f-ef47-4fe3-99c9-1c02a07960c3@de.ibm.com>
Date: Mon, 17 Aug 2026 08:45:54 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] KVM: s390: Fix dirty marking in
 adapter_indicators_set*()
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org,
        Douglas Freimuth <freimuth@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260814163355.227191-1-imbrenda@linux.ibm.com>
 <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260814163355.227191-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a82ae27 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=3qhqli0Z9PzkQMhm4CIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX5WSTkGXqvZjz
 j7BQ0Ree4am4VQpdO4lrc3xvbNyODZwRZyrDGGjh0M8zoPw1b43C+QJTvBC8fyWOsE7NGbB5rPw
 PULF2Wtj0HqruHteRZU3YhmAvVzkyMo=
X-Proofpoint-GUID: iSptEBVACM0oB9ksRLFCkmtspz3aBw8-
X-Proofpoint-ORIG-GUID: iSptEBVACM0oB9ksRLFCkmtspz3aBw8-
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA0NyBTYWx0ZWRfX7HngLp0USpn+
 jtM4lz7wy/KEBOF3RuSvNFBZAsB+BcDGDVseYwJuO6BKrToVomDDrBuoJcMM67Y20gx5PajSnUd
 vDA95ZIRn1AcpHNfyytaeHPdm0j9jSvEcTm+L4Mz774WONrCakUwDZT1f9gQfBSnItk6Rx3H1d/
 vbjXUmxJ2wKRfOL1/rGTkTG1p/uy2UXnPS9jl+hg7AGd0dAh/36QbOsCyPcbRRCfsMJ7U7EOLSw
 yVbQqnhGgzaxGoVo35Ag0mxmFHgQj7lvJODOAkaiWPF8xqEcA/5b7GaSI1uQqZ4IlyOofihUFBC
 0RbHa1JkEqxu75az2O6mb8YIa/t47d4pREUGh7RBCWEnNHeEvqrSxWAKdcXEqbKpeY8W6aTb3P9
 wXDqaWE5kxuwygH7oXTeNxHzpADTIJd41R/+/6C2s9HznyB6F7eCObQ4iiQwbWlrCdBm5KcGv/i
 JmgakGEVmSi3EKF5pqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170047

Am 14.08.26 um 18:33 schrieb Claudio Imbrenda:
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

Doug, Matt, can you have a look?



> ---
>   arch/s390/kvm/interrupt.c | 40 ++++++++++++++++++++-------------------
>   1 file changed, 21 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index da740a378a8c..fc4d1f8193d9 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2984,12 +2984,14 @@ static int adapter_indicators_set(struct kvm *kvm,
>   				  struct s390_io_adapter *adapter,
>   				  struct kvm_s390_adapter_int *adapter_int)
>   {
> -	unsigned long bit;
> -	int summary_set, idx;
>   	struct s390_map_info *ind_info, *summary_info;
> -	void *map;
>   	struct page *ind_page, *summary_page;
>   	unsigned long flags;
> +	unsigned long bit;
> +	int summary_set;
> +	void *map;
> +
> +	guard(srcu)(&kvm->srcu);
>   
>   	ind_page = NULL;
>   
> @@ -3000,14 +3002,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>   		ind_page = pin_map_page(kvm, adapter_int->ind_addr, 0);
>   		if (!ind_page)
>   			return -1;
> -		idx = srcu_read_lock(&kvm->srcu);
>   		map = page_address(ind_page);
>   		bit = get_ind_bit(adapter_int->ind_addr,
>   				  adapter_int->ind_offset, adapter->swap);
>   		set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->ind_gaddr >> PAGE_SHIFT);
>   		set_page_dirty_lock(ind_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
>   		unpin_user_page(ind_page);
>   	} else {
>   		map = page_address(ind_info->page);
> @@ -3015,6 +3014,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>   		set_bit(bit, map);
>   		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>   	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
>   
>   	spin_lock_irqsave(&adapter->maps_lock, flags);
>   	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> @@ -3023,14 +3023,11 @@ static int adapter_indicators_set(struct kvm *kvm,
>   		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
>   		if (!summary_page)
>   			return -1;
> -		idx = srcu_read_lock(&kvm->srcu);
>   		map = page_address(summary_page);
>   		bit = get_ind_bit(adapter_int->summary_addr,
>   				  adapter_int->summary_offset, adapter->swap);
>   		summary_set = test_and_set_bit(bit, map);
> -		mark_page_dirty(kvm, adapter_int->summary_gaddr >> PAGE_SHIFT);
>   		set_page_dirty_lock(summary_page);
> -		srcu_read_unlock(&kvm->srcu, idx);
>   		unpin_user_page(summary_page);
>   	} else {
>   		map = page_address(summary_info->page);
> @@ -3039,6 +3036,7 @@ static int adapter_indicators_set(struct kvm *kvm,
>   		summary_set = test_and_set_bit(bit, map);
>   		spin_unlock_irqrestore(&adapter->maps_lock, flags);
>   	}
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
>   
>   	return summary_set ? 0 : 1;
>   }
> @@ -3048,26 +3046,29 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>   				       struct kvm_s390_adapter_int *adapter_int,
>   				       int setbit)
>   {
> +	struct s390_map_info *ind_info, *summary_info;
>   	unsigned long bit;
>   	int summary_set;
> -	struct s390_map_info *ind_info, *summary_info;
>   	void *map;
>   
> -	spin_lock(&adapter->maps_lock);
> +	guard(srcu)(&kvm->srcu);
> +	guard(spinlock)(&adapter->maps_lock);
> +
>   	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> -	if (!ind_info) {
> -		spin_unlock(&adapter->maps_lock);
> +	if (!ind_info)
>   		return -EWOULDBLOCK;
> -	}
> +
>   	map = page_address(ind_info->page);
>   	bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> -	if (setbit)
> +	if (setbit) {
>   		set_bit(bit, map);
> +		mark_page_dirty(kvm, gpa_to_gfn(adapter_int->ind_gaddr));
> +	}
> +
>   	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> -	if (!summary_info) {
> -		spin_unlock(&adapter->maps_lock);
> +	if (!summary_info)
>   		return -EWOULDBLOCK;
> -	}
> +
>   	map = page_address(summary_info->page);
>   	bit = get_ind_bit(summary_info->addr, adapter_int->summary_offset,
>   			  adapter->swap);
> @@ -3077,7 +3078,8 @@ static int adapter_indicators_set_fast(struct kvm *kvm,
>   		summary_set = test_and_set_bit(bit, map);
>   	else
>   		summary_set = test_and_clear_bit(bit, map);
> -	spin_unlock(&adapter->maps_lock);
> +	mark_page_dirty(kvm, gpa_to_gfn(adapter_int->summary_gaddr));
> +
>   	return summary_set ? 0 : 1;
>   }
>   

