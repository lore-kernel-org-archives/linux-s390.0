Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 960553A4521
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 16:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789920922; cv=none; b=teaLzwX/7m1e4OYzaP/B9W3eJA2orl7yT3XbgSkna+qeqr2MD4kcqJeKUHFBTru8OHmZxIp4KbcHfQsCTaoFwUulEJwC9rkf+W7zBjJtyOUJm9ZArYuGJ1PnCZoZWILDZhILu2FTPUQ88bzBrmO6nx6Y5ugItsofs4bDnHjpbfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789920922; c=relaxed/simple;
	bh=HUs3i/y7j3qer2NxO45Pe+GzUIjsm78yS0CKIxYFiK0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z3EhfJCedHbx6H4y+7QacPuhAKpM5yadSf+VFkM2xv8+RNbq5kUWPm9pt5mWp4jX2vasb13BiQw2YHmqG9l2Z8tMqvL/3ejM+iEqPxr6bUAa7spmsn4TlPVZE5zunomhorajlrciiYO50rBWOdCaYfXFUgtbUIuDs/xg/e7Mkg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tleqkole; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tleqkole"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFa1sx1175003
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 16:15:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=eplk4NdRXUTsK3v/sIncVRRiLgpZAF
	vj9Npx8IuUCcw=; b=TleqkoleGHMS5diSTgkSZNtiY4uKMemdG1va7dWt6RlPTp
	CgrCA67cl1UGLw/iFvl10wMtTQsbpAf3oK7KNn0LEwmGXXcvDh1UOopAxJDo6VCI
	WLAAH9awToecx0GFJYUENK1OMpEU8WIdEIL9IGkWdt4x+8pdm5i3uIc2/M87pcTa
	rXIuFVZLW5iSQ8FCETmyKmc1Dnu1FkJ6OkIQVFBGw0jlsRJvNtdH6ZsnM6x8DUHn
	44YZEVKuemU7f/+ZpOA492Ko1TkSh6DkU9OlnSmOFl581cTFsJ6nOZbHl550tYgI
	m4qzMxPSC/metYXaF2NdBNfM0ci9HIDugKIpCc8Q==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1d004-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 16:15:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68KFHb7i4051822
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 16:15:19 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gt53va4kg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Sun, 20 Sep 2026 16:15:19 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68KGFF3531785510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 20 Sep 2026 16:15:15 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BA3A2004D;
	Sun, 20 Sep 2026 16:15:15 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 211F42004B;
	Sun, 20 Sep 2026 16:15:15 +0000 (GMT)
Received: from osiris (unknown [9.87.137.215])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Sun, 20 Sep 2026 16:15:15 +0000 (GMT)
Date: Sun, 20 Sep 2026 18:15:13 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Vineeth Vijayan <vneethv@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH] s390/cmf: Fix virtual vs physical address confusion
Message-ID: <20260920161513.18515A31-hca@linux.ibm.com>
References: <20260918161207.1756809-1-oberpar@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260918161207.1756809-1-oberpar@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: uSh68AuTqnAruTSqyah7ZGyQ0DApLqnY
X-Authority-Analysis: v=2.4 cv=EOCTQFZC c=1 sm=1 tr=0 ts=6ab00698 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=etb7qX20UnLCi8IszcAA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfX5NrHR5J4UaVT
 kTTohCr9S9GTwbiPMFUq9XKLpTZYFV6PSF0LC2jMjCjaAUPNbtENfPBh6LgwqiklkgkhYPkaIzQ
 J57vVRUWCPOsKZUGaFGK006JTtt5L5I=
X-Proofpoint-GUID: uSh68AuTqnAruTSqyah7ZGyQ0DApLqnY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIwMDIzNSBTYWx0ZWRfX/mIK7vc02qYs
 MQr78xz65/GhFXULSnmwsIfADmlsGrEsQ76H2cXl82cj88J1Ns+3WU4zu7/9e+dllhCRSMCHipP
 cntI5dz07UwrIX+tZSWyAXOwlOEOcbBnyqbueoEhuWVIWjTgZOJnXAlSWuA9Fpoq8oEChH9KfHf
 Nj2CGyWok+KBBmFMa653DKpepQrwTYkq9EjuRtQKQTvFnlT59gSwaS67+zYomxCLDRtMqWJzddo
 MlkXfEe3WS04G3LrzXyoCvYGjNl0e84kVqeSyRQBTwtKAsiUNUlK94CLgFMLMJSvpkgHZhMeg79
 tQseb3hs0AlmRcuyrI/esWy6DVJdlYuqy+axtZrCx0Yf34BoqXMPPZVv1FLY5sM82qUfAM6iWvf
 3IZ/s32pqTPB3c2IVQ9tS2fmPVNBZRRySR4NOFXgozUKk1oM6xWQDU4H5z8uAWYixBJquHQLg2/
 CM7HmnT4g2466hfcGJQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-20_05,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 priorityscore=1501 clxscore=1015 spamscore=0
 adultscore=0 impostorscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609200235

On Fri, Sep 18, 2026 at 06:12:07PM +0200, Peter Oberparleiter wrote:
> The measurement block address is an absolute address; therefore add a
> missing virt_to_phys() translation.
> 
> Without this fix, a wrong address will be used by firmware when storing
> extended format channel measurement data on kernels built with
> CONFIG_RANDOMIZE_IDENTITY_BASE=y.
> 
> Signed-off-by: Peter Oberparleiter <oberpar@linux.ibm.com>
> ---
>  drivers/s390/cio/cmf.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/s390/cio/cmf.c b/drivers/s390/cio/cmf.c
> index 92ab3d546fe4..5f57a12762d2 100644
> --- a/drivers/s390/cio/cmf.c
> +++ b/drivers/s390/cio/cmf.c
> @@ -183,7 +183,7 @@ static int set_schib(struct ccw_device *cdev, u32 mme, int mbfc,
>  	sch->config.mbfc = mbfc;
>  	/* address can be either a block address or a block index */
>  	if (mbfc)
> -		sch->config.mba = address;
> +		sch->config.mba = address ? virt_to_phys((void *)address) : 0;

Would it make sense to change the type of the mba member in struct
schib_config and struct schib to dma64_t, and use virt_to_dma64()
instead of virt_to_phys() here?

That would add sparse type checking and would catch similar future bugs.
