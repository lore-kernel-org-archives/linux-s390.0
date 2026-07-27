Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD51400980
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:14:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154456; cv=none; b=dlmno0xnuBkqkZcCO6rXc4GoFNh/362Ljp0SJGAUQNJtm0Ic3QbG498RqQDrgUTLpJ4SOTXETaowDwUfoyLExt2ZZJv2Xawiq0ClUqGn/d7+cMN74GU88gdSnifgXLR0U3cftU/3gvNR4yNlBItn0GrjXNgea18HNCr5Oc9JrJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154456; c=relaxed/simple;
	bh=nrSeFr2whuo7LDfycwTKe/aceHIqjIJHMSYATEUbcpw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=B9i+KpY6VTkPMNAJFG+yPzSXR4NuAI0Xmp1g5n9R9JUvm3iej47NoJbkPZQ/2I9Emp+VC0kpzzXng6o+Qc0Gq4oIFyN5utznSUoxhalZu1/w9UBE1LS4gz33meO3j/chGo5e0nJQ8oI0hmfLQU9VT8q75I1LZ8vd9sylbBU5OEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=M6sEJsH9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="M6sEJsH9"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RAIbDe061317
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=sNWaGg
	rFCZ3L7HAQoBqVP+GqvZcPT/ASl31if0geh8E=; b=M6sEJsH96qyEG9jD09j1ch
	dynbYjlCZbz5/1tkiUvZp6A+8hPBsKd9joaxJ9H8/ffugM5isxVQny1q/1Qu081t
	kJ42KkDF14Qodpw7V3m8oBE49mom52BzacnR8igtQqf9eOHb1a9rl1ZBrP4GyqjD
	wH6Rt0Rs6CuzLFnmHOsW0GyqakT+qljUX7uv9OgfcS72mhjFLo1gXYGA8wRaMPcy
	+hUnlxca48W4KfeJjcVPu9n/KYnnruwwEyu13xilNBNpQwgfzLMhhCFBk4t4jVCH
	4NoYQR3Mt5T+OpNRNX8ELcN7iRwu2UQbE/gl8QzeAkGr4vsCCJztGiIVfcoC7NyQ
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyc7vq5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:14:09 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RCBIai010160
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:14:08 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fna5xw18c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Mon, 27 Jul 2026 12:14:08 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RCE4gH47382786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 12:14:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5338120145;
	Mon, 27 Jul 2026 12:14:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1358E2013F;
	Mon, 27 Jul 2026 12:14:04 +0000 (GMT)
Received: from [9.111.67.171] (unknown [9.111.67.171])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 12:14:04 +0000 (GMT)
Message-ID: <dfedc123-0126-4c28-936e-f26f8a854862@linux.ibm.com>
Date: Mon, 27 Jul 2026 14:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] s390/zcrypt: Improve EP11 CPRB length and overflow
 checks
To: Harald Freudenberger <freude@linux.ibm.com>
Cc: fcallies@linux.ibm.com, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260727083200.151976-1-freude@linux.ibm.com>
 <20260727083200.151976-3-freude@linux.ibm.com>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US
In-Reply-To: <20260727083200.151976-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 0tn-WJ6lLOpz84oR0tOTzyQZv57xRVrH
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX0VORR9eiWvY7
 /eogCzAdYdla5beYV+XSNC1LUyBPTzberWH5yaxtZe/Ys19YP9RUV0I6OusiUB7CZIwV0G0ewBF
 2upMvI8Lce7DFGNnXJDAo4wOpLZIw6qAtPv2IoI38dWVyiQWMTkuZh4tuXfFg6T8y0U5EqOAD3w
 2gEper3le9VQbbrKiMAonAZEn7+iI9XlvOTH9A5TBZTdRdc/l/dMLImNppsaMpsO5aOSYQxgLyn
 Q/H1vxo8jpru6zIbPhgtGGrPWo66mkM2XMnmchtpbMU/LBEuHX/Zvt9drb2qz02xRhjRZ6t94PL
 9M7TZNc9KwkCy2bSvjQkESTmGbTmlIXdemGXJAcZjK3uW1CLtDZUfYTqO7vlb4u2J2cNvCfo4WV
 W4sQ8McImQTgGFRNWasvdpOQD+tit4Yr8pdncJ/kHtEfvYbR6hxjWMmyaxc0FNwfbvW6+UMHmyo
 H1eN/nmgeu7CT6A2k3A==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDExNiBTYWx0ZWRfX6RcvTHTl7iM+
 U2tlDn1hjky+blwbde/jjqQZUjAOfeUyiGiWFuQMyGnPPkOsAk825LgplAR+QOhrinc81VPK2Uc
 QwbPSx37wrTpwuBbnALBkJ/vCW/Pdg0=
X-Authority-Analysis: v=2.4 cv=AZeB2XXG c=1 sm=1 tr=0 ts=6a674b91 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=LXxHhldPrCqfEDQW6rsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: 0tn-WJ6lLOpz84oR0tOTzyQZv57xRVrH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_03,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 phishscore=0 adultscore=0 impostorscore=0
 clxscore=1015 malwarescore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270116

On 7/27/26 10:32, Harald Freudenberger wrote:
> The xcrb_msg_to_type6_ep11cprb_msgx() function lacks proper input
> validation, creating security vulnerabilities:
> 1. Missing minimum size validation: The ep11_cprb structure and
>     subsequent payload fields (pld_tag, pld_lenfmt) are copied from
>     userspace without verifying sufficient buffer length.
> 2. Arithmetic overflow in length calculations: CEIL4 alignment could
>     overflow, bypassing size checks and enabling buffer overflows.
> 3. There was a gap between the message size copied from user space and
>     the message buffer sent down to the card. The msg buffer size is
>     rounded up to 4 byte boundary.
> 
> Fix by using size_t for length calculations, adding U32_MAX boundary
> checks after alignment, and validating minimum request size and
> minimum reply size before copying from userspace. Also pad the gap
> between user space copied message and message buffer sent down to the
> card by zeros.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   drivers/s390/crypto/zcrypt_msgtype6.c | 24 ++++++++++++++++++------
>   1 file changed, 18 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c b/drivers/s390/crypto/zcrypt_msgtype6.c
> index 2e4aef330b68..f4cca7fcaeea 100644
> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
[...]> @@ -498,6 +507,9 @@ static int 
xcrb_msg_to_type6_ep11cprb_msgx(bool userspace, struct ap_message *ap
>   			     (char __force __user *)xcrb->req, xcrb->req_len)) {
>   		return -EFAULT;
>   	}
> +	if (xcrb->req_len < req_len)
> +		memset(msg->userdata + xcrb->req_len, 0,
> +		       req_len - xcrb->req_len);

Same here, please move the memset to a separate patch.
(Maybe both wipes can go into one commit)

>   
>   	if ((msg->pld_lenfmt & 0x80) == 0x80) { /*ext.len.fmt 2 or 3*/
>   		switch (msg->pld_lenfmt & 0x03) {

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

