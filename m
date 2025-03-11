Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928F019AA63;
	Tue, 11 Mar 2025 14:19:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741702790; cv=none; b=CcW+b5k/bMDu25lLCRkYqa1JFhCHTtclplzgCwS2Ip9i6cHqNUvwge6AD8J+MrLOuD0KH12SvewfuHFxuTvxoavknqaDhBd5wudkXgwnbcgNeXZbm+x8D4ZbIjR8XD2ovwZ1vpzH5OrC+rOVj6HMcGb71IktBgNQwS6rquAfHro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741702790; c=relaxed/simple;
	bh=gn5J3MOOne38LA4FNRhfe9F53jyTFz8JyxsCOJODyOU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OlkUShhFpdJpyCSoBR7Bu/E6aVePTOXGkwc8swMb+WbJRHIZO91i9wVco2pmEtdYbMB8o/5XHtRFVRgu9OL3t/P9ihO9Q8Y/JoH83LQ0hGh/a9QW7H4Bi1BKqGRyAWsUbz+WUBFu1M4jR69r52frkrNM65DKhFG5PH1EgzQArbk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GX95Kujb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GX95Kujb"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52B9eD74002120;
	Tue, 11 Mar 2025 14:19:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=cLoGKU
	6hIzqNfco5/+5/HztyKzx5MWFP6SclUMpodiI=; b=GX95Kujb/X2YY+Byrzb4gb
	iLlLevww6QlbixCyw66ZuJ8utgEnHo+8lu3eTqotKKQUc44Zaj9DmE9uhgFB4S22
	j9ZbKOtXyAaI8NfTcjoButNWWtCrDX563LYogpSi0A9snG7MkiWHba7N7n09SGEA
	t9Txj7cmHhSt0Uy689ZocFl4zjZSTXHJzG4TplCkZsGDb3/XRCBjkBbO7JzRTW8C
	hn+WKYHj4U9ngjxDA2dwwYqWOhlX88D+JE4UBKbBSX0WSzcTkNjHvvg6Z7L6W9Ue
	qTNL/oogrtIeoTrVy0hOf4pFle+qzqTapj8IKvJ4uUvNjrZPjTYY6/XX3xOputig
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45a7g5vafj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:19:35 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52BCvTv9022288;
	Tue, 11 Mar 2025 14:19:34 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45917nck1b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Mar 2025 14:19:34 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52BEJXdO29033154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 11 Mar 2025 14:19:33 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3D21E5805D;
	Tue, 11 Mar 2025 14:19:33 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AD3ED58059;
	Tue, 11 Mar 2025 14:19:30 +0000 (GMT)
Received: from [9.152.212.232] (unknown [9.152.212.232])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 11 Mar 2025 14:19:30 +0000 (GMT)
Message-ID: <25965f63fd72c43fdd3d4a3e2a3f70608f68ffe9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/5] iommu/s390: support iova_to_phys for additional
 table regions
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Tue, 11 Mar 2025 15:19:29 +0100
In-Reply-To: <20250228214456.440641-4-mjrosato@linux.ibm.com>
References: <20250228214456.440641-1-mjrosato@linux.ibm.com>
	 <20250228214456.440641-4-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: ec3glXhTVsrzaJJEQAwRZV-dz65eMeRK
X-Proofpoint-ORIG-GUID: ec3glXhTVsrzaJJEQAwRZV-dz65eMeRK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-11_03,2025-03-11_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 spamscore=0 mlxlogscore=999 suspectscore=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2503110089

