Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8825136655D
	for <linux-s390@vger.kernel.org>; Tue, 30 Jun 2026 13:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827914; cv=none; b=JjbPom+0ysgZV7DDHSsjxq4QnPwzqz8Izy2x698g+HZg3SRoj2D1KtXYpXgUjufRcm+hnNyIXf3QMplmjg5Kpj+4+jPy5Di5oQSDhAXSLM7wjQJ4MWHBuu5iO+vPnGsGHLinieABROTDdOzJqFsDJb5OCi0liupVTH5Drmb0wYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827914; c=relaxed/simple;
	bh=o70PY43WRYMDs0muOBFnRai7bp/G71BuEjdWDdQYTGE=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=swlYAFtWtbicAObS6mWNcVFDtg48ta+9ILaRNqfpsD8UkWIal6G7/a8ncy8CnjxpglGogfhIeFYqch3FOLib3RqhM59kuJ7FX21YRKTpw8fsWSb9WbAlcQ7F3DupSNu51YkTlafAmHteYyRdBi9k2bb4mWviwW3QWOJAsPkxJY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BPvBQh9k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BPvBQh9k"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65U9nAhr1578229;
	Tue, 30 Jun 2026 13:58:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:reply-to:subject:to; s=pp1;
	 bh=6dsnWHSgujZZiPcVNMGZL5eaLxQl/jvISiq0nHJVvgM=; b=BPvBQh9kZbJ0
	JjO+QEq1zw33QCazqc8Rl2WSxLnog+fHO6/yyujc0JT7JNMvqfEPjHSyuuCfvu9r
	YF/fqJE8u0qYHmlUCe+7ZZWjQVCYLoqwx5gCT7+FYDcLlwl8HOkmaRxrjEOUfXS8
	dnAoOSZDn7x+5JgnCWByaz/GyfnUhTBcrc53GAz93pIuazsQmjvF0GJykFxYt+fJ
	91+t/GCH/J5QfJmzZG0ecmvA7JS+tuS5bpVx1XOM900rxKwUsCy609Hi59VP1Xdj
	tU1y2EOwRMegNNZQ7p4rSr7/7vzmoU86PUrAIg0QZ56S/zuozsPw/RFqT56okOy4
	sUoCNJQS6Q==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rextg6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:58:24 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UDna1R022594;
	Tue, 30 Jun 2026 13:58:23 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2suk2hm9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jun 2026 13:58:23 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65UDwLTm66388268
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jun 2026 13:58:22 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 97CD758058;
	Tue, 30 Jun 2026 13:58:21 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C58258057;
	Tue, 30 Jun 2026 13:58:20 +0000 (GMT)
