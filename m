Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE663367F31;
	Mon,  6 Jul 2026 11:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783336653; cv=none; b=Hl7P4LBt6oMMUGnXejuLw5vqw+A004MXYiXkpsjcdf91aAlo/qBq1naS9J4Ed4TM4m/oDEuix97BdczGkZ9z+J4BSWEjoPr2pzUyvuLawqanHHa7EjCQJEKuqAk246o1MplRpmXUmEVfqthLlCphyS/5q2v0w6ja9pFOhujWAWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783336653; c=relaxed/simple;
	bh=q4xzhbvHky63KgGYTrvsex25Fh+Bal0Wm+f67FAD4W0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M/j9h52TEbuGnoSjpZjSSXwH9P+gf920zItI2TehdB/heLC0Y9xDkL1R0BrAslpqhfsIP/BqqAwjvMUZDKw49USkyvi0OBA3TwOsbPhfQxhFy4PV/GN0WG3Hc+g3PZuO0qDgQvOQwcWtPfJ/otXBfNQeqQ/1VoEuJg59UF9TZSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WLRDPsB7; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WLRDPsB7"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 6669IR2B4015302;
	Mon, 6 Jul 2026 11:17:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=ZJTBwG
	jSNZDKHvbuJOa1scVEvsZc8DeSukn7IhD19hA=; b=WLRDPsB7kST9YOfgb4OG/o
	/idedUb65mvL/dYnwo6NeMtsL2tLXklY1qz6UtmEO+JojrFszgejDDVSdLREM1md
	lx26nlSelJaVcNyeUzdro30GLR+DQDgGuNGTzYBCG3mfo4Vdbg6eDWjhhBZkX7bY
	Z17GENWETp3naR6Ex0X9F0xD+dQJpOLBjbAUtiGM1o71QOLPE0DOYv4dQhAkhfsM
	AIuuPfmj4ZINmJcIQD3pODFCl+dO6zzw0LxwZhBzsO/kI8rUbKS+qDBWhf9+P2Xm
	KVVLRByjfKmWlKNeCR5IXejV13PSLDSMdMQ+AwMu5eKVyPYzCWNnZ8njW2VZPmWg
	==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6suqh09d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:17:12 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666AnZoZ011804;
	Mon, 6 Jul 2026 11:17:11 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7f6xvygu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 11:17:11 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666BH4XH47382910
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 11:17:04 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 043672004B;
	Mon,  6 Jul 2026 11:17:04 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 44C3E20043;
	Mon,  6 Jul 2026 11:17:03 +0000 (GMT)
Received: from [9.87.152.232] (unknown [9.87.152.232])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 11:17:03 +0000 (GMT)
Message-ID: <8239c9ba-154c-4e2d-b2fc-700ba12eb585@linux.ibm.com>
Date: Mon, 6 Jul 2026 13:17:02 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 19/27] s390: Introduce Start Arm Execution instruction
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
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-20-seiden@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260706085229.979525-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX+xIhLAcxsHLZ
 f9Rbt2L9sMzlOlmiuaBV/trvtk8Anz1boO8La5Yq1tJHC7H3MZNacc8bOMQw6jP++eds89zWf1c
 MEgJALXgnggU4S1OJ4pEZm3L8/U61oY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDEwOSBTYWx0ZWRfX9ItXXrPx0Eho
 MmApuRdym0zu+BWxo5RNN6GkY8w39oZAbnexTdQm5nGWemvBHbHTn5ImhU2uxdbIc640QO5JJ7S
 ORDTZyxBetxbGjI5rDL6iT/JkykMuxpAUtzyMnd7pNyRzmFGoqDM5vJRsSsndrF7X5NLKBKiF2n
 9ULgONVX3kTRr7wZiasCa/Kj7lBgGRD5nW3HJ3wS9sk+nCETJqKjTUjcKtVn/3QfZXX8f7dNQXD
 tr3EIOr6166Qmd7FaYHAaPvo5kCZsgHHn/h1Sh/9EExEw8O2mn1dZBpAs+C+UUM3C6MbneotCpS
 Jirktf+vB3gWVsMQfPho5GS5qVJGDnzM183J3nrsSOJFbdLH0CcnnPZ6odYjkHAcCx618puJT56
 jDTuaCF8qHvJmkcrAS53tFsaf+Wcq9ul8sq7GFuiioaqIfaNg2+GetOhOi+oidUSzpRLpzoP+hC
 KlkAjUufKmO3Yyhl/Pg==
X-Proofpoint-GUID: osnHUPaW3GcYLybZTEv5viafEL5-tZh3
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a4b8eb8 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=yZFHy3xYVWHLONAxsiAA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: osnHUPaW3GcYLybZTEv5viafEL5-tZh3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060109

On 7/6/26 10:52, Steffen Eiden wrote:
> The Start Arm Execution (SAE) instruction is the centerpiece for
> executing arm64 (KVM) guests on s390. Its purpose is, similar to SIE, to
> enable accelerated execution of arm64 virtual machines. SAE expects the
> physical address of a control block as the only argument.
> 
> The host is responsible to save & restore
>   - GPRs 0-13
>   - access register 0-15
>   - breaking event register (BEAR)
>   - vector/floating point registers
> between SAE executions to guarantee host consistency.
> 
> GPRs and BEAR are save and restores in the asm functions. The other
> register are handled in within C code. Access registers are handled in a
> later patch and SVEs will be handled when they are introduced in a
> future series. Most arm64 registers are handled by a satellite block
> called save_area. Some registers, frequently used by hypervisors, are
> placed into the SAE control block itself.
> 
> Enlighten asm/kvm_host_types.h for the new header variant. The new
> header is chosen instead of asm/kvm_host_s390_types.h if KVM_S390_ARM64
> is defined.
> 

