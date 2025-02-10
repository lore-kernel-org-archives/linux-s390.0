Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3A61F3D30;
	Mon, 10 Feb 2025 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739188049; cv=none; b=B/Z9EVEBnRptq8so8lz6wFeBSZay+3h2XmxUMU6xzVqk1j3NQEkDVq3VYoLqvg/h3OjnzVdow53wEU+H4CyjGlGhw7zOEQR90y53aT/XnEvUCJ8uj2nieHqQeMmNCDZP0s8SOQcWYUJgRy7i47q16iGivj0ufl04Iq+0mz3BkIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739188049; c=relaxed/simple;
	bh=cF/CH70V9SQE+XpvSFXUMJv3KkJgsXiNRJBJx6J0zps=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TZMyolXmp2whEcQkvLk0OPJd+b5+5Q1hQNCea3DiNh5v9PbnmTRdLhedb9atp502ZR4HxJ67dbsXbTJLfBlli1KtUQvk7N+EBWSOO7ZP34FGWrwtCpGyjZQAVikKrWGYUYRwOYVgDjM8pNRyNSp3K57gavb+RYqbGi8SVmRhSRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=EiGLg0E6; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="EiGLg0E6"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A20bYt013946;
	Mon, 10 Feb 2025 11:47:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=0dxywa
	BHHunzNH3EeTC2fmdSmVvuKR7MS4lcFcrkquQ=; b=EiGLg0E6gKy4RAGjRnT+FK
	t3hcsP1h8A48lDyULcmwFWVfybDk0A2P72Oer+hTBGWV6y9OLj0ZD53qMSvB5+di
	8cgbTaEV394F9DoNdeNGiyXts/i22YWVksqC7gx0Jh4MUtjGgjJ3EWlrc5QfUN5P
	2Rb4SDekwLFO+s/oVuSx5s/aJhV1Pm2siPoTtkY25qRmYz0yGUanzUDFui0mMuoU
	9tUSaIglOd8OL9WzfwTxTvxXaj0UitDp+kbiNsKpL/Y+5c7Aok6jsvjfPyKpld2k
	Rg5UxQCrXXbytisJ1jEGpQyA5gJkLg/lcclSpkFFMDKI4y1/JpMsYuISVIXsUyaQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q89yt8uh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:47:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ABRkwB028204;
	Mon, 10 Feb 2025 11:47:09 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44phyy669s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:47:09 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ABl7PB25821722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 11:47:08 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A0D5C58061;
	Mon, 10 Feb 2025 11:47:07 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD1CD58043;
	Mon, 10 Feb 2025 11:47:04 +0000 (GMT)
Received: from [9.171.88.1] (unknown [9.171.88.1])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 11:47:04 +0000 (GMT)
Message-ID: <8027bc7ce19e512253f7f33d205e2010f3f92fc0.camel@linux.ibm.com>
Subject: Re: [PATCH v4 4/4] iommu/s390: implement iommu passthrough via
 identity domain
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 10 Feb 2025 12:47:03 +0100
In-Reply-To: <20250207205335.473946-5-mjrosato@linux.ibm.com>
References: <20250207205335.473946-1-mjrosato@linux.ibm.com>
	 <20250207205335.473946-5-mjrosato@linux.ibm.com>
Autocrypt: addr=schnelle@linux.ibm.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: dY-Y_w8rTTY5aBWh63ZT9QNqprjsp_4c
X-Proofpoint-ORIG-GUID: dY-Y_w8rTTY5aBWh63ZT9QNqprjsp_4c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_06,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 priorityscore=1501 mlxlogscore=999 clxscore=1015 impostorscore=0
 spamscore=0 bulkscore=0 suspectscore=0 adultscore=0 malwarescore=0
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502100096

