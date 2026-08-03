Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B5213B961B;
	Mon,  3 Aug 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748229; cv=none; b=tG/eQR8DnURTxArJiNV0RqiQrMnS6J2ZiYg3a9cfLbrbiyXBEsdksixdWDS1kIGRRAQ0fQRUH9d+kyEW9LOf26Vxe40W5swvjsGzscH5Qt7jU0aDYMYa6SPnL6A60qIR1pk7GL2fyZbUEHlEDjw1c60hODM2A6ga4VWtZG9qx7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748229; c=relaxed/simple;
	bh=2VL0gj57AHtR9TuB2gjU0ih10v3CWwrdXO9PQfolceY=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=UtlQzOZRZUu99Mw9APU56QRE0dJCzIbQj0XC53D24X8GO3M43lxHcE+Gdv8j8eHfdR7qSaFM9veixRhrw8mPVNr+Ui73eoy/XyyvgAUTguoRlrjo33eZ0x9kQ0YSKZbRly38sPvablVoXnTlXerKe4J23en9GiXwlO4WdHm+M8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GhlqpniU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GhlqpniU"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672Lllwb243753;
	Mon, 3 Aug 2026 09:10:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=enciRw4rag5AFKjo6tsCyJWrSL2rACIMWzz4dMD7ArU=; b=GhlqpniUyuft
	mfwcAAiMF5G14YWab0uwzHyt6dDc/ws0S7wZjadaFk8Dxzy6l1eRjbE0tBe+TQRN
	qXG9k7E77bnUTGxCKMKyhPU022p1dUz2UrA3gXkxOkO8AbhE7FCrI++EdnUlArhV
	lb/6dkN80DX7eIGthDXCNAx3aeJBedHxJeo2RMP/2Wy/eusBCoV+TbB/oTFK1QJx
	/gCa6+EeFvBsLSSzgKxWttfmeGQ4r4JHFws+J8c0lerzQWBrfHdVaXnJaXGGk+bR
	E7UsWJ/7q1qYpbPOyfeg8q0VdeeugD1n7lVAbk3mmmxJP8iC+Quce+3cca0Qq4wp
	lCnV+CrJQg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h4qvyb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:10:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738uMVF013221;
	Mon, 3 Aug 2026 09:10:25 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsugvvrd6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:10:25 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6739AOKI12845738
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 09:10:24 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 781005805D;
	Mon,  3 Aug 2026 09:10:24 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35CF658055;
	Mon,  3 Aug 2026 09:10:24 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 09:10:24 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 11:10:23 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik
 <gor@linux.ibm.com>
Subject: Re: [PATCH v11 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260803090427.81AF31F000E9@smtp.kernel.org>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-3-freude@linux.ibm.com>
 <20260803090427.81AF31F000E9@smtp.kernel.org>
Message-ID: <397232af830f5c0f791959983b0b7396@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX5yjNS/XCz0wt
 Qv0/RYYMznOgAOumPxwAYL6SpsVipVcjtbVN8m1B6CgJofaXIr+PsSrMofYXtb1MCmqY8SN3Mh7
 44Qvc85pHJIA1mgLuweWYKp81KZcLBc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX70XgOWLSZR0Z
 6QLZ1h9oyJXAaDaOIuz+3V4J4li3vaBIdcvyts/dV436cw5UtS+MQTZBD4GkDN7XM+aWBMV/yw0
 99dKbMccAIXrkGY/JkyWYmk3rpEP3+5dw7OPUeb5ynmlY1ju2ulRYHi+XxzvobAp3s1H2h7gKJp
 yVqF2d2Lo6MznrDOKm1Ejf9EK+5PoxWebNywoM4tKthBytx9EGrTfjs67lfxuMkiDzCev2e3zH5
 sPmrG+R/jwhbBQ+kJH6LzQGc2lLtYfXX8iMkyaZiW8ypyvN2GFVaCoXElBukK8vIeQLFwUuFfX9
 5H/6hXtJyOW1GO5B27Qj5KXsCa8vhZXVwEcopZ3u/VocOi8fvJQq66F1HVn0ybGYWRxMaZyDq+d
 EankdiuPqimdILBl2GTigYdYQ37/J4UbHGPCP3QjvqBwOYUzihQK8Py5l8nu+pMLxqpPYLzMnG1
 DrDfvggFz7zMNGWVthw==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a705b02 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=njc2o0LNXeiAGBJAAbsA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: M9MR5jSVreUUUdZqnEQ2zX07Irvqlolj
X-Proofpoint-GUID: M9MR5jSVreUUUdZqnEQ2zX07Irvqlolj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608030077

On 2026-08-03 11:04, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> New issues:
> - [High] Out-of-bounds read into uninitialized padding due to relaxed
> bounds check.
> 
> Pre-existing issues:
> - [High] Missing minimum size validation for EP11 requests allows
> uninitialized memory access.
> --
> 
> --- Patch [2]: [PATCH v11 2/5] s390/zcrypt: Improve CCA CPRB length
> and overflow checks ---
> commit 91475dced80fa0f4ff3795e01d4bba627b9d0bfe
> Author: Harald Freudenberger <freude@linux.ibm.com>
> s390/zcrypt: Improve CCA CPRB length and overflow checks
> 
> This commit improves length and overflow validations for CCA CPRB 
> structures.
> It updates calculations to use size_t, adds U32_MAX boundary checks, 
> and
> enforces minimum control block size requirements.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 40f72cdf284d3..3e19e79d747cf 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -404,8 +394,8 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  			     xcrb->request_control_blk_addr,
>>  			     xcrb->request_control_blk_length))
>>  		return -EFAULT;
>> -	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
>> -	    xcrb->request_control_blk_length)
>> +	/* copy subfunction code into AP msg type 6 function code field */
>> +	if (msg->cprbx.cprb_len > req_cblen - 
>> sizeof(msg->hdr.function_code))
>>  		return -EINVAL;
>>  	function_code = ((unsigned char *)&msg->cprbx) + 
>> msg->cprbx.cprb_len;
>>  	memcpy(msg->hdr.function_code, function_code,
> 
> [Severity: High]
> Does this change allow an out-of-bounds read into uninitialized 
> padding?
> 
> The bounds check was relaxed from checking against
> request_control_blk_length to checking against the 4-byte aligned 
> req_cblen.
> 
> If a user supplies an unaligned xcrb->request_control_blk_length (e.g., 
> 37)
> and sets msg->cprbx.cprb_len to point into the uninitialized padding
> (e.g., 38), it appears up to 2 bytes of uninitialized kernel heap 
> memory can
> be read into msg->hdr.function_code and subsequently sent to the
> cryptographic hardware.
> 
> [Severity: High]
> This is a pre-existing issue, but could we apply similar minimum size
> validation to xcrb_msg_to_type6_ep11cprb_msgx() for EP11 requests?
> 
> When a user calls the zcrypt ioctl for an EP11 request with an 
> undersized
> xcrb->req_len (e.g., 0):
> 
> drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx() 
> {
>     ...
>     if (z_copy_from_user(userspace, msg->userdata,
>                          (char __force __user *)xcrb->req, 
> xcrb->req_len)) {
>     ...
> }
> 
> User-supplied data is copied using the user-controlled length without
> verifying it meets the minimum required size for the struct fields that
> are subsequently accessed.
> 
> This allows uninitialized heap memory in ap_msg->msg to dictate control 
> flow
> and be sent to the cryptographic hardware when reading fields like
> msg->pld_lenfmt or msg->cprbx.flags.

see #5 of this patch series
