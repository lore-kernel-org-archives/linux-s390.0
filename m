Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217EF3C2B9C
	for <linux-s390@vger.kernel.org>; Wed, 24 Jun 2026 14:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782311273; cv=none; b=pkWUAeJf8PUVc0QW6P29EzVm8imAWAa8Aemv0sPN3xWPJ0GpJiz7pFYC3GdVynelANsPoZ1FtMo0kpurudcOVHc24UwDcmhSlcdt0cLWsOoNciHLcNVCMkCE0o4C6+KoKjWRnhmS2Xzm0wpibOxY3GVVEM0z3aRB2zYQGCCCRf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782311273; c=relaxed/simple;
	bh=2MZWedhucDPEpVJeNFKaYjob84tEqmXZoUHJjZSfPbw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pmVMNecr0q9diTB0rzsWXqhwJUJkNyN3GriUTgWvrVaa5Peoo86mRhb3JMyO8Bs62wzUtVdtrtlfnpjhOPrLc28SGTTL5Nub18H/pZinjxHhX0vStiHKgslnl6zgdDG1jlACCj27M8b50vWIxts3F/WyJSYBGiBCPj+aH4oQ3r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ilZekPwo; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ilZekPwo"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65OAmDmA866138;
	Wed, 24 Jun 2026 14:27:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=hJt4dK
	njCWJ6d2W3W4/ZOpj8lSA9JGZY64FyiyDsSwY=; b=ilZekPwoAz04q4y58cQJjr
	Ebn+Pr+Ndfy2HtAgzflyindXFiVcfeG6jm4fraX0yolq8N4Vflh3ie5hiH+vnnr8
	uSyme/rjHeFb4gG2HKQcdXqtMI0+wnEhUmBGt3kg9ntmwjsbq/xWAVMjE2xU5gZn
	RiADmgtHpSVJ7iepTgGxMu8mBGydQd51QrmygBAUvwNvIDavOum6fBafQbPxYVLd
	2uO6OnCA6N5pUQNha9bLp0pKFtN4IZz1g8rR65SkF8qBjb5Vo19c0GAdH3Cpj4dA
	Jla32hcfwO4LjI5wc2jiUWgRHQV56wAa0/6eaz2qhKmI6E426rYDyq9ZQ1ZFylrg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4ewjhqvkc7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:27:42 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65OEJgNE025213;
	Wed, 24 Jun 2026 14:27:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ex66k92c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jun 2026 14:27:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65OERbfs49349078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Jun 2026 14:27:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 548F620043;
	Wed, 24 Jun 2026 14:27:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EB85E20040;
	Wed, 24 Jun 2026 14:27:36 +0000 (GMT)
Received: from [0.0.0.0] (unknown [9.111.35.104])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 24 Jun 2026 14:27:36 +0000 (GMT)
Message-ID: <435a9a05-3779-44b6-8aae-3bbce5a2a7b6@linux.ibm.com>
Date: Wed, 24 Jun 2026 16:27:36 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 02/18] target/s390x: Rework s390 cpacf implementations
To: Harald Freudenberger <freude@linux.ibm.com>, richard.henderson@linaro.org,
        david@kernel.org, thuth@redhat.com, berrange@redhat.com
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
        linux390-list@tuxmaker.boeblingen.de.ibm.com,
        linux-s390@vger.kernel.org, dengler@linux.ibm.com,
        borntraeger@linux.ibm.com, fcallies@linux.ibm.com, cohuck@redhat.com
References: <20260624081029.23815-1-freude@linux.ibm.com>
 <20260624081029.23815-3-freude@linux.ibm.com>
