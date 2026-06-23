Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A261A344DB9
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 12:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217466; cv=none; b=SGdBu/arZeGlYlHwPQX05pKyknkBSWr8/958uG5JrRi7C3e3+w8ur89CkLeAb1NDVjRjikQkJvbeiv4qMP34XJEursThkuAioW+aFjVAf0n5ix0MxsyJ3BIVjdSSO36FCAdSp6fSxSE5Orad+0kY+tIyQfI2akzERRAiENizlO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217466; c=relaxed/simple;
	bh=ZZpW21iPgH8ALqglyBLt6gub4mIO/bKWKlswtVgvkaI=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=jfC0FpRz670NN74EzbcNhqR41IIWPXuZIqE73pFGahomwW5YLRMsqRe/hN/jQ8bpp3BvxHORFGMEQPbuJMwFy8qYT9vWc92UTo6KxrKW2vw9ssMz/PPcz/sczj6MYVt8tJZ80hX5TsLLIS75/WXD2HL082cnkGq1j1EXUGE9Dao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ZpOEczn/; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ZpOEczn/"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmjEx1915054;
	Tue, 23 Jun 2026 12:24:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=jJlrFbym56dJKE1AZbRhLcuIOs4/neo4BLF/YQjJDJY=; b=ZpOEczn/sa+0
	NnHVKUA6ny02dSmcw2X0QrNlRG1NRFW6LYgj5zRa/56yfBJS3Vd3w6Mm7hEbuObX
	tr76kpWWL+F4y7FI1tZ06wkCJOOyAQ5yP1axfDizfyZ2G+zhSgLjEhknOBOZQqoG
	xIjbDyzWGTxgiavimqltAF6lDA6FZSpPe+O2D8SrFfpPzrUVmw+QtBVon9ViPz5o
	662x/qxbe1MuM9v9rEkYyoLpW+QY18KyS3mUBxPZrr2tPo9ZPbvN8DrPhKX8Bj5x
	DYJo2b6NYrs+X71dFglhl5eTmW2EKXhKhYJqyc2xpoaZOLYMYa2Mbvlf3uQrQTp8
	J2w2cOUGtg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4ecks-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:24:15 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCJdu1031175;
	Tue, 23 Jun 2026 12:24:14 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyjufu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:24:14 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NCODU229819526
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 12:24:13 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BFC0858051;
	Tue, 23 Jun 2026 12:24:13 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D6C465805F;
	Tue, 23 Jun 2026 12:24:12 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 12:24:12 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:24:12 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 11/17] target/s390x: Support protected key AES CBC for
 cpacf kmc instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <cc246d3d-0436-4d23-b2ce-0fdd000c0490@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-12-freude@linux.ibm.com>
 <cc246d3d-0436-4d23-b2ce-0fdd000c0490@linux.ibm.com>
Message-ID: <be479b3e8bd279aa004c299b4870bb46@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfXxePcvQyIpQ+7
 +9z0j/swftX7zvRdKjZh80Hj35DLdVDQORWTHeF7A9/5JgquhkhRpVdNDVkJlNxwZM/0/iiz2nm
 hLMLjILi/zsrlU8ViNENeo1/yS5wy/M=
X-Proofpoint-ORIG-GUID: GhcUWU6FiFMVnM5nQQ68-Q4fdE0Zah-d
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a7aef cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=tpjd7WJl69OpYSVX48oA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX8q21BF/ojBJ8
 SQ1B7UaQHGfQI/6Mx4OqexKc7fmhZkLLn9WU34wjcvVdwN1huSCK3pJ+kbZGvQry2ARkvxJZ+rk
 jEifSaKTFHS9erJRrYln4HkOZ4F3vlcTr4f0DP3bUgxbLUmk7tpC0un5LnAgJwtfTPfZxMH1SnW
 KP9ZJh97lzOkLzHfAweXHsXi7abbMKO0elKH2h7oVdsmRMyRVKkPPH5IcDVUubLriPxdTLbLdWu
 hcev7Ew+/+PW/bzJ9aIbFhw553D6UxYuCoaNcQVZs+pE/oFccq8uRZl5d3fM/imeoTiQJ6yW2Xc
 qPCmTCfqKLHx4sAaLQ9wCauyUA5ALrjQmBOpchx8Csv33XRvHR8DiOR3dRZb8zkFDEtRvt3iuWV
 QaaTSo0uu3eiD3Vzw94CYCL71mlSytvWi2x5myid0jmKjPZzAaiu5jGDipEm2bRVdN6/3S3QU2q
 ZLDI8wD1Wninp/gOezQ==
X-Proofpoint-GUID: GhcUWU6FiFMVnM5nQQ68-Q4fdE0Zah-d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

On 2026-06-18 08:08, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMC_PAES_128, CPACF_KMC_PAES_192
>> and CPACF_KMC_PAES_256 for the cpacf kmc instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> 
> With the suggested changes:
> 
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> 
>> ---
>>   target/s390x/gen-features.c      |   3 +
>>   target/s390x/tcg/cpacf.h         |   4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 109 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |   7 ++
>>   4 files changed, 123 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 71e0e41d6e..074c53aecd 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -932,6 +932,9 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KMC_AES_128,
>>       S390_FEAT_KMC_AES_192,
>>       S390_FEAT_KMC_AES_256,
>> +    S390_FEAT_KMC_EAES_128,
>> +    S390_FEAT_KMC_EAES_192,
>> +    S390_FEAT_KMC_EAES_256,
> 
> Again, either EAES -> PAES or EAES -> ENCRYPTED_AES
> 

Again - out of the scope of this patch series.

>>       S390_FEAT_KMCTR_AES_128,
>>       S390_FEAT_KMCTR_AES_192,
>>       S390_FEAT_KMCTR_AES_256,
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index bcfcf3b660..a6487261e1 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -620,3 +620,112 @@ int cpacf_paes_ecb(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_paes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                   uint32_t type, uint8_t fc, uint8_t mod)
>> +{
> 
> [ snip ]
> 
>> +    /* fetch protected key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +    /* 'decrypt' the protected key */
>> +    for (i = 0; i < keysize; i++) {
>> +        key[i] ^= protkey_xor_pattern[i];
>> +    }
> 
> You would already benefit from the suggested outsourcing.
> 

Yep, done.

>> +
>> +    /* expand key */
>> +    if (mod) {
>> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
>> +    } else {
>> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +    }
> 
> [ snip ]
