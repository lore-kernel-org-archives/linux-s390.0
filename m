Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E55A399340;
	Mon, 12 Oct 2026 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791804137; cv=none; b=BZEXUO058wM4LIsXkmNd7Kk23N/EWdP6JOBtJ22SwTt2aam9fLheshaV7tjNOnoXz8FE1KfAa61/FlqtLAmwcavTiMLvdJVTrMKAaplmLyR/14eyi12CGtL2i9uAFT3wGxubzAvGgs+2mb0SUi2d3JoaQx1KdnR7HQZ8LJb2puY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791804137; c=relaxed/simple;
	bh=lltc1o7asuAcrbAf2jbPJjjipQgf3qsmfBLJkrpOB6E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MAl31bofhOBqX2ZaFjQYUQo4Yo0mRwG9/DenKUnZXRbPxU+k7Q/8JHe4rEkh94X5yZmZTfB3N7+4ifTk2KeGp5fA88vxCEnDePk3aYGUiA3KFa8lGtrKPiYJHu429/EjKSLbWmoy6qXqdudHnbVgCC1SwVKvB5c/oLhHzapmK2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=k6XDOCHM; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="k6XDOCHM"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8iQZ32750296;
	Mon, 12 Oct 2026 11:22:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=3HtAqvolt9lyyaI653+m3UC3gEFEbx
	7t3R8Gr51q62o=; b=k6XDOCHM/MHfpw1NNIp/GoOgrdR/fqszoKSQgOm4XhvBrF
	yfy60LmOpLbUZT13PVvtwQjJEdarKVfBL7DshflIdsYRnXsQ9S6CQY+L4uwMB4T7
	MwNYXQBpDKuvOFi+KMtzmGngwHEGXj5k247mV9BlVc0bNwgLMH+CQ/VeyACiW59e
	eQAl+M8f/8bKo5VtVnB7uA3cBZaVCnE6tuJ3yVg9n3Q74bpKpRC4nm4bJ9tk0yi4
	3w1gsmfDrS/JC+jEbgSn10yzl3dQIk0cV3gjnDiNQSoDx427onqzTEsBfw8uzCip
	f0kZjVWT2u2cEePVykrRtgm+VAGNUvT6bpVtZ3Lg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv088df-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:22:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69C8JxVX964540;
	Mon, 12 Oct 2026 11:22:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h7yppn1jp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 12 Oct 2026 11:22:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69CBMACi47579638
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 12 Oct 2026 11:22:10 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 20F0120043;
	Mon, 12 Oct 2026 11:22:10 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A2EBB20040;
	Mon, 12 Oct 2026 11:22:09 +0000 (GMT)
Received: from osiris (unknown [9.111.15.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 12 Oct 2026 11:22:09 +0000 (GMT)
Date: Mon, 12 Oct 2026 13:22:08 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Tobias Schumacher <ts@linux.ibm.com>
Cc: Niklas Schnelle <schnelle@linux.ibm.com>,
        Gerd Bayer <gbayer@linux.ibm.com>,
        Julian Ruess <julianr@linux.ibm.com>, Farhan Ali <alifm@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/8] s390/pci: Fix bugs in IRQ domain migration and
 resource cleanup
Message-ID: <20261012112208.19350A7f-hca@linux.ibm.com>
References: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261009-s390_irq_domain_fixes-v3-0-ced19028da3c@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX3iEgVdr+0AKa
 QcrmYB36HJCO+rK4JGn2ciYN3HpTieO4zDogBMMoJ/v3btWFA8gGhU3lR1riLmRm/HRokO3/j74
 xxKgnxzufqXC1TedOqHGbz5uY0LECGKXQmn8tUJpwt+gyswxKoBAhjZUUd7Kq4lu75/lPpL2rEN
 PMDp0/7ZLpitFo0u82BNxagGyZPS5sDTzjR1X77SUH7IJ1+sIQKCrenXGol3reslO91WsvDtQpB
 BbVbOx88y3DnBKgVooxvKRrMgWKYsLoTvTxTYacYCrWAo4DembR8nwC5+3llwlJ+C97z1NiEDqB
 AagzZpBjdpZ0/oosJLGEzwkIoZ+ptuqZSrvqNBWqipd2IV3tdivmN4kyeTi/xwF2H+Ao8FqlULi
 mekwoUU+KVuGLGMJd6jb6iUvsKDyfLLtofmJuo+1gebSmN6IVlt3nd2IfnSeTA4dtGePaH2onrT
 cv0La8bD+B5WsatXzTQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDA0NCBTYWx0ZWRfX+l56ymEVp5UZ
 /RSzX3G4AtPwtfmVaPCV8L36P7d8vw4ThvOJK39tPcYEA+AJNOv0NEhipV0XKkKOj9EF6okrrml
 vGTs5EE/Y9SVYRLubEtyCHmHchT94dM=
X-Proofpoint-ORIG-GUID: UGj5vJMwYu9Cyo61mr7RUM5-lnIFS_No
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6accc2e6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=rmZw6vwOPg5BNLf9a1wA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: UGj5vJMwYu9Cyo61mr7RUM5-lnIFS_No
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610120044

On Fri, Oct 09, 2026 at 08:15:47AM +0200, Tobias Schumacher wrote:
> Commit f770950a4709 ("s390/pci: Migrate s390 IRQ logic to IRQ
> domain API") introduced several bugs in error handling and cleanup
> paths. This series fixes these issues:
...
> Tobias Schumacher (8):
>       s390/pci: Fix double-free and NULL deref in zpci MSI domain cleanup
>       s390/pci: Fix resource leak in zpci MSI setup
>       s390/pci: Fix MSI directed-mode teardown IRQ bit count
>       s390/pci: Fix use-after-free race in zpci floating interrupt cleanup
>       s390/pci: Add error cleanup in zpci_directed_irq_init()
>       s390/pci: Set MSI_FLAG_NO_AFFINITY at IRQ init time
>       s390/pci: Drop the unused index argument of zpci_msi_clear_airq()
>       s390/pci: Unregister the adapter interrupt first in zpci_irq_exit()
> 
>  arch/s390/pci/pci_irq.c | 109 +++++++++++++++++++++++++++++-------------------
>  1 file changed, 67 insertions(+), 42 deletions(-)

Series applied. Thanks!
