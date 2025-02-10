Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E671EF087;
	Mon, 10 Feb 2025 11:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739187897; cv=none; b=cKYzTBL9vR/UV/6NUj1DlRBc+MBLMhX965xaPOrPX/aCRDCNFacttmDE3AnYfcMablqs24FL3jKJyvtIiNCtIIqD19bfp+ftWBx9QORey/HCUyrVtAqmqsX1kbwYlzkBWRKdQ6GVNxaucOmSFd0yfuzgPYJgn6VpPFXqN3/NQ/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739187897; c=relaxed/simple;
	bh=MownO1L4Pun47+h2zfqdUaHKECjHvsS9vdgBglfB7l4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JOOuZ2zglp9Jq94aoQV8Rmt35tJqasEULh2zbPoPuVtebb7Oi5iUUf3vz0hO3akwKazEKsN+cBMSkoao+0mqe0zaPtuFH31Q40fkgXg3oO+8H4L9Pb8i+A9hTR//BuwJCO3FiHTdXmA0OQhTqF75LGoFFiKOWm5zxQwKwjJYGg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CbQf3T2a; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CbQf3T2a"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51A19KpX026306;
	Mon, 10 Feb 2025 11:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EnMUSN
	4nZLyD6NHgUOyA0atjvrw2OaFkW/D/0MxraYM=; b=CbQf3T2auB6mYty0ZeVW7M
	KG0RgcNGYb4p6cjHJca/5yOpJ8YBfOPvvPsVCsrB/giFv7hZH2st1gMoOZI1KTHC
	5v7LRMQMsxqAZEdKi09fFvh+9In33E3fIV3cZlFVMwxI21b6LoPRfIcn2y+MStIA
	5LEcU2CersSNe0OtR6Uel9lJuhFPe5MmyffjfkE4MJn0yJ7JE55CfqGArQTD20wk
	gsX+HvexMxNKo3UhO2eo7TfRaVrs8dswlLIHEq4VEVz4eLiWTbJKPAUTY4KeDfFk
	Me7qg1CBr/ATplyxfTh16qO12fwoSKFcLogu9+hxXnbvnoykLqEkKqWmRlLZIIMw
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44q7h9afa0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:44:42 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51ABJSaN021713;
	Mon, 10 Feb 2025 11:44:41 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44phkse7ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Feb 2025 11:44:41 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51ABieWE18154030
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 11:44:40 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3CABC58050;
	Mon, 10 Feb 2025 11:44:40 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4413958045;
	Mon, 10 Feb 2025 11:44:37 +0000 (GMT)
Received: from [9.171.88.1] (unknown [9.171.88.1])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 10 Feb 2025 11:44:37 +0000 (GMT)
Message-ID: <59312b38813b75578fdd40db7b03250133c5350b.camel@linux.ibm.com>
Subject: Re: [PATCH v4 3/4] iommu/s390: handle IOAT registration based on
 domain
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, farman@linux.ibm.com,
        clegoate@redhat.com, jgg@nvidia.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Date: Mon, 10 Feb 2025 12:44:36 +0100
In-Reply-To: <20250207205335.473946-4-mjrosato@linux.ibm.com>
References: <20250207205335.473946-1-mjrosato@linux.ibm.com>
	 <20250207205335.473946-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: ipJsPR2X0MW5Q_Z8BJ3xqtp6kW6WkaZ8
X-Proofpoint-ORIG-GUID: ipJsPR2X0MW5Q_Z8BJ3xqtp6kW6WkaZ8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-10_06,2025-02-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 phishscore=0 mlxscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 impostorscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2501170000
 definitions=main-2502100096

