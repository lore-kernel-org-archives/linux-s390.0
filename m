Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EB98390615
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 14:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782138874; cv=none; b=NRuPTAmSLB4fJyMf0uSITrqIsM3bZslJ98tuB0Tr+5ATboY2zIHPzeZ/ns1jzPu2TYkMLY+Xs1pGbSclpKCGnOFfHaZWpP94cklq0wlHdgKsl3G01b2AUMh9ejijLXFNkBq0O6cDREqzUde9pDFc5qscRwSTb/ytG+OeA/e4YB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782138874; c=relaxed/simple;
	bh=9DHHJ1ylJHFNC6GTgHFzaxnpoYS4yWL+IuzHsIZkVbQ=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=nwjzJaFurwHt5mhNFwD7nMqT8wWRNQi0lJmMN8/Tc0gaz3twkmPR6JsnoV+BIwy2YCt4Lc0wChTcM2l9UQWeFmebRjZbfIzZUTpGMiCSv4/b5CYXsIW6uxWAwyOLDqrfTzcxzApxvoWKIPkm3xkrvA5fZLBtHFoj3Gup0LqjWms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U4yww38S; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U4yww38S"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDIONW2921959;
	Mon, 22 Jun 2026 14:34:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=EfqKfTOJ++DM9TdTIA1UBJH3SMFXSqsb0DAk1tGIPFU=; b=U4yww38SMUTu
	QnxYQ2lQnfEPz/sXaoAmjM5o2j5nTc0OQUxzzEJ8oGcmZWMs7X9+LZeCOlY1sv/X
	snj+2Hqj2B06dSP2cFzITAokAk4rBbA1Jzo4VLfR62KZyBCO6xENy4ec0OS1l5cu
	rLKULyUf4B6IQIwBvu+0/6IQUBafpNrVaAZGnATwnOtiUzJAxXM71VNb+PIreV70
	wS99GBAdywtjmUwKD/V2ZIL3AA+JqmDALGTS7bK7Itij0ehBbat8/QIc87akJOWW
	lsBrd9++XQu/toO/auy9kJdfyiArNSiNz5N/3sDCxKvl4DyOXI5z48ZEwLD9WGLD
	wrtrhZQnlQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk49qev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 14:34:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MEKHIR013101;
	Mon, 22 Jun 2026 14:34:22 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jw6s2a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 14:34:22 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MEYLOc19268188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 14:34:21 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0750D5805D;
	Mon, 22 Jun 2026 14:34:21 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 268D958052;
	Mon, 22 Jun 2026 14:34:20 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 14:34:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 16:34:19 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 09/17] target/s390x: Support pckmo encrypt AES
 subfunctions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <d0678c75-68b1-48da-aaf6-c846b48c02e3@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-10-freude@linux.ibm.com>
 <d0678c75-68b1-48da-aaf6-c846b48c02e3@linux.ibm.com>
Message-ID: <3a2169d3ca127e02427217f28c9f8e2e@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX/UAGy7J/y/Fp
 SVp8HecLyBcEwhbTMbgGRm+1ctyYKHafhD+GIQku8R7Zlfin/Murgm1+XuT1UUEIXPD4+5Lwllt
 nfKW6baTR67DuRcTtptbjQsIT1aBPfg=
X-Proofpoint-ORIG-GUID: mlDyt9T8Pf4k_WdnJ6g9b0t1YolHsU20
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3947ef cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=xpaf58q_mXcZgcUq6jUA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0MiBTYWx0ZWRfX6S9Pf75vhccD
 xe0jfi+AsQ3XsatPZrYTUvpdT6j/683gBxZPlm7mt1tZCPSqdXd3NMx1LiCeECDKuqEJGcGRJRW
 xYWOiR1gbOPm0soMcbf4yqev2YobicxWwzKc3zbJWdSTyG/qHQzxiqGEZqSVySN4ogNxsZfCEf9
 7lg+qxm7K/bFOoop0bJkqfdDdjulljSXnm8E1Zgb1QaZQllotVzxUir/p1xeZE6on4ZzW/n6n28
 ceflL9YGA9QYWtkdAd1IW9b+VVZlJh5tYjCfVosNgd/pJfLx7NZUjYplHnI0jVjmrVHiIqBz2GN
 TfE4wSQ4wbR7p3BfFhjTZI1Pu+XXgcRXzcU8DGVBCQ/722dZo28C3KWUvAZfmUVF46+CQfeFoZN
 +WJQtFRtGtbdPYS7xlCpdum6A3k648R/lFnahYUCuD2aj6kUkxssg835ttXSQxV26jDP6cvSGJn
 Y0qSEBo3ebdDdvdmnLg==
X-Proofpoint-GUID: mlDyt9T8Pf4k_WdnJ6g9b0t1YolHsU20
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220142

On 2026-06-18 07:50, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfuctions PCKMO-Encrypt-AES-128-Key,
>> PCKMO-Encrypt-AES-192-Key and PCKMO-Encrypt-AES-256-Key.
>> 
>> These subfunctions derive a protected key from an AES clear key
>> by encrypting it with an internal AES wrapping key. More
>> details can be found in the "z/Architecture Prinziples of
>> Operation" document.
>> 
>> The qemu version provided here is only a fake indented to make
> 
> typo: indeted -> intended
> 
>> protected key available for developing and testing purpose:
>> * The protected key is 'derived' from the clear key by xoring
>>    the fixed pattern 0xAAAA... onto the key value.
>> * The AES Wrapping Key Verification Pattern is a fixed
>>    value of 32 bytes 0xFACEFACE...
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the typo fixed and the other comments at least considered:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  2 +
>>   target/s390x/tcg/cpacf_aes.c     | 66 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 21 ++++++++++
>>   4 files changed, 92 insertions(+)
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index 0312436c43..5a0a3473d5 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -467,3 +467,69 @@ int cpacf_aes_xts(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +/*
>> + * Hard coded pattern xored with the AES clear key
>> + * to 'produce' the protected key.
>> + */
>> +static const uint8_t protkey_xor_pattern[32] = {
> 
> the wrapping key for protected keys is called virtual server master
> key if I recall correctly. Maybe name this accordingly or at least
> something with master or wrapping key in it as this describes the
> purpose better I think.
> 

But honestly I don't want to call this a key - neither a wrapping nor
a virtual server master key. This is a simple xor pattern to be applied
to the clear key value. I don't want to call this a key in any way.
If I would label this a key someone (or AI) would immediately raise
a security finding - hard coded key / weak key / key in code ...

>> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
>> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
>> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA,
>> +    0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA, 0xAA };
>> +
>> +/*
>> + * Hard coded wkvp ("Wrapping Key Verification Pattern")
>> + */
>> +static const uint8_t protkey_wkvp[32] = {
> 
> Since you call this protkey_wkvp you could call the wrapping key 
> protkey_wk.
> 
>> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
>> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
>> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E,
>> +    0x0F, 0x0A, 0x0C, 0x0E, 0x0F, 0x0A, 0x0C, 0x0E };
> 
> [ snip ]
