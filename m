Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47CE119BC6;
	Wed, 26 Jun 2024 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719406128; cv=none; b=Sn1bFvOIHNJ23HP38zAeZOi+6muXhDaHts04SfTTfoi8yxi1Ek9/heaLmZ9NGnTikFI/ppMBfnj0/r1+6DvaxC/I0Se3lpCLOZm6e+yEv/lr0nYCJ/n/reE2CfMCxyaK3n+w+YsZEkyTQ380EfbxVOKhB6d/HboyjYNynTnJdUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719406128; c=relaxed/simple;
	bh=zNMzXNtaGkFXqoNCuCZI1KiwCqFEAZ3HXo636YRRIUM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=QgnzxVe/7Tthj52122JaajRGY7pkwxMCeCRHJaJrsLMrCjx0irv+MBQEGJpCrSrI2t5vUPtPbkNAk8+Lu3kmUxHkH3qBHi88Y83xEcvzopIDBr5wdJkrqAOv7DMpeRRZp/zRMEVkoGPmLlVET3EU16++OAIXjsq5CcLqLCdEwPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ouGTUB8p; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ouGTUB8p"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QCSqvh017661;
	Wed, 26 Jun 2024 12:48:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	message-id:subject:from:to:cc:date:in-reply-to:references
	:content-type:content-transfer-encoding:mime-version; s=pp1; bh=
	fsIQQtLTm4Gg90CEu/3VEdMQqSTEw/mf7ZgROk28Brk=; b=ouGTUB8pTd51hSeL
	uKGarIfX1ARuHp3nilRQ0yOFRwnxk1gwr7D44CR6AwV8laoJIGj8pg6pDV6+KIOZ
	hYJIUD8b0BwodtchL9SJIv5PnXiqZCjslVS0jElCRsORdZ2w/73dO00G2Hc1DAm6
	1wny0Z9zYF2Ip80FXZKBLbMo6Yhz/WT29q7DlWYT4cwI2SbBWLefRWXgQlTMUCwj
	1trOGMd+QJ5bn4yUnz5PN02FCZ7U7n1wBUz/hZPMv3mKdjfOmFk3mS3IW2EY4IJp
	yOoqw8J79zANpJA8UGf+Wrm8WOsIVgH2DOsMYjXTDsauoNsGvxDI6QMC5v2yEm5R
	VTAOqw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 400k1581k4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:48:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45QCUCOW000627;
	Wed, 26 Jun 2024 12:48:40 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yxaen4b0x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:48:40 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45QCmYa754722832
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Jun 2024 12:48:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BEFE20049;
	Wed, 26 Jun 2024 12:48:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5032D20040;
	Wed, 26 Jun 2024 12:48:34 +0000 (GMT)
Received: from [9.152.224.39] (unknown [9.152.224.39])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 26 Jun 2024 12:48:34 +0000 (GMT)
Message-ID: <4ab328297c12d1c286c56dbc01d611b77ea2da03.camel@linux.ibm.com>
Subject: Re: [PATCH] s390/ism: Add check for dma_set_max_seg_size in
 ism_probe()
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Ma Ke <make24@iscas.ac.cn>, wintera@linux.ibm.com, twinkler@linux.ibm.com,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Wenjia
 Zhang <wenjia@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, borntraeger@linux.ibm.com, svens@linux.ibm.com,
        davem@davemloft.net, Stefan Raspl <raspl@linux.ibm.com>
Date: Wed, 26 Jun 2024 14:48:30 +0200
In-Reply-To: <20240626081215.2824627-1-make24@iscas.ac.cn>
References: <20240626081215.2824627-1-make24@iscas.ac.cn>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.2 (3.52.2-1.fc40app2) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3ImCsWcLqj6CUkocrVdSXFwLnfAiHS1L
X-Proofpoint-GUID: 3ImCsWcLqj6CUkocrVdSXFwLnfAiHS1L
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_06,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 suspectscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 phishscore=0 adultscore=0 mlxscore=0 bulkscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2406260092

Hi Ma Ke,

On Wed, 2024-06-26 at 16:12 +0800, Ma Ke wrote:
> As the possible failure of the dma_set_max_seg_size(), we should
> better check the return value of the dma_set_max_seg_size().

I think formally you're correct. dma_set_max_seg_size() could return an
error if dev->dma_parms was not present.

However, since ISM devices are PCI attached (and will remain PCI
attached I believe) we can take the existance of dev->dma_parms for
granted since pci_device_add() (in drivers/pci/probe.c) will make that
point to the pci_dev's dma_parms for every PCI device.

So I'm not sure how important this fix is.

> Fixes: 684b89bc39ce ("s390/ism: add device driver for internal shared
> memory")
> Signed-off-by: Ma Ke <make24@iscas.ac.cn>
> ---
> =C2=A0drivers/s390/net/ism_drv.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/s390/net/ism_drv.c b/drivers/s390/net/ism_drv.c
> index e36e3ea165d3..9ddd093a0368 100644
> --- a/drivers/s390/net/ism_drv.c
> +++ b/drivers/s390/net/ism_drv.c
> @@ -620,7 +620,9 @@ static int ism_probe(struct pci_dev *pdev, const
> struct pci_device_id *id)
> =C2=A0		goto err_resource;
> =C2=A0
> =C2=A0	dma_set_seg_boundary(&pdev->dev, SZ_1M - 1);
> -	dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	ret =3D dma_set_max_seg_size(&pdev->dev, SZ_1M);
> +	if (ret)
> +		return ret;
> =C2=A0	pci_set_master(pdev);
> =C2=A0
> =C2=A0	ret =3D ism_dev_init(ism);

BTW, I've dropped ubraun@linux.ibm.com and sebott@linux.ibm.com as
their emails won't work any longer, anyhow. Instead I've added Niklas
Schnelle, Wenjia Zhang and Stefan Raspl.

Thanks, Gerd
