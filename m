Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8AA447A0D4;
	Thu, 20 Aug 2026 15:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787240436; cv=none; b=mRK7aXVpVPWrNPWgSEA7q8Ftaj500v0C3pfsSCmh45foyDM5GPnPh30UZdR8zqj+eHC3cDO39eEKXPSrFWSZCajMkXsmUgx5jsyte40aTLbyq9S6Kd1wElRifbSFeSaDVMqKmyD9M7M8NSkfrB4+HLJStVzsTFBRIUvvJ0f8VW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787240436; c=relaxed/simple;
	bh=E8sr9qFr5Ob/54fS++IO2VzkuwZrhbRFHpVEAapkQGY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=laNaX5tjD5tm26t8cqztedpjKCMlV+B4CqtdHUi1Ka4G0kZaASP6jX0+F+ZgltsMEt6F4dXM+uiamL7nix65EMQNehF2GKiFy8UFHeZlYcrffxBMBnfuQCF0YJNEfOAeedqevnReAwkoAXjqfMrUmoFYH7pWIPUqfrqxr5j1Oj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Y8G9regC; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Y8G9regC"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67KEVjKn2750370;
	Thu, 20 Aug 2026 15:40:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=dokA88
	zMvlCBywSbB1oa0Z1etYFrtn2N3SHgKthPByU=; b=Y8G9regCVwtnbPScTfxkwm
	/aPqHYjsaUjvgeNOHhK9TzV3Ex1ZaxPtSpd/TaSKsQ3lRl5AAakxLhZSgp3OID1h
	KRlR0jGIO2mNPcdiht3ZeyflygYv2y0RVE1XEp6foaRDrPnozPh5AOiQhzPMOvzk
	gH2Tzs+1j9jEYG8mpgflBCHwCVzvP+thkAVQPoD315hpAhL4GDRB8EoEGnhK2WNL
	kla1sfDT+nzUY0KlGhc6QsAiTd+4woNg8V74IV67ZeUqvMy1FyW5Uwxz+IHvf436
	w6YfPFW3lc0uPhzv98wUEZ4fNp1sDwdyD0+zmYWAQ2QsLT9+/y3RK9Xz1avVm11g
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g4yu0kcrp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 15:40:32 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67KFQJu5015361;
	Thu, 20 Aug 2026 15:40:31 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eqfhha-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 20 Aug 2026 15:40:31 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67KFeRwH42860930
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Aug 2026 15:40:27 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A25532004B;
	Thu, 20 Aug 2026 15:40:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 73C1720043;
	Thu, 20 Aug 2026 15:40:27 +0000 (GMT)
Received: from [9.224.91.220] (unknown [9.224.91.220])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Aug 2026 15:40:27 +0000 (GMT)
Message-ID: <c745570b-5f58-4243-8b6a-275dae830c6b@linux.ibm.com>
Date: Thu, 20 Aug 2026 17:40:27 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before using
 it
To: sashiko-reviews@lists.linux.dev
Cc: Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org,
        Heiko Carstens <hca@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
References: <20260820140439.892324-1-dengler@linux.ibm.com>
 <20260820140439.892324-2-dengler@linux.ibm.com>
 <20260820142043.F40931F000E9@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260820142043.F40931F000E9@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MthiLWae c=1 sm=1 tr=0 ts=6a871ff0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=n2At5nnwvY2wsksHEjgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: PFLJLf8pVqt1vuMRn2KId73Mid_eNs8C
X-Proofpoint-GUID: PFLJLf8pVqt1vuMRn2KId73Mid_eNs8C
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX3T2cf8741+AA
 RGciXgtAp1UW5SMJUBykb8G+kRr1kqW13cUOIU1RcaqH9Extt311Txa2bBjX/MNR1uH7KJDOSEE
 oS5AEr0UH12DK125FobDKzGigRUWe/8=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDExNyBTYWx0ZWRfX13BihWmXhr+m
 TrMTewN5DwdJ3ut5H0apX8JVWL9M02k13hxKbye3HzhGwpIqO5UW6Z8wexdv/2YB8W9ltV6Zx4+
 pRzjHZmvc2bG5WJyqxk/0KjbcrYmyiOXgNVMJI4r+kMEpcerQ2je+3nflodITBIFJqBidqoVVwR
 9VFb56x/llsXjtqay0uyCPC0Eya46ULvr0ry9HtGxA6jT4zAmrh/oTzGkDHwm8tiYzwZu0yrfCL
 bUSWOWB+b8LfxOn3u62FWlrDKCy+xOxdGwS31aHt64+GipXdiY6SujIIPtuIupoX5jJN3gwZ244
 OctNyp/2eazzqFruwEl7Ou+oWMQes+gm9lkBs1Jqp5+6MDvsYM/VE7+tO4wDdxJWGV3v9z9llrh
 2jMPNvJaN+F4iDG1a0Mmq5RUJxKd//ud5YsGNozcZ5G6QWonDrgcL1ZaQjwKjgS4nUjWTPc4F0r
 lSkmJ+1ZW2i51fyARIg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-20_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 bulkscore=0 phishscore=0 clxscore=1015
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200117

