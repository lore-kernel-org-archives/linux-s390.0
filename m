Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D81003C9EEF;
	Fri, 14 Aug 2026 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786720132; cv=none; b=N1dpGLaekqe32Y1OjWzyCA+glsaEQGTRL9takuHwh/2FdZ3Qx7RmqkUddnKek1Up/1bvcYR5ithKFBVjgcveWyJxcDzmkVsoLJqdjzh35a4U56ImXdxxdhhdWrVIJ3gQZFD4eK+bELmTPVCH3/6iAmyynvaSPlVamt/WKUZfym4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786720132; c=relaxed/simple;
	bh=jsl8MrQfwRthoU04AgSqk5+QOq9zjYaABgINvgF5WOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nkdQvddxQU/vc8eYAP4kG+wGkxvrDmvW7Gv5fkuRN5/Llx8f8P+Ib6ptYQouT1zBjm+f0AxYjIEyFLq9L1KQy/TK1tU36uRn4ZDtsum0C7z+kTyWlZ4lq9fUT+a75CDdq/YhHKOIloB7SMyZBGZt6XrxClosYfMQzCOGqgfqHc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WH7x+pLj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WH7x+pLj"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67EE5ZAP3660177;
	Fri, 14 Aug 2026 15:08:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=O45NYv
	hjJ0ymu35KpIGlEr65IetKun7u2AI3RzlFy/Q=; b=WH7x+pLj4yR6JD5aln6zOb
	kogQk4gXGSu+ZxIAPO9ZtWLCXktrlSXgsURPc5yAr+QDwzPsoP35xAC5M2XcuXRV
	qwDD21Uvqysy6zkm4akNT66G8YkgMSMmZk6B2pboJ065+76LlUlFN/EEFL1acksS
	UrzuITbSso+aOzFT3HYGKNq2+3BOzim37h1bKnQaNp14VRAmq126C+FB1+bYotFK
	CDfK/Gyp5YWxbWb7+Xf51uVjLNml8H4uBy0RgNmqGcKgJ4vLOGMokLnD1pCjauJb
	hhCGFEWWKQ++jtVbXidMMZv9a8QnaDFL0FY/DkPl0W4TvceXuJHI0U+q3U1ze36A
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvk0dbr8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 15:08:50 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67EEuTFD020324;
	Fri, 14 Aug 2026 15:08:48 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5wfv6d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 14 Aug 2026 15:08:48 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67EF8i0F38535600
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Aug 2026 15:08:44 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA8E320043;
	Fri, 14 Aug 2026 15:08:44 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6727320040;
	Fri, 14 Aug 2026 15:08:44 +0000 (GMT)
Received: from [9.111.74.75] (unknown [9.111.74.75])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 14 Aug 2026 15:08:44 +0000 (GMT)
Message-ID: <9d6917f1-bfd0-4539-8df1-cc46b4d2a419@linux.ibm.com>
Date: Fri, 14 Aug 2026 17:08:44 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/1] s390/crypto: Generate intermediate CV for API
 partial block handling
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.vom>
References: <20260814142010.259918-1-dengler@linux.ibm.com>
 <20260814142010.259918-2-dengler@linux.ibm.com>
 <20260814143143.75EE41F00A3A@smtp.kernel.org>
