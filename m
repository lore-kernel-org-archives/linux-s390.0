Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0606E3AFCE5;
	Wed, 29 Jul 2026 15:11:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785337901; cv=none; b=YhjxL2i6cuz5y+JvMg+qjwMWoi1lbn15IfZCVL+ckhCIY51IBS55UT5WETwWmO59AsiutVTW16TpkxQRRjKdcK71Ok0T/KhJTNrYkhpEtgOiTeefG+MHMN7ygS04PJne6J55YAlHL46O65izl55h4nvS/fjMl8dnUkY2wuq9sTc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785337901; c=relaxed/simple;
	bh=aSFx05asRMwwMg31IFLVO1WNz9Zjdi6CqC3bFPc1lOo=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=RLAhbJ9OpzG6LieX4MZYvyHxr+iNGhWbjzuwoMbuYbdl+VstV5CDbeSmrStUrfdPAUnLFhgEFkcyFP3YCeLfIJAE2D64wMcjYSczeUYFWd9tuSdoBf8VFYjIJzazfQR2qnefZXUTRQTmk67SranEo1Eiq89SxjiRREbkDSOP/Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hNlW6CzP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hNlW6CzP"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66TEmP0m336962;
	Wed, 29 Jul 2026 15:11:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=373/aIRgLxFlW4EDOZMGwhaQ89y8XqDaCY/y+j7WCH0=; b=hNlW6CzPQ1vX
	VEmf8W0AhyUounH79BgpsDgfATfu99md3wCtkW0Ge8HGVXirC4aPYOpFkOVBAweJ
	z9l3MflJgGmW+nBLZQvEGj8pi4Jb29zchG8CHqoINiu0vb54bh1PR2C0bKb9N/LM
	p2pCQDi5gIMMf9hmz77NQRHWI7ZBkMveb2TS5XCKq69aMrDUDJ0EGc6aC2niTjZ/
	NijQT6u1bF3L72MvXIaCpvBah9oKXmrB7ugUX8DZ7Y+9gvAWvgrCpPwvUTnSyr33
	C9YNwIIcenoAOycriqc0TqT3Kydh6qHd/UnzWmSBDVfCiIbu9XOLgnR8wRCmLuL+
	P2OrxAzq3A==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwd2jkt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:11:38 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66TFBb0l020370;
	Wed, 29 Jul 2026 15:11:37 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn9pgf1kp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 29 Jul 2026 15:11:37 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66TFBaOY32244274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 Jul 2026 15:11:36 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F19D758063;
	Wed, 29 Jul 2026 15:11:35 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8062A58058;
	Wed, 29 Jul 2026 15:11:35 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 29 Jul 2026 15:11:35 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 29 Jul 2026 17:11:35 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v8 2/5] s390/zcrypt: Improve CCA CPRB length and overflow
 checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260729145924.BBDF91F000E9@smtp.kernel.org>
References: <20260729143928.191969-1-freude@linux.ibm.com>
 <20260729143928.191969-3-freude@linux.ibm.com>
 <20260729145924.BBDF91F000E9@smtp.kernel.org>
Message-ID: <227ca82e444932ff0d203ae4073595b5@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 92mLEgzajS4nhMlFwMK0wO6H1up8DVq2
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfX1pm60f1jw5ea
 B4V4Jgqnawsrf9RDzeR2Hgt8V12MKEjSHHBe5nTvy2lUXW4UjIjvi3CYaop3olLIglf0dxKv1OM
 UKD70mMQCYv7IeJ8pNXih4G9CJJx5+M=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a6a182a cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Ycwy5HyKQbdaXcLRr6oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI5MDEyMCBTYWx0ZWRfXxOmefdKwHxff
 WE8PyE1VMprOPJEZRkUAFWCiXExpdS601rPLzt1siD1sINuqELjGt1/x1t868VUWBWIlHzpqw+2
 dDW8RZ2Q/gII1dpPRQ7Yt7cdJUwdG9T42KZmQHnZochkXICMmM6ZCDY56rGFzz8QJxFbVN956B2
 Ai2z0vMIZayWYUNxGHvLR4bJXYGjcNk719Lb6Z0bwJ35l51JMv/5Gi62xzy9mLUEOlwUt+elUVt
 XoEsZpKyF9CSY2EZ+6nNY+rbXUsBTi/0X2Cl9GEVpxwrkDb4Dfy34hPv2pD5GhWw7wcsnSneRDS
 IG42fMBcBWsdsgePDu5XOo5KDoxEuzh6cJqR6flZOdPEYbQ2D4CPt4xuusUTNzlPCR82D4xGVcK
 NiciX50/L5JcJkUwi6YiTzbuOgLda5OeZem1iaeGXlcs19uNfrOaPS0BJSDO/PUVpC2EfvZZi1y
 pU4m/gjxAcUN+H6wBfA==
