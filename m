Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E233446C3
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:45:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781858744; cv=none; b=FMD7Kxx9SbC/BKUXz1imSW+I4u58TC1Uv6yoi12uZkTpMHBTCROTVKeINmQZKQ0L8aF0lIOOYoBrjZuXlzKye6gJDk1FrhCxn4UAhUbwCvT9iowSrsdLjOMLEKrWrGBy0kkePB+vIUYLsiM+eKczsJm+ydXk2DzUdUK3AITLGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781858744; c=relaxed/simple;
	bh=pNKVsjG2BUg6UfWxYPLu+5NmNExaQ3Zoii9WLpgFS94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=i0t+NVYScDZcfu70wE46yMdjaG0qxXZh8foTkcVYBXb6B+5g5xXFQsAAMTBUwmAW4rjNpqj03kMgT1Dr8B3o8+9LxzF67b3evgVW9TpvepQgPCjzOAUEHom/OiLs3LVYExgkP1To1QiLEdLFUWYjhvRYzt0pnSsxuM9sGWAcxdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=KhoMSteS; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="KhoMSteS"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mFhK1840347
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:45:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=e5ssNt
	OjVlnT6sN5blmNibHFpHlTd9cYlv1i7V7LfRY=; b=KhoMSteSyIrSK49hs7yWh/
	4up+LIIKLL3vRDxKCT+HL2oIlERJNx2fpblqgvNYFSUugHnMNRpVc5MGlxAq2+w6
	CoXHQJFiIWirlN7sMQSYIibVqf7w5ZRnF3UW0oe7ySOixxG8RCHH8SEj2V2kp1dP
	CSuWn2+9eCsa8uP7bGAuySKPIy4Pyr46x/rfscpbrU3P/tPWuv2lAz+YFfrWRYkU
	wyrnkJxrczj9gn53hE1T7TIfIz2TvSXStdw0naFrz8D5xfYUIvWespNqLks2WbRi
	iIEUMRIjtTwxLzXLh6WAnCX5xURPSmCL7D1nsNZiKmbaIKeIhO/cHhQy694ujP+g
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcm51-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:45:41 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J8Jb7D025628
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:45:40 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172fyrh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:45:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J8jaL124969566
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:45:36 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C07202004D;
	Fri, 19 Jun 2026 08:45:36 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 603DB20043;
	Fri, 19 Jun 2026 08:45:36 +0000 (GMT)
Received: from [9.111.75.212] (unknown [9.111.75.212])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 08:45:36 +0000 (GMT)
Message-ID: <ba6122f2-c4a3-48f1-8272-f5b9de453442@linux.ibm.com>
Date: Fri, 19 Jun 2026 10:45:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: Ingo Franzki <ifranzki@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfX/TjnSnS9jXCV
 FvXFTrmwUMSJEpcQROgh2oDUE4bhD1HNq6S2s/SeikQ6dwa6e/SYpcBuB49yNSEUzzFUGRrW0Ns
 bucVHTA9rldrl2IhUqzdzalLdGnlmZM=
X-Proofpoint-ORIG-GUID: J4Q31hXQMWSBnpYDZ906h6uzHILmImhf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA3NiBTYWx0ZWRfXwfVcfzYD+lv0
 PWPa1sa0+XxHhT3kQiPdN3e+6eVFVbCwHIk17u14yROzwIqYLONBvqYqDW2kVjG5K3qmO0yL18/
 TpiQRlpOoHCyuHe2wtHSkVw+r+g+/zn46J/+UAEOJXXq0Ux6wPdhHl+F2sXu8ViRFN6l7RM3iV9
 EpDKnV5euEYaQbYeI8zREVW6WOvUKXjpNnHdFh0ODslq9Vn5+kbmO3yCfuSE3RjTTCTopjdkck0
 snGkL/n1jumh2axwxeKa+vohZD5OKdFpks/A/92MFFYHoy2IxxOIGgpsahUSWzQdvcVAK6nh147
 XkuoRuniBNCEb+LCCD3Yvj8LIvGnw7BDcUl6/oHKcaWziCIs2tdlO0cSmK1MbMlW6HQF5EZOECW
 SKEeVU82HQWBp0WLd+GoePVoK7eqZP8Bc0MgrpQEAa099dgM8FoC2rmoAQ9JAW3Snl2IY/K5n/y
 BpJaWlEpvblPTCSLJnA==
X-Proofpoint-GUID: J4Q31hXQMWSBnpYDZ906h6uzHILmImhf
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a3501b5 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=s3SrIzr4Emr5MCFJissA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190076

On 6/19/26 10:32, Ingo Franzki wrote:
> On 19.06.2026 09:45, Holger Dengler wrote:
>> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
>> supported keytype, which are derived from the bit-size of the key. The
>> calculation for the bit-size of a protected key has to take into
>> account, that the length of the protected key blob also includes the
>> length of the wrapping key verification pattern (WKVP). Subtract the
>> length of the MKVP from the protected key length fixes this
>> calculation.
>>
>> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
>> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/pkey_api.c | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
>> index d6b595eb3370..2160e1de3014 100644
>> --- a/drivers/s390/crypto/pkey_api.c
>> +++ b/drivers/s390/crypto/pkey_api.c
>> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>>   	if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>>   		return -EFAULT;
>>   
>> -	keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
>> +	keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
>> +						   AES_WK_VP_SIZE));
>>   	if (!keytype) {
>>   		PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>>   			     __func__, kvp.protkey.len);
> 
> Why not simply use
> 
>       t->keytype = kvp.protkey.type;
> 
> and remove the whole 'keytype = pkey_aes_bitsize_to_keytype(....)' thing ?
> The type of the protected key is already contained in the protected key structure, so why trying to guess it from the size again?
> 
> You will need a length check for the 'memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);' (regardless of how you determine the type).

I think, we need to check both: the derived keytype from the keysize AND 
the the keytype in the struct. The ioctl gets a struct which can contain 
any random data. So, we should first derive the keytype from the keysize 
and compare it with the keytype in the struct. Any mismatch should 
result in an error. I'll add this check in the v2.

And, as I already mentioned: the length-check before the memcpy() is 
mandatory in any way and a fix for this is already on its way.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

