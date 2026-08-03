Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CBC0B672
	for <linux-s390@vger.kernel.org>; Mon,  3 Aug 2026 07:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785743753; cv=none; b=fa4fe8Z05EJZd7GDxcX9y08LOZ4CmXEQoUIpeYa4eRPIIjS1X34uYvwwDYops6FGBFAoyAyDNrHno5YuR7YeBPZ1kQMJClMjRAXZydAnvVhdJ3n6Wj0RNDVRPqFPsIpI4uSYF6nm0jxa0wko4yelHnzhAe+Bt4ME6YKpCmzREa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785743753; c=relaxed/simple;
	bh=zb0uoIp3182l/99udiY2cnTTnqKhHqFZe/+S7d5CjZY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=B3DBrJir9PSR95M5a3hxqdpD4kplXRAKuItROXIQxnViKp46cVtIB9sR5YwShG+n2jAh4pOmguFIHZhP0E/rjUzUFjF/kOgww/0ydhJ7r8UUdEI+ly+uZX1T8xRDh1wSC2MowAu6xhEall6qoUvVAvCgowHj2xVWpV9XA0C2xLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=UxVmF0hw; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="UxVmF0hw"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LmALI244528
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 07:55:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=KUOBevmIgTkl+nIkHfG3aTUttpXUEd9TkQfOJlyUL/w=; b=UxVmF0hwLAWN
	5l54w5Wy+vgIcH/Ccsnj3mSmWHUiSp1sGJXaKZCpNQFdmrtdgbgEtjrhAl4h+sOg
	AStwqkIipdcDgH5wj2zp2qYThqJViMiAtdF+/XPD2k10ikcVZW2LUMrEX0yCmcul
	LiJBCpyVxGYwnxzMsrzSkKuigGPLdNTkI7xvm1sxd0E1fPrkgvHceDuIULu37eW4
	akhVQfB7c0lYr1M8NFp352Q3TJOJSUhr3vMO/uv9+kPDqjlwZGN65ucSVNIcgOTG
	XvaSTaJXQr/YNc56w+UFvPG0HFspq1Mm4yFVP2/Cwod90e0bV+RnKHo2qXIPQYAS
	PgsTVkFuuw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4qhd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 07:55:51 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6737fGk7006573
	for <linux-s390@vger.kernel.org>; Mon, 3 Aug 2026 07:55:50 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswbg4583-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 03 Aug 2026 07:55:50 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6737tmLh52625876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 07:55:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C96D75805A;
	Mon,  3 Aug 2026 07:55:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 240AF58054;
	Mon,  3 Aug 2026 07:55:48 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 07:55:48 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 09:55:47 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <b50da3f2-a3de-43d6-8db4-a796f4437cf4@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-3-freude@linux.ibm.com>
 <b50da3f2-a3de-43d6-8db4-a796f4437cf4@linux.ibm.com>
Message-ID: <3c799af0f50b5047ce31bc03606656a0@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfX+WF5cNb6BGeO
 C8/LXaKm0ja6sYgs1vmeC5gL30Bvkb2IqQ6HKuGdzE8IwT4POlzecNstehJBgk9Ctoc+LIaAJ1U
 /pK9u7oDljr+6ckfYWXUbhUnhY5FjA4=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA2OCBTYWx0ZWRfX8cCDUPPilSI9
 1LcyOqW97voDJu/+iozZQ3N4lEhjw8z+rwKtdhaV0a4j0gGtNwGuH6I7gy/FyqDY/E20SeXtKcS
 cWWFevKLZ8l8isJ1AgTMbdjuwNQtlQ43Z2so820G6WKRjVWR9FxqLG0XGJxrn25efuMrPxls4pJ
 6ueJErVypEb0BY10gzCPm1LZzhRjSYr5GDLw9LC+292YWHnTqVt2jd912OJz3QE5jRPVwnwM8dy
 zvawxcgirw4wr26it6qx5HLl3D8KQfO0mIEUaAIRcHuKIGNXh0ah/HjpYBwqDFjGOnlhnizgmes
 kueICi9ZOv7AQeseU3nLZUnYdnX4VQqg5VSZ7P+HmpCjH7E0yhdntWb0oQWb7VULlPKwlgsLvUF
 nq4NV7l0up1nXKwAhp/dSaWp86IaWtMo3Ne2hQ5GYPRIQ1Wb8zEnetppkBjuiUQaSoPSNwYYeC1
 Xbm5p53wFYdAGZI109A==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a704987 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=VU8cMqV1dA9rTLT3L-EA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: NQP6oXtRoX3DFo-_DguHUyvpQQxgpYTi
X-Proofpoint-GUID: NQP6oXtRoX3DFo-_DguHUyvpQQxgpYTi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030068

