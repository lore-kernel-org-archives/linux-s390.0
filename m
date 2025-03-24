Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4262E25FA31
	for <linux-s390@vger.kernel.org>; Mon, 24 Mar 2025 14:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742827285; cv=none; b=L7qaOuRoipIAqQ19fy+/nX4nTh4Cnaxluep02uksoPM3f1GtariX7/pIvttfexDV/OB+V8UlbOj205N/r+LqZg8BEBghCIn/Oo9Lv4SQsuhZL4Mg/Wtu2bgzr9jH7bVpElPqslIb3yi7kJBGKfKYnzQfVhye93IVjX9f9Auosl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742827285; c=relaxed/simple;
	bh=NhRJTRoD7mGHOKQLwHiK//8AQEhMXZUDz3C7JwuPVj0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=OXxdFAIKX4V5JMGaqSua4p0S1uY/BlQ283dMQUfcp6HcRmKcNsvvwg8nB7wEjb5bOMkQbnD4IcXvZds2V6yWa2FekkQH0kuGwCUbHV3NxSmgqSDTDsLKBEBaFNwjdQv5iFkNs5x4TPLThGjKo2jgEWFhXeJqlxrfqUXaNfPL+kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=eCCjdXF0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="eCCjdXF0"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52OCxHrm013670;
	Mon, 24 Mar 2025 14:41:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=+ESMW7mtbKz3hpB2sUk5WMRFnkVyUTXQsoQEQp+dM+k=; b=eCCjdXF0fJZN
	4ktOw6/7uBfu+Xy7W7BNceTVczYfKczK9y3qFlD1sYPiCgFVpkqm6eDRmHlVyaXr
	oCFnYvlx1FxqV/CL8/ivoi8XuPH/V5fGopZresh+b1eRT9t6pp4/ZVZd/YJXb4/W
	jqUlj7iDVIDOO5ZoA6vt2xP9qpUxZps9NfYDV5Hhr+SuB7xjcqWgX3VQE1CMGI7Q
	ifnSpMGv8oZRnsg5rRmPOE70IPhJLE+deKw7/ooSuIkp4Wa+90dPCbAJos35bHLf
	736FK9u9DRFbJoBJMqNu3s3egi4BBiOyg8X7CUk7eIlo+hEhBtH9JIBbBqN0A+z3
	7eowe5gacw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45jys9323b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:41:21 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52OCe5EJ012352;
	Mon, 24 Mar 2025 14:41:20 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 45j91kxjtp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Mar 2025 14:41:20 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52OEfIRc26018288
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 14:41:19 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A698C5805A;
	Mon, 24 Mar 2025 14:41:18 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E09B5803F;
	Mon, 24 Mar 2025 14:41:18 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 24 Mar 2025 14:41:18 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 15:41:18 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 03/20] s390/ap: Introduce ap message buffer pool
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <1935a111-c0a3-4d7e-85f5-f7218253f1fc@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-4-freude@linux.ibm.com>
 <1935a111-c0a3-4d7e-85f5-f7218253f1fc@linux.ibm.com>
Message-ID: <31aa895585a8302597d41b989d0c196c@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: h1eq-DQr6cIfrZ08rbKE9fL4zzosEiNQ
X-Proofpoint-GUID: h1eq-DQr6cIfrZ08rbKE9fL4zzosEiNQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-24_04,2025-03-21_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxlogscore=999 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 adultscore=0 impostorscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2503240105

On 2025-03-17 17:14, Holger Dengler wrote:
> On 04/03/2025 18:20, Harald Freudenberger wrote:
>> There is a need for a do-not-allocate-memory path through the
>> ap bus layer. When ap_init_apmsg() with use_mempool set to true
>> is called, instead of kmalloc() the ap message buffer is
>> allocated from the ap_msg_pool. This pool only holds a limited
>> amount of buffers: ap_msg_pool_min_items with the item size
>> AP_DEFAULT_MAX_MSG_SIZE and exactly one of these items (if available)
>> is returned if ap_init_apmsg() with the use_mempool arg set to true
>> is called. When this pool is exhausted and use_mempool is set true,
>> ap_init_apmsg() returns -ENOMEM without any attempt to allocate
>> memory.
>> 
>> Default values for this mempool of ap messages is:
>>  * Each buffer is 12KB (that is the default AP bus size
>>    and all the urgend messages should fit into this space).
> 
> typo: urgent
> 

done -> v3

>>  * Minimum items held in the pool is 8. This value is adjustable
>>    via module parameter ap.msgpool_min_items.
>> 
>> The zcrypt layer may use this flag to indicate to the ap bus
>> that the processing path for this message should not allocate
>> memory but should use pre-allocated memory buffer instead.
>> This is to prevent deadlocks with crypto and io for example
>> with encrypted swap volumes.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> With the typo and the changed indent (see comment below)
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/ap_bus.c     | 57 
>> ++++++++++++++++++++++++++++----
>>  drivers/s390/crypto/ap_bus.h     |  9 ++---
>>  drivers/s390/crypto/zcrypt_api.c | 10 +++---
>>  3 files changed, 60 insertions(+), 16 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/ap_bus.h 
>> b/drivers/s390/crypto/ap_bus.h
>> index 483231bcdea6..a7bd44e5cc76 100644
>> --- a/drivers/s390/crypto/ap_bus.h
>> +++ b/drivers/s390/crypto/ap_bus.h
>> @@ -233,11 +233,12 @@ struct ap_message {
>>  			struct ap_message *);
>>  };
>> 
>> -#define AP_MSG_FLAG_SPECIAL  0x0001	/* flag msg as 'special' with 
>> NQAP */
>> -#define AP_MSG_FLAG_USAGE    0x0002	/* CCA, EP11: usage (no admin) 
>> msg */
>> -#define AP_MSG_FLAG_ADMIN    0x0004	/* CCA, EP11: admin (=control) 
>> msg */
>> +#define AP_MSG_FLAG_SPECIAL  0x0001   /* flag msg as 'special' with 
>> NQAP */
>> +#define AP_MSG_FLAG_USAGE    0x0002   /* CCA, EP11: usage (no admin) 
>> msg */
>> +#define AP_MSG_FLAG_ADMIN    0x0004   /* CCA, EP11: admin (=control) 
>> msg */
>> +#define AP_MSG_FLAG_MEMPOOL  0x0008   /* ap msg buffer allocated from 
>> mempool */
> 
> Please do not change the indent here. The change is not required, but
> it makes the life of reviewers much harder.
> 

corrected -> v3

>> 
>> -int ap_init_apmsg(struct ap_message *ap_msg);
>> +int ap_init_apmsg(struct ap_message *ap_msg, bool use_mempool);
>>  void ap_release_apmsg(struct ap_message *ap_msg);
>> 
>>  enum ap_sm_wait ap_sm_event(struct ap_queue *aq, enum ap_sm_event 
>> event);
> [...]
