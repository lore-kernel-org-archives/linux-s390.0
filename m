Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7AD42980A
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783948914; cv=none; b=snBiOTjSj3CGcNmAeUI4bWSm4hl9G6BdAcP8kifE5aMr5OKYpB8OQwl5JoGNGaklIoogA2BaK+epWFW1TAjcnU73XV9TbgljPYYGB38Ytw5HmsDdVyRRWheFkb8eCqW7H7DTlYGweqIbOsQAKgOnD2PSmluqMG9JSQb4ReWCth4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783948914; c=relaxed/simple;
	bh=3Ei4vNVrTanNBfZJiPJ3LCKHitdmxxmGiBd/F97P9JQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YKNVWAc0R/CF5mS9JrU6ZSDf9jgS/lJplu8rXH3KxugBuWcDeIQ04NnPa4WGEhK7LTM2+c+6ZNx5EMk5sydFph9KTtOVaZHRvVIGHYEUnx+yO3XISW9r+XZ3vX03lagVFMF8CvVlqdPvm8ImCdIBZhG7LHsVvHLSDcL2n3J3eVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lG/uT/q7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lG/uT/q7"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66DCD0bh2453894
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:21:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=9Lm3uB
	L3y9ZfE+O4UjprgRL11asocT59ncCIoqA9QIc=; b=lG/uT/q7bbGhpWEy6CIPEo
	jmRLgIDDtyJdVRQYKaKoN1pGmjG57iNGMy6uT+zdh/+IO5ZCOYCLdpeJ0GWUIRAE
	2xzwhsILlGuwi7aPT2kn6cgIiEIgIzyrfjXkYXSZNUMQ2+n62j4aT9asBKqV0aPn
	68kqoui6yGgIiOI5x9k+x9FUFYQQt73IEzOSi30iYqqNCKWnmKsH1woEI3px4qm3
	NL8U9r7uJxaDOli1NwFgoZ8ORS9+ujvtuOBZU4nnkDfuPDfl6jVs1N4qNPySWD6h
	B6h81nvZdQIuBOx/DsLSIlJ/n2NmRuzg43DzqeSIkq4cA+jcZ9dRIARHPOrSDg6w
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegt0ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:21:52 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DDJZwT008786
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:21:51 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2uxwgjw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 13:21:51 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DDLlAd9699800
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 13:21:47 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C11F42004B;
	Mon, 13 Jul 2026 13:21:47 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 81F2720043;
	Mon, 13 Jul 2026 13:21:47 +0000 (GMT)
Received: from [9.111.34.160] (unknown [9.111.34.160])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 13:21:47 +0000 (GMT)
Message-ID: <995f0618-ff76-4bd5-a0fc-4592ecd13484@linux.ibm.com>
Date: Mon, 13 Jul 2026 15:21:47 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/1] s390/zcrypt: Improve zcrypt reply message
 verification checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260710151005.79765-1-freude@linux.ibm.com>
 <20260710151005.79765-2-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260710151005.79765-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wflyQvmiqZFTofTJf_zNUwqCu1zeIZNc
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfX/QR7Luz7yxwK
 R6uzmXARjIHNCE4v1g/YAh4A1YoYwvpOvOrMRELaz0xWiZrRvk2IteMRwyso32GAl3RSgeuPLmN
 9w4snJtEW/JNbDtRzPJh+iz7XTRL4NA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEzOCBTYWx0ZWRfX270QNWJnhO4w
 X0vK8fsiVegyzp/Jq779HYnUbHSaKSKSSqVhFCWKommYT52p2LYKioU7AqHpVQdBYtMM8FJlcLD
 xJ9pSptkggV1LnbCwgeneBmOsvpY+ZGmaqF0WfeS7TPR3nORuXmTaASS1WbbDdsuDJUDlyvweHd
 8/YC6O8Jo+m34jQn9dJXCP3ra5fl/V4DvikdVOJ93PtPT0fKmaL2Zw2w0jclnqWm+2ghu8/TMbX
 j8uv9IQs1pgk/tWyhqxPwZyr5DSEgdQDnOwNAhwBkqyjzTsdM9vwzeZ2LfQ+G4jOggCKQLw3gD/
 +tVbQ4YJIxFVpzLXs6I5EA7b+Iquy0e+H6n2PIX3YWVRV3P8VXqXwmAPI/y/xLH864JwEY49NvY
 Sdttu3YEXnPZ0OAPFJeiu22zst2fOtVE/zxO75gmsexNjO9+saU8kc3/O4Y6yRfIAmj6lxWica8
 YCq5jQy26HzmVXhxSKQ==
