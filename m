Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1C0E378803
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 17:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782321753; cv=none; b=IK2z9C/T8tr0pxg7oP8vl+aW8Uiz6bRalQk3WHgI5aFcDli5kWDQpiT4Igp8tGIxvsVBnxWR3Ow4lunXCJx+2Xvx4WskQ+aaaDEyBCdqK5y1GmgZkRQum10m4f+wpCH4SQbZeRb2MX3GzIv4qwqaNjVpu2RLVyYYHlSJyKndip8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782321753; c=relaxed/simple;
	bh=Qpa+sfQGXZXGOq8SB0Ql9bto4Djm/8kixBSX4JpKi/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A4Uks2E7zqgWcSumdtsyDPyBEzKIgX1ofhxK2FTU9ZgUvbunI1EXzcVxr8TmsGe6Uo6//GrwbJ5iL5Y6q5o3WzrQ9sqAJolRXWlIIAizIzXnLcuI0TuQzyDZnIPKCXEzsUe5i7KfAww7adXaf5ptbI6viCvOyd+2lZ6mQn9yeg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fpOBHLzT; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fpOBHLzT"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OEmFWe1337097;
	Wed, 24 Jun 2026 17:22:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=FWMw0r
	VmmI4iFHozMe9Bot7FhA+l27OSNqndRuKjO4s=; b=fpOBHLzTB2/44XbJ2zO4lt
	0iw8DS3/As0kwUH0XM0XtgMVTN0AWRrg+veLCzcV++1GCmPtN90M8nej2PXcAl6x
	E+Y7m4b9SBM8AcfIpbL31LihLMzTT3kGnoYgn93rUqyyzTt2vIok7E9YCy+Sr1sM
	Aie0tMnLkz3L9dGDXVJUC3RBSMKwfsIX4iXOvC0dsDA5uFVaGY0x1jya95XpPZ2+
	kjkljblLERBUCU+OWZrMmXCCO0Py1QWPkRoq79QOU1KC3FVqCIGnyc5CA/ijdS+2
	efp9bDfrScSti2gi2/Oo1q8lcQ9JiNVxm/5T546sDelsjGbOThpxn+hUESA7S77Q
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjc3nmjd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:22:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OHJlap003901;
	Wed, 24 Jun 2026 17:22:21 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex5jwhxgr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 17:22:21 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OHMHmA49938848
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 17:22:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 689992004F;
	Wed, 24 Jun 2026 17:22:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C21F720043;
	Wed, 24 Jun 2026 17:22:16 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.87.142.129])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 17:22:16 +0000 (GMT)
Message-ID: <193565c3-6215-4dd7-bb99-4410ed48196f@linux.ibm.com>
Date: Wed, 24 Jun 2026 19:22:16 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 06/18] target/s390x: Support AES CBC for cpacf kmc
 instruction
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-7-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-7-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=X4Ni7mTe c=1 sm=1 tr=0 ts=6a3c124e cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=SBuLggzHEtyKXn15os8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX5Am+l5UQydod
 50TCwTlg34qcd1WIXkJIZS9fJDziuFcKg42EzTd3S/yTADFCXpW7wWH376hvjRVL6PdEMfuMDUO
 oSSxl2mWDDGsKr9ssmsFIyy1U0JsHyc=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDE0NCBTYWx0ZWRfX2LGAUftCMS6n
 vrPnysKK6VEDUbLQ2D43L4XPolG8r1M/MMyZKVH4FFGkxfyqmuRS/YudEnFOW25MTM1QoPdIgcq
 GnK+xU9eukq1GgfzoH72J7ULzL0NRnGV6grbNvLxMIgRYMsoJdQy1cHMNNxGAKk9KmlAqyRNX88
 54DhebGaPy8Z3kpO4jSKmtr9DSBhgxmvqrsJnOw1G0SPYNcFJbuNFv6dQ6q1l6jmlRRI8iXY3e6
 9zXutl+VbqQWIoFyPmA1tLHUD1xHrfRrdJQGmP1GhQvon/kGDMjBfSsx6auz1Ghq6zIP3tGL5lz
 SpacbdTrOp3ihZkUmUOQch6D9D4DaLUZFcnc5G7zZxR4LJyFbEtC9xdyLvoMF9nWPpfz2Ki1XPQ
 WAC/307KuPFL+5336WpXK2J5kQNrAA==
X-Proofpoint-ORIG-GUID: VLNerZUfTdjFjjHzaAIoq6mQjuCpBBlw
X-Proofpoint-GUID: VLNerZUfTdjFjjHzaAIoq6mQjuCpBBlw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc=
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.22.0-2606150000 definitions=main-2606240144



