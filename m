Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3BF23EFFDB;
	Mon, 18 May 2026 11:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779104695; cv=none; b=JHylmJb/w/FI03etOpGC1Qjl6SCIlulh+dmF2UKOGP6gdCB5/8t2tHTBRg703YRLU/K1pYo9V+ym9fse75hxwD+xWdjiICReL82QPwU2IoeiFuckXYwUtJxe3jVIi2L60FeJmrd5aUVesvYAHzxXSR7O3IJTixTCdZ6WgeR/3T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779104695; c=relaxed/simple;
	bh=yMb1SzhAh3/f/kDUldVCtMfSRAQ6WMeQpo1bDvmqvD0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=gh4to4f/4PbT4vwqHYtQG93rRYNKlZJBkvqcJ199mHFz/NkOLr6tWrquiZq7EBh9vqcWStqurbaC/E+YsTNwEb5HigUFTaeDXfkBAdMabp2V7xMYfMY+cEwHM0/ZU7UWn+y6twKYqcftBHl8tHMPMTxjs7BcCyMUBnpfU2fupL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com; spf=pass smtp.mailfrom=de.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GMN2djOR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GMN2djOR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64I7rsdm823931;
	Mon, 18 May 2026 11:44:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=reTlL1
	XWU+Ra9/OVzwep5W7v2QWb2Kxhly4L3Z+ghy0=; b=GMN2djORdYhAvC5GD+shai
	3qVvaOK7IaWpIf0APJzzGoXTVODdmvNeSlu5bxb96mavBGdjUutiCVDu09CyE9Ii
	oXLUeVeVUdkwjxsJpWIcRurCsUe6BrVGX+xCEQofUOPgmriMLuxa/H4U/eO+Eunq
	wmGyCI5blKTA5zAkniWx1P/Vjtq4p4Ra9y3vlLWOpx+dtQpGs/tTvJ2sle4iDiPe
	okp7WyKhqh0FNAHc8qpIYmljWucVqt3nbFk9v5qpfH8x0gEZEHGaUmoLAEPrdUzX
	zYy1PBtXgKGvGpWRr0loSPvCgTbYcyiuyZqytHg4tVFMTTLD35dCQjPDB64XXkTQ
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h887bjf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:44:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64IBdRDS023024;
	Mon, 18 May 2026 11:44:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wpwv57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 18 May 2026 11:44:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64IBikuw29950616
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 11:44:46 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 039E520071;
	Mon, 18 May 2026 11:44:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D0ED120065;
	Mon, 18 May 2026 11:44:45 +0000 (GMT)
Received: from [9.52.200.39] (unknown [9.52.200.39])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 18 May 2026 11:44:45 +0000 (GMT)
Message-ID: <0f114ba1-72f6-4ffb-b179-01b8baaaec4c@de.ibm.com>
Date: Mon, 18 May 2026 13:44:45 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v2 5/5] KVM: s390: Properly reset zero bit in PGSTE
To: Claudio Imbrenda <imbrenda@linux.ibm.com>, linux-kernel@vger.kernel.org
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
        david@kernel.org, seiden@linux.ibm.com, nrb@linux.ibm.com,
        schlameuss@linux.ibm.com, gra@linux.ibm.com
References: <20260512175251.300882-1-imbrenda@linux.ibm.com>
 <20260512175251.300882-6-imbrenda@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260512175251.300882-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: f8UXM8fk8Z0an5mIf5YzOGaRnLtkeuJV
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE4MDExMiBTYWx0ZWRfX/ACSGV6cvWJg
 V00RuFk/S8h5ps1Rgf+MCqNegpOAnMZL6due2n0n0omCHvPGMzasRrlrkdQDQLdcTPDE23aFlqf
 xE/x3cpJeMjqK1h2I7kr9EEqy9q72eFobNNx819qYOLv8wQA3iRMa8SRQl4NkIWZ7HMU78A177k
 KCSUM61grtFhcNKHImvvLJ2GKtEA6ou0tuLWGHoJjioB+HsTsAwhhxAnwM/ZChYijEJDBSMA+LA
 9MbSuU3f4YpxB5tVqYxhfZ14OJ8f0MK6FVAkBBujnkjl3hrsxb8PQaMFP6Mch0kJN1sKJJzxke3
 ObGv/mMyRoAcJjqr4ZMB/Fc3byAlAysz72WQak2gNkkZWAW5A3Be2hGPpumjn7GIrGgcXUpFVtF
 C1H8A7Y6opgONlfjUwND9Q0i2u8UMm9+C0KG7+C5HgReMu5LthSV4P698JPYaejkHRUNbeWCJA6
 eqnvwwYCn//XkRuQYZA==
X-Proofpoint-GUID: f8UXM8fk8Z0an5mIf5YzOGaRnLtkeuJV
X-Authority-Analysis: v=2.4 cv=apyCzyZV c=1 sm=1 tr=0 ts=6a0afbb2 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=9DvXnxvuG7zSzAFeCowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-18_03,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 priorityscore=1501 impostorscore=0
 bulkscore=0 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605130000
 definitions=main-2605180112

Am 12.05.26 um 19:52 schrieb Claudio Imbrenda:
> When calling _gmap_ptep_xchg(), always clear the pgste.zero bit. This
> prevents the page from being accidentally discarded when getting
> unmapped.

Ideally have some example in the patch description, that makes review easier.> 
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Was this broken before the rework as well? Do we need a stable backport into 6.19
and older?

> ---
>   arch/s390/kvm/gmap.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/s390/kvm/gmap.h b/arch/s390/kvm/gmap.hcd R
> index e490f2995a26..4de9ed8d58ba 100644
> --- a/arch/s390/kvm/gmap.h
> +++ b/arch/s390/kvm/gmap.h
> @@ -199,6 +199,7 @@ static inline union pgste _gmap_ptep_xchg(struct gmap *gmap, union pte *ptep, un
>   	}
>   	if (!ptep->s.d && newpte.s.d && !newpte.s.s)
>   		SetPageDirty(pfn_to_page(newpte.h.pfra));
> +	pgste.zero = 0;
>   	return __dat_ptep_xchg(ptep, pgste, newpte, gfn, gmap->asce, uses_skeys(gmap));
>   }
>   

