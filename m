Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 732CC3D333E;
	Wed,  8 Apr 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775658901; cv=none; b=bka1kGIF3Oxcr3+8CifrN4bK2rMzjMrF1ZwR9iGM1OfgXSTA8YswvpX4tsVg8tI6mvMA4WKHsfv+QcGlup82G6P9uvD5Wj2LE22dmMZOnbJch1mZ1PzJR9gMd3HZ0ycyz7El3NT6F3oYLVu/Huz73jFlWYGmWgWJl/Tyswvx8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775658901; c=relaxed/simple;
	bh=cGn3mWczE8KwdzRV6yr8IYFSQyCLRqP+Kc7TFM2zr+k=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gMBAnW/U46KjC0t6dQ1OnEB/YRe6ijqblOhdyLI5qg6Il/JEfcu2Rg643ZTcPToRX/j83dd0C1KWvUpB8UnqjEZhIyW7zd/OF7w4y2gtARRveDSclpopqRuRQSUliot1jwR9hO3Ap66sCGc7/VMORuxO6Q8eVk4VouOmdsZjW00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bvnCDav6; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bvnCDav6"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6385CQO52302379;
	Wed, 8 Apr 2026 14:34:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FE3y9T
	frXiNDTc2jKKxIVUutVtsW/XQ9PDAxoq0O3jU=; b=bvnCDav60MHawM7ILCgQzN
	dblq+43q8W6gpW4o6iC0LHzYTtd67cT4hN5er7F9gy+1eM8B1qGSG8yHErCt2Gwe
	CN52vu7CHW+evidcgr/ku+ZkKPnLb8AzU0BkbdBUTY7UWTfpHa4d3EwDy9X0BJle
	jLrwAM66eCvJGzVNSIEs1UJ1IUeESYrwVtt15o1mimbHePTtD3YmiRVSqGaRiVt1
	mLXnoOGdUp+u9CUZJSQULr9UKyGALnPqDChgiS90pzFgqz3Uy4szykxZ4+9kYe9c
	bf8LshGGtT+KcRTU/7UjYUMyHFNofBwnj6y8IGW3NIUNGf/N4QXFtsEdZGZf3byg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dcn2fgfng-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 14:34:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 638AuiD4013821;
	Wed, 8 Apr 2026 14:34:53 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dcmf47rm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Apr 2026 14:34:53 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 638EYqSn62783986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Apr 2026 14:34:52 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A393158055;
	Wed,  8 Apr 2026 14:34:52 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F7B25804B;
	Wed,  8 Apr 2026 14:34:52 +0000 (GMT)
Received: from [9.61.9.193] (unknown [9.61.9.193])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  8 Apr 2026 14:34:52 +0000 (GMT)
Message-ID: <6569b8b8-7654-4dbe-a4a6-f1e565451672@linux.ibm.com>
Date: Wed, 8 Apr 2026 10:34:51 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] VFIO: remove dead notifier code
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc: alex@shazbot.org, linux-s390@vger.kernel.org
References: <20260407175934.1602711-1-pbonzini@redhat.com>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20260407175934.1602711-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA4MDEzMiBTYWx0ZWRfXz042Nhu4tz1H
 iquZh414eaxVlrA+hlXH/hqXBjA+7I8GXju4jhmmp7JsCKOmA31+9SB+afdIibtfBturx4BkxE7
 RGZXA4qoB2qCefnYnx6n8ZqSV7dt+i2mOIrbIsuk+0mGTN1gq3RDr5edvTFDIlgPXg2jKQOmO0L
 AL37rqMODiqqrunM7cOMH9d1sUaQXzjDKVpgoezSFbI9R172E8YwBth0FQxBRJtEUf/kPVTdH5/
 LB+eNB9VKzepBHrD7Sp8AahPxwSEbHhyPgGTtLRKexdIZkIZ/VYmhy9C4ELv2jUu8V0tgDNN1JX
 IRm918sNugNk3miaqmZ9Rm5K8r4rg3DsAduc/tYgy+Uo+AVYgQKEADvewYLyRVCSa56VDQpyt8a
 M5HiZFvb2lGObFQJNxBHP9wDOj2dFDvrTLcNhpWoPEi7xjWGE+FkA4ln9o2tpj5seEn5BuCclj7
 by0dlb52KYCNcEcLyng==
X-Authority-Analysis: v=2.4 cv=FsY1OWrq c=1 sm=1 tr=0 ts=69d6678e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=6L0n8PvidacnQo0FCSkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P5wH4-URjmXRQ-XYhtN5Z6xTTj1VIZMz
X-Proofpoint-GUID: P5wH4-URjmXRQ-XYhtN5Z6xTTj1VIZMz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-08_04,2026-04-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604080132



On 4/7/26 1:59 PM, Paolo Bonzini wrote:
> group->notifier is dead code. VFIO initializes it and checks it for emptiness on
> teardown, but nobody ever registers on it or triggers it.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

There are two minor review comments about capitalization at the 
beginning of
sentences in the vfio-ap.rst document in the Documentation/arch/s390
directory. Other than that:

