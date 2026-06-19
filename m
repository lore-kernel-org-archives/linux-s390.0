Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B736533291F
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781860639; cv=none; b=HNw7OuxwzfPVWdWxpZ+bzJ2lXi9wZYx1WZsUPtokbwA9f5/Z7A/AY8M3EeU6v8K7WVIgUVROO1eas6apvVaVHER+9sdrG5nSD18ahJyZ4lU2l9C+fr+SHUPZKS4RSz1zyxs6aA2DM44bg9p09uDeKVasIloQRAVs0oY4vRWnINQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781860639; c=relaxed/simple;
	bh=4cRSrGLYcWTPNCTsEIQHbPwVG4TqOHyj7G3eAaBhcmo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kyB7snmaXXsGDKrCM+PstDMj3s1HaLRmiWeYnzaeEV1LBrZe64UfYUVq6NtaUQN3xBPo7SwqcFxikcPG4a/eb8ZxiAeodKjY9VgY6BB/hCVq+dNwQe2DNsxwHhc8J4dzei80HAY+o0GCZ6zDolOhcJ+KDkMjGZcrE5P3XZbVywU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K3Af1OEM; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K3Af1OEM"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mHjP1840372
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:17:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=bMwGir
	IPigwljS07dhOxaKyl/gkkqqi9I/VK98Il+Lc=; b=K3Af1OEMCJ/C6ZEG/crdjz
	MJETB0bYRe1vNYGIE6qrxC8qlYmZtG+1Az3uYlgmrcR31M06svu1GXIPqzdXzqLb
	JGKaxTwKvgy9SR4J/EwiMH8T2XU//8uVlebpOphSwUbsRLwyO4T3OQyeucmUvBWB
	66U+RZfG65T+ZnUC/zVVt9e9ZMJlAYyzgzcxz9UVBGT6+48LEftl0WAKxTPnslnL
	+/lAN//UBzr3Y5CuZksHFKL41lBFHh/nuQI4mnluLwLZnHRWoqSiyayUL3JFD9b+
	7l/hQZ2gaQmHz5zs+7fieG7vgGphb2yX0HptSqthQL92xW6S8fcpeQo3OAEf2rqg
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcrge-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:17:14 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J94aaV015532
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:17:13 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172g3w6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 09:17:13 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J9H9dO51184104
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 09:17:09 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CE3C12004D;
	Fri, 19 Jun 2026 09:17:09 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A74D820049;
	Fri, 19 Jun 2026 09:17:09 +0000 (GMT)
