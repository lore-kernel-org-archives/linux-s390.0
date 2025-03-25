Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CE2F19AD70
	for <linux-s390@vger.kernel.org>; Tue, 25 Mar 2025 09:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742894674; cv=none; b=HlsQzrUAyWItGs12ShXH/Na6Yv6jAeEW3e4ibFCdcS5LKil6HmOZ95Gt45LcZ8L6B5ILBmc5vaUNzm9c21ZJp+mFbNxe8tA/Z6dJjaWI1lJ6aASeFwNkZ+/4g3zohP/CldC+lPChkYhTpXDle7LP95eilQj8FD/q1SYcKU4zYIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742894674; c=relaxed/simple;
	bh=PXK6mhSSRnxGTeJs9TFnMzJsEAK3LjaENwOOQvznik4=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Iz9XcbZe6Nl9hw0dIyeIG+LO8R+76XeAcEUCB2F4BA/H78L+Gl/oXMee5C1w2TnIf4o44N8ENGXyXsg5Cd24nSwS6gowSZF7LMC77BGVP5xfZDLm6k1FAdg9lJHdu+UriPlC7fRUNNV0IXC4ChH7FFLnEOrfpdMOoE3ZtB3OZHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jZqJJvzz; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jZqJJvzz"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P7rcpM023873;
	Tue, 25 Mar 2025 09:24:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ZiAo5cXIturccv1CFUCCcdogBn4a96wHpr0P1sn2Et0=; b=jZqJJvzzA2TE
	UdbH0NTkHZJJG2yzXZupUFh6u00Qb1NCdt2XqxH5Ph5PszsDbgHNxKLnbk7r1NaB
	aSjGVLW2IFphRdA68I+7/wwQuZsZv/KT2zDNkGGhPcBnNz+mXPyBxaLqH1HXJoqS
	UBcidW5kKJiO8e5pejmwrvy2Aw3zBmu6DXLsKTpIuzpXyBgncFXV38LTP0ia8izj
	SiKoQqddfXNU9DNDP0n6SsTwFtyJJCkrEl8oTwckQ7qSzq4gieRrwqgTMN0+qzln
	Svisp69tvwseUXv5H+Y2wtSjFFXXle7qTJUQQ1Sujj8MFbQzopXv9jKsYSJn9MEw
	Q8z+0ErbTg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45kekytmsx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 09:24:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 52P6UXAJ005801;
	Tue, 25 Mar 2025 09:24:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ja82a9wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 09:24:27 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 52P9OQXA28770966
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 25 Mar 2025 09:24:27 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D193758059;
	Tue, 25 Mar 2025 09:24:26 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 457ED58043;
	Tue, 25 Mar 2025 09:24:26 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 25 Mar 2025 09:24:26 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 25 Mar 2025 10:24:25 +0100
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v2 07/20] s390/zcrypt: Rework zcrypt function
 zcrypt_device_status_mask_ext
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <64bab2ed-4302-45bf-b831-009c5b2d34e1@linux.ibm.com>
References: <20250304172116.85374-1-freude@linux.ibm.com>
 <20250304172116.85374-8-freude@linux.ibm.com>
 <64bab2ed-4302-45bf-b831-009c5b2d34e1@linux.ibm.com>
Message-ID: <4d82c1e8fe9cf60eb7393a0e91c71033@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OeC9b0oIo3PTFvhJHRHB4YKbYJYdTYeK
X-Proofpoint-GUID: OeC9b0oIo3PTFvhJHRHB4YKbYJYdTYeK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-25_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 adultscore=0 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 mlxscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2503250062

