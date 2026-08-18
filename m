Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5640B36A374;
	Tue, 18 Aug 2026 20:16:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787084193; cv=none; b=ge+alZMkrxtNyEHS2kUXMQJAd5R6szOc9lmCqaVspVfSoCFOKiT/TgicHvHnXUQeComo1WwiA8cITYMi0u94npJ0NwUQvO6vVTCzIlNf86jR7vyJru9lHUMN2Av8tXR9Wz9mpWcfD+O8p2h3F9/+1WbY76gEzpl/lfhnioPZUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787084193; c=relaxed/simple;
	bh=4Kzh2BqFz3QNvHWgeEiAKhA9ukomOLDvb++xnsuKgAE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeOnJuwHOpVSOF/gbPBbUlUeBLExPewmw/Ctnt7sncKi2rSw14JDo5LLrOFLgVX9Y7jm6GlWiQtqDzQWy983yO5W3OQJljDxmQlc+SN+94QZEtZSB/OlXxQiyDlxT4CrzHrnPCqFnqSnCbphey1P2OCQztVVN/0abwh3Cl1jwdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=p2S/DKfV; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="p2S/DKfV"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IJWDLW1260956;
	Tue, 18 Aug 2026 20:16:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=6lVzk4
	esEkUfnSiu7Le8xGcLup67KWzd3QJ9AT+Jyus=; b=p2S/DKfV4xTH9YqTl8goEn
	eZNeeR5CMZ415H977wX6gb/9EgrHX9v2lQleNFhgaampCOhLnEdpS+x6WoeKoG2V
	Wn0/OurB4q/kNPegcu7pBTQyRcPet9iwj4vjaJqYCwehLyqaRGpp9y8VBprDGUyi
	3o1j/OfKPmOzcLiO9njH8997QDJUfgxrlN97Q5Fxcu+kXMdMtUgzTVbIsFi0lkPJ
	zmSd4FTVE7Vf4GaaUIDxPyr+74Q5auGkisgETwXpHh9xDGso2UHATH1g3FmfnJ/s
	RwC1i7lwZsO2WHityqy+eKs5x6Cwx7UXRJMyTvtCjLB6zkqBBz1XWM6dlhKkG03Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fu4tqr2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:16:19 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IKBNEr009047;
	Tue, 18 Aug 2026 20:16:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw5d7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 20:16:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IKGHvI16908928
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 20:16:17 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1B05B5805E;
	Tue, 18 Aug 2026 20:16:17 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A08E158051;
	Tue, 18 Aug 2026 20:16:15 +0000 (GMT)
Received: from [9.61.131.241] (unknown [9.61.131.241])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 20:16:15 +0000 (GMT)
Message-ID: <98713094-10c0-47fa-b54c-c67ab82f7a51@linux.ibm.com>
Date: Tue, 18 Aug 2026 16:16:15 -0400
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
To: Niklas Schnelle <schnelle@linux.ibm.com>,
        Farhan Ali
 <alifm@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)"
 <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>
Cc: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Tobias Schumacher <ts@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Content-Language: en-US
From: Matthew Rosato <mjrosato@linux.ibm.com>
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RiMDqjaebPd6v69bqhv844lhZhQfWhgC
X-Authority-Analysis: v=2.4 cv=NLLlPU6g c=1 sm=1 tr=0 ts=6a84bd93 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=th3aBrcy0Tt1vy9RbOYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX46rrz4NFBge2
 1Gi25W6pprn6qgypQ3CyZk/C07s/juEqBaJU0uAs4TWZndURfYbs1VW6/O6/V+iJIXqWHczWjdf
 t0XDNpUWYo7oqh/+GytdKPiiQrbB4iU=
X-Proofpoint-ORIG-GUID: RiMDqjaebPd6v69bqhv844lhZhQfWhgC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE0NyBTYWx0ZWRfX/hAb4AoPEJJ8
 2hJpeKbfgMIO+3Ay4Wdwl/fZa+VYtnHAOOG9xv0AtoB0EYyeyYsXleSDaapj1yOgZYVumi2EKfH
 xftmsOXOo8uBQcVjb84T4XQRG74WdXjg8k8L0yC0YvDEQ/64w+jJ2vXfjjy96Cbg2VncmTYlWaQ
 MPNt9o4lVwJCSH9amr0wa19yH04Czu8FUYcJyeB8c5+JZH5hME4NAb9HmTkldUL6cE5BF+9Wykq
 yRkHF2j/yI1Bx1YdaVm7M1w+GvDJYa7Wb/RqGT1uLa2KcwHwOWKHQyjDuuKxBjbKXhijJYdb+nr
 HxV6wqA7MYDOe+5ZcYo+03P1rXji7KR2J7v1EzvhXIe9SyTZKM23I0VBwBo9H5/oSL2SCJ1pamp
 HS+SLaqruArRebk9V1DqiuHLWT3EpTc37RhyxpwuG7UywfNQITy2fMDjDm/eLRZdmKdZliwA/t6
 lIrSCnePET8vqvREtBg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_04,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 spamscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 malwarescore=0 suspectscore=0 clxscore=1011 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180147

On 8/18/26 3:13 PM, Niklas Schnelle wrote:
> When using a 5-level translation table via ZPCI_TABLE_TYPE_RFX
> get_rso_from_iova() returns NULL when the region-first entry is invalid.
> Yet in get_rto_from_iova() the region-second origin rso is not checked
> to be non-NULL before accessing rso[rsx] leading to a NULL pointer
> dereference instead of a NULL return when iova_to_phys() is called on
> a unmapped IOVA. Fix this by adding the missing NULL check.
> 
> Cc: stable@vger.kernel.org
> Fixes: 81244074b518 ("iommu/s390: allow larger region tables")
> Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>

Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>

> ---
>  drivers/iommu/s390-iommu.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iommu/s390-iommu.c b/drivers/iommu/s390-iommu.c
> index f148f559ac56..58ca7727b7f2 100644
> --- a/drivers/iommu/s390-iommu.c
> +++ b/drivers/iommu/s390-iommu.c
> @@ -974,6 +974,8 @@ static unsigned long *get_rto_from_iova(struct s390_domain *domain,
>  	case ZPCI_TABLE_TYPE_RFX:
>  	case ZPCI_TABLE_TYPE_RSX:
>  		rso = get_rso_from_iova(domain, iova);
> +		if (!rso)
> +			return NULL;
>  		rsx = calc_rsx(iova);
>  		rse = READ_ONCE(rso[rsx]);
>  		if (!reg_entry_isvalid(rse))
> 
> ---
> base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
> change-id: 20260818-iommu_fix_iova_to_phys-5879275b95ec
> 
> Best regards,

