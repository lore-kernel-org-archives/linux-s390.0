Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D610280A56
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 16:17:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781799423; cv=none; b=sPhEUO55UA4vytbLFqaKuOh/wjzrJRkYLqv5VrTBQ+PUm/zMCNLFWkA19fWo86tYJZGGGMEr9ZaABmOt7OYVkUtqRbmspfhV0EuN/YUWSS434IU6n9jI15KA/FAeLqE5/P2OVojlkD5P03Pi4zUUZyj/iM3ATl+67x+MT5y7C1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781799423; c=relaxed/simple;
	bh=hYI+hKTvid2RM3u9yYp1jiAw3X88wnHIi1zDeTxnd/w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=emTGgcuOkpTXy0U0N9XYsUshxBHyxDZgTHNC2OCUdiol9m+huklaIH9E0agvSNhsF2TJeTzAW15SI9mFtBVyLqicizXnowudamoStGEXC1jpiXE3KPsuaLM9zXZBKKEWZ39JUdzIQN6q9JLmt0IJ48H8YLCiq7vw5mHoBnCJ7Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kq/J3yy4; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kq/J3yy4"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65IFIll73711907
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 16:17:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=fah1NZY6h02G10Ns/RIqJQ3JnLwq8x
	xscGxouqhnUeQ=; b=kq/J3yy4zeMixwmGHzExB2EEPqDBrLIxihYkmiUyal70Pm
	TiaNtMrbvFnTGy0I2MF/PYnKx4eoraFXlSq35JkISc96/hiq8dou+Q5QVuyrG3sI
	s3yKYAmqQhSfNevf+K8IXd1w96cKlIzipeJ1FFIFRvcamQWeIbCTOIQ7+2sZcb2p
	Ev/cSiot0dnUrjbIVnPKgMz/j+CJv5eASHYXvfKdYdAUFrt7CdXc8hWn3j0pntX3
	b251Yz5ON2ePjStkhXhF2G8x+hkvgpnuGQ3XatQXdwiVkSO549FGWNASlxKnWIQ9
	ngD35AI+ScHZPtONFK6w/AlhrGs8QQ3Lzp5xsMzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4eueqx9093-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 16:17:01 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65IG4iEp028220
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 16:17:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172cjj2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 18 Jun 2026 16:17:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65IGGuci27132412
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Jun 2026 16:16:57 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D204120043;
	Thu, 18 Jun 2026 16:16:56 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B96D820040;
	Thu, 18 Jun 2026 16:16:56 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.224.92.206])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 18 Jun 2026 16:16:56 +0000 (GMT)
Date: Thu, 18 Jun 2026 18:16:55 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: linux-s390 <linux-s390@vger.kernel.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Subject: Re: [PATCH] s390/mm: Use set_pmd() / set_pud() for hugetlb pagetable
 entries
Message-ID: <35d23772-89a3-4e55-b4b6-abd83db3001c-agordeev@linux.ibm.com>
References: <20260616174627.1068004-1-gerald.schaefer@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616174627.1068004-1-gerald.schaefer@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfX1Azinr/PFjHP
 0av5xlxz9nBj1BAEUuzCsGnu/1R9dsoXRcGTAYWzB6GWMeaEWBNQC5gRHTGOp8RImN5Fz1opFWK
 FQENH+oD6kB/s88AJ83EMBNI1h2+Tory1bj+66j0PjlFNO07GgIXcBKtH6qxpo7r6XX2us3F6Zj
 +TBOOZbxWbrEDKmyfq5/Jxh31Kif6+EO5S6kYuNJXUw1f/StRUrHA9zjkADFiKdk51VqIiFoFZW
 vY8R809/5V7N4/ctP7rN80qQN6khq91Sh76CzRbW6B8OnPCdsbg2iMk4pi3juaOuUWxFvPmk7oQ
 BKmFA7ksL8en41K/UFkzZRYnjLSCdDQO7Oq2wwGt/s/pba+q5NalU1w1Xq69PN3h7dA9dhy0K/W
 LOCJ5ON8f47mZ/ie+vX0a1C3RUr7aORvNM3YfFPlhMy1hjDWG4NNogbSJsfoDokUsfGCDK+JGXw
 lry9LL1Lo/+cp+9w9NQ==
X-Proofpoint-GUID: EWpq8Wy2DRww8DNeovOwxhK9FWjjCzI9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDE0NyBTYWx0ZWRfX3Dr+X1di34II
 KOBjXAecDttq/0oJTX9xSY2wyFa1cKdt4O3Atb9DdiCn2nB5/b33eRXaq7tKPSr+TA74Ty1fBHs
 Cp+1ZrdLaSJO2IWDS2MeRZMGow9zmY8=
X-Proofpoint-ORIG-GUID: EWpq8Wy2DRww8DNeovOwxhK9FWjjCzI9
X-Authority-Analysis: v=2.4 cv=auGCzyZV c=1 sm=1 tr=0 ts=6a3419fd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=w_ULX488V-JFV4fqhTQA:9 a=CjuIK1q_8ugA:10 a=zZCYzV9kfG8A:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 priorityscore=1501 suspectscore=0 impostorscore=0
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606180147

On Tue, Jun 16, 2026 at 07:46:27PM +0200, Gerald Schaefer wrote:
> hugetlb code is known to view all pagetable entries as PTEs, instead of
> corresponding upper levels like PMD or PUD. For s390, with different
> pagetable entry layout for different levels, this requires some
> conversion action under the hood.
> 
> The converted PMD and PUD entries are then written via set_pte()
> function, but that might add some PTE-specific modifications.
> There is no functional problem with current code, and the clearing of
> _PAGE_UNUSED in set_pte(). Avoid future problems by using the set_pmd()
> and set_pud() functions instead.
> 
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>
> ---
>  arch/s390/include/asm/hugetlb.h |  4 ++--
>  arch/s390/mm/hugetlbpage.c      | 10 ++++++----
>  2 files changed, 8 insertions(+), 6 deletions(-)

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

and applied, thanks!
