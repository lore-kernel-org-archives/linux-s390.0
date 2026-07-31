Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 622F342C508
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785494147; cv=none; b=HuRqYmY0TFH7CpAaSiiC77xuAesRRRfNVbuKFY1z2Bc5f6OpuQs3YLG6H99QoprACFVwriS4qE9oVjs+woe2bHnR5uZOI9eECdiqA6R7KtUn8dCG++WMbeIEotdx3x6Q/vtQZZGMz5MfIBsRinJzgn4IsNFdvgCl17nY/k218jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785494147; c=relaxed/simple;
	bh=tQwWL/YYeIneM2q7Qbyupf5a0CRpuPcAjsdSOZfH2GU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gvXTd3uUXfDoF1APNzH8hCTloxKDsus4Rp1vHoq5gf0K3gc3fmbc9gjHOqiM8XdA4C5DUzp5WrgeZEVzvv4wQZ6ogXO7LG6KS32FftuI8KwWszJPAv1dCFTm1E6NIxInimB/fzwOemZ/dTwjToOdysLbWrOXf0+jIxcso9YQzAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IJdtWFoW; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IJdtWFoW"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V8HgN81230373
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:35:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=PUJehX
	E7FOW+uOx17hmEw2v8iD54pCdLqCIoPPYgNuw=; b=IJdtWFoWFjSRnSSIeTWh75
	vh9gTaISvQVn8Z+2Ok6fIGFr2Hlt86s8h42GXmZI0epVM0yBV3MiUsJxhOK7vDtZ
	+eW5PjWERIOzaFx5Km4pbrjQbmnVELB+G2BZMdplNTg05szOs7qnV7E+WiYQ+n15
	3pIVWaUp+ZE4jjNKFbVK47KnKeX92fD51mOVRvAVh3xjga5QiTmrCeXaXQvV2fVc
	nDc/dywpK+HgmXHe9GX1ryt06+ZBB6xcBs0CFNxwcyHm4LbToFj7MmY2RxUVKYsW
	jUp4yXitGL5kLQMfL/4dp7twDQ21IdyIHI9d928y1c4vd8Ff/d+ak2utlfNi1KXQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p3grs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:35:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66VAQIga012168
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:35:24 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uwfn6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 10:35:24 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66VAZKhm25559510
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 10:35:20 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4594420043;
	Fri, 31 Jul 2026 10:35:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECDC720040;
	Fri, 31 Jul 2026 10:35:19 +0000 (GMT)
Received: from [9.111.59.130] (unknown [9.111.59.130])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 10:35:19 +0000 (GMT)
Message-ID: <b50da3f2-a3de-43d6-8db4-a796f4437cf4@linux.ibm.com>
Date: Fri, 31 Jul 2026 12:35:19 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, ifranzki@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260730141509.205970-1-freude@linux.ibm.com>
 <20260730141509.205970-3-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260730141509.205970-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfX2fRyOKxlOeQ8
 7E7Zr2McmdtojXoxNXFCMHsIvADAX9kqsY0qH9V/P7urblhzIyE1YFaqm+HvMbVh6Ir+xGUBaWr
 pxEZgmx+NSd3v3J3ywFXMNQMahzoSc8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA3NyBTYWx0ZWRfXw4xN0jPK/3Hw
 OKtnun2LnB2FBYFOfWyoq7bUi/EKJl4/WCuymXTDbvKApZjP//wytk9ugB7Rigbyua4lz3ZJg3/
 f2P2o9kGYySityZ2HJVjMwkypgkmOjR69mI5Tavx3dK1VALnoX+5ZLE6Vdh5N8bymnxQtAv0nND
 6W83l7pR9gxcecV+vllaiZTfY9eRa2EBnPMFygfnXBTVj1mn4aNcIsE7F8YPx9uaptIc2M/Y5AZ
 ISUupk520PboBAggFHd9vOFtENJ/PeTNQgMAdutIqcznZOZGpRkitKT9bxOcQSRHvJ3cMiHxjJj
 o8p80b15/hM/ojhbEN1UFy7BTQXTAXhwPy2LZlywMaFqWZ8u+4UKiOXjqE9cSDGDnWDm4js2mGZ
 a8IZK22YJEzSvckAlRLwlj4aoylK3hlec4btu7MVIThrcGtqiXdltAqjxHK7u8YSVV120hyHT/T
 tVotDVSrE7RCUMxCFtA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c7a6c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=TFtROhQJRlRxTTIoW4YA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: cf3Pva1f6F6YVTeIRcRPx_ww7i7cNbp9
X-Proofpoint-ORIG-GUID: cf3Pva1f6F6YVTeIRcRPx_ww7i7cNbp9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_03,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310077

