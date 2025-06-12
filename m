Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9780918DB2A;
	Thu, 12 Jun 2025 08:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749718149; cv=none; b=gsT59vxDhh9HK50Ey4p6J1yocWnblmpkeavRydBsiL0/hSbjA0iTE8v8WS0wbt1vHiynvVtudHr/3hwtlqGPjLFSdArQHLberQI/xIqTXFO1Wko83iKilxchLmu92WmCERwJl6KzktRbIB7au6NEh9TF1CuR7WHuKR5S/tPI0xA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749718149; c=relaxed/simple;
	bh=PAy/WlPsNYo+E95/+VqoFf2fwUusuRoy36XPJndo1fw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xx+PyvHgm7N+sscwwby4SIEfRrCukodVF7C5BZVLAfOg5lqygzKgjGLJogw7et5pYjFn4NDWVMSC7lrpfRghUnCcSsHXjzcxCMiiu2weQbRYpPf5WQ4w7lwCyRz71MBn+O6eyH3t72VUqrI6P7ezjPRD4i3mlDBxBXu16ddUp04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qsVXGP0t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qsVXGP0t"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C1RqVE019665;
	Thu, 12 Jun 2025 08:49:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=931g58CzQGgnHv1qSvxrUg/N0PxEDU
	ddT7sLaxR1SCg=; b=qsVXGP0tvfIKw99NVM+a8FEXbzCnqvS+YJbCdrHvlfQExe
	3bFposHMGYrSrzhizK7D8sOwPYI+sqDX0QzqzBs2jvVpftbwHWhut93FwGoDG7tS
	T3onS4s1nKGUvQCE2olzgd/WWzxK5zERjm1CdD05zKuNRO8lI0RJhin0y7Rqn001
	TzHmKqycJM45vCSh2p/2t4Kk1SwYCv15L/m/t5qwDNsAC/ytGZ49vZ4cyBKJPXRP
	lBflzkfoqHulOjaVvOp99xx4kdR4k/yhGS0RH2tIXk1U75QiXmTUAegnQf1+5hvH
	7RdTfSHGySaNH3Y7X5NyTw189ew9/5Djvg0VMskA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7shdn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:49:00 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55C57WEM015168;
	Thu, 12 Jun 2025 08:48:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 474yrtm5mp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 08:48:59 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55C8mteu38666584
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 08:48:55 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B9CC82004D;
	Thu, 12 Jun 2025 08:48:55 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0361520043;
	Thu, 12 Jun 2025 08:48:55 +0000 (GMT)
Received: from osiris (unknown [9.87.144.171])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 08:48:54 +0000 (GMT)
Date: Thu, 12 Jun 2025 10:48:53 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/pkey: prevent overflow in size calculation for
 memdup_user()
Message-ID: <20250612084853.10868Bec-hca@linux.ibm.com>
References: <20250611192011.206057-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250611192011.206057-1-pchelkin@ispras.ru>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: DUSRih4kD1J-pZVTJ7-3wUb-CIvBe78g
X-Proofpoint-GUID: DUSRih4kD1J-pZVTJ7-3wUb-CIvBe78g
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA2NyBTYWx0ZWRfX3shafD5pCby5 zn4BQWOW3B1EP+sJu5j58nF6pQs0rF3N0CdALFigXxqCa2t0ErpEnSps1KG0ODNWdK9xrUcOggP Z1mVBHDDPxUK9/IvelrL4L5hBFZ9p7DZZfBxyLdoi2FE4PtlKb6nqjSCbyb9oo4gPB0GSv09619
 ohGtTxZmCzUFfDIJGH+lHNn0qmH4JlfYrVv5LP/dTwLVh6nDQzcW1xGPN3ETd86XsG4lStbifN2 8IqsxPbRhdphZLt6k+PvUffu15jB+1HWnN/FLF+jXq8okZ1SXJ0/hxDHeA+C7waI2+yHTLTmOKW 9S9U5KiK2zRkmtrG6Y3ZO+MSVkFMAG87BhpgQ2gFMV4lC8+L7RpcZKTfAHIDPA/mc296IBxTpon
 yy2O+zwduh38cem/p97WBjAALWFENM9CG2nhwm6m5DUk8nvuDYbeSpPwH7lPADN/pLO83S34
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684a947c cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=VnNF1IyMAAAA:8
 a=UixuG2OKhzkuXq3kIYYA:9 a=CjuIK1q_8ugA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_06,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=397 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120067

On Wed, Jun 11, 2025 at 10:20:10PM +0300, Fedor Pchelkin wrote:
> Number of apqn target list entries contained in 'nr_apqns' variable is
> determined by userspace via an ioctl call so the result of the product in
> calculation of size passed to memdup_user() may overflow.
> 
> In this case the actual size of the allocated area and the value
> describing it won't be in sync leading to various types of unpredictable
> behaviour later.
> 
> Use a proper memdup_array_user() helper which returns an error if an
> overflow is detected. Note that it is different from when nr_apqns is
> initially zero - that case is considered valid and should be handled in
> subsequent pkey_handler implementations.
> 
> Found by Linux Verification Center (linuxtesting.org).
> 
> Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
> Cc: stable@vger.kernel.org
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
> 
> v2: use memdup_array_user() helper (Heiko Carstens)
> 
>  drivers/s390/crypto/pkey_api.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