X-Authority-Analysis: v=2.4 cv=IqMutr/g c=1 sm=1 tr=0 ts=6a54e670 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=VwQbUJbxAAAA:8 a=ypx8-JeG6iJm6fwO9KIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: wflyQvmiqZFTofTJf_zNUwqCu1zeIZNc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 phishscore=0 suspectscore=0 priorityscore=1501 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130138

On 7/10/26 17:10, Harald Freudenberger wrote:
> Add or improve checks related to buffer sizes and reply sizes to the
> handling of replies from the crypto cards for CCA and EP11 (AP message
> type 6) messages. The verification code related to reply field length
> was not designed well and thus firmware deficiencies could lead to
> unexpected behavior in the zcrypt device driver. Thus improve the code
> to more closely inspect especially length fields at message replies.
> 
> The 3 hunks of this patch deal with CCA, EP11 and (CCA) RNG replies
> and improve the checking for reply buffer size by using size_t instead
> of int. RNG replies an additional check makes sure the hard coded
> limit of the data buffer is not exceeded. Also there was a condition
> with additional data for an CCA reply where some of the field values
> where unchecked used to invoke memcpy into user
> space. zcrypt_msgtype6_receive() now checks all the relevant fields
> before convert_type86_xcrb() uses them.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Cc: stable@vger.kernel.org

See my comments below.

> ---
>   drivers/s390/crypto/zcrypt_msgtype6.c | 42 ++++++++++++++++++++++-----
>   1 file changed, 34 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 40f72cdf284d..8252fd185663 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
[...]
> @@ -863,7 +870,8 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
>   	    t86r->cprbx.cprb_ver_id == 0x02) {
>   		switch (resp_type->type) {
>   		case CEXXC_RESPONSE_TYPE_ICA:
> -			len = sizeof(struct type86x_reply) + t86r->length;
> +			len = (size_t)sizeof(struct type86x_reply) +
> +				(size_t)t86r->length;

Is the explicit cast for sizeof() really necessary. I would assume, that 
the following should be sufficient:

	len = sizeof(struct type86x_reply) +
		(size_t)t86r->length;

>   			if (len > reply->bufsize || len > msg->bufsize ||
>   			    len != reply->len) {
>   				pr_debug("len mismatch => EMSGSIZE\n");
> @@ -874,10 +882,27 @@ static void zcrypt_msgtype6_receive(struct ap_queue *aq,
>   			msg->len = len;
>   			break;
>   		case CEXXC_RESPONSE_TYPE_XCRB:
> -			if (t86r->fmt2.count2)
> -				len = t86r->fmt2.offset2 + t86r->fmt2.count2;
> -			else
> -				len = t86r->fmt2.offset1 + t86r->fmt2.count1;
> +			len1 = (size_t)t86r->fmt2.offset1 +
> +				(size_t)t86r->fmt2.count1;
> +			if (t86r->fmt2.offset1 > reply->len ||
> +			    t86r->fmt2.count1 > reply->len ||
> +			    len1 > reply->len) {

Wouldn't it be sufficient to check only (len1 > reply->len)? If 
(t86r->fmt2.offset1 > reply->len) is true, than also (len1 > reply->len) 
will be true (and the same for count1).

Or did I miss something?

> +				pr_debug("len mismatch => EMSGSIZE\n");
> +				msg->rc = -EMSGSIZE;
> +				goto out;
> +			}
> +			if (t86r->fmt2.count2) {
> +				len2 = (size_t)t86r->fmt2.offset2 +
> +					(size_t)t86r->fmt2.count2;
> +				if (t86r->fmt2.offset2 > reply->len ||
> +				    t86r->fmt2.count2 > reply->len ||
> +				    len2 > reply->len) {

Same here.

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