On 7/30/26 16:15, Harald Freudenberger wrote:
> The xcrb_msg_to_type6cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Integer overflow after CEIL4 alignment: Signed int variables could
>    overflow during 4-byte boundary alignment, causing undersized
>    buffer allocations or incorrect bounds checking.
> 2. Missing minimum size validation: The CPRBX structure is copied from
>    userspace without verifying sufficient buffer length. Undersized
>    buffers cause uninitialized memory access when reading structure
>    fields like cprbx.cprb_len and cprbx.domain.
> 3. Arithmetic overflow in sum calculations: Adding control block and
>    data block sizes could overflow, bypassing size checks and enabling
>    buffer overflows.
> 
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, validating minimum control block size before
> copying from userspace, and detecting sum calculation overflows.
> 
> Fixes: e2c6d91eb8b1 ("s390/zcrypt: Rework domain processing within zcrypt device driver")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org # 7.1+
> ---
>  drivers/s390/crypto/zcrypt_msgtype6.c | 78 +++++++++++++--------------
>  1 file changed, 36 insertions(+), 42 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 40f72cdf284d..fb37e28c8242 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> @@ -342,49 +342,40 @@ static int xcrb_msg_to_type6cprb_msgx(bool userspace, struct ap_message *ap_msg,
>  		};
>  	} __packed * msg = ap_msg->msg;
>  
> -	int rcblen = CEIL4(xcrb->request_control_blk_length);
> -	int req_sumlen, resp_sumlen;
> -	char *req_data = ap_msg->msg + sizeof(struct type6_hdr) + rcblen;
> -	char *function_code;
> +	size_t req_cblen, rep_cblen, req_sumlen, rep_sumlen;
> +	char *function_code, *req_data;
>  
> -	if (CEIL4(xcrb->request_control_blk_length) <
> -			xcrb->request_control_blk_length)
> -		return -EINVAL; /* overflow after alignment*/
> -
> -	/* length checks */
> +	/* request length and overflow checks */
> +	if (xcrb->request_control_blk_length < sizeof(struct CPRBX))
> +		return -EINVAL;
> +	req_cblen = CEIL4((size_t)xcrb->request_control_blk_length);
> +	if (req_cblen > U32_MAX)
> +		return -EINVAL;
>  	ap_msg->len = sizeof(struct type6_hdr) +
> -		CEIL4(xcrb->request_control_blk_length) +
> -		xcrb->request_data_length;
> +		req_cblen + xcrb->request_data_length;
>  	if (ap_msg->len > ap_msg->bufsize)
>  		return -EINVAL;
> -
> -	/*
> -	 * Overflow check
> -	 * sum must be greater (or equal) than the largest operand
> -	 */
> -	req_sumlen = CEIL4(xcrb->request_control_blk_length) +
> -			xcrb->request_data_length;
> -	if ((CEIL4(xcrb->request_control_blk_length) <=
> -	     xcrb->request_data_length) ?
> +	req_sumlen = req_cblen + xcrb->request_data_length;

The req_sumlen is also used for the calculation of ap_msg->len, right?
Why not moving the req_sumlen calculation and checks up and use it there?

req_sumlen = req_cblen + xcrb->request_data_length;
if (req_sumlen > U32_MAX)
[...]
ap_msg->len = sizeof(struct type6_hdr) + req_sumlen;
if (ap_msg->len > ap_msg->bufsize)
[...]

And another question about the aligned buffer lengths:
We have the request-control-block, followed by the request-data. Is only
the request-control-block required to be 4-byte aligned or also the
request-data, or only both together (request-control-block and -data)?

Lets assume, request-control-block and -data length are both not 4-byte
alligned. Do we need the padding between the cprb and the data or at the
end of both blocks or only after data?

Example:
req-ctrl-blk: length 5
req-data: length 5

With only cprb padded (--> req_sumlen: 13)
| req-ctrl-blk[5] | pad[3] | req-data[5] |


With both padded separately (--> req_sumlen: 16)
| req-ctrl-blk[5] | pad[3] | req-data[5] | pad[3] |

With both padded together (--> req_sumlen: 12)
| req-ctrl-blk[5] | req-data[5] | pad[2] |


> +	if (req_sumlen > U32_MAX)
> +		return -EINVAL;
> +	if (req_cblen <= xcrb->request_data_length ?
>  	    req_sumlen < xcrb->request_data_length :
> -	    req_sumlen < CEIL4(xcrb->request_control_blk_length)) {
> +	    req_sumlen < req_cblen) {
>  		return -EINVAL;
>  	}
>  
> -	if (CEIL4(xcrb->reply_control_blk_length) <
> -			xcrb->reply_control_blk_length)
> -		return -EINVAL; /* overflow after alignment*/
> -
> -	/*
> -	 * Overflow check
> -	 * sum must be greater (or equal) than the largest operand
> -	 */
> -	resp_sumlen = CEIL4(xcrb->reply_control_blk_length) +
> -			xcrb->reply_data_length;
> -	if ((CEIL4(xcrb->reply_control_blk_length) <=
> -	     xcrb->reply_data_length) ?
> -	    resp_sumlen < xcrb->reply_data_length :
> -	    resp_sumlen < CEIL4(xcrb->reply_control_blk_length)) {
> +	/* reply length and overflow checks */
> +	if (xcrb->reply_control_blk_length < sizeof(struct CPRBX))
> +		return -EINVAL;
> +	rep_cblen = CEIL4((size_t)xcrb->reply_control_blk_length);
> +	if (rep_cblen > U32_MAX)
> +		return -EINVAL;
> +	rep_sumlen = rep_cblen + xcrb->reply_data_length;
[...]

Before this change, resp_sumlen was 4-bate aligned, now only rep_cblen
is aligned. Is thsi change intended? (the question is similar to the one
above)

The rest looks good to me.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

