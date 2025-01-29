Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D842813D51E;
	Wed, 29 Jan 2025 14:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738160880; cv=none; b=kaN2Be4BNThq9lfy04t9/kXC1u6cfoCZJQPs577BH8S3W+9VnVVf01aReufLFsVvXbetL/tF1k6ctVkH7rxS+giWSKQ+WpkgknHUimRs7/1+bk6nMM24ISrM2DdMM3wx+Oc6req2CDVtPyDB7u7RuOEFHIeDzb8rYicL0J6lyLs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738160880; c=relaxed/simple;
	bh=BLI6egnAdGTtnYw+9QuxZLSH7W+BG1KOcngek/cpDXI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l6qw+UgXvMi2GBJSGbRpD5Ww1C2l+BMA18MPjq/bAXqN2/da9uZ2HyJ7h043MOyCW/ESEom12GwCzesKtuHHQHEd/HHm2bArg+AXfEozmn+GmAIjHbLX7adqcAJx7LuOvzzu0v68xckflg2Eogn2DiGka+RDTme1RFzmCkBwud4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OmgqcU7Q; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OmgqcU7Q"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDbftr028470;
	Wed, 29 Jan 2025 14:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=o7Pu6q
	27ML/V8ZUvXNJ2AfseDV8prCHSuR5q4Cio8Io=; b=OmgqcU7Q+o7Mb5MHaGH2CG
	DNukU5JvOlXwvKK6Er7+6J0oD/9nOiaI9zd6hkn1jq53d70pc3IqoBcccW66PMVg
	L3T+4Sjq8k2laEGAG1bDdmwb2yRejubqrhrqhYXZK1tPXRW8VsmGpDF89+MVaRrv
	H+QC71JqtwFwX2oNaWGNo6y12ra1wSmUu5DIHNP7iuz3Lk2pv7fIQa+k0PYk579H
	n/3Jww4ScCFzsJvt1t6MkwHUj4L3uaSSyfPQanRJW4PcEFTSNmGQlIcPc6wP1jTc
	QI95JdBstAaGkFS779BveJ/Ik4pzqW2UxHU2xOlmENBBAq5Hl4GisRU3uUowigTw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb60as2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 14:27:44 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDv0XU028042;
	Wed, 29 Jan 2025 14:27:44 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskgymg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 14:27:44 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TERgEI19530390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 14:27:42 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A93215805E;
	Wed, 29 Jan 2025 14:27:42 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1ADD658052;
	Wed, 29 Jan 2025 14:27:41 +0000 (GMT)
Received: from [9.61.176.130] (unknown [9.61.176.130])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jan 2025 14:27:40 +0000 (GMT)
Message-ID: <38a47dc9-7680-4321-b4c0-cf8b82ed1b43@linux.ibm.com>
Date: Wed, 29 Jan 2025 09:27:40 -0500
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
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
Cc: linux-hardening@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
Content-Language: en-US
From: Anthony Krowiak <akrowiak@linux.ibm.com>
In-Reply-To: <20250116131859.105756-2-thorsten.blum@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: k_eAbs0Okt0RS2cNWyITuDzSk9OJthm2
X-Proofpoint-ORIG-GUID: k_eAbs0Okt0RS2cNWyITuDzSk9OJthm2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1011 lowpriorityscore=0 mlxlogscore=999
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290113




On 1/16/25 8:18 AM, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct ap_matrix_dev.
>
> Use struct_size() to calculate the number of bytes to allocate for
> matrix_dev with a single mdev_type.
>
> Link: https://github.com/KSPP/linux/issues/79

LGTM:
Reviewed-by: Anthony Krowiak <akrowiak@linux.ibm.com>

> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>   drivers/s390/crypto/vfio_ap_drv.c     | 2 +-
>   drivers/s390/crypto/vfio_ap_private.h | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 67a807e2e75b..ea9ffa37f263 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -96,7 +96,7 @@ static int vfio_ap_matrix_dev_create(void)
>   	if (ret)
>   		goto bus_register_err;
>   
> -	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
> +	matrix_dev = kzalloc(struct_size(matrix_dev, mdev_types, 1), GFP_KERNEL);
>   	if (!matrix_dev) {
>   		ret = -ENOMEM;
>   		goto matrix_alloc_err;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 437a161c8659..9aed8994f567 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -53,7 +53,7 @@ struct ap_matrix_dev {
>   	struct mutex guests_lock; /* serializes access to each KVM guest */
>   	struct mdev_parent parent;
>   	struct mdev_type mdev_type;
> -	struct mdev_type *mdev_types[1];
> +	struct mdev_type *mdev_types[];
>   };
>   
>   extern struct ap_matrix_dev *matrix_dev;

