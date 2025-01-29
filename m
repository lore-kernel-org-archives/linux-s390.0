Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85C4F1AD403;
	Wed, 29 Jan 2025 15:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166051; cv=none; b=SIHGlumrFyxHR3bUnOftByNWVEzmaDFU3QfhJcwpYl5Rz7XL/dXKY2wNQzruBDbLYgqrhOlp3kbS2o+tFWkiBcHxupGVqDWOi1JD9QhyEcmdUKJsCmpMMhpXiHc162PfZoG6sFF5Clr9WB1YIDilNoR+gzevENBzN8Z8wheMYPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166051; c=relaxed/simple;
	bh=j3H/YkFZxydWVxZwTVNK0pWbLamFBxtpjNG1HGRozw8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+udvyHUKOiiA5qomrIFIHO1ycuQeSRUkrjfQaZ4+2WQ3vYVmukaAsta1IDbqmOKJe6IBPPFOxjKEQaDWndzg9K9fEq9CeR2x6kpuzj0Z//Bvg8TDoxZvQaY1L23DbfILhirEevQQsOTtcjmdeQMLaxbyJEDEdcxnFyJXavuG4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=V34ztABM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="V34ztABM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50TENMxg030814;
	Wed, 29 Jan 2025 15:54:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=UtonePPy0pLQ6bsSy1HA5+WlY8+DxN
	wYp+tgC1LA7/8=; b=V34ztABMVNf84fw1AZBOBtlxKuL12tyg//fAV4A2+Wo/Rq
	lLoHuVBFvl3hpfBzN2KXyfLyUQG61wlv7wGfwJfth5vvW9LbGZPzImUz2OpqBdVJ
	nW4eILA4YjsDh7b8O54vlrwbCh71SX0WeozPqZjhltBTvysJ0uRsFfoTvyjZsu8F
	Jjlu54FdX44zkESVaU3p8ImHDL7TlU3YX1cG/iKTN+qndmDYprrzJGGFdN3Sig28
	6/0zOQo2dwZvPuGNkimk9MF+lXxVjO1OSQXdNoJwP+vJdw+sux9l4uQEONLfiGfO
	A8muyU2Jx1JW+epmlVHlxN3gpIuaiYhZxNr0AYRg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fb60b67q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:54:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50TCe9up012441;
	Wed, 29 Jan 2025 15:54:00 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dany9gj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:54:00 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TFruMI25493766
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:53:56 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9562720085;
	Wed, 29 Jan 2025 15:53:56 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6082020083;
	Wed, 29 Jan 2025 15:53:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jan 2025 15:53:56 +0000 (GMT)
Date: Wed, 29 Jan 2025 16:53:55 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-hardening@vger.kernel.org,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Replace one-element array with flexible
 array member
Message-ID: <Z5pPE19EQxaahb3q@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250116131859.105756-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116131859.105756-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nFNDuDZItcIZBeQBgpqGS7Ngf9F_2RU3
X-Proofpoint-ORIG-GUID: nFNDuDZItcIZBeQBgpqGS7Ngf9F_2RU3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 clxscore=1015 lowpriorityscore=0 mlxlogscore=861
 bulkscore=0 spamscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290125

On Thu, Jan 16, 2025 at 02:18:59PM +0100, Thorsten Blum wrote:
> Replace the deprecated one-element array with a modern flexible array
> member in the struct ap_matrix_dev.
> 
> Use struct_size() to calculate the number of bytes to allocate for
> matrix_dev with a single mdev_type.
> 
> Link: https://github.com/KSPP/linux/issues/79
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/s390/crypto/vfio_ap_drv.c     | 2 +-
>  drivers/s390/crypto/vfio_ap_private.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_drv.c b/drivers/s390/crypto/vfio_ap_drv.c
> index 67a807e2e75b..ea9ffa37f263 100644
> --- a/drivers/s390/crypto/vfio_ap_drv.c
> +++ b/drivers/s390/crypto/vfio_ap_drv.c
> @@ -96,7 +96,7 @@ static int vfio_ap_matrix_dev_create(void)
>  	if (ret)
>  		goto bus_register_err;
>  
> -	matrix_dev = kzalloc(sizeof(*matrix_dev), GFP_KERNEL);
> +	matrix_dev = kzalloc(struct_size(matrix_dev, mdev_types, 1), GFP_KERNEL);
>  	if (!matrix_dev) {
>  		ret = -ENOMEM;
>  		goto matrix_alloc_err;
> diff --git a/drivers/s390/crypto/vfio_ap_private.h b/drivers/s390/crypto/vfio_ap_private.h
> index 437a161c8659..9aed8994f567 100644
> --- a/drivers/s390/crypto/vfio_ap_private.h
> +++ b/drivers/s390/crypto/vfio_ap_private.h
> @@ -53,7 +53,7 @@ struct ap_matrix_dev {
>  	struct mutex guests_lock; /* serializes access to each KVM guest */
>  	struct mdev_parent parent;
>  	struct mdev_type mdev_type;
> -	struct mdev_type *mdev_types[1];
> +	struct mdev_type *mdev_types[];
>  };
>  
>  extern struct ap_matrix_dev *matrix_dev;

Applied, thanks!
