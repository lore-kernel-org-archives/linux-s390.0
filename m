Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217CD1E04BD;
	Mon, 31 Mar 2025 10:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743418735; cv=none; b=jzeYUrufkA9I0pE3XlDJiUd8Izhqu6dCYXVo7Fjym8C8mIkqecH0bOrvVbDB5yGJ9DXURjw4AwJtdgGGK3AdXXg0EjAGSalm/pkFve0IXPJ0XOJVTFktKbwxOquKNtihFF22usGo9QQwHe2Qsqg5/1bCsQljqUur78B/sC73khQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743418735; c=relaxed/simple;
	bh=EdbgafNxYGu/0XTf7zfAz1bXaEoSlO/vk/i5SU4szcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XOlEoxSC1yL0IjSNIbKs3D/COmPLqQ52475a8SPgHOghFnOvTXV9pJ2KCVdvoq0C87ecUWV7sHlmgO2X1f9v+3kfSNHA0bcNxAmFaoLTQogVLK25lKUfgFPEGV0TSQkW9vN2yKq1vPj7zYj5IRjzTSWvZeSgTMQGjw+cE075vTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Gg7dC1iF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Gg7dC1iF"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52V4VTeq030864;
	Mon, 31 Mar 2025 10:58:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=1xzsUz
	kznSz9Dr4e9xWfh0mKDxu6S+leuxvVC4YqcUY=; b=Gg7dC1iFI1bQpIB6cNFE2s
	NQ+0wjFaUyb7435368UrRiMcSJjaxrTuR6POKTH2qUdf9uYe63FhpKLGuPHQfvwp
	qmh7JkcUvCulBfAcINMKuZTYDwtxhl8J1jn2PANt4PEAIL76EnmS8xoqM+T9Efpl
	WbTruD7YcOBDnu8Ze4KsR1STNLx+04YhKtrNNPnrSx8eYqpcoYikl5XSAG1ifg/6
	6Ca0gNx+B9y5pM+tlsZTYjNobUdeP7UHAoFBkNxWw2g1jnXds0CK4lhk64KHtVE6
	3uQYJTUvfV0sRLWvG1JKKkbVUiqk/ftddBefKN/Lm9rxseWSVDLDAEDHm5zcQT2Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45q602kyny-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:58:47 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52V8uw38005213;
	Mon, 31 Mar 2025 10:58:46 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pujynmd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 10:58:46 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VAwgWD19202414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 10:58:42 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 59FBA2004B;
	Mon, 31 Mar 2025 10:58:42 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1527E20040;
	Mon, 31 Mar 2025 10:58:41 +0000 (GMT)
Received: from localhost (unknown [9.171.66.204])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 10:58:41 +0000 (GMT)
Date: Mon, 31 Mar 2025 12:58:39 +0200
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
Message-ID: <your-ad-here.call-01743418719-ext-6354@work.hours>
References: <20250312-fix_dma_map_alloc-v2-1-530108d9de21@linux.ibm.com>
 <c6bcb10536005fd36966a97574e424c17cde1105.camel@linux.ibm.com>
 <your-ad-here.call-01743087110-ext-9280@work.hours>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <your-ad-here.call-01743087110-ext-9280@work.hours>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ru52HP92MBdeCfXZqx7EbOK2m9jmqgDq
X-Proofpoint-ORIG-GUID: Ru52HP92MBdeCfXZqx7EbOK2m9jmqgDq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 suspectscore=0 mlxlogscore=999 priorityscore=1501
 adultscore=0 bulkscore=0 lowpriorityscore=0 clxscore=1015 spamscore=0
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310078

On Thu, Mar 27, 2025 at 03:51:50PM +0100, Vasily Gorbik wrote:
> On Thu, Mar 27, 2025 at 10:45:40AM +0100, Niklas Schnelle wrote:
> > On Wed, 2025-03-12 at 11:32 +0100, Niklas Schnelle wrote:
> > > The fixed commit sets up dev.dma_range_map but missed that this is
> > > supposed to be an array of struct bus_dma_region with a sentinel element
> > > with the size field set to 0 at the end. This would lead to overruns in
> > > e.g. dma_range_map_min(). It could also result in wrong translations
> > > instead of DMA_MAPPING_ERROR in translate_phys_to_dma() if the paddr
> > > were to not fit in the aperture. Fix this by using the
> > > dma_direct_set_offset() helper which creates a sentinel for us.
> > > 
> > > Fixes: d236843a6964 ("s390/pci: store DMA offset in bus_dma_region")
> > > Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
> > > Signed-off-by: Niklas Schnelle <schnelle@linux.ibm.com>
> > > ---
> > > Note: Based on iommu/next
> > > 
> > > v1 -> v2:
> > > - Fixed typo, added trailers
> > > - Link to v1: https://lore.kernel.org/r/20250306-fix_dma_map_alloc-v1-1-b4fa44304eac@linux.ibm.com
> > > ---
> > >  arch/s390/pci/pci_bus.c | 24 +++++++++++-------------
> > >  1 file changed, 11 insertions(+), 13 deletions(-)
> > > 
> > 
> > With the IOMMU pull request for Linux v6.15 the fixed commit is now in
> > Linus tree (with the SHA as cited) but this fix isn't. Since this fix
> > only touches s390 specific code I think it could go through the s390
> > tree but that currently doesn't carry the fixed commit so would have to
> > wait until the s390 tree pulls in v6.15-rc1. 
> > 
> > I don't think any breakage from the missing sentinel is visible outside
> > of guests using the new IOMMU passthrough mode so I guess waiting until
> > after v6.15-rc1 would be okay.
> > 
> > Heiko, Vasily, Alexander what do you think?
> 
> Sure, I'll pick it up in the s390 tree for rc1 or rc2, depending on
> whether there will be a second s390 tree pull request during the merge
> window.

Applied, thank you!