From: Holger Dengler <dengler@linux.ibm.com>
Content-Language: en-US, de-DE
In-Reply-To: <20260814143143.75EE41F00A3A@smtp.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfX7Lglp+fTH6HV
 2qIlPToI06WGDXqUbBXqZjwG5EvPKkFmDJUMnKZIkWog50TeAO6FU1XCWfCPXYmrxkYKEa60noa
 Y62RLmZNZqWc1N9x+MKO3hPJQIDKMBDWQo6y/mqLRho0IJekcpkLBftt/UksT/y9sRIaih//zvs
 DK2I3/aTjIBZytVEOhl2I6+T8qNK5lVlLC56zhHY+CXUu50nPGp6GfjRDhxIZKikNP90nTHg/Sh
 EU8YVETfAd0IOg4zPa8TobZpI5Fzq8jwompS5y1wa9KO5WPM0XT3bspgAGeNor2mKg1dk0S3RO1
 xe38VMDaitd9LOXmvQUlenjIYhNUrfPlao+5OcipwYWFiR2FocitSqzjmS55ajfFvjoWpfkiJNt
 QY5Myh4CqYHpxHwcpDXsisbFkZKkZXZ09v4GmJn44PV81GXQR1ceqyFfr9+VDg1tYi3BebESGE7
 r5v3P4TrWA0pswvSzjA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDExNCBTYWx0ZWRfX6qOyuwyIBI+9
 uyiFaL+/uL0T7OhHt/sQiLlgodxYYch4XOpq6CSovvo+J8RCJx5eAVY0RN/MSWH94kZQ9aeUDqB
 MdduHc2jxm2xmaXmMRZlm18mo1CLGIc=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7f2f82 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=gN5i18_ZI52W_xiBWBcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: t5bBcEWNluGD2eXZSR6pbFs3WQ61aBsR
X-Proofpoint-ORIG-GUID: t5bBcEWNluGD2eXZSR6pbFs3WQ61aBsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-14_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608140114

On 8/14/26 16:31, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
> 
> Pre-existing issues:
> - [High] Hardware Alignment Requirement Violation due to `__packed` attribute
> --
> 
> --- Patch [1]: [PATCH v1 1/1] s390/crypto: Generate intermediate CV for API partial block handling ---
> commit 6ca29d2947b71c2e1420feb8fbee6504922ff37f
> Author: Holger Dengler <dengler@linux.ibm.com>
> 
> s390/crypto: Generate intermediate CV for API partial block handling
> 
> This commit updates the internal hash_data() function to conditionally use
> cpacf_kimd() for intermediate chaining values when API partial block handling
> is requested, reserving cpacf_klmd() for the final hash value.
> 
>> diff --git a/arch/s390/crypto/hmac_s390.c b/arch/s390/crypto/hmac_s390.c
>> index f8cd09f341d4b..445fa7bbd9586 100644
>> --- a/arch/s390/crypto/hmac_s390.c
>> +++ b/arch/s390/crypto/hmac_s390.c
>> @@ -150,7 +150,10 @@ static int hash_data(const u8 *in, unsigned int inlen,
>>  
>>  #undef PARAM_INIT
>>  
>> -	cpacf_klmd(func, &param, in, inlen);
>> +	if (final)
>> +		cpacf_klmd(func, &param, in, inlen);
>> +	else
>> +		cpacf_kimd(func, &param, in, inlen);
> 
> [Severity: High]
> This is a pre-existing issue, but could the alignment of the param block passed
> to cpacf_kimd() and cpacf_klmd() trigger a hardware specification exception?
> 
> The param variable is defined earlier in hash_data() with the __packed
> attribute:
> 
> 	union {
> 		struct sha256_paramblock {
> 			u32 h[8];
> 			u64 mbl;
> 		} sha256;
> 		struct sha512_paramblock {
> 			u64 h[8];
> 			u128 mbl;
> 		} sha512;
> 	} __packed param;
> 
> The __packed attribute reduces the compiler's alignment requirement for param
> to 1 byte. The z/Architecture requires doubleword (8-byte) alignment for KIMD
> and KLMD parameter blocks.

This is not true. The z/Architecture (as described in "z/Architecture,
Principles of Operation") does not require any alignment for the address
of the parameter block in general register GR1.

> If the compiler places param on a stack address not divisible by 8, won't this
> cause a kernel panic when passed to these hardware instructions?

There is no specification exception documented, if the parameter block
address in GR1 is not 8-byte aligned. A stack address not divisible by 8
will not cause a specification exception and there for also no kernel crash.

> Since the struct fields inside the union are naturally packed, can we remove
> the __packed attribute to ensure the compiler maintains safe alignment?

The __packed statement may be redundant. But I would prefer to leave it
in the code, because it increases the readability.

[...]

-- 
Mit freundlichen Grüßen / Kind regards
Holger Dengler

