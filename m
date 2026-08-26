Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E4E63C09F9
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787785529; cv=none; b=G4H8gF6NNyqFQS8QQmiUFL80mVCWlVxdro/WDYW9YmfleWHv3b5y7dITVo82/VtSJPqpP0rNeaFUDeWLkdkTf2F19W+9R5M9zyt1OuRA8XrHrRMAqrTkLhNQQsFKghAbLx3Suk2ChbLoWSFoRdwYvOsQHgJHXZDsslVdF5pgrjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787785529; c=relaxed/simple;
	bh=RjaF1MxXp9IEP55/AP9zOjlI0R+pjnFlxVLUW/qCEx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qD0f5hx4LYhSLDwjd4IFSIzT2CHRUMpAhtnGLhC1lk0MMZty4L5fppDUQY5/huTv6SKoIbkdEHfyV6PcBXticyLdbifKPz8nXhuSnSVKeRpB4LW5EZuj/uQdP1mThAjyXG0O6bmzldqDYWfdLduZF/jopHkze06CaYCmJE1+bto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fr9i9Ylm; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fr9i9Ylm"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67QL1fFW853124
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=HlJ3+waTAgJh3EVHJ86JwBI0QHCAOH
	Ff0bqkZf0C8pw=; b=Fr9i9YlmhbQfXu0Xo+uKcd+M6bnjOXwTaI4cIepvcvY4US
	p0vZx5jXahjJmDKJLThR2s+ZpkyAhlOSXmTHqANEYd1MK0kevov3CjPu+dRaTVYb
	TJHry7VAbt6eTiB90NpbjfBQCRKMqwdtQHHmqnD2ZUensoRHx1ptr5coKGjFHH1Z
	VXPByzJXIYDeDNTo/zRCrtb5wCT9xy7V4KgYr/k5kIftSxofv1DMepHGpf4SsWBi
	KrbviC+E52OMg4G2Fpv3h/wlLr1QmS+JPNWZ56ANDywtxuXREPTFJM43cOOdaJcj
	uLDX7eGgD3p+cSHCEp4bM1K1Yjwzt+dgOpnYfWKw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g716j1rxq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:18 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QMuLAQ017298
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:17 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7qkhck94-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Wed, 26 Aug 2026 23:05:17 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67QN5Dj437421494
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Aug 2026 23:05:13 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B06620043;
	Wed, 26 Aug 2026 23:05:13 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 01FF720040;
	Wed, 26 Aug 2026 23:05:13 +0000 (GMT)
Received: from localhost (unknown [9.111.46.147])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 26 Aug 2026 23:05:12 +0000 (GMT)
Date: Thu, 27 Aug 2026 01:05:11 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Thomas Richter <tmricht@linux.ibm.com>, Jan Polensky <japo@linux.ibm.com>,
        Sumanth Korikkar <sumanthk@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/pai: Reduce excessive debug feature size
Message-ID: <ttkeg4n@ub.hpns>
References: <20260825094925.1791807-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260825094925.1791807-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX1ZtxAQIbiTR3
 LrddhciPkG2q6Yie/adoY/jx56h7hxGMX7KUTHCK/t5K+EecdW3UhD+qcUbGlaTvIH2iA6edr3G
 aTZsIHQDrQ4EDLa6+zGrtZE/NL133kE=
X-Proofpoint-GUID: -wf2OfkN1zdjzsXOWciH35-pYgzvplIY
X-Proofpoint-ORIG-GUID: -wf2OfkN1zdjzsXOWciH35-pYgzvplIY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE5NCBTYWx0ZWRfX8kovS2wikaJp
 H1IYKk807m0BowqFaU12ALIRIH3IVJIayrpQDvm1hF3yMd+frFX3KqZv6Z/wesmrGISFazL1pkW
 U8NFj893JTMY3Dm/y7E80H0vUaBWgUXmDgRI/oCXGedJ0r/fb662URG5nGGUsxHfGQdqU68IcWQ
 mL9b1qIfFFFN8eAKtcIGxhQ92wlerbfbEJGjVY7f3lWFzmKDd09iyzNER2Eb4xXMpVTM/vWK63z
 z9nUqess792L49z1fgJuZwMzdxGOH+VGaSvFdRQboxq3HiiFaY2kB22hQzTh4MkSEImrgAoXSsJ
 EztG/pnls+TrbNTYILjwU1fLDDr03yRBeA11aHtcwBj63Mbv6XnimukT6pZE0GbEReewURbDqhZ
 wwiOuUZsgXYWB0ubWsflbJxoviSfRwCX/R2WZOcsBm3Lbuw5W4KoRqZChQbyOh6VSNcYSRrkg4u
 fMoehb+XvPTSXW+MV4Q==
X-Authority-Analysis: v=2.4 cv=H7brBeYi c=1 sm=1 tr=0 ts=6a8f712e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=kDPx03Ww-hrN-jpW9KgA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 bulkscore=0 adultscore=0 priorityscore=1501 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260194

On Tue, Aug 25, 2026 at 11:49:25AM +0200, Heiko Carstens wrote:
> The pai debug feature is registered with 256 areas, where each area
> contains 32 pages. This sums up to a total of 32MiB. The code does not use
> any debug exceptions, which means that 255 of those areas are never
> used. In addition all existing debug feature calls have a lower level (5)
> than the default level (3).
> 
> This in turn means that without user interaction the debug feature is
> unused.
> 
> Reduce the number of areas to 1, and also reduce the number of pages for
> the remaining area to 1. Since user interaction is required, the user can
> also increase the size of the remaining area, instead of wasting memory by
> default.
> 
> This reduces the total size of the debug feature to 4KiB.
> 
> Fixes: a3f8423622ef ("s390/pai_crypto: Add PAI crypto characteristics table for parameters")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/kernel/perf_pai.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thank you!
