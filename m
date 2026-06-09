Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7388247A0BA;
	Tue,  9 Jun 2026 15:04:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781017486; cv=none; b=Kl7QgQnmerwTp4ovRRjMbpH8G2ugQHZa1aoNSDfSiG46agkzOiB/N1nKs7AUzAyS3A2mTh6ucnhbHFWrZG5ksORfl3G3QHT1JQXcoHjQawTLNN1JMC6lFKPFz9J2q2awz8mZMJ17/Ib5mU9BMYSFOJcv90Roqd5DDiUVvlDTEco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781017486; c=relaxed/simple;
	bh=Wf9HzAHPW1kAhEE845BgOu0vn79sj8SV2gPm7qjqsrk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LIkV3pPaTZaxktTxsRbPeAX/MHG7zvewZEVO8B7/VedhBIupzp0N7OtMhPEdyrbnNvLQU50zujrAL/e2G08ZoZb5Bpytb15bxUxLOqXfF7HGK0BKb5aUs0ECEhPkmId8dG1qN/EoplLk22tItOeolu+Nllk22iFXU4RiN9ewEHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ianyWXdz; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ianyWXdz"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6597FV6j3192673;
	Tue, 9 Jun 2026 15:04:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=V+M1Ps
	9aUGYeZLxbFFLnMPEZeMR8P5HTTgcAiH4gFyo=; b=ianyWXdzj1fuk2NLcyrhP8
	MmbYtvmQn+8FBZqi/aEc3XAc7n+TV/bxbiCN19txBUGIsFDxPcHT0dU+/rUXEWOD
	QqGMUtnCOLqpYvo0Vcrrv6PdWot3dEIwtwWsG6rXisRf/18IKI68Eg5a6/CV5Fqb
	wyuJeje5tpDGu2pNWyE0OFmih1P7VvYpGcFLi8tW7OyCfrWp1nRRS8Gn6nQYjNlk
	JEtwu+qShDe8VT7qjL+6hS39rQutRnS2mzAZF5B4PzY6kdnsRDAsn4ttQN1T4SJq
	2uZx0azaYLKEJDni5oZ5yycTg9z10u/Lz99a2t63GTFugswZMZYW0njAW+ErMpRw
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb95cs8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:04:19 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 659Ene4A004125;
	Tue, 9 Jun 2026 15:04:18 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emxvjtgbr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jun 2026 15:04:18 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 659F4BPD30999078
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Jun 2026 15:04:11 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 980462004B;
	Tue,  9 Jun 2026 15:04:11 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 988C720049;
	Tue,  9 Jun 2026 15:04:10 +0000 (GMT)
Received: from [9.87.134.239] (unknown [9.87.134.239])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  9 Jun 2026 15:04:10 +0000 (GMT)
Message-ID: <2d73aca5-1858-4a7a-a304-0971e4789dc1@linux.ibm.com>
Date: Tue, 9 Jun 2026 17:04:10 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 13/26] s390: Introduce read/write ARM sysreg
 instructions
To: Steffen Eiden <seiden@linux.ibm.com>, kvm@vger.kernel.org,
        kvmarm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter
 <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Marc Zyngier <maz@kernel.org>, Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
References: <20260529155601.2927240-1-seiden@linux.ibm.com>
 <20260529155601.2927240-14-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260529155601.2927240-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=N4UZ0W9B c=1 sm=1 tr=0 ts=6a282b73 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=72H-NXkf21sWWxSQJykA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: wzeM5kGmmWREGeMulp5sHgWYt7jUnYvp
X-Proofpoint-GUID: wzeM5kGmmWREGeMulp5sHgWYt7jUnYvp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA5MDEzOSBTYWx0ZWRfX+MUDH0cQDTPr
 IMexFdOgol2/C97VnFOuSaY640GvvhsfjwwQkSsg3s199xpExn8Rw5qPs+66YYyz4Lb/XOH3I6m
 g/G8VZ3bz47QneDHoPj5kctD64/0zmqRDQn02PVtC4bfeWqfan4LhIXjeSpPoxOrZRoqDcp6eXP
 lJVwZyCga45a5EPCTIrTqGdFPowmhMaCyLyPEmArkhoTj3bE7pV7My1AmunbYkGwtJCNc/yvWZU
 RzLituNV+UIPn6DC31bqhxiRLEUlsZLTCS1L3NJX//Jl62NRkM1uz3sBJXFjaF5+IIyA0+kBGmp
 LlI3HjcaxCnRnrkED1VAatURD7xOmxmxyPeoLN9PBch6vYwUhVmz2+wArKcPcDzsSyY9UiCrx3H
 Ycfk43eTGmfJOxbuXN4CJ46ycuZT4unHTCRAQ4VP4Hdp/M1n3b+1MoOIxGD4+nVl1fZ5CmZcdbX
 h/jFni+fZoqaZJEP/3Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-09_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 clxscore=1011 lowpriorityscore=0
 phishscore=0 impostorscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606090139

