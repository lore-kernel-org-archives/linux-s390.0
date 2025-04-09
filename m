Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA0315530C
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 13:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206371; cv=none; b=XOQXJ16vPt/8S2JuPkPS68Tt8+FXYa5gsZY+x2czLxBk+7ITDFK8ucSw3JVhzE0yyxlYTXOw6AAfQ7roGbMSp9hf36POmAse+xEMCzyzeOhFia4skh8U36oGzOnOsMQYUCnzkzcWS+S+ulfMgbUA7cbok6i16RGw7VbrcdNHMgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206371; c=relaxed/simple;
	bh=vkXTqdi3OHYqTyhmOgiVHUljzluJt6LVmvHDbWy8Hho=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=fYmYql6gbBHEbhPtblw7i5qR1QuQMB0XNJrniAeSnjNKXk9DbFb857n7ij2hIbgAYL9BB6i3VsyL1D9iDRSleUz8tZaQ+e5n1Iotxkf30d2TjhbHsFhhXvsFXUUXP3PdEMrkMeWW8tP1utZ4lEOLmhFYt82D6ojiFwaqX3lFhIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nXr2RzHW; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nXr2RzHW"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 539AYJnw013997;
	Wed, 9 Apr 2025 13:46:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=FYcsDjAgmjE/JjB8BvN0EvK3UqBrlefG0+K5dT46MZ0=; b=nXr2RzHWWfS+
	IIB5P1eNcVdsijyyipChYFzXILVBzpJPFJiXDPNw5t0lN55b+1ml+HoWx5ZzCAME
	LcUThoeE3afYeSiL6Gl8DZCwkz9c/sjU4RdJ3hNXM5IylHBrnzICQFsn65C8oXUI
	SsDeGRh7BytmynivBw8sAXbLktUimISXwYZvVPndH1TsPQvM6/53yljOzKK++f+3
	4xF25YMIdweRF6ppik2utWurf0+yILQqZb0OygWZCmvB3SZ1w5jhfETwzktk6VG0
	8olmu+2Gfwin7AHgdzX6LZraer6eOu0jhLpBzetjzysTDJLi+SrDAPpojWYL7bwC
	eROSAlPHnA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45w57px4d9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:46:06 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539Cr30S024605;
	Wed, 9 Apr 2025 13:46:05 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutg3rt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:46:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539Dk13p29753896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 13:46:02 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BA24658058;
	Wed,  9 Apr 2025 13:46:03 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6070558057;
	Wed,  9 Apr 2025 13:46:03 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 13:46:03 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Apr 2025 15:46:03 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 04/21] s390/ap/zcrypt: New xflag parameter
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <6e91cd67-e08d-4cb0-ada2-84125f566c41@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-5-freude@linux.ibm.com>
 <6e91cd67-e08d-4cb0-ada2-84125f566c41@linux.ibm.com>
Message-ID: <8de8f591b4222b487f42ca8fb083df91@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3EG09BizZfUMi_m3rHJWnJc6N5thB4d0
X-Proofpoint-GUID: 3EG09BizZfUMi_m3rHJWnJc6N5thB4d0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 clxscore=1015
 spamscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0 mlxlogscore=975
 priorityscore=1501 malwarescore=0 impostorscore=0 phishscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502280000
 definitions=main-2504090082

On 2025-04-09 10:40, Holger Dengler wrote:
> On 27/03/2025 15:39, Harald Freudenberger wrote:
>> Introduce a new flag parameter for the both cprb send functions
>> zcrypt_send_cprb() and zcrypt_send_ep11_cprb(). This new
>> xflags parameter ("execution flags") shall be used to provide
>> execution hints and flags for this crypto request.
>> 
>> There are two flags implemented to be used with these functions:
>> * ZCRYPT_XFLAG_USERSPACE - indicates to the lower layers that
>>   all the ptrs address userspace. So when construction the ap msg
>>   copy_from_user() is to be used. If this flag is NOT set, the ptrs
>>   address kernel memory and thus memcpy() is to be used.
>> * ZCRYPT_XFLAG_NOMEMALLOC - indicates that this task must not
>>   allocate memory which may be allocated with io operations.
>>   For the zcrypt layer this limits the number of EP11 targets
>>   to 16 APQNs. But as this flag is passed down the stack, it
>>   may induce further restrictions.
>> 
>> For the AP bus and zcrypt message layer this means:
>> * The ZCRYPT_XFLAG_USERSPACE is mapped to the already existing
>>   bool variable "userspace" which is propagated to the zcrypt
>>   proto implementations.
>> * The ZCRYPT_XFLAG_NOMEMALLOC results in setting the AP flag
>>   AP_MSG_FLAG_MEMPOOL when the AP msg buffer is initialized.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>  drivers/s390/crypto/ap_bus.c          |  6 +--
>>  drivers/s390/crypto/ap_bus.h          |  2 +-
>>  drivers/s390/crypto/zcrypt_api.c      | 76 
>> +++++++++++++++------------
>>  drivers/s390/crypto/zcrypt_api.h      | 11 +++-
>>  drivers/s390/crypto/zcrypt_ccamisc.c  | 16 +++---
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 10 ++--
>>  6 files changed, 69 insertions(+), 52 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_api.c 
>> b/drivers/s390/crypto/zcrypt_api.c
>> index ad09c5306e28..01cb72fed828 100644
>> --- a/drivers/s390/crypto/zcrypt_api.c
>> +++ b/drivers/s390/crypto/zcrypt_api.c
> [...]
>> @@ -1045,36 +1048,40 @@ static long _zcrypt_send_ep11_cprb(bool 
>> userspace, struct ap_perms *perms,
>> 
>>  	trace_s390_zcrypt_req(xcrb, TP_ZSENDEP11CPRB);
>> 
>> -	rc = ap_init_apmsg(&ap_msg, false);
>> +	rc = ap_init_apmsg(&ap_msg, xflags & ZCRYPT_XFLAG_NOMEMALLOC ?
>> +			   AP_MSG_FLAG_MEMPOOL : 0);
>>  	if (rc)
>>  		goto out;
>> 
>>  	target_num = (unsigned short)xcrb->targets_num;
>> 
>>  	/* empty list indicates autoselect (all available targets) */
>> -	targets = NULL;
>> +	rc = -ENOMEM;
>>  	if (target_num != 0) {
>>  		struct ep11_target_dev __user *uptr;
>> 
>> -		targets = kcalloc(target_num, sizeof(*targets), GFP_KERNEL);
>> -		if (!targets) {
>> -			func_code = 0;
>> -			rc = -ENOMEM;
>> +		if (target_num <= ARRAY_SIZE(targetbuf)) {
>> +			targets = targetbuf;
>> +		} else if (xflags & ZCRYPT_XFLAG_NOMEMALLOC) {
>>  			goto out;
>> +		} else {
>> +			targets = kcalloc(target_num,
>> +					  sizeof(*targets), GFP_KERNEL);
>> +			if (!targets)
>> +				goto out;
> 
> As discussed, this alloc&copy is only required in userspace path. If
> zcrypt_send_ep11_cprb() is called from userspace, the targets pointer
> can be used directly.

Done as discussed. There is now a new patch which changes this
code to not alloc and memcpy in case of kernel space. So with that
the 16 apqns stack buffer is not needed any more and thus will
vanish in v4 and so also this artificial limitation is gone as well.

changes
