Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A385940DFBD
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 13:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827998; cv=none; b=g6zdx4Qx8/uLR6KpKIDvfHPMUpuy14x9ydY8KvPUhHYeToKHcTQrX3/p6GkjP6NKaUTcrLuJCG8DOTNaZNqDWhpnxnXy0gFx/jswgoFhw5m0qh9rZFIZ6aLulTnsLVtKhL0E62XW3NIQ1Etw9Cg6sBDkqBU7dWw/UQHsHma0PZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827998; c=relaxed/simple;
	bh=PQyeajGdi8AQhZGpaeHSRdwCctOJcLuqy4UuzkxlJGA=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=rlxEF4lslYYRdYb7qnZJN/y5Lu2tEUws93Z22d0gOIMgeBURgdE8e94HhKH2VqKDOmbFgyiJ3AfiC7Ft3uAT6DKzU+hcZLGpWLiVj2/6MJivgOOjHGi0wKmiYJG0TIdiiaUyhXAasHDGlW3IxtoPX/sFbVHn3Pdg70Omg5vF4MM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=b5srNAfO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="b5srNAfO"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nJvE1535058;
	Tue, 30 Jun 2026 13:59:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=DwbGV7+T1Yrf9/3wO3J1YAxHmEC6q/0qNJY7UW7WU1s=; b=b5srNAfODP58
	lhmIhiCRNWsV23hUVni/pqaBEu+vKp1idSqCX4z00QxgkZBpDiM3+f2f2StAhtbR
	RoRl3CsDpjP1/7oxeHsjrHnuNy/PlOAWgRXinFbotRScvC+ziPCOy5b503EmRUWL
	aOi3S35BLGGBkZ3wzLqpDUchSDEGt5ssq6fmznUbbxtGSBztGA2C82nRgcc9xX/n
	q2kH9l6OykZd7uXCphtFFhmPpYdQEsVN076vpODCQxqoWSnK1vBpRu4BUJUikpx5
	/u/rcpiX6lZsc0CWDAHS9irENR5rGBkCAgR6GioXmLNFEMG57aOdbH2Uv4GnJ40B
	rt1gJi+QtA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26mjpvw1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:59:49 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UDnvd3032252;
	Tue, 30 Jun 2026 13:59:48 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhafat-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:59:48 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UDxlwL26018506
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 13:59:47 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6E3D858056;
	Tue, 30 Jun 2026 13:59:47 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 503A65805D;
	Tue, 30 Jun 2026 13:59:46 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 13:59:46 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jun 2026 15:59:45 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 06/18] target/s390x: Support AES CBC for cpacf kmc
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <193565c3-6215-4dd7-bb99-4410ed48196f@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-7-freude@linux.ibm.com>
 <193565c3-6215-4dd7-bb99-4410ed48196f@linux.ibm.com>
Message-ID: <81ddd4d2d7c3912704c41db6bd2bf453@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfX52ctn0xxmTQy
 7re+EvqxVXnrJoOKrh043Q5Q3BcRZnrweCEytXwi+ppvJ833rasG47F3pkAQJ8OwDoePrCDyUy3
 2/8ltBKS2oV0oYAjOKuiC4P4blcQfFW+tTXEXEfFv8eEf6CpknkDEcQuE4emkkKfUyPzXjxQsVM
 V5RP5OhnSqehn8PkkWW3wWJo29a2+gbRPm6ut0V4s4JrpH5DgySoZxiW9y3Ih9UnXllCkfONAyS
 Of54e+T2IBPHfzSVy1ADz7IIjw9xOmGZ2CYg1SSUKtBQySC14Ljff1E6JEtYdEz39F0daLRuvHW
 F8jlE7nLXcOKYayR7XOFgThxaW1D++j8WT3WQmYPnY7muy8uaFkaC+iCGQfRarZNeH9+N1hYjxe
 jscnGXwlQw7tX3iVwtJzIafC9J0ff4ZvRdwu1sBZHOO8u1FmQwYWxFXIk9Irzj6xI0j/NI0zEt3
 5m/adFX8au8VZpdrESg==
X-Proofpoint-GUID: 19iLcD2_3rvNgPqS3-K03qt3fjAeAvJs
X-Authority-Analysis: v=2.4 cv=Z8bc2nRA c=1 sm=1 tr=0 ts=6a43cbd5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=SFrgTpVYP7yuAwOcGMEA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfXx79Mi0z/yyTC
 Sml/B6tCFDPnzhQqVtVuk+bruyYXIxJvTeBEbwvM1RvlN6wGfoF7gU4S3+kXv+Ua6w2KDmOEhRv
 gyOoLqSUr1JPRqJpJF84gQqDgsGTJ8E=
X-Proofpoint-ORIG-GUID: 19iLcD2_3rvNgPqS3-K03qt3fjAeAvJs
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 impostorscore=0
 malwarescore=0 phishscore=0 bulkscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300129

On 2026-06-24 19:22, Ilya Leoshkevich wrote:
> On 6/24/26 10:10, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
>> and CPACF_KMC_AES_256 for the cpacf kmc instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Tested-by: Holger Dengler <dengler@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |   3 +
>>   target/s390x/tcg/cpacf.h         |   4 ++
>>   target/s390x/tcg/cpacf_aes.c     | 102 
>> +++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c |  24 ++++++++
>>   4 files changed, 133 insertions(+)
> 
> [...]
> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index ba836f1473..6412cc187d 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -111,3 +111,105 @@ int cpacf_aes_ecb(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t 
>> *dst)
>> +{
>> +    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
>> +        dst[i] = src1[i] ^ src2[i];
>> +    }
>> +}
>> +
>> +int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint32_t type, uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], 
>> buf[AES_BLOCK_SIZE];
>> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> +    uint64_t addr, len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32], iv[AES_BLOCK_SIZE];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KMC);
>> +
>> +    switch (fc) {
>> +    case 0x12: /* CPACF_KMC_AES_128 */
>> +        keysize = 16;
>> +        break;
>> +    case 0x13: /* CPACF_KMC_AES_192 */
>> +        keysize = 24;
>> +        break;
>> +    case 0x14: /* CPACF_KMC_AES_256 */
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
>> +
>> +    if (!(env->psw.mask & PSW_MASK_64)) {
>> +        len = (uint32_t)len;
>> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
>> +    }
>> +
>> +    /* length has to be properly aligned. */
>> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
>> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>> +    }
>> +
>> +    /* fetch iv from param block */
>> +    for (i = 0; i < AES_BLOCK_SIZE; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +
>> +    /* fetch key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
> 
> Another couple of candidates for copy_from_guest_wrap().
> 

Yes, makes sense to have some (inline) function. I think I will add
something to cpacf.h.

>> +
>> +    /* expand key */
>> +    if (mod) {
>> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
>> +    } else {
>> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +    }
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> +        if (mod) {
>> +            /* decrypt in => buf */
>> +            AES_decrypt(in, buf, &exkey);
>> +            /* buf xor iv => out */
>> +            aes_xor(buf, iv, out);
>> +            /* prep iv for next round */
>> +            memcpy(iv, in, AES_BLOCK_SIZE);
>> +        } else {
>> +            /* in xor iv => buf */
>> +            aes_xor(in, iv, buf);
>> +            /* encrypt buf => out */
>> +            AES_encrypt(buf, out, &exkey);
>> +            /* prep iv for next round */
>> +            memcpy(iv, out, AES_BLOCK_SIZE);
>> +        }
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
> 
> I think
> 
>     len -= AES_BLOCK_SIZE;
>     done += AES_BLOCK_SIZE;
> 
> would be clearer.
> 
> 
> Other than that:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]
