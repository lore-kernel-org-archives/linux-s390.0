Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B1A217F36;
	Thu, 27 Mar 2025 14:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743087134; cv=none; b=pDmvzO9nZ75CI8xeAAPU/JMQvr8U5CZ4SQUicHZoL5Rrz0GOZ2Wka62V5zxN1IE1I7aOma1d89tVppAGP8ZaKqYii5FyxeT3Hb7N4+S31wlDJ0xwJUgaMVkjrnQVPQguvu16SmbQkW2+xif8gfCmWTtrjJa+f40NNb6rhAHsbZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743087134; c=relaxed/simple;
	bh=Bhr1KeHS8Z77l5QEy9EMMf1yW4NyU+HAeAvfNIiaQvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Wpjxavx2e+D9B/gcwG+Kg3yRtZTIIdypYfiEyRwIIcIYwS+Zopnnsd4gH/M5FjukwUwsRNUy4YSWZK3M4ceueVJm10xu0x8eNio2cUTE2Bt8BWxtGp2HaT4+mFK2q90JDGqCzFeA4wVvs+DhKUmE+lYmD6nBQ7qC3FmryQ77bNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=aGXof6Tw; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="aGXof6Tw"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52R5kbN3018437;
	Thu, 27 Mar 2025 14:51:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=YycBTB
	loCv3Pe+HLW4266HM2aMmLdKjY8qSwckPN1l8=; b=aGXof6TwnPmmaeKrc03m8B
	Ouq9G8h13K9yMwrwbT0psJBcT+zvYmB/rccERzO9NYJvoKOqPfoc+5oqlw71JIzp
	4tniGC7xCUvHWHAo3JYvrJMcbyA9JLGS9tid6BfD9kawSHTm0SzG1yA27CHW6zOJ
	16H6RLDWKAIPKkFiWTwA6fIx1d8NZkrVSgju0xADrLKoLK7UrDL1z6Oo/IYyZSlq
	mezyUuTKc85oJJpq/IXEggVkeSkYJzMxpegjjtj66J0JZVKMBQAdXoM2KPQbrC1M
	zsH/cgxEn5Eo6X9V+9ePe4ahSQU8yyXk6hfBG1FQxQQ0FSq0c3aIPJtrb/m+0EQQ
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45mnrwnj2f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:51:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52RCnl1Z009737;
	Thu, 27 Mar 2025 14:51:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45j9rkwk8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 27 Mar 2025 14:51:57 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52REpq7145154732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 27 Mar 2025 14:51:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 420D020043;
	Thu, 27 Mar 2025 14:51:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 15B4E20040;
	Thu, 27 Mar 2025 14:51:52 +0000 (GMT)
Received: from localhost (unknown [9.152.212.168])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 27 Mar 2025 14:51:52 +0000 (GMT)
Date: Thu, 27 Mar 2025 15:51:50 +0100
From: Vasily Gorbik <gor@linux.ibm.com>
To: Niklas Schnelle <schnelle@linux.ibm.com>
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Joerg Roedel <jroedel@suse.de>,
        Will Deacon <will@kernel.org>, Gerd Bayer <gbayer@linux.ibm.com>,
        Jason Gunthorpe <jgg@ziepe.ca>, Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: Re: [PATCH v2] s390/pci: Fix dev.dma_range_map missing sentinel
 element
Message-ID: <your-ad-here.call-01743087110-ext-9280@work.hours>
References: <20250312-fix_dma_map_alloc-v2-1-530108d9de21@linux.ibm.com>
 <c6bcb10536005fd36966a97574e424c17cde1105.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c6bcb10536005fd36966a97574e424c17cde1105.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 13KfAhoY4-2FwZoeKoHuTDNbFrC-h_Kq
X-Proofpoint-ORIG-GUID: 13KfAhoY4-2FwZoeKoHuTDNbFrC-h_Kq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-27_01,2025-03-26_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 clxscore=1011
 impostorscore=0 priorityscore=1501 malwarescore=0 spamscore=0 phishscore=0
 mlxlogscore=999 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503270099

On Thu, Mar 27, 2025 at 10:45:40AM +0100, Niklas Schnelle wrote:
> On Wed, 2025-03-12 at 11:32 +0100, Niklas Schnelle wrote:
> > The fixed commit sets up dev.dma_range_map but missed that this is
> > supposed to be an array of struct bus_dma_region with a sentinel element
> > with the size field set to 0 at the end. This would lead to overruns in
> > e.g. dma_range_map_min(). It could also result in wrong translations
> > instead of DMA_MAPPING_ERROR in translate_phys_to_dma() if the paddr
> > were to not fit in the aperture. Fix this by using the
> > dma_direct_set_offset() helper which creates a sentinel for us.
> > 
> > Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
> > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > ---
> > Note: Based on iommu/next
> > 
> > v1 -> v2:
> > - Fixed typo, added trailers
> > - Link to v1: https://lore.kernel.org/r/20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com
> > ---
> >  arch/s390/pci/pci_bus.c | 24 +++++++++++-------------
> >  1 file changed, 11 insertions(+), 13 deletions(-)
> > 
> 
> With the IOMMU pull request for Linux v6.15 the fixed commit is now in
> Linus tree (with the SHA as cited) but this fix isn't. Since this fix
> only touches s390 specific code I think it could go through the s390
> tree but that currently doesn't carry the fixed commit so would have to
> wait until the s390 tree pulls in v6.15-rc1. 
> 
> I don't think any breakage from the missing sentinel is visible outside
> of guests using the new IOMMU passthrough mode so I guess waiting until
> after v6.15-rc1 would be okay.
> 
> Heiko, Vasily, Alexander what do you think?

Sure, I'll pick it up in the s390 tree for rc1 or rc2, depending on
whether there will be a second s390 tree pull request during the merge
window.
