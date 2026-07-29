Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F04048EBF3;
	Wed, 29 Jul 2026 13:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785333373; cv=none; b=uylEcTj/Q3hsAXAwS52erdwqnWbC7VkbD961wtytkTiYg74bAIEJK8v2qzrw7B8C3JV1miSz3IHTIjten0PHfCJwZyLfPOwWRmqjGbuoh12TvqsQJjWNXWY0oMi1cQo94hACRKsPfARAAsJXHjMPUhsm8hrtm8J8HqEYe2+YN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785333373; c=relaxed/simple;
	bh=OFNaDfGXuE2SjCJFbT2ZuwBj/PNM3C9WGm7aQ1l/j0E=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=aZguk6SOKG73yzs+Vze3f1Na6FFNRo1WLqYmxcM4B1dwgf9CUicvbIIVZxlW79KzKqEaOCOo4dMqduFoJ00sCBJt+4OSaWxbNlr+SjnbY00NH6R8L5LECgQ42MAIZOz4AAPsekEtb1OCbIsHRFLbDXLSpdCKhEu0t4uvUTaSeTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=HWJQDmHj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="HWJQDmHj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TDHl3e2423272;
	Wed, 29 Jul 2026 13:56:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=X91w/z0ngyb5XEaWwERgRQ7I0zmHWL8A6OzZ3ixSwnE=; b=HWJQDmHjYx2k
	IRqTehkAWWETYIsE6G6sCd8hVcaj6F8EkBHSTpH8GCElAlRgntJgfXTmXSrVVuF5
	itQoH4PecgQqWzOEZdaY3hPCPniAPqGRm74KwivMHR1SJBLB2wBrWKTVvZncUM3t
	msV087eDCd5tmzeKP5mSNjFwXU+dn2Ay9MB9AAzW6/0KnV3x+bNFMOlhuJRspgOU
	mN3EyYt3otE5A0S9tZA/bZskwMaiPe2VF2fS03Zr0z0Pwbm7S0qyTc4sK4TFCGNH
	Q3P0t+MKKYAo1YaUQvnLvQ9+1Wjg00grJ4Rnq5QKqMWphvJUN1V1ozqGqMWPUZJV
	kNffCVMigQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuycjxdk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:56:05 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TDfp0L008354;
	Wed, 29 Jul 2026 13:56:04 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fqf4pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 13:56:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TDu44X61669856
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 13:56:04 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0421B58059;
	Wed, 29 Jul 2026 13:56:04 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AAE4658055;
	Wed, 29 Jul 2026 13:56:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 13:56:03 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 15:56:03 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: Re: [PATCH v7 1/5] s390/zcrypt: Fix CPRB memory allocation in zcrypt
 misc code
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729101556.13D0C1F00A3D@smtp.kernel.org>
References: <20260729095318.184141-1-freude@linux.ibm.com>
 <20260729095318.184141-2-freude@linux.ibm.com>
 <20260729101556.13D0C1F00A3D@smtp.kernel.org>
Message-ID: <50ffffcd67f91849c13efce80f316022@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: B96r9u7bz9TsjA3OSCtzxEqqALBInH2D
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfX4ZG2FRxx17w9
 IwWXbDNknrr96js5ALYr3N4XxaGfMOl4PA/K0v3ZOF6q/MQAy3rBVENZJpmvJ0qyFRkmzEgVFCM
 RIRhH0a7YOO/UySc2x8k+lXlBlJnVpanT/mJMwURxwP8P0gzgzTphBvvqnfWQpgmslyoHRzjghT
 lVcn9g27cKPADb8+vaBWEgdNhaOGEevct+kMxcYXFJ4PCiEfyp2bev7RLGKXim0oUyJngzWiRsC
 a9qX92Hg8mFexcVJwZ+Mlr3qUqmPtzueG9z+PDcqlbDR3e06HgVge9Uf0QAGVLYdyegajOUdjLl
 Jk2i9BZAs3eH14LPdEys+6j1Ii+a7RgeGSs1XEZI51tiIhCS+Wuiw2+195zGKLYRjU27U3Z93iJ
 ld4k+5MRx8sMkHPAcY8gK3v5KiP2O1+6xIHmVJsxc/RsoY66I02scQ6c7p+L1E7U1CY7k1hip1m
 XrEFhDl1hl94+pORfTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDExNCBTYWx0ZWRfXyN/XLcNF0x1v
 I/GmFUvrOv+XFaDQ079/2PhVVoAbK6XS9HHRlNAtKGspcXxO3nFHRpXsa+b9TIqvFmKCXhlSGA1
 34DEH7AdJ162n290b7GaALsO0A+jMGU=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a6a0675 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=DKHooPl4vFUTZQatxCIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: B96r9u7bz9TsjA3OSCtzxEqqALBInH2D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_05,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290114

