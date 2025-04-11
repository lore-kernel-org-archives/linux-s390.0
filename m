Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9372367B8
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 12:58:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744376303; cv=none; b=MjAmvIS1uTLyFM/HlFK7mruC3tKNxoMttycc/kQwas5suh11XPBfPW2biuD+QRqj4jn5mKKmk3jJfG1PlUyAt5YaHnOxHlodwXh9/QBrEOKm1i+ZzmObjbpb/gYm4V9hmS1HkosW71mPZzjkDjW5nwTb22HnNUJDzuOvDt7He3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744376303; c=relaxed/simple;
	bh=f+5T2G8/K4JOYCC8nTEhXbuMxbQIhjOSp7WPgIJCVfA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fV/qEg8WMkl0hz8vkdo8W3nWr/r6DDPb3/pDjoODsRrIAe8KPDdrxXJBYWxEM6KCMSHLA9ILX7DQDOgTLDq/8zIGWqVKTVH7st68YXkBIIJBj0irVABNmY34NL/btLVOuEoV7o1z8sSaD8cWxvcuHh5CTKgMW8+/u+TZD0zSmwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oc5vrpIM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oc5vrpIM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53BCSIwC026344;
	Fri, 11 Apr 2025 12:58:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=74hLzL
	RgiL1xiHKnRchE0VDfX2BS0LaYGtMoVkhohFg=; b=oc5vrpIMpG/PjECv7jETxq
	t77eT3SZSQbc6S8LPa2dP//xgmAii/UMNqWnjqeAFQSTORVhhHwmXqjShyPRfGxR
	B538iQCY/e+4nR5cQcwefxklwvjmOK9xq1IKZizKSARtM12qADowuO4IbiZ111jz
	3LG1m/PFfguoPBnz35Qv0wL49DrZEsNC0zmVzRynL/0lCEIE7Hn47YsAihp4VU5G
	IKhkFJIef+Dgc1LO8elXu1N+4U/cAz7DsYOU67JiQyp1UeVfjtkl1gUqtsYDnlj9
	Z0kKHw05DXbu6vvcT9EEs7iF9k7JylscZTAaVmjSnr25yDl4Jg+pz6hGANzBQxoA
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45y343r5pc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 12:58:18 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAxqpl018567;
	Fri, 11 Apr 2025 12:58:18 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 45uh2m2ux6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 12:58:17 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BCwDkE33686224
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 12:58:14 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D3F6B20040;
	Fri, 11 Apr 2025 12:58:13 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0869420043;
	Fri, 11 Apr 2025 12:58:13 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 12:58:12 +0000 (GMT)
Message-ID: <e5124c6a-ba9d-45d5-9d7c-d6f14f1338af@linux.ibm.com>
Date: Fri, 11 Apr 2025 14:58:11 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/24] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-8-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3i0Fghje0d4iMIOJAnV7Qw-EQ4QvVaxo
X-Proofpoint-ORIG-GUID: 3i0Fghje0d4iMIOJAnV7Qw-EQ4QvVaxo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 clxscore=1015 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110080

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Introduce a cprb mempool for the zcrypt ep11 misc functions
> (zcrypt_ep11misc.*) do some preparation rework to support
> a do-not-allocate path through some zcrypt ep11 misc functions.
> 
> The mempool is controlled by the zcrypt module parameter
> "mempool_threshold" which shall control the minimal amount
> of memory items for CCA and EP11.
> 
> The mempool shall support "mempool_threshold" requests/replies
> in parallel which means for EP11 to hold a send and receive
> buffer memory per request. Each of this cprb space items is
> limited to 8 KB. So by default the mempool consumes
>   5 * 2 * 8KB = 80KB
> 
> If the mempool is depleted upon one ep11 misc functions is
> called with the ZCRYPT_XFLAG_NOMEMALLOC xflag set, the function
> will fail with -ENOMEM and the caller is responsible for taking
> further actions.
> 
> This is only part of an rework to support a new xflag
> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

With the requested changes below, you can keep my R-b.

> ---
>  drivers/s390/crypto/zcrypt_api.c      |   6 +
>  drivers/s390/crypto/zcrypt_ep11misc.c | 153 ++++++++++++++++----------
>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>  3 files changed, 99 insertions(+), 61 deletions(-)
> 
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c b/drivers/s390/crypto/zcrypt_ep11misc.c
> index b60e262bcaa3..00e9d141a456 100644
> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
[...]
> @@ -411,12 +420,19 @@ EXPORT_SYMBOL(ep11_check_aes_key);
>  /*
>   * Allocate and prepare ep11 cprb plus additional payload.
>   */
> -static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
> +static void *alloc_cprbmem(size_t payload_len, u32 xflags)
>  {
>  	size_t len = sizeof(struct ep11_cprb) + payload_len;
> -	struct ep11_cprb *cprb;
> +	struct ep11_cprb *cprb = NULL;
>  
> -	cprb = kzalloc(len, GFP_KERNEL);
> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> +		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
> +			cprb = mempool_alloc_preallocated(cprb_mempool);
> +			memset(cprb, 0, len);
> +		}
> +	} else {
> +		cprb = kzalloc(len, GFP_KERNEL);
> +	}
>  	if (!cprb)
>  		return NULL;

Same as in the previous patch:
- no check for cprb_mempool != NULL
- use kmalloc()
- move memset() down

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

