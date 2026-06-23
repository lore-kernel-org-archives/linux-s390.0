Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3216770836
	for <linux-s390@vger.kernel.org>; Tue, 23 Jun 2026 12:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782217954; cv=none; b=ADbXNWhcjPQksLsPvB9TxFG7n147RlMMLtXpfqjkb70Po5/YMCtaEdyfMY07NF5v7gWQsrKYeK1PT1vOMZ70ZP28S0z4dkwdMrTQ26mamciR4TSMisgE2dwStFoXYo1VwdR8O9tG1X53ODVhXbZiFTqDzBXZRtJwTKsml8gup7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782217954; c=relaxed/simple;
	bh=Bmxz11JS3kcN6lPUyaCS2IGW94WV+4kxJ2tL+5Gls+0=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=sEAiteApftnEUHrZvh3YL7YpW94H/blBOQc6GAa7CmoFVaIPxcHsSJNYKNNupBsRW9SKg0Qod+/cw/SyTzY8ZlZON06K8vZ+rJG3nFEFqiNPA9tSxDR6JJK3pXsabZQyN5fCd6mHWogFR+bYotX8/Rk8phg83iaofBpFadUnjss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=D8Ik3dAP; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="D8Ik3dAP"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65NBmbCY1914900;
	Tue, 23 Jun 2026 12:32:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=ii8ubBjO6avbIeg3OwBxjAIAKcfCiZ5n6bXgq00LlOE=; b=D8Ik3dAPfz3/
	SxGZpzJ9JL92LKMb3npEtEQMatoSBSYvBqRkU+ptSUsBHbt1i1PAu62nXXQvfjwi
	NZqR0ehyoG61Qzpfrcvfm/mqw5Nj3pUGZ1SnDAz9ZF3I78iIN5ocM6yD15zCLDYd
	KpKidFZMSNguFWuWG5IaKL2AhsQvAmF3C/K2gbuS70PCWbJCg5IeJgFv8wCBiA3z
	vz8Y4L8+506F1QQMu+ZYfjfWGTyQHki08xzZky6NCWdxuWRiyuIw2oAxVQRCx7Ry
	Vyiuy56KMvjij3mvtx9srlnEPtsJWfHd/uAx2fPypov3Xkkf0TT+3LIVALBNJ+U1
	OV2h/sMu5g==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjk4edtx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:32:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65NCJgBh017867;
	Tue, 23 Jun 2026 12:32:23 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwba9d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Jun 2026 12:32:23 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65NCWMTd10551820
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 23 Jun 2026 12:32:22 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5867058061;
	Tue, 23 Jun 2026 12:32:22 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0682E5805D;
	Tue, 23 Jun 2026 12:32:21 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 23 Jun 2026 12:32:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 23 Jun 2026 14:32:20 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Finn Callies <fcallies@linux.ibm.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, berrange@redhat.com, qemu-s390x@nongnu.org,
        qemu-devel@nongnu.org, linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v7 12/17] target/s390x: Support protected key AES CTR for
 cpacf kmctr instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
References: <20260617094820.34402-1-freude@linux.ibm.com>
 <20260617094820.34402-13-freude@linux.ibm.com>
 <1cf46c18-6b80-415a-bcb8-cb68dea6b69e@linux.ibm.com>
Message-ID: <f1877349fdf56b1d8d4f3e553ae320d9@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX/vqJxXgjo43T
 60YoQIyHzvFS83EcPDdVrAkzvCNhvmLQpFjqaHGHCeko/XIESxJiOB+rYzGYT0rnnQiGNuVne4F
 clDM/bx8wxrTPtV7dHcbNaPDh33LeWo=
X-Proofpoint-ORIG-GUID: fA9wYY68zGxqabxWQKTQhlpqw1drPoFA
X-Authority-Analysis: v=2.4 cv=Oph/DS/t c=1 sm=1 tr=0 ts=6a3a7cd8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=rJUJxA7k1JXDQCIw7yMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjIzMDEwMSBTYWx0ZWRfX2ZuKtRS36qOI
 pq2xN9F1Ermn5h95y2PssDIJ7vpxPR0gh736gPimTKt0AapvcY79733HYRGceyEE2hcJh/VWhaF
 uwZisUjwtKojwv6m5ZZF0mlmwzC0eru6C49pkmQBSw4MjnwYIaEb/on2BNSLTWjuGQJgKZxfMxO
 Q2pAu1LpT0e8G8oaNn4QCcDFQiKDXpoLUWa+NWC15ZzslWCspcLjAnajl/hH5z5Jk5RFmsDMgfz
 KJjsPs2aib04ObKY+S+azYsheahOpaYsG2G3ewz1/lea7GFzVeuBI5Odige8GMu2qQXYPyKpPCn
 5b+tubx7UbR9qisjUcEisVUMI4RJPP9FesZqvUcWSbdbbGV7iFdGlDYSwbCaDJdlcp4J/Bf4KPM
 GxnXtCC3QKFI91GQ28ArUFzTWAxGZv1VO9Lrq6Exj+OhLDkLlQRrmEzHVqpqjTBzRiTrfyeNbG1
 ef+cO0KM5tXECmffYBg==
X-Proofpoint-GUID: fA9wYY68zGxqabxWQKTQhlpqw1drPoFA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-23_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606230101

On 2026-06-18 08:10, Finn Callies wrote:
> On 17.06.26 11:48, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMCTR_PAES_128, CPACF_KMCTR_PAES_192
>> and CPACF_KMCTR_PAES_256 for the cpacf kmctr instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  5 ++
>>   target/s390x/tcg/cpacf_aes.c     | 90 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  7 +++
>>   4 files changed, 105 insertions(+)
>> 
>> diff --git a/target/s390x/gen-features.c b/target/s390x/gen-features.c
>> index 074c53aecd..4a131dc191 100644
>> --- a/target/s390x/gen-features.c
>> +++ b/target/s390x/gen-features.c
>> @@ -938,6 +938,9 @@ static uint16_t qemu_MAX[] = {
>>       S390_FEAT_KMCTR_AES_128,
>>       S390_FEAT_KMCTR_AES_192,
>>       S390_FEAT_KMCTR_AES_256,
>> +    S390_FEAT_KMCTR_EAES_128,
>> +    S390_FEAT_KMCTR_EAES_192,
>> +    S390_FEAT_KMCTR_EAES_256,
> 
> EAES -> PAES or EAES -> ENCRYPTED_AES
> 

Again - not in the scope of this patch series.

>>       S390_FEAT_PCC_XTS_AES_128,
>>       S390_FEAT_PCC_XTS_AES_256,
>>       S390_FEAT_PCKMO_AES_128,
> 
> [ snip ]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index a6487261e1..ffa286d422 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -729,3 +729,93 @@ int cpacf_paes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_paes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                   uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                   uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                   uint64_t *ctr_ptr_reg, uint32_t type,
>> +                   uint8_t fc, uint8_t mod)
>> +{
> 
> [ snip ]
> 
>> +    /* fetch protected key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +    /* 'decrypt' the protected key */
>> +    for (i = 0; i < keysize; i++) {
>> +        key[i] ^= protkey_xor_pattern[i];
> 
> Outsourcing if you see a benefit.
> 

Yep, done.

>> +    }
>> +
>> +    /* expand key */
>> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
> 
> [ snip ]
