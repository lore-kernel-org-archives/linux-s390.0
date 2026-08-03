Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3626F353A66
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 08:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785744100; cv=none; b=u3VQoHdDlY4YnQZK4yE49Guu6FKHPk2Ttu273jlRQfYPxY9HuFmPv0A+sGgeGXMmhX662PYoyKPWGgeDlWjLelpvQvZ3s++Oul6FzkYqOeR3E4WOjQLQbM8wt6jWKnLlKrw2YFolnqGRo/OdhvO3CLm6GKyYjswU49iGQCfUkY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785744100; c=relaxed/simple;
	bh=eanVA21a6bHDXB1FoxKk9g4POcLCAuZQbcZngM/PnC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BnF8/TVdimkc+JUu5oTNUHVQgO9eyofzOr0kYKUChKpgTtJTl4n3w8o9S9o3I8T0W2XGle3pLIdRgZUduT0/eavrCQPf5R6vD+I0y7nBHtlGz2Rn8CKtB8uJ1yXFzY7BQio8t3ERzyc4yHg+wHagghgR+EPUxukAXAZ3QRUjykI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=q+642NBo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="q+642NBo"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Llphf243824
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:01:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O6syUZ
	5NELEvsNjduyxbJJGMCRlFlb/preBqCZX6ijU=; b=q+642NBoijC3UvGc7Rz7WF
	TmrAL8EkhlFEAAqXoBbhp0vJPAxzi5ym0lbWdUouJWVL9O6Pc4uzB0+1Pea9LrmQ
	bFQxmzZpQ+Du8F1xv250EZozfAq9pmvBVkVr9GXMOmCQg7oW2kv5YJ620zwYQX+Z
	Dd+2ArAQhpGC4jiIEdJx8zSRMn4MCp65ug1/7QY5c0trwF0PXLA8yKiDEjMniMKI
	gB+tAEslukr2yj9L4ulS3aZGIE2rQmjCFE6QAw42QTMzJ/z8niQe+UhEolQRI01c
	VRdF2strpx+94klZ+qf+vlsEguhzpufnGbN6d0e6xLcbehEn1MulGwNjRCMbcJKw
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4qj8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:01:38 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6737uFj3026236
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 08:01:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyc4ev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 08:01:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67381XZP49873356
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 08:01:33 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7EE4A2004E;
	Mon,  3 Aug 2026 08:01:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 03F5620040;
	Mon,  3 Aug 2026 08:01:33 +0000 (GMT)
Received: from [9.87.136.96] (unknown [9.87.136.96])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 08:01:32 +0000 (GMT)
Message-ID: <07a1fd51-1ebc-4d7a-b8cb-9159107f9e22@linux.ibm.com>
Date: Mon, 3 Aug 2026 10:01:32 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
To: freude@linux.ibm.com
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-3-freude@linux.ibm.com>
 <b50da3f2-a3de-43d6-8db4-a796f4437cf4@linux.ibm.com>
 <3c799af0f50b5047ce31bc03606656a0@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <3c799af0f50b5047ce31bc03606656a0@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfX3CUduyImcTfA
 kXcS03UY9MTt8brwPlNtRLaOBeOONhThL2JMqqYQlJrPiu5LX0XeWLBuejxYvK0INlBEk5IJVeL
 7gPDrhMKpWLmCWach3k6TkIT5HE7AUU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfXxh7ZSdz8/8Hz
 CCQLOoYpjzV6sI/0IruLc/AlG/OtUe5xoVP1pe3I+dwMPDOLf2jyzEzQunO4PzLTIYgsMxoF9kS
 phHhMCeexEkMPBWHcwmNaZ/uhEn3yGebQ4GJqEZdIQYxRWawML12t3d8Z2wR1OVCFGKAIjaOXij
 aNYmjamh6WPNPSC8RsvccV3B4EgqFd/bPcYQ0u3zr7VM/43kI1+PJ0rI/8wjt5Q1E3AwkGUIaPa
 BKdsZvolk8gfdwDc6sxahgYp0P4kZzw2xedMGwJSLbeg/KWv6U9x2wzJZk8OvTUTztPcQyDy2Yu
 i2kXx/FQLPt2PW5Nvwfn6wHfCpTzm494G090bRGg04cTJe/G5OdjKFg2c0KHLcB8Sq/yc41sZ5D
 nGhskDE57qBVVX5FrMf6VlxcYsGUpPoRUGMPvYZDoN+Aivmw5Qtytjj0UCkfyaj+284l/y83mvD
 BCYDfXqp7Cs8vkG8blA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a704ae2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=DQ0ouippglCBWTOOEq4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: ETkOEEjGa3hGrfWwCVocMM7_b7YaGKvP
