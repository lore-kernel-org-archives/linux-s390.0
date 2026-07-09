Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5537E3EC2FF
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 10:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783594189; cv=none; b=ZnwCL62m8Y0zdHCgQwPgcs4ywPZauZJMSw5dBYHIvKfJukXY7IfGwzK6RW/YJ0hBmrdn8lTZvV/U7mAgpFzZNer/kTnxL6vlECW3oJcBNs+4GElw57QceXsB0ovVwR5DKNkumDNbGWKHwxfna9ou29sqaNIGxR+TYoVioYngcbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783594189; c=relaxed/simple;
	bh=Qq7vdm4bx8lrE/HzDEL/WnMIgZW+hHT890xhF62sXAY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jgk1c0usYV+Vvo/2q+up47rujJNrwPOS0y9lO+ASsrMVGgWe/8EdXEWGqHnnWkwnSV56+FX+o7GIFvAfrOhxlwBAj/vepd/pxaLOOLm9b+SveUTetUOXKLhv11Y0gZSjvMFYry07qnddWe5e1y4wOer450ShS1Mh72yO1FVLjwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NBXB6g5M; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NBXB6g5M"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669AmN0W1957081
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 10:49:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XFGIsUzHImFHqGM9AtbemH5gjV68F+
	R7IhkPo3LroEA=; b=NBXB6g5MEoKnCVu4UlP6KJEWzI3QVEq21I2mhRwmiVpEML
	N2ziPMlIwoC8NYmGVd8oL4xJAgFglbMhpaGrcfOnvh86ETc+AxFXgLUCVpVFCJfa
	L+j/FuzFcWyM2W5xrPfzcjeIZOrfQAW9ETFfav5g6Z4Fyyr5HZZKuYKIrbQ2JnVK
	enRbO9IvEdd0fXDstQ2x0mEgRyP5cWaRR4Lb9DkDtTRpPrdRTgIWVpPPYwECVue2
	x+jwoJFQpXQ5aHpFKcE/udAUhuwAoqH9LhP/7hGpojKF7mzK5HPIfY9T8isKtseG
	eC1/awJoZ/NHfRMi7lMkdlkmwGF0mk3CVS+uyCBA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp41bhc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 10:49:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669AnkuG001443
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 10:49:46 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkcrpb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 10:49:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669Ang6550069886
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 10:49:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 471792004B;
	Thu,  9 Jul 2026 10:49:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 067A420043;
	Thu,  9 Jul 2026 10:49:42 +0000 (GMT)
Received: from localhost (unknown [9.111.0.64])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  9 Jul 2026 10:49:41 +0000 (GMT)
Date: Thu, 9 Jul 2026 12:49:40 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/checksum: Fix csum_partial() without vector facility
Message-ID: <tthwm2s@ub.hpns>
References: <p01.g0de361f35d11.tthup4z@ub.hpns>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <p01.g0de361f35d11.tthup4z@ub.hpns>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4f7ccb cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=taGOT5302pmyRWZOzp8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDEwNCBTYWx0ZWRfX0Nz2dafu+2ou
 U4Bt+HI68BnGIAuGI06MGu9p8jsHhVuhdKkeCuqmfeHN3EPUuZMiLYMj7qb5aZUsiaonXikyWo/
 OxarkWF6J5BUWj80Gilbi8Oyni4rXEE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDEwNCBTYWx0ZWRfX3fCO7wxSgWXl
 xMGKAYZV3xJPRBvX/qFrxm9oimQ0z9Ir38XRvVmwKyB4JlUmsxGJbv459jr2Ft2u+Bc06cRVbBj
 6oqLYdFejP6FPgXsSh/DGWdj7fFH5Uos+Q2qbuqtOgOEog8x4yqNVh/Q7OWEOg5Qzol8hr22JP3
 k+MJNtugOnS94lhH7ff+ZkF51Rzi9NHXLA1SeVS/w0C0YTgISf186evlCKFG/3QkqciVIzqXZ9V
 uxG8JpijesvzFBBjx3hxovdN9bz2d3HGXNMae19PvhXubQx/7/X7mMWZKMfLi4OYo6l2m3yVbiz
 GPHKNPQAFMtIjtaFvyWj4ICtLdLDEHBf0LYzTR9tGfq+1ej6EjA22uRVrw6ja0fTnXVZ7ZuIs4f
 VyxhfQiAVG+gchkxkTZB51njSUmCZYabYXk8DPiaxVuWjRUTMPvFYk+mh2KYk5B7rUEjwpipm/R
 HiWlLtFxOgQ2dBDXlOg==
X-Proofpoint-ORIG-GUID: 6_HNMVhbnglecZdpQtVSth5JCpNmQQ2u
X-Proofpoint-GUID: 6_HNMVhbnglecZdpQtVSth5JCpNmQQ2u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_02,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090104

On Wed, Jul 08, 2026 at 12:02:14PM +0200, Vasily Gorbik wrote:
> Currently csum_partial() calls csum_copy() with copy=false and dst=NULL.
> On machines without the vector facility, csum_copy() falls back to
> cksm(dst, ...), causing the checksum to be calculated from address zero
> instead of the source buffer.
> 
> The VX implementation already checksums data loaded from src. Make the
> fallback do the same by passing src to cksm().
> 
> Fixes: dcd3e1de9d17 ("s390/checksum: provide csum_partial_copy_nocheck()")
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> ---
>  arch/s390/lib/csum-partial.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied
