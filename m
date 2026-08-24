Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F573644D4;
	Mon, 24 Aug 2026 15:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787583844; cv=none; b=VcSsInNgUw+OUNn23MCVOHPbh/FQtIMJDsit07e0zMLFTcRQzHOZv25W6XyprOYAD8lIi7HMhnM963Ute5g2PZKqaB8W5Ar3JyPppOtUeUuFoXWOaJ90y9H3tAcAH7PyxlLHdgP6ZFEBZgXVl82zZQ037U5Ib6JPtC/NGnXOz0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787583844; c=relaxed/simple;
	bh=GAUW59keKCXWzzmAtIs0BkMagu2uhlzhJuS7LC3Ad/c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IrO8eTVDIlalWLfQzvo4NTmCvsNYRSScNK4CRlnwbaqyzHXoUTzE5UykREDQYB44SlOvYcnblsvlG85WYhCqPLerSQR7SXdRfwKZrLGdpccxcCxOb4nTCSsfkq0R83DtKde39hAWpBOkyLYsO/L4SOWifEO5DSXJbm7b8Jny5cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y0A/mzSr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y0A/mzSr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67OD1USn084911;
	Mon, 24 Aug 2026 15:03:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=vBhEbG
	8ZiS2sUkDLgtnE9KhlLxdnPA2S6CKV5jFF8dg=; b=Y0A/mzSrdILZXcV42ICsKu
	OSDCA6Vw9ulu/RvURmQI+BFjRy+zLZFwKDHPN+jCYo9m+GWQiObPNEGUALXkWQM+
	1RiB8BZwu/hMBzHZCNTEP2FU1aDIrIGoTZgK4rKh91rkf1gO259xbwO6FKMGYyZR
	b9D7RofYdb8XH+/jFcdnZfQ8AFFOlIw86KIKZd8u/mqSYQlUEq2iosaD/H7RogKx
	aCjElq8qQGJIbUC+8QsLzQGZeWZsYyDrP6M2+2ye4L7zm2/fxXC1IKZqrw0XjNvE
	+HqHMK0fbiswpeDhnheHQv244Oalz1BSrkc61C1Bs5nA03muOGCtgA6Xcg9ScvbA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73eqj4us-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:03:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67OEuG16017167;
	Mon, 24 Aug 2026 15:03:51 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsxxeet-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Aug 2026 15:03:51 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67OF3oca26215026
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Aug 2026 15:03:50 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A32FE5803F;
	Mon, 24 Aug 2026 15:03:50 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A79255805A;
	Mon, 24 Aug 2026 15:03:49 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.61.159.18])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Aug 2026 15:03:49 +0000 (GMT)
Message-ID: <69c6d33a-9f8e-404f-8506-41dc20e469f9@linux.ibm.com>
Date: Mon, 24 Aug 2026 11:03:49 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] s390/vfio-ap: Use AP_DOMAINS for adm_add bitmap size
 in vfio_ap_mdev_cfg_add()
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260824135850.503728-1-akrowiak@linux.ibm.com>
 <20260824135850.503728-5-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260824135850.503728-5-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: E5gdSoTx1NFKYK4P1K2QFKhMHgXQHeC8
X-Proofpoint-ORIG-GUID: E5gdSoTx1NFKYK4P1K2QFKhMHgXQHeC8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfX61bT1i7Hvz6a
 a7DwTjJ/GWHGqMJVVkY/dghoVXlcSgqTwh9SKjlC9PCmsXaZEr4bBCeer3D4xZC7smxJQOT0KdR
 lqz9IGNSo8jK2cznrCX78U5e4biYdnORkODLhD7bWTKvwwMr8RkUjbnDVYHGu0lVOeTrQT0Qd02
 3ls7b2wVWo5tYku/zxFXUi3gYcz8evfcfziqdaU8NPKyX9/NCWobKUGUeTASdr9WyA46wZpxojn
 F2MVk+anz8NYazE64VEDpvAsaC3A/ATY/2FEm5TJMMhk73JRQTCZtqc0toBRNut9dPzCMhcLbww
 AwjXbsBInOTT2MEiKqFrooiaAifxxVfr7dl3J1ErU2hSTCq4vFF4kRkcIh3MjW3qsLZKZflzhaF
 c8ivKfRBvAn3LPkPS7oA11NYsbFQA+CTtYU4OWUGHOzQj7H56xrmaYmbNxz7EMWiyj2/i1/ZUIK
 /KGJIFgY3MHkj29uyWw==
X-Authority-Analysis: v=2.4 cv=QsRuG1yd c=1 sm=1 tr=0 ts=6a8c5d58 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=MUCPCBqibscqCCpCrd0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI0MDEyNiBTYWx0ZWRfXxGXOl2MVEe5t
 +oOhc8jKl05RjdsfrtOPPqkc8IX4RVYUGTIoAlrw/GwcU1GZIWvnmxUXnf+CF6F3uv5EZ8Od2aV
 XE/WYnWH+4rKnYmw/WnjDhkIQcM1jwg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-24_04,2026-08-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 spamscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608240126



On 8/24/26 9:58 AM, Anthony Krowiak wrote:
> In vfio_ap_mdev_cfg_add(), the bitmap_and() call that computes
> the intersection of newly added control domains with those
> assigned to each matrix mdev passes AP_DEVICES as the bitmap
> size instead of AP_DOMAINS:
> 
>      bitmap_and(matrix_mdev->adm_add,
>                 matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
> 
> Control domains are indexed by AP queue index (APQI) and their
> bitmaps are sized by AP_DOMAINS, not AP_DEVICES. The two
> constants are both 256 today so there is no functional impact,
> but the wrong constant is inconsistent with the two bitmap_and()
> calls immediately above it and with every other operation on
> adm/aqm bitmaps in the file, all of which correctly use
> AP_DOMAINS.
> 
> Use AP_DOMAINS to keep the code consistent and correct in case
> the two constants ever diverge.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index c7eebbd0ed40..e62e0dfa7282 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2840,7 +2840,7 @@ static void vfio_ap_mdev_cfg_add(unsigned long *apm_add, unsigned long *aqm_add,
>   		bitmap_and(matrix_mdev->aqm_add,
>   			   matrix_mdev->matrix.aqm, aqm_add, AP_DOMAINS);
>   		bitmap_and(matrix_mdev->adm_add,
> -			   matrix_mdev->matrix.adm, adm_add, AP_DEVICES);
> +			   matrix_mdev->matrix.adm, adm_add, AP_DOMAINS);
>   
>   		mutex_unlock(&matrix_dev->mdevs_lock);
>   	}

Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>
