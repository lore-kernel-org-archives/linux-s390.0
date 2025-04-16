Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9998623371A;
	Wed, 16 Apr 2025 09:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796134; cv=none; b=lS9osU3NWaposajnayihdNmz1Apc+sdCSaJDdIotAZ6MMWnvnuA1LJoLXFuTagruln5WyJA3Ei2wnvtQNu2Q6rW5jc+Yb91fEXvXD870IQ4JxnXvWmFYGLA3QmHZPtc4/g180dax5RbScbo106SqXD7ehSXuaBZRbEbpg4jJaec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796134; c=relaxed/simple;
	bh=05QxXqivbSdfbDCL7/ruM7xLHEtOAuyN8K6UqkeiaoA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KDXOJ4GtG/NCJGUk38FjeeIrFoWALqZy3wt8FVgPK8njdxdfS9Us9zM6ZDiBLoGHv5ZeohtA3s4/3reSMGQVDJlPX+VrT5EHr7fIFsHcPaOjnldSm2WkJo3ArPRJihW9ii3b+FSRqlQYyZwa5SgiHdWUmoDWW6/Vvi5lODiVNLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TYIoKdl9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TYIoKdl9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FL3eha018902;
	Wed, 16 Apr 2025 09:35:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=w3hM8Z
	RRQsVyGIYjdZkA0T3THggoIVmw6QfZD7+58NA=; b=TYIoKdl9iIMnUJwFwsyKb0
	tgMKkPUrmUOTfBziq1N0hPrhYMOE3HdJuDBBDLjMgt0E4GAnIXFbUYegTci3vwFA
	NfdgCoz77U2uOkoyjfnhoJkThUh7fwSQAooF7leRl6r3n5vagn/sTCyKSdMiuU0d
	IA69VtzXBsegzCRhyILc3RfsmJou8kdYDT+9AdIzPcXasLboSCnSlS2tqXTfITDZ
	3sjV+skyKP3jywyyW6+CNWbla9ke2UliVv6VUD/xBxCZyD4g7Q/4ZSAZmXObJmRH
	HhEhZOrBEVa0bn5MzrFDD/NBQeE9/F6tUw6p3hkfma3vxmMMfbKtjkMsUreSKD/w
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gatra-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:35:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G9JEhj024907;
	Wed, 16 Apr 2025 09:35:20 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4602gtfx72-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:35:20 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9ZJaG30147138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:35:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5213E58045;
	Wed, 16 Apr 2025 09:35:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A5F6058050;
	Wed, 16 Apr 2025 09:35:16 +0000 (GMT)
Received: from [9.179.17.252] (unknown [9.179.17.252])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:35:16 +0000 (GMT)
Message-ID: <925b1369de0d347ddee2115d1de63843623ac485.camel@linux.ibm.com>
Subject: Re: [PATCH v5 5/5] iommu/s390: allow larger region tables
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 16 Apr 2025 11:35:15 +0200
In-Reply-To: <20250411202433.181683-6-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
	 <20250411202433.181683-6-mjrosato@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: T7Kz7xVW64sq_e_qjCa8E4eR-1nL1WIt
X-Proofpoint-GUID: T7Kz7xVW64sq_e_qjCa8E4eR-1nL1WIt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=948 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160078