On 6/24/26 10:10, Harald Freudenberger wrote:
> Support the subfunctions CPACF_KMC_AES_128, CPACF_KMC_AES_192
> and CPACF_KMC_AES_256 for the cpacf kmc instruction.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> Reviewed-by: Finn Callies <fcallies@linux.ibm.com>
> ---
>   target/s390x/gen-features.c      |   3 +
>   target/s390x/tcg/cpacf.h         |   4 ++
>   target/s390x/tcg/cpacf_aes.c     | 102 +++++++++++++++++++++++++++++++
>   target/s390x/tcg/crypto_helper.c |  24 ++++++++
>   4 files changed, 133 insertions(+)

[...]

> diff --git a/target/s390x/tcg/cpacf_aes.c b/target/s390x/tcg/cpacf_aes.c
> index ba836f1473..6412cc187d 100644
> --- a/target/s390x/tcg/cpacf_aes.c
> +++ b/target/s390x/tcg/cpacf_aes.c
> @@ -111,3 +111,105 @@ int cpacf_aes_ecb(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>   
>       return !len ? 0 : 3;
>   }
> +
> +static void aes_xor(const uint8_t *src1, const uint8_t *src2, uint8_t *dst)
> +{
> +    for (int i = 0; i < AES_BLOCK_SIZE; i++) {
> +        dst[i] = src1[i] ^ src2[i];
> +    }
> +}
> +
> +int cpacf_aes_cbc(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                  uint64_t param_addr, uint64_t *dst_ptr_reg,
> +                  uint64_t *src_ptr_reg, uint64_t *src_len_reg,
> +                  uint32_t type, uint8_t fc, uint8_t mod)
> +{
> +    enum { MAX_BLOCKS_PER_RUN = 8192 / AES_BLOCK_SIZE };
> +    uint8_t in[AES_BLOCK_SIZE], out[AES_BLOCK_SIZE], buf[AES_BLOCK_SIZE];
> +    const MemOpIdx oi = make_memop_idx(MO_8, mmu_idx);
> +    uint64_t addr, len = *src_len_reg, done = 0;
> +    int i, keysize, addr_reg_size = 64;
> +    uint8_t key[32], iv[AES_BLOCK_SIZE];
> +    AES_KEY exkey;
> +
> +    g_assert(type == S390_FEAT_TYPE_KMC);
> +
> +    switch (fc) {
> +    case 0x12: /* CPACF_KMC_AES_128 */
> +        keysize = 16;
> +        break;
> +    case 0x13: /* CPACF_KMC_AES_192 */
> +        keysize = 24;
> +        break;
> +    case 0x14: /* CPACF_KMC_AES_256 */
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
> +
> +    /* length has to be properly aligned. */
> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* fetch iv from param block */
> +    for (i = 0; i < AES_BLOCK_SIZE; i++) {
> +        addr = wrap_address(env, param_addr + i);
> +        iv[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }
> +
> +    /* fetch key from param block */
> +    for (i = 0; i < keysize; i++) {
> +        addr = wrap_address(env, param_addr + AES_BLOCK_SIZE + i);
> +        key[i] = cpu_ldb_mmu(env, addr, oi, ra);
> +    }

Another couple of candidates for copy_from_guest_wrap().

> +
> +    /* expand key */
> +    if (mod) {
> +        AES_set_decrypt_key(key, keysize * 8, &exkey);
> +    } else {
> +        AES_set_encrypt_key(key, keysize * 8, &exkey);
> +    }
> +
> +    /* process up to MAX_BLOCKS_PER_RUN aes blocks */
> +    for (i = 0; i < MAX_BLOCKS_PER_RUN && len >= AES_BLOCK_SIZE; i++) {
> +        aes_read_block(env, mmu_idx, *src_ptr_reg + done, in, ra);
> +        if (mod) {
> +            /* decrypt in => buf */
> +            AES_decrypt(in, buf, &exkey);
> +            /* buf xor iv => out */
> +            aes_xor(buf, iv, out);
> +            /* prep iv for next round */
> +            memcpy(iv, in, AES_BLOCK_SIZE);
> +        } else {
> +            /* in xor iv => buf */
> +            aes_xor(in, iv, buf);
> +            /* encrypt buf => out */
> +            AES_encrypt(buf, out, &exkey);
> +            /* prep iv for next round */
> +            memcpy(iv, out, AES_BLOCK_SIZE);
> +        }
> +        aes_write_block(env, mmu_idx, *dst_ptr_reg + done, out, ra);
> +        len -= AES_BLOCK_SIZE, done += AES_BLOCK_SIZE;

I think

     len -= AES_BLOCK_SIZE;
     done += AES_BLOCK_SIZE;

would be clearer.


Other than that:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]
