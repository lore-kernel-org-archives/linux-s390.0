Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76FF4274FD0
	for <linux-s390@vger.kernel.org>; Mon, 14 Apr 2025 14:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744640486; cv=none; b=mkwBQUZTIXepEDQMlPRbewVnoKJqGxE/Agj+gQSehtW15iKGAhfSyx7JYaub6NOEe4KzODnNHDEENUUpQBGMKB35K9t+dFAJd81olwOre+XB9dXgAHU2ykWKLxrX3dieXvbkW4qTEwVtE6EWfFxCrB55scqPLPlEM8I/UF7DB2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744640486; c=relaxed/simple;
	bh=C4LPi02nU13J8nH/30pe/cS4bAkLEmYui2/jYimdlU8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XJ1tgRVGoBM7mKbunXN2rWTIOavEmZrTLLqRbAQgjxXLwsgRSRLTRxaKphr78H+Li8gFBLa5iRJOgqqneC6xVl2JSjYBhqEy53/sAhBbdBRggXU9dnL4x8BTSNSIddJETnEc3g6/ffFuQcjQ1awtX1oY97Hs03No23966USkD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HqH+ShRk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HqH+ShRk"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53EAg0Ms032268;
	Mon, 14 Apr 2025 14:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=K6Q+eeBsDGJV0brb+d9PckILrLZaL8lqgmZfyW7QhJA=; b=HqH+ShRkh0zv
	S6aGFM21LRsytgj4I7F/Z6Fp/SWr3PEryXS41pSFR7OyehfrX+tyGnM9fwILw4EZ
	zl5RU2yDEm5LgR+F/4jIQSjVlEqdaSWmvGrV4lM8AT2tyFSx9nmuUG2ngNM33kzT
	r4i+HRwSGssKJ16OOcgfngxF7Hk+iuRDTP0JVFK+LP4zYwsHzPo0F1m17I9TK+Xq
	TOldySaoeWz+a68++yN1dJr6YA+0crj7Ihq3O3EWCNQeLJ3M5UJ6odj4oAx7OuJ5
	XCMTvMv6/6aqX0gPzhi4b6FSfsicaTx3PlCO2gRV0D7HK0kPLKu2SEZrdB6DT9kp
	P9heDzh9Zw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 460ndsumwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:21:20 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 53EBTmt1001272;
	Mon, 14 Apr 2025 14:21:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4602vyprht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Apr 2025 14:21:20 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 53EELIVE20644394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Apr 2025 14:21:19 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E02AB5805D;
	Mon, 14 Apr 2025 14:21:18 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E55D45805A;
	Mon, 14 Apr 2025 14:21:17 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Apr 2025 14:21:17 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 14 Apr 2025 16:21:17 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, seiden@linux.ibm.com,
        borntraeger@linux.ibm.com, frankja@linux.ibm.com,
        imbrenda@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v4 07/24] s390/zcrypt: Introduce cprb mempool for ep11
 misc functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <e5124c6a-ba9d-45d5-9d7c-d6f14f1338af@linux.ibm.com>
References: <20250409140305.58900-1-freude@linux.ibm.com>
 <20250409140305.58900-8-freude@linux.ibm.com>
 <e5124c6a-ba9d-45d5-9d7c-d6f14f1338af@linux.ibm.com>
Message-ID: <6484bd8b9fd5fd540e54d4aa4e70f1b8@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sMsePsNsj7CXmtwX_6Z7Cd4UrKz0BPAF
X-Proofpoint-ORIG-GUID: sMsePsNsj7CXmtwX_6Z7Cd4UrKz0BPAF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-14_04,2025-04-10_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 mlxscore=0 malwarescore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 spamscore=0 adultscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504140102

On 2025-04-11 14:58, Holger Dengler wrote:
> On 09/04/2025 16:02, Harald Freudenberger wrote:
>> Introduce a cprb mempool for the zcrypt ep11 misc functions
>> (zcrypt_ep11misc.*) do some preparation rework to support
>> a do-not-allocate path through some zcrypt ep11 misc functions.
>> 
>> The mempool is controlled by the zcrypt module parameter
>> "mempool_threshold" which shall control the minimal amount
>> of memory items for CCA and EP11.
>> 
>> The mempool shall support "mempool_threshold" requests/replies
>> in parallel which means for EP11 to hold a send and receive
>> buffer memory per request. Each of this cprb space items is
>> limited to 8 KB. So by default the mempool consumes
>>   5 * 2 * 8KB = 80KB
>> 
>> If the mempool is depleted upon one ep11 misc functions is
>> called with the ZCRYPT_XFLAG_NOMEMALLOC xflag set, the function
>> will fail with -ENOMEM and the caller is responsible for taking
>> further actions.
>> 
>> This is only part of an rework to support a new xflag
>> ZCRYPT_XFLAG_NOMEMALLOC but not yet complete.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the requested changes below, you can keep my R-b.
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c      |   6 +
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 153 
>> ++++++++++++++++----------
>>  drivers/s390/crypto/zcrypt_ep11misc.h |   1 +
>>  3 files changed, 99 insertions(+), 61 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index b60e262bcaa3..00e9d141a456 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
> [...]
>> @@ -411,12 +420,19 @@ EXPORT_SYMBOL(ep11_check_aes_key);
>>  /*
>>   * Allocate and prepare ep11 cprb plus additional payload.
>>   */
>> -static inline struct ep11_cprb *alloc_cprb(size_t payload_len)
>> +static void *alloc_cprbmem(size_t payload_len, u32 xflags)
>>  {
>>  	size_t len = sizeof(struct ep11_cprb) + payload_len;
>> -	struct ep11_cprb *cprb;
>> +	struct ep11_cprb *cprb = NULL;
>> 
>> -	cprb = kzalloc(len, GFP_KERNEL);
>> +	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>> +		if (cprb_mempool && len <= CPRB_MEMPOOL_ITEM_SIZE) {
>> +			cprb = mempool_alloc_preallocated(cprb_mempool);
>> +			memset(cprb, 0, len);
>> +		}
>> +	} else {
>> +		cprb = kzalloc(len, GFP_KERNEL);
>> +	}
>>  	if (!cprb)
>>  		return NULL;
> 
> Same as in the previous patch:
> - no check for cprb_mempool != NULL
> - use kmalloc()
> - move memset() down
> 
> [...]

Done
