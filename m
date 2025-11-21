Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2F3A2765FF;
	Fri, 21 Nov 2025 13:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763731131; cv=none; b=otmofyVIcspadHP0kflTRtmxCA+lkYSPQ4Ia2BLSDKBoJPw8guaLzv9MXmTMZJyScRILpjdy68mPbX+cwLNxiQBHhWLBk6koXmychE6Xcf8xcy0YQuQCHCsrejALo0ttBg7eIQ1rOE4dsxKHAp7VzH6pMG4O6hftFhY1jZCOvS4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763731131; c=relaxed/simple;
	bh=5O26KkrM4DwrZO3yvjcEsKkx3hhKiQVHx9I5SopdCPE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CLR9E0HtHBOamCHsziYz8ZNbhrURuNTU9hOOPCk2xNo9tVPBC5Rg38/WzARIvVxqUTH3YaBnw2UmBz+Ub56IhmNJJann/GPJOpiNoH6AYJWv4omDwmEiPzrklXJHKV0uv3rTg3LccMO78KOb5ZtNsj41MERIu01ojqqA/I3tfgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Njmj47If; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Njmj47If"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALCa3kR028016;
	Fri, 21 Nov 2025 13:18:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=id71A7ZBKAN/KcC1B3eLXu8ms3CGHt
	CbXT8ZVcnauNA=; b=Njmj47IfVeQ9cdILlrppsOULVQXRHgmt+zrd3Xzgg4/8M6
	/hPU+5FoY+EanINVSEIX+GdDQaXbdhD/3VbJdoLmkXUiy/xHiMfAsAq/4Zry/Q6S
	FDU/OfRVUCT4+j6tgyK3lWPHxwg+5GSzDH4GTEM31MMKR2ZafLepkd5OSCaVn+Ad
	UFCK3o3NiCnCVJppC6av4vHtKBlz3MVzBO6NoD7//S/UigMbkbQJ4wSluqEMLT1y
	9v5KoVSQREnGE4Hs1WzdODRJO/M02zUM6baGQVdXRF+tFLvwzsFUitx2hF52qSUV
	TLagG2MMBA9LHEOCDy+uje5/2TNVQGYLYF8L17OQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4aejkac0bv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:18:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5ALBUTrG030851;
	Fri, 21 Nov 2025 13:18:44 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4af47ycf1e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Nov 2025 13:18:44 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5ALDIe9742729952
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Nov 2025 13:18:40 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6F6342004B;
	Fri, 21 Nov 2025 13:18:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA9EF20040;
	Fri, 21 Nov 2025 13:18:39 +0000 (GMT)
Received: from osiris (unknown [9.111.15.252])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Nov 2025 13:18:39 +0000 (GMT)
Date: Fri, 21 Nov 2025 14:18:38 +0100
From: Heiko Carstens <hca@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Farhan Ali <alifm@linux.ibm.com>
Subject: Re: [PATCH v5 2/2] s390/pci: Migrate s390 IRQ logic to IRQ domain API
Message-ID: <20251121131838.27602Bb6-hca@linux.ibm.com>
References: <20251121-implement-msi-domain-v5-0-d7e717dfd3f7@linux.ibm.com>
 <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251121-implement-msi-domain-v5-2-d7e717dfd3f7@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 2vA05v_JHdkt4nJEqa76EoQIT7muha6Q
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTE1MDAzMiBTYWx0ZWRfX1AKNfTdjcP+1
 EG35vvT3XP1x0B/U9DPvHYZzI2KUm0qX+yuEgNgWMJb9macbF2Yc/RXWKgcg9Lk3vEhPTmWhWGu
 gCpz392Gs9NiroAfEzuS7MLGEG9ghgBF3DDNpQL17sx0oKrEU3FQsmzr7pbVyB6dO/l4l7wByqb
 gmkaEOqxwcliyGrfgnlUsmwmkB4NzF6estI8eZvKQk6HTAc/YTPdK7oHod9M+a2ufNRivokpw8M
 8X2LPvaxA/u5xDPZETGIJf+Pn3BozHTqYTAy7JksYjbu4dH5OaE5LUgT72jXtakoNt717IcKyq5
 06Pwlr26R1bpDQxXQG64svIhfYIhaHIWN/UKmb2gi96MYB9JX4odiV86WYOJi1yKwae4VPn4ZjL
 R1qVJz1FzMNRZk7VVeifQNjfanlVdQ==
X-Proofpoint-ORIG-GUID: 2vA05v_JHdkt4nJEqa76EoQIT7muha6Q
X-Authority-Analysis: v=2.4 cv=XtL3+FF9 c=1 sm=1 tr=0 ts=692066b5 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=jRXUgG7nxkhpfmSRjOoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-21_03,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511150032

On Fri, Nov 21, 2025 at 06:32:19AM +0100, Tobias Schumacher wrote:
> s390 is one of the last architectures using the legacy API for setup and
> teardown of PCI MSI IRQs. Migrate the s390 IRQ allocation and teardown
> to the MSI parent domain API. For details, see:
...
> Signed-off-by: Tobias Schumacher <ts@linux.ibm.com>
> ---
>  arch/s390/Kconfig           |   1 +
>  arch/s390/include/asm/pci.h |   4 +
>  arch/s390/pci/pci_bus.c     |  21 ++-
>  arch/s390/pci/pci_irq.c     | 333 +++++++++++++++++++++++++++-----------------
>  4 files changed, 227 insertions(+), 132 deletions(-)
...
>  static struct irq_chip zpci_irq_chip = {
>  	.name = "PCI-MSI",
> -	.irq_unmask = pci_msi_unmask_irq,
> -	.irq_mask = pci_msi_mask_irq,
> +	.irq_compose_msi_msg = zpci_compose_msi_msg
>  };

C99 initializers are supposed to end with a comma. If new initializers would be
added with subsequent patches, this makes the patches smaller (adding the
extra "," to the existing line is just noise).

> -	if (msi_vecs < nvec) {
> -		pr_info("%s requested %d irqs, allocate system limit of %d",
> +	if (msi_vecs < nvec)
> +		pr_info("%s requested %d IRQs, allocate system limit of %d\n",
>  			pci_name(pdev), nvec, zdev->max_msi);
> -	}

Bodies of if-statements with more than one line are supposed to come with
brackets for readability reasons, like it used to be before your change.

Note that for new s390 code we mostly follow the coding style guideline as
described in Documentation/process/maintainer-tip.rst. Maybe it makes sense
to spend the effort to add an s390 specific variant of that document...

Anyway, I'll change your code accordingly when applying - no need for a
version.
