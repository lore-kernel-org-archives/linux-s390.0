Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ACE330DD22
	for <linux-s390@vger.kernel.org>; Thu,  6 Aug 2026 05:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993771; cv=none; b=J8ItVaM5fmfIqtQH2IkoGvDE71SWAPwSPNbkCZjxcLXrgfqa5snopQwyHqSSe6zSkRxIQBEZoBJKZjg7b0irB552sOFiziKVd4VN3VPGXw8YFtX1bm+ouH+TPkWwQ+17oLp++axhGIW34caqDS3aCL/Vj5Fi60rpbfuPu8W7neA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993771; c=relaxed/simple;
	bh=4KFRDLBFn2NjbqwkZzWWk53eD6EZmU7kqrhhuLPDAuU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GL6SSnmft4PO7uindfkCZlcaulSbGvYucRPdcseEGCV8/5Gk/MsO5NMq1MZoxM5X3ORo5nVZppG2glsah7rLYS3/R1KFYe/ldkVbfjgHhnCVwpi1x9xABQBVeN3/e15ctDiVEByuTyc+meLA89OYIlqdgdzQFQHlNpj9OsN+SXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GeCSKmoi; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GeCSKmoi"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NmV5l994940
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 05:22:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sr2j+b
	wSYlb1N58CgvlMtSMHx7cro1qx26z9AjV3v9c=; b=GeCSKmoiihR5oLnI1P4PZw
	Trx/Wu2qvxAzYo14SI5K2Kh/je/a22q/xnmA+uRHH2uBZ4YG0LKnYKIZgaOyGUol
	7tkQddQgzI0FqZH1UhzZ4UWIHam1CqEqoEhj2zbClfFyp5XQ55ejIdfN5pjqNFKR
	BNuQE0aAPqjX81sXIv4Kr11hTtPJR1geS+sqbFLDIh4ignCpuzTp6P3bVvFLzR31
	b5CMxJo7i5ELl8+FJWW/dLqhHSk+iWWoAumrsNj81MNtfBIj2d1m+xIj18p2hkj3
	1vQmns2xy/PT0uUzWCqp+GUN4/uliHy/LiYFzN24t+dUcIPA9GH0uQAlmAxqZnng
	==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs67hx7kj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 05:22:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6765BK0K003107
	for <linux-s390@vger.kernel.org>; Thu, 6 Aug 2026 05:22:47 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsvmhhpy7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 06 Aug 2026 05:22:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6765MgIZ51970400
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 05:22:42 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BDE5920043;
	Thu,  6 Aug 2026 05:22:42 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 93E9D20040;
	Thu,  6 Aug 2026 05:22:42 +0000 (GMT)
Received: from [9.224.87.205] (unknown [9.224.87.205])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 05:22:42 +0000 (GMT)
Message-ID: <bbd320da-c0fc-4fdd-8e19-e4dd4d7b6e41@linux.ibm.com>
Date: Thu, 6 Aug 2026 07:22:42 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
To: Harald Freudenberger <freude@linux.ibm.com>, dengler@linux.ibm.com,
        ifranzki@linux.ibm.com
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260804144926.241039-1-freude@linux.ibm.com>
 <20260804144926.241039-2-freude@linux.ibm.com>
Content-Language: en-GB
From: Finn Callies <fcallies@linux.ibm.com>
In-Reply-To: <20260804144926.241039-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX8oYIKZx8i6b4
 HTAkVwg8whnOa/HXWWpySIVNKw0o8ayk7aha2VXTwvXn8AyrsZx4fblYOcha0aIsRpqT9H4INu1
 mYD4Xa2h2oSZa+0RZ65dH96atczt1Rw=
