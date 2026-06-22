Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9758C3264EF
	for <linux-s390@vger.kernel.org>; Mon, 22 Jun 2026 15:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782140742; cv=none; b=rajk4Bwu+RILqjK7tfqd8zzUYYkqk3/e6lnBgMXlAfNF2yLAz5BZYvR6mma89TTj41P5GmiQ5MGOiyWkxO2jzYuFbxQafX8FioQOZbC0rfHsG0nkUI+f7F1PWRAB0hbQH+HZJBgSm2LIS97AWlmRxmlVjd2zejYJ7y3tdWQXhnw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782140742; c=relaxed/simple;
	bh=ujrvdMByqZyhyDwGWCRhydf5OEmGWDStHKs5lhhCHYM=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=XVCndUIFLh0QpsNAw2u8GPv32B+q3oxUD5WgZk35bQXfvGSg+WDzMXqJKBylOXbfdZEsk46hmXgEpGWogqNohp/2fioArO9I7DNOxSIRiD6Nd8d9seZ7fUUIdhNBWjm3I7Jxd2QXv2i8Oq4U6QNaOtJUXPlIGvWLTzeK2HMQndQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ofz3IiMp; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ofz3IiMp"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65MDIOSU2921959;
	Mon, 22 Jun 2026 15:05:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=2W8I1BMyBqpd1ivAhqWNmk9GdIkqpbGHYWjDco2yphw=; b=ofz3IiMppdNH
	nDTZib6SOmzyO08ViQQ5HklFB2LPKL/I3GeFhMAMPTY217VPdl812ojyNzDWTjUk
	yVblW2aWsww4Z6oDZDi1wMEQaunOMX8QoxBnsf6O7BR2L+m2J6Ou7vzGIFpw9BPm
	voetK+atahKnzdnWgPe++YsDVSE25rh82SV7U4K6wsZbHnuJoGzr4k3oUENR/Q3C
	Xka6IAMoycWW5H703oYsdQXTPUUFEQedia+YJ8q9LB1NKGR81npjOAY4LfnARS0s
	I+NpNt39OC3SGUqiaWhuOYkUSv2JWbCflYIWz8YK+hSF5dRpmbJbH2R5i43dayvE
	CHDq5eX6qw==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk49vkq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 15:05:32 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65MF4bBs018738;
	Mon, 22 Jun 2026 15:05:31 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7dfxjcf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Jun 2026 15:05:31 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com [10.39.53.230])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65MF5Tk134865772
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jun 2026 15:05:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D93EB58054;
	Mon, 22 Jun 2026 15:05:29 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA9EA5805D;
	Mon, 22 Jun 2026 15:05:28 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Jun 2026 15:05:28 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 22 Jun 2026 17:05:28 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 10/17] target/s390x: Support protected key AES ECB for
 cpacf km instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <943edaf2-801b-4124-a7c7-67555ba2ac28@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-11-freude@linux.ibm.com>
 <943edaf2-801b-4124-a7c7-67555ba2ac28@linux.ibm.com>
Message-ID: <78bcb32f11ecd35f1647e4a11b12cdf8@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX/0EChDzwNuae
 Ki/pjT53bOjB8ZXNGsp07JyGg3xg0tk7RugkqmnlCqIRtxGiDUIHTufpp14SQYT4WngpwJIBUmx
 fY4tz3kx1JpYvSF8Cmhj+p45Rm8OvAg=
X-Proofpoint-ORIG-GUID: QhXmWL44NvsfDDhQe1qJCDaeDxoXgncP
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a394f3c cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=p5adxXorVEag3c1WdLgA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIyMDE0NyBTYWx0ZWRfX628dfeSPENqQ
 0ZIJpGsxbZhsgPKEBkup4CopsICeet55i/HL06bhgWUw8E2Wbq1x75/1vqhVMIia/5QTADma3Dv
 /MqLyo5HSs2UNS6glex3YTP02wFgfj/4Je0hWsX1SuKv8vzDLVEFOggCCmZkbBNOWjPj7pjZuS2
 XGs0K3k2wCWM4M6TRj/EPdAXl7vWSaZvnQrsBYcGeOmY5CDz00Jx5nAKb76/mkV4pCs31NTmr83
 2GtF1YU4wAyL+DrYrnmDfMWj2z+/yH++vJw1eVyRLGMf3eBAATo6sQs7dQUJNaaD860ZiSUBySC
 NUVu6fjlWL9KlKLMAeUStudxX5RgAVxUFYF7Sw+2SKVMmIcU1Uu7ivYEep8RvNeXs97QqyW0LNb
 wMzfP2hSNVHghQEJumSsgFwz7h2BLhqbRc2y9EjysthdfRZM9IwYQ7IEQs5yeAmN1XrGq/v3EWK
 U7vqKBgRJ3wlK4evm6g==
X-Proofpoint-GUID: QhXmWL44NvsfDDhQe1qJCDaeDxoXgncP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-22_02,2026-06-22_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606220147

On 2026-06-18 07:57, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KM_PAES_128, CPACF_KM_PAES_192
>> and CPACF_KM_PAES_256 for the cpacf km instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the comments at least considered:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 87 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>   4 files changed, 101 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index d3e69aaca6..71e0e41d6e 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -924,6 +924,9 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KM_AES_128,
>>       S390_FEAT_KM_AES_192,
>>       S390_FEAT_KM_AES_256,
>> +    S390_FEAT_KM_EAES_128,
>> +    S390_FEAT_KM_EAES_192,
>> +    S390_FEAT_KM_EAES_256,
> 
> I would strongly prefer PAES instead of EAES. I know the CPACF
> function is called KM...ENCRYPTED...AES... but since we use protected
> or PAES in any other context and never Encrypted AES I would highly
> suggest PAES here as well. Or as an alternative expand the E to
> S390_FEAT_KM_ENCRYPTED_AES_128 to match the CPACF naming.
> 

Yes, I am with you. But this is not part of this patch series.
These defines have been introduced into qemu long before this patch.
Maybe someone could rework them but not here and now with this patch
series.

>>       S390_FEAT_KM_XTS_AES_128,
>>       S390_FEAT_KM_XTS_AES_256,
>>       S390_FEAT_KMC_AES_128,
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index 5a0a3473d5..bcfcf3b660 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -533,3 +533,90 @@ int cpacf_aes_pckmo(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return 0;
>>   }
>> +
>> +int cpacf_paes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                   uint32_t type, uint8_t fc, uint8_t mod)
>> +{
> 
> [ snip ]
> 
>> +
>> +    /* fetch protected key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +    /* 'decrypt' the protected key */
>> +    for (i = 0; i < keysize; i++) {
>> +        key[i] ^= protkey_xor_pattern[i];
>> +    }
> 
> Think about outsourcing this into a function as it would improve
> readability and reduce code dublication in future commits.
> 

Yes, let's do this - see v8 of the patch series.

>> +
>> +    /* expand key */
>> +    if (mod) {
>> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
>> +    } else {
>> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +    }
> 
> [ snip ]
