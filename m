Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27BE1221FA2
	for <linux-s390@vger.kernel.org>; Fri, 11 Apr 2025 12:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744375263; cv=none; b=tQ0+RCACyAEz1+9vUWjFGHuxwtNgWZsNYaTlKSVMYN0AMFea7lkWoE0kp8MCs6bf2XKxCnLkoUXoYt6OLzCVhNbFFKYb6Sj6H3GdqKENz7u1x/7aFV6CHX10PR0BB7J4SHZe2VEmjw22q2NqeQpCqh6F1l/na4wINnTDTD8q6fM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744375263; c=relaxed/simple;
	bh=WldTpNU3f9l6jvNwSXu1AVr6vv1j1z5BvLSmMbSCWF0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eRXvpRJtq8OVOEUv7AuqD3eJuQPgVZR/TpZOkshpUq2vuP3jB3oA2Ya95spXqByxV5vNREl3WnJGWZdW/sRbvjPaO4KhT5P6z/6ofqosUv1UNmH/43YgFpFkK59WS5wNS+EJa18i3SAJoBvUX5dZooicEjHqpowqeKy+PpdMvsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hB3HzH4B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hB3HzH4B"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53B5F3h4029130;
	Fri, 11 Apr 2025 12:40:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=rGydna
	gedegEpdzlemuIGh5zG4yq+/3XsP0WisTBx0A=; b=hB3HzH4BrU+Q6E+8+tHixt
	7/F7Do5r/4oqxNCSCQw70gkvxpjRssxtSWVmtBH+1O6zHDyNKN//7Wm5xw6xzaNW
	DUgCskmgZBVRj4iONjGyFYdFzcM3CnEVa5HMg8ZuFDFA5D3//EBkFJbrpi+3f8w3
	CXimlh2dRO/ZQ0aM7fzB/MyJMdcsNf3N+LqZcgiG6qhr/aHnHiGkbMIKFcQEk1N3
	gwyrE1h86RVbDmcMlHJkqmgIL4tb3VfzWuFreY6KCsJjEXTWy6be22873KPXRxeu
	xLJrHokODX3mwI+0bHVUfiHdIROCHJ4BiOvRAkoLG2vBsbyCKGc+OEE+wHsbHABw
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45xj5xmhbg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 12:40:58 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53BAQFZm025522;
	Fri, 11 Apr 2025 12:40:58 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45ugbmaxc6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Apr 2025 12:40:58 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53BCes9G12452154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Apr 2025 12:40:54 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1DCF620043;
	Fri, 11 Apr 2025 12:40:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 705AF20040;
	Fri, 11 Apr 2025 12:40:53 +0000 (GMT)
Received: from [9.171.54.209] (unknown [9.171.54.209])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Apr 2025 12:40:53 +0000 (GMT)
Message-ID: <53b1ca15-e679-4e62-bf3e-50ff2b62d484@linux.ibm.com>
Date: Fri, 11 Apr 2025 14:40:51 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/24] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-7-freude@linux.ibm.com>
Content-Language: de-DE
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <20250409140305.58900-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: FJphcZ2efDHnkx-EZiKyI0tv76uBH9LD
X-Proofpoint-ORIG-GUID: FJphcZ2efDHnkx-EZiKyI0tv76uBH9LD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-11_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0 mlxscore=0
 suspectscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504110080

On 09/04/2025 16:02, Harald Freudenberger wrote:
> Introduce a new module parameter "zcrypt_mempool_threshold"
> for the zcrypt module. This parameter controls the minimal
> amount of mempool items which are pre-allocated for urgent
> requests/replies and will be used with the support for the
> new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
> shall provide enough memory items to support up to 5 requests
> (and their associated reply) in parallel. The minimum value
> is 1 and is checked and maybe adjusted in the module init().
> 
> If the mempool is depleted upon one cca misc functions is called
> with the named xflag set, the function will fail with -ENOMEM
> and the caller is responsible for taking further actions.
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