On 8/20/26 16:20, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] The patch fixes an out-of-bounds read in `_ip_cprb_helper()` but misses identical vulnerabilities in `cca_gencipherkey()` and `_ep11_genaeskey()`.
> - [High] Unvalidated length fields in the CPRBX response payload are used to advance a memory pointer, causing severe out-of-bounds reads in `cca_query_crypto_facility()`.
> --
> 
> --- Patch [1]: [PATCH v1 1/1] s390/zcrypt: Validate length in reply before using it ---
> commit 3fcaad86f04a2a9419691d5f1a54cc873f326675
> Author: Holger Dengler <dengler@linux.ibm.com>
> 
> s390/zcrypt: Validate length in reply before using it
> 
> The length information in the reply is used to copy the key token to
> the target buffer. An invalid information in t->len of the reply may
> cause an over-read of the target buffer and also a over-write of the
> target buffer. To prevent that, check t->len before using it.
> 
>> diff --git a/drivers/s390/crypto/zcrypt_ccamisc.c b/drivers/s390/crypto/zcrypt_ccamisc.c
>> index d4ce6352b5b2e..54b8edd1dfc74 100644
>> --- a/drivers/s390/crypto/zcrypt_ccamisc.c
>> +++ b/drivers/s390/crypto/zcrypt_ccamisc.c
>> @@ -1158,8 +1158,21 @@ static int _ip_cprb_helper(u16 cardnr, u16 domain,
>>  
>>  	/* do not check the key here, it may be incomplete */
>>  
>> -	/* copy the vlsc key token back */
>> +	/*
>> +	 * Copy the vlsc key token back.
>> +	 * The available space in the destination (key_token) and the source
>> +	 * (t) buffer is always larger as the valid range of prepparm->kb.len.
>> +	 * Validate t->len ba comparing it with the length information in the
>> +	 * param block of the request (prepparm->kb.len)
>> +	 * The value range of prepparm->kb.len has been checked above.
>> +	 */
>>  	t = (struct cipherkeytoken *)prepparm->kb.tlv1.key_token;
>> +	if (t->len != prepparm->kb.len - 3 * sizeof(uint16_t)) {
>> +		ZCRYPT_DBF_ERR("%s reply with invalid key_token length %u\n",
>> +			       __func__, t->len);
>> +		rc = -EIO;
>> +		goto out;
>> +	}
>>  	memcpy(key_token, t, t->len);
>>  	*key_token_size = t->len;
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but since you are fixing the
> unvalidated length field from the device reply here, should similar validation
> be added to cca_gencipherkey() and _ep11_genaeskey()?
> 
> In drivers/s390/crypto/zcrypt_ccamisc.c:cca_gencipherkey(), the code reads
> the generated token length directly from the untrusted reply and calculates
> the copy length without checking bounds against the structure size:
> 
>     keybuflen = prepparm->kb.tlv1.len - 2 * sizeof(uint16_t);
>     ...
>     if (keybuf) {
>         if (*keybufsize >= keybuflen)
>             memcpy(keybuf, t, keybuflen);
> 
> Could a malicious or compromised device return an inflated length, causing
> memcpy() to read thousands of bytes out-of-bounds from the cprbmem
> allocation and potentially leak kernel memory to userspace?

The memcpy is only called, if keylen is less equal *keysize (which is
the available space in keybuf). As far as I can see, this prevents any
over-writes of the keybuf buffer, even with a malicious response from
the hardware.

This objection is not relevant.

> A similar unvalidated copy appears in
> drivers/s390/crypto/zcrypt_ep11misc.c:_ep11_genaeskey(), which relies entirely
> on the untrusted device data length:
> 
>     memcpy(keybuf, rep_pl->data, rep_pl->data_len);

In _ep11_genaeskey(), the rep_pl->data_len must be less equal
*keybufsize, otherwise the function returns with an error.

This objection is false.

> [Severity: High]
> This is a pre-existing issue, but does a similar vulnerability exist in
> drivers/s390/crypto/zcrypt_ccamisc.c:cca_query_crypto_facility() where the
> unvalidated length field is used to advance a memory pointer?
> 
> In that function, the code blindly advances ptr using an unchecked length
> provided by the device payload:
> 
>     len = *((u16 *)ptr);
>     if (len > sizeof(u16)) {
>         ...
>         ptr += len;
>     }
> 
> If the hardware returns a corrupt or malicious length, could ptr advance
> far beyond the cprbmem buffer bounds, leading to an out-of-bounds dereference
> on the next iteration or exposing arbitrary kernel memory during the
> subsequent memcpy()?

This objection is under investigation and will be fixed (if required) in
another series.

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

