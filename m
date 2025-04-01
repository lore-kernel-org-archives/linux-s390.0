Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CBE21EDA05;
	Tue,  1 Apr 2025 09:11:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743498707; cv=none; b=YW+gwP+sDkQWRKAb0k+JPxQcZIlp9E3j+5++PSYTOLyN2d4gOkmMAYe39vdpTNtIktEVsvonuRXv7FqX+emZijGWQmp1HPqnvkSEZCKH19/CBtc0ZGHvel31JhnuTaLLKMdYnzcqByxNQ5rz0quuCkHAXFS47XpL+dsovAL7ktI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743498707; c=relaxed/simple;
	bh=z5w4mqCNWGf9ESkE5yFsF6dByAcXvoIsTorTJ9KZAjA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EGETDMQu1vMVsZAK6Z1AgXdzIfmgeNsvWF4m2h7e51xh3u94DfRDQtpqzNLP0vQdZ6kIITqIxjc2+bU8vdhwcJsd35XyJeaJZ5SQGPAL7FigscD14W3u21c9XdLkyAtK9xq/n/Pu2C/zManow8/lYwZvdVAYs5Tvj4zv+tUJxUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpq1zwgC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpq1zwgC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5311amAB007991;
	Tue, 1 Apr 2025 09:11:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XyRix+4GNv6ZrOcC6r80lhGA/F7ll6
	PFz2oW/xEJcr0=; b=fpq1zwgCTB8d4LNVPauRePRc3Q6pjQVus1rLRxHbp1pvwP
	k9PhGM1n2ZaNHo3Dy4zCZeJXZJroUzUujMv9jVe8nu0ZG6my72IpS8T0YUmufVvV
	9Kc5MGVaqe7zrr97bhSO7aLsZ/gL1PTvXhVRlnpsePw3Zkspc9kvZmiPYGdDmVc+
	pXKzKxw3kqjb7M6jOMOVfbuZPk2Wv+hT3s8n2v5NEgWkd1cCypNZ0F2SBrGSx8gH
	rswC6IK50Tk0N6/aLY1BPP5mchoMDdnrpMi2V0RiY/rLlZPgX4M40/rXEgl4Yuml
	VeSJt3PZnc2B+z2mhsK6dZcoX7WU8/5p/mdcuwSA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qvfpvgxn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 09:11:22 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5318o0sg014576;
	Tue, 1 Apr 2025 09:11:21 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpm1psx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Apr 2025 09:11:21 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5319BH1r31654402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Apr 2025 09:11:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9E1692004B;
	Tue,  1 Apr 2025 09:11:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 644FF20043;
	Tue,  1 Apr 2025 09:11:17 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  1 Apr 2025 09:11:17 +0000 (GMT)
Date: Tue, 1 Apr 2025 11:11:15 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Matthew Rosato <mjrosato@linux.ibm.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
        gerald.schaefer@linux.ibm.com, schnelle@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com,
        borntraeger@linux.ibm.com, clg@redhat.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v4 5/5] iommu/s390: allow larger region tables
Message-ID: <20250401091115.7691Bd6-hca@linux.ibm.com>
References: <20250331202159.85956-1-mjrosato@linux.ibm.com>
 <20250331202159.85956-6-mjrosato@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250331202159.85956-6-mjrosato@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iggC1jnG6T90UBVs0OvZOfNAlGnIobQP
X-Proofpoint-GUID: iggC1jnG6T90UBVs0OvZOfNAlGnIobQP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-01_03,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 priorityscore=1501 clxscore=1011 adultscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=651 mlxscore=0 impostorscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504010057

On Mon, Mar 31, 2025 at 04:21:59PM -0400, Matthew Rosato wrote:
> Extend the aperture calculation to consider sizes beyond the maximum
> size of a region third table.  Attempt to always use the smallest
> table size possible to avoid unnecessary extra steps during translation.
> Update reserved region calculations to use the appropriate table size.
> 
> Signed-off-by: Matthew Rosato <mjrosato@linux.ibm.com>
> ---
>  arch/s390/include/asm/pci_dma.h |  1 +
>  drivers/iommu/s390-iommu.c      | 71 ++++++++++++++++++++++++---------
>  2 files changed, 53 insertions(+), 19 deletions(-)

...

> +	spin_lock_irqsave(&zdev->dom_lock, flags);
> +	if (zdev->s390_domain->type == IOMMU_DOMAIN_BLOCKED ||
> +	    zdev->s390_domain->type == IOMMU_DOMAIN_IDENTITY)
> +		goto out;
> +
> +	s390_domain = to_s390_domain(zdev->s390_domain);
> +	if (zdev->end_dma < max_tbl_size(s390_domain)) {
> +		end_resv = max_tbl_size(s390_domain) - zdev->end_dma;
> +		region = iommu_alloc_resv_region(zdev->end_dma + 1, end_resv,
> +						 0, IOMMU_RESV_RESERVED,
> +						 GFP_KERNEL);

GFP_KERNEL allocation while holding a spinlock is not correct.
