Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9307B4C80
	for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2025 09:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740475374; cv=none; b=ffpDVSYgROQf/jnYrkTtiJf754VWuNDVJrmFKn+kwphKWvkSRGn+VeESdRPImtvZv00RUeuA4jxjeGbHFZlrcV/dgOQkfHugQ+9Nqfz8fnu7cY9ZzdKmMCvHPeSQIdyDNjsJTWFtUMgzVErEDLE8gUShJJskM463ei3fvT5VEiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740475374; c=relaxed/simple;
	bh=anjeykKA8H5aVOZcqSAcRrofEXltAU7WXEkd7h7l/TA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RlIe/FJi+tMi8bEQySlEhI2WnqTOjPjKDYV7cN0LbGEco4nES+tvRtBfhyFc1Xj9I255kc9vHjXIMB6n+KJqqwH55ZK4g4tf29DslbtYcsE2/jEcEZpjLzG0WM8UhOOgaGJn3MU+QiFCp30xxy1YeiiUmD9d8ft7xU++6d8Lvig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eH7YH0b2; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eH7YH0b2"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P20uZC004027;
	Tue, 25 Feb 2025 09:22:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=Qkdr1g
	Jv9mXd1amMmNCoMVHGNeQOWsjQTQWiTGe0zYg=; b=eH7YH0b2WY9gEACwEUhRjF
	fz9S7gqep+67ceJ39ajFx8wVDvLyjPjkr2RQVVOxhjertL+Ift9fNoF+pX1VBmOD
	KEFatz0/VngIGvj76IBIT9n4D27e29aLNDehFHNCQCEfiebWExMDz++ngr5bEUBV
	MhAlH69IdVf2aS2m2YGxzIInf2Uoe836pE5oV17DskAsD+kr0JNhwUisM5eoA4mL
	dddSSw4ezcppefG/wHE2gzuT3H7Uks2EgKA/dsZstpeC3/5rmDbvGQPQytC+fJiL
	WuQgdwaHVmMz7blrT76VsMkGD+OQyfaa0x3qYByQzZwrZEeuuapiKnlmH9iKoorg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4514q09kc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:22:48 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P7U7bT026961;
	Tue, 25 Feb 2025 09:22:48 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44ytdkbvv1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 09:22:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P9MiPO35652214
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 09:22:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44BC52045A;
	Tue, 25 Feb 2025 09:22:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 014AF20459;
	Tue, 25 Feb 2025 09:22:44 +0000 (GMT)
Received: from [9.171.13.48] (unknown [9.171.13.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 09:22:43 +0000 (GMT)
Message-ID: <36d15c1d-6d69-41b4-9c78-bd77611f98a2@linux.ibm.com>
Date: Tue, 25 Feb 2025 10:22:43 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] s390/ap: Move response_type struct into ap_msg
 struct
To: freude@linux.ibm.com
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-2-freude@linux.ibm.com>
 <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
 <604e9fbfd03fdfa4af7764ba54d8103b@linux.ibm.com>
Content-Language: de-DE, en-US
From: Holger Dengler <dengler@linux.ibm.com>
In-Reply-To: <604e9fbfd03fdfa4af7764ba54d8103b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: M7Y-4Fz0RSk2MGjJbd1x_xFvN3qV6kPj
X-Proofpoint-GUID: M7Y-4Fz0RSk2MGjJbd1x_xFvN3qV6kPj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_03,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 suspectscore=0 mlxscore=0 phishscore=0 bulkscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 malwarescore=0 clxscore=1015
 priorityscore=1501 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250061

On 25/02/2025 09:56, Harald Freudenberger wrote:
> On 2025-02-24 16:23, Holger Dengler wrote:
>> On 23/02/2025 10:54, Harald Freudenberger wrote:
>>> Move the very small response_type struct into struct ap_msg.
>>> So there is no need to kmalloc this tiny struct with each
>>> ap message preparation.
>>
>> I understand the intention for this patch, but in my opinion the
>> layering concept between ap and zcrypt is violated by defining the
>> response-type as part of the ap message struct. But I don't have any
>> better solution, so for the moment you may leave it as is.
>>
>>>
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> ---
>>>  drivers/s390/crypto/ap_bus.h           |  12 ++-
>>>  drivers/s390/crypto/zcrypt_msgtype50.c |  22 +++---
>>>  drivers/s390/crypto/zcrypt_msgtype6.c  | 101 ++++++++++---------------
>>>  3 files changed, 59 insertions(+), 76 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/ap_bus.h b/drivers/s390/crypto/ap_bus.h
>>> index f4622ee4d894..a5d8f805625f 100644
>>> --- a/drivers/s390/crypto/ap_bus.h
>>> +++ b/drivers/s390/crypto/ap_bus.h
>>>  struct ap_message {
>>>      struct list_head list;        /* Request queueing. */
>>>      unsigned long psmid;        /* Message id. */
>>> @@ -222,7 +231,7 @@ struct ap_message {
>>>      size_t bufsize;            /* allocated msg buffer size */
>>>      u16 flags;            /* Flags, see AP_MSG_FLAG_xxx */
>>>      int rc;                /* Return code for this message */
>>> -    void *private;            /* ap driver private pointer. */
>>> +    struct ap_response_type response;
>>
>> I don't like this change. The completion and the type are both
>> message-type related. That means, this change pulls messate-type
>> related data definitions into the ap-layer. On the other hand, I have
>> currently no idea how this can be solved.
>>
> 
> Well, the "private" data could be opaque allocated in ap_init_apmsg without
> any knowledge about the data - just the size. And the msg type 50 and 6
> implementations could just check for the right size and then overlay the
> private data bytes with their own struct.

The only "problem" is, that the lower layer (ap in this case) has no knowledge, how much memory is required for the private data.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

