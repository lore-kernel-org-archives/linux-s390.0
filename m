Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD9247C0EA;
	Fri, 11 Sep 2026 12:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789131179; cv=none; b=aaICZZ3Ejmp/kcrcWcsLgVlwAV0qzL+sxHxxOAQ8LcvME83Tm+ygOzw9+keKcS+Y1uTjcNQDgCNexRqfcDeGaAELxL48ONmB1NsoxyvnSaRLf6gHOT3xBT6Jjdya37BTlsf5KW/gzuIk9j2r9Ep2WJGnF8atqJwFOLO8PYPeXAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789131179; c=relaxed/simple;
	bh=Pw10lXRPwvD+YiMgaxy5ISWfwtaiUerIr4kthFOyt6U=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=MB0Ol47G8f6GKfUVYPmvneQG9kWzfkH/X7M+N1nwbNYPpFjc0XJ5JbnPV4tWIsdCg/YE9OzaH5MsiwW/lnwiDxJ1Zv3n92L1MKtGr7nqwUB8NsZwF3aOMd4uAFiD9yUb+tupz9zG2OfLRmUSCOk5HSYul1BcViPJFaShpLy6ff8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=TWK79QH9; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="TWK79QH9"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68BB1rP41460618;
	Fri, 11 Sep 2026 12:52:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=toepEvovBlBVyIQ4Qc5eVaH2geLLqDWJiAenLWnfPwU=; b=TWK79QH9FfxX
	YUMej21a3LgwRMwDgaTcg/QBcQbV6GfbzYL/AkfklPMDKRICLj4xxJ480TuXz2B8
	gGXK5kS9WediaV9viDIrfJUzzN7edB9KjNZpOOhiuN1Akhy1QpEZEMWzPB1ubLld
	bA6ZanNeamFZYKVlll7U1KXizIVYakoLxdCVBJFxOkzMQVb+lZ5PlsVBmjRdiDCO
	VuRuWlE8GSlW58Yd0+0IJ9zQpIZ9FqksNzxC+lylIikIg6RXH9ohE0HdaCIEQG0x
	m06QXxnKMhsAVpo+qO6swVJ7kWAaxrhjBO1tv17ny1JNbwum1sBHoTDC7CA3cfTd
	hrSvOJByIQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gkd8sbe9m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:52:56 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68BCo41O1676551;
	Fri, 11 Sep 2026 12:52:55 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gkvmhpd8a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Sep 2026 12:52:55 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68BCqs8W26542614
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 11 Sep 2026 12:52:55 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CF44F5805E;
	Fri, 11 Sep 2026 12:52:54 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7D75358051;
	Fri, 11 Sep 2026 12:52:54 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 11 Sep 2026 12:52:54 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Fri, 11 Sep 2026 14:52:54 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH v3 1/1] s390/zcrypt: Fix and improve zcrypt reply message
 verification checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260910163532.CD2F61F000FF@smtp.kernel.org>
References: <20260910161906.36251-1-freude@linux.ibm.com>
 <20260910161906.36251-2-freude@linux.ibm.com>
 <20260910163532.CD2F61F000FF@smtp.kernel.org>
Message-ID: <1afaaa7339badac67456109db7d79b18@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: rJIZE7HPIJcERRe7sjCSj9CETYZzlAGh
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfX7xQY89cKs7uM
 MtWaK/dfRpCAAx1z0sOUOQyrPATAr27PrZxPugKHkdXFUDjBLnL0jTHh9MAG4xYc1wB8gtP8wz/
 s3UD5FfTCXtamOXNbpD9uGnzfNi12v7hkhHIRr1veUBNzA021tF5gC1W4mSanLrmEuCUHj3bns3
 BsPb8wVFAFN0XoDzjj9d2ciwFdpBR5C9DPqB7Tc9zeIvRycEBD1Xu8NDPb351qYZVHsvAR4aEoi
 G+9GC9KFqjoAk0l8wVeStT0J3xGl3DjLQl9YzVROto/WVpEKS4JUeh8fHG+PGYm0a4sfO4PyLn7
 Hd+ZSV0U2OrNiELpaZbZgTj/0Hq9LKSNZ2J+j3DHBjzS+KE13mEdHQ7tsY4ccR2IIhEOeDAfgPw
 sapBchT4oOolwNaHxQTqONAP4DHL3f8ZUw0J2USWJ3cHyH+qoXEMEhk8J3se++Ax2Pf1euSxe4I
 tlDXs5D/9oRraLjA3uA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTExMDE3NiBTYWx0ZWRfX9bKQbf+9JQc7
 yQINfLtKrgnsjLSlTzsRf1VBRDb2LMCJZsdZLdjrS17cnjiH0gRgLZCVvQ7sCTRLNv32ruuLHud
 ndrQdAueqFZ2uvNUWNnHH0TX4XHHq1g=
