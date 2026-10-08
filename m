Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A54A31ED7C
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791482760; cv=none; b=JVsT2md+hGeMUwUMKnrFHQ/WLkS9Wu0qd4pFA5gBtt1ZWc3ZMkkaH9WwCyrBf682XWYvJ764fL+yOgNzXTDMoTp44hAQQ69qly7ZzJBvLVBcm4aD9sPTAfMlku5hIWyOdLOIARTLBLjuIkfs8U3/Jv8uzv+bKlYqJNmR01QNIIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791482760; c=relaxed/simple;
	bh=bn7DUYJFzsBWEBC9aLk/Jx0CShXPLq1UqD+gOlwfLus=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W+jR9wufgiDBP2lhsxLo3Me8PqneaDgdmkmFH6I673UPKvh2TH4U1nJXdq3evNH+8q/zFr8D1VhhAIIlUqrquJIJc1O65NqvS5nLQG+EovviY9SmiYnyo7+K25J5PWeyOT0wWeTTJ0H1C1wIeV4yLmfdO8UIQC0nLWmldJWdwPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=OQ6BI2pf; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="OQ6BI2pf"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 698HZnlK1967731
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 18:05:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=TzALEM2oAbZ+lPzHIBgyIwl5sB/MHH
	q02yQHLF7Me3A=; b=OQ6BI2pfjrPmNShYiSX42VZ5B4ncUN+L5PO9wmrTIe1olh
	Df+TyuXCbtAJgtmohg0nxoZiHiD6C3fOmN/Sh07r01mQAyOWXs9cTHIsYfhrJ+Qz
	tjYJaNZsRkZWvD2fC9CR6R+NkrXfSLXB92/KsNjbo8zGaaag3omhZn16BvqgyHPb
	ML+bEMw+LJLf06F9LVhfbL6ypAIoDchNJn6ul8l7mx6e6qiTfqIbpGQ9zGw41kbd
	QyYJ/yTI2AvBL/kHCSPJZf6Mh19SGBu5Wew50CVbSWZwC3/CGIZVMiHYM4Ayn3p8
	PCyUYsEEbXh0e6mB9h2c1yEhealyn4+KhXnKff1w==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvdpqc-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 18:05:58 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 698HWhc63783110
	for <linux-s390@vger.kernel.org>; Thu, 8 Oct 2026 18:05:57 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h58d5rtcm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 08 Oct 2026 18:05:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 698I5rrJ44302834
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Oct 2026 18:05:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F315F20049;
	Thu,  8 Oct 2026 18:05:52 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE03E20040;
	Thu,  8 Oct 2026 18:05:52 +0000 (GMT)
Received: from osiris (unknown [9.111.70.153])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu,  8 Oct 2026 18:05:52 +0000 (GMT)
Date: Thu, 8 Oct 2026 20:05:51 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3 0/2] Fix minor LLM findings in zcrypt dd
Message-ID: <20261008180551.13419C79-hca@linux.ibm.com>
References: <20261006154603.9699-1-freude@linux.ibm.com>
 <20261008180225.13419B26-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261008180225.13419B26-hca@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: DgG1LfOZMDjzceW3K-qqBUjkri3lZ_Z8
X-Proofpoint-ORIG-GUID: DgG1LfOZMDjzceW3K-qqBUjkri3lZ_Z8
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac7db86 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=hYu9tsoeT-jkgwHI1scA:9
 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3MiBTYWx0ZWRfX8vJXD21oxo64
 lXWmtR5QHpOHEst2VkWKdxkIUUEPnANb0j0y3opr+5PmbQLDQKlyOdkFRH0YdsHTzlVEEIIuPae
 fL2FW5ZniouWhfgw8g5Kyx9bZp38ywFmqdNkQrvOC9uXeCJWy2ZP0HvtOQ1BPwxSuYQaqulXGBh
 lsq5GDH+ZVRM1zYj2mH9R5fYbJmTPEz5EZNTN4Hq5uo42oLPCHFnDNWz5UipD562P5/rJwEv5UV
 v5oeH9l65YrLpGFaGmXnWKHPwOki5W8LvY4QtZMHCif8D4zlYD+KHV16qOuUMeOKk9FTvigWMs6
 i1c3QK2QEuwBkyMmu9QruogzHhBl2r1yZudlCk5cR6Zrwjb2LevYRr8t4YCfyyi0C7OPMHlLon1
 8qO1tQV7ahdIKXl8yTvjx6/Z393p5/k1AXFBFgVcQGUTJsea3w804HUsizzVfh9YnVs+TYOyZ4p
 UP04mZFPloXKUVfyIWg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3MiBTYWx0ZWRfXw3fqT79LGPdx
 L+INsplNfiR/NZVgkSBY0azyOvego4bI1GJ5+rc/o9vIyQ14u8WcpSl6DIgdMIAEqASWEYETN4l
 FJEJ1klytU1lTrQhVrACQflKZAEysXk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1015 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080072

On Thu, Oct 08, 2026 at 08:02:25PM +0200, Heiko Carstens wrote:
> On Tue, Oct 06, 2026 at 05:46:01PM +0200, Harald Freudenberger wrote:
> > Fix some minor LLM findings related to the zcrypt device driver.
> > 
> > Changelog:
> > v1: Two patches:
> >     - The first patch fixes a gap related to speculative execution
> >       with the domain index.
> >     - The second patch fixes a length/pointer check with parsing the
> >       FQ reply from a CCA card.
> > v2: Fix a complain from Sashiko about silently dropping invalid
> >     domains down to domain value 0. So now a explicit check makes
> >     sure domain is either AUTOSEL_DOM or in range 0...255.
> >     2nd patch unchanged.
> > v3: Well this spectre thing points out to be really wired. So here is
> >     again a rework claiming it shall protect against speculative
> >     execution with respect to the domain value.
> >     2nd patch unchanged.
> > 
> > Harald Freudenberger (2):
> >   s390/zcrypt: Guard domain index uses against speculative bypass
> >   s390/zcrypt: Fix out-of-bounds ptr advance in
> >     cca_query_crypto_facility()
> > 
> >  drivers/s390/crypto/zcrypt_api.c     | 35 ++++++++++++++++++++--------
> >  drivers/s390/crypto/zcrypt_ccamisc.c | 22 +++++++++++++++--
> >  2 files changed, 45 insertions(+), 12 deletions(-)
> 
> Fixed typed reported by Holger, and applied. Thanks!
        ^^^^^
typos... :)