X-Authority-Analysis: v=2.4 cv=I7VVgtgg c=1 sm=1 tr=0 ts=6a741a27 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ftbQInSDeYyPVs8ZUbQA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDAzOCBTYWx0ZWRfX/x0BZqZuqHSH
 ffJ1CP1knSJ/N9mraLDq6didphrrqyApzzpxXE6wG3H4Ifh11WZuMv78rXIp95WfRTzYOgGNq5M
 mCtzMa+F8+b3ARJlnDD3k9ABQ8cUGuk2yjSGHfiWXfYLPNerNjCKfECvx7eUwxH2fzfljmBsRtQ
 xbwg4D/TtO7aVZsbXcpxkEncl5xrFSVb9GOZNS/Q6cBqHrf4e1qvhpoOWlhC6ygSyzuPtEdCcH4
 vLHvcG9r6jFRQNTe99EBfavPhJXVZw6MIFBwgWQhFjXrjH75I+TXJIejlgQTgJ8fhcD7zf6SXc2
 yPymwfimErkoiwcIP9NvIHYaBSPnYoR3+Ijvo8t/QSXkUrIYSN9IIGLBaCPghxdWSMfe4dMr9Rn
 6JnRUvNTk8W3COVpa2C9MUALRXa9n422IVOMxL4jPYrurKyUL7MVEtM01/7WTgZ9v269ZwuiCmF
 ksqUAr7XHH9sJoHJDRA==
X-Proofpoint-ORIG-GUID: aDw6uaxoTo04rLbm7FV5_aSthyQmPaXB
X-Proofpoint-GUID: aDw6uaxoTo04rLbm7FV5_aSthyQmPaXB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 malwarescore=0 adultscore=0 lowpriorityscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060038



On 04.08.26 16:49, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA, EP11 (AP message
> type 6) and ICA (AP type 50) messages. The verification code related
> to reply field length was not designed well and thus firmware
> deficiencies could lead to unexpected behavior in the zcrypt device
> driver. Thus improve the code to more closely inspect especially
> length fields at message replies.
> 
> Rework zcrypt_msgtype6_receive(), zcrypt_msgtype6_receive_ep11() and
> zcrypt_msgtype50_receive() to validate reply lengths more carefully
> before copying data back into the request buffer. Use size_t for
> length calculations, reject inconsistent reply sizes, and add
> defensive handling for short invalid replies. For XCRB replies,
> validate both reply segments and derive the effective message length
> from the covered range instead of trusting only the second segment.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/s390/crypto/zcrypt_msgtype50.c |  39 ++++---
>   drivers/s390/crypto/zcrypt_msgtype6.c  | 151 ++++++++++++++++---------
>   2 files changed, 126 insertions(+), 64 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype50.c b/drivers/s390/crypto/zcrypt_msgtype50.c
> index d6fc2d8e7fad..ef925b399806 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype50.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype50.c
> @@ -416,26 +416,39 @@ static void zcrypt_msgtype50_receive(struct ap_queue *aq,
>   		.reply_code = REP82_ERROR_MACHINE_FAILURE,
>   	};
>   	struct type80_hdr *t80h;
> -	int len;
> +	size_t len;
>   
>   	/* Copy the reply message to the request message buffer. */
>   	if (!reply)
>   		goto out;	/* ap_msg->rc indicates the error */
> +
>   	t80h = reply->msg;
> -	if (t80h->type == TYPE80_RSP_CODE) {
> -		len = t80h->len;
> -		if (len > reply->bufsize || len > msg->bufsize ||
> -		    len != reply->len) {
> -			pr_debug("len mismatch => EMSGSIZE\n");

I don't like this debug statement, its very undescriptive. What is len? 
What does it mismatch against? What does the mismatch mean?

The "=> EMSGSIZE" looks very uncommon for me as well, is this a common 
way of logging error paths?

> -			msg->rc = -EMSGSIZE;
> -			goto out;
> -		}
> -		memcpy(msg->msg, reply->msg, len);
> -		msg->len = len;
> -	} else {
> -		memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +
> +	if (t80h->type != TYPE80_RSP_CODE) {
> +		if (reply->len < sizeof(error_reply))
> +			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
>   		msg->len = sizeof(error_reply);
> +		goto out;
> +	}
> +
> +	len = t80h->len;
> +	if (len != reply->len) {
> +		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
> +				    len, reply->len);

Same here. What is len? rpl.len is a technical statement, but logs 
should be descriptive right?

> +		msg->rc = -EMSGSIZE;
> +		goto out;
>   	}
> +	if (len > reply->bufsize || len > msg->bufsize) {
> +		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
> +				    len, reply->bufsize, msg->bufsize);

