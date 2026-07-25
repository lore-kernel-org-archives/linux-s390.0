Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24EE37E5D6;
	Sat, 25 Jul 2026 16:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784996846; cv=none; b=Ow2+uPGu1J/rs8PVHDh9n44qpp5pAbXQ+XCfkwlIjxcfBSCo7DrIoCerZCT1EuHi4ls7SxZNyRewCMGx4d6w4gP7ta+HK/HOejxYdTwmdWY3K45kqnEuLwlLnG+A/jGGvAdK198bVL08BPKsrsr5aJ1jPExEUvCGNNpICpb8yIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784996846; c=relaxed/simple;
	bh=0QRkAw/JaBkre0lhpOqTQdLvlR0reh+r9yP12XhII9Q=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aXk4tuYsnFWiYV6Dx6UVLSGPYmg9GcnE72+vcFLeKV8uFXHzazVtSVSG8SCBfnIzMUfFwNWmnYOjEa4OtAp85016UJNVoFyS0yc/796nsUARUAeCTjkbomsgM4EjimsmMAbIK+lJm/JPANOmcXU8Iw9IIeZ9u/synjJgH+liykA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Hfq9n/u2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Hfq9n/u2"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66PDmSg3816328;
	Sat, 25 Jul 2026 16:27:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=HR9UH2
	A0YlFsNPncZXWzi/IAXkDvnFOgbulY7B2MqUY=; b=Hfq9n/u2SBE8RKATI4kS5A
	ly0mCSDAXqwSOnCvTSYlKJyPS9VhGIyiT+RV3RL39fBoKnlv4R7vGQRes9TMmQiZ
	1wP7KaAlSO0jGrUIT+lKxpe39re1APwxTWpkahjgLBquPDFFL2FDHdSt6K/jEQyt
	vHfXnQSG2gMcVYNiFwN3HioAVBJq8+5VrX2v/AlNwr4JAn2W/dBEMSVSCGl0vnUe
	LolXha8XcHkPvY1mutz5YLij5cdIOOyKE4TOBBWdwBpNDFf/o22cFnO0gpXJ9LlY
	8gbZI6/pResVL/yNnOcUarw6PbjB2OtblD4u8KHpz3fpn/fiwRalwOkhL2AOHLnw
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0x8qcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:27:21 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66PGQP6h017484;
	Sat, 25 Jul 2026 16:27:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fmn331tfn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 25 Jul 2026 16:27:20 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66PGRJ2T24904282
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 25 Jul 2026 16:27:19 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4726758057;
	Sat, 25 Jul 2026 16:27:19 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A8BCC58058;
	Sat, 25 Jul 2026 16:27:18 +0000 (GMT)
Received: from [9.61.125.168] (unknown [9.61.125.168])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 25 Jul 2026 16:27:18 +0000 (GMT)
Message-ID: <2d14a562-daa6-48f2-8d7c-0e5c2d011213@linux.ibm.com>
Date: Sat, 25 Jul 2026 12:27:18 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/9] s390/vfio_ccw: ensure index for read/write regions
 are within range
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
References: <20260725152705.3958100-1-farman@linux.ibm.com>
 <20260725152705.3958100-7-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260725152705.3958100-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pTxauZLYA248dNLyltz1PlcCozyr3Uzr
