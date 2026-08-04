Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC1380FEE
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 15:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785856877; cv=none; b=uquStpMpT2XLqGLGhLerSWICokanQjZDRWRYtYsyJkSOEAkE30oZMycR2NF2G+F5qOHnKv7ctDoJuWtcCA9C0VVYgZzbjh0tAydSj5lCqldQC06KwYiBO1bRI0UMQYz4ps2t0L1fwqCNs3OQUB0lEvzmoA5xnTAXSjORM78OxT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785856877; c=relaxed/simple;
	bh=9cfUjb2ld8zAS9rxLwp2EC7VD51SPS/+bR9q+83Ck18=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=boY3Pq8nvb1bR7LKhBMKxhgVMYjUgAwjcyXWDlOkx6SehreascxWMsgjocUNnL4FbvSpX/KIK2WsbvxDXb8I9r5f1RLJAbzYKd9laaG5I0HIyy4hfLOnLKVqeRmYu14yqBwIgUoyJmUPlCF8laOogxbbkuh1/5/oC3G78kEAzO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tRfR1Wg7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tRfR1Wg7"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 674Cldul863339
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 15:21:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=agAkEf+Zoa08VtuaayF9El3uETfffmyz+yl7iZZcYAI=; b=tRfR1Wg7wM+F
	KAhNz7TR2nrRFko+p7SsG8hy4Kp3bBzi97HWOKJehwlOXiKCeaNeXdn9NAm6QaZT
	YdRvmRkk4wLcrV+PHyELovqjVzmxn8ItEgqNuIsSYhjdFUubL29XMZ1gVCKxasN3
	H2/TZvUrVBBz+qDsTZwGlhDpv2wIpxGr9QqXHfCPHFr+XBHIiYqp6mwHBxHl1oxQ
	sNeGY4EawjZbXeCfArPJwwlC1pcPvZBMbYUPPXw7DFpkyDubwb9MZlDdZHf5Ltsm
	HtKIoeVfkRot+fXpDT/sanFgL7SA3vmboQnE3OjNCyTWLLmctQQeoge16/dnO5bv
	l3kUDEi3wA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8a3xh9x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 15:21:14 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 674FBHTW013355
	for <linux-s390@vger.kernel.org>; Tue, 4 Aug 2026 15:21:13 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugw2khu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 15:21:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 674FLCY77537264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Aug 2026 15:21:12 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 51FD45805F;
	Tue,  4 Aug 2026 15:21:12 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEE165805C;
	Tue,  4 Aug 2026 15:21:11 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Aug 2026 15:21:11 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 04 Aug 2026 17:21:11 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Holger Dengler <dengler@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev
 <agordeev@linux.ibm.com>
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <995f0618-ff76-4bd5-a0fc-4592ecd13484@linux.ibm.com>
References: <20260710151005.79765-1-freude@linux.ibm.com>
 <20260710151005.79765-2-freude@linux.ibm.com>
 <995f0618-ff76-4bd5-a0fc-4592ecd13484@linux.ibm.com>
Message-ID: <dc9981b471164ee322c7bf4367100050@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=E6P9Y6dl c=1 sm=1 tr=0 ts=6a72036a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=QrogSGZlYnRMzEWw5ogA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: FartjvkfSiyE9-TdQu4PsYW1KxQDHfhQ
X-Proofpoint-GUID: FartjvkfSiyE9-TdQu4PsYW1KxQDHfhQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfXyw4oSDXhcrLg
 ASqaCUPpukX3f+HL0XzB+KJ4ilqW1zxW7tNC2HQuovfbk9uHl0gsGw7n0gwZqJfs/iu1ASwXLhC
 7f2rFnZOAE/9GotrCifo1DqHVZu23sA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDEyMyBTYWx0ZWRfX61p30M/mVvmM
 PxkBeThOFBQ32jQ7moCQqsLy2jJ61cgqXSid/2tCBhrE4rEEN0xz/GEEDOrPk+rCBohY6CZwRZF
 eOf90FRuBRdkseZqIk+rCTErwaYIpYFqLzEqjbGRtFkQ/NScp+IqEhrbnDACiz38yPRpXThFzZe
 yyrizDnfMdBy/9xyQtVC9LbVpT2PJAh1JYss49RQOMdmmAI/VSxeU76uXEOY57Mpsy9uP1k2FSJ
 BhR82WKpkRW0+a5FzYbdI/tqko4MOcqkKyV7sgmMWNWpdSxEZxg7udqIOac9HMLNq5u9ppvOwNk
 TUG28yzVQ8TeOdzKfrdcjqnTve9buujFTi7glacXscUFrBa7bSu5Cs+GKKacAoDG2Pj1kG0DFaa
 jZ4jX7YZf40ihOAHPyBoNWh9dmB7h/19k1IbsWHmrGx3v5XhPATCMBz+RMrevvu/BD4Bzx3LY8S
 FWojMyAtzd8KZBT2ikw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_03,2026-08-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 impostorscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608040123

