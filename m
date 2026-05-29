Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32E063B8930
	for <linux-s390@vger.kernel.org>; Fri, 29 May 2026 08:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780043407; cv=none; b=dke1UCden5Zf2pWUm9/bhiexbvWQle0WCuD7UsfOl1X6nW//J7LaFsGBuyAG8KLO62it2qxXbpWIeSdVo2Vu1egRGQzcyRgsz+vx1u5OFPz1ustVOXV7apqjW7rfSNSukpo+FnDfUnemHFY1m0p0kY7gLnUeG/92nNcjeZ9dOgA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780043407; c=relaxed/simple;
	bh=44BTPT7dX+NZT9MD7H/OQ9sAn3f/wDtrpvlrogjAsPg=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MoRRyUWJMFFpm5TKZ5cl6l5+gF2GGT4qBmVebVvpHj+uTz/y9yncyE3QmbfNlrnzpGypEMsaLTGBHo1OdO/WqQxRZ0zy7M2m0qzea1ZuoWTXk7Ae7jn39kUgtbe2Zt5Go7TGOejmz3FXmDzQVf9+4lTJCu8nRHdwD4GlUW1er8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=cW8ASZXO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="cW8ASZXO"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64SLluMX2776536;
	Fri, 29 May 2026 08:30:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=T2sBwdxwvf3COHInB+BAgjq9QU6WPTR4suqHBLMQ0i4=; b=cW8ASZXOpkM1
	OSoI0hcHzafd27VQaNsSYEfnA4xdLO0QqzVqS0D+ovPEgJ/SeSlusuUyjko6pJt/
	w6GKX6SlDSpNDW7gx4Lj9NmCTz0XDiSNuXouDCQr/FgWQWkczSj6XNr6MaDBmCzx
	3Mzc+dZk6uUuqCngcUYnAgq+pFkrldnOrj82gXkGJWSDmkLeuRRxl+wv0tV90IZp
	vrVftHFa3PtHkJHWrpmUNwKwWSFpUnbbjCPUAqk8+LE3dkeaOrWsLb7IBYIrb+nX
	l2mRq5BDLlLR++e6p6ns8Gnlh3OvZ1g2LP6iix4mYQmCLBRI1TaHqTFuXUUlx7Pm
	0LoXxPR6LA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ee889f7ac-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:30:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64T8O8it020742;
	Fri, 29 May 2026 08:30:01 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4edjrbvjj6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 29 May 2026 08:30:01 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64T8U09L16974498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 29 May 2026 08:30:00 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CFDD5805A;
	Fri, 29 May 2026 08:30:00 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4367658054;
	Fri, 29 May 2026 08:29:59 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 29 May 2026 08:29:59 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 29 May 2026 10:29:58 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexandra Winter
 <wintera@linux.ibm.com>,
        Aswin Karuvally <aswin@linux.ibm.com>,
        Christian
 Borntraeger <borntraeger@linux.ibm.com>,
        Holger Dengler
 <dengler@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Stefan
 Haberland <sth@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH 6/6] s390/zcrypt: replace get_zeroed_page() with kzalloc()
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260528-b4-s390-drivers-v1-6-b7108f54d722@kernel.org>
References: <20260528-b4-s390-drivers-v1-0-b7108f54d722@kernel.org>
 <20260528-b4-s390-drivers-v1-6-b7108f54d722@kernel.org>
Message-ID: <7009bf5ca0c1b009afe7efe0d249b990@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: IdUy2qrJBqKo7iw2KV7i_bw_3Wv0V5-_
X-Proofpoint-GUID: IdUy2qrJBqKo7iw2KV7i_bw_3Wv0V5-_
X-Authority-Analysis: v=2.4 cv=XqfK/1F9 c=1 sm=1 tr=0 ts=6a194e8a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=BOL8qLHpssRxeIhISHgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDA3OCBTYWx0ZWRfXzZxQW0wfXdeN
 rXWTWogbNAL33SJiBtlELRmAQM1iRmofIqBPtAbrR0DWqqotaYYcSYpe/F0+TjlsG+uowuF8cre
 0RGaoe3+mTeSA1pIsQSfUTZxtUkZbDJV6MaWogL3jeSeYWmQnMWchKf6ScKykmt4NcfQk82g6Nr
 Gy2mAJwvEeB9yne8zb5wfCvdxuLaBQytPP2cVfx4EtT5BUDiWgX0OCVa3Wt2N5wQ4pxWUd/Pf6f
 j2FJP+3ReGEnC1NyAwtUl6Q5oY5hv3/by1cXQ7fy4B1LdGMhj4kKJ6p9n2oe6SZg6fnyCTTn4hK
 7SfdE5YgwvihFOmoDldtRZp8cJsv+6edWQF+DruOYE0ifdBsHBFdnoLcFdARWHCpzPqmLb3VOxk
 1DeWDIh4HM0YR5N7xuZkrjs4Oz/Za846pePfFzTfDeEuAcLocL/Xu2UCwLFsoJk6YDMfe8i1D8p
 3e3CYWOgF9I18qosN4g==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2605290078

On 2026-05-28 09:09, Mike Rapoport (Microsoft) wrote:
> zcrypt_rng_device_add() allocates a buffer for the software random
> number generator data cache.
> 
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
> 
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list 
> for
> fast path allocations.
> 
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
> 
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
> 
> Link:
> https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  drivers/s390/crypto/zcrypt_api.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c 
> b/drivers/s390/crypto/zcrypt_api.c
> index d6a455df228d..f57189c2b839 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -1782,7 +1782,7 @@ int zcrypt_rng_device_add(void)
> 
>  	mutex_lock(&zcrypt_rng_mutex);
>  	if (zcrypt_rng_device_count == 0) {
> -		zcrypt_rng_buffer = (u32 *)get_zeroed_page(GFP_KERNEL);
> +		zcrypt_rng_buffer = kzalloc(PAGE_SIZE, GFP_KERNEL);
>  		if (!zcrypt_rng_buffer) {
>  			rc = -ENOMEM;
>  			goto out;
> @@ -1799,7 +1799,7 @@ int zcrypt_rng_device_add(void)
>  	return 0;
> 
>  out_free:
> -	free_page((unsigned long)zcrypt_rng_buffer);
> +	kfree(zcrypt_rng_buffer);
>  out:
>  	mutex_unlock(&zcrypt_rng_mutex);
>  	return rc;
> @@ -1811,7 +1811,7 @@ void zcrypt_rng_device_remove(void)
>  	zcrypt_rng_device_count--;
>  	if (zcrypt_rng_device_count == 0) {
>  		hwrng_unregister(&zcrypt_rng_dev);
> -		free_page((unsigned long)zcrypt_rng_buffer);
> +		kfree(zcrypt_rng_buffer);
>  	}
>  	mutex_unlock(&zcrypt_rng_mutex);
>  }

Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>
