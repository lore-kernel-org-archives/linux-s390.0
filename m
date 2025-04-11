Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF66D1925A0
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 13:26:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744377963; cv=none; b=mH+8kDf8ESKywkAtskhj3RQqo/eCs8/OFITUn4ZiTjsh6iQIRLImVP+FLH6BwNbf+ndbujWEmiV7tm6Hw0/FrXFASDADgS+szVmHgvQ/WX+er0BS9kUesoXRvbLZkF+M39+D7nATiCFDV0wgifIDZ43qTJrcEUNiI0px5E8gQkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744377963; c=relaxed/simple;
	bh=Zy1teN7a7+qEWfARCBsnXKTkmltWgv8HYvxWAHq4xnA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BEZrwXP7EmRIvemlNyRAey5JDl93bVWFLrb04c4Es5O095YL1m7zMqAIW63WsRbuacRbVqN7zTDqAvnYCMw5PfyMivP1AZch04uCvsD2mAYm0uIeIxhndNpBHdhuVWKWlCrWEbVmWDEoqNtaHjcWOatzL0JDA64R69c1tNekpnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pf7m+DkP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pf7m+DkP"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B3kZQa028408;
	Fri, 11 Apr 2025 13:25:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=+g0x5G
	/pgYeLpgyhcvj8JA+0uvwqAGR6AHrRkptFoVk=; b=pf7m+DkPESo+yvmxvhsPsl
	gl/QAthMmt2X/gZu5XUclNOmqrC0HP6FRLkYcCqdv2fqXiE381Z3HkpEs1R8muAh
	IM2cGRfdpDRaPmZ/t8wi+CVKiGNMDjaV9kOS/wvCcKSekMh58LTRUcJxcm2psMyu
	f7jMfFJiMXpNWpqPEoaDRhx6eOlW3oHQIm+HbXp/cr/0XB4ndPJkR/PgsGG/RAIo
	TktbcUTXWyTOnEu7gSucFBHHwfNOSIOtRQRHDbpOv2f5ffq9e+PSf+WHP9400Jsj
	FhXHNeIe+z1c/g3PnNZqNOnzFBizUafLu1Z++wtZIsHhZh97eMWclucLJ+opP+4A
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xufaagmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:25:59 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BD7N1F024600;
	Fri, 11 Apr 2025 13:25:58 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutubv3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 13:25:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BDPsZ641943542
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 13:25:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 864C820040;
	Fri, 11 Apr 2025 13:25:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F199C20043;
	Fri, 11 Apr 2025 13:25:53 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 13:25:53 +0000 (GMT)
Message-ID: <3d545497-da67-4e03-8495-d5bf5a763d33@linux.ibm.com>
Date: Fri, 11 Apr 2025 15:25:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/24] s390/zcrypt: Remove CCA and EP11 card and domain
 info caches
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-13-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-13-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: GP8VBFNp0PLlRdfCt47nyIu6aVh-wj0e
X-Proofpoint-ORIG-GUID: GP8VBFNp0PLlRdfCt47nyIu6aVh-wj0e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 spamscore=0 bulkscore=0 mlxlogscore=999
 clxscore=1015 suspectscore=0 malwarescore=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110083

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Remove the caching of the CCA and EP11 card and domain info.
> In nearly all places where the card or domain info is fetched
> the verify param was enabled and thus the cache was bypassed.
> The only real place where info from the cache was used was
> in the sysfs pseudo files in cases where the card/queue was
> switched to "offline". All other callers insisted on getting
> fresh info and thus a communication to the card was enforced.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

See my comment below. With that
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  drivers/s390/crypto/pkey_cca.c        |  16 ++--
>  drivers/s390/crypto/zcrypt_ccamisc.c  |  89 +------------------
>  drivers/s390/crypto/zcrypt_ccamisc.h  |   8 +-
>  drivers/s390/crypto/zcrypt_cex4.c     |  35 ++++----
>  drivers/s390/crypto/zcrypt_ep11misc.c | 120 ++++----------------------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   2 +-
>  6 files changed, 46 insertions(+), 224 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 3a6a5b785a0d..7e24b78d4e56 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]
> @@ -1771,24 +1701,14 @@ static int fetch_cca_info(u16 cardnr, u16 domain, struct cca_info *ci)
>  /*
>   * Fetch cca information about a CCA queue.
>   */
> -int cca_get_info(u16 card, u16 dom, struct cca_info *ci, int verify)
> +int cca_get_info(u16 card, u16 dom, struct cca_info *ci)
>  {
> -	int rc;
> -
> -	rc = cca_info_cache_fetch(card, dom, ci);
> -	if (rc || verify) {
> -		rc = fetch_cca_info(card, dom, ci);
> -		if (rc == 0)
> -			cca_info_cache_update(card, dom, ci);
> -	}
> -
> -	return rc;
> +	return fetch_cca_info(card, dom, ci);

Why not remove this function completely and rename fetch_cca_info()?

>  }
>  EXPORT_SYMBOL(cca_get_info);
>  
>  int cca_findcard2(u32 **apqns, u32 *nr_apqns, u16 cardnr, u16 domain,
> -		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp,
> -		  int verify)
> +		  int minhwtype, int mktype, u64 cur_mkvp, u64 old_mkvp)
>  {
>  	struct zcrypt_device_status_ext *device_status;
>  	u32 *_apqns = NULL, _nr_apqns = 0;
[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

