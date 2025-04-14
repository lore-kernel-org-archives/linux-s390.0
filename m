Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8096523D2AA
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640247; cv=none; b=hXdBm5q82hCsK1geXReEI0+mMl+TtGohz1l5+RPxDsxExL5jT+kK4aI5XDpzTYuMUkVHAgDvC+pzAxGCXJezGOx5CwlsPumuW1WHlomsa+mVA3HxJBo5Y4WBBc9BuQN3Iom+zdiIl4bdZGXx+D85MHBkThk6TiP/EFftj3C3DQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640247; c=relaxed/simple;
	bh=iz3dn5z9remWKd6Nj96Z5BQR4jzykuZrNHcb8CE4PUY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=KsEBLWPOYm6u7V/0wFwZrOcWgakqzMQwZWc8OYtR3W3jIKgZoLKWdOEOL5OmdvYQg/eC3W7J6G60AGo7TPoQnoIA4h5/i6/5MDGWS6VMeBrHtmy1KLEOqqf2Y2n12XkJE1VcA/TOLQVRrUKLd0fWxKWrSoDMuvWLZtAVWDiinrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=T6hV0He+; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="T6hV0He+"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53ECXwBh003355;
	Mon, 14 Apr 2025 14:17:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=V2XpPQBJtW8twm2vFIwz1hYZhMsmA0Cx734nHgsBc1Q=; b=T6hV0He+7g3k
	8rTm6dlf3B5T7PZ8hjz2YeQvrXrXCi6jWzo1yrCYSpDOUGFJ2Weyz+SsYX7mR72P
	ikOiSXYz9oTBnfJtuiFApoOqsf8gA2YgWszRtyozNsi8TM+xNmEYN+EImKVyFdOu
	xncWhCmWZwtaIIZLNkcdZWFgbcDbeV3D05uwzCogscwYaod+Yg433Fakrj/Qn/aV
	svGfRnvWDDrAw5rM0t1JIVTT2MwmvwtfkVIvIrcBugMFriwGr43D7ANTitXXUjOs
	GO0qC15Rn5OtfGo9UMSltdEoicIKxr+ulbaUPKMH7EHAQZO5x7IdGEcVUEBuJDnt
	L5jHzexn0g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460ndsumby-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:17:21 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EDpG33016431;
	Mon, 14 Apr 2025 14:17:21 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 460571x7pu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:17:21 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EEHJxT30409356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:17:19 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A1DF658052;
	Mon, 14 Apr 2025 14:17:19 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2E7358045;
	Mon, 14 Apr 2025 14:17:18 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:17:18 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:17:18 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 06/24] s390/zcrypt: Introduce cprb mempool for cca misc
 functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <53b1ca15-e679-4e62-bf3e-50ff2b62d484@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-7-freude@linux.ibm.com>
 <53b1ca15-e679-4e62-bf3e-50ff2b62d484@linux.ibm.com>
Message-ID: <75a7e907ab922aacde1231bf63bd64ea@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bi8kmgHNySdcWOjjA2Apv8iNicsgL0Rq
X-Proofpoint-ORIG-GUID: bi8kmgHNySdcWOjjA2Apv8iNicsgL0Rq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140102

