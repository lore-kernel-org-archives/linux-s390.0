Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F8052356A2;
	Wed, 16 Apr 2025 09:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744795210; cv=none; b=Wr79SmaoKLksTBUlsAlF4aqn/MQ8oF3EcsEDUKyWqmF7U6BQjcyyx5e8ZUzusoAyWgX6fnkCPBS3oboox0tLBT+PDSJ2yYMFbpw5uUWucuS/x3px7X3APg+E6w6tBjGtGU86rmxRGlYbg+jy6IP0myfcE16Jscw5rhgvMTW0Tbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744795210; c=relaxed/simple;
	bh=kKSrxTfVMGwguU4+jro0x1CfKtFmI6/TcJWMp8JuuT0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=otaFYdQoP2uLAx5tCA1wh8KSQl8P3V/oN/owr2nIr/g16tDbXWvCp92IuxaKbL+dLvYJuSjrukPeJGo8DmyNaLubDAjRbSKgR9J/LI6bwdVNwXJZkDgUgVwSf1uaRNsXD98to7D+x/DWmwvO8zQViDNWVbG/HY9+inn7bR49Z9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=d53YjI94; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="d53YjI94"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53FLg5mr026666;
	Wed, 16 Apr 2025 09:19:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qh3N+r
	ShPUWZ6G+Klpg963dwtnehvHnsNjZ5hVHmeaU=; b=d53YjI94pSU1vMIbaifg+R
	RQR5usgBtNDVaCT1ZGsuozZ9Phi2ibblQc4Xo382emxW272Jvqf5vw0mqyJft0Rx
	s78yBZV1C+avo5VQUB1uT2qk7yAOaouRVzn2ZZ++hBZLPmHrh1adze1bxNMX255e
	PgI+wGnB6ROC4cYgEfHva3OvXoduYIdT83KLNOX7hyz12pO3ogyHm37J9t7yvI2b
	IKQJsqfnPY3cKHLpnYcaqD9Ga5cqpYQ9SQUDESZJobx4AtH4XcnObgfXHZFYdxxv
	xVN5lrLcTEy+X/Tg7WWAnjseTyMB4mxhSnzG0+mksJBg1VUgAFJjCHJ5WcD85vfg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461ykt2f9j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:19:57 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8e7iZ016689;
	Wed, 16 Apr 2025 09:19:56 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46057276vu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:19:56 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9JtRs29295240
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:19:55 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8232258059;
	Wed, 16 Apr 2025 09:19:55 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5C7A58053;
	Wed, 16 Apr 2025 09:19:52 +0000 (GMT)
Received: from [9.179.17.252] (unknown [9.179.17.252])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:19:52 +0000 (GMT)
Message-ID: <1cb8f6c28a74abfbda24f551eb9981a832b5009a.camel@linux.ibm.com>
Subject: Re: [PATCH v5 4/5] iommu/s390: support map/unmap for additional
 table regions
From: Niklas Schnelle <schnelle@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>, joro@8bytes.org, will@kernel.org,
        robin.murphy@arm.com, gerald.schaefer@linux.ibm.com
Cc: hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        svens@linux.ibm.com, borntraeger@linux.ibm.com, clg@redhat.com,
        iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
Date: Wed, 16 Apr 2025 11:19:52 +0200
In-Reply-To: <20250411202433.181683-5-mjrosato@linux.ibm.com>
References: <20250411202433.181683-1-mjrosato@linux.ibm.com>
	 <20250411202433.181683-5-mjrosato@linux.ibm.com>
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
X-Proofpoint-GUID: gJpzFUxFP6vUViGiTZZR8c3_viSqjuVX
X-Proofpoint-ORIG-GUID: gJpzFUxFP6vUViGiTZZR8c3_viSqjuVX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_03,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 mlxlogscore=999 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160073

