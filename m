Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D580437114;
	Thu, 13 Aug 2026 11:55:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786622114; cv=none; b=fZOnRkCUycDqpeGCawPwH8Uv2sHntrWGSBXVgyMh30W0BLiO2Oi6ilRSHrFWqibXWb16VqZiF8J17bCa6yzh91EY4bKyRgo9vKyaaF/woIi8GGQzTQAiyK8A6al9fhvbC4a926zbEI5NOXIbLdc1pPK/v7GkGn/CE9NCBE/ZQeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786622114; c=relaxed/simple;
	bh=lW9g78pmuj5XUCrIFuiVyk8c7sZFJyiFq9/carze9/I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tqNtfn6B+VWqGpoJjZXUDSBgAs5gl5TopTf3v97F4pbY9LWYp8eU97R7U11HHVkiePcvOS6yG59VrMjuot5Em6xnwOsF6cOSUjUSN/aLZD6pXMcFW8kI4bHLZz+6fZZnomB9nlL5tRnts5rNVn2Nv1Af0Ffycvu55nw6MZ1rgYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WzA1ycEz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WzA1ycEz"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67D994er043076;
	Thu, 13 Aug 2026 11:55:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=yz9BAG
	xJ/DiFdn4JjHhko9lIONWMlZPCx26u5Ghw6uM=; b=WzA1ycEzOM5EWdz0DfB+37
	JiwV21L5TfuFtvLYByBN3XmMiUC+68QQ2iVOiT7Mw41lwsrvu0wC8Ff5cgBgVyzC
	OGDCzsRo8q4wOhKgpRRkp0USm8LajTnD5q20NxlgP0hc79j/ezof3/Rck4HWgBJQ
	AWw96BOW4HQsDM+MrCdsXnL4/hpFqiEvHzJ1rVFqdOR55T8myQaX0xDpCUQl3K55
	Js6A95Pg4+wmz2ZoWEhSp/mtRZSWweGalM5ZS6u98jogOsO7b4sDsEqTnVZX9TiF
	WxJGaJMWT/wSXWEbXLN/OlhfvY3eTrCG02r+XCWzpXPINuLtr70qh5MC8zvrucmA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk07pb9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:06 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67DBfHJc023439;
	Thu, 13 Aug 2026 11:55:05 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsk2urq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Aug 2026 11:55:05 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67DBt48x18744056
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Aug 2026 11:55:04 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4E53958052;
	Thu, 13 Aug 2026 11:55:04 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C20E558045;
	Thu, 13 Aug 2026 11:55:02 +0000 (GMT)
Received: from [9.61.3.203] (unknown [9.61.3.203])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 13 Aug 2026 11:55:02 +0000 (GMT)
Message-ID: <abb3cf85-52da-4375-accd-287d5df98eb8@linux.ibm.com>
Date: Mon, 10 Aug 2026 09:14:33 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 01/15] s390/vfio-ap: Provide function to get the number
 of queues assigned to mdev
To: Anthony Krowiak <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc: borntraeger@de.ibm.com, mjrosato@linux.ibm.com, pasic@linux.ibm.com,
        alex@shazbot.org, kwankhede@nvidia.com, fiuczy@linux.ibm.com,
        pbonzini@redhat.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com,
        agordeev@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com
References: <20260807221834.562851-1-akrowiak@linux.ibm.com>
 <20260807221834.562851-2-akrowiak@linux.ibm.com>
Content-Language: en-US
From: "Jason J. Herne" <jjherne@linux.ibm.com>
In-Reply-To: <20260807221834.562851-2-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX1G3n9JOv1XPD
 tJuqoJ2HRls+47ofBg37Q8eguOjJw1VIPo98ctzMOA3C74HlF+V6GGAFtJP23u/w+xWX7i3CP1S
 RfXrx5HhyZc5qHRtRwgrTtTzP97fOUzjvhu2qCKxaQaT5vvocnX8iPx4rxlago0KfcyuceVH7p3
 4va6OdxnQrWUGDJC4feWcsSI5uSah41GpC+ScXPqvCItOe/srPW5bD4fYFv4I8f+UR3NJdTkbXC
 C4svhJ/dohW79My9MY/kWq+Z1JfEZP1+d72K49T7/VHjiLGhIhhpg/tZ/pCBiOSimd955RoWkHk
 RxHrhDG/eyYwhOu2fva2MZbzr0tllJW6szee7w3VStGE70nI82s+tsjYbr5Sgs5rmgvq7ecfWFo
 kvrEECLOS/x0x/oKYMx7nCoJYTRKf2D7LHzRwWaerrN+Hy+fu4uhq3yElLuFxwDzGVVH4POBxvQ
 ub0FPVOYYagDpAmLzWA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEzMDA4MSBTYWx0ZWRfX0GlmRMUxc8Vf
 nUkKciywhoZ3HUoydFpvOJOaCYCBoWs2d8SngkmY7JwLqoq8UmXytKnWDBNzt89+NVpl9YdECCM
 RsqNj9nDrlIH2uQkKfzY88kBhbyAFC4=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7db09a cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=Hris5y_VtiwXNOhm0gYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: jcRSnBPLUYmn--6TskD9X4Sy6-95WmtR
X-Proofpoint-ORIG-GUID: jcRSnBPLUYmn--6TskD9X4Sy6-95WmtR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-13_03,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608130081

On 8/7/26 6:18 PM, Anthony Krowiak wrote:
> Provides a function that returns the number of queues that are or will be
> passed through to a guest when the mdev is attached to a guest.
> 
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c     | 8 ++++++++
>   drivers/s390/crypto/vfio_ap_private.h | 2 ++
>   2 files changed, 10 insertions(+)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index 44b3a1dcc1b3..36786d70a88f 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2098,6 +2098,14 @@ static void vfio_ap_mdev_request(struct vfio_device *vdev, unsigned int count)
>   	release_update_locks_for_mdev(matrix_mdev);
>   }
>   
> +int vfio_ap_mdev_get_num_queues(struct ap_matrix *ap_matrix)
> +{
> +	lockdep_assert_held(&matrix_dev->mdevs_lock);
> +
> +	return bitmap_weight(ap_matrix->apm, AP_DEVICES) *
> +	       bitmap_weight(ap_matrix->aqm, AP_DOMAINS);
> +}
> +
static inline unsigned int bitmap_weight(const unsigned long *src, 
unsigned int nbits)

bitmap_weight returns an unsigned int. I think 
vfio_ap_mdev_get_num_queues should probably return an unsigned int too, 
for maximum typw safety?

Other than that:
Reviewed-by: Jason J. Herne <jjherne@linux.ibm.com>


