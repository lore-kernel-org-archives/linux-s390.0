Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F2CF22BAB3;
	Thu, 16 Jan 2025 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737042108; cv=none; b=TUVBM58Oc/I/Cc272K0/7toI8QHjaGIUld/3fTLTt1Tik1QzKJ2jEWscazLIpwZzxh6mRIkHjYA+BKI2RGZXef2z0Sfdit08i3w9uyvJx8RfPw0Mxpk2BRYSrC8IWIw6q6pXPlT5U2pmpCoM8KPSpnWdmfKJXsDkzY2TUOd3flY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737042108; c=relaxed/simple;
	bh=WRgb2WIjYPs6oTXd+wiqvISHTGUD7dIyS/oT/rcE4Es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DYwPvVT698t2Df/0FUs09ciJOiclTz3dL7qUW9uYVo97qFodQOT3eevQuXLRu4hpEGiMxEDxuMHdQJNyUNDuxsBOKb7wqOkUwL1VCQwJtP9T56QDG1316IqJH2M/YVnJh4PUVQBTuGJ/QnlUz8VDc+8l5TYAe0AQ7/oVLg3/kt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZB7B9enB; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZB7B9enB"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50GCSDxN028423;
	Thu, 16 Jan 2025 15:41:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2cERSA
	WDweVFJA4tlNhI7lzvAjc8fz5T3kJQCOUuts0=; b=ZB7B9enBlQwr9J2dIDuTBI
	RSYVhUeUZjk17b/iQVX//m9e8RsGpV76ibh7UhG8aFqhBz5vR9QUBYHfUrc7hHJ8
	6cDBw03rlTUFMZWrPBTF0LIyTk3KRHHe0IAYXlHzkR39LeQKUSz25xYuNZ3kjAbr
	QA6hWaNyHwzD31zoGG1LH9A+ncPf8PFaNGb1JKC7gqvwoepXzfVO9Kc2is6ZnjY0
	Fw/NuQiDRIyIH9MsyX3/SEAXGqHn9VDqN3l7XPI3Oi7LAdagDF7ptcdhpfgQn+4k
	qdN2LFvcnUkq/HuvX8Y/gxozaUY3vx0O/SRtFAlBC2LlcC68rDhUvzICfngmn0rw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 446q5hv179-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:41:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50GDmnSl007386;
	Thu, 16 Jan 2025 15:41:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4443yneg49-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 16 Jan 2025 15:41:36 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50GFfZXG39125594
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Jan 2025 15:41:35 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CDA15805C;
	Thu, 16 Jan 2025 15:41:35 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CFE605805D;
	Thu, 16 Jan 2025 15:41:33 +0000 (GMT)
Received: from [9.61.176.130] (unknown [9.61.176.130])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 16 Jan 2025 15:41:33 +0000 (GMT)
Message-ID: <6b898f8a-4ea0-421c-bbd2-cf318f0d5a5f@linux.ibm.com>
Date: Thu, 16 Jan 2025 10:41:33 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Fix indentation in vfio_ap_mdev_ioctl()
To: Thorsten Blum <thorsten.blum@linux.dev>,
        Halil Pasic
 <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250116131146.105439-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250116131146.105439-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _zb9zkVWC_9OHgiNOcRPZFpazXuiHvca
X-Proofpoint-GUID: _zb9zkVWC_9OHgiNOcRPZFpazXuiHvca
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-16_06,2025-01-16_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 phishscore=0 suspectscore=0 spamscore=0 mlxlogscore=999 clxscore=1011
 priorityscore=1501 impostorscore=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501160117




On 1/16/25 8:11 AM, Thorsten Blum wrote:
> Remove any extra indentation to improve the code's readability.

Ironically, I noticed this the other day and was going to fix it.

Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

>
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index a52c2690933f..155e19aef5df 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2199,8 +2199,8 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>   		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
>   		break;
>   	case VFIO_DEVICE_GET_IRQ_INFO:
> -			ret = vfio_ap_get_irq_info(arg);
> -			break;
> +		ret = vfio_ap_get_irq_info(arg);
> +		break;
>   	case VFIO_DEVICE_SET_IRQS:
>   		ret = vfio_ap_set_irqs(matrix_mdev, arg);
>   		break;

