Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8D1E7484;
	Thu, 27 Jun 2024 05:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719465637; cv=none; b=UHHxd3bnIgo0l2vLCSnr3tE9NIQuMouOJb9wmP2yo4/CsEy+vNYGgPmq8kMlSZn+HpM2guBQjtuQP71438vyPjwn+IkayhVRwDqt/BkQ71o+103peB7CWJaJ5atc7j3YU9KhDpYiNW4jKVMzUkBxYDaPrK5klw0oNHDtjvscWDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719465637; c=relaxed/simple;
	bh=D/X5YwfUNyF7H8xkH0w9pwN7YRo+9twFtmwa8F4Hhg0=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ub7FgNPsKjGtj8BYIUS+HSdkubunIWkd/vJwqkQZ4T+6Mmvy8qKzMZRL/E9gINYkaqTHOI9Hjyq2bxDBd9vZSvTlLJWBKa71T5s1SNr1fMcDZ45EpI2R/ku+J9sDK9oDsgsXh5lbzrK+J4oninqi3IuPX0QpZgL38votSiUiK3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=LwqoMyqp; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="LwqoMyqp"
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45R2vmk8001296;
	Wed, 26 Jun 2024 22:20:29 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pfpt0220; bh=LujTv9Un+e7Gfkpm+Ek8qW0Qp
	TfwdpmhopdaziKnrX4=; b=LwqoMyqpYtgfnDf7zErvT3WqglLHvvKIVDUxuD05U
	iov1Jh7X49TpRS3S30Ped/OmV8Sg6JjjjkTEA5zQwywqhXWf0UCyZ1juo2XPegTQ
	HYlmrLf5vcEGaEg7NeybRqJ3X/iyJDaIDmxCFAgxtdQseZXpzmaEwTNdkg+ovv1b
	UFl5oU7kHyKeVKbOUvKNv6pOPpt+7xutOmNwpMIGseM2Y1gbWF+mKtn3J7Mjm8VC
	vleyOTrodoEa178u50pQaKp0iQKjMtFLm+i/4dNMGPSVkc5WNKQ1bdxa65hQy+qz
	Aay8org0vIhte2i4Xs2VJ+gxFQ77bMFp2JzKn3ItiwqSw==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 400yrt0bxm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 22:20:28 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Wed, 26 Jun 2024 22:20:28 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Wed, 26 Jun 2024 22:20:28 -0700
Received: from maili.marvell.com (unknown [10.28.36.165])
	by maili.marvell.com (Postfix) with SMTP id 700623F7071;
	Wed, 26 Jun 2024 22:20:24 -0700 (PDT)
Date: Thu, 27 Jun 2024 10:50:23 +0530
From: Ratheesh Kannoth <rkannoth@marvell.com>
To: Ma Ke <make24@iscas.ac.cn>
CC: <wintera@linux.ibm.com>, <twinkler@linux.ibm.com>, <hca@linux.ibm.com>,
        <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
        <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
        <bhelgaas@google.com>, <linux-s390@vger.kernel.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
Message-ID: <20240627052023.GB1743080@maili.marvell.com>
References: <20240627021314.2976443-1-make24@iscas.ac.cn>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240627021314.2976443-1-make24@iscas.ac.cn>
X-Proofpoint-GUID: 1RgVgEIe1BgXqTi3lr5xIeuaM-kYjrZ3
X-Proofpoint-ORIG-GUID: 1RgVgEIe1BgXqTi3lr5xIeuaM-kYjrZ3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-27_02,2024-06-25_01,2024-05-17_01

On 2024-06-27 at 07:43:14, Ma Ke (make24@iscas.ac.cn) wrote:
> As the possible failure of the dma_set_max_seg_size(), we should better
Could you expand on the scenario of failure ?
> check the return value of the dma_set_max_seg_size().

> +++ b/drivers/s390/net/ism_drv.c
> @@ -620,7 +620,10 @@ static int ism_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  		goto err_resource;
>
>  	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
> -	dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	ret = dma_set_max_seg_size(&pdev->dev, SZ_1M);
Same error check is not valid for dma_set_seg_boundary() ?

>