X-Authority-Analysis: v=2.4 cv=MpXHeGae c=1 sm=1 tr=0 ts=6aa3f9a8 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=dOyH9hSqfUK5H4-rlsIA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: rJIZE7HPIJcERRe7sjCSj9CETYZzlAGh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-11_04,2026-09-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 adultscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609110176

On 2026-09-10 18:35, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> - [High] Legitimate XCRB and RNG responses will be spuriously rejected
> due to enforcing an incorrect minimum length of sizeof(struct
> type86x_reply).
> --
> 
> commit 991141a9c29feb41fbfdd37e1610a682977e72b6
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Fix and improve zcrypt reply message verification checks
> 
> This commit adds and improves checks related to buffer sizes and reply 
> sizes
> for CCA, EP11, and ICA messages in the zcrypt driver. It adds length
> validation before accessing reply message structures to prevent 
> out-of-bounds
> reads. It also reworks payload evaluation functions.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 3df1d676de5d8..a7d392272cfa2 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> [ ... ]
>> @@ -820,6 +833,8 @@ static int convert_response_xcrb(bool userspace, 
>> struct zcrypt_queue *zq,
>>  {
>>  	struct type86x_reply *msg = reply->msg;
>> 
>> +	/* reply->len is always >= sizeof(struct error_hdr) here */
>> +
>>  	switch (msg->hdr.type) {
>>  	case TYPE82_RSP_CODE:
>>  	case TYPE88_RSP_CODE:
>> @@ -827,9 +842,14 @@ static int convert_response_xcrb(bool userspace, 
>> struct zcrypt_queue *zq,
>>  		return convert_error(zq, reply);
>>  	case TYPE86_RSP_CODE:
>>  		if (msg->hdr.reply_code) {
>> -			xcrb->status = msg->fmt2.apfs;
>> +			if (reply->len < sizeof(struct type86_fmt2_msg))
>> +				xcrb->status = 0x0008044DL;
>> +			else
>> +				xcrb->status = msg->fmt2.apfs;
>>  			return convert_error(zq, reply);
>>  		}
>> +		if (reply->len < sizeof(struct type86x_reply))
>> +			return -EINVAL;
> 
> [Severity: High]
> Does this code incorrectly reject legitimate XCRB responses?
> 
> It appears that this check assumes XCRB replies use the large 
> ICA-specific
> type86x_reply struct. If a userspace application sends a valid XCRB 
> request
> without a data payload, the hardware replies successfully without 
> padding.
> 
> While zcrypt_msgtype6_receive() correctly computes len as offset1 + 
> count1
> and verifies it exactly matches the hardware reply length, this check 
> evaluates
> reply->len < sizeof(struct type86x_reply). Since type86x_reply includes 
> 6
> additional bytes (pad[4] and length) intended only for ICA responses, 
> its size
> is larger than an empty-payload XCRB response.
> 
> Could this result in valid XCRB responses being rejected with -EINVAL,
> causing a regression for userspace applications using the ICAXCRB 
> ioctl?
> 

Will fix this in the next version.

>>  		if (msg->cprbx.cprb_ver_id == 0x02)
>>  			return convert_type86_xcrb(userspace, zq, reply, xcrb);
>>  		fallthrough;	/* wrong cprb version is an unknown response */
> [ ... ]
>> @@ -885,6 +909,8 @@ static int convert_response_rng(struct 
>> zcrypt_queue *zq,
>>  {
>>  	struct type86x_reply *msg = reply->msg;
>> 
>> +	/* reply->len is always >= sizeof(struct error_hdr) here */
>> +
>>  	switch (msg->hdr.type) {
>>  	case TYPE82_RSP_CODE:
>>  	case TYPE88_RSP_CODE:
>> @@ -892,6 +918,8 @@ static int convert_response_rng(struct 
>> zcrypt_queue *zq,
>>  	case TYPE86_RSP_CODE:
>>  		if (msg->hdr.reply_code)
>>  			return -EINVAL;
>> +		if (reply->len < sizeof(struct type86x_reply))
>> +			return -EINVAL;
> 
> [Severity: High]
> Does this check similarly apply a logically flawed minimum-size limit 
> to RNG
> hardware responses?
> 
> It seems this could fail if the hardware RNG response buffer size
> configuration ever drops below the 6-byte delta caused by the 
> ICA-specific
> padding in type86x_reply.
> 

Does not apply. A valid RNG reply always need to be >= sizeof(struct 
type86x_reply)
and even more. However to access the fields cprbx.ccp_rtcode and 
cprbx.ccp_rscode in
function convert_type86_rng() this check is a precondition.

>>  		if (msg->cprbx.cprb_ver_id == 0x02)
>>  			return convert_type86_rng(zq, reply, data);
>>  		fallthrough;	/* wrong cprb version is an unknown response */
