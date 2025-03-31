Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17F971B4F0F
	for <linux-s390@vger.kernel.org>; Mon, 31 Mar 2025 11:21:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743420064; cv=none; b=Mp6rjEuMtSGN7qJpfzGMa1fUMPpEWMGKz+pGYqwcAMP/LCyg3ykCKy44LsAyYFXpZ679fvgwzUPaCMUq1l50W8ydgRTDON3ajyKEHCZK/VAp/dWt8aRhi3wgK0hAVeSStG9hPWXk1BBY14w1NtpMaZXHmV9xeZ048QX7dOUPfO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743420064; c=relaxed/simple;
	bh=ZXLEidgbdOU+yfK2MnIgbnNst9hfV5U73i6VH2kcgWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B5RfHJm90XFeIsD60u5RCCfWplacoL2JS7rbDQTDzv8ooh7UA6chSDSuiob6pAD/zqSaAvCdhxIzMBKlPP+eZA0bLJzYGBvc63R9shXHkoo8CF74eXXOwHhS17Bi07PbIaDgD7KIKZasD+Vatm32aC4O05+EMazvkwcmFHcbv0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M4YbKUYk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M4YbKUYk"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52UKdrm5014553;
	Mon, 31 Mar 2025 11:20:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=5yJWWXtsnZPvOibLelraA6MKnmpGc9
	5x6om/R71JYKg=; b=M4YbKUYkSt57mqzmUN31UImGNUi/bsDp7bVCOzNLjsJ8+m
	HYVu6EiVo0/UQprAoPf1Qlm2uIjaM5hbORti8hHbZ1L5uJ63WA61dDcvkgAxEeQD
	rkZBaMH0ufu5zoD/oUCiayatdoT+kyUuLPoN79NV06SoMZrHCREsB7g8U+z8x7zi
	FwmfFaLPb3bWLSgQVNZQgtMvxXtvpey4X5g7yRfHUQyjQ0uNiQaI4Xb+UJfabIPp
	6EcEoILoPe8kuJLvXw+0gXzWT0ytz5ZIIXgzJ/ehCIc5AEbQo/MgAXOZSvVFaYgZ
	7oXb12tP64YtdJkDqrKkR+9pSNa1gA+IoZRwcirw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45qd602rfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 11:20:59 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52VA7X99014560;
	Mon, 31 Mar 2025 11:20:58 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45pvpkwfcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 31 Mar 2025 11:20:58 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52VBKsCG33358356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 11:20:54 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 736AD20043;
	Mon, 31 Mar 2025 11:20:54 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0202E20040;
	Mon, 31 Mar 2025 11:20:54 +0000 (GMT)
Received: from osiris (unknown [9.179.29.62])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon, 31 Mar 2025 11:20:53 +0000 (GMT)
Date: Mon, 31 Mar 2025 13:20:52 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: dengler@linux.ibm.com, ifranzki@linux.ibm.com, fcallies@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 05/21] s390/zcrypt: Introduce cprb mempool for cca
 misc functions
Message-ID: <20250331112052.25223F0d-hca@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-6-freude@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250327143941.45507-6-freude@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: b9YKwCfcVnGXXQZFppq6EYq39aL0JQuW
X-Proofpoint-GUID: b9YKwCfcVnGXXQZFppq6EYq39aL0JQuW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-31_04,2025-03-27_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=999 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 phishscore=0 adultscore=0
 mlxscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503310078

On Thu, Mar 27, 2025 at 03:39:25PM +0100, Harald Freudenberger wrote:
> Introduce a new module parameter "zcrypt_mempool_threshold"
> for the zcrypt module. This parameter controls the minimal
> amount of mempool items which are pre-allocated for urgent
> requests/replies and will be used with the support for the
> new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
> shall provide enough memory items to support up to 5 requests
> (and their associated reply) in parallel.
> 
> For CCA each mempool item is 16KB, as a CCA CPRB needs to
> hold the request and the reply. The pool items only support
> requests/replies with a limit of about 8KB.
> So by default the CCA mempool consumes
>   5 * 16KB = 80KB
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>  drivers/s390/crypto/zcrypt_api.c     |  13 ++-
>  drivers/s390/crypto/zcrypt_api.h     |   2 +
>  drivers/s390/crypto/zcrypt_ccamisc.c | 117 ++++++++++++++++++++-------
>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>  4 files changed, 102 insertions(+), 31 deletions(-)

...

> @@ -229,7 +241,16 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
>  	 * allocate consecutive memory for request CPRB, request param
>  	 * block, reply CPRB and reply param block
>  	 */
> -	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> +		size_t len = 2 * cprbplusparamblen;
> +
> +		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
> +			cprbmem = mempool_alloc_preallocated(cprb_mempool);
> +			memset(cprbmem, 0, len);
> +		}
> +	} else {
> +		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> +	}
>  	if (!cprbmem)
>  		return -ENOMEM;

What happens on the ZCRYPT_XFLAG_NOMEMALLOC path if the cprb_mempool
is empty and the allocation fails?

> +int __init zcrypt_ccamisc_init(void)
> +{
> +	/* Pre-allocate a small memory pool for cca cprbs. */
> +	cprb_mempool = mempool_create_kmalloc_pool(zcrypt_mempool_threshold,
> +						   CPRB_MEMPOOL_ITEM_SIZE);
> +	if (IS_ERR(cprb_mempool)) {
> +		ZCRYPT_DBF_ERR("%s mempool_create(%d,%d) failed: %ld\n",
> +			       __func__, zcrypt_mempool_threshold,
> +			       CPRB_MEMPOOL_ITEM_SIZE, PTR_ERR(cprb_mempool));
> +		cprb_mempool = NULL;
> +		return -ENOMEM;
> +	}
> +	return 0;
> +}

Like before: mempool_create_kmalloc_pool() returns NULL on error. Also
please don't use ZCRYPT_DBF_ERR for such allocation failures. There
will be a very visible message on the console for this case.
