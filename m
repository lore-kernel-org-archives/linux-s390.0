Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1133439182D;
	Wed, 25 Mar 2026 21:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774474226; cv=none; b=CNMwZMueqVeyrr+KbrCw3BUfUg804zZs/cuq447j9KhRd7X8Pd4sdfRELBkAgwd6CqhXjI3hPp9zmEn62spbZyFUv5r0irBW15JGB9cgWuMO1xFaebItlkUq3YIgbWrjm+s6O0JPrwc7seM6UnfZ0m2qIOZfdHNDNNtTP1OAyd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774474226; c=relaxed/simple;
	bh=SrQxmfHt++v0GEweSa9hzNtnJXeL9rd9YJiM3pWEvAc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sBTOg2uUjC7rvouprMtcGzcXerjXVCb1O7Alhp+jxj4ukteLh86Qr1umTA6M2iLsRwRBLGlqbPJIJF6L/YYFX3vx7ahO6H2LUXn//DrJRqoeiDaR2+iDSfEKnr9nJaQ6Xresoj7W/6HwgWHiYFVZR4kzQELnrYqvF3IaAJqKfuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=G94i1jnI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="G94i1jnI"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62PEEoci1073850;
	Wed, 25 Mar 2026 21:30:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=b429MO
	o0fV2jrrEisgVs6pu4IYUfyT6sFUhavb7qQx8=; b=G94i1jnIIHu8nU8mxwt36+
	RwUpCWClAZ4GMIvxT17asNplWOyaR+kK36a0ERelLjRY4lE3/0BvySSMlX02hXKN
	XOU2phjEPlTUpkw7pkZvs1yxkszRcnkfvqBBdf3kzN7iZt3qiB7BKJuUExW9XR1I
	UT3GpMMob4Z2YdTIcGOIL0TXGM2o/JgboZ9tYn4EhfsuT+/OzEMbxZTKh3gMS18e
	T7Ml3sQN9ksohijlblMb3LOG/P+cU9A3gBRLQfyiIedWK+OdnpnowY3K6ZVWs6CK
	wll2S7GBEDamsbsXfP1Xm5e4P0oU6NmMDQevFjT1QnH9rq9sPI18qn0oLOPkhgAQ
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4d1ky09jhn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:30:19 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62PJrBrO026685;
	Wed, 25 Mar 2026 21:30:19 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4d275m08e3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 25 Mar 2026 21:30:19 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62PLUHoT30868202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Mar 2026 21:30:17 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83D135805C;
	Wed, 25 Mar 2026 21:30:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3A20F58054;
	Wed, 25 Mar 2026 21:30:16 +0000 (GMT)
Received: from [9.61.87.139] (unknown [9.61.87.139])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 25 Mar 2026 21:30:16 +0000 (GMT)
Message-ID: <c1deb93a-a2cd-4a5f-a8e2-9cc078f407c8@linux.ibm.com>
Date: Wed, 25 Mar 2026 17:30:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/24] fixup! KVM: s390: Remove non-atomic
 dat_crstep_xchg()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        imbrenda@linux.ibm.com
Cc: jjherne@linux.ibm.com, borntraeger@de.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com
References: <20260325210149.888028-1-akrowiak@linux.ibm.com>
 <20260325210149.888028-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260325210149.888028-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI1MDE1NyBTYWx0ZWRfXyhoNxg+pmBdK
 e1uWPqmoiDn/QSABODwXIEd9vL0LVQd5+Pm42tMgvZw9CpRQ+tjZiXIDd2PH03+SCeRaBG4MaLG
 v0bZro0F0ddvnBaTFvrFb5oHNw4rfj0/Xrg2SOHnW3J/T8fk+ME2hLvRj+Mr+DVjMkGUMo/Zo7x
 zU1k9NJVUnQ8xtauaQoI56qtVpdov5Lh/fhtGTUVeWGvTuCilNTA2LTBrwePDY71qi22PUUFpiR
 5KdMlHFBcsHVPcUodkxCd+RByFMz/++VxeOmLhdH26nSxwvm0JE8GBwf7iYXUIPK4IGomWkJXSV
 o2BLiNJRkl/fWU7Ly73gzL50DCNTFaXeJNgPD9UnHAK+FtkJhBo+nQ8MROHIv/kvQmswF27iSsu
 0gnt+ZDWcrmELOQ81nGWnzwOIfj/5NvoSo2MN3BmgqNWSzYv/mYmKzAHUov8jmOAmd3ODf9nXag
 sZbzbOGpGlpwQg0e4OA==
X-Authority-Analysis: v=2.4 cv=JK42csKb c=1 sm=1 tr=0 ts=69c453eb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=CxopoHNdSZbKf0LVR9MA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 8w5xI3DWBbCrAnKlx_ILlW8dIwBhCcyP
X-Proofpoint-GUID: 8w5xI3DWBbCrAnKlx_ILlW8dIwBhCcyP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-25_05,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 clxscore=1011 priorityscore=1501 malwarescore=0 adultscore=0
 spamscore=0 suspectscore=0 phishscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603250157

On 3/25/26 5:00 PM, Anthony Krowiak wrote:
> From: Claudio Imbrenda <imbrenda@linux.ibm.com>
> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Tony/Claudio, I suspect this was included on accident and will be
handled separately and dropped from this series?  I don't even see it
mentioned in the cover letter.

If intentional and intended to be part of this series, then please add a
proper commit message.

> ---
>  arch/s390/kvm/gmap.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.h
> index 967a280b3235..19379d162777 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
> @@ -198,7 +198,7 @@ static inline bool __must_check _gmap_crstep_xchg_atomic(struct gmap *gmap, unio
>  							 union crste oldcrste, union crste newcrste,
>  							 gfn_t gfn, bool needs_lock)
>  {
> -	unsigned long align = 8 + (is_pmd(*crstep) ? 0 : 11);
> +	unsigned long align = is_pmd(*crstep) ? _PAGE_ENTRIES : _PAGE_ENTRIES * _CRST_ENTRIES;
>  
>  	lockdep_assert_held(&gmap->kvm->mmu_lock);
>  	if (!needs_lock)

