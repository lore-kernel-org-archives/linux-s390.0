Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E3B30FF31
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 17:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782322031; cv=none; b=rkQalN2/2PdHRhSQh8X6IyQk0jNXKrLxMyu9E8SY5nV2VD4MKjr++FKO9fw+RZvcu3mi0w0MqmAmzqdV5mBpkCwPSfY+902v9maGqmsOOmOFupQ16W4KDH4fTQBuDr5DXVHmQJmJkCBl1QntXv854LRXxiC3134Z03oBfZK6lTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782322031; c=relaxed/simple;
	bh=MUmQJAnq7pH0S7gplGQYngeLyvqmAgQFnk68/5G5YQw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GhcQjsRIKF4WMQkt9wm4DrRK3W1YXosgdH+qvp13NUwbNsPtcIycvRtMER3F7mo2AV9vn2uhBe6mRkeLuywRbo6N8ukc+/T5/2pvkbwVv2XIyRSYe5iHiv5pF1QCUg914j2D+NDfJh2kCuKPNkljEKkdphx4ZEfZc1PRI0Fvu74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lj9KmkEk; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lj9KmkEk"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmEG71487931;
	Wed, 24 Jun 2026 17:26:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2Fpizy
	Mf1Bl7FsV5n5BXohwSkKK5qFUTSwhEoah63LQ=; b=lj9KmkEk5rEY6NN98M1nNy
	hdZyYPpcimiPFjneeY6OdYk94WouefmNq17VQG2h5NcesvLG1x7ud33odQDUJDOj
	p9G0rWzntJMcJCviSr124B2H67GQiIp3mJ3fBR2aP9x68pGBLJMaQRXgrZ2xrrLB
	ZxYZSfdXsk2j0KpP9LQiuGqtbvOdTmkSyE44XBYeZIQQ+WRY6JQg0pt3iFJiRbrN
	CivGE4SfXa3KVNtsfua7buVuKt8wiDOb32zr+P6NKqf/MGYQBFrqQWYAPuxyYWzi
	hffvq2j4xPz4/yU0knii0S4Z3tfewyp/LA6FPxBIktev6NEZr7vjGvyJy1EbjOcA
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqwfg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:26:58 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OHJngc016476;
	Wed, 24 Jun 2026 17:26:57 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4ex7vyshn3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:26:57 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OHQrtH40305004
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 17:26:53 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6B48A20040;
	Wed, 24 Jun 2026 17:26:53 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A38672004B;
	Wed, 24 Jun 2026 17:26:52 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.129])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 17:26:52 +0000 (GMT)
Message-ID: <a948d24d-f9cb-4d67-bf46-007d6de3c523@linux.ibm.com>
Date: Wed, 24 Jun 2026 19:26:52 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 07/18] target/s390x: Support AES CTR for cpacf kmctr
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-8-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3c1362 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=5zCL6iFVHV85iPuFRzkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX0xn2SgGNMyk3
 avLO5G7vr7rZQv5fntOawX+kbRW2EH+gqJdHhpMnvBSTL1angJ6wH4jeoKQDZ9SvjGUzcSKD/Ba
 ajEjSyvu3/q2VdcHhWdIjaUDsh8tVHN4YMspHH4eBKWhoufYkEu97Mv/UYcwS/LbGDscx5XJy4m
 DM3BpPBfSOPopW1gEjiefphWV58l+eUC+Oq41ZwTdjRU20EUag39VdFSZBdowlcX6s5Vky9VAi/
 Tppe7hgcp9fvy5j0++I5yDSXiI9i8H40oqd1Dpji7WKooaA9uZWjFq5XyEpz28ULEJHacyd77T+
 UJItBSqlAUD8JKeyUrITy+jpCwoqlR/5LPYNjh8fjnQzkBPCTV7zhFqwbU9ve6q6BYy5Jyfj9sv
 +8RDMC/ficfy32sOryQUKYoUOjsTEQ==
X-Proofpoint-GUID: GqdNOnlwYYPyLWmZTXsay8pX230pNDlG
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX48aAICWViwc+
 wa8IzzOgfkN4C1jwkw5eB9azA0feAQsd2kfIwc81OCgAtQOsczmd2o47zjzO3Fx2Zdw3gfPBY+G
 J2FSgSeFt627JKUcHWaSQ4XbgikI1ws=
X-Proofpoint-ORIG-GUID: GqdNOnlwYYPyLWmZTXsay8pX230pNDlG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240144



On 6/24/26 10:10, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMCTR_AES_128, CPACF_KMCTR_AES_192
> and CPACF_KMCTR_AES_256 for the cpacf kmctr instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |  3 ++
>   target/s390x/tcg/cpacf.h         |  5 +++
>   target/s390x/tcg/cpacf_aes.c     | 76 ++++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c | 24 ++++++++++
>   4 files changed, 108 insertions(+)

[...]

> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -213,3 +213,79 @@ int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +int cpacf_aes_ctr(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                  uint64_t *ctr_ptr_reg, uint32_t type,
> +                  uint8_t fc, uint8_t mod)
> +{
> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +    uint8_t ctr[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> +    uint64_t addr, len = *src_len_reg, done = 0;
> +    int i, keysize, addr_reg_size = 64;
> +    uint8_t key[32];
> +    AES_KEY exkey;
> +
> +    g_assert(type == S390_FEAT_TYPE_KMCTR);
> +
> +    switch (fc) {
> +    case 0x12: /* CPACF_KMCTR_AES_128 */
> +        keysize = 16;
> +        break;
> +    case 0x13: /* CPACF_KMCTR_AES_192 */
> +        keysize = 24;
> +        break;
> +    case 0x14: /* CPACF_KMCTR_AES_256 */
> +        keysize = 32;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }

A general comment; I think I've seen this in previous patches as well.
Would it make sense to properly define constants like
CPACF_KMCTR_AES_128 and drop comments? Or, if the goal is easier
cross-checking with POp, hardcode decimal numbers, since POp specifies
them in decimal?

> +
> +    if (!(env->psw.mask & PSW_MASK_64)) {
> +        len = (uint32_t)len;
> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
> +    }
> +
> +    /* length has to be properly aligned. */
> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* fetch key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +
> +    /* expand key */
> +    AES_set_encrypt_key(key, keysize * 8, &exkey);
> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        /* read in nonce/ctr => ctr */
> +        aes_read_block(env, mmu_idx, *ctr_ptr_reg + done, ctr, ra);
> +        /* encrypt ctr => buf */
> +        AES_encrypt(ctr, buf, &exkey);
> +        /* read in one block of input data => in */
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
> +        /* xor input data with encrypted ctr => out */
> +        aes_xor(in, buf, out);
> +        /* write out the processed block */
> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;

Same comment as in the previous patch.


Otherwise:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]

