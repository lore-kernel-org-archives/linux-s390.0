Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534862528FC
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 08:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744189018; cv=none; b=dbWOM0oMeebqSngqnmg0Km2uMv0r4I4ogsj6Mpb5R7j64w3EwdIWVhn0CE/EWRtmuEu4mSSWxnrhkLwYYoriRp48pyYziS0qvh8Xdq9eiuN375DALOBbIfcJe4msMV3lU9K2tdjm5tORF+nBS9x9MEruzh8/FVD3MNJpQepPZ5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744189018; c=relaxed/simple;
	bh=+Hau5aGRNiV/kirjlID5WAWqbR7L0QnUJU4e0cb1uB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=krTVIZ/9/gIzhjQt0JLbF1qSEvTxHRE6340ZNqhj5tr1IoOlY69pMq6PeqYUhf9EFXVWWjFtDRL836iDN5plsplKIT/abmP4tnpidHt+xNxTvpwzv7kfx92Uz1uzkmaw4qECLLT374Xmr/1saYrTc2J7V6ry/1mcLLLcKyNa8sI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GchuS4aE; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GchuS4aE"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 538LALKm017794;
	Wed, 9 Apr 2025 08:56:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kSwMMs
	EX1FSFkY2mbu+B647C3GHl+f7Cp3PKaXkHDTQ=; b=GchuS4aEF1bEEjU2BBIVGn
	q3+zXogLG/lHad1B4UVsuKWiUH4O8MaHBrJusi4PriBIlMjd7JtBcqLj28LoMdrr
	LLXHvsqJLWY6JWDKkWKqdj8yPUvUeXNdDR9BMSnXky7RmSPZofCkYVi2tbjcuHdv
	6a/crg2RrL5BeBE5+NRjUzY277r+3NHHadNrgTjfHUJNGJKhqXvWF5CjspDnNkAF
	+URlRdv6o/euMS5mj2B9ICx1wbPwzwmfJiBGgzijJ6YrbjHNWzp27t5EWp0zsdsK
	7oLi8YQXMrEaTO03tQWPhS08Y/j4hSFF5cPXKu0NJFpf0S+lQY1xvp60NyVPPh6A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w3u35535-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:56:54 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5398VOr0024610;
	Wed, 9 Apr 2025 08:56:39 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutf3d1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 08:56:39 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5398uZxg33161518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 08:56:35 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8983320040;
	Wed,  9 Apr 2025 08:56:35 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1AE6E2004E;
	Wed,  9 Apr 2025 08:56:35 +0000 (GMT)
Received: from [9.171.58.154] (unknown [9.171.58.154])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 08:56:35 +0000 (GMT)
Message-ID: <5a3ac12d-6aff-42d4-87fc-1d8cc5a26d06@linux.ibm.com>
Date: Wed, 9 Apr 2025 10:56:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/21] s390/zcrypt: Rework zcrypt function
 zcrypt_device_status_mask_ext
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-8-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250327143941.45507-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: nZV1dmQcVur2LJoDoiY1fYpTGT0Y0e4Z
X-Proofpoint-ORIG-GUID: nZV1dmQcVur2LJoDoiY1fYpTGT0Y0e4Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_03,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 clxscore=1015 malwarescore=0 mlxscore=0 priorityscore=1501 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090046

On 27/03/2025 15:39, Harald Freudenberger wrote:
> Rework the existing function zcrypt_device_status_mask_ext():
> Add two new parameters to provide upper limits for
> cards and queues. The existing implementation needed an
> array of 256 * 256 * 4 = 256 KB which is really huge. The
> reworked function is more flexible in the sense that the
> caller can decide the upper limit for cards and domains to
> be stored into the status array. So for example a caller may
> decide to only query for cards 0...127 and queues 0...127
> and thus only an array of size 128 * 128 * 4 = 64 KB is needed.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Looks good now. With the minor change mentioned below
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/zcrypt_api.c      | 14 +++++++++++---
>  drivers/s390/crypto/zcrypt_api.h      |  3 ++-
>  drivers/s390/crypto/zcrypt_ccamisc.c  | 17 ++++++++++++-----
>  drivers/s390/crypto/zcrypt_ep11misc.c | 12 ++++++++----
>  4 files changed, 33 insertions(+), 13 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index 12efcf1b54fc..504064c27a8b 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> @@ -1599,7 +1599,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>  {
>  	struct zcrypt_device_status_ext *device_status;
>  	u32 *_apqns = NULL, _nr_apqns = 0;
> -	int i, card, dom, rc = -ENOMEM;
> +	int i, card, dom, rc;

If you initialize rc with -ENOMEM here ....

>  	struct ep11_domain_info edi;
>  	struct ep11_card_info eci;
>  
> @@ -1609,13 +1609,16 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
>  				 GFP_KERNEL);
>  	if (!device_status)
>  		return -ENOMEM;
> -	zcrypt_device_status_mask_ext(device_status);
> +
> +	zcrypt_device_status_mask_ext(device_status,
> +				      MAX_ZDEV_CARDIDS_EXT,
> +				      MAX_ZDEV_DOMAINS_EXT);
>  
>  	/* allocate 1k space for up to 256 apqns */
>  	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
>  	if (!_apqns) {
> -		kvfree(device_status);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto out;

... you do not need to set it here. Just jump to out.

if (!_apqns)
	goto out;

>  	}
>  
>  	/* walk through all the crypto apqnss */
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

