Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC3E28369E;
	Thu, 10 Apr 2025 11:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744286055; cv=none; b=ZCslaHzLtbc6dWWaWiE8Xbaoxc5Smx7Xoo8EibzJTvMDCsBJABPcDA58FQxUpPqHxuR/lw84Boj+vh6wKlCVrvZuROM0KMM0z3/40pqYrhDnU1zl/RHlZrt4yYgm5XD2mpvQCawTUSsU+6pvx+XE1+tXvaol4M74UtUzk5/DWrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744286055; c=relaxed/simple;
	bh=VkpzxQnPv4g7qVNaOY8DVOUzppBCuz8wvrpaObOsARI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dsj4gooKXhcdAwiiu5gu1QCLIyPjpN9rhnkN0xn8Pi6OX28pxDdObct3YJEBD6Us7OlOnNn0ImFTEi/ip7YgpW+vzRuD7jKhCY0HTlwPsLzvfsf5zdjnNnHGMmyWClwETmB/lKC61H5gWoQkwnnObB8uCRAJc9xUoiWEEfsaWCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eHJpZCRO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eHJpZCRO"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53A6F5sh003312;
	Thu, 10 Apr 2025 11:54:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=4uB5xgE1U7uP+X5kkwtxU25Vq8f/Iq
	ONtcpyD31Pry8=; b=eHJpZCRO2V6XkwmDESkCCQKjMNmqbkOfJStYMmqS3igcWV
	eqTvHYCuSebd9mcY9FSMaSaI71CCEpZ1SHwg0tKix+EjnVPOT9xqpHpH2aVfX3dP
	91Q27a6y/jV3u4J+TDCz4X/8SB3B5PA8PsnXTkd6Gm18ajkFtk28InAyIs+4LXW9
	xe4k0tjW1XyqCxLF91Vego5vQNMyDwk9Mecg/Niy2I8jfMqIYYb0dGUOSkOS7FdE
	anjO25XcA3PIWobilncNCY5aarM8AlP4NE2XkDvbp5BYk/JU+Bd8kQQP8meoPTWp
	BPr1oL9jpvT8JTZQ7fb9mxxfh9lLlOdhsKCAtgRw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0404dg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:54:12 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 53ABmTkb015775;
	Thu, 10 Apr 2025 11:54:11 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45x0404dg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:54:11 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53ABO46L024651;
	Thu, 10 Apr 2025 11:54:10 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutp23q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 10 Apr 2025 11:54:10 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53ABs61t47579552
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 10 Apr 2025 11:54:07 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB1462004E;
	Thu, 10 Apr 2025 11:54:06 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B00F20040;
	Thu, 10 Apr 2025 11:54:06 +0000 (GMT)
Received: from osiris (unknown [9.171.50.250])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 10 Apr 2025 11:54:06 +0000 (GMT)
Date: Thu, 10 Apr 2025 13:54:04 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
Cc: gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Subject: Re: [PATCH] Removing deprecated strncpy()
Message-ID: <20250410115404.8774F32-hca@linux.ibm.com>
References: <20250410113230.28116-1-kevinpaul468@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250410113230.28116-1-kevinpaul468@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: LhB3sn-1zY53nSnUUIU3aprwMcHou5uU
X-Proofpoint-GUID: Ml1u4_wJ4OQpFUIhIk6rfwnBBTWIB-Fq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-10_02,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 mlxlogscore=707
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504100086

On Thu, Apr 10, 2025 at 05:02:30PM +0530, Kevin Paul Reddy Janagari wrote:
> This patch suggests the replacement of strncpy with strscpy
> as per the Documentation/process/deprecated
> the strncpy() fails to guarntee NULL termination
> since the function adds zero pads, this isn't really convenient
> for short strings as it may cause performce issues
> 
> strscpy() is a preffered replacement because
> it overcomes the limitations of strncpy as mentioned above
> 
> Signed-off-by: Kevin Paul Reddy Janagari <kevinpaul468@gmail.com>
> ---
>  arch/s390/boot/printk.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/s390/boot/printk.c b/arch/s390/boot/printk.c
> index 8cf6331bc060..8f3b2244ef1b 100644
> --- a/arch/s390/boot/printk.c
> +++ b/arch/s390/boot/printk.c
> @@ -158,7 +158,7 @@ static noinline char *strsym(char *buf, void *ip)
>  
>  	p = findsym((unsigned long)ip, &off, &len);
>  	if (p) {
> -		strncpy(buf, p, MAX_SYMLEN);
> +		strscpy(buf, p, MAX_SYMLEN);

This won't even compile. Please compile test before sending any patches.
