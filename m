Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A020B362154;
	Fri, 24 Jul 2026 19:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784919699; cv=none; b=AWVBfQ/malfcZVay0laOfkXz7N2WL1rf+oDsGIxP6ZFmYrPW2qhmPXeQY/2AJDKdVMBOY1ZYa5e7rkJtalsbrn6LW2RVQ+GKggRAlNjxbhIR4bdiJqEwGgKeKQwEZzzX0EQvWpdZSol8GM0dyhI0wLW6vCWpFpIE9QgVvRHja+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784919699; c=relaxed/simple;
	bh=uMNBhZSK00on9lX0ldEsFJFjAVteVm/itGtjjhD4H3U=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l5X3TFd+ysm8eRibQxBlfZOmgwiFdfDo7lEA5gKoFvGpKbw8y0x7kRAx40XqbFWQpAQlQc5hdVvp2x2q4gAr5K68cyOc0J9mEZ3+3+4CR0b6eItxGSxeNpwbzhFARSUvJUywubFhfbYlNaKzsDFk/yR5etNX7pVvvJIQvFCrwJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DC7dY5/N; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DC7dY5/N"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66OHBuHF2324507;
	Fri, 24 Jul 2026 19:01:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=nNwWSl
	cLt6GyltvZuzKPMHDSxubSotyybJi3glyGN3E=; b=DC7dY5/NIRxUn9o+zUZTtY
	RbkaabX9GJ7RSVOALzMclTcETaStKsyYRnPJ+d0jYb1ClCwc1sC+vRnSaILS+PE8
	c+SUohxmFNsGsS7Gnr7tN9TbV7yQqVXsD3zEEObfLo5UysX3dZ8jyvIwNojYyBnQ
	LRZK9iwKptq4PTpaaQ2RraIpV+Re3LtUmLBC/Ky7YCuDVd4pYj6KquHLSqzbTY5E
	wdjXEPkeHnfzGlR96dTpCSWYuIjZCVsUjLHANETH1jEHwg5TXzwp8sbcQWP9Yrl4
	kY1u5ekIOEbY9TKlhdpRANWQGZWwlQ0f4HNSAi82nBzurHfKm+WBbRzL+5UJW6ZQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg78gngsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 19:01:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66OIYcVE015838;
	Fri, 24 Jul 2026 19:01:30 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgktqje4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 24 Jul 2026 19:01:30 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66OJ1TUp22413858
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 24 Jul 2026 19:01:29 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01D7958045;
	Fri, 24 Jul 2026 19:01:29 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 06BAF58054;
	Fri, 24 Jul 2026 19:01:28 +0000 (GMT)
Received: from [9.61.177.4] (unknown [9.61.177.4])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 24 Jul 2026 19:01:27 +0000 (GMT)
Message-ID: <1fc1a866-74d5-49a8-9ea9-f2554589548e@linux.ibm.com>
Date: Fri, 24 Jul 2026 15:01:27 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/8] s390/vfio_ccw: ensure index for read/write regions
 are within range
To: Eric Farman <farman@linux.ibm.com>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Halil Pasic <pasic@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        stable@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
References: <20260723174751.1180334-1-farman@linux.ibm.com>
 <20260723174751.1180334-7-farman@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260723174751.1180334-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfXzTZOoyFFUwmu
 icqOnRkZc9/Q9K55Bzdrj7FuFpLaYJKZVMD67UJe8KrprKOjcyFs+w4bolsM4svs16p7zmuPZBT
 KZu5Wy4A3jXj+wTaHETauLwTSOLsqsMKtvhOjgs7TgRYzi5GJ3c6OGphrcYd5ImrjNimysSRFao
 exzTWrC4sHRSrasEPgnk6XmGIjN/rtHeNUsJVKQgNuJoGWalYgRguqgkFImppIUS+E6Un8KhOCi
 H77oFO5nQRpdRghqwqSNwrgCe7JIE8156VpjEb9D0JeFjPQwhfCrHZKEASZ9cszRT+JmPO1e9FD
 dlJsqEJELB5xbm3bFNRfteTBnULZTeWYjGyoYTYr5msQBackX8qKKLFH7vEtR2XwOlKnHVf87fr
 loZaoEWCK2MLMNIYJHMdaoKLmqeedTMCn4tB4N1XJubzwFdp440UeVVp7Z8ckTIRX7zGyBw7C80
 yACvCLF2LMHQ4XA+uIw==