Received: from ltc.linux.ibm.com (unknown [9.5.196.140])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Jun 2026 13:58:20 +0000 (GMT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 30 Jun 2026 15:58:20 +0200
From: Harald Freudenberger <freude@linux.ibm.com>
To: Ilya Leoshkevich <iii@linux.ibm.com>
Cc: richard.henderson@linaro.org, david@kernel.org, thuth@redhat.com,
        berrange@redhat.com, qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
Subject: Re: [PATCH v8 07/18] target/s390x: Support AES CTR for cpacf kmctr
 instruction
Reply-To: freude@linux.ibm.com
Mail-Reply-To: freude@linux.ibm.com
In-Reply-To: <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-8-freude@linux.ibm.com>
 <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
Message-ID: <dd14bb109eaa9c599a1a94f9618775c0@linux.ibm.com>
X-Sender: freude@linux.ibm.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a43cb80 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=ZZgNOd5QJxuZDPaVO9IA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: w9e1MVYFfISiOexL7pT5rTYYHV3O8hi5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfXyXuNgwlfch56
 NbEyNaime2PCsj8hO69sxTrF8+ICfB5oQjwk2x7yjyPM+CZvrZpzE7OosD/jOBeLGm1pfxzRDe1
 FY69Jwdo090XxBIn43p7JLQPzaTDD6HVai/o0vQkb0t+etQ+uJnJ6eo6MpXNdPtTyuy6mhVVn8D
 PGaqsELV2spSjPgMJu4VsL0R7Q5CPy06h4Xj/wjY3PSH4aJgPlWAx1wNNumf+XeWMjjEtw+tJtF
 y6phXP96wvh5q7B2fqQ8Y69rLBFxc/kwsSYm61DqqOmP4pX2AWEOshAdD+PgAWBht+0gBwdYO1v
 PP3ALpF/GRllWaMA8WgBtdnKm7Cw3FMEnDml/Pcb0wyqZwGVSk64LIqIJR0IEjWpkoT8t9IoJkr
 2cDJAOq1brwhN1aHV+HsYMThuEXBD6z5qHFFXX0kpMO0lhVuXaIZnXOP9us2t4i7xPGbUDN0AN3
 NIT+BlD6yFIslPAh/wA==
X-Proofpoint-GUID: w9e1MVYFfISiOexL7pT5rTYYHV3O8hi5
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEyOSBTYWx0ZWRfXxE47MuHnp+/I
 No/B9sjXZgaaYpMVMEJlgAegoMe4Ld6qHRqa/WPS9odj4PU9WGoQZkNdCP6ka6Nl4oeCb0yhv1d
 tpUzzZCEAVzeroiSsn0XEfo8F3Hk3ko=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300129

On 2026-06-24 19:26, Ilya Leoshkevich wrote:
> On 6/24/26 10:10, Harald Freudenberger wrote:
>> Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
>> and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.
>> 
>> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
>> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
>> ---
>>   target/s390x/gen-features.c      |  3 ++
>>   target/s390x/tcg/cpacf.h         |  5 +++
>>   target/s390x/tcg/cpacf_aes.c     | 76 
>> ++++++++++++++++++++++++++++++++
>>   target/s390x/tcg/crypto_helper.c | 24 ++++++++++
>>   4 files changed, 108 insertions(+)
> 
> [...]
> 
>> --- a/target/s390x/tcg/cpacf_aes.c
>> +++ b/target/s390x/tcg/cpacf_aes.c
>> @@ -213,3 +213,79 @@ int cpacf_aes_cbc(CPUS390XState *env, const int 
>> mmu_idx, uintptr_t ra,
>>         return !len ? 0 : 3;
>>   }
>> +
>> +int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t 
>> ra,
>> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
>> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
>> +                  uint64_t *ctr_ptr_reg, uint32_t type,
>> +                  uint8_t fc, uint8_t mod)
>> +{
>> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
>> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
>> +    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
>> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
>> +    uint64_t addr, len = *src_len_reg, done = 0;
>> +    int i, keysize, addr_reg_size = 64;
>> +    uint8_t key[32];
>> +    AES_KEY exkey;
>> +
>> +    g_assert(type == S390_FEAT_TYPE_KMCTR);
>> +
>> +    switch (fc) {
>> +    case 0x12: /* CPACF_KMCTR_AES_128 */
>> +        keysize = 16;
>> +        break;
>> +    case 0x13: /* CPACF_KMCTR_AES_192 */
>> +        keysize = 24;
>> +        break;
>> +    case 0x14: /* CPACF_KMCTR_AES_256 */
>> +        keysize = 32;
>> +        break;
>> +    default:
>> +        g_assert_not_reached();
>> +    }
> 
> A general comment; I think I've seen this in previous patches as well.
> Would it make sense to properly define constants like
> CPACF_KMCTR_AES_128 and drop comments? Or, if the goal is easier
> cross-checking with POp, hardcode decimal numbers, since POp specifies
> them in decimal?

I'll add defines to cpacf.h and remove this hardcoded values here.

> 
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
>> +    /* fetch key from param block */
>> +    for (i = 0; i < keysize; i++) {
>> +        addr = wrap_address(env, param_addr + i);
>> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
>> +    }
>> +
>> +    /* expand key */
>> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
>> +
>> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
>> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) 
>> {
>> +        /* read in nonce/ctr => ctr */
>> +        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
>> +        /* encrypt ctr => buf */
>> +        AES_encrypt(ctr, buf, &exkey);
>> +        /* read in one block of input data => in */
>> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
>> +        /* xor input data with encrypted ctr => out */
>> +        aes_xor(in, buf, out);
>> +        /* write out the processed block */
>> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
>> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;
> 
> Same comment as in the previous patch.

Will change this wherever it appears in the series.

> 
> 
> Otherwise:
> 
> Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
> 
> [...]
