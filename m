Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E306C303A15;
	Tue, 21 Oct 2025 08:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761036526; cv=none; b=df1Y8yoeTI6PLC8r/RKf43S9dzleTACjbphyuqmLXxt8nuJGl59ffh+18otfugNj5V0UGUlQ+SXh8X0KhoSriAnCuRbGqpQjY3Jz1K+6/W58ztFvm5tpiPt0dBYNesxkXir21fE+/RhxPk4rDMJTAgjT2F0kKjz8dofNREw+gJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761036526; c=relaxed/simple;
	bh=0vRwJbUYs0Gu/VJYQ2xfMLpSFAeGteIkNSPUVasCNE4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IdsajJHmMc9NzHQs8Bv3reHf9+IWDFfhBztVKj1KbO8WIa1M8uHG/8P5NHmGliCGQe/IndkbA7ccaE4oF4rRVyfvteJykik5yCoHoGPup5zgGtpvI5DlvNqBLwAYwh8NrYT9yrkzdaTFFrmCTgah3L/kk/GlA1tC2FmKUC7Skuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=sMUMWAXX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="sMUMWAXX"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59L5lgc1020450;
	Tue, 21 Oct 2025 08:48:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=z7oyuGf+YmrdjdAlCdljzaOoBcmjt3
	nedZ0w+/dyCrI=; b=sMUMWAXX/8sY8Do1huxbrboQr5eFVQnwPlBEki6stGqniW
	ldYu1HZKhMzVPDElU1aXezrbtB4lgLP8ckyaP/GumTFfxl2oZrCEBQQqbhm4UcN3
	LFaGusmctrYMbp18Tvh8JsC0xmCrJ3TfUinBLPP2/NsjVyMa+mFTZWpsC+CfwlMs
	w3YcPLvERjs41TDcxL8HAEhvLtHRZQFTHZCklpYDCImAxYdisewiSNb+G3gA8cOZ
	iaJresCsFCo7vBE5SNattGsJ0uX6iv7hgIYsiDjUeIsjMRQ7LRuiVVzXMd3jLuoH
	Z+0jFkX+m/p6lcWSKuc2N99ZxVl1E9s7o5IZ1p9A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31c4sc8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:48:25 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59L6CiX8014658;
	Tue, 21 Oct 2025 08:48:24 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49vn7s22hc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Oct 2025 08:48:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59L8mMtt16974242
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 08:48:22 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 653A120043;
	Tue, 21 Oct 2025 08:48:22 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5C9720040;
	Tue, 21 Oct 2025 08:48:21 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.111.75.81])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Oct 2025 08:48:21 +0000 (GMT)
Date: Tue, 21 Oct 2025 10:48:20 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, iommu@lists.linux.dev,
        linux-s390@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        virtualization@lists.linux.dev
Subject: Re: [PATCH] mm: Make INVALID_PHYS_ADDR a generic macro
Message-ID: <8ef6bea9-5905-4d15-be77-f58645d967d0-agordeev@linux.ibm.com>
References: <20251021025638.2420216-1-anshuman.khandual@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251021025638.2420216-1-anshuman.khandual@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: SFsr08sj6VOHWyp68BfmatDwsVOqiBAF
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfXybe+b5Oqvt21
 7nQzCRWt0Qdz0L6NetKOeEaFWC9/bRTheXys9Jo0yPruZzS8K1X5soLFYF64NcSmqjVmSyDC5k7
 ecAg26cW+S87fUIL3yYns3aen8OVIZD9HAosIUS/itSROuTxJahgvxsQ9eTLyCOX3V+9XbM18Ux
 srZPJXF0zBCi/JPzlDtS6TSEVgZ8QMfo9UBC3MMgfAsge8DoTecVq1HmUygmZIYfkQHQ1VBWHr4
 MkNT+sO9OhvDdmRk9hEKXAmmD0Z+/PVMR94eMBvCLLoe9Pedp+1Eh5J7uwYNuoGZ8FKyYreVc7L
 MISNLC2tSYEN2woAfEBhoNkzvNR0Cg5qmF16Lu+Rj2FPXRxwP241fYzx4PO6UF+Z7hfl1eOTFgk
 OALOr+UD8heOc/vPfeqdN+n37aFx9Q==
X-Proofpoint-GUID: SFsr08sj6VOHWyp68BfmatDwsVOqiBAF
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f748d9 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=37rDS-QxAAAA:8 a=JfrnYn6hAAAA:8 a=7CQSdrXTAAAA:8
 a=VnNF1IyMAAAA:8 a=mrUCOdJJ3iSU8PumKu0A:9 a=CjuIK1q_8ugA:10
 a=k1Nq6YrhK2t884LQW06G:22 a=1CNFftbPRP8L7MoqJWF3:22 a=a-qgeE7W1pNrGK8U0ZQC:22
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-20_07,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

On Tue, Oct 21, 2025 at 03:56:38AM +0100, Anshuman Khandual wrote:
> INVALID_PHYS_ADDR has very similar definitions across the code base. Hence
> just move that inside header <liux/mm.h> for more generic usage. Also drop
> the now redundant ones which are no longer required.
> 
> Cc: linux-kernel@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: iommu@lists.linux.dev
> Cc: linux-s390@vger.kernel.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: virtualization@lists.linux.dev
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/mm/mmu.c                  | 2 --
>  arch/s390/boot/vmem.c                | 1 -
>  drivers/vdpa/vdpa_user/iova_domain.h | 2 --
>  include/linux/mm.h                   | 2 ++
>  kernel/dma/swiotlb.c                 | 2 --
>  5 files changed, 2 insertions(+), 7 deletions(-)
...
> diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
> index cea3de4dce8c..fbe64ffdfb96 100644
> --- a/arch/s390/boot/vmem.c
> +++ b/arch/s390/boot/vmem.c
> @@ -16,7 +16,6 @@
>  #include "decompressor.h"
>  #include "boot.h"
>  
> -#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
>  struct ctlreg __bootdata_preserved(s390_invalid_asce);
>  
>  #ifdef CONFIG_PROC_FS

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>	# s390

Thanks!
