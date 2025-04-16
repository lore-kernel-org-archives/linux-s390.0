Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F97922A4FC
	for <linux-s390@vger.kernel.org>; Wed, 16 Apr 2025 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744796371; cv=none; b=qr0nY166gDsGtN8Z9tq6ltuYJNWy1tM8Z9449hhreXFV1zlDMvTKMAS33Hw/xgoeAkv123gT8M2RpH8tiiwl0h/psD2lliDiagdGibsvNPD285LbAaK6jIu/Q8qr4nBqVMm8v9lirtdNrbKJG9nAH/DqYj6TxCBemSkupiTq0/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744796371; c=relaxed/simple;
	bh=AhemxfrUPB5g0k3679m/5Wx7a1L9KmrSvc6W4Bf97gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZjpifUNMGz7Pl7QrgdOwoWKiLh1k33AR+5EH33/ho5Rs10rjzPu0okSquuMoibA5HEeUa+F/zHSImFGQ6x4DeR3Trn9BriEZ676s0PETZPUK+N5PvN5vYwwL8wFfUcb/hC+AeAEG5NxFEF5YEHATbAxqcunGa/UPAQ00UJX0PlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PO3dVCqH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PO3dVCqH"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53G8K81j019183;
	Wed, 16 Apr 2025 09:39:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=a7yaap
	Po+pQgxkpV2y6sl/1vTMgdAqHZDIAPiMtEtqI=; b=PO3dVCqHsSwZedkMf7Rtp1
	IinZAd1L0LLXEKYMtjTmFTg1TyYCXGY+riifeDDXsOxmk3iWYiN+4Zb0DPrSq/Bq
	n5nYZUVq2ZiX/stqosCsT+cNMf3R9dtSYiBKp7PM8wygxxKxQqq7lmK7B0+PNExs
	Ryrjxtg6kkOy0i+R46/1/KYMTVuyDp9cS3chTz7Z2lmGXh3F/vhlPqInQL+zkpJ9
	tyL/KK2kYLlfRjmt8igZ0M+jsIkVYl17wOZukZl4Oup00ZfV3390Gnsm9X94UN2w
	0XX4vojI4CG7Ji7gKxe8EskSztsM82ax7FaHyJ1DHgBLurmvsveZ9W+gC0jz1W/g
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 461y1gau6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:39:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53G81RSW010387;
	Wed, 16 Apr 2025 09:39:26 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qk7bte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Apr 2025 09:39:26 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53G9dMmT23068938
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Apr 2025 09:39:22 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 68DE42004E;
	Wed, 16 Apr 2025 09:39:22 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5BF432005A;
	Wed, 16 Apr 2025 09:39:21 +0000 (GMT)
Received: from [9.171.38.231] (unknown [9.171.38.231])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 16 Apr 2025 09:39:21 +0000 (GMT)
Message-ID: <836efa15-5815-4d21-9a1b-f53c59434239@linux.ibm.com>
Date: Wed, 16 Apr 2025 11:39:20 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 25/25] Add a new parameter xflags to the in-kernel API
 function pkey_key2protkey(). Currently there is only one flag supported:
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au,
        ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com
References: <20250415142438.118474-1-freude@linux.ibm.com>
 <20250415142438.118474-26-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250415142438.118474-26-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QzmXvuLvluNBz3cF73b-jjLuSngrYDNl
X-Proofpoint-GUID: QzmXvuLvluNBz3cF73b-jjLuSngrYDNl
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-16_04,2025-04-15_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 suspectscore=0 phishscore=0 mlxlogscore=999 priorityscore=1501 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504160078

The commit message is not formatted correctly. Please add a summary line and check the linebreaks/textwidth.

On 15/04/2025 16:24, Harald Freudenberger wrote:
> * PKEY_XFLAG_NOMEMALLOC:
>   If this flag is given in the xflags parameter, the pkey
>   implementation is not allowed to allocate memory but instead should
>   fall back to use preallocated memory or simple fail with -ENOMEM.
>   This flag is for protected key derive within a cipher or similar
>   which must not allocate memory which would cause io operations - see
>   also the CRYPTO_ALG_ALLOCATES_MEMORY flag in crypto.h.
> 
> The one and only user of this in-kernel API - the skcipher
> implementations PAES in paes_s390.c set this flag upon request
> to derive a protected key from the given raw key material.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

Looks good now, thx!

> ---
>  arch/s390/crypto/paes_s390.c   | 6 +++---
>  arch/s390/include/asm/pkey.h   | 5 ++++-
>  drivers/s390/crypto/pkey_api.c | 3 +--
>  3 files changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/crypto/paes_s390.c b/arch/s390/crypto/paes_s390.c
> index 511093713a6f..1f62a9460405 100644
> --- a/arch/s390/crypto/paes_s390.c
> +++ b/arch/s390/crypto/paes_s390.c
> @@ -182,14 +182,14 @@ static inline int __paes_keyblob2pkey(const u8 *key, unsigned int keylen,
>  {
>  	int i, rc = -EIO;
>  
> -	/* try three times in case of busy card */
> +	/* try three times in case of busy card or no mem */
>  	for (i = 0; rc && i < 3; i++) {
> -		if (rc == -EBUSY && in_task()) {
> +		if ((rc == -EBUSY || rc == -ENOMEM) && in_task()) {
>  			if (msleep_interruptible(1000))
>  				return -EINTR;
>  		}
>  		rc = pkey_key2protkey(key, keylen, pk->protkey, &pk->len,
> -				      &pk->type);
> +				      &pk->type, PKEY_XFLAG_NOMEMALLOC);
>  	}
>  
>  	return rc;
> diff --git a/arch/s390/include/asm/pkey.h b/arch/s390/include/asm/pkey.h
> index a709a72be79a..c0e7f8c25e9f 100644
> --- a/arch/s390/include/asm/pkey.h
> +++ b/arch/s390/include/asm/pkey.h
> @@ -20,10 +20,13 @@
>   * @param key pointer to a buffer containing the key blob
>   * @param keylen size of the key blob in bytes
>   * @param protkey pointer to buffer receiving the protected key
> + * @param xflags additional execution flags (see PKEY_XFLAG_* definitions below)
> + *        As of now the only supported flag is PKEY_XFLAG_NOMEMALLOC.
>   * @return 0 on success, negative errno value on failure
>   */
>  int pkey_key2protkey(const u8 *key, u32 keylen,
> -		     u8 *protkey, u32 *protkeylen, u32 *protkeytype);
> +		     u8 *protkey, u32 *protkeylen, u32 *protkeytype,
> +		     u32 xflags);
>  
>  /*
>   * If this flag is given in the xflags parameter, the pkey implementation
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 55a4e70b866b..cef60770f68b 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -53,10 +53,9 @@ static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
>   * In-Kernel function: Transform a key blob (of any type) into a protected key
>   */
>  int pkey_key2protkey(const u8 *key, u32 keylen,
> -		     u8 *protkey, u32 *protkeylen, u32 *protkeytype)
> +		     u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags)
>  {
>  	int rc;
> -	const u32 xflags = 0;
>  
>  	rc = key2protkey(NULL, 0, key, keylen,
>  			 protkey, protkeylen, protkeytype, xflags);

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

