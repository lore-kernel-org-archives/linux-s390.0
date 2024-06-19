Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 901087710F
	for <linux-s390@vger.kernel.org>; Wed, 19 Jun 2024 22:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718837025; cv=none; b=nlPTS8+MBlUmYq5n48xSK9II5IzkTe2IjQaG8DXjI8udIzSUyROrSqo3taAjudsFIj9jiI5+7H7KjgM+JFCug3728QBvHLyuUywDbtyMGMDDkHd0Zq7dzKKzhjSbhcVM3hs5oPc4xrfMRL21Hg8zTQdjv0ptQw39IiIT13TE6xc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718837025; c=relaxed/simple;
	bh=rccHxlQCo8PCkl+wBEiFMB2ysa9BaNBWEb0AzZfRgME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SXYZKerPrs9QmQBqZ/srUyCak3gFpW1zlUEGZIxb1YukL4lv/uQluWUBQItnC1+l3lKjOzd7GYmh/9ubaPP23+ZG6TOqok43FBhhngesI83xcYdWZ7xOAgE+rqblRd9KCVYhbeaxtxGv1MwJ1ooMw95ZPyjMkB46+FCA3iRgWCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=RpnrxpTH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="RpnrxpTH"
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45JMSnYW029964;
	Wed, 19 Jun 2024 22:43:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=aT7kqBoByjh7jmnj1TUH3PePjUp
	WsIOrMkFUws0xZHk=; b=RpnrxpTHJtkjFwsI4uZTQoz1QuH3jMcuFDNncrHRrCW
	rNOuvCDKPGDeryUYDt5DrIW+b46L5nxqE+LysaA829ybyUwH9snKtfSySQt9ZdRD
	B199Q7m4IAXwuQclPwzRXiFitUvhHOSazZ9ZVksoRZp0owpSmI6e/ZseFTQtG7aw
	EkyMWKp/51MAaF/QcLOeCdsZpU/7y09VTllS8BMs7fbEUY2nLYT26AigGiMDdzAG
	YW1X6udENk1W7p9u262v2nnH9quQDAtwnYBuaNkvAeWM/i3tO/PwY63D1fhh5GCZ
	tgjvMrFUxXyxiQO7MF/gEj+h5qiQggdK7cyiEhGT4gA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85cg14g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:43:29 +0000 (GMT)
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 45JMhTr3019468;
	Wed, 19 Jun 2024 22:43:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yv85cg14e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:43:29 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45JMSFcp023897;
	Wed, 19 Jun 2024 22:43:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3ysp9qgq05-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 22:43:27 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45JMhMh755902570
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Jun 2024 22:43:24 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 25CC720043;
	Wed, 19 Jun 2024 22:43:22 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 874DF20040;
	Wed, 19 Jun 2024 22:43:21 +0000 (GMT)
Received: from localhost (unknown [9.171.70.82])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Jun 2024 22:43:21 +0000 (GMT)
Date: Thu, 20 Jun 2024 00:43:20 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, agordeev@linux.ibm.com,
        gerald.schaefer@linux.ibm.com, hca@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com,
        linux-s390@vger.kernel.org, linux-mm@kvack.org,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH] s390/mm: get total ram pages from memblock
Message-ID: <your-ad-here.call-01718837000-ext-1272@work.hours>
References: <20240616013537.20338-1-richard.weiyang@gmail.com>
 <75ee1ec6-12b0-461e-9dab-6fb6d5cc235f@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <75ee1ec6-12b0-461e-9dab-6fb6d5cc235f@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 7VUYnWupo4KNvzh5nz86YPZo-EJk7Bwt
X-Proofpoint-GUID: ZdZv4Td3iu8DpTVtM8drgoQlDoai2GQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 malwarescore=0 spamscore=0 impostorscore=0
 mlxlogscore=908 bulkscore=0 phishscore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2405170001 definitions=main-2406190169

On Tue, Jun 18, 2024 at 11:57:19AM +0200, David Hildenbrand wrote:
> On 16.06.24 03:35, Wei Yang wrote:
> > On s390, zero page's size relies on total ram pages.
> > 
> > Since we plan to move the accounting into __free_pages_core(),
> > totalram_pages may not represent the total usable pages on system
> > at this point when defer_init is enabled.
> > 
> > We can get the total usable pages from memblock directly. The size maybe
> > not accurate due to the alignment, but enough for the calculation.
> > 
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > CC: Mike Rapoport (IBM) <rppt@kernel.org>
> > CC: David Hildenbrand <david@redhat.com>
> > 
> > ---
> > Not tested on a machine, hope it is fine.
> > ---
> >   arch/s390/mm/init.c | 3 ++-
> >   1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
> > index e769d2726f4e..d811ffa5e147 100644
> > --- a/arch/s390/mm/init.c
> > +++ b/arch/s390/mm/init.c
> > @@ -65,12 +65,13 @@ static void __init setup_zero_pages(void)
> >   	unsigned int order;
> >   	struct page *page;
> >   	int i;
> > +	unsigned long total_pages = PHYS_PFN(memblock_phys_mem_size() - memblock_reserved_size());
> >   	/* Latest machines require a mapping granularity of 512KB */
> >   	order = 7;
> >   	/* Limit number of empty zero pages for small memory sizes */
> > -	while (order > 2 && (totalram_pages() >> 10) < (1UL << order))
> > +	while (order > 2 && (total_pages >> 10) < (1UL << order))
> >   		order--;
> >   	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> 
> I suspect that this is good enough as an approximation for that purpose.
> 
> Reviewed-by: David Hildenbrand <david@redhat.com>

Applied, thanks!
