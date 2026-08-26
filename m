Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 693B03E5ED7
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785548; cv=none; b=E+ZF2EKD3/4F8b7IKYNUONIV73KtekrPUstuTagXNgHM/SY8V764xoFfH2OIZb8l+haLTKGUIdPifgqqMEHCvQj6MYjZm77c0n3W/asxm6Vi7Q8czIAJpUw2eSplh4K2UYJsmJPx3VPuTstzcCr3I1GPmw14JnMXN75Vn6o6cvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785548; c=relaxed/simple;
	bh=i0rlP8i4UVcZLy9M8VHprwBGD1lx6c2CGLMC7UgD16k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HFUR4Q+WyiSkqnI/eR4N2V6MQclpiLLoXdxEydYGzsQFfXWnwC7wZ7mS6XmSu6ltE2Bms9GOZx7tvKI7XQET0lhB3aMR7sxgTywYlnU1rhYzrwR1RC/vt+ZiCTWW99tbp9OHdXxPTIqZS5aCrCoClapKNCrzxoMwFusaEm7Ooc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dvaXs1AY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dvaXs1AY"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1ZOM1020093
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=w7h1fsZziWSexdGmlj30w+j0CAkPii
	8v3gph939/4ks=; b=dvaXs1AYQ/be7X/i9RrRaTg6fm6Vflis80TGNxwD+vUSYX
	zfMrovdoND5tzDqicOOhExPc2f9cgVOtTbTR93vupsKE7blOojnr5JhZG5pOCxPt
	PBrzbGxAzOqrY6v7Wb0Vp0rDg1CZ+7UlPmy7Y382iBlqYjYu073WeDF5UBwS55oL
	2qE4uMG/mjShl3rJpAU4ynLd4JPosZLBZ5XsTBrcLjOSQZad01ycffYJTh4DpzDz
	mYxkK1Piv1yfaRdHJcGyEu9GSwQdHbvJwY6Us8JKiYDUJ7j7BqgOZAQAFPyE6zST
	V7lZlQApRz9ydmKpRmA9X6TmD09OBXZdE/rZ2MeQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73dxhbn6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QMuP20002733
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g7rsyccpn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:40 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QN5aYm44630284
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 23:05:36 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFBBF2004B;
	Wed, 26 Aug 2026 23:05:36 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7536A20040;
	Wed, 26 Aug 2026 23:05:36 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 23:05:36 +0000 (GMT)
Date: Thu, 27 Aug 2026 01:05:35 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Mete Durlu <meted@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/topology: Switch to common cpu capacity code
Message-ID: <ttkeg5b@ub.hpns>
References: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825-common_capacity-v1-1-1cdfa3ad5e14@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX/7RmIfk5rGCK
 ujrKEKlvELqfD3TwnolHruXeBjmhApBUIv0Hs7O9XT7Hr24Ye3tiXK4XCLG3zwHXjjkhHlzcmtk
 vao81FUrLKcacL907s+DwTCVnRD3gnU=
X-Authority-Analysis: v=2.4 cv=AYuB2XXG c=1 sm=1 tr=0 ts=6a8f7145 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=Puiun7Du49nS_SMLvowA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: foa9JqmBBaZFgZK6hy2nlh5VowzTBZin
X-Proofpoint-GUID: foa9JqmBBaZFgZK6hy2nlh5VowzTBZin
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX3SXqJz2z1MIh
 XvC7+uzl1ofW/iD2WEhgNGPo6Mspg1/o6bqBTHker+C4enfwK+7q4mJ6QvUab94qLlYn9WYgXxg
 OAVnVYmYrPSL8K22GpIsZvUaqI4nAvNmvde77SOq1Ssl7dAB+MEHDBQ0nzPqBVQQ8v9bDnTubQT
 YKSY8/rEmEvbEopOhbERdQXB+/ZQezRtN7etMmHPaAZPDEJtERgoFLeCXB7Tl5eoEeHCQ70z2TS
 0eYKyP/GdZrSVBnR2FGsGW13jk/gVrQWUk1UyS4O889Ni7jTuA0XOIZpHP7BQR3vS7Y8ibaUic4
 rTHjrtTfWTk2uvsDa0lUB/DrmtsMEac6lbjSdBcr13MHb6HCcb1zdQFtExE09/+LAMab8+iPs5x
 Lb8kYWFENwOkupyyg44kqhRhQ4ZjDUWVrFu8Def3LCcacXhlZWqpBlST6J4uMqZxL4lmcO4Rd7a
 y8XISd7vox2O87pJTbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 clxscore=1015 adultscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260194

On Tue, Aug 25, 2026 at 02:58:20PM +0200, Mete Durlu wrote:
> s390 implementation of cpu capacity management infrastructure code does
> not do anything different than its common code counterpart. Switch to
> common code functions and remove the smp_cpu_*_capacity() functions.
> Make s390 code better align with other architectures which utilize
> cpu_capacity. No functional changes.
> 
> Allow cpu_capacity attributes inside sysfs to accurately reflect cpu
> capacity.
> ex:
> 
> $ cat /sys/devices/system/cpu/cpu0/polarization
> vertical:high
> $ cat /sys/devices/system/cpu/cpu0/cpu_capacity
> 1024
> 
> $ cat /sys/devices/system/cpu/cpu40/polarization
> vertical:low
> $ cat /sys/devices/system/cpu/cpu40/cpu_capacity
> 128
> 
> Prior to commit 6bceea7a1e07 ("arch_topology: Relocate cpu_scale to
> topology.[h|c]") cpu_capacity attribute was only available to the common
> arch_topology driver's users. Reflect the correct values to the newly
> made available attributes.
> 
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>
> ---
>  arch/s390/include/asm/processor.h |  1 -
>  arch/s390/include/asm/smp.h       |  4 +---
>  arch/s390/kernel/smp.c            | 16 +++-------------
>  arch/s390/kernel/topology.c       |  2 +-
>  4 files changed, 5 insertions(+), 18 deletions(-)

Applied, thank you!
