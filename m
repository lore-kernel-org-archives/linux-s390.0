Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B45F402420
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 09:28:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783589339; cv=none; b=pGqyNn04YvhfGzykqXPAK+43Q9yIQtuzgiJDTtT6DvTWHDdoCytuoR4KojMCTG0WXcsY19DX0F/J4Lzj6zVS6xIdEtYqRlYPPgowjmQ2+Qrv8sT2rskzlH7a55snnmkpvO3IaeSy5Er+2mQ8mwFt5r0yZxCiIOajaAFc3iJlr9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783589339; c=relaxed/simple;
	bh=PBCx6VlbnzAC4y+/GLHpa00Gx8n0g+sooIWqisGzejE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=YjKC11NHl2MKvVmS0XwyP7UndzThOLWb6gS8u/uJ7VIurnVsN8kjiE/ethanherm8DNmU5M9TvA0p3OA/MGuVJk31bTLxE5wk2xKkKWJar1Gr6NzS/HgTrTCpopmXQw35/DgaDry9uwFYFjOvzBByDyXHcijhLz6qG4FSGt+cCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hlYt/ESX; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hlYt/ESX"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6696INNU1535411;
	Thu, 9 Jul 2026 09:28:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=uqpvrrqSnTkzGoGoAXvaPZRc/o9xduczg511LWkRzuk=; b=hlYt/ESXUzaG
	Dv94cZ/d2ecdOHkouIxNGcAuiJihlGsc74L4Ga8h/3IZWbHskEfswgFJGIQuxgTn
	wGsEyfkGPCj01QA65Uh17fID1+T3+PULn4WIOclbcU2DJMoH2YmyGV71q9CcaE5o
	+7QOvtmBe17nIzSICinyOnhpMGUcsv6YA02x91zirTR/zQqCMeEy2kFt2bgnfr5Z
	r32y7iJUJs8ufIQUnWhDK9nXca/Ac3FgZMfq5QjFA2Zg7LpHxCwf0xeL7rQN+iz+
	vNciURvvmufHS6IowO3AKXoyC3KPZak3jokI5ctQ8EvHDSa+w3jA9lj7+7m7L28w
	EorR0FNVXA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknrews-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:28:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6699JcD7004480;
	Thu, 9 Jul 2026 09:28:46 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7dgkcg0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Jul 2026 09:28:46 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 6699SjJl32506456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 09:28:45 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8B8C258054;
	Thu,  9 Jul 2026 09:28:45 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90ECB5804E;
	Thu,  9 Jul 2026 09:28:44 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Jul 2026 09:28:44 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 09 Jul 2026 11:28:44 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: richard.henderson@linaro.org, iii@linux.ibm.com, david@kernel.org,
        thuth@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v11 19/21] target/s390x: Use generic AES helper functions
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <ak6AoBLuS5PZmOB6@redhat.com>
References: <20260707161815.40919-1-freude@linux.ibm.com>
 <20260707161815.40919-20-freude@linux.ibm.com> <ak6AoBLuS5PZmOB6@redhat.com>
Message-ID: <21c30b3d8d79f9833d1df7b2874c3b11@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4f69cf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=fl1GoCeS9bTKRjxQArwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: tiPCbN60yVZBNHhxrpNsQzppfPF7923T
X-Proofpoint-ORIG-GUID: tiPCbN60yVZBNHhxrpNsQzppfPF7923T
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX9b1aeNEQDEAa
 zaMrrVCLaBP64mgtSOs/qXSKawwZUY3VGBMH3fF+DW8mEeaxQkYdbYk1/05tXrqASpN9KYnZM0w
 rruQu2VhVfuBm03iw8KzaA/we79i2rA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDA4OSBTYWx0ZWRfX+EXjwnkFMx8U
 x1XIw8f/YoHCdzALuLxAzVSOjInqSjUqealp04pAFOHwmA2jAAiHqKF+mIiRHku7f0nrTdvS8k8
 AWL1cE4cQkOC3rgrja+H6bgwNIMq3c8LDHOrFOssypEL0Wn3GTA9ZsxehW+g6T6sKx2yo2wyDSN
 5aOCIxUY2XU9LuM+jhkQy6OJpth4gdVvt+dSesJwGbYQTJ4/8Sj2//kbR2vgt2Pj1djoiiEygiM
 o/TGlc+dU1S0iediZiVWgxmEyFrjaA+CG6QJZ2V06ZgbE1mMbjA8o9j6kloQmV9VaIwKYFRYCbc
 IV5QFGmnuL7y7MTGFrH3CEiSLHsLVYX1I0Ya47izuLDhkRntlgKAAh0kyKcN+dsy15KNcoZv0Ft
 Qeq97njSg4SbgUSSYoaC/8y72JUmZImereIc2LhNX63sOpzu0ssz8md6eGHxwtzgGi/8aGIhbyO
 arsHjrG2U60t1cpYJZA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_01,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090089

