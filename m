Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 397E42472AF
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 13:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744637702; cv=none; b=kWs5ni+bQnCQLYSEGHmoQOmYjgmrQfw+VIu05fsB1rhhuYMGd2ExZaPViuKe1Y9uP2UKPDcq/P/vDvKiE/T1nZV8piO0Tb+QsLvPq06ForpRu5z5hNHeHVBn32oKxAJW8BGmtbSS0XqnJ3q0nnAPFl/wdy2vKqS+qr+yJMrQrD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744637702; c=relaxed/simple;
	bh=6hEeM+uXbNNAYErZLw7nj4/mrtb5DDlX5G3Q8AhYwHA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uDdBGG6tS0qDHeSUDG1gSaZVxP6FRH4InDfcq+gW6ckJ/qvDMQkP2c1ySlR+COojuWAHOuyAOjGQdnCK93a/uc15jPpfIogdxUfXjK4x5asqCGhnkY7JS55j9q3l1ZiP6b1QgIh7oMJsfCCm1Rvkj4c6Cthhs3n7WrWJNgXWU1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fNGouoEM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fNGouoEM"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECEaxI030941;
	Mon, 14 Apr 2025 13:34:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bgNAB5
	yAQ62B+jdqq/JUDlggNypVT7VhjqkUAoBglws=; b=fNGouoEMrt6LdY5ObAzIxB
	2Rw/twjZhB4gXkvQzM2aNbBiyVKKkATEoY3lcdYmiEZUNptKnfk5LSFofyCdcX3Y
	OvWQkPDqbDpBwRLgz09GFm6c1RTmHrAVsYzZTMrIfC9XV4KK/EK4+i+Y9yisisve
	kgVnqRZUNT3iFfCe3lsMzNKSjN7CWgpIGl1eCeU5UZzJbIcgPfivOaoT2wVl78Oe
	/j/Gpbz50ueh6PVNGjzAsBY4G5uu7VQwP8UYFYGov8M33om9steJnwQ2I1fymZBo
	5g7lvDrX6rtgqbIiwArWVPQ0vKysYMVQ41SThy0hh8vQYhA0UJvmVrel+kfUYloA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460nc4bhsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 13:34:58 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53E9cBxu010387;
	Mon, 14 Apr 2025 13:34:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4604qjx4dm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 13:34:57 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EDYrPG50659758
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 13:34:53 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B1D912004B;
	Mon, 14 Apr 2025 13:34:53 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E90E20040;
	Mon, 14 Apr 2025 13:34:53 +0000 (GMT)
Received: from [9.171.15.155] (unknown [9.171.15.155])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 13:34:53 +0000 (GMT)
Message-ID: <c3eee1ca-78ab-4e72-bf6a-f98e2a74b9f6@linux.ibm.com>
Date: Mon, 14 Apr 2025 15:34:53 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 24/24] s390/pkey/crypto: Introduce xflags param for
 pkey in-kernel API
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-25-freude@linux.ibm.com>
Content-Language: en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-25-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: BWPphF3sk-a8hmqsV0lWEPTscuL_PBhx
X-Proofpoint-ORIG-GUID: BWPphF3sk-a8hmqsV0lWEPTscuL_PBhx
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 priorityscore=1501 mlxscore=0 spamscore=0 adultscore=0 mlxlogscore=999
 phishscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140098

On 09/04/2025 16:03, Harald Freudenberger wrote:
> Add a new parameter xflags to the in-kernel API function
> pkey_key2protkey(). Currently there is only one flag supported:
> 
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

See one last comment below.
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> ---
>  arch/s390/crypto/paes_s390.c   |  6 +++---
>  arch/s390/include/asm/pkey.h   | 15 ++++++++++++++-
>  drivers/s390/crypto/pkey_api.c | 11 +++++++----
>  3 files changed, 24 insertions(+), 8 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
> index 55a4e70b866b..c46b57001550 100644
> --- a/drivers/s390/crypto/pkey_api.c
> +++ b/drivers/s390/crypto/pkey_api.c
> @@ -53,17 +53,20 @@ static int key2protkey(const struct pkey_apqn *apqns, size_t nr_apqns,
>   * In-Kernel function: Transform a key blob (of any type) into a protected key
>   */
>  int pkey_key2protkey(const u8 *key, u32 keylen,
> -		     u8 *protkey, u32 *protkeylen, u32 *protkeytype)
> +		     u8 *protkey, u32 *protkeylen, u32 *protkeytype, u32 xflags)
>  {
> +	u32 flags;
>  	int rc;
> -	const u32 xflags = 0;
> +
> +	/* as of now only the NOMEMALLOC flag is supported */
> +	flags = xflags & PKEY_XFLAG_NOMEMALLOC ? ZCRYPT_XFLAG_NOMEMALLOC : 0;

Please move the mapping of the flags to the implementation of the pkey handlers. The pkey layer should stay independant to any hander implementation and should not know about any of the ZCRYPT_XFLAGs.

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

