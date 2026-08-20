Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DD37DE9B
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787238290; cv=none; b=AcXFtcXj79lLi9KsIQuxcpgn0Rl7lITKZl5i1ilYzu5HcZYRy1DRWFRhRkrlLQUugjgGimND/wJi3aaBVo06LwPdLVcjOqUWjcUQe27GnFlEACBsG0SUTfcrR6mMs+VzcBskT9Nx4W9ephNxYmJWWLdRBeqOO/1ZfUmqasMubvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787238290; c=relaxed/simple;
	bh=12lAHXQ54J95TB8iAExOLu8OOTSvHxGdLd4TvRwBrTs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=naAOhdNh8rIiFIj4A3r67/daiRL6P93ALSYSbuDQonfaPG/fpvFtXYFFMfViauJRwjbcRA7+nQblhFwcAjkTzDncg/Mrq5XHks+SCb/cb2z1EPmprWcDgRzq/MX2H4E+xvmTbz5eOQRSrOlmMaxBvZTC18ycbRRwOuFlgccDE1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Lm9GS7D4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Lm9GS7D4"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVURD872617
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:04:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=h/sKT/
	VoaSfZzPNUwVm2IPu5zZAfC8lZK0GQ2ZZpRzg=; b=Lm9GS7D4tLfq/vr2zlUGH2
	ieNzgazjFMBDo+/HaXNCpDJvQgLs9SK3rqBL1S3IMBP65G7rz06WqCoHp4NaIFdE
	nB40+rLMln4evPy4tGJRfr6prcy7ALxrjstE5Fqg3Lne11YBPcl+kAXZzs59lJ71
	15wTX4hxImsWCeO6JkxxEe15bmA121emOceLBoJF64BunJAxucjDbMgIhP/K6rTZ
	PrS0bIZ5+0WrkaSe+i7Lw3KKjFYTcPRsWCaKqm5WXGWP+38z2J+GuuT9TW+Zytue
	y06d8ILcyv023SGdQI6Hem73AHBnYnvOXXDAj26r3h/7eXyM8WEaBW27iYRwE1cg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0b45b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:04:48 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KEuHkW009342
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:04:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqfcg8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 15:04:47 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KF4hY641419110
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 15:04:43 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C48120043;
	Thu, 20 Aug 2026 15:04:43 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B6520040;
	Thu, 20 Aug 2026 15:04:43 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 15:04:43 +0000 (GMT)
Message-ID: <e131bc89-eca3-48b7-affe-3fefd1c39170@linux.ibm.com>
Date: Thu, 20 Aug 2026 17:04:43 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before using
 it
To: freude@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>,
        Ingo Franzki <ifranzki@linux.ibm.com>
References: <20260820140439.892324-1-dengler@linux.ibm.com>
 <20260820140439.892324-2-dengler@linux.ibm.com>
 <3cd23b72c689c0ba769b5bc091798c40@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <3cd23b72c689c0ba769b5bc091798c40@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KszyyxWl7uHyP0OmXy3OABhkU2qrTQYs
X-Proofpoint-GUID: KszyyxWl7uHyP0OmXy3OABhkU2qrTQYs
X-Authority-Analysis: v=2.4 cv=RoX16imK c=1 sm=1 tr=0 ts=6a871790 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=QvcCvJDnHzl9Ek5gYlgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExMyBTYWx0ZWRfX3LA57aSY5dWV
 nynYFxcTIOmEG8J7L6BlqyMl9iT3XqLD2fpvMkuMfBayLai59O8VuXL9v7JPiySFGoWz4ElHUz8
 KqTlxyiBFVehlxOudwfWvLaXd2mliDw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExMyBTYWx0ZWRfXxxYN/2xCmRpN
 wJpYl0f5PCIiN82451ulnjteWVlR/tt72MTRieOJpzXprl2OSjzZbdJLP+ud/pq4h9a7aLRwcrj
 oNREhCGhvrCWq5qtiGHF8/v/NCj3gqBztdHXV749N7P9bv2q+ilakNoQkh8DDglTCf2jBQmSNrz
 dmtnpyhVOqkgp7sdPuVV6SjiluC6tKlX4ajvG6YcvXvlsg4eqhXtbISA1Ggne9A2Qzb7IQvYViS
 RSM4vOz4G8pfhPUQ+8vsqM4XS/9qy2YkCInwNUR57aXpi/og83OjU5ZXVoMk5mrWrvl+bJmdjYz
 jOPDhUgDlrU0jMrRB0RG4Y5m8LDWJcyN8RdQ2B7uEiYX1hxjdCjD6Wdq0LJKvwC/eAr6w2ol45v
 8CZs9hlOeyL/0jjh4kX7MSWFeKcSbiaEiIb1Wr5O+pVwUN6Zax02qDzYFnI5X8HTlVvA8vHzGdN
 0qGMMMtkxGbmgnyzmbA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 suspectscore=0 malwarescore=0 adultscore=0
 clxscore=1015 phishscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200113

On 8/20/26 16:46, Harald Freudenberger wrote:
> On 2026-08-20 16:04, Holger Dengler wrote:
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c
>> b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index d4ce6352b5b2..54b8edd1dfc7 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
>> @@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>>
>>      /* do not check the key here, it may be incomplete */
>>
>> -    /* copy the vlsc key token back */
>> +    /*
>> +     * Copy the vlsc key token back.
>> +     * The available space in the destination (key_token) and the source
>> +     * (t) buffer is always larger as the valid range of prepparm-
>> >kb.len.
>> +     * Validate t->len ba comparing it with the length information in
>> the
> 
> what is this funny "ba" in the previous sentence ?

A typo. Should be "by". Will be fixed in v2.

> 
>> +     * param block of the request (prepparm->kb.len)
>> +     * The value range of prepparm->kb.len has been checked above.
>> +     */
>>      t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
>> +    if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
>> +        ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
>> +                   __func__, t->len);
>> +        rc = -EIO;
>> +        goto out;
>> +    }
>>      memcpy(key_token, t, t->len);
>>      *key_token_size = t->len;
> 
> Reviewed-by: Harald Freudenberger <freude@linux.ibm.com>

Thx, I'll pick it for the v2.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