Content-Language: en-US
From: Ilya Leoshkevich <iii@linux.ibm.com>
In-Reply-To: <20260624081029.23815-3-freude@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=I4VVgtgg c=1 sm=1 tr=0 ts=6a3be95f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=B6hoElRAeX7WwpK8Q9wA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX4dx62i+SlVAL
 TS/eOP/VBowuQtH3NMCcsvUxACPlorTkZehEauTkLbQ+flBTzzOslcRqT/9nyCqSTs0c4U7E6lR
 dOmh8jconfp8YhxAiiIrNFHHv2xuH3yansMGdLb5wnaW2tTUohQjSG6FDf4D3z1QsukKZBzNtgY
 qZQHYQ0Yc+12t3iUoGO3BRBmxgRSzPGCbZzLpld+XVraSc19R8apkgFtRbXql9Tb6l+MIyMakLt
 J+6XT7TynKYbysdfKxxdhjtrFONcTM2GE7q67GJhfn90KknDXmY/fyJIxbCcI2Vl8djOMZwPdtd
 JKaaF6gW74iapS0hfAiP8OXoW6sBpK6Xl4XSDVykmBaewaJzs/YdXs1zy6Z35qRarKOkmis2wm0
 LUPNcvAj5/RinBCebJLM5ZYuxhDJHw==
X-Proofpoint-GUID: pGXIhcMUK4hFTRXtLYrVo9WcXDdTCNVm
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI0MDExOSBTYWx0ZWRfX0k00TMhzr1XS
 mGibupaDZkbsgFNEsWM9qcGFKzDcxY+ZAhLkAE+7R69Ghc+Y5oTz2lj5QOetzR0BbL4W+W4RD/B
 3oaF+0auMFQlBnJYfiTFa43osGe/SrA=
X-Proofpoint-ORIG-GUID: pGXIhcMUK4hFTRXtLYrVo9WcXDdTCNVm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-24_03,2026-06-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 spamscore=0 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606240119



On 6/24/26 10:09, Harald Freudenberger wrote:
> Fix missing parts for MSA 9 kdsa and rework the cpacf
> handling code so that further extensions can be made in
> a clean and structured way.
> 
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>
> Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
> Tested-by: Holger Dengler <dengler@linux.ibm.com>
> ---
>   target/s390x/tcg/crypto_helper.c | 89 +++++++++++++++++++++++++++-----
>   target/s390x/tcg/insn-data.h.inc |  1 +
>   target/s390x/tcg/translate.c     |  2 +
>   3 files changed, 79 insertions(+), 13 deletions(-)
> 
> diff --git a/target/s390x/tcg/crypto_helper.c b/target/s390x/tcg/crypto_helper.c
> index 29ad2aff43..f5189ce1c5 100644
> --- a/target/s390x/tcg/crypto_helper.c
> +++ b/target/s390x/tcg/crypto_helper.c
> @@ -272,6 +272,57 @@ static void fill_buf_random(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
>       }
>   }
>   
> +static int cpacf_kimd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x03: /* CPACF_KIMD_SHA_512 */
> +        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
> +                          &env->regs[r2 + 1], S390_FEAT_TYPE_KIMD);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}
> +
> +static int cpacf_klmd(CPUS390XState *env, const int mmu_idx, const uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x03: /* CPACF_KLMD_SHA_512 */
> +        rc = cpacf_sha512(env, mmu_idx, ra, env->regs[1], &env->regs[r2],
> +                          &env->regs[r2 + 1], S390_FEAT_TYPE_KLMD);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}
> +
> +static int cpacf_ppno(CPUS390XState *env, const int mmu_idx, uintptr_t ra,
> +                      uint32_t r1, uint32_t r2, uint32_t r3, uint8_t fc)
> +{
> +    int rc = 0;
> +
> +    switch (fc) {
> +    case 0x72: /* CPACF_PRNO_TRNG */
> +        fill_buf_random(env, mmu_idx, ra, &env->regs[r1], &env->regs[r1 + 1]);
> +        fill_buf_random(env, mmu_idx, ra, &env->regs[r2], &env->regs[r2 + 1]);
> +        break;
> +    default:
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +    }
> +
> +    return rc;
> +}

I wonder if it would make sense to create separate op_kimd(), etc,
opcode handlers and make these new functions separate helpers.
Multiplexing in op_msa() and then de-multiplexing here looks like
busy work to me. That's of course out of scope of this series, so:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

[...]