Acked-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> ---
>   Documentation/arch/s390/vfio-ap.rst | 18 ++++++------------
>   drivers/vfio/group.c                |  3 ---
>   drivers/vfio/vfio.h                 |  1 -
>   drivers/vfio/vfio_iommu_type1.c     |  1 -
>   4 files changed, 6 insertions(+), 17 deletions(-)
>
> diff --git a/Documentation/arch/s390/vfio-ap.rst b/Documentation/arch/s390/vfio-ap.rst
> index eba1991fbdba..2de0560bd70c 100644
> --- a/Documentation/arch/s390/vfio-ap.rst
> +++ b/Documentation/arch/s390/vfio-ap.rst
> @@ -431,17 +431,14 @@ matrix device.
>   * callback interfaces
>   
>     open_device:
> -    The vfio_ap driver uses this callback to register a
> -    VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the matrix mdev
> -    devices. The open_device callback is invoked by userspace to connect the
> -    VFIO iommu group for the matrix mdev device to the MDEV bus. Access to the
> -    KVM structure used to configure the KVM guest is provided via this callback.
> -    The KVM structure, is used to configure the guest's access to the AP matrix
> -    defined via the vfio_ap mediated device's sysfs attribute files.
> +    the open_device callback is invoked by userspace to connect the

Capitalization:
s/the open_device callback/The open device callback/

> +    VFIO iommu group for the matrix mdev device to the MDEV bus.  The
> +    callback retrieves the KVM structure used to configure the KVM guest
> +    and configures the guest's access to the AP matrix defined via the
> +    vfio_ap mediated device's sysfs attribute files.
>   
>     close_device:
> -    unregisters the VFIO_GROUP_NOTIFY_SET_KVM notifier callback function for the
> -    matrix mdev device and deconfigures the guest's AP matrix.
> +    this callback deconfigures the guest's AP matrix.

Capitalization:
s/this callback/This callback/

>   
>     ioctl:
>       this callback handles the VFIO_DEVICE_GET_INFO and VFIO_DEVICE_RESET ioctls
> @@ -449,9 +444,8 @@ matrix device.
>   
>   Configure the guest's AP resources
>   ----------------------------------
> -Configuring the AP resources for a KVM guest will be performed when the
> -VFIO_GROUP_NOTIFY_SET_KVM notifier callback is invoked. The notifier
> -function is called when userspace connects to KVM. The guest's AP resources are
> +Configuring the AP resources for a KVM guest will be performed at the
> +time of ``open_device`` and ``close_device``. The guest's AP resources are
>   configured via its APCB by:
>   
>   * Setting the bits in the APM corresponding to the APIDs assigned to the
> diff --git a/drivers/vfio/group.c b/drivers/vfio/group.c
> index 4f15016d2a5f..731dd0dead0d 100644
> --- a/drivers/vfio/group.c
> +++ b/drivers/vfio/group.c
> @@ -456,7 +456,6 @@ static int vfio_group_fops_release(struct inode *inode, struct file *filep)
>   	 * Device FDs hold a group file reference, therefore the group release
>   	 * is only called when there are no open devices.
>   	 */
> -	WARN_ON(group->notifier.head);
>   	if (group->container)
>   		vfio_group_detach_container(group);
>   	if (group->iommufd) {
> @@ -541,7 +540,6 @@ static struct vfio_group *vfio_group_alloc(struct iommu_group *iommu_group,
>   	/* put in vfio_group_release() */
>   	iommu_group_ref_get(iommu_group);
>   	group->type = type;
> -	BLOCKING_INIT_NOTIFIER_HEAD(&group->notifier);
>   
>   	return group;
>   }
> @@ -720,7 +718,6 @@ void vfio_device_remove_group(struct vfio_device *device)
>   	 * properly hold the group reference.
>   	 */
>   	WARN_ON(!list_empty(&group->device_list));
> -	WARN_ON(group->notifier.head);
>   
>   	/*
>   	 * Revoke all users of group->iommu_group. At this point we know there
> diff --git a/drivers/vfio/vfio.h b/drivers/vfio/vfio.h
> index 50128da18bca..0854f3fa1a22 100644
> --- a/drivers/vfio/vfio.h
> +++ b/drivers/vfio/vfio.h
> @@ -90,7 +90,6 @@ struct vfio_group {
>   	struct mutex			group_lock;
>   	struct kvm			*kvm;
>   	struct file			*opened_file;
> -	struct blocking_notifier_head	notifier;
>   	struct iommufd_ctx		*iommufd;
>   	spinlock_t			kvm_ref_lock;
>   	unsigned int			cdev_device_open_cnt;
> diff --git a/drivers/vfio/vfio_iommu_type1.c b/drivers/vfio/vfio_iommu_type1.c
> index 03cefdf99a4a..c8151ba54de3 100644
> --- a/drivers/vfio/vfio_iommu_type1.c
> +++ b/drivers/vfio/vfio_iommu_type1.c
> @@ -36,7 +36,6 @@
>   #include <linux/uaccess.h>
>   #include <linux/vfio.h>
>   #include <linux/workqueue.h>
> -#include <linux/notifier.h>
>   #include <linux/mm_inline.h>
>   #include <linux/overflow.h>
>   #include "vfio.h"