[...]

> +	u64	gpr[31];		/* 0x0300  */
> +	u64	_03f8;			/* 0x03f8  */
> +
> +	union {
> +		u64	icptd[8];		/* 0x0400 */
> +		/* validity-interception reason; icptr 0x01 */
> +#define SAE_VIR_UNKNOWN		0x00
> +#define SAE_VIR_UNSUPP_FORMAT	0x01
> +#define SAE_VIR_MSO_BOUNDS	0x02
> +#define SAE_VIR_MSLA		0x03
> +#define SAE_VIR_MGPAS		0x04
> +#define SAE_VIR_INVAL_SYSREG	0x05
> +#define SAE_VIR_HOST_CONTROL	0x06
> +#define SAE_VIR_SCA		0x07
> +#define SAE_VIR_MSO_ALIGN	0x08
> +#define SAE_VIR_HLC		0x09
> +#define SAE_VIR_IRPTC		0x0a

Will these ever be used for something?



> +		u16 vir;			/* 0x0400 */
> +		/* host access interception details; icptr 0x02 */
> +		struct {
> +			u64		esr_elz;	/* 0x0400 */
> +			u8		_0408[6];	/* 0x0408 */
> +			u16		pic;		/* 0x040e */
> +			union teid	teid;		/* 0x0410 */
> +			gva_t		far_elz;	/* 0x0418 */
> +			gva_t		vaddr;		/* 0x0420 */
> +			u64		suppl;		/* 0x0428 */
> +			u8		gltl;		/* 0x0430 */
> +			u8		_0431[7];	/* 0x0431 */
> +			u64		_0438;		/* 0x0438 */
> +		} hai;
> +		/* exception-interception details; icptr 0x03 */
> +		struct {
> +			u64	esr_elz;		/* 0x0400 */
> +			u64	_0408[2];		/* 0x0408 */
> +			gva_t	far_elz;		/* 0x0418 */
> +		} trap;
> +		/* timer-interception reason; icptr 0x04 */
> +#define SAE_IR_TIMER_ID_VIRT		BIT(6)
> +#define SAE_IR_TIMER_ID_PHYS		BIT(7)
> +		u8	tir;			/* 0x0400 */
> +	};
> +	u64	_0440[376];			/* 0x0440 */
> +} __packed __aligned(PAGE_SIZE);
> +static_assert(sizeof(struct kvm_sae_block) == PAGE_SIZE);
> +

[...]

> +#if IS_ENABLED(CONFIG_KVM_ARM64)
> +/*
> + * __sae64a calling convention:
> + * %r2 pointer to sae control block physical address
> + */
> +SYM_FUNC_START(__sae64a)
> +	stmg	%r6,%r14,__SF_GPRS(%r15)	# store kernel registers
> +	STBEAR	__SF_SAE_BEAR(%r15)		# save breaking event address register
> +	.insn	rre,0xb9a50000,%r2,0		# Start Arm Execution
> +# Let the next instruction be NOP to avoid triggering a machine check
> +# and handling it in a guest as result of the instruction execution.

@Christian:
I have the feeling things got lost in translation when this comment was 
written.
How would we trigger a MCHECK by having an instruction after SIE/SAE?
AFAIU this allows us to have a label which we can check in the mcheck 
handler to decide who triggered the mcheck.

Without the label the comment and NOP are useless as far as I can see.
So we need to decide if this still applies and then either remove it or 
add sae handling to mcck_int_handler and maybe other mcheck functions.

> +	nopr	7
> +	LBEAR	__SF_SAE_BEAR(%r15)		# restore breaking event address register
> +	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> +	xgr	%r0,%r0				# clear guest registers to
> +	xgr	%r1,%r1				# prevent speculative use
> +	xgr	%r3,%r3
> +	xgr	%r2,%r2
> +	xgr	%r4,%r4
> +	xgr	%r5,%r5
> +	BR_EX	%r14
> +SYM_FUNC_END(__sae64a)
> +EXPORT_SYMBOL(__sae64a)
> +#endif
> +
>   /*
>    * SVC interrupt handler routine. System calls are synchronous events and
>    * are entered with interrupts disabled.
> diff --git a/arch/s390/tools/opcodes.txt b/arch/s390/tools/opcodes.txt
> index def2659f6602..0e4773c94af0 100644
> --- a/arch/s390/tools/opcodes.txt
> +++ b/arch/s390/tools/opcodes.txt
> @@ -594,6 +594,9 @@ b9a0	clp	RRF_U0RR
>   b9a1	tpei	RRE_RR
>   b9a2	ptf	RRE_R0
>   b9a4	uvc	RRF_URR
> +b9a5	sae	RRE_R0
> +b9a6	lasrm	RRE_R0
> +b9a7	stiasrm	RRE_R0
>   b9aa	lptea	RRF_RURR2
>   b9ab	essa	RRF_U0RR
>   b9ac	irbm	RRE_RR

