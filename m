Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38ED6357D0B;
	Fri, 22 May 2026 17:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779471881; cv=none; b=i7tZAlHQVCMSIaU+QXTn1WqZtGF2SnXDXNaqqxiXAAovs8u94K0gnHyYzqt/4L0t58Ue0OU7MiVypMvLXbribE1fvfW/q8lwzBDalwvFE7Jbhlgn+TbtAU7LJpa4VRWtLr+CHPvTwOiA4lUSRcQEPPbN0a66gTKW4SL+x/sDLDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779471881; c=relaxed/simple;
	bh=0iUVzFVcVklaM3apyMpOPzAsj0+qitSb0RkZ8TmMv7c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=fNvdusg8XRx264Qkte7Gm2n4RNyDpX2C/jjEOjxamvvoeBfKIcbdVUZMtpMkapNuY9oO1PPfkeJhvBFGoyVbSlVLdX/nuSD6af5xm7HzYBWDQJRoMxAd0ogdhbjNdA1trPI+tfJ50JHBy+vYVlRQZNRNu+ltTm310xjU55JFH+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YwxIrhil; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YwxIrhil"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64M7NIxo4007147;
	Fri, 22 May 2026 17:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b/Qq/D
	ZY06Jx9Ppv6LEhssLT8SXSD9uSV90ZQt787eM=; b=YwxIrhilQ6EkT9OF+2qbOZ
	u+JorY1FjjPJM0FV4UnEJW8itznFXqZobNUzatYuUXXt/0Na6ftnVwrjOjFAwUN2
	iQ6Emlyvf2HyUtZ9epUMykxqH8GIEjNScS3f79VNRnLNg6jofP1MWIsZ0kHN1l/L
	hmURgBPe4oEvUgaa7kwWFd9USStzp1DR37CqfnUrrBqDwHU6mvxlLiVWSKnG1MJa
	pyLT9cEF8298/ONzeliVPnhdL/y7PkOiyefmS5tYDvDZUZqkx/uridzBmrE9Ghzy
	mpHAin1wJeQyLeQbUFHoReX1E/kP97gJdV9ERhCmSzx8ZeKtVNyWrkufyKoA6TYA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6hawkq45-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:44:37 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64MHd5vB032051;
	Fri, 22 May 2026 17:44:36 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e754gsqpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 May 2026 17:44:36 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64MHiZjv5702214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 May 2026 17:44:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 309B058053;
	Fri, 22 May 2026 17:44:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 077115805F;
	Fri, 22 May 2026 17:44:34 +0000 (GMT)
Received: from [9.61.48.218] (unknown [9.61.48.218])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 22 May 2026 17:44:33 +0000 (GMT)
Message-ID: <7fa8f346-a75e-4088-8b72-0fe854753bea@linux.ibm.com>
Date: Fri, 22 May 2026 13:44:33 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/3] KVM: s390: Enable adapter_indicators_set to use
 mapped pages
To: Douglas Freimuth <freimuth@linux.ibm.com>, borntraeger@linux.ibm.com,
        imbrenda@linux.ibm.com, frankja@linux.ibm.com, david@kernel.org,
        hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, kvm@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20260520160442.1051999-1-freimuth@linux.ibm.com>
 <20260520160442.1051999-3-freimuth@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260520160442.1051999-3-freimuth@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIyMDE3NiBTYWx0ZWRfXwgcaFqd/MNub
 NqKc6bA/LExzvMGiOjNVu166OXVcUgYz+woXSiMHD4JCVcqQF+25xR/1KYIAW529pE+un0Sedn9
 hzJhv7te2KJEiddSuuMmWTMzTBmB4Gc4JDqhQXLaiStFW2ZhNPvnDrWoUGy6fDoHTVY0S4kThb3
 TLkW5xYlgxHYG86hZZf5KnLehL+FMLuMnyu832GnS/t1v37d843s3hB4tlV1y/LgPpu4whNn7cg
 xGTAG1GzifGJdsymj5YcD4WSyAZqMVXXFUji0zKBggJJGfSVp8ZDZyKw9clVFhHweydE4pAkw/j
 p/+LCaZsgOs2vNThJWfUkKlOc4rtCrzIujgTaurtwIA+jOlFsDBbk8+fX9adUtP1FWJaQ9aLoWy
 eh1I9FL6aO7OkYe+8zuP1V9s9/+8kfrTCbyTylBQ7AyeDetDHC9IQ0QhtsJlfK4EFyH1HJIeuE5
 VdgNJptOt8ZswWNe49A==
X-Authority-Analysis: v=2.4 cv=Np/htcdJ c=1 sm=1 tr=0 ts=6a109605 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Im6Lxs3u8qUyE2bwNGIA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ojv0mDO7H9PsbN2eNZ20NGQFyXWyOtzm
X-Proofpoint-GUID: ojv0mDO7H9PsbN2eNZ20NGQFyXWyOtzm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-22_04,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 clxscore=1015 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605220176

On 5/20/26 12:04 PM, Douglas Freimuth wrote:
> The s390 adapter_indicators_set function can now be optimized to use
> long-term mapped pages when available so that work can be
> processed, on a fast path when interrupts are disabled.

nit: drop the comma

> If adapter indicator pages are not mapped then local mapping is
> done on a slow path as it is prior to this patch. For example, Secure
> Execution environments will take the local mapping path as it does prior to
> this patch.
> 
> Signed-off-by: Douglas Freimuth <freimuth@linux.ibm.com>
> ---
>  arch/s390/kvm/interrupt.c | 89 ++++++++++++++++++++++++++++-----------
>  1 file changed, 65 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/s390/kvm/interrupt.c b/arch/s390/kvm/interrupt.c
> index 654c37e5e898..c41461b6f365 100644
> --- a/arch/s390/kvm/interrupt.c
> +++ b/arch/s390/kvm/interrupt.c
> @@ -2885,41 +2885,82 @@ static unsigned long get_ind_bit(__u64 addr, unsigned long bit_nr, bool swap)
>  	return swap ? (bit ^ (BITS_PER_LONG - 1)) : bit;
>  }
>  
> +static struct s390_map_info *get_map_info(struct s390_io_adapter *adapter,
> +					  u64 addr)
> +{
> +	struct s390_map_info *map;
> +
> +	if (!adapter)
> +		return NULL;
> +
> +	list_for_each_entry(map, &adapter->maps, list) {
> +		if (map->addr == addr)
> +			return map;
> +	}
> +	return NULL;
> +}
> +
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
> +	ind_page = NULL;
> +
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	ind_info = get_map_info(adapter, adapter_int->ind_addr);
> +	if (!ind_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
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
>  		unpin_user_page(ind_page);
> -		return -1;
> +	} else {
> +		map = page_address(ind_info->page);
> +		bit = get_ind_bit(ind_info->addr, adapter_int->ind_offset, adapter->swap);
> +		set_bit(bit, map);
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +	}
> +	spin_lock_irqsave(&adapter->maps_lock, flags);
> +	summary_info = get_map_info(adapter, adapter_int->summary_addr);
> +	if (!summary_info) {
> +		spin_unlock_irqrestore(&adapter->maps_lock, flags);
> +		summary_page = pin_map_page(kvm, adapter_int->summary_addr, 0);
> +		if (!summary_page) {
> +			WARN_ON_ONCE(ind_page || ind_info);

I think this was my suggestion on v6, but this is basically WARN_ON_ONCE(true).
We can't reach this code unless we got the indicator page somehow. 

Really then it should be:

if (WARN_ON_ONCE(!summary_page))
    return -1;

And we catch the first instance of setting indicator bits but failing to set
the summary bit.

With that:

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

