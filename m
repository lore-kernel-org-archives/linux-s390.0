Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B01E432E76
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784801382; cv=none; b=n1hme+Ocyy0LS2cItp9MQcWJnLTdIFVxrnqGYVpB4ij9PweD4hbiQH2FCDfk44fWV6FZCeJIHKRIyttzKCRDY7ugiNYF5OABMU2w3pdiI+YW6WfPJer7276c+tCKrgBzm+Y1NVWoMEZJhfv2VZ4fQIYoKeTTmQ9HamMcn+4+zG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784801382; c=relaxed/simple;
	bh=9D6vw5vR0U3ggAEi/i3dW6qy+rIsuy0KU4isKWvCMgw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WFBcrLpcBn0ANKabxQE8XPtPrfCp58zFBbdwgFeXXZCQYycmpq/mvymgNSk1eDc11lu7mwrGMEWocOKj3XWgCzGirEdHZ5UBxoyVt3pfVeiygrfpQ4k8Cw/GWk1NHGvpvFyU11vU0YeDAA1/Cf1mm+z4XWbApxY+ur1645Q+IaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Fasm9PHq; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Fasm9PHq"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66N9Bqte701419
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:09:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=XxzXyMrQcjZ+4C7Y+8icRdrKdIN+YM
	LyB2t1M/Ul5LE=; b=Fasm9PHqiBylnmpwUXBhvPPgY77FUcYCSjnXCyDmJio0k+
	G+ANYGRdq//tZZDEmfCW2fmiZrFYaCVmE6/brC5DhOcnUzXNKeAqewSUaHmozWdq
	ptm+tzGfiDZDAeQsmvDIY2dzcQA5h1/jc2rEmDOvjopnJ4ip/IbK3CU4Ocvj1D5I
	YI/I/BIH/48OSiiA5ic6Zz+r1VNMwxATa/J0Eyns5KqsRxch/DyYkNVSoAD6DTmK
	/9uLHazVLu0htX9KLEF6y1h2rVDKmrpm3fkWLXY4dfrAA66cZ6aiv+lprUbaDfM+
	WZ8TfqiqfLXKWgipMXON5x8VMc4CnhW1f/Gnt0hg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg77apx2j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:09:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66NA4dZm013990
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:09:39 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fgp1gke85-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 23 Jul 2026 10:09:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66NA9Zbr50332132
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 23 Jul 2026 10:09:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CA4EC200A9;
	Thu, 23 Jul 2026 10:09:35 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 94CA0200A8;
	Thu, 23 Jul 2026 10:09:35 +0000 (GMT)
Received: from localhost (unknown [9.87.154.205])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 23 Jul 2026 10:09:35 +0000 (GMT)
Date: Thu, 23 Jul 2026 12:09:34 +0200
From: Vasily Gorbik <gor@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v5 0/1] Rework pkey ioctl functions error paths
Message-ID: <ttimhjy@ub.hpns>
References: <20260722142947.109588-1-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260722142947.109588-1-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: iAxVLdn_PdjdKZWPIj25JngPrzGaw2FN
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfX0kVXyV2n1H40
 htf3z5eHFf3R5kYBb2yD/Si2f7DR73s87etRk/W/+zKvDmfiZzA/YFjIwel+xkokZ1ttwmqoUhH
 BPswLE8sLTY/WBhFtRIiWT3QRRnHN4c=
X-Proofpoint-GUID: iAxVLdn_PdjdKZWPIj25JngPrzGaw2FN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA5NiBTYWx0ZWRfXxQcceAHW29R1
 dHy99QsdxLP3o7yXI+r0sMdGF7bAI0GYDj88olDSF/tyGhg9j1BzRlqXvSsAFS+hy458jACcXrY
 e5dxuV9XSlVHs7CQ9aTZW73qlZLsDVoK8a2/1NQUl1hjFHz9nb/DGuCG+KwKwOADrQE0gD2KB5/
 8q7YHgTe77oXLNekpNHRCOp8F5gNOAe6E/fOmrf0fc5n4g0GlHSVK+321zrKXuXzkUnX/xEki0y
 HMCcIoPIywgoY6hWlqt0OZHl+CHlWV0vohT1JxbYblf7PkHZDwCa9jGTLpFUBWFHCWSSm6flFbK
 qXfyTWu8vDozrhB2aAREZ2BwGmRZbl1X1BrHKqanAEBF/fXPGauUWFF5LqWpLb1GOpvvFp+rYVG
 kAqt3neF1q8rCS25Zue7htjgYXIyPnaeWS6gWQ4qkzWc6VI2en+fu9NuQt2cLJSIdB7ygL2aSS/
 KOPUMs394yEU1IWue8A==
X-Authority-Analysis: v=2.4 cv=K7AS2SWI c=1 sm=1 tr=0 ts=6a61e864 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=jlZqRBTkV_RvZNCki7YA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_03,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 spamscore=0 phishscore=0 malwarescore=0 adultscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607230096

On Wed, Jul 22, 2026 at 04:29:46PM +0200, Harald Freudenberger wrote:
> Slight rework for all the pkey ioctl functions, especially related to
> the error paths with regard to free memory. This patch removes all
> this duplicated code and introduces one code block at the end of the
> functions which is jumped into via goto out or executed on regular
> exit.
> 
> Changelog:
> v1 - first version
> v2 - just a rebase of the v1 patch as the original patch did not apply
>      any more.
> v3 - Fix paths where a error ptr returned from a helper function may
>      be used as input for kfree(). Fixed typo pathes -> paths
> v4 - Added yet another slight rework covering the possible use of an
>      uninitialized variable in an error path.
> v5 - Resend without any code changes, just Finn's reviewed by added.
> 
> Harald Freudenberger (1):
>   s390/pkey: Rework ioctl functions error paths
> 
>  drivers/s390/crypto/pkey_api.c | 288 ++++++++++++++++++---------------
>  1 file changed, 157 insertions(+), 131 deletions(-)

Applied, thank you!
