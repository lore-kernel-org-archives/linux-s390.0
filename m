Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537163D8100;
	Tue, 13 Oct 2026 09:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791884051; cv=none; b=M/kQGns9NSLrRRqi3XOPtpNBiIG6WTWXBvPlTnkBFr8TR2NfgcLNr/CRaq8nioxXPdLzK3dREDKiWvA9NPAFdxWRMlUx6+EbKWL6UPqcdHNLt2UuEzSxYqB9DRgEBQAmMLULq8/V03N8SYN3UXLM2fZiHhYEISifiuyjUdz6wOs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791884051; c=relaxed/simple;
	bh=6ZKGxAb0Vnr7qs1xZDZDeWQAwTJ7MDOpOqkpsjJ4gKA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ni8hb8FOO4vo21rdETZKRoLEsWdlEp/VM4Na+ZWPayD+ufPtOD146/wtibrxV2mKJxXA3ZKorh+A/U3PWox9aLy1K0ntLlZwJrv7iF4FMAoFfh7BVTmJVG9sgMT4QKI0LTYw3QsQvj8L1CqAHV7PHAaamqQdNS9Ggc5vVkHL8Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hYfnUwEb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hYfnUwEb"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EUWC725945;
	Tue, 13 Oct 2026 09:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XyXu/2RpH5p+BQXnwWDaDsAJjOVoJ2
	19Tn/h1dA8EYI=; b=hYfnUwEbWXw4+9ECgL78e2GSrBUQRD6llmGLzjcfsOhgOE
	l+z2KNeBAG6fR9bGlsH607Dvy8r0cb/qhDmDAc1yEJiqIYmNsmCL3XOQ3VJeSKyE
	9l/iLdrtHoNrhoCJeHvSyvf3Mk8Mr5lPq/ZpkmXzs3yvMlhz5h7b2CNz7MG821ji
	q86cu0nug4PmEGdMoB1q6GglPAygOfoth6BZlYxkcILcnph1OXduIu3gL/b2o9EO
	UO52r3BgPI8AHD2aYfYK3CZZXBAkjSA3qsk7laBRDiGmJH9yklyvDuyOigQnnH4Z
	lbk3nBgifOC0klvIXN7JEL4n2NlkSA9MVtb+J0dQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0csvr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:34:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69D8Tri72667556;
	Tue, 13 Oct 2026 09:34:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h802vs6ru-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 09:34:02 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69D9XwSk52953500
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 09:33:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5964A2004D;
	Tue, 13 Oct 2026 09:33:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B730020040;
	Tue, 13 Oct 2026 09:33:57 +0000 (GMT)
Received: from osiris (unknown [9.111.34.214])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 13 Oct 2026 09:33:57 +0000 (GMT)
Date: Tue, 13 Oct 2026 11:33:56 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Gerd Bayer <gbayer@linux.ibm.com>
Cc: Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
        "Joerg Roedel (AMD)" <joro@8bytes.org>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Benjamin Block <bblock@linux.ibm.com>,
        Ramesh Errabolu <ramesh@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Farhan Ali <alifm@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH v2 0/3] s390/pci: Updates to PCI insn tracing
Message-ID: <20261013093356.9443B48-hca@linux.ibm.com>
References: <20261012-rpcit_trcfh_upstream-v2-0-1812db73dfa5@linux.ibm.com>
 <20261012160049.19350J7a-hca@linux.ibm.com>
 <126474a4cf510aacd256dca642eb013f7e10dda1.camel@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <126474a4cf510aacd256dca642eb013f7e10dda1.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX/qvKHyi8aK7n
 z5FohrKWghYOJ7B0pDC1yhs8b+fiSwizUKJAZKdXmW9OX+zSffp2VN6D/HD6/itvE7MgOULWG2H
 zs70A3mm9A3sBKH8x6MRcyD2PIUdNPddM96tWKlqqNvln8JIabAYwAwFpJMRrX1WOSQsKTKAMLM
 lkZQDmQzAT80y9XH7tLVKZVy/C0mU4/tpMzQ48FVBTn+yfN3jJsdRF1J23kNdG75tQLrKnm4bNY
 6gZ9ctwhf1Lr+9ihDweAfGdf+j2NPm2UPVin9rwr4TSTaBYVkHNwoB39iEZmS6sqKNxaL/eY7pE
 lyjHkJASoNjiyUbyIiI1zaf+cxm6nos9CbuXaocL2Dxl9c8k3bGWPccArp0PgGryAOIh02Oc0Bu
 6VWOJWVcLDHR70b3K9HXqCtaHGmLTpVWrFx2BwAsDacPLYOyUZeght1e/W5UXSUmS1k4ecftnjA
 IkE8dlx2VonXZTjvv1A==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDAzNiBTYWx0ZWRfX0AmkRWNUowpK
 2Dt8iptAOO9Xut0Y/dxCj5LjxS61EvD/dUysNaCu8JWeIA4vPQS1rGAuCPRBSp0Af3JH9sTmK9a
 z4JZmThrzRsq0a8wSr6dmdiGS7L7e5A=
X-Proofpoint-ORIG-GUID: AQMMFFkaki-gBl9BIkrar06WyPTdKGZJ
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6acdfb0a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=9DNx3T0ovit8ovVIW74A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: AQMMFFkaki-gBl9BIkrar06WyPTdKGZJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130036

On Mon, Oct 12, 2026 at 06:10:55PM +0200, Gerd Bayer wrote:
> On Mon, 2026-10-12 at 18:00 +0200, Heiko Carstens wrote:
> > On Mon, Oct 12, 2026 at 04:21:48PM +0200, Gerd Bayer wrote:
> > > Gerd Bayer (3):
> > >       s390/pci: Adjust alignment in insn trace
> > >       s390/pci: Use 32-bit fh outside of inline asm
> > >       s390/pci: Add function handle to RPCIT insn trace
> > > 
> > >  arch/s390/include/asm/pci_insn.h |  2 +-
> > >  arch/s390/pci/pci_insn.c         | 42 +++++++++++++++++++++++++++++++++-------
> > >  drivers/iommu/s390-iommu.c       |  8 +++-----
> > >  3 files changed, 39 insertions(+), 13 deletions(-)
> > 
> > Even though this touches drivers/iommu/s390-iommu.c I assume this
> > should go upstream via s390. Is this correct?
> 
> that was my assumption, yes. I hope the iommu-maintainers agree, since
> patch 2 touches s390 internals, exclusively.

Ok, since the changes to s390-iommu.c are minimal/trivial I fixed up
the typo reported by Matthew and applied the series.

Thanks!