On Fri, 2025-04-11 at 16:24 -0400, Matthew Rosato wrote:
> Map and unmap ops use the shared dma_walk_cpu_trans routine, update
> this using the origin_type of the dma_table to determine how many
> table levels must be walked.
>=20
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  drivers/iommu/s390-iommu.c | 127 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 119 insertions(+), 8 deletions(-)
>=20
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index 338a7381e918..46f45b136993 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -67,6 +67,20 @@ static inline void set_pt_pfaa(unsigned long *entry, p=
hys_addr_t pfaa)
>  	*entry |=3D (pfaa & ZPCI_PTE_ADDR_MASK);
>  }
> =20
> +static inline void set_rf_rso(unsigned long *entry, phys_addr_t rso)
> +{
> +	*entry &=3D ZPCI_RTE_FLAG_MASK;
> +	*entry |=3D (rso & ZPCI_RTE_ADDR_MASK);
> +	*entry |=3D ZPCI_TABLE_TYPE_RFX;
> +}
> +
> +static inline void set_rs_rto(unsigned long *entry, phys_addr_t rto)
> +{
> +	*entry &=3D ZPCI_RTE_FLAG_MASK;
> +	*entry |=3D (rto & ZPCI_RTE_ADDR_MASK);
> +	*entry |=3D ZPCI_TABLE_TYPE_RSX;
> +}
> +
>  static inline void set_rt_sto(unsigned long *entry, phys_addr_t sto)
>  {
>  	*entry &=3D ZPCI_RTE_FLAG_MASK;
> @@ -81,6 +95,22 @@ static inline void set_st_pto(unsigned long *entry, ph=
ys_addr_t pto)
>  	*entry |=3D ZPCI_TABLE_TYPE_SX;
>  }
> =20
> +static inline void validate_rf_entry(unsigned long *entry)
> +{
> +	*entry &=3D ~ZPCI_TABLE_VALID_MASK;
> +	*entry &=3D ~ZPCI_TABLE_OFFSET_MASK;
> +	*entry |=3D ZPCI_TABLE_VALID;
> +	*entry |=3D ZPCI_TABLE_LEN_RFX;
> +}
> +
> +static inline void validate_rs_entry(unsigned long *entry)
> +{
> +	*entry &=3D ~ZPCI_TABLE_VALID_MASK;
> +	*entry &=3D ~ZPCI_TABLE_OFFSET_MASK;
> +	*entry |=3D ZPCI_TABLE_VALID;
> +	*entry |=3D ZPCI_TABLE_LEN_RSX;
> +}
> +
>=20
--- snip ---
> =20
> -static unsigned long *dma_walk_cpu_trans(unsigned long *rto, dma_addr_t =
dma_addr, gfp_t gfp)
> +static unsigned long *dma_walk_region_tables(struct s390_domain *domain,
> +					     dma_addr_t dma_addr, gfp_t gfp)
>  {
> -	unsigned long *sto, *pto;
> +	switch (domain->origin_type) {
> +	case ZPCI_TABLE_TYPE_RFX:
> +		return dma_walk_rf_table(domain->dma_table, dma_addr, gfp);
> +	case ZPCI_TABLE_TYPE_RSX:
> +		return dma_walk_rs_table(domain->dma_table, dma_addr, gfp);
> +	case ZPCI_TABLE_TYPE_RTX:
> +		return domain->dma_table;
> +	default:
> +		return NULL;
> +	}
> +}
> +
> +static unsigned long *dma_walk_cpu_trans(struct s390_domain *domain,
> +					 dma_addr_t dma_addr, gfp_t gfp)
> +{
> +	unsigned long *rto, *sto, *pto;
>  	unsigned int rtx, sx, px;
> =20
> +	rto =3D dma_walk_region_tables(domain, dma_addr, gfp);
> +	if (!rto)
> +		return NULL;
> +
>  	rtx =3D calc_rtx(dma_addr);
>  	sto =3D dma_get_seg_table_origin(&rto[rtx], gfp);
>  	if (!sto)
> @@ -690,8 +804,7 @@ static int s390_iommu_validate_trans(struct s390_doma=
in *s390_domain,
>  	int rc;
> =20
>  	for (i =3D 0; i < nr_pages; i++) {
> -		entry =3D dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
> -					   gfp);
> +		entry =3D dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
>  		if (unlikely(!entry)) {
>  			rc =3D -ENOMEM;
>  			goto undo_cpu_trans;
> @@ -706,8 +819,7 @@ static int s390_iommu_validate_trans(struct s390_doma=
in *s390_domain,
>  undo_cpu_trans:
>  	while (i-- > 0) {
>  		dma_addr -=3D PAGE_SIZE;
> -		entry =3D dma_walk_cpu_trans(s390_domain->dma_table,
> -					   dma_addr, gfp);
> +		entry =3D dma_walk_cpu_trans(s390_domain, dma_addr, gfp);
>  		if (!entry)
>  			break;
>  		dma_update_cpu_trans(entry, 0, ZPCI_PTE_INVALID);
> @@ -724,8 +836,7 @@ static int s390_iommu_invalidate_trans(struct s390_do=
main *s390_domain,
>  	int rc =3D 0;
> =20
>  	for (i =3D 0; i < nr_pages; i++) {
> -		entry =3D dma_walk_cpu_trans(s390_domain->dma_table, dma_addr,
> -					   GFP_ATOMIC);
> +		entry =3D dma_walk_cpu_trans(s390_domain, dma_addr, GFP_ATOMIC);
>  		if (unlikely(!entry)) {
>  			rc =3D -EINVAL;
>  			break;

Looks good to me and we even get nicer formatting :)

Reviewed-by: Niklas Schnelle <schnelle@linux.ibm.com>

