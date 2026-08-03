Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FF1927E05F;
	Mon,  3 Aug 2026 09:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785748183; cv=none; b=INvADlG8ebhO7LmV6cSVcd9Cz6kQnnz6wQy7xxmFm5rkPBLrW2BZuciAQPBg4+Gy1595ezXoGXV4VxGlp95vY2hE3zx6BMNKBANI5efzRncHUYopFKXDjhU9FlQlN2OmSBvwXjldfwMeaEJYNk49SBSwFwf727CuESDkGQPnEiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785748183; c=relaxed/simple;
	bh=cOt1YGrZT1qgojNIgXWeXg98+7LkVVz3IrR5A+ITsM0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=FUlmClZrXHQHY1V425ron880f0wSuKO2EYQZIAj+7Kjf8qyoninfEiF19y89eo+xZufDWQC+XQNSdLQyjIQ6hNtH76Yoy4s/Xfvjp7knxkaURh4mQj4wfDF6XyS1bmMMntWk/CZ4E3RWPIOKQ4tg7SYM/AGOKrzzQS7EB9h3UkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jTKJBNKr; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jTKJBNKr"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 672LlT6k2563827;
	Mon, 3 Aug 2026 09:09:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=oluF0AsGipD9sdIQRKWzVJSWZAJ/M8xE5/wgZ47wO+8=; b=jTKJBNKrGM0W
	w4zYtgb7loQ/JxIc9XyoLBK1H8MVhXf0cm8k5nR0WCLbW+aNvC5VFUfAr5OwWCEL
	env0cXcJcEOivmiqOBpED5toSJFZymrsjVjnt/IPd7HOSaJg5Zc0RbakI0EtwjRZ
	winFeZvlhoD58qdqhZ05EEUmWyVOEJQ9JPV9qnlWJeWgpeJGwuQ4Ltkt1fCGtclw
	HPUJu7C9+18jF1lG/VXPRYRuL1XhQw9elLdwAKcUqrBUq3X07n/G/GSkiDrj8LGh
	4If63MQgyoCW+AEWklag+Qh2FpcBTkBWQRhCU4A4Rl3jP6UkOY1novAMjWdLtLlo
	lnLf0XLpfQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8fqfv9t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:09:41 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6738uIHp005700;
	Mon, 3 Aug 2026 09:09:40 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtycdqn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 03 Aug 2026 09:09:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67399dux24642196
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Aug 2026 09:09:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 623DD58052;
	Mon,  3 Aug 2026 09:09:39 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0FDD958065;
	Mon,  3 Aug 2026 09:09:39 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  3 Aug 2026 09:09:38 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 03 Aug 2026 11:09:38 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH v11 3/5] s390/zcrypt: Improve EP11 CPRB length and
 overflow checks
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <20260803085021.30E061F000E9@smtp.kernel.org>
References: <20260803083339.212885-1-freude@linux.ibm.com>
 <20260803083339.212885-4-freude@linux.ibm.com>
 <20260803085021.30E061F000E9@smtp.kernel.org>
Message-ID: <fe6d686794f9d0c3fb67ba353cef333e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Fj2LJG8XcRjHGuoCuhF6_0SKvYCMSR0Q
X-Proofpoint-ORIG-GUID: Fj2LJG8XcRjHGuoCuhF6_0SKvYCMSR0Q
X-Proofpoint-Spam-Info: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfX654OtA079vff
 d2rJZ5huXFNs27V+0NV/KTwU62Yd86bQAaP8w1OpMjdhmO3Lud/g8lfF83WMEzz1veqDlE8tr4P
 6Sb+4obsqnL2LCF5gNZ+0ggmo1EQX/0=
X-Authority-Analysis: v=2.4 cv=K8cS2SWI c=1 sm=1 tr=0 ts=6a705ad5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=bprVitO3MEqBuKX84JoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODAzMDA3NyBTYWx0ZWRfXzDSLgv2EI4pN
 CXRNVUu5YOoqBee3uCpUTRro8S63HA11FGsNsrqvIbBaDI89d0+yhq0xHxu5ert7uXn8r+NqSoS
 Q9MZoXXBrSdSg2W3vPHnA+IvDcg5XorkTW31oSRFylFYksKpfcw+hpgQxjZxz4PXcfxsyw/PoDx
 UcC/bMC/mnQt7OOZW/Ygwy13RXZ4DEhqenNU3g1yaKPhkGlO/BToITaRT4eQ95MXc2I9qM7Nf/Y
 nBFe4SEY1GbscEX4RcjODHB0D/zOAkJotu0RDKpW/TgBVyj68n7lfQeYRPMUIGMjzcUgVcO/uaR
 slpKKIXQwAlWelc29o+eNnJQvjX2W/QIPbJLfaohj26pVqE9e+MUUVafqJ2mKeYyx4j+Gw/8S5Y
 Wn6EtwzPEwVrBTD+KtrgD+WN6q86TRIqaMLlssXafi5YcNIGCFf+c8CfJ22+CNj5yoodM0k6v+R
 gQm9VjsOX1wZn6PDsvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-02_06,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 impostorscore=0 bulkscore=0 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608030077