On Fri, 2025-02-28 at 16:44 -0500, Matthew Rosato wrote:
> The origin_type of the dma_table is used to determine how many table
> levels must be traversed for the translation.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_dma.h |  2 ++
>  drivers/iommu/s390-iommu.c      | 52 ++++++++++++++++++++++++++++++++-
>  2 files changed, 53 insertions(+), 1 deletion(-)
>=20
> diff --git a/arch/s390/include/asm/pci_dma.h b/arch/s390/include/asm/pci_=
dma.h
> index 42d7cc4262ca..8d8962e4fd58 100644
> --- a/arch/s390/include/asm/pci_dma.h
> +++ b/arch/s390/include/asm/pci_dma.h
> @@ -55,6 +55,8 @@ enum zpci_ioat_dtype {
>  #define ZPCI_PT_BITS			8
>  #define ZPCI_ST_SHIFT			(ZPCI_PT_BITS + PAGE_SHIFT)
>  #define ZPCI_RT_SHIFT			(ZPCI_ST_SHIFT + ZPCI_TABLE_BITS)
> +#define ZPCI_RS_SHIFT			(ZPCI_RT_SHIFT + ZPCI_TABLE_BITS)
> +#define ZPCI_RF_SHIFT			(ZPCI_RS_SHIFT + ZPCI_TABLE_BITS)
> =20
>  #define ZPCI_RTE_FLAG_MASK		0x3fffUL
>  #define ZPCI_RTE_ADDR_MASK		(~ZPCI_RTE_FLAG_MASK)
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f2cda0ce0fe9..0a6aad11c327 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -36,6 +36,16 @@ struct s390_domain {
> =20
>  static struct iommu_domain blocking_domain;
> =20
> +static inline unsigned int calc_rfx(dma_addr_t ptr)
> +{
> +	return ((unsigned long)ptr >> ZPCI_RF_SHIFT) & ZPCI_INDEX_MASK;
> +}
> +
> +static inline unsigned int calc_rsx(dma_addr_t ptr)
> +{
> +	return ((unsigned long)ptr >> ZPCI_RS_SHIFT) & ZPCI_INDEX_MASK;
> +}
> +
>  static inline unsigned int calc_rtx(dma_addr_t ptr)
>  {
>  	return ((unsigned long)ptr >> ZPCI_RT_SHIFT) & ZPCI_INDEX_MASK;
> @@ -759,6 +769,43 @@ static int s390_iommu_map_pages(struct iommu_domain =
*domain,
>  	return rc;
>  }
> =20
> +static unsigned long *get_rto_from_iova(struct s390_domain *domain,
> +					dma_addr_t iova)
> +{
> +	unsigned long *rfo, *rso, *rto;
> +	unsigned long rfe, rse;
> +	unsigned int rfx, rsx;
> +
> +	switch (domain->origin_type) {
> +	case ZPCI_TABLE_TYPE_RFX:
> +		rfo =3D domain->dma_table;
> +		goto itp_rf;
> +	case ZPCI_TABLE_TYPE_RSX:
> +		rso =3D domain->dma_table;
> +		goto itp_rs;
> +	case ZPCI_TABLE_TYPE_RTX:
> +		return domain->dma_table;
> +	default:
> +		return NULL;
> +	}
> +
> +itp_rf:
> +	rfx =3D calc_rfx(iova);
> +	rfe =3D READ_ONCE(rfo[rfx]);
> +	if (!reg_entry_isvalid(rfe))
> +		return NULL;
> +	rso =3D get_rf_rso(rfe);
> +
> +itp_rs:
> +	rsx =3D calc_rsx(iova);
> +	rse =3D READ_ONCE(rso[rsx]);
> +	if (!reg_entry_isvalid(rse))
> +		return NULL;
> +	rto =3D get_rs_rto(rse);
> +
> +	return rto;
> +}

I played around with re-organizing the above as the goto out of the
switch feels a bit cumbersome. One variant I came up with is a separate
get_rso_from_iova() function like below:

static unsigned long *get_rso_from_iova(struct s390_domain *domain,
					dma_addr_t iova)
{
	unsigned long *rfo;
	unsigned long rfe;
	unsigned int rfx;

	switch (domain->origin_type) {
	case ZPCI_TABLE_TYPE_RFX:
		rfo =3D domain->dma_table;
		rfx =3D calc_rfx(iova);
		rfe =3D READ_ONCE(rfo[rfx]);
		if (!reg_entry_isvalid(rfe))
			return NULL;
		return get_rf_rso(rfe);
	case ZPCI_TABLE_TYPE_RSX:
		return domain->dma_table;
	default:
		return NULL;
	}
}

static unsigned long *get_rto_from_iova(struct s390_domain *domain,
					dma_addr_t iova)
{
	unsigned long *rso;
	unsigned long rse;
	unsigned int rsx;

	switch (domain->origin_type) {
	case ZPCI_TABLE_TYPE_RFX:
	case ZPCI_TABLE_TYPE_RSX:
		rso =3D get_rso_from_iova(domain, iova);
		rsx =3D calc_rsx(iova);
		rse =3D READ_ONCE(rso[rsx]);
		if (!reg_entry_isvalid(rse))
			return NULL;
		return get_rs_rto(rse);
	case ZPCI_TABLE_TYPE_RTX:
		return domain->dma_table;
	default:
		return NULL;
	}
}

I think this is slightly cleaner but not by enough that I'd say we have
to do it this way and I leave the choice to you.

> +
>  static phys_addr_t s390_iommu_iova_to_phys(struct iommu_domain *domain,
>  					   dma_addr_t iova)
>  {
> @@ -772,10 +819,13 @@ static phys_addr_t s390_iommu_iova_to_phys(struct i=
ommu_domain *domain,
>  	    iova > domain->geometry.aperture_end)
>  		return 0;
> =20
> +	rto =3D get_rto_from_iova(s390_domain, iova);
> +	if (!rto)
> +		return 0;
> +
>  	rtx =3D calc_rtx(iova);
>  	sx =3D calc_sx(iova);
>  	px =3D calc_px(iova);
> -	rto =3D s390_domain->dma_table;
> =20
>  	rte =3D READ_ONCE(rto[rtx]);
>  	if (reg_entry_isvalid(rte)) {

So with or without my suggestion.

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>