On Fri, 2025-02-07 at 15:53 -0500, Matthew Rosato wrote:
> Enabled via the kernel command-line 'iommu.passthrough=3D1' option.
>=20
> Introduce the concept of identity domains to s390-iommu, which relies on
> the bus_dma_region to offset identity mappings to the start of the DMA
> aperture advertized by CLP.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 95 +++++++++++++++++++++++++++++---------
>  1 file changed, 72 insertions(+), 23 deletions(-)
>=20
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 007ccfdad495..e1c76e0f9c2b 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -16,7 +16,7 @@
> =20
>  #include "dma-iommu.h"
> =20
> -static const struct iommu_ops s390_iommu_ops;
> +static const struct iommu_ops s390_iommu_ops, s390_iommu_rtr_ops;
> =20
>  static struct kmem_cache *dma_region_table_cache;
>  static struct kmem_cache *dma_page_table_cache;
> @@ -432,9 +432,11 @@ static int blocking_domain_attach_device(struct iomm=
u_domain *domain,
>  		return 0;
> =20
>  	s390_domain =3D to_s390_domain(zdev->s390_domain);
> -	spin_lock_irqsave(&s390_domain->list_lock, flags);
> -	list_del_rcu(&zdev->iommu_list);
> -	spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +	if (zdev->dma_table) {
> +		spin_lock_irqsave(&s390_domain->list_lock, flags);
> +		list_del_rcu(&zdev->iommu_list);
> +		spin_unlock_irqrestore(&s390_domain->list_lock, flags);
> +	}
> =20
>  	zpci_unregister_ioat(zdev, 0);
>  	zdev->dma_table =3D NULL;
> @@ -762,7 +764,13 @@ int zpci_init_iommu(struct zpci_dev *zdev)
>  	if (rc)
>  		goto out_err;
> =20
> -	rc =3D iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops, NULL);
> +	if (zdev->rtr_avail) {
> +		rc =3D iommu_device_register(&zdev->iommu_dev,
> +					   &s390_iommu_rtr_ops, NULL);
> +	} else {
> +		rc =3D iommu_device_register(&zdev->iommu_dev, &s390_iommu_ops,
> +					   NULL);
> +	}
>  	if (rc)
>  		goto out_sysfs;
> =20
> @@ -826,6 +834,39 @@ static int __init s390_iommu_init(void)
>  }
>  subsys_initcall(s390_iommu_init);
> =20
> +static int s390_attach_dev_identity(struct iommu_domain *domain,
> +				    struct device *dev)
> +{
> +	struct zpci_dev *zdev =3D to_zpci_dev(dev);
> +	u8 status;
> +	int cc;
> +
> +	blocking_domain_attach_device(&blocking_domain, dev);
> +
> +	/* If we fail now DMA remains blocked via blocking domain */
> +	cc =3D s390_iommu_domain_reg_ioat(zdev, domain, &status);
> +
> +	/*
> +	 * If the device is undergoing error recovery the reset code
> +	 * will re-establish the new domain.
> +	 */
> +	if (cc && status !=3D ZPCI_PCI_ST_FUNC_NOT_AVAIL)
> +		return -EIO;
> +
> +	zdev_s390_domain_update(zdev, domain);
> +
> +	return 0;
> +}
> +
> +static const struct iommu_domain_ops s390_identity_ops =3D {
> +	.attach_dev =3D s390_attach_dev_identity,
> +};
> +
> +static struct iommu_domain s390_identity_domain =3D {
> +	.type =3D IOMMU_DOMAIN_IDENTITY,
> +	.ops =3D &s390_identity_ops,
> +};
> +
>  static struct iommu_domain blocking_domain =3D {
>  	.type =3D IOMMU_DOMAIN_BLOCKED,
>  	.ops =3D &(const struct iommu_domain_ops) {
> @@ -833,23 +874,31 @@ static struct iommu_domain blocking_domain =3D {
>  	}
>  };
> =20
> -static const struct iommu_ops s390_iommu_ops =3D {
> -	.blocked_domain		=3D &blocking_domain,
> -	.release_domain		=3D &blocking_domain,
> -	.capable =3D s390_iommu_capable,
> -	.domain_alloc_paging =3D s390_domain_alloc_paging,
> -	.probe_device =3D s390_iommu_probe_device,
> -	.device_group =3D generic_device_group,
> -	.pgsize_bitmap =3D SZ_4K,
> -	.get_resv_regions =3D s390_iommu_get_resv_regions,
> -	.default_domain_ops =3D &(const struct iommu_domain_ops) {
> -		.attach_dev	=3D s390_iommu_attach_device,
> -		.map_pages	=3D s390_iommu_map_pages,
> -		.unmap_pages	=3D s390_iommu_unmap_pages,
> -		.flush_iotlb_all =3D s390_iommu_flush_iotlb_all,
> -		.iotlb_sync      =3D s390_iommu_iotlb_sync,
> -		.iotlb_sync_map  =3D s390_iommu_iotlb_sync_map,
> -		.iova_to_phys	=3D s390_iommu_iova_to_phys,
> -		.free		=3D s390_domain_free,
> +#define S390_IOMMU_COMMON_OPS() \
> +	.blocked_domain		=3D &blocking_domain, \
> +	.release_domain		=3D &blocking_domain, \
> +	.capable =3D s390_iommu_capable, \
> +	.domain_alloc_paging =3D s390_domain_alloc_paging, \
> +	.probe_device =3D s390_iommu_probe_device, \
> +	.device_group =3D generic_device_group, \
> +	.pgsize_bitmap =3D SZ_4K, \
> +	.get_resv_regions =3D s390_iommu_get_resv_regions, \
> +	.default_domain_ops =3D &(const struct iommu_domain_ops) { \
> +		.attach_dev	=3D s390_iommu_attach_device, \
> +		.map_pages	=3D s390_iommu_map_pages, \
> +		.unmap_pages	=3D s390_iommu_unmap_pages, \
> +		.flush_iotlb_all =3D s390_iommu_flush_iotlb_all, \
> +		.iotlb_sync      =3D s390_iommu_iotlb_sync, \
> +		.iotlb_sync_map  =3D s390_iommu_iotlb_sync_map, \
> +		.iova_to_phys	=3D s390_iommu_iova_to_phys, \
> +		.free		=3D s390_domain_free, \
>  	}
> +
> +static const struct iommu_ops s390_iommu_ops =3D {
> +	S390_IOMMU_COMMON_OPS()
> +};
> +
> +static const struct iommu_ops s390_iommu_rtr_ops =3D {
> +	.identity_domain	=3D &s390_identity_domain,
> +	S390_IOMMU_COMMON_OPS()
>  };

Looks good to me here and worked well in my tests too. Thank you!

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>