On 2026-07-29 12:15, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 3 potential
> issue(s) to consider:
> 
> New issues:
> - [Medium] Incomplete memory scrubbing in CPRB free functions leaves
> padding bytes unzeroed.
> 
> Pre-existing issues:
> - [High] Information leak of uninitialized kernel heap memory to AP
> hardware due to unpadded EP11 request lengths.
> - [High] Incomplete fix in EP11 CPRB memory allocation causes valid
> 4-byte padded hardware replies to be rejected with -EMSGSIZE.
> --
> 
> --- Patch [1]: [PATCH v7 1/5] s390/zcrypt: Fix CPRB memory allocation
> in zcrypt misc code ---
> commit cba05c09d2194f550fb91ddbd8234cd389b1848a
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix CPRB memory allocation in zcrypt misc code
> 
> This commit rounds up the memory allocation for CPRB structures to a
> multiple of 4 bytes. It ensures the base CPRB and parameter block are
> aligned to a 4-byte boundary, which is required by the zcrypt layer.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c 
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index 84936a795b956..0aa72593ae2bd 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
>> @@ -231,6 +232,10 @@ EXPORT_SYMBOL(cca_check_sececckeytoken);
>>   * block, reply CPRB and reply param block and fill in values
>>   * for the common fields. Returns 0 on success or errno value
>>   * on failure.
>> + * It is guaranteed that request and a possible param block
>> + * are aligned to a 4 byte boundary. Furthermore if a param
>> + * block is used, the memory allocated for this is rounded up to
>> + * the next multiple of 4 bytes.
>>   */
>>  static int alloc_and_prep_cprbmem(size_t paramblen,
>>  				  u8 **p_cprb_mem,
>> @@ -239,7 +244,8 @@ static int alloc_and_prep_cprbmem(size_t 
>> paramblen,
>>  				  u32 xflags)
>>  {
>>  	u8 *cprbmem = NULL;
>> -	size_t cprbplusparamblen = sizeof(struct CPRBX) + paramblen;
>> +	size_t cprbplusparamblen =
>> +		ALIGN(sizeof(struct CPRBX), 4) + ALIGN(paramblen, 4);
> 
> [Severity: Medium]
> If the allocation size is rounded up here, do the corresponding
> free_cprbmem() functions need to be updated to clear the padded size?
> 
> For example, in drivers/s390/crypto/zcrypt_ccamisc.c:free_cprbmem():
> 
>     memzero_explicit(mem, 2 * (sizeof(struct CPRBX) + paramblen));
> 
> And in drivers/s390/crypto/zcrypt_ep11misc.c:free_cprbmem():
> 
>     memzero_explicit(mem, sizeof(struct ep11_cprb) + payload_len);
> 
> Currently they use the unpadded lengths. Can this leave the padding 
> bytes
> unzeroed when freed, potentially leaking sensitive hardware response 
> data
> that spills into the padding?

Valid and will be addressed with version 8 of this patch series.

> 
> [ ... ]
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index 3dda9589f2b95..e604c100ccce2 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
>> @@ -355,21 +356,24 @@ EXPORT_SYMBOL(ep11_check_aes_key);
>> 
>>  /*
>>   * Allocate and prepare ep11 cprb plus additional payload.
>> + * It is guaranteed that the memory is aligned to a 4 byte boundary.
>> + * Furthermore the memory allocation is rounded up to the next
>> + * multiple of 4 bytes (with taking the payload_len into account).
>>   */
>>  static void *alloc_cprbmem(size_t payload_len, u32 xflags)
>>  {
>> -	size_t len = sizeof(struct ep11_cprb) + payload_len;
>> +	size_t memlen = ALIGN(sizeof(struct ep11_cprb) + payload_len, 4);
>>  	struct ep11_cprb *cprb = NULL;
>> 
>>  	if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>> -		if (len <= CPRB_MEMPOOL_ITEM_SIZE)
>> +		if (memlen <= CPRB_MEMPOOL_ITEM_SIZE)
>>  			cprb = mempool_alloc_preallocated(cprb_mempool);
>>  	} else {
>> -		cprb = kmalloc(len, GFP_KERNEL);
>> +		cprb = kmalloc(memlen, GFP_KERNEL);
>>  	}
>>  	if (!cprb)
>>  		return NULL;
>> -	memset(cprb, 0, len);
>> +	memset(cprb, 0, memlen);
> 
> [Severity: High]
> This is a pre-existing issue, but since we are aligning EP11 lengths, 
> does
> the AP message creation leak uninitialized kernel memory?
> 
> In 
> drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx(),
> the message length is rounded up:
> 
>     ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
> 
> But only the unpadded length is copied into the buffer:
> 
>     if (z_copy_from_user(userspace, msg->userdata, (char __force
> __user *)xcrb->req, xcrb->req_len))
> 
> Since drivers/s390/crypto/ap_bus.c:ap_init_apmsg() allocates the buffer
> without __GFP_ZERO:
> 
>     ap_msg->msg = kmalloc(maxmsgsize, GFP_KERNEL);
> 
> Can the padding gap between xcrb->req_len and CEIL4(xcrb->req_len) leak 
> up
> to 3 bytes of uninitialized kernel heap memory to the AP hardware?
> 

Addressed with patch #5 of this series.

> 
> [Severity: High]
> This is a pre-existing issue, but does aligning the memory allocation
> resolve the EMSGSIZE failures if prep_urb() still uses the unpadded 
> length?
> 
> In drivers/s390/crypto/zcrypt_ep11misc.c:prep_urb(), the unpadded 
> length
> is passed:
> 
>     u->resp_len = rep_len;
> 
> When the hardware replies with a 4-byte padded length,
> convert_type86_ep11_xcrb() in drivers/s390/crypto/zcrypt_msgtype6.c
> checks it against the unpadded resp_len:
> 
>     if (xcrb->resp_len < msg->fmt2.count1) {
>         pr_debug("resp_len %u < required %u => EMSGSIZE\n",
>                  (unsigned int)xcrb->resp_len, msg->fmt2.count1);
>         return -EMSGSIZE;
>     }
> 
> Does this cause valid padded hardware replies to be rejected with
> -EMSGSIZE for unaligned requests?
> 
>> 
>>  	cprb->cprb_len = sizeof(struct ep11_cprb);
>>  	cprb->cprb_ver_id = 0x04;

This may be valid but will eventually be covered with another patch 
outside of this series.
