Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2445D18FDBD
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781859332; cv=none; b=FZj3KyMVtQvbSFM6hlLSftp+d017Tkd2aefc4fdfBz0m7ICxNnZFYF9ybcaTdN2JBWE3vCJKf+dh698wU10/Z3Jd/lQV12/wv44CzMBW8po3byfvZWuygVNw2RBEkChrsimrSQK1/sC0SB1fs2hl2AyUpC+Ke8j2X/dntXLrufo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781859332; c=relaxed/simple;
	bh=+3r6R8FIj+CMvLjKxjhR7zwKH2cV1zCKiJwgCGcfSqs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JwQoaGxTbr863Hjf2s+YEGK2YpojFfTK249HREfOsui0LugjpVCJHpTfMtK8B+JGoAXb5Jd9iIKLJY230LJd03Xo2iXVeItfnKKUxl3+HxHzRy0SRTU8ITYPPYDoQUCntu+tFvrVpthLf0eNQqhatznlOA9CDn1ILcbImf+n1q0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJqAL2d0; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJqAL2d0"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65J7mcmp1840616
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:55:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=doPYjD
	wkGT0oU6p0KrrDi9HrssBcgWsxKNf/QwZeW+k=; b=IJqAL2d0eoMYmj5LMNmGx6
	f/7J4ZK/ID6PBP81TVWbkQHRYpbzrwh09uvD/UZNnucr5AZeIFfMGBZU1nqF4QSn
	4wQ8arnFrlbqWmccSOnhNNHzE6yfVPSNy8Bp34X1dTXRwcAVInmP+UTFHC/mfi6I
	YXsQ1rEXfezHGzluA7Y4iMxXpNa7c4I/oBHq3o6XYSPkSiPHL4aBF47PhJvYhWw+
	/VtJuNhsfzOPQLe5IjfNaJ6prUgKcCS/k2qYy/gF1QgRLIPcm6ioIu5h0mqi+bgP
	T2ocaqEu5UEqHNciqs7vbSzqW6yqAQLY1fkVwpe62y3Qq5bCJzqjxSBgTIhMsVXg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4euequcndh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:55:30 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65J8naBj023548
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:55:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ev172g0xr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 19 Jun 2026 08:55:28 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65J8tPX748431402
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Jun 2026 08:55:25 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 010242004E;
	Fri, 19 Jun 2026 08:55:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C75E620040;
	Fri, 19 Jun 2026 08:55:24 +0000 (GMT)
Received: from [9.111.159.204] (unknown [9.111.159.204])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 19 Jun 2026 08:55:24 +0000 (GMT)
Message-ID: <a548db54-6b9c-4edd-917d-5ed7a967fb66@linux.ibm.com>
Date: Fri, 19 Jun 2026 10:55:24 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] pkey: Fix bitsize check in PKEY_VERIFYPROTK ioctl
To: Holger Dengler <dengler@linux.ibm.com>
Cc: Harald Freudenberger <freude@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260619074541.1710716-1-dengler@linux.ibm.com>
 <20260619074541.1710716-2-dengler@linux.ibm.com>
 <a4234cb9-5d92-4b97-979d-2b0be9cbeb1e@linux.ibm.com>
 <ba6122f2-c4a3-48f1-8272-f5b9de453442@linux.ibm.com>
Content-Language: en-US, de-DE
From: Ingo Franzki <ifranzki@linux.ibm.com>
In-Reply-To: <ba6122f2-c4a3-48f1-8272-f5b9de453442@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE5MDA4MSBTYWx0ZWRfX8++tWt/po1+k
 Mu0zjVxuSxfR7J7KexSUxuNhgyAWE9keP3y4ipnlj1aJ8HZnli5zR2bsKahHN97mg5ESnP6Mq0R
 LHxgGzDZDlkldCYZb9pLeRqUHnRISQg=
