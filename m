Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB6CB1F60A
	for <linux-s390@vger.kernel.org>; Tue, 25 Feb 2025 07:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740469179; cv=none; b=H2W9yw9F99BEP9crgvnaXKkxbGKtyfiif0H34udr5dMUOTsgUBm1x283FNxnaLKu71NjRgAc5AYgI7JLxAS7Qz/8nK779OumpAn4NmLvtJgSKoxYqHERPPs1ol82Oon6kQL6dZ8c6zb2N/tzSA8F6hkk14QJX4uPk8Gv2vhdWH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740469179; c=relaxed/simple;
	bh=4yar7f9Gus5lb/oq52yjJVchv6AuSGcegzwwUI7D3aU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=kw/6Fz3ePXyh/sqfmVysa5+FrrE/JV0EpsA4hpjZ+RYR4lhmq8fEMGDFgdE0SDvP4dbKBz4o2u3BYC+4vYtEAJHpYQCQ1plx4RBo6IY9hH2XultZK+EJDjX+cj0q2tyNPRY9SkCHZPtU0n+a0cNCXRAZK+nykOrq16i7NUtX6Ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Wfn/X7BN; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Wfn/X7BN"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51P183c9011030;
	Tue, 25 Feb 2025 07:39:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=zNZTAg
	5uOC45dor/D1AtJgnzBbCaZPxFQ16+gjxCZaQ=; b=Wfn/X7BNTcFaQlvme/sSns
	EPJoj9SgNiuKYHBvB7TRF0GniUXxWCNfJ8Lsfbgdxq/W3R3bWSO6ywowPA4edYRO
	bMxneziOK+ymbXEIB/7VkPTVYI71d4vaLsrVyArmWqkRQy96DTEIpPZ7mQZ7obOj
	Ah9wVdFddJYjGV35LE7bM+3jazuB8HWZUzyvQozuJm/GfoVVu8byTlWEypPKE2AY
	dTHJzG/jVmI5bmiyAFnO8tVOaqwGtPECyMGU6xpJgnzFYf97D9f96+RAoqoGWsgy
	GXglDZq6nmFJ0FyBDCek+thwo3YLBmfnFxJO8TrbtGT/7hTvL1T3yOx2DDBaMXRA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4513x9sbk2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:39:34 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51P61aOC012462;
	Tue, 25 Feb 2025 07:39:34 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44yrwskuax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Feb 2025 07:39:33 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51P7dUq547251732
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Feb 2025 07:39:30 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 71BF920043;
	Tue, 25 Feb 2025 07:39:30 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 27BBE20040;
	Tue, 25 Feb 2025 07:39:30 +0000 (GMT)
Received: from [9.171.13.48] (unknown [9.171.13.48])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Feb 2025 07:39:30 +0000 (GMT)
Message-ID: <50ff4164-14eb-4ba2-8685-f0b07dcbc2bc@linux.ibm.com>
Date: Tue, 25 Feb 2025 08:39:29 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 01/20] s390/ap: Move response_type struct into ap_msg
 struct
From: Holger Dengler <dengler@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>, ifranzki@linux.ibm.com,
        fcallies@linux.ibm.com
Cc: linux-s390@vger.kernel.org, herbert@gondor.apana.org.au
References: <20250223095459.43058-1-freude@linux.ibm.com>
 <20250223095459.43058-2-freude@linux.ibm.com>
 <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
Content-Language: de-DE
In-Reply-To: <4e7052e5-2319-42f8-a9f0-ca59227a2f10@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: GfRnqLP9opMLcV6M1-UFPvG1TnQuag6-
X-Proofpoint-GUID: GfRnqLP9opMLcV6M1-UFPvG1TnQuag6-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-25_02,2025-02-24_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2502100000 definitions=main-2502250049

On 24/02/2025 16:23, Holger Dengler wrote:
> On 23/02/2025 10:54, Harald Freudenberger wrote:
>> Move the very small response_type struct into struct ap_msg.
>> So there is no need to kmalloc this tiny struct with each
>> ap message preparation.
> 
> I understand the intention for this patch, but in my opinion the layering concept between ap and zcrypt is violated by defining the response-type as part of the ap message struct. But I don't have any better solution, so for the moment you may leave it as is.
> 
>>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/ap_bus.h           |  12 ++-
>>  drivers/s390/crypto/zcrypt_msgtype50.c |  22 +++---
>>  drivers/s390/crypto/zcrypt_msgtype6.c  | 101 ++++++++++---------------
>>  3 files changed, 59 insertions(+), 76 deletions(-)
>>
[...]
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index b64c9d9fc613..21ee311cf33d 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -1061,28 +1046,26 @@ static long zcrypt_msgtype6_modexpo_crt(struct zcrypt_queue *zq,
>>   * Prepare a CCA AP msg: fetch the required data from userspace,
>>   * prepare the AP msg, fill some info into the ap_message struct,
>>   * extract some data from the CPRB and give back to the caller.
>> - * This function allocates memory and needs an ap_msg prepared
>> - * by the caller with ap_init_message(). Also the caller has to
>> - * make sure ap_release_message() is always called even on failure.
>> + * This function may allocate memory if the ap_msg msg buffer is
>> + * not preallocated and needs an ap_msg prepared by the caller
>> + * with ap_init_message(). Also the caller has to make sure
>> + * ap_release_message() is always called even on failure.
> 
> Please move this change to the patch, which makes the allocation optional.

This change will be reverted by the next patch in the series, so please dropt it here and make only the change in the next patch.

[...]
>> @@ -1158,28 +1141,26 @@ static long zcrypt_msgtype6_send_cprb(bool userspace, struct zcrypt_queue *zq,
>>   * Prepare an EP11 AP msg: fetch the required data from userspace,
>>   * prepare the AP msg, fill some info into the ap_message struct,
>>   * extract some data from the CPRB and give back to the caller.
>> - * This function allocates memory and needs an ap_msg prepared
>> - * by the caller with ap_init_message(). Also the caller has to
>> - * make sure ap_release_message() is always called even on failure.
>> + * This function may allocate memory if the ap_msg msg buffer is
>> + * not preallocated and needs an ap_msg prepared by the caller
>> + * with ap_init_message(). Also the caller has to make sure
>> + * ap_release_message() is always called even on failure.
> 
> Please move this change to the patch, which makes the allocation optional.

Same here.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler
--
IBM Systems, Linux on IBM Z Development
dengler@linux.ibm.com