See my comment below. With these fixed you can keep my R-b.

> ---
>  drivers/s390/crypto/zcrypt_api.c     |  16 +++-
>  drivers/s390/crypto/zcrypt_api.h     |   2 +
>  drivers/s390/crypto/zcrypt_ccamisc.c | 116 ++++++++++++++++++++-------
>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>  4 files changed, 104 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_api.c b/drivers/s390/crypto/zcrypt_api.c
> index f753c0403a18..888ab289bd10 100644
> --- a/drivers/s390/crypto/zcrypt_api.c
> +++ b/drivers/s390/crypto/zcrypt_api.c
> @@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor interface, " \
>  		   "Copyright IBM Corp. 2001, 2012");
>  MODULE_LICENSE("GPL");
>  
> +unsigned int zcrypt_mempool_threshold = 5;
> +module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 0440);
> +MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply mempool minimal items.");

Maybe you can mention the minimum value here as well?

"CCA and EP11 request/reply mempool minimal items (min: 1)."

> +
>  /*
>   * zcrypt tracepoint functions
>   */
> @@ -2147,13 +2151,20 @@ int __init zcrypt_api_init(void)
>  {
>  	int rc;
>  
> +	/* make sure the mempool threshold is >= 1 */
> +	zcrypt_mempool_threshold = max_t(unsigned int, zcrypt_mempool_threshold, 1);
> +

BTW: As far as I can see, mempool allows 0 as minimal preallocated elements. The result will be a mempool without any pre-allocated elements. This means, no NOMEMALLOC request could be processed. This is sad, but it is not really an error.

Anyhow, if you would limit the mempool to at least 1 element, a threshold value < 1 is an error and should be treated as such. So, do not silently fix the value, but printout an error message and return with -EINVAL here.

>  	rc = zcrypt_debug_init();
>  	if (rc)
>  		goto out;
>  
>  	rc = zcdn_init();
>  	if (rc)
> -		goto out;
> +		goto out_zcdn_init_failed;
> +
> +	rc = zcrypt_ccamisc_init();
> +	if (rc)
> +		goto out_ccamisc_init_failed;
>  
>  	/* Register the request sprayer. */
>  	rc = misc_register(&zcrypt_misc_device);
[...]
> diff --git a/drivers/s390/crypto/zcrypt_api.h b/drivers/s390/crypto/zcrypt_api.h
> index 94dffb01942f..84d636fd14a4 100644
> --- a/drivers/s390/crypto/zcrypt_api.h
> +++ b/drivers/s390/crypto/zcrypt_api.h
[...]
> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
> index 521baaea06ff..05085b40a55c 100644
> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
[...]

> @@ -229,7 +241,16 @@ static int alloc_and_prep_cprbmem(size_t paramblen,
>  	 * allocate consecutive memory for request CPRB, request param
>  	 * block, reply CPRB and reply param block
>  	 */
> -	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> +		size_t len = 2 * cprbplusparamblen;
> +
> +		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {

Remove the check for cprb_mempool != NULL. This case can never happen.

> +			cprbmem = mempool_alloc_preallocated(cprb_mempool);
> +			memset(cprbmem, 0, len);

Check for cprbmem != NULL before memset(), or move the memset() down.

> +		}
> +	} else {
> +		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);

Use kmalloc here and ...

> +	}
>  	if (!cprbmem)
>  		return -ENOMEM;

... wait until cprbmem is always valid and do the memset() here.

if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
	size_t len = 2 * cprbplusparamblen;

	if (len <= CPRB_MEMPOOL_ITEM_SIZE)
		cprbmem = mempool_alloc_preallocated(cprb_mempool);
} else {
	cprbmem = kmalloc(2 * cprbplusparamblen, GFP_KERNEL);
}
if (!cprbmem)
	return -ENOMEM;
memset(cprbmem, 0, len);

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