X-Proofpoint-GUID: 92mLEgzajS4nhMlFwMK0wO6H1up8DVq2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-29_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607290120

On 2026-07-29 16:59, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] An integer overflow in the length calculation of EP11
> requests bypasses the AP message buffer bounds check, leading to a
> massive heap buffer overflow or immediate kernel panic during the
> `copy_from_user` operation.
> - [High] The `xcrb_msg_to_type6_ep11cprb_msgx()` function does not
> verify that the user-provided `xcrb->req_len` is sufficiently large
> (e.g., at least `sizeof(struct ep11_cprb)`) before copying from
> userspace, allowing undersized requests to leave critical message
> fields populated with uninitialized kernel memory.
> --
> 
> --- Patch [2]: [PATCH v8 2/5] s390/zcrypt: Improve CCA CPRB length and
> overflow checks ---
> commit 9af37e5b015a5cc6a88563feffcb032b0b3d9669
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve CCA CPRB length and overflow checks
> 
> The commit fixes integer overflows and missing length checks in
> xcrb_msg_to_type6cprb_msgx() by validating input lengths and checking 
> for
> addition overflows.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 40f72cdf284d3..fb37e28c82424 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
> 
> [ ... ]
> 
>> @@ -437,10 +428,13 @@ static int xcrb_msg_to_type6cprb_msgx(bool 
>> userspace, struct ap_message *ap_msg,
>>  	}
>> 
>>  	/* copy data block */
>> -	if (xcrb->request_data_length &&
>> -	    z_copy_from_user(userspace, req_data, 
>> xcrb->request_data_address,
>> -			     xcrb->request_data_length))
>> -		return -EFAULT;
>> +	if (xcrb->request_data_length) {
>> +		req_data = ap_msg->msg + sizeof(struct type6_hdr) + req_cblen;
>> +		if (z_copy_from_user(userspace, req_data,
>> +				     xcrb->request_data_address,
>> +				     xcrb->request_data_length))
>> +			return -EFAULT;
>> +	}
>> 
>>  	return 0;
>>  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but looking further down in 
> the
> same file, xcrb_msg_to_type6_ep11cprb_msgx() seems to have the same 
> missing
> minimum size validation that this patch fixes for CCA CPRB.
> 
> In 
> drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():
> 
> 	/* Import CPRB data from the ioctl input parameter */
> 	if (z_copy_from_user(userspace, msg->userdata,
> 			     (char __force __user *)xcrb->req, xcrb->req_len)) {
> 
> If the user-provided xcrb->req_len is smaller than sizeof(struct 
> ep11_cprb),
> the rest of the message header could remain uninitialized. Could this 
> result
> in uninitialized kernel memory dictating control flow or being used to 
> route
> requests?
> 
> [Severity: Critical]
> This is a pre-existing issue, but xcrb_msg_to_type6_ep11cprb_msgx() 
> also
> appears to suffer from the same integer overflow issue:
> 
> In 
> drivers/s390/crypto/zcrypt_msgtype6.c:xcrb_msg_to_type6_ep11cprb_msgx():
> 
> 	/* length checks */
> 	ap_msg->len = sizeof(struct type6_hdr) + CEIL4(xcrb->req_len);
> 	if (ap_msg->len > ap_msg->bufsize)
> 		return -EINVAL;
> 
> If a user provides a large 64-bit xcrb->req_len like 
> 0xFFFFFFFFFFFFFFB0,
> could CEIL4(xcrb->req_len) wrap around, bypassing the ap_msg->bufsize
> check, and resulting in a huge buffer overflow or kernel panic during 
> the
> subsequent z_copy_from_user()?

And these both are fixed with the next patch in the series !!!
