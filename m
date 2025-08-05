Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632382750E3
	for <linux-s390@vger.kernel.org>; Tue,  5 Aug 2025 14:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754402476; cv=none; b=RF1G8IbOULHwZaQ2Ek2iTta5HzNwjjA4/Mk2EUNQwyydNcfDKBQVuUSk0gyGd/a+VpD5K+d+h8LJqvc1t3oFf+G3BAyQYrKO92miMjywjXinAlKGRXKthPWUGBp110nQpCTUqZYRhMbwUhsjM6pgmft1aWUT776r1LSgVyojerY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754402476; c=relaxed/simple;
	bh=9fjJanLrM99RKdit/gHahNwbivJpqWPAykC6qx5ZxTM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EZELTwhh/gxNHQf6e9uCzRfXuJEKju1WGPsBZmtLusV8KVKLwwlwaly3ZP28mkL1Wb7VfFj4qw2jxU9rMA0jpYc4lMxP51LXsyPx3QMJaKyi4URHoPzIa407uFZPTG6uLB9WDucZFw4QDccGIvNwsUsk/JhTXnVrn4+m5HVbLyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ChzTXRPD; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ChzTXRPD"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5757XLT1010762;
	Tue, 5 Aug 2025 14:01:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=aS+u4axyEFkFgYG9SQ84xB75qxO/xV
	hKP18028E9+6o=; b=ChzTXRPD0d6Uk+lf4s1g8LhC6q33su0aF3e3pxLMeyhlfX
	RPIFsSXqfnqtdMaLSj2H+PTbKx/cnZmABVDhSWwp8Mknk1b678L+vhB4vI5ZiMzz
	jbPzeaLp1m8FO8EWQJwnVuHlkwHfKUTWhzkh+LNbQVR9hevCmTDKTDuztbJYf6Bp
	st4Pqoy8XhT4H3TVxVfPnkc7gcP3CBwmUwOKWtfwimjf0kRoka6w/gAXi5v43TOO
	TJ5qr9lFDwEt79cloFjf8izxQ5fbNLRAxsOJhcNWxj6Frua1FGLpLR61r3Plj1NU
	5IdTNnp0/549uTnb4WgDLca6oJ52eXvi7tFrSOoQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 489ac0xt7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:01:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 575AYAql004450;
	Tue, 5 Aug 2025 14:01:06 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 489yq2jdty-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Aug 2025 14:01:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 575E13Eq52691380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 5 Aug 2025 14:01:03 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 298532005A;
	Tue,  5 Aug 2025 14:01:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E94942004D;
	Tue,  5 Aug 2025 14:01:02 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  5 Aug 2025 14:01:02 +0000 (GMT)
Date: Tue, 5 Aug 2025 16:01:01 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
Cc: linux-s390@vger.kernel.org, gor@linux.ibm.com, hca@linux.ibm.com
Subject: Re: [PATCH] debug: fix typo in debug_sprintf_format_fn function
 comment
Message-ID: <8d636303-d98e-408d-8b9d-86cd0ce5c508-agordeev@linux.ibm.com>
References: <20250804093321.434674-1-tigran.mkrtchyan@desy.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250804093321.434674-1-tigran.mkrtchyan@desy.de>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: oRIaNBcDcEVhe6Fjik7JtwzdRbyE-FBx
X-Proofpoint-ORIG-GUID: oRIaNBcDcEVhe6Fjik7JtwzdRbyE-FBx
X-Authority-Analysis: v=2.4 cv=GNoIEvNK c=1 sm=1 tr=0 ts=68920ea4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=2OwXVqhp2XgA:10 a=hv2mxPgWdOaPnmPoOS8A:9
 a=CjuIK1q_8ugA:10 a=Lz_-k8IuIvwA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODA1MDEwMSBTYWx0ZWRfXxEoj2OZeCK8r
 prV1wyMXphOCyViR8E6+FNw5AiFSs9Z4GFF+vQGTCY3cjh3rqnvKhofQO+nNCOW8ZTSMV4ktiEF
 8kXkMegjMTvJ3PQl9Z8dlRNhaCDfK4XkJGETikvSQdZwNQlRTYvJbnv+rKwEXBjy6/JJAxqMgVH
 DEI53Y/5cgDo+Yecs1ebD96NNT1JCoWZtMzl0Npy5+BU/Ad0B2Ev904ZzJKZktEJdCdxwdtkhir
 WcWJ25xsgSVYYtBiomSrWKQ46TpjVApma6BcFJ5NvZ187hdD+9Xc2qZLaM2JY2ZqmMA9YBEioZI
 OkidU0lThP28LSvD9lRAC/uQzk74wz88cL2SuoDwBD6ZNu6t6WHdJ8uTNDvayVK99HlkQ9IlbjA
 BylPb3QD3PzwmKulxJRmN8fmfi0Lud0Az/+Dqv8a2exkMSUdvw1t9QpNZ69b4TPRveq+BMBv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-05_03,2025-08-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0
 mlxlogscore=517 impostorscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 clxscore=1011 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2508050101

On Mon, Aug 04, 2025 at 11:33:21AM +0200, Tigran Mkrtchyan wrote:
> Signed-off-by: Tigran Mkrtchyan <tigran.mkrtchyan@desy.de>
> ---
>  arch/s390/kernel/debug.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks!