Received: from [9.111.159.204] (unknown [9.111.159.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 09:17:09 +0000 (GMT)
Message-ID: <5cf08341-acf3-497a-859f-65889ab294d9@linux.ibm.com>
Date: Fri, 19 Jun 2026 11:17:09 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: freude@linux.ibm.com
Cc: Holger Dengler <dengler@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
 <c701bc8554683dab75d5fcd95f01175b@linux.ibm.com>
Content-Language: en-US, de-DE
From: Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <c701bc8554683dab75d5fcd95f01175b@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4MSBTYWx0ZWRfXyyj5HJncD7rg
 /7kaUIpQoR3Jfn9mw3sAx5+eEMTe6bRG6D5gS529GIBhztLC4YWzDrZkgZ/pjDwT9PkiOSN/BAd
 0/W+S91hrtJgNr1GvCipkS/1AtKlauQ=
X-Proofpoint-ORIG-GUID: Qt6O8APUp1nXgU11AbFZjGdi9mwPRsFi
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4MSBTYWx0ZWRfX6uf86xgJRW/t
 gcoJcgW8kenOcTu/uA1yVG7hsRtUIwUkcIBXAq4HBpMfJWJHwiTAxiysKLmQhTbfWRofwq1lf34
 dQC0cgmq7YikbEJ40yAfnMd+WGkR81lKvXPa/9Ml7ryMxNIvguxzoQCLXQp5V1V5TtAP/ku+sa6
 aorfIKOE1RauXhLWS1ZqExBaCOszi1T8kev/legl5d0dBSTT0xLCH2U8ZIz/XLrVs6ui1Temogm
 uJwQL8QQkgAAJx3Z9pKvFiKdzFslHwbf0fmD8WHpnyZeUigLodmcL7Vw3egJYs3IZVK2Anag63X
 /mo020WYBZe3ZrZJ1YYjyYL7vXtmaju6zZewZDexkGYLkW04jVmDWF2xuO9bSZVqq28u5vNuKie
 ThBIjsF2ATgcs0PPotWP/5VsIyAAIhRBIw5f8T5JXCr7b0Kz/bI/pUE7wNK05Fr7q6JJ6i51zE5
 9rWyo+9fFsAtEhGTf5w==
X-Proofpoint-GUID: Qt6O8APUp1nXgU11AbFZjGdi9mwPRsFi
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a35091a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qttPAmirWCgBvoJqxUAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-19_02,2026-06-18_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 malwarescore=0 clxscore=1015 adultscore=0
 phishscore=0 lowpriorityscore=0 suspectscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606190081

On 19.06.2026 10:43, Harald Freudenberger wrote:
> On 2026-06-19 10:32, Ingo Franzki wrote:
>> On 19.06.2026 09:45, Holger Dengler wrote:
>>> As part of the verification, the PKEY_VERIFYPROTK ioctl checks for
>>> supported keytype, which are derived from the bit-size of the key. The
>>> calculation for the bit-size of a protected key has to take into
>>> account, that the length of the protected key blob also includes the
>>> length of the wrapping key verification pattern (WKVP). Subtract the
>>> length of the MKVP from the protected key length fixes this
>>> calculation.
>>>
>>> Fixes: 8fcc231ce3be ("s390/pkey: Introduce pkey base with handler registry and handler modules")
>>> Signed-off-by: Holger Dengler <dengler@linux.ibm.com>
>>> ---
>>>  drivers/s390/crypto/pkey_api.c | 3 ++-
>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
>>> index d6b595eb3370..2160e1de3014 100644
>>> --- a/drivers/s390/crypto/pkey_api.c
>>> +++ b/drivers/s390/crypto/pkey_api.c
>>> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>>>      if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>>>          return -EFAULT;
>>>
>>> -    keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
>>> +    keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
>>> +                           AES_WK_VP_SIZE));
>>>      if (!keytype) {
>>>          PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>>>                   __func__, kvp.protkey.len);
>>
>> Why not simply use
>>
>>      t->keytype = kvp.protkey.type;
>>
>> and remove the whole 'keytype = pkey_aes_bitsize_to_keytype(....)' thing ?
>> The type of the protected key is already contained in the protected
>> key structure, so why trying to guess it from the size again?
> 
> Not sure how this comes from. However, as this function anyway is only
> valid to be called for protected AES keys I would stay with the guessing
> from the length.

The problem with guessing the type from the length is that there are non-AES protected key types that have the same size as AES keys, e.g. PKEY_KEYTYPE_ECC_P256 and PKEY_KEYTYPE_ECC_ED25519 are both 64 (32+32) bytes in size and would be treated as AES-256 bit key with the current guessing....

> 
>>
>> You will need a length check for the 'memcpy(t->protkey,
>> kvp.protkey.protkey, kvp.protkey.len);' (regardless of how you
>> determine the type).
> 
> As you wrote, the length still needs to be checked here for <= sizeof(t->protkey).


-- 
Ingo Franzki
eMail: ifranzki@linux.ibm.com  
Linux on IBM Z Development
IBM Campus 1, 71139 Ehningen, Germany

IBM Deutschland Research & Development GmbH
Vorsitzender des Aufsichtsrats: Wolfgang Wendt
Geschäftsführung: David Faller
Sitz der Gesellschaft: Ehningen / Registergericht: Amtsgericht Stuttgart, HRB 243294
IBM DATA Privacy Statement: https://www.ibm.com/privacy/us/en/
