Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 014E418F2EA;
	Wed, 29 Jan 2025 15:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738166037; cv=none; b=LFITdRNrGH/sm9QmEIINKrXKDcks9O2Ex3itRBeoUiRg+W2z+ygU7OtbPW4l4JyvIXH3Voht7poYSOg5X1pBqqKMoVzHhrKCy3GvdbVnuLoMTZynE071PVUmBpAE7Uz/GSsbD98RAjGzzBgtGuaktVjSOqqEDZapwtOFvwBg7LI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738166037; c=relaxed/simple;
	bh=/NRjMUjJEP+0tJHthQdth5+FwukV4GD1IQMGwdhBZSk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BxuCiTz1434QrFr7ILoylUdJ4I2AHn+jS2sAJzzMYdjtCHSHT3w2OnUfTLiwhGHmVoGEHU2XJWNOfMcGN1hdSDvbFjn/JDTymq5G2a+7ejg2HPWMtL1L9SeRicBV84qOkFrFGeNGb9oHPFoHFxdht9cMfcOlUbHsWc9+Wk33mc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QOMX1BVL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QOMX1BVL"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50T5O4o4013686;
	Wed, 29 Jan 2025 15:53:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=ns/e1BLrSkSjVILRfori3y4nlvUyts
	/4rV4TYCkJH4g=; b=QOMX1BVLn+mu0jRCuMIkcfR5wsWqOPgvRyTwjh8+PFiLet
	GHk65y763KaUYuIqAyxFZgfyy2q4F0vITsDrK58CCXV5SI/eEN+6jVT3Y6QdG4bE
	DA16FUdxGEA8ZpMAjanx5XiD7axRw9AOegetSAOE5x+eiZP6FBjfvcAZWoEYKE3Y
	C0FnMXdlgKcrJ036b9y20w5eDC7j//5HjxZL0d1vX83wAjaT5AAIdMYYMLdEOCGW
	6wmi9kOPBZRvafUBR0NAEihtrOT5BaI5AX44lI7SqV4KMGNQUxKOs8siI7NGLsc2
	KpiqM9UeAIyJEgytlOqe8VdHy4pUHKA8hVzvGLNQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44fe58atd5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:43 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50TDv0t1028042;
	Wed, 29 Jan 2025 15:53:42 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44dbskh9yb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jan 2025 15:53:42 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50TFrcfT15073790
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jan 2025 15:53:38 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C11AF2004F;
	Wed, 29 Jan 2025 15:53:38 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 82F082004B;
	Wed, 29 Jan 2025 15:53:38 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 29 Jan 2025 15:53:38 +0000 (GMT)
Date: Wed, 29 Jan 2025 16:53:37 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Thorsten Blum <thorsten.blum@linux.dev>
Cc: Tony Krowiak <akrowiak@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390/vfio-ap: Fix indentation in vfio_ap_mdev_ioctl()
Message-ID: <Z5pPATGEi1PNio8q@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250116131146.105439-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116131146.105439-2-thorsten.blum@linux.dev>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: uoq5gmD44J921toneSsRpwz9_QZaAD_Z
X-Proofpoint-ORIG-GUID: uoq5gmD44J921toneSsRpwz9_QZaAD_Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-29_02,2025-01-29_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 spamscore=0
 lowpriorityscore=0 mlxlogscore=931 bulkscore=0 impostorscore=0
 priorityscore=1501 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501290125

On Thu, Jan 16, 2025 at 02:11:47PM +0100, Thorsten Blum wrote:
> Remove any extra indentation to improve the code's readability.
> 
> Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> ---
>  drivers/s390/crypto/vfio_ap_ops.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/s390/crypto/vfio_ap_ops.c b/drivers/s390/crypto/vfio_ap_ops.c
> index a52c2690933f..155e19aef5df 100644
> --- a/drivers/s390/crypto/vfio_ap_ops.c
> +++ b/drivers/s390/crypto/vfio_ap_ops.c
> @@ -2199,8 +2199,8 @@ static ssize_t vfio_ap_mdev_ioctl(struct vfio_device *vdev,
>  		ret = vfio_ap_mdev_reset_queues(matrix_mdev);
>  		break;
>  	case VFIO_DEVICE_GET_IRQ_INFO:
> -			ret = vfio_ap_get_irq_info(arg);
> -			break;
> +		ret = vfio_ap_get_irq_info(arg);
> +		break;
>  	case VFIO_DEVICE_SET_IRQS:
>  		ret = vfio_ap_set_irqs(matrix_mdev, arg);
>  		break;

Applied, thanks!