On 2026-07-31 12:35, Holger Dengler wrote:
> On 7/30/26 16:15, Harald Freudenberger wrote:
>> The xcrb_msg_to_type6cprb_msgx() function lacks proper input
>> validation, creating security vulnerabilities:
>> 1. Integer overflow after CEIL4 alignment: Signed int variables could
>>    overflow during 4-byte boundary alignment, causing undersized
>>    buffer allocations or incorrect bounds checking.
>> 2. Missing minimum size validation: The CPRBX structure is copied from
>>    userspace without verifying sufficient buffer length. Undersized
>>    buffers cause uninitialized memory access when reading structure
>>    fields like cprbx.cprb_len and cprbx.domain.
>> 3. Arithmetic overflow in sum calculations: Adding control block and
>>    data block sizes could overflow, bypassing size checks and enabling
>>    buffer overflows.
>> 
>> Fix by using size_t for length calculations, adding U32_MAX boundary
>> checks after alignment, validating minimum control block size before
>> copying from userspace, and detecting sum calculation overflows.
>> 
>> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within 
>> zcrypt device driver")
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Cc: stable@vger.kernel.org # 7.1+
>> ---
>>  drivers/s390/crypto/zcrypt_msgtype6.c | 78 
>> +++++++++++++--------------
>>  1 file changed, 36 insertions(+), 42 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 40f72cdf284d..fb37e28c8242 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  		};
>>  	} __packed * msg = ap_msg->msg;
>> 
>> -	int rcblen = CEIL4(xcrb->request_control_blk_length);
>> -	int req_sumlen, resp_sumlen;
>> -	char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
>> -	char *function_code;
>> +	size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
>> +	char *function_code, *req_data;
>> 
>> -	if (CEIL4(xcrb->request_control_blk_length) <
>> -			xcrb->request_control_blk_length)
>> -		return -EINVAL; /* overflow after alignment*/
>> -
>> -	/* length checks */
>> +	/* request length and overflow checks */
>> +	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
>> +		return -EINVAL;
>> +	req_cblen = CEIL4((size_t)xcrb->request_control_blk_length);
>> +	if (req_cblen > U32_MAX)
>> +		return -EINVAL;
>>  	ap_msg->len = sizeof(struct type6_hdr) +
>> -		CEIL4(xcrb->request_control_blk_length) +
>> -		xcrb->request_data_length;
>> +		req_cblen + xcrb->request_data_length;
>>  	if (ap_msg->len > ap_msg->bufsize)
>>  		return -EINVAL;
>> -
>> -	/*
>> -	 * Overflow check
>> -	 * sum must be greater (or equal) than the largest operand
>> -	 */
>> -	req_sumlen = CEIL4(xcrb->request_control_blk_length) +
>> -			xcrb->request_data_length;
>> -	if ((CEIL4(xcrb->request_control_blk_length) <=
>> -	     xcrb->request_data_length) ?
>> +	req_sumlen = req_cblen + xcrb->request_data_length;
> 
> The req_sumlen is also used for the calculation of ap_msg->len, right?
> Why not moving the req_sumlen calculation and checks up and use it 
> there?
> 
> req_sumlen = req_cblen + xcrb->request_data_length;
> if (req_sumlen > U32_MAX)
> [...]
> ap_msg->len = sizeof(struct type6_hdr) + req_sumlen;
> if (ap_msg->len > ap_msg->bufsize)
> [...]
> 

Done

> And another question about the aligned buffer lengths:
> We have the request-control-block, followed by the request-data. Is 
> only
> the request-control-block required to be 4-byte aligned or also the
> request-data, or only both together (request-control-block and -data)?
> 
> Lets assume, request-control-block and -data length are both not 4-byte
> alligned. Do we need the padding between the cprb and the data or at 
> the
> end of both blocks or only after data?
> 
> Example:
> req-ctrl-blk: length 5
> req-data: length 5
> 
> With only cprb padded (--> req_sumlen: 13)
> | req-ctrl-blk[5] | pad[3] | req-data[5] |
> 
> 
> With both padded separately (--> req_sumlen: 16)
> | req-ctrl-blk[5] | pad[3] | req-data[5] | pad[3] |
> 
> With both padded together (--> req_sumlen: 12)
> | req-ctrl-blk[5] | req-data[5] | pad[2] |
> 
> 

I can only deduce this from the existing code.
But my suggestion is:
for a control block only:
   ctrl-block | pad
control + data block:
   ctrl-block | pad | data-block | pad
in a way that the start of each block is aligned to a 4 byte
boundary AND can be processed in hunks of 4 bytes (double word).
So we should make sure that the memory backing up an
ap message is allocated with respect to the padding.

>> +	if (req_sumlen > U32_MAX)
>> +		return -EINVAL;
>> +	if (req_cblen <= xcrb->request_data_length ?
>>  	    req_sumlen < xcrb->request_data_length :
>> -	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
>> +	    req_sumlen < req_cblen) {
>>  		return -EINVAL;
>>  	}
>> 
>> -	if (CEIL4(xcrb->reply_control_blk_length) <
>> -			xcrb->reply_control_blk_length)
>> -		return -EINVAL; /* overflow after alignment*/
>> -
>> -	/*
>> -	 * Overflow check
>> -	 * sum must be greater (or equal) than the largest operand
>> -	 */
>> -	resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
>> -			xcrb->reply_data_length;
>> -	if ((CEIL4(xcrb->reply_control_blk_length) <=
>> -	     xcrb->reply_data_length) ?
>> -	    resp_sumlen < xcrb->reply_data_length :
>> -	    resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
>> +	/* reply length and overflow checks */
>> +	if (xcrb->reply_control_blk_length < sizeof(struct CPRBX))
>> +		return -EINVAL;
>> +	rep_cblen = CEIL4((size_t)xcrb->reply_control_blk_length);
>> +	if (rep_cblen > U32_MAX)
>> +		return -EINVAL;
>> +	rep_sumlen = rep_cblen + xcrb->reply_data_length;
> [...]
> 
> Before this change, resp_sumlen was 4-bate aligned, now only rep_cblen
> is aligned. Is thsi change intended? (the question is similar to the 
> one
> above)

There is no difference in the way how the reply sizes and limits are
calculated to the way how the request sizes and limits are computed.
And there should not be any difference.

> 
> The rest looks good to me.