X-Proofpoint-GUID: ETkOEEjGa3hGrfWwCVocMM7_b7YaGKvP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030068

On 8/3/26 09:55, Harald Freudenberger wrote:
> On 2026-07-31 12:35, Holger Dengler wrote:
>> On 7/30/26 16:15, Harald Freudenberger wrote:
>>> The xcrb_msg_to_type6cprb_msgx() function lacks proper input
>>> validation, creating security vulnerabilities:
>>> 1. Integer overflow after CEIL4 alignment: Signed int variables could
>>>    overflow during 4-byte boundary alignment, causing undersized
>>>    buffer allocations or incorrect bounds checking.
>>> 2. Missing minimum size validation: The CPRBX structure is copied from
>>>    userspace without verifying sufficient buffer length. Undersized
>>>    buffers cause uninitialized memory access when reading structure
>>>    fields like cprbx.cprb_len and cprbx.domain.
>>> 3. Arithmetic overflow in sum calculations: Adding control block and
>>>    data block sizes could overflow, bypassing size checks and enabling
>>>    buffer overflows.
>>>
>>> Fix by using size_t for length calculations, adding U32_MAX boundary
>>> checks after alignment, validating minimum control block size before
>>> copying from userspace, and detecting sum calculation overflows.
>>>
>>> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within
>>> zcrypt device driver")
>>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>>> Cc: stable@vger.kernel.org # 7.1+
>>> ---
>>>  drivers/s390/crypto/zcrypt_msgtype6.c | 78 +++++++++++++--------------
>>>  1 file changed, 36 insertions(+), 42 deletions(-)
>>>
>>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/
>>> crypto/zcrypt_msgtype6.c
>>> index 40f72cdf284d..fb37e28c8242 100644
>>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>>> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool
>>> userspace, struct ap_message *ap_msg,
>>>          };
>>>      } __packed * msg = ap_msg->msg;
>>>
>>> -    int rcblen = CEIL4(xcrb->request_control_blk_length);
>>> -    int req_sumlen, resp_sumlen;
>>> -    char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
>>> -    char *function_code;
>>> +    size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
>>> +    char *function_code, *req_data;
>>>
>>> -    if (CEIL4(xcrb->request_control_blk_length) <
>>> -            xcrb->request_control_blk_length)
>>> -        return -EINVAL; /* overflow after alignment*/
>>> -
>>> -    /* length checks */
>>> +    /* request length and overflow checks */
>>> +    if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
>>> +        return -EINVAL;
>>> +    req_cblen = CEIL4((size_t)xcrb->request_control_blk_length);
>>> +    if (req_cblen > U32_MAX)
>>> +        return -EINVAL;
>>>      ap_msg->len = sizeof(struct type6_hdr) +
>>> -        CEIL4(xcrb->request_control_blk_length) +
>>> -        xcrb->request_data_length;
>>> +        req_cblen + xcrb->request_data_length;
>>>      if (ap_msg->len > ap_msg->bufsize)
>>>          return -EINVAL;
>>> -
>>> -    /*
>>> -     * Overflow check
>>> -     * sum must be greater (or equal) than the largest operand
>>> -     */
>>> -    req_sumlen = CEIL4(xcrb->request_control_blk_length) +
>>> -            xcrb->request_data_length;
>>> -    if ((CEIL4(xcrb->request_control_blk_length) <=
>>> -         xcrb->request_data_length) ?
>>> +    req_sumlen = req_cblen + xcrb->request_data_length;
>>
>> The req_sumlen is also used for the calculation of ap_msg->len, right?
>> Why not moving the req_sumlen calculation and checks up and use it there?
>>
>> req_sumlen = req_cblen + xcrb->request_data_length;
>> if (req_sumlen > U32_MAX)
>> [...]
>> ap_msg->len = sizeof(struct type6_hdr) + req_sumlen;
>> if (ap_msg->len > ap_msg->bufsize)
>> [...]
>>
> 
> Done
> 
>> And another question about the aligned buffer lengths:
>> We have the request-control-block, followed by the request-data. Is only
>> the request-control-block required to be 4-byte aligned or also the
>> request-data, or only both together (request-control-block and -data)?
>>
>> Lets assume, request-control-block and -data length are both not 4-byte
>> alligned. Do we need the padding between the cprb and the data or at the
>> end of both blocks or only after data?
>>
>> Example:
>> req-ctrl-blk: length 5
>> req-data: length 5
>>
>> With only cprb padded (--> req_sumlen: 13)
>> | req-ctrl-blk[5] | pad[3] | req-data[5] |
>>
>>
>> With both padded separately (--> req_sumlen: 16)
>> | req-ctrl-blk[5] | pad[3] | req-data[5] | pad[3] |
>>
>> With both padded together (--> req_sumlen: 12)
>> | req-ctrl-blk[5] | req-data[5] | pad[2] |
>>
>>
> 
> I can only deduce this from the existing code.
> But my suggestion is:
> for a control block only:
>   ctrl-block | pad
> control + data block:
>   ctrl-block | pad | data-block | pad
> in a way that the start of each block is aligned to a 4 byte
> boundary AND can be processed in hunks of 4 bytes (double word).
> So we should make sure that the memory backing up an
> ap message is allocated with respect to the padding.

Ok.

> 
>>> +    if (req_sumlen > U32_MAX)
>>> +        return -EINVAL;
>>> +    if (req_cblen <= xcrb->request_data_length ?
>>>          req_sumlen < xcrb->request_data_length :
>>> -        req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
>>> +        req_sumlen < req_cblen) {
>>>          return -EINVAL;
>>>      }
>>>
>>> -    if (CEIL4(xcrb->reply_control_blk_length) <
>>> -            xcrb->reply_control_blk_length)
>>> -        return -EINVAL; /* overflow after alignment*/
>>> -
>>> -    /*
>>> -     * Overflow check
>>> -     * sum must be greater (or equal) than the largest operand
>>> -     */
>>> -    resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
>>> -            xcrb->reply_data_length;
>>> -    if ((CEIL4(xcrb->reply_control_blk_length) <=
>>> -         xcrb->reply_data_length) ?
>>> -        resp_sumlen < xcrb->reply_data_length :
>>> -        resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
>>> +    /* reply length and overflow checks */
>>> +    if (xcrb->reply_control_blk_length < sizeof(struct CPRBX))
>>> +        return -EINVAL;
>>> +    rep_cblen = CEIL4((size_t)xcrb->reply_control_blk_length);
>>> +    if (rep_cblen > U32_MAX)
>>> +        return -EINVAL;
>>> +    rep_sumlen = rep_cblen + xcrb->reply_data_length;
>> [...]
>>
>> Before this change, resp_sumlen was 4-bate aligned, now only rep_cblen
>> is aligned. Is thsi change intended? (the question is similar to the one
>> above)
> 
> There is no difference in the way how the reply sizes and limits are
> calculated to the way how the request sizes and limits are computed.
> And there should not be any difference.

Ok, than you can add my R-b to this patch.

Reviewed-by: Holger Dengler <dengler@linux.ibm.com>

> 
>>
>> The rest looks good to me.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

