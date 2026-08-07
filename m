Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D30C73A5445
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 07:40:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786088407; cv=none; b=UGTLQo2e+wvtgXeKdOBGcVUkS30YoiqTE+O1bG2/blQ7pxoo3NSjwH+cqM4Z2FS2yoxrL2TKe6Rb6+HYAU2WX5sP0DYk8o866FbjKTBMJYK1hml3SkWiK26dY1iFjgsbaWmPm00osju3dLVoCtFUZZ1ncocY2+af0Q/mSoWbje0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786088407; c=relaxed/simple;
	bh=1ROQOWCRKZ8up1K6c3qDkuxEFa1RKD91DWvhN2ImF5c=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=MMkUx1nmKgxUl72BMs3Ym52cw9H6k8QXtxE1O5dHzDfKswXGMp4mCmhosS6Pm+0YCH8PPXrPqcs0qnAM/FZlgh0M/7w7o3zEpSC9EH8aWybXl8CXT/2VY1o+IbimZgNA2NLNBvZpSRU52go50ycbgQ/ro/U5e2/gOh8cug8SNfU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GzBpRgJR; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GzBpRgJR"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6770HtqQ4060705
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 07:40:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=AMaL1g
	aHDu17laLpOSXlqt8inJMSFQIlH0R3SuaU8ho=; b=GzBpRgJRiOTHXw7jM73Me+
	oDWlwtF3TADmHb+TCWHwiFegcSNsFUDM1WT9UUzAudo02/+S5zpzq5iJ2W2z/wgY
	a62AUiO23AqUhSLOBWIjnX5MImaedmRRSPL+3p9Swh/5Msrbt2aDrYDfHaXR+VWV
	KK2+5wHaaQ+PrpXa7yiEqak6IfA9u1GbVzrFN6A4L4vtcKkjT+w+SdvxrF6WruaP
	5iI4odtY7YsixquNQB0/ZTxSg1VrV3T34hU2PQ55K5r3RD2Kg/BYRr+/2DBIUSW7
	0i0hTeuopvZP2MqY0QIT6tPuMvWm9Sewd3ETx4w4f0a6tbztye/+mFdMmoHGfFLQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy02arx5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 07:40:04 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6777QHGq011674
	for <linux-s390@vger.kernel.org>; Fri, 7 Aug 2026 07:40:03 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyxjvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 07:40:03 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6777dxMr38273414
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 7 Aug 2026 07:39:59 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57A9D20043;
	Fri,  7 Aug 2026 07:39:59 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D91B620040;
	Fri,  7 Aug 2026 07:39:58 +0000 (GMT)
Received: from [9.111.208.53] (unknown [9.111.208.53])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  7 Aug 2026 07:39:58 +0000 (GMT)
Message-ID: <6a14e29d-8a54-43c3-8153-6f786bca7aca@linux.ibm.com>
Date: Fri, 7 Aug 2026 09:39:56 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
From: Finn Callies <fcallies@linux.ibm.com>
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260804144926.241039-1-freude@linux.ibm.com>
 <20260804144926.241039-2-freude@linux.ibm.com>
 <bbd320da-c0fc-4fdd-8e19-e4dd4d7b6e41@linux.ibm.com>
Content-Language: en-GB
In-Reply-To: <bbd320da-c0fc-4fdd-8e19-e4dd4d7b6e41@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=G6ws1dk5 c=1 sm=1 tr=0 ts=6a758bd4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=hUIe0fkoabwoUAFEsfQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfXxsVwSAZ0oel2
 tb+hNZryjem8IzgyxzECpv4ovDntbC0f/SdTWYDjzOERrLaPFs50W6AkRSlFc1qnTgYElcyEj/E
 GQAW2QINA/c8bqe/JwSwf5kF8BFzxs1M771UQHSPC7vIRDgqdqXsqGfJQ7K/YJqJitWm0MQIfZR
 2k8JhJrmwKv/IMmT67kYBP7ubgf1Aqt7U2PIay2dQB9XXx1ftPeiQf/OlpcSy3tI2GyFL27G9FE
 rxs5SHLLs9AGsPGsqATgpvc4cjQyI/fxVegP8jv9jK0RWYwSlDGmzoIssBjvpbyMSUpZaA37ny1
 bmt63ljYJ07B+AHIaqme5H2SgpuSSjebPUP4+JcDqnL7wXUQklKW5LIL6lfySOUamzroLsKS0Kn
 +cBFH7rdTSX6ZndF/YDs7gbDBOjX9sbV4tFM5hkoDBdQnKU0GVifDycFk9t8aXm9SgkX5Ub3Jn0
 pLO3sHu4swQ8OyWdM0w==