X-Proofpoint-GUID: 41BANjC97tt2UR8wp6z0Fy4rE4gNRpyE
X-Authority-Analysis: v=2.4 cv=MelcfZ/f c=1 sm=1 tr=0 ts=6a63b68b cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VwQbUJbxAAAA:8
 a=20KFwNOVAAAA:8 a=VnNF1IyMAAAA:8 a=hBBn9mCUk0k-jeIHgn0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDE2OCBTYWx0ZWRfXzJsKe21b8O7l
 Z6SnDyQsGM3or3HHyuWl34FxA3NnFt9TBmHUjgabc++RTzv2mc350hJ8v1oWIK1qkLlTIafdOei
 VTBMPq4iTxwvnqkQPbBrrqYRZLIpidE=
X-Proofpoint-ORIG-GUID: 41BANjC97tt2UR8wp6z0Fy4rE4gNRpyE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-24_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 spamscore=0
 clxscore=1015 malwarescore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607240168

On 7/23/26 1:47 PM, Eric Farman wrote:
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
>  drivers/s390/cio/vfio_ccw_async.c | 4 ++++
>  drivers/s390/cio/vfio_ccw_chp.c   | 4 ++++
>  drivers/s390/cio/vfio_ccw_ops.c   | 7 +++----
>  3 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/s390/cio/vfio_ccw_async.c b/drivers/s390/cio/vfio_ccw_async.c
> index 420d89ba7f83..f213f62f6641 100644
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
> @@ -24,6 +25,8 @@ static ssize_t vfio_ccw_async_region_read(struct vfio_ccw_private *private,
>  		return -EINVAL;
>  
>  	mutex_lock(&private->io_mutex);
> +
> +	i = array_index_nospec(i, private->num_regions);
>  	region = private->region[i].data;
>  	if (copy_to_user(buf, (void *)region + pos, count))

Couldn't using array_index_nospec cause us to accidentally operate on
region[0] if ppos were ever out of range?

By comparison, vfio_pci_ioctl_get_region_info() does an explicit check
first, so to do something similar here and elsewhere in this patch:

if (i >= private->num_regions)
   return -EINVAL;
i = array_index_nospec(i, private->num_regions);

(Note that for this case and vfio_ccw_async_region_write my pseudocode
doesn't account for io_mutex)

>  		ret = -EFAULT;
> @@ -48,6 +51,7 @@ static ssize_t vfio_ccw_async_region_write(struct vfio_ccw_private *private,
>  	if (!mutex_trylock(&private->io_mutex))
>  		return -EAGAIN;
>  
> +	i = array_index_nospec(i, private->num_regions);
>  	region = private->region[i].data;
>  	if (copy_from_user((void *)region + pos, buf, count)) {
>  		ret = -EFAULT;
> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_chp.c
> index 38c176cf6295..bf678270c457 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -9,6 +9,7 @@
>   */
>  
>  #include <linux/slab.h>
> +#include <linux/nospec.h>
>  #include <linux/vfio.h>
>  #include "vfio_ccw_private.h"
>  
> @@ -26,6 +27,8 @@ static ssize_t vfio_ccw_schib_region_read(struct vfio_ccw_private *private,
>  		return -EINVAL;
>  
>  	mutex_lock(&private->io_mutex);
> +
> +	i = array_index_nospec(i, private->num_regions);
>  	region = private->region[i].data;
>  
>  	if (cio_update_schib(sch)) {
> @@ -97,6 +100,7 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_ccw_private *private,
>  		list_del(&crw->next);
>  
>  	mutex_lock(&private->io_mutex);
> +	i = array_index_nospec(i, private->num_regions);
>  	region = private->region[i].data;
>  
>  	if (crw)
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
>  
>  		info->offset = VFIO_CCW_INDEX_TO_OFFSET(info->index);
>  		info->size = private->region[i].size;

