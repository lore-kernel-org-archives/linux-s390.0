Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 871C92F4321;
	Thu, 12 Jun 2025 11:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749728465; cv=none; b=A+7jqZ+rT225wJBEi8CBmfn5JtlFjvPe1ihtyAocccHreIit8FHXy/czCvr0FxwpP3iIoGE8zoNgRt04EWecJMWVhGhwv/dqUs6nTe8/pQ6wkxsPEGeUfbE9lh/NCXcBgjfL7EDXYIUS2T0AepPJIU+uHTl3T5ltEQ6l/Cyxfv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749728465; c=relaxed/simple;
	bh=Q4XoUFpQv2swVxPe++qvUoEtbFikUDsX9fGBpjA8psk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WRvwgR60nikkMw2y0KAI8suy0Ze/foMX5vY1aQIr0RXrf7PUa25pHTaFT72O5FhOhuwF8rmPamw9SrpgWUTZITu6YvNarphz0JIut0rY8wVocjL9hf0Vx8QR3yC+6rsz56QkVf+qJV1Bas2WaMOGsdsYrbNU104a5s1TV7rXvu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rOtMhvcH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rOtMhvcH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55C2rOhi027347;
	Thu, 12 Jun 2025 11:40:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=bcV/754bBlWaL9ToRIvwhPmH1WFMs7
	Bzy0vJwrIycHk=; b=rOtMhvcHE7en9IRnDh/uhZUJ7rDCWIz1t32sMgGTNLww3t
	JxY/Eeht+WACtq3xVsOw1kfX4fo960j/ahFPr9qTXsbNLiqoBl0vo4qdl7H9qsOZ
	cYpVWHoTBFcnCJuqsDcxlr7W37L0DSGWqHbVtDLOZikq3l0pBIJ1WL4+MvFaWf02
	m3ICXB9JlvE4w2gS2bleaGSpLqHWe9qcncFx1Hd1d65xtls3SeFxfdSQZ1jnqEsE
	9ii1mhxPJupuBoQubt2A+s8+tbnHdIsegXsMc9yPiH/ZfhqEsQtvDNTa8Pb15P8z
	n/Fug71It+cSe9LcsRcsbTdjHJHIZgDtL7tFcTvw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv7taqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:40:56 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55CAKDTq021895;
	Thu, 12 Jun 2025 11:40:55 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4750504msp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Jun 2025 11:40:55 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55CBepeP59441530
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Jun 2025 11:40:51 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B98A920040;
	Thu, 12 Jun 2025 11:40:51 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6FDAE2004B;
	Thu, 12 Jun 2025 11:40:51 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Jun 2025 11:40:51 +0000 (GMT)
Date: Thu, 12 Jun 2025 13:40:50 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] s390/pkey: prevent overflow in size calculation for
 memdup_user()
Message-ID: <aEq8wrEmJVItMiZQ@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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
X-Proofpoint-ORIG-GUID: YzfeidtxsQ4a7GyVfVSZDf4kay8v1FrQ
X-Proofpoint-GUID: YzfeidtxsQ4a7GyVfVSZDf4kay8v1FrQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjEyMDA4NiBTYWx0ZWRfXykqO6HJL6g0W 8yPNuUf3Hhbjqd2KkVXvn9IaKwRVZr7tZu66Enk8RYY7U0c066pgvds99QOqmJ1OjytbFVjk3ZF CkNMm5ZNv0TsWgd0poQ8nDXP3+dQy5ZDCuhnqUai0L7bzlCLFkYdBfJJPJ4nAby3HNH2jDdY9N8
 PKD4t7X7jPLgm4hj8UfjMjuvAh+Evw/cFV0GzMFeyGBGIne+w/QCEWtO9s84YCmJO8x0JAt8J6I j67AX4eyjI7k4d3A2ow4BvEejwTvf6lOA43gk+DXI5KBehZXuy4SS+Gn+2l95YFcBpB0b3RskJO 09QcUmuR9p622H5zX+PQ6wsUbuNSAr9FCEQwdYiTJV55UraPhp4LM26lMJdJ3lFmXiZP5EtFfc1
 UbKNm6oydGFn3I8CSz1bQsoPRkiFkhzGEcthSSeOcREVzDkotwuKbOPEff/KlSh7mqemm9hJ
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684abcc9 cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=kj9zAlcOel0A:10 a=6IFa9wvqVegA:10 a=HH5vDtPzAAAA:8 a=VwQbUJbxAAAA:8 a=xjQjg--fAAAA:8 a=wqd0SS-B0bwRHdejR9QA:9
 a=CjuIK1q_8ugA:10 a=QM_-zKB-Ew0MsOlNKMB5:22 a=L4vkcYpMSA5nFlNZ2tk3:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-12_07,2025-06-10_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1011 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=638 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506120086

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
> 
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index cef60770f68b..b3fcdcae379e 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -86,7 +86,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
>  	if (!uapqns || nr_apqns == 0)
>  		return NULL;
>  
> -	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
> +	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
>  }
>  
>  static int pkey_ioctl_genseck(struct pkey_genseck __user *ugs)

Applied, thanks!