X-Proofpoint-ORIG-GUID: bnX1JmWvDbMxu5tWF7vNMqXNQR1DPI7u
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA3MDA1MyBTYWx0ZWRfX2TqndLX7qhHn
 sRBs4T62nHjZDV9wqBcjAMrUregQI40raUds0v1eeAP+kiLjpZrPGXZ1DtvWS97fKEdrZtNw3se
 POn4MKv7kpLHdRjoRc4lsKqXvYaBvBA=
X-Proofpoint-GUID: bnX1JmWvDbMxu5tWF7vNMqXNQR1DPI7u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-07_01,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0
 phishscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608070053



On 06.08.26 07:22, Finn Callies wrote:
> 
> 
> On 04.08.26 16:49, Harald Freudenberger wrote:
>> Add or improve checks related to buffer sizes and reply sizes to the
>> handling of replies from the crypto cards for CCA, EP11 (AP message
>> type 6) and ICA (AP type 50) messages. The verification code related
>> to reply field length was not designed well and thus firmware
>> deficiencies could lead to unexpected behavior in the zcrypt device
>> driver. Thus improve the code to more closely inspect especially
>> length fields at message replies.
>>
>> Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
>> zcrypt_msgtype50_receive() to validate reply lengths more carefully
>> before copying data back into the request buffer. Use size_t for
>> length calculations, reject inconsistent reply sizes, and add
>> defensive handling for short invalid replies. For XCRB replies,
>> validate both reply segments and derive the effective message length
>> from the covered range instead of trusting only the second segment.
>>
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
>>   drivers/s390/crypto/zcrypt_msgtype6.c  | 151 ++++++++++++++++---------
>>   2 files changed, 126 insertions(+), 64 deletions(-)
>>
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/ 
>> crypto/zcrypt_msgtype50.c
>> index d6fc2d8e7fad..ef925b399806 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype50.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype50.c
>> @@ -416,26 +416,39 @@ static void zcrypt_msgtype50_receive(struct 
>> ap_queue *aq,
>>           .reply_code = REP82_ERROR_MACHINE_FAILURE,
>>       };
>>       struct type80_hdr *t80h;
>> -    int len;
>> +    size_t len;
>>       /* Copy the reply message to the request message buffer. */
>>       if (!reply)
>>           goto out;    /* ap_msg->rc indicates the error */
>> +
>>       t80h = reply->msg;
>> -    if (t80h->type == TYPE80_RSP_CODE) {
>> -        len = t80h->len;
>> -        if (len > reply->bufsize || len > msg->bufsize ||
>> -            len != reply->len) {
>> -            pr_debug("len mismatch => EMSGSIZE\n");
> 
> I don't like this debug statement, its very undescriptive. What is len? 
> What does it mismatch against? What does the mismatch mean?
> 
> The "=> EMSGSIZE" looks very uncommon for me as well, is this a common 
> way of logging error paths?
> 
>> -            msg->rc = -EMSGSIZE;
>> -            goto out;
>> -        }
>> -        memcpy(msg->msg, reply->msg, len);
>> -        msg->len = len;
>> -    } else {
>> -        memcpy(msg->msg, reply->msg, sizeof(error_reply));
>> +
>> +    if (t80h->type != TYPE80_RSP_CODE) {
>> +        if (reply->len < sizeof(error_reply))
>> +            memcpy(msg->msg, &error_reply, sizeof(error_reply));
>> +        else
>> +            memcpy(msg->msg, reply->msg, sizeof(error_reply));
>>           msg->len = sizeof(error_reply);
>> +        goto out;
>> +    }
>> +
>> +    len = t80h->len;
>> +    if (len != reply->len) {
>> +        pr_warn_ratelimited("len %zu rpl.len %zu mismatch => 
>> EMSGSIZE\n",
>> +                    len, reply->len);
> 
> Same here. What is len? rpl.len is a technical statement, but logs 
> should be descriptive right?

I suggest something like "... mismatch: EMSGSIZE"

Additionally do not hardcode return code strings. Either use a function 
which converts rc to string or Just use %d and print the rc itself.

> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>>       }
>> +    if (len > reply->bufsize || len > msg->bufsize) {
>> +        pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
>> +                    len, reply->bufsize, msg->bufsize);
> 
> Why buf instead of buffer? Why safe space here?
> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>> +    }
>> +    memcpy(msg->msg, reply->msg, len);
>> +    msg->len = len;
>> +
>>   out:
>>       complete(&msg->response.work);
>>   }
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/ 
>> crypto/zcrypt_msgtype6.c
>> index 3df1d676de5d..b98449913e24 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -766,6 +766,13 @@ static int convert_type86_rng(struct zcrypt_queue 
>> *zq,
>>       if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
>>           return -EINVAL;
>> +    /*
>> +     * Note that offset2 and count2 have already been checked in
>> +     * zcrypt_msgtype6_receive(). So only check for not exceeding
>> +     * the hard coded rng buffer size.
>> +     */
>> +    if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
>> +        return -EMSGSIZE;
>>       memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
>>       return msg->fmt2.count2;
>>   }
>> @@ -928,48 +935,75 @@ static void zcrypt_msgtype6_receive(struct 
>> ap_queue *aq,
>>       };
>>       struct ap_response_type *resp_type = &msg->response;
>>       struct type86x_reply *t86r;
>> -    int len;
>> +    size_t len, len1, len2 = 0;
>>       /* Copy the reply message to the request message buffer. */
>>       if (!reply)
>>           goto out;    /* ap_msg->rc indicates the error */
>> +
>>       t86r = reply->msg;
>> -    if (t86r->hdr.type == TYPE86_RSP_CODE &&
>> -        t86r->cprbx.cprb_ver_id == 0x02) {
>> -        switch (resp_type->type) {
>> -        case CEXXC_RESPONSE_TYPE_ICA:
>> -            len = sizeof(struct type86x_reply) + t86r->length;
>> -            if (len > reply->bufsize || len > msg->bufsize ||
>> -                len != reply->len) {
>> -                pr_debug("len mismatch => EMSGSIZE\n");
>> -                msg->rc = -EMSGSIZE;
>> -                goto out;
>> -            }
>> -            memcpy(msg->msg, reply->msg, len);
>> -            msg->len = len;
>> -            break;
>> -        case CEXXC_RESPONSE_TYPE_XCRB:
>> -            if (t86r->fmt2.count2)
>> -                len = t86r->fmt2.offset2 + t86r->fmt2.count2;
>> -            else
>> -                len = t86r->fmt2.offset1 + t86r->fmt2.count1;
>> -            if (len > reply->bufsize || len > msg->bufsize ||
>> -                len != reply->len) {
>> -                pr_debug("len mismatch => EMSGSIZE\n");
>> +
>> +    if (t86r->hdr.type != TYPE86_RSP_CODE ||
>> +        t86r->cprbx.cprb_ver_id != 0x02) {
>> +        if (reply->len < sizeof(error_reply))
>> +            memcpy(msg->msg, &error_reply, sizeof(error_reply));
>> +        else
>> +            memcpy(msg->msg, reply->msg, sizeof(error_reply));
>> +        msg->len = sizeof(error_reply);
>> +        goto out;
>> +    }
>> +
>> +    switch (resp_type->type) {
>> +    case CEXXC_RESPONSE_TYPE_ICA:
>> +        len = sizeof(struct type86x_reply) + (size_t)t86r->length;
>> +        break;
>> +    case CEXXC_RESPONSE_TYPE_XCRB:
>> +        len1 = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
>> +        if (t86r->fmt2.offset1 > reply->len ||
>> +            t86r->fmt2.count1 > reply->len) {
>> +            pr_warn_ratelimited(
>> +                "offset1 %u count1 %u rpl.len %zu mismatch => 
>> EMSGSIZE\n",
>> +                t86r->fmt2.offset1, t86r->fmt2.count1,
>> +                reply->len);
> 
> same here
> 
>> +            msg->rc = -EMSGSIZE;
>> +            goto out;
>> +        }
>> +        if (t86r->fmt2.count2) {
>> +            len2 = (size_t)t86r->fmt2.offset2 +
>> +                (size_t)t86r->fmt2.count2;
>> +            if (t86r->fmt2.offset2 > reply->len ||
>> +                t86r->fmt2.count2 > reply->len) {
>> +                pr_warn_ratelimited(
>> +                    "offset2 %u count2 %u rpl.len %zu mismatch => 
>> EMSGSIZE\n",
>> +                    t86r->fmt2.offset2, t86r->fmt2.count2,
>> +                    reply->len);
> 
> same here
> 
>>                   msg->rc = -EMSGSIZE;
>>                   goto out;
>>               }
>> -            memcpy(msg->msg, reply->msg, len);
>> -            msg->len = len;
>> -            break;
>> -        default:
>> -            memcpy(msg->msg, &error_reply, sizeof(error_reply));
>> -            msg->len = sizeof(error_reply);
>>           }
>> -    } else {
>> -        memcpy(msg->msg, reply->msg, sizeof(error_reply));
>> +        len = max_t(size_t, len1, len2);
>> +        break;
>> +    default:
>> +        memcpy(msg->msg, &error_reply, sizeof(error_reply));
>>           msg->len = sizeof(error_reply);
>> +        goto out;
>> +    }
>> +
>> +    if (len != reply->len) {
>> +        pr_warn_ratelimited("len %zu rpl.len %zu mismatch => 
>> EMSGSIZE\n",
>> +                    len, reply->len);
> 
> same here
> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>>       }
>> +    if (len > reply->bufsize || len > msg->bufsize) {
>> +        pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
>> +                    len, reply->bufsize, msg->bufsize);
> 
> same here
> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>> +    }
>> +    memcpy(msg->msg, reply->msg, len);
>> +    msg->len = len;
>> +
>>   out:
>>       complete(&resp_type->work);
>>   }
>> @@ -992,34 +1026,49 @@ static void zcrypt_msgtype6_receive_ep11(struct 
>> ap_queue *aq,
>>       };
>>       struct ap_response_type *resp_type = &msg->response;
>>       struct type86_ep11_reply *t86r;
>> -    int len;
>> +    size_t len;
>>       /* Copy the reply message to the request message buffer. */
>>       if (!reply)
>>           goto out;    /* ap_msg->rc indicates the error */
>> +
>>       t86r = reply->msg;
>> -    if (t86r->hdr.type == TYPE86_RSP_CODE &&
>> -        t86r->cprbx.cprb_ver_id == 0x04) {
>> -        switch (resp_type->type) {
>> -        case CEXXC_RESPONSE_TYPE_EP11:
>> -            len = t86r->fmt2.offset1 + t86r->fmt2.count1;
>> -            if (len > reply->bufsize || len > msg->bufsize ||
>> -                len != reply->len) {
>> -                pr_debug("len mismatch => EMSGSIZE\n");
>> -                msg->rc = -EMSGSIZE;
>> -                goto out;
>> -            }
>> -            memcpy(msg->msg, reply->msg, len);
>> -            msg->len = len;
>> -            break;
>> -        default:
>> +
>> +    if (t86r->hdr.type != TYPE86_RSP_CODE ||
>> +        t86r->cprbx.cprb_ver_id != 0x04) {
>> +        if (reply->len < sizeof(error_reply))
>>               memcpy(msg->msg, &error_reply, sizeof(error_reply));
>> -            msg->len = sizeof(error_reply);
>> -        }
>> -    } else {
>> -        memcpy(msg->msg, reply->msg, sizeof(error_reply));
>> +        else
>> +            memcpy(msg->msg, reply->msg, sizeof(error_reply));
>>           msg->len = sizeof(error_reply);
>> +        goto out;
>>       }
>> +
>> +    switch (resp_type->type) {
>> +    case CEXXC_RESPONSE_TYPE_EP11:
>> +        len = t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
>> +        break;
>> +    default:
>> +        memcpy(msg->msg, &error_reply, sizeof(error_reply));
>> +        msg->len = sizeof(error_reply);
>> +        goto out;
>> +    }
>> +
>> +    if (len != reply->len) {
>> +        pr_warn_ratelimited("len %zu rpl.len %zu mismatch => 
>> EMSGSIZE\n",
>> +                    len, reply->len);
> 
> same here
> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>> +    }
>> +    if (len > reply->bufsize || len > msg->bufsize) {
>> +        pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
>> +                    len, reply->bufsize, msg->bufsize);
> 
> same here
> 
>> +        msg->rc = -EMSGSIZE;
>> +        goto out;
>> +    }
>> +    memcpy(msg->msg, reply->msg, len);
>> +    msg->len = len;
>> +
>>   out:
>>       complete(&resp_type->work);
>>   }
> 