On 2026-07-08 18:53, Daniel P. Berrangé wrote:
> On Tue, Jul 07, 2026 at 06:18:06PM +0200, Harald Freudenberger wrote:
>> Rewrite the cpacf implementations to use the generic
>> AES helper functions from crypto/aes-helpers.c
> 
> The aes-helper.c addition should be done at the start of this series,
> and then the impls can use the AES helpers right from the start.
> 
> This avoids the reviewers having to review code that is never merged
> due to being replaced in this patch.
> 
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>  target/s390x/tcg/cpacf_aes.c | 124 
>> ++++++++++-------------------------
>>  1 file changed, 36 insertions(+), 88 deletions(-)
>> 
>> diff --git a/target/s390x/tcg/cpacf_aes.c 
>> b/target/s390x/tcg/cpacf_aes.c
>> index 4449bbc0d2..e9f0db2b5a 100644
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -110,20 +110,13 @@ int cpacf_aes_ecb(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      return !len ? 0 : 3;
>>  }
>> 
>> -static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t 
>> *dst)
>> -{
>> -    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
>> -        dst[i] = src1[i] ^ src2[i];
>> -    }
>> -}
>> -
>>  int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>>                    uint64_t param_addr, uint64_t *dst_ptr_reg,
>>                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>>                    uint32_t type, uint8_t fc, uint8_t mod)
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> -    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], 
>> buf[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>>      uint64_t addr, len = *src_len_reg, done = 0;
>>      int i, keysize, addr_reg_size = 64;
>> @@ -179,19 +172,11 @@ int cpacf_aes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>>          if (mod) {
>> -            /* decrypt in => buf */
>> -            AES_decrypt(in, buf, &exkey);
>> -            /* buf xor iv => out */
>> -            aes_xor(buf, iv, out);
>> -            /* prep iv for next round */
>> -            memcpy(iv, in, AES_BLOCK_SIZE);
>> +            /* decrypt in => out */
>> +            AES_cbc_decrypt(in, out, iv, &exkey);
>>          } else {
>> -            /* in xor iv => buf */
>> -            aes_xor(in, iv, buf);
>> -            /* encrypt buf => out */
>> -            AES_encrypt(buf, out, &exkey);
>> -            /* prep iv for next round */
>> -            memcpy(iv, out, AES_BLOCK_SIZE);
>> +            /* encrypt in => out */
>> +            AES_cbc_encrypt(in, out, iv, &exkey);
>>          }
>>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>> @@ -221,11 +206,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> -    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>>      uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>      uint64_t addr, len = *src_len_reg, done = 0;
>> +    uint8_t ctr[AES_BLOCK_SIZE], key[32];
>>      int i, keysize, addr_reg_size = 64;
>> -    uint8_t key[32];
>>      AES_KEY exkey;
>> 
>>      g_assert(type == S390_FEAT_TYPE_KMCTR);
>> @@ -267,12 +251,10 @@ int cpacf_aes_ctr(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>>          /* read in nonce/ctr => ctr */
>>          aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
>> -        /* encrypt ctr => buf */
>> -        AES_encrypt(ctr, buf, &exkey);
>>          /* read in one block of input data => in */
>>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> -        /* xor input data with encrypted ctr => out */
>> -        aes_xor(in, buf, out);
>> +        /* encrypt ctr and xor with in => out */
>> +        AES_ctr_encrypt(in, out, ctr, &exkey);
>>          /* write out the processed block */
>>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>> @@ -353,28 +335,13 @@ int cpacf_aes_pcc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      return 0;
>>  }
>> 
>> -static void aes_xts_prep_next_tweak(uint8_t tweak[AES_BLOCK_SIZE])
>> -{
>> -    uint8_t carry;
>> -    int i;
>> -
>> -    carry = tweak[AES_BLOCK_SIZE - 1] >> 7;
>> -
>> -    for (i = AES_BLOCK_SIZE - 1; i > 0; i--) {
>> -        tweak[i] = (uint8_t)((tweak[i] << 1) | (tweak[i - 1] >> 7));
>> -    }
>> -
>> -    tweak[i] = (uint8_t)(tweak[i] << 1);
>> -    tweak[i] ^= (uint8_t)(0x87 & (uint8_t)(-(int8_t)carry));
>> -}
>> -
>>  int cpacf_aes_xts(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>>                    uint64_t param_addr, uint64_t *dst_ptr_reg,
>>                    uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>>                    uint32_t type, uint8_t fc, uint8_t mod)
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> -    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>>      uint64_t addr, len = *src_len_reg, done = 0;
>>      uint8_t key[32], tweak[AES_BLOCK_SIZE];
>> @@ -425,23 +392,19 @@ int cpacf_aes_xts(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>> 
>>      /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> -        /* fetch one AES block into buf1  */
>> -        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
>> -        /* buf1 xor tweak => buf2 */
>> -        aes_xor(buf1, tweak, buf2);
>> +        /* fetch one AES block into in  */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>>          if (mod) {
>> -            /* decrypt buf2 => buf1 */
>> -            AES_decrypt(buf2, buf1, &exkey);
>> +            /* decrypt in => out */
>> +            AES_xts_decrypt(in, out, tweak, &exkey);
>>          } else {
>> -            /* encrypt buf2 => buf1 */
>> -            AES_encrypt(buf2, buf1, &exkey);
>> +            /* encrypt in => out */
>> +            AES_xts_encrypt(in, out, tweak, &exkey);
>>          }
>> -        /* buf1 xor tweak => buf2 */
>> -        aes_xor(buf1, tweak, buf2);
>>          /* prep tweak for next round */
>> -        aes_xts_prep_next_tweak(tweak);
>> -        /* write out this processed block from buf2 */
>> -        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
>> +        AES_xts_prep_next_tweak(tweak);
>> +        /* write out this processed block from out */
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>>          done += AES_BLOCK_SIZE;
>>      }
>> @@ -637,7 +600,7 @@ int cpacf_paes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>                     uint32_t type, uint8_t fc, uint8_t mod)
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> -    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], 
>> buf[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>>      uint8_t key[32], wkvp[32], iv[AES_BLOCK_SIZE];
>>      uint64_t addr, len = *src_len_reg, done = 0;
>> @@ -705,19 +668,11 @@ int cpacf_paes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>>          if (mod) {
>> -            /* decrypt in => buf */
>> -            AES_decrypt(in, buf, &exkey);
>> -            /* buf xor iv => out */
>> -            aes_xor(buf, iv, out);
>> -            /* prep iv for next round */
>> -            memcpy(iv, in, AES_BLOCK_SIZE);
>> +            /* decrypt in => out */
>> +            AES_cbc_decrypt(in, out, iv, &exkey);
>>          } else {
>> -            /* in xor iv => buf */
>> -            aes_xor(in, iv, buf);
>> -            /* encrypt buf => out */
>> -            AES_encrypt(buf, out, &exkey);
>> -            /* prep iv for next round */
>> -            memcpy(iv, out, AES_BLOCK_SIZE);
>> +            /* encrypt in => out */
>> +            AES_cbc_encrypt(in, out, iv, &exkey);
>>          }
>>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>> @@ -747,11 +702,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> -    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>>      uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint8_t ctr[AES_BLOCK_SIZE], key[32], wkvp[32];
>>      uint64_t addr, len = *src_len_reg, done = 0;
>>      int i, keysize, addr_reg_size = 64;
>> -    uint8_t key[32], wkvp[32];
>>      AES_KEY exkey;
>> 
>>      g_assert(type == S390_FEAT_TYPE_KMCTR);
>> @@ -805,12 +759,10 @@ int cpacf_paes_ctr(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>>          /* read in nonce/ctr => ctr */
>>          aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
>> -        /* encrypt ctr => buf */
>> -        AES_encrypt(ctr, buf, &exkey);
>>          /* read in one block of input data => in */
>>          aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> -        /* exor input data with encrypted ctr => out */
>> -        aes_xor(in, buf, out);
>> +        /* encrypt ctr and xor with in => out */
>> +        AES_ctr_encrypt(in, out, ctr, &exkey);
>>          /* write out the processed block */
>>          aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>> @@ -911,7 +863,7 @@ int cpacf_paes_xts(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>                     uint32_t type, uint8_t fc, uint8_t mod)
>>  {
>>      enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> -    uint8_t buf1[AES_BLOCK_SIZE], buf2[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>>      const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>>      uint8_t key[32], wkvp[32], tweak[AES_BLOCK_SIZE];
>>      uint64_t addr, len = *src_len_reg, done = 0;
>> @@ -974,23 +926,19 @@ int cpacf_paes_xts(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>> 
>>      /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>>      for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> -        /* fetch one AES block into buf1  */
>> -        aes_read_block(env, mmu_idx, *src_ptr_reg + done, buf1, ra);
>> -        /* buf1 xor tweak => buf2 */
>> -        aes_xor(buf1, tweak, buf2);
>> +        /* fetch one AES block into in */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>>          if (mod) {
>> -            /* decrypt buf2 => buf1 */
>> -            AES_decrypt(buf2, buf1, &exkey);
>> +            /* decrypt in => out */
>> +            AES_xts_decrypt(in, out, tweak, &exkey);
>>          } else {
>> -            /* encrypt buf2 => buf1 */
>> -            AES_encrypt(buf2, buf1, &exkey);
>> +            /* encrypt in => out */
>> +            AES_xts_encrypt(in, out, tweak, &exkey);
>>          }
>> -        /* buf1 xor tweak => buf2 */
>> -        aes_xor(buf1, tweak, buf2);
>>          /* prep tweak for next round */
>> -        aes_xts_prep_next_tweak(tweak);
>> -        /* write out this processed block from buf2 */
>> -        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, buf2, ra);
>> +        AES_xts_prep_next_tweak(tweak);
>> +        /* write out this processed block from out */
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>>          len -= AES_BLOCK_SIZE;
>>          done += AES_BLOCK_SIZE;
>>      }
>> --
>> 2.43.0
>> 
> 
> With regards,
> Daniel

I'll do this. Thanks for your feedback