On Fri, 2025-04-11 at 16:24 -0400, Matthew Rosato wrote:
> Extend the aperture calculation to consider sizes beyond the maximum
> size of a region third table.  Attempt to always use the smallest
> table size possible to avoid unnecessary extra steps during translation.
> Update reserved region calculations to use the appropriate table size.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_dma.h |  1 +
>  drivers/iommu/s390-iommu.c      | 70 ++++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 18 deletions(-)
>=20
> diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_=
dma.h
> index 8d8962e4fd58..d12e17201661 100644
> --- a/arch/s390/include/asm/pci_dma.h
> +++ b/arch/s390/include/asm/pci_dma.h
> @@ -25,6 +25,7 @@ enum zpci_ioat_dtype {
>  #define ZPCI_KEY			(PAGE_DEFAULT_KEY << 5)
> =20
>  #define ZPCI_TABLE_SIZE_RT	(1UL << 42)
> +#define ZPCI_TABLE_SIZE_RS	(1UL << 53)
> =20
>  #define ZPCI_IOTA_STO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOTA=
_DT_ST)
>  #define ZPCI_IOTA_RTTO_FLAG	(ZPCI_IOTA_IOT_ENABLED | ZPCI_KEY | ZPCI_IOT=
A_DT_RT)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 46f45b136993..433b59f43530 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -511,9 +511,25 @@ static bool s390_iommu_capable(struct device *dev, e=
num iommu_cap cap)
>  	}
>  }
> =20
> +static inline u64 max_tbl_size(struct s390_domain *domain)
> +{
> +	switch (domain->origin_type) {
> +	case ZPCI_TABLE_TYPE_RTX:
> +		return ZPCI_TABLE_SIZE_RT - 1;
> +	case ZPCI_TABLE_TYPE_RSX:
> +		return ZPCI_TABLE_SIZE_RS - 1;
> +	case ZPCI_TABLE_TYPE_RFX:
> +		return U64_MAX;
> +	default:
> +		return 0;
> +	}
> +}
> +
>  static struct iommu_domain *s390_domain_alloc_paging(struct device *dev)
>  {
> +	struct zpci_dev *zdev =3D to_zpci_dev(dev);
>  	struct s390_domain *s390_domain;
> +	u64 aperture_size;
> =20
>  	s390_domain =3D kzalloc(sizeof(*s390_domain), GFP_KERNEL);
>  	if (!s390_domain)
> @@ -524,10 +540,26 @@ static struct iommu_domain *s390_domain_alloc_pagin=
g(struct device *dev)
>  		kfree(s390_domain);
>  		return NULL;
>  	}
> +
> +	aperture_size =3D min(s390_iommu_aperture,
> +			    zdev->end_dma - zdev->start_dma + 1);
> +	if (aperture_size <=3D (ZPCI_TABLE_SIZE_RT - zdev->start_dma)) {
> +		s390_domain->origin_type =3D ZPCI_TABLE_TYPE_RTX;
> +	} else if (aperture_size <=3D (ZPCI_TABLE_SIZE_RS - zdev->start_dma) &&
> +		  (zdev->dtsm & ZPCI_IOTA_DT_RS)) {
> +		s390_domain->origin_type =3D ZPCI_TABLE_TYPE_RSX;
> +	} else if (zdev->dtsm & ZPCI_IOTA_DT_RF) {
> +		s390_domain->origin_type =3D ZPCI_TABLE_TYPE_RFX;
> +	} else {
> +		/* Assume RTX available */
> +		s390_domain->origin_type =3D ZPCI_TABLE_TYPE_RTX;
> +		aperture_size =3D ZPCI_TABLE_SIZE_RT - zdev->start_dma;
> +	}
> +	zdev->end_dma =3D zdev->start_dma + aperture_size - 1;
> +
>  	s390_domain->domain.geometry.force_aperture =3D true;
>  	s390_domain->domain.geometry.aperture_start =3D 0;
> -	s390_domain->domain.geometry.aperture_end =3D ZPCI_TABLE_SIZE_RT - 1;
> -	s390_domain->origin_type =3D ZPCI_TABLE_TYPE_RTX;
> +	s390_domain->domain.geometry.aperture_end =3D max_tbl_size(s390_domain)=
;
> =20
>  	spin_lock_init(&s390_domain->list_lock);
>  	INIT_LIST_HEAD_RCU(&s390_domain->devices);
> @@ -680,6 +712,8 @@ static void s390_iommu_get_resv_regions(struct device=
 *dev,
>  {
>  	struct zpci_dev *zdev =3D to_zpci_dev(dev);
>  	struct iommu_resv_region *region;
> +	u64 max_size, end_resv;
> +	unsigned long flags;
> =20
>  	if (zdev->start_dma) {
>  		region =3D iommu_alloc_resv_region(0, zdev->start_dma, 0,
> @@ -689,10 +723,21 @@ static void s390_iommu_get_resv_regions(struct devi=
ce *dev,
>  		list_add_tail(&region->list, list);
>  	}
> =20
> -	if (zdev->end_dma < ZPCI_TABLE_SIZE_RT - 1) {
> -		region =3D iommu_alloc_resv_region(zdev->end_dma + 1,
> -						 ZPCI_TABLE_SIZE_RT - zdev->end_dma - 1,
> -						 0, IOMMU_RESV_RESERVED, GFP_KERNEL);
> +	spin_lock_irqsave(&zdev->dom_lock, flags);
> +	if (zdev->s390_domain->type =3D=3D IOMMU_DOMAIN_BLOCKED ||
> +	    zdev->s390_domain->type =3D=3D IOMMU_DOMAIN_IDENTITY) {
> +		spin_unlock_irqrestore(&zdev->dom_lock, flags);
> +		return;
> +	}
> +
> +	max_size =3D max_tbl_size(to_s390_domain(zdev->s390_domain));
> +	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> +
> +	if (zdev->end_dma < max_size) {
> +		end_resv =3D max_size - zdev->end_dma;
> +		region =3D iommu_alloc_resv_region(zdev->end_dma + 1, end_resv,
> +						 0, IOMMU_RESV_RESERVED,
> +						 GFP_KERNEL);
>  		if (!region)
>  			return;
>  		list_add_tail(&region->list, list);
> @@ -708,13 +753,9 @@ static struct iommu_device *s390_iommu_probe_device(=
struct device *dev)
> =20
>  	zdev =3D to_zpci_dev(dev);
> =20
> -	if (zdev->start_dma > zdev->end_dma ||
> -	    zdev->start_dma > ZPCI_TABLE_SIZE_RT - 1)
> +	if (zdev->start_dma > zdev->end_dma)
>  		return ERR_PTR(-EINVAL);
> =20
> -	if (zdev->end_dma > ZPCI_TABLE_SIZE_RT - 1)
> -		zdev->end_dma =3D ZPCI_TABLE_SIZE_RT - 1;
> -
>  	if (zdev->tlb_refresh)
>  		dev->iommu->shadow_on_flush =3D 1;
> =20
> @@ -999,7 +1040,6 @@ struct zpci_iommu_ctrs *zpci_get_iommu_ctrs(struct z=
pci_dev *zdev)
> =20
>  int zpci_init_iommu(struct zpci_dev *zdev)
>  {
> -	u64 aperture_size;
>  	int rc =3D 0;
> =20
>  	rc =3D iommu_device_sysfs_add(&zdev->iommu_dev, NULL, NULL,
> @@ -1017,12 +1057,6 @@ int zpci_init_iommu(struct zpci_dev *zdev)
>  	if (rc)
>  		goto out_sysfs;
> =20
> -	zdev->start_dma =3D PAGE_ALIGN(zdev->start_dma);
> -	aperture_size =3D min3(s390_iommu_aperture,
> -			     ZPCI_TABLE_SIZE_RT - zdev->start_dma,
> -			     zdev->end_dma - zdev->start_dma + 1);
> -	zdev->end_dma =3D zdev->start_dma + aperture_size - 1;
> -
>  	return 0;
> =20
>  out_sysfs:

Looks good, thanks for the great work!

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