X-Proofpoint-ORIG-GUID: 94iocXZD7Ov8mcWpkubqUfwYq8XzL4-F
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE5MDA4MSBTYWx0ZWRfX8lBYMeJvNp+V
 UMbPubjHoeGm2QF4MQ3xmKP8UL1K1eDdXmkZKzTxoKpwIOQ80wWZI6x3YTofBR+WGlLgBjn++42
 T+J7TnJ9sccsf/EIGB/4hr+FCOhbjp+lnCfginUcxTNYbfcY2eXja7jB3myqB+Nrt5N5LgpSavC
 iPEOKxLAbjDe8mek0w3R3D7DxeK018Ixn+uBcTIR+EAv+TQjjPNYvZZPDpQk9ZjVaEMpvAEfexj
 KRUUOmZOYT5C+U1KJP4NtdlkOSPL6kX2lWcLlj99s5cYYEwLSqNig1GbWWl3UlGCCQ3s+cuhbyC
 EOu2jMoTY8BulVg2zNpJpzZzsbNzgh7bdQIl2J3BEz2efqIOqxtESYP5G8U7dTMym0QolDj6EIg
 uQUc/OO93KbDnNKxZ9izMtO/OlSBbKKBp7cBI3uGdrpwrILwVGrYe8j6E8fRth+cEfnyAHU/ZWg
 TwC1R8bmDdB9eYdwTVg==
X-Proofpoint-GUID: 94iocXZD7Ov8mcWpkubqUfwYq8XzL4-F
X-Authority-Analysis: v=2.4 cv=L9gtheT8 c=1 sm=1 tr=0 ts=6a350402 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
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

On 19.06.2026 10:45, Holger Dengler wrote:
> On 6/19/26 10:32, Ingo Franzki wrote:
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
>>>   drivers/s390/crypto/pkey_api.c | 3 ++-
>>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
>>> index d6b595eb3370..2160e1de3014 100644
>>> --- a/drivers/s390/crypto/pkey_api.c
>>> +++ b/drivers/s390/crypto/pkey_api.c
>>> @@ -334,7 +334,8 @@ static int pkey_ioctl_verifyprotk(struct pkey_verifyprotk __user *uvp)
>>>       if (copy_from_user(&kvp, uvp, sizeof(kvp)))
>>>           return -EFAULT;
>>>   -    keytype = pkey_aes_bitsize_to_keytype(8 * kvp.protkey.len);
>>> +    keytype = pkey_aes_bitsize_to_keytype(8 * (kvp.protkey.len -
>>> +                           AES_WK_VP_SIZE));
>>>       if (!keytype) {
>>>           PKEY_DBF_ERR("%s unknown/unsupported protkey length %u\n",
>>>                    __func__, kvp.protkey.len);
>>
>> Why not simply use
>>
>>       t->keytype = kvp.protkey.type;
>>
>> and remove the whole 'keytype = pkey_aes_bitsize_to_keytype(....)' thing ?
>> The type of the protected key is already contained in the protected key structure, so why trying to guess it from the size again?
>>
>> You will need a length check for the 'memcpy(t->protkey, kvp.protkey.protkey, kvp.protkey.len);' (regardless of how you determine the type).
> 
> I think, we need to check both: the derived keytype from the keysize AND the the keytype in the struct. The ioctl gets a struct which can contain any random data. So, we should first derive the keytype from the keysize and compare it with the keytype in the struct. Any mismatch should result in an error. I'll add this check in the v2.

Well, you finally call pkey_handler_verify_key() which calls pckmo_verify_key() and this has the following already:

		keysize = pkey_keytype_to_size(t->keytype);
		if (!keysize || t->len != keysize + AES_WK_VP_SIZE)
			goto out;

So you basically do the same here again. 

You might have to limit the type to AES keys though. 

> 
> And, as I already mentioned: the length-check before the memcpy() is mandatory in any way and a fix for this is already on its way.
> 


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
