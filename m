Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A743737E5FB
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:12:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154326; cv=none; b=UCpjw4dj14tktTODn48MBe2aoG8ING1iQABcYxwhcStsf+nm+qleLdwnePaj1lwloSh4mQXiVbsNt4sthMjl1hH9PQRnV0C03o0NRn/m5na8AQ3Z0FaN4rSHNn0QnPADpDv+u9qjjKhMg6FGHrrObIjgx9wPe8jydpm6KEk4k2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154326; c=relaxed/simple;
	bh=uX6O3T9tt/HiYIQUoy9/oxBrkTTu4sJ/RdLNfRVndqE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClKs8oUnLwnjPgzmFstIPMHObwruy/5XVKyIjd5Krb6QsNQHiAElaOUJLUSqIT0tZ4edvtmbaym6/01jl4ZQOevE5q36sFgXKjprUE16KhxqxziUGZ82M8VfLUykLCL8m4aQogn92teYGwVrqYc0S9rYd8Ljp8Uvh7VM4JnvQgo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=R/3GDASJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="R/3GDASJ"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAJ0LH1956947
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:12:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PGYauI
	/qNVYqijX6JkUCLIV1hwDL7fcKgGdqY/pHpaQ=; b=R/3GDASJSDPwnogf6GW5n3
	g9akAr/4UUHEpriy1oPluzA1X2E1NLq3xyz3uP73RsjHNi9a0LESvHzEYLl0LVte
	nCcOGX9eOXGnUUGywPkQWCrWpwLuXNdlLvE18mDdLzMr+KWXswh/ViTci6IIw+sV
	2uXY0NivySFPGGY+JRZcdw/nVRMmsswnwfK3BICP+HuaIw9DF/RkbNm5zmlV/+fA
	nmqRQC1ZxCImYmbZu4sqQoNS7LlYfWso7j8w+Rv/3TSFvEMbXy+u7yG+9ZmVZLra
	AaLOxKlgfts7O463NrX97t1ThpvTTDZyxyKGR6qhmPyKXQd+QKBo5obiiUCgd7Ug
	==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0xfw2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:12:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RCBHrb019298
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:12:02 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pg53gu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:12:02 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RCBxJF17695020
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 12:11:59 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEF152013E;
	Mon, 27 Jul 2026 12:11:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFFF22013D;
	Mon, 27 Jul 2026 12:11:58 +0000 (GMT)
Received: from [9.111.67.171] (unknown [9.111.67.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 12:11:58 +0000 (GMT)
Message-ID: <15a2b581-b04a-4f49-a846-b5d872a17a76@linux.ibm.com>
Date: Mon, 27 Jul 2026 14:11:58 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727083200.151976-1-freude@linux.ibm.com>
 <20260727083200.151976-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260727083200.151976-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: J2WoykAvEEknX-gIvnANyu2_CBOZU_z5
X-Proofpoint-ORIG-GUID: J2WoykAvEEknX-gIvnANyu2_CBOZU_z5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX9suwEftVhKUL
 L8kfdTyVggXHJKd1a618uZ6be3i3tZtU+SR3WFPgxEuoZtRJVySvPPyzQI8zo/9ZVDHYBILkx+O
 d4miMzS2YpXmIFxiavwNHR7YZlWvUEM=
X-Authority-Analysis: v=2.4 cv=dYuwG3Xe c=1 sm=1 tr=0 ts=6a674b13 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=goHlAa6d6fNH7Q_GjdUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfXwebFvWiTzZXQ
 aIyiZNNvvecQwuJcKM9vObiO2s3dfRyNNbQZUlcLrbyFk2f8+XpmgvZtpCUFE37SejDwi3oM9CX
 BMQQHCUa7NEnD7+z4J7ZNULYhC6nIPKDhPpZ0/XE6nCUUayVtwADOfOoGyEpsIKDE3SEviAcXrQ
 3rNXG/If/r2DsjTkhNUC78h035XKStsCVoX/0sxEWOZaLQiqiB9dhrJJdwZXcOzXbOOe8ISdIva
 IMtNqWS4YawUhgcbQx+DusjF3sNSKN1ubx9KLS8sYMmY23o8gLCY8Jo6lKHymrdmz8H1XlXZGWy
 rYDpPlhPPjx/jjU9XuVqqXV7giggynoUEWcVokh2gB5FI9nD+FCBrfTvD5D8J2ldpRWx4YjP1Bl
 y5Mlxs4vvdVBrOuAF88QocfOFXLi8MKkAxOJHNZakqP1LbTzB8Q1h+3VYo9vGRg1NKMChWF8lS4
 8c7yqBdfo8U1pVPTClw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 clxscore=1015 phishscore=0 malwarescore=0
 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116

On 7/27/26 10:31, Harald Freudenberger wrote:
> The xcrb_msg_to_type6cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Integer overflow after CEIL4 alignment: Signed int variables could
>     overflow during 4-byte boundary alignment, causing undersized
>     buffer allocations or incorrect bounds checking.
> 2. Missing minimum size validation: The CPRBX structure is copied from
>     userspace without verifying sufficient buffer length. Undersized
>     buffers cause uninitialized memory access when reading structure
>     fields like cprbx.cprb_len and cprbx.domain.
> 3. Arithmetic overflow in sum calculations: Adding control block and
>     data block sizes could overflow, bypassing size checks and enabling
>     buffer overflows.
> 4. Potential kernel memory leak if copy_from_user() only copies
>     xcrb->request_control_blk_length bytes but the processing of the
>     message works with the rounded up to 4 byte boundary buffer size.
> 
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, validating minimum control block size before
> copying from userspace, and detecting sum calculation overflows. Fix
> the possible kernel memory leak by zeroing the trailing bytes.

The last sentence should go into a separate patch. See my comment below.

> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

The length check looks good so far. Only the min-length check need some 
rework (as discussed).

> ---
>   drivers/s390/crypto/zcrypt_msgtype6.c | 77 +++++++++++++--------------
>   1 file changed, 37 insertions(+), 40 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 40f72cdf284d..2e4aef330b68 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
[...]
> @@ -404,6 +395,9 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
>   			     xcrb->request_control_blk_addr,
>   			     xcrb->request_control_blk_length))
>   		return -EFAULT;
> +	if (xcrb->request_control_blk_length < req_cblen)
> +		memset(msg->userdata + xcrb->request_control_blk_length,
> +		       0, req_cblen - xcrb->request_control_blk_length);

Can you please move this wipe into a separate patch? It is not related 
to the input checking but addresses another class of vulnerability.

I think it is worth to describe this issue/fix in its own commit message.

>   	if (msg->cprbx.cprb_len + sizeof(msg->hdr.function_code) >
>   	    xcrb->request_control_blk_length)
>   		return -EINVAL;[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

