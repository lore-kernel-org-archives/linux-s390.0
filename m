Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3AEF3BFE4D
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 08:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786954303; cv=none; b=iS+w4zkJOAZ4k9pIMCNhYPZ8pd/9fRq5ZRmuHveYp5UXD5UqgIN++panBmBrf8n9zGzms5ajkeyAyrhz9827Kr5ygVdpWMDc76MXN+EId0n0+4SlFf0rDYghs2qN0u68pFk+C7TlAAbTym4yU87s3QokkZkR06vomRqcRX/yNKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786954303; c=relaxed/simple;
	bh=wSU1blaxdLk2Z4osnLPtjRvgmQ1a8//IL4/N0gjIaFg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZwMBwJDx9UQ1wU72ejHoxzX6chY/MI0GKp3XB9E3PAsWIUxI7vTPeiQ8reOP3/B4A4mH10YeRx6pXGO84jWG1FMZqDDMnsMk25KcAidzzYuOKoIjfAePnTtA0LJ4M89Cehiux/VMY/mtSCqIwVnj6aHXDuCY0r6+HLSztjDV1Ws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Tg8G2Y+R; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Tg8G2Y+R"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67GLXFUK3639647;
	Mon, 17 Aug 2026 08:11:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=kuwNDD
	th6j8+felH+XDP2fO6rCZBfVAZdDW/QyiXz6k=; b=Tg8G2Y+RKvayasTYpSo0PE
	rX+E54LUFE4/1l8HuGwFwiMZcToYBY9W4zG0C1SiXyNKPUd6QoHpuDxJZ1fC3UQH
	yRXiJ9I8cQ0W0DapgFT64U0HRVBuqIvDMbphWu/YmRPLuonI+HdhSm+8m2VxOIHr
	YqSG8bbR61Rd0gCyR2ZTj1EXinomAWxrv6qD9XQD/qpfIpa6491k7BLlihF7iW0Z
	yMbOEFEdgcQ8WPZ6ymQBBnMI5z1K2Wi53JPHnhfI53+U3sq5+Vn6+lvanlvJ7rZK
	RPm2H6lC518mwO7gpBbGW3LU+rnZGeoJOmL+bikwBYAZ2/4z1me9ipZQIBoqqXnA
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhks5b6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:11:33 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67H8BMtQ015616;
	Mon, 17 Aug 2026 08:11:33 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g33ejw2hj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 17 Aug 2026 08:11:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67H8BSlV40305014
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Aug 2026 08:11:28 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B76AA20043;
	Mon, 17 Aug 2026 08:11:28 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2C98320040;
	Mon, 17 Aug 2026 08:11:28 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.12.156])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 17 Aug 2026 08:11:28 +0000 (GMT)
Message-ID: <6621b094-e536-4f47-8b69-c9c0ad4132f8@linux.ibm.com>
Date: Mon, 17 Aug 2026 10:11:27 +0200
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX6trn85hmGeOf
 JKY3V2dhp5y9mv1mVOdXXJPPH8h7TSZBS7g434DE0dSxkfNiiDSb8OmNhEeKUaiAoF7VeRiHmbK
 rPo9PfHzfHBBud1+C0aRLxFwTo6VKJJ8lVxA3XcwcGXVDTnGjzQnRk9Znp9FzwhCCcDRXUlzwPz
 T9mDkVHqU32o0oYX/+8dyloNVcCZPo6EC1xJXeFFrA2C+AVSykkLWr9wM8g+H3JxPBTSxlxZzdl
 iC3NsAr2LAYp0vkEjQtkaTuHNKgwUurSJYhdC/ZqfIUisDnNKD2ZzAdHpznaysE2g8y/P8mAWdB
 Fyne4MHuaDblxIuH+bXg0TlyiM5YnAj2FAwWlTnwKvWNnmOFFoQO16ZCkX89q3HuXvxwFncZYOo
 lKVdJn953JCL6g02eaEke8ohJGpCxzuOK07fo3T6hrbsx9URc3QDd2cmLkhsn2l8xaaIKrWNGT5
 RVOCV2sADw2mHPHMLzg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDA1OSBTYWx0ZWRfX3cPm4/MPF4iq
 eToAPF4WrwXRTBcQz64S2189OhVUyHRp3yq+JHd46whWX/VDn8xVoGgDVi0Cg1DSzaOD0U5uzvG
 C6zbpqbWWv5+0tCSJBvxoraM/d487tg=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a82c235 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=ZLLi-ALZ7FbK3oftqOwA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: 19yIMRWkActMedI-Od12TrN0Mo2wDeyu
X-Proofpoint-GUID: 19yIMRWkActMedI-Od12TrN0Mo2wDeyu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_06,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608170059



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
> 

[...]

> +/*
> + * read exactly one AES block from guest memory into a local buffer
> + */
> +static inline void aes_read_block(CPUS390XState *env, const int mmu_idx,
> +                                  const uintptr_t ra, uint64_t guest_addr,
> +                                  uint8_t *buf)
> +{
> +    read_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
> +}
> +
> +/*
> + * write exactly one AES block from local buffer to guest memory
> + */
> +static void aes_write_block(CPUS390XState *env, const int mmu_idx,
> +                            const uintptr_t ra, uint64_t guest_addr,
> +                            uint8_t *buf)
> +{
> +    write_guest_wrap_u8(env, mmu_idx, ra, guest_addr, buf, AES_BLOCK_SIZE);
> +}

nit: I would these two functions, I don't think they deserve a wrapper.

> +
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
> +
> +    /* length has to be properly aligned. */
> +    if (!QEMU_IS_ALIGNED(len, AES_BLOCK_SIZE)) {
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    /* fetch key from param block */
> +    read_guest_wrap_u8(env, mmu_idx, ra, param_addr, key, keysize);
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
> +        aes_read_block(env, mmu_idx, ra, *src_ptr_reg + done, in);
> +        if (mod) {
> +            AES_decrypt(in, out, &exkey);
> +        } else {
> +            AES_encrypt(in, out, &exkey);
> +        }
> +        aes_write_block(env, mmu_idx, ra, *dst_ptr_reg + done, out);
> +        len -= AES_BLOCK_SIZE;
> +        done += AES_BLOCK_SIZE;
> +    }
> +
> +    *src_ptr_reg = deposit64(*src_ptr_reg, 0, addr_reg_size,
> +                             *src_ptr_reg + done);
> +    *dst_ptr_reg = deposit64(*dst_ptr_reg, 0, addr_reg_size,
> +                             *dst_ptr_reg + done);
> +    *src_len_reg -= done;
> +
> +    return !len ? 0 : 3;
> +}

The issue with writing memory, but not registers, on fault is still
there, but I think today's behavior is good enough for emulating real
sane code.


With our without the above addressed:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
