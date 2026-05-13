Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904263D6473;
	Wed, 13 May 2026 07:51:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778658669; cv=none; b=RWn+24uxfPk2BVKX7hm78YXgfZZv6//1KjtIDOZw6z9oR8TBfE8DnIPCpzwHBFsYP4MiU72Br3+Zda8vKiemn1Fsq1V9ZkfPMhqJLkrcTLpZ/6J75YgSMA6oOF7moL7tfQGtADKo9uEI1OtRjFdm5twzZNKJv+2q8xf3MXwoC0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778658669; c=relaxed/simple;
	bh=S3MQvptA2ih7d6eKI+HanUejUUCkonJNrFP2K2aomgs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=riXkBk2weIsHjurUrkcjsiAncsoze1dXAbx2MfherFwtb4dEv7QtwA6UysQK3OQkpXKKNiv6ARegkGUc9VDsZ6kJ3LnLmJ64rNBirKDBFAT4wXSTx8GhimJKFFyOIJXVCkKZMwTqa/J8I+TRKagQ2M4sVKq3P3CPkFwxJVFxA+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=VdBpRrEN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="VdBpRrEN"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64D1h6x43179743;
	Wed, 13 May 2026 07:51:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nyJf5X
	7Py9uh2kQ1ajTdxIIKJTopcucM+RflQZaIB5g=; b=VdBpRrENi/UKrjs0+hanqZ
	l8bAYwHIAGFUb3SNRkLB38FIBM104x75L3j6n2e+hdrzMJF688op9E6PK1fWW+sl
	Ad/dXS2kumSj7rFJQG8WuFqY6TA4/HqHWe/i7SNEBbyB4e7YNSazlHiYDA4a0YoK
	4DatuJWFJMNIJUJAp4TPBR9ZTovmFTBlpdOp6y6KXU6/41fzxcv9dO3C78Cy+mP7
	4tH6eC4l8HcAviecou5IhGgwDu2KmJrOakw6ggUapRkSx466ZQXZSPNT4NAVvdyM
	BWHoSJp26g+H9lyWsTWC6MNq8AoUf0cOroSlYeNzCO+kPuO8TdcUuMEv5RIZ61AQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e3nv6pbyv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:51:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64D7dSI7009983;
	Wed, 13 May 2026 07:51:03 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e3nfgetk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 13 May 2026 07:51:03 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64D7oxJZ28049706
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 13 May 2026 07:50:59 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5B9720043;
	Wed, 13 May 2026 07:50:59 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7FC4620040;
	Wed, 13 May 2026 07:50:59 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 13 May 2026 07:50:59 +0000 (GMT)
Message-ID: <2b918744-41b7-4fa3-94a7-02de595f6dcc@de.ibm.com>
Date: Wed, 13 May 2026 09:50:59 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] KVM: s390: vsie: Fix memory leak when unshadowing
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-2-imbrenda@linux.ibm.com>
Content-Language: en-US
From: Christian Borntraeger <borntraeger@de.ibm.com>
In-Reply-To: <20260512175251.300882-2-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Us1T8ewB c=1 sm=1 tr=0 ts=6a042d68 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=DCMeoaV-cPcIjBzKr0EA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: M8yUvGIZ_ZV2fXaSCPn79niCtJqIP5lV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDA3NyBTYWx0ZWRfXwEky5oKjtD4n
 b1oATNFu1ozhaefeVBQXTZDn5G7+7tBDBBL9q/BDMECTfjkXQPl9v+dxQnA/rfPTlI/VQlLUbXG
 0agGZzw8W+IfkXzgfikqgeiWuTvfIJjWcPMxdajkTgjDHutfl/PITTa1XDuEO9fTVeZQThEQ43X
 y3me8/sgqCUxm2WQzajrGDO/2k6TS/VWMwQ3XTCHriqUqU05R/SJNn5VGBgrGCasJelEW3b8heC
 H+pD8EhAbvLlta/ob7xNz+qp1AQN4kRQMLshjRiOVvRpeATwDorMmQTxpUkrOotbqx/fFUfabl3
 ArLQWbdqB5aQa3UR3u6Ji5PVkrXXXFQOpNBuo2jM/RaYfiJLF0YJoOURTXRdjMTk4F0un4aoKp0
 zAqUmdjeOnwKHbzMC7kIpq3smQYe92xj8bX9aCT+hJx7UmSJr9sLuOapV9l5p3UEECQAr5t7ZjX
 kTBBqrgtPyZKEj6MHQQ==
X-Proofpoint-ORIG-GUID: M8yUvGIZ_ZV2fXaSCPn79niCtJqIP5lV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 bulkscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130077

Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> When performing a partial unshadowing, the rmap was being leaked.
> 
> Add the missing kfree().
> 
> Fixes: a2c17f9270cc ("KVM: s390: New gmap code")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> Reviewed-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>

> ---
>   arch/s390/kvm/gmap.c | 4 +++-
>   1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/gmap.c b/arch/s390/kvm/gmap.c
> index 3c26e35af0ef..fd1927761980 100644
> --- a/arch/s390/kvm/gmap.c
> +++ b/arch/s390/kvm/gmap.c
> @@ -1143,8 +1143,10 @@ void _gmap_handle_vsie_unshadow_event(struct gmap *parent, gfn_t gfn)
>   		}
>   		scoped_guard(spinlock, &sg->host_to_rmap_lock)
>   			head = radix_tree_delete(&sg->host_to_rmap, gfn);
> -		gmap_for_each_rmap_safe(rmap, rnext, head)
> +		gmap_for_each_rmap_safe(rmap, rnext, head) {
>   			gmap_unshadow_level(sg, rmap->r_gfn, rmap->level);
> +			kfree(rmap);
> +		}
>   	}
>   }
>   

