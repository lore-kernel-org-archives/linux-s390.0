Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A9625C6E7
	for <linux-s390@vger.kernel.org>; Wed,  9 Apr 2025 13:43:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744206182; cv=none; b=M4mCglyDWaBXnLrXbVUijvx2ggYk2wsJTJjpRUKvZk1DUPstUUSm9bVHVVmt/pPD7RRLTfzjwCQGIBzK4+b9lpJ2pNz68oxpZEcmJ5blrJQ/RnRRW0e77uv8UJ08yDOovSiPVhdXZcuR3J958mCtp3PCkQFXPPIukZXQUt8234g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744206182; c=relaxed/simple;
	bh=zUWR4yjhvwzVJzBpjwRp66mqpWwKWblEBt+j4fDMeb8=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=Mgs3DU+hVAXLSAdwGYy7cCk7GzOEn40dCgkQ4IOdQJCK7vdA+eQ1LIzLKLErKBzV6BMXhu5cB8D7GDE1z/6qaiUa5jXwltl5gNaAanHAgtJs6xVeF8PRf87Xh33YVlbyNxSTs7AAQVW8QJ+MnFhglopkJp5ZElUoB5mZYPMoV7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=qQFRwvNY; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="qQFRwvNY"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5399J9VV009215;
	Wed, 9 Apr 2025 13:42:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=uLvDxQCHxBuGACjwEyr7uIYzPSpYYkPdV+4fG9TG9w8=; b=qQFRwvNYa69E
	Odk2zSowN/zgNdI/+mnppbouslfindo1aEcz0nZEQQ5CVXjlYI2Uxw8FBhBzUPko
	HIfYPsWdNi50SLeclA7tNycE3lYzYJSyRoUWBluHXZl+t/4bJEMWUBy+tyyBneyM
	U0Yh/aP8lzVpp6+bhOwoMwF3ScjXF4EyrcyM2GgHwEhCDhEXlI2btsVQGCMxX89T
	3lygKowIuPqqW/HPTFLpykTk8tliaYB43GO9tQlxohhSl6F8AlhfsWt0Oc0GSxIb
	uN0/EZ50I/fK0Qibe4IednIaGcvr5G+pakI9ylW5/Gz5Mn+Js1Xr98qyZJwElcyJ
	n2w86jjZ6A==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 45wayr3v89-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:42:57 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 539Cr7FC024616;
	Wed, 9 Apr 2025 13:42:57 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 45ueutg3ef-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 09 Apr 2025 13:42:57 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 539DgtRq28901964
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 9 Apr 2025 13:42:56 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D407058068;
	Wed,  9 Apr 2025 13:42:55 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 230785805B;
	Wed,  9 Apr 2025 13:42:55 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  9 Apr 2025 13:42:55 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 09 Apr 2025 15:42:54 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: ifranzki@linux.ibm.com, fcallies@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, linux-s390@vger.kernel.org,
        herbert@gondor.apana.org.au
Subject: Re: [PATCH v3 07/21] s390/zcrypt: Rework zcrypt function
 zcrypt_device_status_mask_ext
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <5a3ac12d-6aff-42d4-87fc-1d8cc5a26d06@linux.ibm.com>
References: <20250327143941.45507-1-freude@linux.ibm.com>
 <20250327143941.45507-8-freude@linux.ibm.com>
 <5a3ac12d-6aff-42d4-87fc-1d8cc5a26d06@linux.ibm.com>
Message-ID: <d3d2080f6d0e1034ba03b5d139ea218f@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wCAUBQljbQwmAInOdnRThSzilvm_IAq_
X-Proofpoint-GUID: wCAUBQljbQwmAInOdnRThSzilvm_IAq_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-09_05,2025-04-08_04,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 malwarescore=0 bulkscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502280000 definitions=main-2504090082

On 2025-04-09 10:56, Holger Dengler wrote:
> On 27/03/2025 15:39, Harald Freudenberger wrote:
>> Rework the existing function zcrypt_device_status_mask_ext():
>> Add two new parameters to provide upper limits for
>> cards and queues. The existing implementation needed an
>> array of 256 * 256 * 4 = 256 KB which is really huge. The
>> reworked function is more flexible in the sense that the
>> caller can decide the upper limit for cards and domains to
>> be stored into the status array. So for example a caller may
>> decide to only query for cards 0...127 and queues 0...127
>> and thus only an array of size 128 * 128 * 4 = 64 KB is needed.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> 
> Looks good now. With the minor change mentioned below
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> 
>> ---
>>  drivers/s390/crypto/zcrypt_api.c      | 14 +++++++++++---
>>  drivers/s390/crypto/zcrypt_api.h      |  3 ++-
>>  drivers/s390/crypto/zcrypt_ccamisc.c  | 17 ++++++++++++-----
>>  drivers/s390/crypto/zcrypt_ep11misc.c | 12 ++++++++----
>>  4 files changed, 33 insertions(+), 13 deletions(-)
>> 
> [...]
>> diff --git a/drivers/s390/crypto/zcrypt_ep11misc.c 
>> b/drivers/s390/crypto/zcrypt_ep11misc.c
>> index 12efcf1b54fc..504064c27a8b 100644
>> --- a/drivers/s390/crypto/zcrypt_ep11misc.c
>> +++ b/drivers/s390/crypto/zcrypt_ep11misc.c
>> @@ -1599,7 +1599,7 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, 
>> u16 cardnr, u16 domain,
>>  {
>>  	struct zcrypt_device_status_ext *device_status;
>>  	u32 *_apqns = NULL, _nr_apqns = 0;
>> -	int i, card, dom, rc = -ENOMEM;
>> +	int i, card, dom, rc;
> 
> If you initialize rc with -ENOMEM here ....
> 

You are totally right. However, I will not take this
as the following patches anyway rework this code and
the end result is that there is no alloc done within
this function and the rc variable is not needed any more.

>>  	struct ep11_domain_info edi;
>>  	struct ep11_card_info eci;
>> 
>> @@ -1609,13 +1609,16 @@ int ep11_findcard2(u32 **apqns, u32 *nr_apqns, 
>> u16 cardnr, u16 domain,
>>  				 GFP_KERNEL);
>>  	if (!device_status)
>>  		return -ENOMEM;
>> -	zcrypt_device_status_mask_ext(device_status);
>> +
>> +	zcrypt_device_status_mask_ext(device_status,
>> +				      MAX_ZDEV_CARDIDS_EXT,
>> +				      MAX_ZDEV_DOMAINS_EXT);
>> 
>>  	/* allocate 1k space for up to 256 apqns */
>>  	_apqns = kmalloc_array(256, sizeof(u32), GFP_KERNEL);
>>  	if (!_apqns) {
>> -		kvfree(device_status);
>> -		return -ENOMEM;
>> +		rc = -ENOMEM;
>> +		goto out;
> 
> ... you do not need to set it here. Just jump to out.
> 
> if (!_apqns)
> 	goto out;
> 
>>  	}
>> 
>>  	/* walk through all the crypto apqnss */
> [...]