On Fri, 2025-02-07 at 15:53 -0500, Matthew Rosato wrote:
> At this point, the dma_table is really a property of the s390-iommu
> domain.  Rather than checking its contents elsewhere in the codebase,
> move the code that registers the table with firmware into
> s390-iommu and make a decision what to register with firmware based
> upon the type of domain in use for the device in question.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci.h |  2 ++
>  arch/s390/kvm/pci.c         | 17 ++-------------
>  arch/s390/pci/pci.c         | 35 +++++++++++++++++-------------
>  arch/s390/pci/pci_sysfs.c   | 11 +---------
>  drivers/iommu/s390-iommu.c  | 43 +++++++++++++++++++++++++++++++++++--
>  5 files changed, 66 insertions(+), 42 deletions(-)
>=20
>=20
--8<---
>  int zpci_hot_reset_device(struct zpci_dev *zdev)
>  {
> -	u8 status;
>  	int rc;
> =20
>  	lockdep_assert_held(&zdev->state_lock);
> @@ -758,19 +773,9 @@ int zpci_hot_reset_device(struct zpci_dev *zdev)
>  			return rc;
>  	}
> =20
> -	rc =3D zpci_enable_device(zdev);
> -	if (rc)
> -		return rc;
> -
> -	if (zdev->dma_table)
> -		rc =3D zpci_register_ioat(zdev, 0, zdev->start_dma, zdev->end_dma,
> -					virt_to_phys(zdev->dma_table), &status);
> -	if (rc) {
> -		zpci_disable_device(zdev);
> -		return rc;
> -	}
> +	rc =3D zpci_reenable_device(zdev);
> =20
> -	return 0;
> +	return rc;

I can confirm that this change to re-do the I/O address translation re-
registration fixes the below zpci_hot_reset_device() test which  in an
iommu.passthrough=3D1 guest was causing host IOMMU violations in v3:

# echo 'bus' > /sys/bus/pci/devices/2003\:00\:00.0/reset_method
# echo 1 > /sys/bus/pci/devices/2003\:00\:00.0/reset

>  }
>=20
---8<---
> =20
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index fbdeded3d48b..007ccfdad495 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -381,6 +381,46 @@ static void zdev_s390_domain_update(struct zpci_dev =
*zdev,
>  	spin_unlock_irqrestore(&zdev->dom_lock, flags);
>  }
> =20
> +static int s390_iommu_domain_reg_ioat(struct zpci_dev *zdev,
> +				      struct iommu_domain *domain, u8 *status)
> +{
> +	struct s390_domain *s390_domain;
> +	int rc =3D 0;
> +	u64 iota;
> +
> +	switch (domain->type) {
> +	case IOMMU_DOMAIN_IDENTITY:
> +		rc =3D zpci_register_ioat(zdev, 0, zdev->start_dma,
> +					zdev->end_dma, 0, status);
> +		break;
> +	case IOMMU_DOMAIN_BLOCKED:
> +		/* Nothing to do in this case */
> +		break;
> +	default:
> +		s390_domain =3D to_s390_domain(domain);
> +		iota =3D virt_to_phys(s390_domain->dma_table) |
> +		       ZPCI_IOTA_RTTO_FLAG;
> +		rc =3D zpci_register_ioat(zdev, 0, zdev->start_dma,
> +					zdev->end_dma, iota, status);
> +	}
> +
> +	return rc;
> +}
> +
> +int zpci_iommu_register_ioat(struct zpci_dev *zdev, u8 *status)
> +{
> +	unsigned long flags;
> +	int rc;
> +
> +	spin_lock_irqsave(&zdev->dom_lock, flags);
> +
> +	rc =3D s390_iommu_domain_reg_ioat(zdev, zdev->s390_domain, status);
> +
> +	spin_unlock_irqrestore(&zdev->dom_lock, flags);
> +
> +	return rc;
> +}
> +
>=20

I really like how this takes out more of the IOMMU details from non-
IOMMU code. Definitely an improvement in terms of on its own. As stated
above I tested that this fixes the one issue I stumbled over in testing
the previous version. So feel free to add:

Tested-by: Niklas Schnelle <schnelle@linux.ibm.com>
Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>