X-Proofpoint-ORIG-GUID: pTxauZLYA248dNLyltz1PlcCozyr3Uzr
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI1MDE1NCBTYWx0ZWRfXzgb1aa3lf4aV
 onH/J6UzQ9dY4zEsENSWtWfg3foFjWekMGlwxiWIEnusSqfO6NcLMqjM9SjR7nVSatk+BfiYnUq
 HdGgXKtrYmCmsxAK/8u3wTlUU63lnac=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a64e3e9 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=cGiaVNcBUXJiE0ilch8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI1MDE1NCBTYWx0ZWRfXy4vXuxE1LZSQ
 EULM+Hl/7hWO9+8rOzoGOA8fsN9OgwJ/IDyC3faGnrt1AiVnvRed+ZLiwKh9Ph++diJb9wDQzd/
 2QVvPJxx56RmC+S8q83lr3ii0luLDW1KGcCOTbRAyLSTrXyGydeNpcKVOvqBVjvuIw3p1Ly57/B
 FTn5ZTeoUJlk2sDvbe+TgDhjZkFxgALZopbIX5EzHesLpap7O8g/U7NE2DT9S2KCOY4T4P7L9rj
 91RFkQFamXkJbLWdidL/+NTONSoCWA+EQpBpXoQJxLmBlyJ5Q832gDIwVMl1eDr5k0Ahtc9QIR4
 gzt8Qi7O2MWfM1KnbIcCyP0TSDCXC9MVMIG9MfHtHV7SA56Nb0FPYdIcJR02xdGCF4jNUiKJ42e
 UoEOai4JEZpT7rLAzDZNh6xzeM2UEbCVna1Ftncl1l45vTM9xVMImhmjI+XZ63JFvCvn3MgYFdm
 L+EmBqqdORaPtxn1LHQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-25_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607250154

On 7/25/26 11:27 AM, Eric Farman wrote:
> The introduction of the capability chain rightly clamped the
> region indexes to the range of the capabilities itself, but
> neglected to do so for the existing read/write regions which
> should also be enforced.
> 
> Fixes: db8e5d17ac03 ("vfio-ccw: add capabilities chain")
> Cc: stable@vger.kernel.org
> Cc: Cornelia Huck <cohuck@redhat.com>
> Signed-off-by: Eric Farman <farman@linux.ibm.com>
> ---
>  drivers/s390/cio/vfio_ccw_async.c | 16 ++++++++++++++++
>  drivers/s390/cio/vfio_ccw_chp.c   | 15 +++++++++++++++
>  drivers/s390/cio/vfio_ccw_ops.c   |  7 +++----
>  3 files changed, 34 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 420d89ba7f83..4aff0b58fa5d 100644
> --- a/drivers/s390/cio/vfio_ccw_async.c
> +++ b/drivers/s390/cio/vfio_ccw_async.c
> @@ -8,6 +8,7 @@
>   */
>  
>  #include <linux/vfio.h>
> +#include <linux/nospec.h>
>  
>  #include "vfio_ccw_private.h"
>  
> @@ -24,11 +25,20 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
>  		return -EINVAL;
>  
>  	mutex_lock(&private->io_mutex);
> +
> +	if (i >= private->num_regions) {
> +		ret = -EINVAL;
> +		goto out_unlock;
> +	}
> +
> +	i = array_index_nospec(i, private->num_regions);

LGTM.

...

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_ops.c
> index 45ec722d25ea..032a1cdf4df7 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -243,6 +243,7 @@ static ssize_t vfio_ccw_mdev_read(struct vfio_device *vdev,
>  		return vfio_ccw_mdev_read_io_region(private, buf, count, ppos);
>  	default:
>  		index -= VFIO_CCW_NUM_REGIONS;
> +		index = array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->read(private, buf, count,
>  							ppos);
>  	}
> @@ -295,6 +296,7 @@ static ssize_t vfio_ccw_mdev_write(struct vfio_device *vdev,
>  		return vfio_ccw_mdev_write_io_region(private, buf, count, ppos);
>  	default:
>  		index -= VFIO_CCW_NUM_REGIONS;
> +		index = array_index_nospec(index, private->num_regions);
>  		return private->region[index].ops->write(private, buf, count,
>  							 ppos);
>  	}
> @@ -338,11 +340,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struct vfio_device *vdev,
>  		    VFIO_CCW_NUM_REGIONS + private->num_regions)
>  			return -EINVAL;
>  
> -		info->index = array_index_nospec(info->index,
> -						 VFIO_CCW_NUM_REGIONS +
> -						 private->num_regions);
> -
>  		i = info->index - VFIO_CCW_NUM_REGIONS;
> +		i = array_index_nospec(i, private->num_regions);

...  These didn't at first, but then I realized that these functions in
vfio_ccw_ops.c each had pre-existing checks of index against
VFIO_CCW_NUM_REGIONS prior to this point.

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