On 5/29/26 17:55, Steffen Eiden wrote:
> Introduce Extract Arm System Register and Store Arm System Register to
> enable s390 hosts to read and write system registers for arm64 guests.
> The new instructions use the new RIE_H instruction format. Add assembler
> macros to create instructions in RIE_H format manually. Add Support for
> disassembling the new instructions.
> 
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>   arch/s390/include/asm/sae-asm.h | 48 +++++++++++++++++++++++++++
>   arch/s390/include/asm/sae.h     | 58 +++++++++++++++++++++++++++++++++
>   arch/s390/kernel/dis.c          |  1 +
>   arch/s390/tools/opcodes.txt     |  2 ++
>   4 files changed, 109 insertions(+)
>   create mode 100644 arch/s390/include/asm/sae-asm.h
> 
> diff --git a/arch/s390/include/asm/sae-asm.h b/arch/s390/include/asm/sae-asm.h
> new file mode 100644
> index 000000000000..d81ed89eb4ed
> --- /dev/null
> +++ b/arch/s390/include/asm/sae-asm.h
> @@ -0,0 +1,48 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef __ASM_S390_SAE_ASM_H
> +#define __ASM_S390_SAE_ASM_H
> +
> +#ifdef __ASSEMBLER__
> +
> +.macro	GPR_NUM	opd gr
> +	\opd = 255
> +	.irp rs,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15
> +	.ifc \gr,%r\rs
> +		\opd = \rs
> +	.endif
> +	.endr
> +	.if \opd == 255
> +		\opd = \gr
> +	.endif
> +.endm
> +
> +/*
> + * RIE_H - RIE-h instruction format
> + *
> + * RIE-h format: <insn> R1, R3, I2, M4
> + *    +--------+----+----+----+-----------------+----+--------+
> + *    | OpCode | R1 |////| R3 |        I2       | M4 | Opcode |
> + *    +--------+----+----+----+-----------------+----+--------+
> + *    0        8    12   16   20                36   40      47
> + */
> +.macro RIE_H	opc, gr1, gr3, imm2, m4
> +	GPR_NUM	r1, \gr1
> +	GPR_NUM	r3, \gr3
> +	.byte	(\opc & 0xff00) >> 8
> +	.byte	r1 << 4
> +	.byte	(r3 << 4) | ((\imm2 & 0xf000) >> 12)
> +	.byte	((\imm2 & 0x0ff0) >> 4)
> +	.byte	((\imm2 & 0x000f) << 4) | (\m4 & 0xf)
> +	.byte	\opc & 0xff
> +.endm
> +
> +.macro SASR r1, r3, i2, m4
> +	RIE_H 0xed99, \r1, \r3, \i2, \m4,
> +.endm
> +
> +.macro EASR r1, r3, i2, m4
> +	RIE_H 0xed9b, \r1, \r3, \i2, \m4,
> +.endm
> +
> +#endif /* __ASSEMBLER__ */
> +#endif /* __ASM_S390_SAE_ASM_H */
> diff --git a/arch/s390/include/asm/sae.h b/arch/s390/include/asm/sae.h
> index fe010a1a7729..1d9a16b91b23 100644
> --- a/arch/s390/include/asm/sae.h
> +++ b/arch/s390/include/asm/sae.h
> @@ -4,6 +4,7 @@
>   
>   #include "linux/linkage.h"
>   #include <linux/types.h>
> +#include <asm/sae-asm.h>
>   
>   /* defined in arch/s390/kernel/entry.S */
>   asmlinkage int __sae64a(phys_addr_t sae_block_phys);
> @@ -12,6 +13,12 @@ asmlinkage int __sae64a(phys_addr_t sae_block_phys);
>   #include <linux/io.h>
>   #include <asm/kvm_host_arm64_types.h>
>   
> +asm(".include \"asm/sae-asm.h\"\n");
> +
> +#define _SAE_ASR_REG_SHIFT	5
> +#define SASR_FLAG_INITIALIZED  0x8
> +#define EASR_FLAG_SA           0x8

s/SA/SAVE_AREA/ or SAVEAREA

I think both might fit.

> +
>   /**
>    * __sae64a() - Start Arm Execution
>    */
> @@ -20,6 +27,57 @@ static inline void sae64a(struct kvm_sae_block *sae_block)
>   	__sae64a(virt_to_phys(sae_block));
>   }
>   
> +/**
> + * sasr() - Set Arm System Register
> + * @arm_reg: ARM system register identifier; compile-time constant
> + * @val: Value to set
> + * @save_area: Pointer to SAE save area
> + * @flags: Operation flags; compile-time constant
> + *
> + * Sets an ARM system register value.
> + */
> +static __always_inline void sasr(unsigned int arm_reg, u64 val,
> +				 struct kvm_sae_save_area *save_area,
> +				 u64 flags)

m4 is 4 bits in length, any reason why we use a u64 here?
Same for easr.

> +{
> +	struct kvm_sae_save_area *sdo = (void *)save_area->sdo;
> +	u16 reg = arm_reg >> _SAE_ASR_REG_SHIFT;
> +
> +	asm volatile (
> +		"	SASR	%[r1],%[r3],%[i2],%[m4]\n"
> +		: "+m" (*save_area), "+m" (*sdo)
> +		: [r1] "d" (val),
> +		  [r3] "a" (save_area), [i2] "K" (reg), [m4] "I" (flags)
> +	);
> +}