On 2026-08-03 10:50, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential
> issue(s) to consider:
> 
> Pre-existing issues:
> - [Critical] Incomplete Fix / Domain Isolation Bypass. The patch
> introduces proper ASN.1 parsing in `xcrb_msg_to_type6_ep11cprb_msgx()`
> to extract the function code, allowing shorter encodings of `func_val`
> (e.g., 1 byte instead of 4). However, it fails to update the
> subsequent send function `zcrypt_msgtype6_send_ep11_cprb()`, which
> still uses a fixed-offset C struct (`struct pld_hdr`) to overwrite the
> domain ID (`dom_val`) in the payload. Because the EP11 hardware
> natively parses the ASN.1 payload, an attacker can supply a shorter
> `func_val` to shift the actual `dom_val` field. The driver will
> validate the request but overwrite the wrong offset, leaving the
> attacker-supplied domain ID intact. The hardware will then process the
> payload using the attacker-controlled domain ID, bypassing
> cryptographic domain isolation.
> --
> 
> --- Patch [3]: [PATCH v11 3/5] s390/zcrypt: Improve EP11 CPRB length
> and overflow checks ---
> commit ded2aaf4bb041722a4604d826ab3b2f1e7bf5794
> Author: Harald Freudenberger <freude@linux.ibm.com>
> 
> s390/zcrypt: Improve EP11 CPRB length and overflow checks
> 
> This commit fixes missing minimum size validation and arithmetic 
> overflows
> in xcrb_msg_to_type6_ep11cprb_msgx(). It introduces proper size checks 
> and a
> simple ASN.1 parsing mechanism for the payload up to the function value
> field.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_msgtype6.c 
>> b/drivers/s390/crypto/zcrypt_msgtype6.c
>> index 3e19e79d747cf..7e1f76c935ee1 100644
>> --- a/drivers/s390/crypto/zcrypt_msgtype6.c
>> +++ b/drivers/s390/crypto/zcrypt_msgtype6.c
>> @@ -491,26 +540,51 @@ static int xcrb_msg_to_type6_ep11cprb_msgx(bool 
>> userspace, struct ap_message *ap
> 
> [ ... ]
> 
>> +	/* function length */
>> +	if (offs >= pld_len)
>> +		return -EINVAL;
>> +	i = asn1_length_decode(pld + offs, pld_len - offs, &u);
>> +	if (i < 0)
>> +		return -EINVAL;
>> +	offs += i;
>> +	if (offs >= pld_len || u > pld_len - offs)
>> +		return -EINVAL;
>> +	/* function value */
>> +	i = asn1_int_decode(pld + offs, u, &u);
>> +	if (i < 0)
>> +		return -EINVAL;
>> +	offs += i;
>> +	*fcode = 0xFFFF & u;
> 
> [Severity: Critical]
> This is a pre-existing issue, but this updated parsing exposes a bypass 
> of
> the cryptographic domain isolation.
> 
> The new ASN.1 logic correctly parses a variable-length payload, 
> allowing a
> shorter encoding of func_val (e.g., 1 byte instead of 4). However, how 
> does
> the subsequent send function handle this?
> 
> Looking at zcrypt_msgtype6_send_ep11_cprb(), it appears to still use a
> fixed C-struct offset to overwrite the domain ID:
> 
> drivers/s390/crypto/zcrypt_msgtype6.c:zcrypt_msgtype6_send_ep11_cprb() 
> {
>         ...
>         payload_hdr = (struct pld_hdr *)((&msg->pld_lenfmt) + lfmt);
>         payload_hdr->dom_val = AP_QID_QUEUE(zq->queue->qid);
>         ...
> }
> 
> If an unprivileged user issues an EP11 CPRB ioctl with a valid ASN.1 
> payload
> containing a 1-byte function ID, wouldn't the fixed offset in
> zcrypt_msgtype6_send_ep11_cprb() miss the actual dom_val field?
> 
> It seems this would result in the driver validating the request but
> overwriting the wrong offset. This could leave an attacker-supplied 
> domain
> ID intact, allowing the EP11 hardware to process the payload using the
> wrong domain.

And exactly this is addressed with #4 of this patch series.
