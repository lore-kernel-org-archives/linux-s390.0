Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B88AC2BE656;
	Fri, 21 Aug 2026 12:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787315962; cv=none; b=Ivy06BDi7b6k7ZpXmRGtolFEXCDCtW0agNve98KURTEr/vK6f+KkL7oyv0c4WjnUm6Vmo5ukG9KJvJcOIaPpHwhZp2ByaYFYW32K27p3l/M7ijnh8ETvOw8tPXi40qw9M/3l2cJa2VayTkb0LmCUpARFhlIQvCE8sT6WAsgzxS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787315962; c=relaxed/simple;
	bh=4mYURL+s1ldrK62t4s0H9FxHaNWHmqXcmyhPCoJZkbM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=j54YThlbxPWpqIzBDlTfzVKRygzJ/y6zz4CVD5DiIprMGEn7J1dcMX7ShalT6W+g3YctsYpsY13wqxtEjq80P+1Z8xa5MLy6nrVnl3qfD8SCcsec5hzSpVj8qdtJzf7HG+djWIVZdgejDCKz7pcDpF8YmJogOtQZ7+NHjAzjM6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=LDYlOnm5; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="LDYlOnm5"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67LC1ZrF3766793;
	Fri, 21 Aug 2026 12:39:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:sender:subject:to; s=pp1;
	 bh=tRqdJQLnIVA94Uwpfm8oSywK7asl1ud4Ag3HNO0LVo0=; b=LDYlOnm5gcS8
	NzK+l9Pyw7gEnuen844X9I2iea2Rxx3gXjBfjy4shJES9btEiNBN+mA/tHKYhvNu
	slaHycZQFgsfIWNuTBUwDecKc5QVxMJIK5ZSkn1IHg7LGWF6G6GhavxojwWCmGSs
	BMjIPkIYHPPu5AQpB17xAHsrBbELvfaQueFkpkGJAzKWfs3nnkv2D3B5tYAvxQnj
	Uh40kQOLbQ4sdH63wqIabHJ7xXFdfC32w+6oxhEqtP6kVov7JIdHDNXW1V88PvkH
	lLg+omIiCxT2/Smme3i2w7MKtYcJ3H7BFR020ytIuvEevWr/+Py4vDtWZXQSv5Hj
	q04YZY3Lqg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0heas-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:39:08 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67LCQGXu003512;
	Fri, 21 Aug 2026 12:39:07 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ekmmf9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 21 Aug 2026 12:39:07 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67LCd1O940042986
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 21 Aug 2026 12:39:01 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2558E20043;
	Fri, 21 Aug 2026 12:39:01 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0F88320040;
	Fri, 21 Aug 2026 12:39:01 +0000 (GMT)
Received: from p14sgen6-pf6akexs (unknown [9.224.70.27])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 21 Aug 2026 12:39:01 +0000 (GMT)
Received: from bblock by p14sgen6-pf6akexs with local (Exim 4.99.5)
	(envelope-from <bblock@linux.ibm.com>)
	id 1wxOWS-00000000iZl-3PBa;
	Fri, 21 Aug 2026 14:39:00 +0200
Date: Fri, 21 Aug 2026 14:39:00 +0200
From: Benjamin Block <bblock@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Omar Elghoul <oelghoul@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <jroedel@suse.de>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
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
Subject: Re: [PATCH] iommu/s390: Fix NULL dereference in iova_to_phys() with
 ZPCI_TABLE_TYPE_RFX
Message-ID: <20260821123900.GB18339@p14sgen6-pf6akexs.ehn-de.ibm.com>
References: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260818-iommu_fix_iova_to_phys-v1-1-1cd76d2a55b8@linux.ibm.com>
Sender: Benjamin Block <bblock@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3KuUyA4baePonVYfh0ABHys77SWYAhsX
X-Proofpoint-GUID: 3KuUyA4baePonVYfh0ABHys77SWYAhsX
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a8846ec cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=8nJEP1OIZ-IA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=th3aBrcy0Tt1vy9RbOYA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX9wgRxKjYDXXm
 LOh7uSIEkXd7qDJwQDb0bv+Y5UoS6lwb5YErk1kX7J5goz0R4VwF2AEojHety0f/UR2rwv1+n38
 3zUynyzeNBkr6Pyp+wsRlIqriE6Da60=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIxMDA5NiBTYWx0ZWRfX6ClxFJZNur0w
 w2K3XL3umzcXEC8nVnEIdEU+aB8fw9BacMSjdIluZG1QVSLkeH8t3G/LSWA3JBXku2uCQCsyh3+
 O8frZiwZZ5D54Vf+AjP419WQ5H+WpnO+MI0Q6hExujmlYPuWk/VJgR59Z3wO3XwB/sl5OaHG4ss
 92s7rT6/MEN/KGWGAeGY9eYtioUQwoIenL5759ihKKV+11FZGHofUb2/Nq56wlgqpayw0XmZZIM
 VIaOHWH3BSrUfXTX9AYwFqokTDUk35A6Y9oTcdr9ApyRHsmD1rw6tlx6pRW0r1wC1dRgnvOL85D
 PkF9L/xKszlooMoXtIxSYpBkesBkuMobf6qxlvE5JpurQSSGXHiX5JcNKzqU7hdcd4SF94B7XLT
 8SlqrQ0UCFXDAagGGx569vZL3UJ8XEW2z20aTTGFmQNevs/0q9N5ANjhczqPQd590RmECYi1VeB
 MdlpINVfGaMnTwh30YA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-21_04,2026-08-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1011 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608210096

On Tue, Aug 18, 2026 at 09:13:17PM +0200, Niklas Schnelle wrote:
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

Looks good to me!


Reviewed-by: Benjamin Block <bblock@linux.ibm.com>

-- 
Best Regards, Benjamin Block        /        Linux on IBM Z Kernel Development
IBM Deutschland Research & Development GmbH    /   https://www.ibm.com/privacy
Vors. Aufs.-R.: Wolfgang Wendt         /        Geschäftsführung: David Faller
Sitz der Ges.: Ehningen     /     Registergericht: AmtsG Stuttgart, HRB 243294