Why buf instead of buffer? Why safe space here?

> +		msg->rc = -EMSGSIZE;
> +		goto out;
> +	}
> +	memcpy(msg->msg, reply->msg, len);
> +	msg->len = len;
> +
>   out:
>   	complete(&msg->response.work);
>   }
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 3df1d676de5d..b98449913e24 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -766,6 +766,13 @@ static int convert_type86_rng(struct zcrypt_queue *zq,
>   
>   	if (msg->cprbx.ccp_rtcode != 0 || msg->cprbx.ccp_rscode != 0)
>   		return -EINVAL;
> +	/*
> +	 * Note that offset2 and count2 have already been checked in
> +	 * zcrypt_msgtype6_receive(). So only check for not exceeding
> +	 * the hard coded rng buffer size.
> +	 */
> +	if (msg->fmt2.count2 > ZCRYPT_RNG_BUFFER_SIZE)
> +		return -EMSGSIZE;
>   	memcpy(buffer, data + msg->fmt2.offset2, msg->fmt2.count2);
>   	return msg->fmt2.count2;
>   }
> @@ -928,48 +935,75 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
>   	};
>   	struct ap_response_type *resp_type = &msg->response;
>   	struct type86x_reply *t86r;
> -	int len;
> +	size_t len, len1, len2 = 0;
>   
>   	/* Copy the reply message to the request message buffer. */
>   	if (!reply)
>   		goto out;	/* ap_msg->rc indicates the error */
> +
>   	t86r = reply->msg;
> -	if (t86r->hdr.type == TYPE86_RSP_CODE &&
> -	    t86r->cprbx.cprb_ver_id == 0x02) {
> -		switch (resp_type->type) {
> -		case CEXXC_RESPONSE_TYPE_ICA:
> -			len = sizeof(struct type86x_reply) + t86r->length;
> -			if (len > reply->bufsize || len > msg->bufsize ||
> -			    len != reply->len) {
> -				pr_debug("len mismatch => EMSGSIZE\n");
> -				msg->rc = -EMSGSIZE;
> -				goto out;
> -			}
> -			memcpy(msg->msg, reply->msg, len);
> -			msg->len = len;
> -			break;
> -		case CEXXC_RESPONSE_TYPE_XCRB:
> -			if (t86r->fmt2.count2)
> -				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
> -			else
> -				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
> -			if (len > reply->bufsize || len > msg->bufsize ||
> -			    len != reply->len) {
> -				pr_debug("len mismatch => EMSGSIZE\n");
> +
> +	if (t86r->hdr.type != TYPE86_RSP_CODE ||
> +	    t86r->cprbx.cprb_ver_id != 0x02) {
> +		if (reply->len < sizeof(error_reply))
> +			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +		msg->len = sizeof(error_reply);
> +		goto out;
> +	}
> +
> +	switch (resp_type->type) {
> +	case CEXXC_RESPONSE_TYPE_ICA:
> +		len = sizeof(struct type86x_reply) + (size_t)t86r->length;
> +		break;
> +	case CEXXC_RESPONSE_TYPE_XCRB:
> +		len1 = (size_t)t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
> +		if (t86r->fmt2.offset1 > reply->len ||
> +		    t86r->fmt2.count1 > reply->len) {
> +			pr_warn_ratelimited(
> +				"offset1 %u count1 %u rpl.len %zu mismatch => EMSGSIZE\n",
> +				t86r->fmt2.offset1, t86r->fmt2.count1,
> +				reply->len);

same here

> +			msg->rc = -EMSGSIZE;
> +			goto out;
> +		}
> +		if (t86r->fmt2.count2) {
> +			len2 = (size_t)t86r->fmt2.offset2 +
> +				(size_t)t86r->fmt2.count2;
> +			if (t86r->fmt2.offset2 > reply->len ||
> +			    t86r->fmt2.count2 > reply->len) {
> +				pr_warn_ratelimited(
> +					"offset2 %u count2 %u rpl.len %zu mismatch => EMSGSIZE\n",
> +					t86r->fmt2.offset2, t86r->fmt2.count2,
> +					reply->len);

same here

>   				msg->rc = -EMSGSIZE;
>   				goto out;
>   			}
> -			memcpy(msg->msg, reply->msg, len);
> -			msg->len = len;
> -			break;
> -		default:
> -			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> -			msg->len = sizeof(error_reply);
>   		}
> -	} else {
> -		memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +		len = max_t(size_t, len1, len2);
> +		break;
> +	default:
> +		memcpy(msg->msg, &error_reply, sizeof(error_reply));
>   		msg->len = sizeof(error_reply);
> +		goto out;
> +	}
> +
> +	if (len != reply->len) {
> +		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
> +				    len, reply->len);

same here

> +		msg->rc = -EMSGSIZE;
> +		goto out;
>   	}
> +	if (len > reply->bufsize || len > msg->bufsize) {
> +		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
> +				    len, reply->bufsize, msg->bufsize);

same here

> +		msg->rc = -EMSGSIZE;
> +		goto out;
> +	}
> +	memcpy(msg->msg, reply->msg, len);
> +	msg->len = len;
> +
>   out:
>   	complete(&resp_type->work);
>   }
> @@ -992,34 +1026,49 @@ static void zcrypt_msgtype6_receive_ep11(struct ap_queue *aq,
>   	};
>   	struct ap_response_type *resp_type = &msg->response;
>   	struct type86_ep11_reply *t86r;
> -	int len;
> +	size_t len;
>   
>   	/* Copy the reply message to the request message buffer. */
>   	if (!reply)
>   		goto out;	/* ap_msg->rc indicates the error */
> +
>   	t86r = reply->msg;
> -	if (t86r->hdr.type == TYPE86_RSP_CODE &&
> -	    t86r->cprbx.cprb_ver_id == 0x04) {
> -		switch (resp_type->type) {
> -		case CEXXC_RESPONSE_TYPE_EP11:
> -			len = t86r->fmt2.offset1 + t86r->fmt2.count1;
> -			if (len > reply->bufsize || len > msg->bufsize ||
> -			    len != reply->len) {
> -				pr_debug("len mismatch => EMSGSIZE\n");
> -				msg->rc = -EMSGSIZE;
> -				goto out;
> -			}
> -			memcpy(msg->msg, reply->msg, len);
> -			msg->len = len;
> -			break;
> -		default:
> +
> +	if (t86r->hdr.type != TYPE86_RSP_CODE ||
> +	    t86r->cprbx.cprb_ver_id != 0x04) {
> +		if (reply->len < sizeof(error_reply))
>   			memcpy(msg->msg, &error_reply, sizeof(error_reply));
> -			msg->len = sizeof(error_reply);
> -		}
> -	} else {
> -		memcpy(msg->msg, reply->msg, sizeof(error_reply));
> +		else
> +			memcpy(msg->msg, reply->msg, sizeof(error_reply));
>   		msg->len = sizeof(error_reply);
> +		goto out;
>   	}
> +
> +	switch (resp_type->type) {
> +	case CEXXC_RESPONSE_TYPE_EP11:
> +		len = t86r->fmt2.offset1 + (size_t)t86r->fmt2.count1;
> +		break;
> +	default:
> +		memcpy(msg->msg, &error_reply, sizeof(error_reply));
> +		msg->len = sizeof(error_reply);
> +		goto out;
> +	}
> +
> +	if (len != reply->len) {
> +		pr_warn_ratelimited("len %zu rpl.len %zu mismatch => EMSGSIZE\n",
> +				    len, reply->len);

same here

> +		msg->rc = -EMSGSIZE;
> +		goto out;
> +	}
> +	if (len > reply->bufsize || len > msg->bufsize) {
> +		pr_warn_ratelimited("len %zu exceeds buf %zu/%zu => EMSGSIZE\n",
> +				    len, reply->bufsize, msg->bufsize);

same here

> +		msg->rc = -EMSGSIZE;
> +		goto out;
> +	}
> +	memcpy(msg->msg, reply->msg, len);
> +	msg->len = len;
> +
>   out:
>   	complete(&resp_type->work);
>   }