On 2025-03-19 12:03, Holger Dengler wrote:
> On 04/03/2025 18:21, Harald Freudenberger wrote:
>> Rework the existing function zcrypt_device_status_mask_ext():
>> * Add two new parameters to provide upper limits for
>>   cards and queues. The existing implementation needed an
>>   array of 256 * 256 * 4 = 256 KB which is really huge. The
>>   reworked function is more flexible in the sense that the
>>   caller can decide the upper limit for cards and domains to
>>   be stored into the status array. So for example a caller may
>>   decide to only query for cards 0...127 and queues 0...127
>>   and thus only an array of size 128 * 128 * 4 = 64 KB is needed.
>> * Instead of void the reworked function now returns an int.
>>   The currently only way to have the function return != 0
>>   is by providing card or domains limits beyond 256.
> 
> I would prefer to stay with a void function and limit the card and
> domain values to the current maximum. Details below.
> 
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/zcrypt_api.c      | 20 +++++++++++++++-----
>>  drivers/s390/crypto/zcrypt_api.h      |  3 ++-
>>  drivers/s390/crypto/zcrypt_ccamisc.c  | 22 +++++++++++++++++-----
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 14 ++++++++++----
>>  4 files changed, 44 insertions(+), 15 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>> b/drivers/s390/crypto/zcrypt_api.c
>> index 62cc05881b13..bd2738e3792a 100644
>> --- a/drivers/s390/crypto/zcrypt_api.c
>> +++ b/drivers/s390/crypto/zcrypt_api.c
>> @@ -1317,19 +1317,25 @@ static void zcrypt_device_status_mask(struct 
>> zcrypt_device_status *devstatus)
>>  	spin_unlock(&zcrypt_list_lock);
>>  }
>> 
>> -void zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext 
>> *devstatus)
>> +int zcrypt_device_status_mask_ext(struct zcrypt_device_status_ext 
>> *devstatus,
>> +				  int maxcard, int maxqueue)
> 
> Keep void and ...
> 
>>  {
>>  	struct zcrypt_card *zc;
>>  	struct zcrypt_queue *zq;
>>  	struct zcrypt_device_status_ext *stat;
>>  	int card, queue;
>> 
>> +	if (maxcard > MAX_ZDEV_CARDIDS_EXT || maxqueue > 
>> MAX_ZDEV_DOMAINS_EXT)
>> +		return -EINVAL;
>> +
> 
> ... limit maxcard/maxqueue to the maximum supported values. In my
> opinion, it does not make any sense to call this function with higher
> values than the maximum.
> 
> maxcard = MIN(maxcard, MAX_ZDEV_CARDIDS_EXT);
> maxqueue = MIN(maxqueue, MAX_ZDEV_DOMAINS_EXT);
> 
> As a side effect, it keeps the caller code much simpler.
> 
>>  	spin_lock(&zcrypt_list_lock);
>>  	for_each_zcrypt_card(zc) {
>>  		for_each_zcrypt_queue(zq, zc) {
>>  			card = AP_QID_CARD(zq->queue->qid);
>>  			queue = AP_QID_QUEUE(zq->queue->qid);
>> -			stat = &devstatus[card * AP_DOMAINS + queue];
>> +			if (card >= maxcard || queue >= maxqueue)
>> +				continue;
>> +			stat = &devstatus[card * maxqueue + queue];
>>  			stat->hwtype = zc->card->ap_dev.device_type;
>>  			stat->functions = zc->card->hwinfo.fac >> 26;
>>  			stat->qid = zq->queue->qid;
> [...]
>> @@ -1635,9 +1643,11 @@ static long zcrypt_unlocked_ioctl(struct file 
>> *filp, unsigned int cmd,
>>  					 GFP_KERNEL);
>>  		if (!device_status)
>>  			return -ENOMEM;
>> -		zcrypt_device_status_mask_ext(device_status);
>> -		if (copy_to_user((char __user *)arg, device_status,
>> -				 total_size))
>> +		rc = zcrypt_device_status_mask_ext(device_status,
>> +						   MAX_ZDEV_CARDIDS_EXT,
>> +						   MAX_ZDEV_DOMAINS_EXT);
>> +		if (!rc && copy_to_user((char __user *)arg, device_status,
>> +					total_size))
> 
> With the change above, you can stay with the current error handling.
> Only the addition parameters for zcrypt_device_status_mask_ext() need
> to be added.
> 
>>  			rc = -EFAULT;
>>  		kvfree(device_status);
>>  		return rc;
> [...]

Done as suggested - only I used typed min (min_t()) instead of MIN.
-> v3
