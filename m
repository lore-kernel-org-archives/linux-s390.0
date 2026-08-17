Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5E473ACA70
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 09:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786958271; cv=none; b=MVG3nvx0riPGryVpmtaN9q7cLwR2y8DvwneyulP0JxNVsnGY3NF9xxKJSnFA0BX8EqigHzCiVfLPwhpcbmflQ2IJj326+tjdXmfgHEsvRfVXMkUlMQG213hweHXgWSRXywjKN5XZaR6JmVUzmzLNcM8fDRbxtCwNjcU4cBW3u0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786958271; c=relaxed/simple;
	bh=1y5KSe36odRycO2Fm+zdd5ff6K+VQSM4zsPYX0Hm7EU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gThDB9tg44gaFZgMHkLHor7uOq4R1g9YqN7Kboh20hLQhWko6jq2PtKb+SkBAB22J31jCvCy9FyLwNlsg72bvJ79eBpjbcy+bakB8ErbRh5demY4Wu77pliqo8Hb6gW9gcLmJeDiOQbSnaJtCg+kuOTJ5sjFIms7B8l0QnQns4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Usye1Yss; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Usye1Yss"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLW4NY3637430;
	Mon, 17 Aug 2026 09:17:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=EjDS1l
	kzE6S/WfWJ85GdmcWr+iJ90WgA6tq4CZ1WjAw=; b=Usye1Yss50Oc+Kk42e4MHd
	kdItTRA5O5ABgV6vHpwsUA8aVRtTBLty8mlw0/+NuXbblzuJKT1yBSrB6po+zfXW
	/TspH/rUmSJymRM/AHWi9siZMsrqjw/iLA5yfwaFwTxeq6cFyaNWmXyygw8Mry+U
	OxB0bZWgi1snPuoMOAj9YE0Q/oUU9BbMnOz3DPLfksLu99laJmPFLRPCFR6amC0B
	+Poh8mbwnea/1lZLxSLOjyddGn1sfMTAgNXywKBESf3D7RfgB+Jfxs3IqUCAfXqA
	g8WdJyb1MwBnLZO9TbPKPWDSuvIHnuncP1Zk0i+lg73l+J3ywMAYCTv94uZXl2rQ
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhksfjy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:17:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H9BJ3O003662;
	Mon, 17 Aug 2026 09:17:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tvwfve-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 09:17:37 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H9HYSn48169362
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 09:17:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE5620049;
	Mon, 17 Aug 2026 09:17:33 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 64ABD20040;
	Mon, 17 Aug 2026 09:17:33 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 09:17:33 +0000 (GMT)
Message-ID: <e95ee364-3e48-44c4-8c7b-5d306f417c16@linux.ibm.com>
Date: Mon, 17 Aug 2026 11:17:33 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/19] target/s390x: Support AES ECB for cpacf km
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org, linux-s390@vger.kernel.org,
        dengler@linux.ibm.com, borntraeger@linux.ibm.com,
        fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260806151302.26846-1-freude@linux.ibm.com>
 <20260806151302.26846-8-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260806151302.26846-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfX6jWave4D3pPY
 zBW7jpS9objlkJWlCiihk5RK8G6V6AJh6tYaSkGaUtqGttJOQr8pPDFVgX2lMmFdjYo+FQ6zbVb
 aM+B3O9uy/J8JfOw5hArKBA1p6WA0ocaKRUgfL5sbyB5FUl/uroCw1zeHX7xpF0x6ON7H98RQaS
 Drr7FqS+w2GOyh2/5Rn1nR6wERC6gX3ZhsVEIs0iALO/F8NZGjXx973HZqbw54t2ggoV53oMOzz
 ZufdtEzzIcNuQcYOTAnQqw4xh2WdCudrGfPm62Iz5JhdbO9DDj4I9cybWEkFlnDilrKUXDle/VD
 3K0f9eK+HD6J+GI2uDBbHNCxvFbZ3cVUF9NhK9aABz8dV2SVEM5ynm35LX38IwhRFnElve8nwem
 TbXmm84zgcr3LMEZRBhnD7NlO+CCTS6/zoV8p8zpanMdlhjLqWdHUQY0ZcUd4RZrrBLBXf4AtxA
 crq1VtHNyknv+QJxlIw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA2NyBTYWx0ZWRfXx12/CiI7MZqP
 aw80M1dX54yAPwmwTipxnaZsnITsj09HwiLiYO/mUYk4+n5+2UQF+ug7l3fZFdLtssgMGcTPU04
 eqKTU7jP0A5I4Bil/WwXPsH7iM9Y6e4=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82d1b2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=66JXINVWjWM9bfsnM3kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: FlMzTpB0HA6FEADzy_U0jKf9lL428_Hq
X-Proofpoint-GUID: FlMzTpB0HA6FEADzy_U0jKf9lL428_Hq
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170067



On 8/6/26 17:12, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KM_AES_128, CPACF_KM_AES_192
> and CPACF_KM_AES_256 for the cpacf km instruction.
> 
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   6 ++
>   target/s390x/tcg/cpacf_aes.c     | 107 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 +++++++
>   target/s390x/tcg/meson.build     |   1 +
>   5 files changed, 141 insertions(+)
>   create mode 100644 target/s390x/tcg/cpacf_aes.c

[...]

> +int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                  uint32_t type, uint8_t fc, uint8_t mod)
> +{
> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE];
> +    uint64_t len = *src_len_reg, done = 0;
> +    int i, keysize, addr_reg_size = 64;
> +    uint8_t key[32];
> +    AES_KEY exkey;
> +
> +    g_assert(type == S390_FEAT_TYPE_KM);
> +    switch (fc) {
> +    case CPACF_KM_AES_128:
> +        keysize = 16;
> +        break;
> +    case CPACF_KM_AES_192:
> +        keysize = 24;
> +        break;
> +    case CPACF_KM_AES_256:
> +        keysize = 32;
> +        break;
> +    default:
> +        g_assert_not_reached();
> +    }
> +
> +    if (!(env->psw.mask & PSW_MASK_64)) {
> +        len = (uint32_t)len;
> +        addr_reg_size = (env->psw.mask & PSW_MASK_32) ? 32 : 24;
> +    }

Just noticed something, here and in all other patches. POp says:


In the 24-bit addressing mode, the contents of bit
positions 40-63 of general registers R1 and R2 consti-
tute the addresses of the first and second operands,
respectively, and the contents of bit positions 0-39
are ignored; bits 40-63 of the updated addresses
replace the corresponding bits in general registers R1
and R2, carries out of bit position 40 of the updated
address are ignored, and the contents of bit positions
32-39 of general registers R1 and R 2 are set to zeros.


Seems like we are not zeroing out bits 32-39?

> +
> +    /* length has to be properly aligned. */
> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* fetch key from param block */
> +    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);

Another weird nit, also here and everywhere else. POp says:


When the second-operand length is initially zero, the
following occurs. The parameter block, first, and sec-
ond operands are not accessed, and general regis-
ters R1, R2, and R2 + 1 are not changed.


I guess we need to bail early if length is 0.

[...]
