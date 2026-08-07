Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B571332614
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 10:49:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786099788; cv=none; b=ot7CHARh2YSeS3bIcXKfEz4lnRVGRoC+ZtTH90IPElMtfdGUtIt/URi14UmR8g4m8Li6wu76TAcIchRTrZ831PToFEseX1bHlhaS1wlf1JK/v2AjVTIVIdW2TG++MJ1uiozdph9XXR5Me+TJYCMOCBtIE++ZrVzU5o08PIzGwjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786099788; c=relaxed/simple;
	bh=dky0l3ejWkMkYegxGiDMvP0NOYB3ppq7bfk3Kt1Qz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pyKTfW+QQyLWliPzJo6xlO3xQ/25WzgoF/48ZGNMEXO5vN0wlQgl+hVIm+dXlZF8xs9doWLJ8Em9ZV46BaIAj1MVhPQIpKAEOEqXzrjaI+RphIZTQ1r0t36/D/u0kRpJ1YSgoSSKGht1Dznfvmp9W7iYrAH4ab8jzoeuDxVUWVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bBmENoGf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bBmENoGf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770IKKN4162231
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:49:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=WOPDFAmBpoESIXXa+B+j1L20JGQhqR
	MwvW+0F7pzB74=; b=bBmENoGfULM/Xvc6aLVVHeaQAvUCZD1eeB4R+gGUFODhfS
	Hh7I/Li0fVFlOdYxUejyES9GgVEd0g0SJIAGQbJOO6EIwQzHTcPUxdEeam0UW4ZC
	FOqigOLO55U+WNQIuUq67LYj6NVQpkXCcKKU6x0+wf0kpT7TUB2PeZ6v6yJf46Aa
	gxmphASu36QlkyBnzIaJkESZze4p2DnXPNOrJn8M+IOwdn1/Ne1zStYha8BwmMTx
	RhM4XYZyRPJaW5C5Ifbq8iWSnPIMCmL69qXHiFU+byWlUBcKv6p21kORyyD0tQ2J
	Z1xK38+N1cDfj233vVxte9krRLa+wV0dk5XSwj0Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvxyyug2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:49:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 677AQGR3007772
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 10:49:45 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhq94r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 10:49:44 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 677AneRO50135418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 10:49:40 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3B5320040;
	Fri,  7 Aug 2026 10:49:40 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 83E3D2004D;
	Fri,  7 Aug 2026 10:49:40 +0000 (GMT)
Received: from osiris (unknown [9.87.138.170])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  7 Aug 2026 10:49:40 +0000 (GMT)
Date: Fri, 7 Aug 2026 12:49:39 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        linux-s390@vger.kernel.org
Subject: Re: [PATCH 0/2] s390/char: Enable CONTEXT_ANALYSIS
Message-ID: <20260807104939.17243Bb2-hca@linux.ibm.com>
References: <20260806155303.2675932-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260806155303.2675932-1-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=SYrHsPRu c=1 sm=1 tr=0 ts=6a75b84a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=Msg9EcKYynwj2SRv6Z4A:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX5Lje86GarT/9
 KH/P1RP8qFDPsnr2iaGw9l2IiMq3qkca2ViTIBigkZfDZcnAFabOCeVU/+E+xExgnD6w0XCmFau
 3EVuacK1jsFckspDANY70pYRK5hwXaU=
X-Proofpoint-ORIG-GUID: ZvZUDq7fSJQFdGw47h399orV8nrZs80E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA4MyBTYWx0ZWRfX3OYkA4HJ+h8h
 mHiEuUBgeDATDdI2iz59LBgVHLy/zEoQGlGwh0zR2ZA8/MpqRYTN2qWbAdbQdxU5yTbmJGA5zlf
 er+It0dRO48yuCWyDEXJoAh+YGaXT8hcI5h8z72zuZquvg0SsqCY2asGYtRvKg0QyfwX6Ea8rzg
 dbXZvep2uVMjmlt6Q8S/1jnFgSSWZ8jtfviTdWlDQzw9Sa65KmTzr1D61axb4q64g1yY5oledXz
 bhw99GBltq56pgxGPoaxRJPHDAXFBCyBqKFRgP8M1KwwdYATDW9vOrWlpC3yOSfthb86G5YY2QP
 Mvs45Lv+THnR4vLYqYfRRYWaLcd8cER6GvqVyJJ1uAelIwNMvaAG584vZYUVwjPL3GxhCN5PO7F
 1LUXLjMhok9d2fusXUVlC20bt9lUMNJFSyNlJ96nMfz7M5Id61P0YyjLngiakH+Icgjlw/lxyyZ
 iGr+rtAI5pk8wcRPj2g==
X-Proofpoint-GUID: ZvZUDq7fSJQFdGw47h399orV8nrZs80E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608070083

On Thu, Aug 06, 2026 at 05:53:01PM +0200, Heiko Carstens wrote:
> Enable CONTEXT_ANALYSYS for s390/char drivers.
...
> Heiko Carstens (2):
>   s390/con3215: Add __must_hold() attribute to raw3215_make_room()
>   s390/char: Enable CONTEXT_ANALYSIS
> 
>  drivers/s390/char/Makefile  | 2 ++
>  drivers/s390/char/con3215.c | 1 +
>  2 files changed, 3 insertions(+)

Applied.