On 2026-07-13 15:21, Holger Dengler wrote:
> On 7/10/26 17:10, Harald Freudenberger wrote:
>> Add or improve checks related to buffer sizes and reply sizes to the
>> handling of replies from the crypto cards for CCA and EP11 (AP message
>> type 6) messages. The verification code related to reply field length
>> was not designed well and thus firmware deficiencies could lead to
>> unexpected behavior in the zcrypt device driver. Thus improve the code
>> to more closely inspect especially length fields at message replies.
>> 
>> The 3 hunks of this patch deal with CCA, EP11 and (CCA) RNG replies
>> and improve the checking for reply buffer size by using size_t instead
>> of int. RNG replies an additional check makes sure the hard coded
>> limit of the data buffer is not exceeded. Also there was a condition
>> with additional data for an CCA reply where some of the field values
>> where unchecked used to invoke memcpy into user
>> space. zcrypt_msgtype6_receive() now checks all the relevant fields
>> before convert_type86_xcrb() uses them.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Cc: stable@vger.kernel.org
> 
> See my comments below.
> 
>> ---
>>   drivers/s390/crypto/zcrypt_msgtype6.c | 42 
>> ++++++++++++++++++++++-----
>>   1 file changed, 34 insertions(+), 8 deletions(-)
>> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 40f72cdf284d..8252fd185663 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> [...]
>> @@ -863,7 +870,8 @@ static void zcrypt_msgtype6_receive(struct 
>> ap_queue *aq,
>>   	    t86r->cprbx.cprb_ver_id == 0x02) {
>>   		switch (resp_type->type) {
>>   		case CEXXC_RESPONSE_TYPE_ICA:
>> -			len = sizeof(struct type86x_reply) + t86r->length;
>> +			len = (size_t)sizeof(struct type86x_reply) +
>> +				(size_t)t86r->length;
> 
> Is the explicit cast for sizeof() really necessary. I would assume,
> that the following should be sufficient:
> 
> 	len = sizeof(struct type86x_reply) +
> 		(size_t)t86r->length;
> 

Yes - removed.

>>   			if (len > reply->bufsize || len > msg->bufsize ||
>>   			    len != reply->len) {
>>   				pr_debug("len mismatch => EMSGSIZE\n");
>> @@ -874,10 +882,27 @@ static void zcrypt_msgtype6_receive(struct 
>> ap_queue *aq,
>>   			msg->len = len;
>>   			break;
>>   		case CEXXC_RESPONSE_TYPE_XCRB:
>> -			if (t86r->fmt2.count2)
>> -				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
>> -			else
>> -				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
>> +			len1 = (size_t)t86r->fmt2.offset1 +
>> +				(size_t)t86r->fmt2.count1;
>> +			if (t86r->fmt2.offset1 > reply->len ||
>> +			    t86r->fmt2.count1 > reply->len ||
>> +			    len1 > reply->len) {
> 
> Wouldn't it be sufficient to check only (len1 > reply->len)? If
> (t86r->fmt2.offset1 > reply->len) is true, than also (len1 >
> reply->len) will be true (and the same for count1).
> 
> Or did I miss something?

Well this calculation is tricky. So let me summarize what I think should 
be checked:
1) offset1 should lie in the buffer
    ==> offset1 < reply->len should be true
2) the block should fit into the buffer
    ==> count1 <= reply->len should be true
with that it is clear and no need to check that the end (offset1 + 
count1)
is also covered:
    ==> offset1 + count1 <= reply->len should then be implicitly true

Maybe have a look at v6 of this code. I reworked this again and now it 
clearly
distinguishes between validations of the message fields (count, offset) 
and
checks about length of messages and buffer sizes.

> 
>> +				pr_debug("len mismatch => EMSGSIZE\n");
>> +				msg->rc = -EMSGSIZE;
>> +				goto out;
>> +			}
>> +			if (t86r->fmt2.count2) {
>> +				len2 = (size_t)t86r->fmt2.offset2 +
>> +					(size_t)t86r->fmt2.count2;
>> +				if (t86r->fmt2.offset2 > reply->len ||
>> +				    t86r->fmt2.count2 > reply->len ||
>> +				    len2 > reply->len) {
> 
> Same here.
> 
> [...]