On 2025-04-11 14:40, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Introduce a new module parameter "zcrypt_mempool_threshold"
>> for the zcrypt module. This parameter controls the minimal
>> amount of mempool items which are pre-allocated for urgent
>> requests/replies and will be used with the support for the
>> new xflag ZCRYPT_XFLAG_NOMEMALLOC. The default value of 5
>> shall provide enough memory items to support up to 5 requests
>> (and their associated reply) in parallel. The minimum value
>> is 1 and is checked and maybe adjusted in the module init().
>> 
>> If the mempool is depleted upon one cca misc functions is called
>> with the named xflag set, the function will fail with -ENOMEM
>> and the caller is responsible for taking further actions.
>> 
>> For CCA each mempool item is 16KB, as a CCA CPRB needs to
>> hold the request and the reply. The pool items only support
>> requests/replies with a limit of about 8KB.
>> So by default the CCA mempool consumes
>>   5 * 16KB = 80KB
>> 
>> This is only part of an rework to support a new xflag
>> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
> See my comment below. With these fixed you can keep my R-b.
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c     |  16 +++-
>>  drivers/s390/crypto/zcrypt_api.h     |   2 +
>>  drivers/s390/crypto/zcrypt_ccamisc.c | 116 
>> ++++++++++++++++++++-------
>>  drivers/s390/crypto/zcrypt_ccamisc.h |   1 +
>>  4 files changed, 104 insertions(+), 31 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>> b/drivers/s390/crypto/zcrypt_api.c
>> index f753c0403a18..888ab289bd10 100644
>> --- a/drivers/s390/crypto/zcrypt_api.c
>> +++ b/drivers/s390/crypto/zcrypt_api.c
>> @@ -50,6 +50,10 @@ MODULE_DESCRIPTION("Cryptographic Coprocessor 
>> interface, " \
>>  		   "Copyright IBM Corp. 2001, 2012");
>>  MODULE_LICENSE("GPL");
>> 
>> +unsigned int zcrypt_mempool_threshold = 5;
>> +module_param_named(mempool_threshold, zcrypt_mempool_threshold, uint, 
>> 0440);
>> +MODULE_PARM_DESC(mempool_threshold, "CCA and EP11 request/reply 
>> mempool minimal items.");
> 
> Maybe you can mention the minimum value here as well?
> 
> "CCA and EP11 request/reply mempool minimal items (min: 1)."

Done

> 
>> +
>>  /*
>>   * zcrypt tracepoint functions
>>   */
>> @@ -2147,13 +2151,20 @@ int __init zcrypt_api_init(void)
>>  {
>>  	int rc;
>> 
>> +	/* make sure the mempool threshold is >= 1 */
>> +	zcrypt_mempool_threshold = max_t(unsigned int, 
>> zcrypt_mempool_threshold, 1);
>> +
> 
> BTW: As far as I can see, mempool allows 0 as minimal preallocated
> elements. The result will be a mempool without any pre-allocated
> elements. This means, no NOMEMALLOC request could be processed. This
> is sad, but it is not really an error.
> 
> Anyhow, if you would limit the mempool to at least 1 element, a
> threshold value < 1 is an error and should be treated as such. So, do
> not silently fix the value, but printout an error message and return
> with -EINVAL here.
> 
>>  	rc = zcrypt_debug_init();
>>  	if (rc)
>>  		goto out;
>> 
>>  	rc = zcdn_init();
>>  	if (rc)
>> -		goto out;
>> +		goto out_zcdn_init_failed;
>> +
>> +	rc = zcrypt_ccamisc_init();
>> +	if (rc)
>> +		goto out_ccamisc_init_failed;
>> 
>>  	/* Register the request sprayer. */
>>  	rc = misc_register(&zcrypt_misc_device);
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_api.h 
>> b/drivers/s390/crypto/zcrypt_api.h
>> index 94dffb01942f..84d636fd14a4 100644
>> --- a/drivers/s390/crypto/zcrypt_api.h
>> +++ b/drivers/s390/crypto/zcrypt_api.h
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 521baaea06ff..05085b40a55c 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
> [...]
> 
>> @@ -229,7 +241,16 @@ static int alloc_and_prep_cprbmem(size_t 
>> paramblen,
>>  	 * allocate consecutive memory for request CPRB, request param
>>  	 * block, reply CPRB and reply param block
>>  	 */
>> -	cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
>> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>> +		size_t len = 2 * cprbplusparamblen;
>> +
>> +		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
> 
> Remove the check for cprb_mempool != NULL. This case can never happen.
> 
>> +			cprbmem = mempool_alloc_preallocated(cprb_mempool);
>> +			memset(cprbmem, 0, len);
> 
> Check for cprbmem != NULL before memset(), or move the memset() down.
> 
>> +		}
>> +	} else {
>> +		cprbmem = kcalloc(2, cprbplusparamblen, GFP_KERNEL);
> 
> Use kmalloc here and ...
> 
>> +	}
>>  	if (!cprbmem)
>>  		return -ENOMEM;
> 
> ... wait until cprbmem is always valid and do the memset() here.
> 
> if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
> 	size_t len = 2 * cprbplusparamblen;
> 
> 	if (len <= CPRB_MEMPOOL_ITEM_SIZE)
> 		cprbmem = mempool_alloc_preallocated(cprb_mempool);
> } else {
> 	cprbmem = kmalloc(2 * cprbplusparamblen, GFP_KERNEL);
> }
> if (!cprbmem)
> 	return -ENOMEM;
> memset(cprbmem, 0, len);
> 
> [...]

Hm, not clear what exactly you mean. I changed the code to:

{
	u8 *cprbmem = NULL;
	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
	size_t len = 2 * cprbplusparamblen;
	struct CPRBX *preqcblk, *prepcblk;

	/*
	 * allocate consecutive memory for request CPRB, request param
	 * block, reply CPRB and reply param block
	 */
	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
			cprbmem = mempool_alloc_preallocated(cprb_mempool);
	} else {
		cprbmem = kmalloc(len, GFP_KERNEL);
	}
	if (!cprbmem)
		return -ENOMEM;
	memset(cprbmem, 0, len);
         ...
