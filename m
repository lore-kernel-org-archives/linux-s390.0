Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 428C042FCA8;
	Tue, 21 Jul 2026 09:59:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784627963; cv=none; b=NrORdK7Fgxl64ISrMvwcfOMRFJTLumvlf2KQnefvwOF3IWrw6pu1jrp6bJDwEJu2mAR9cCMiJug5PTiZPe6Rn5rTz7/g8kLnx0k0AiKqgDFCB9HCoyDSNbHY5QVGLCBNXLep5r0PGgqgTq3d7apQDz4PI1Oqgp1aMyCXjK6LvIc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784627963; c=relaxed/simple;
	bh=ISX5LY30wjq+MPodRckgbiO6z7QOKn7RVdBVeo/rM1o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kZMy7bop/RNgXSOvKsx+UR9RQVVl/PEK7LtVNRpgs4AGSEEAroKHseGcHBq6T4cf1R6+Q/0mv/OPfHWnhoOUbaNl9uPYzoCpUgnduyPFyB8eqFemIYFsMU424PmppFi5ejBboDaiykGrwwSxJQTMz1xBe9hkfOQSq48TmSX5uGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=iL2pp0xH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="iL2pp0xH"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66KNDVhO3560135;
	Tue, 21 Jul 2026 09:59:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=hqAsVDBgecRJBusiKisD1Jg8rGYjh7
	BnQXRU47A/vpI=; b=iL2pp0xHB3mFaoiWET73NmMaAaMwSfsBHF64u/Ei5GE/kx
	iCHOFIFwqi1N4/vDvt4ytKZ5D7ub4I6BfyQQhj28TF1nLwl4/DN2INEgSPi4jqZt
	IRlTxkMsgiskvum4Z1EN74gRa/HC3ts/O5N5flvd4s+VdsxMMZa+8XUuMiOJ3E1E
	8zw1qM72YacM+6GTN90HDvsd3OUCYTkP3caJpUbAcdX2F/cuLQq0gzF2iN9AboPs
	CvpkN2bNtmtSgI3vIXMgpdqaeRaXnQfyp7a3EOuSLAvuaOc2Sciqtz0LvfV1IdXp
	9ZZHPtHJAXl9FDDGkzjJN4oPd51MPNg+YniyHGJQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fg7ah3jka-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:59:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66L9nZje023813;
	Tue, 21 Jul 2026 09:59:16 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fgnah1pmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jul 2026 09:59:16 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66L9xCAf51642826
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jul 2026 09:59:12 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 464972004B;
	Tue, 21 Jul 2026 09:59:12 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17CA320043;
	Tue, 21 Jul 2026 09:59:12 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.87.85.9])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jul 2026 09:59:12 +0000 (GMT)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
        Vasily Gorbik
 <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda
 <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>, linux-s390@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 8/8] s390: Add support for DCACHE_WORD_ACCESS (again)
In-Reply-To: <20260720085834.898025-9-hca@linux.ibm.com>
References: <20260720085834.898025-1-hca@linux.ibm.com>
	<20260720085834.898025-9-hca@linux.ibm.com>
Date: Tue, 21 Jul 2026 11:59:11 +0200
Message-ID: <yt9dmrvkll3k.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Qbi-E-chf0pfWLaaoAu0uV_ESZqdnXJu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIxMDEwMiBTYWx0ZWRfX1MSl8ZdxC3hK
 CwZ+NYtPer3bRebvDaC8ygVq4MBdqoIMUgqyMVOulI/wMYWP0TaKvyM8aAi+gGf2RIIqAvSCiSi
 niPk5QBgOzUPSHqdI6Bvz0E/RsRxSxDypgSYY/mPvBjnQBRB2ipiFpwgPsEZv8SZ8H3FBgW5SrV
 zP5dBwbbh8opRwcOUtfr+B3q2A/rKnzOqUy+JV8kg22dnFFS6rx+IRAqBwKyaMv1KOCMLY8gjrf
 rt8U51XtK6ao+5ADS9xPwJs+KfqvpZ7kb3zTd9xrOvedVLSjg8/uUvmtB0WYWuVIIaKnquC+PM3
 oHVbzEE1jVXbwLwlyEpfi54qcU/utdTxTuNn5tgJxkJAc2HGlyn348borcbagFu7t7HI5pkpX6x
 1KCKIc1qfyDnjYiGpRxFo8L3/gc9aIYX7peTuCnsOqaXVCUyMVfk1pd8IJ7WtNxvb0Boz6AHvmO
 FP6ATsdfWF0ehz7Zj1w==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIxMDEwMiBTYWx0ZWRfX3t+y3n0BBUdd
 1Day50jduvLUU7dgCPRYUSVYP4D2hHnTueZnbaipOKi3YqKTZdjkL8pRUWDWwXZ9E7mi33zFGYP
 7ocyLkoCOF2O/b30O5MH4c8w/h3mr6k=
X-Proofpoint-GUID: Qbi-E-chf0pfWLaaoAu0uV_ESZqdnXJu
X-Authority-Analysis: v=2.4 cv=SM5ykuvH c=1 sm=1 tr=0 ts=6a5f42f5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=VAyOQAVIeXdyq_GhAlYA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-20_06,2026-07-20_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 bulkscore=0 suspectscore=0 adultscore=0
 spamscore=0 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607210102

Heiko Carstens <hca@linux.ibm.com> writes:

> Implement load_unaligned_zeropad() and enable DCACHE_WORD_ACCESS to
> speed up string operations in fs/dcache.c and fs/namei.c.
>
> With the secure storage access exception cases addressed, add support
> for DCACHE_WORD_ACCESS again.
>
> Tested-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  arch/s390/Kconfig                      |  1 +
>  arch/s390/include/asm/asm-extable.h    |  4 ++++
>  arch/s390/include/asm/word-at-a-time.h | 22 ++++++++++++++++++++++
>  arch/s390/mm/extable.c                 | 18 ++++++++++++++++++
>  4 files changed, 45 insertions(+)
>
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 84404e6778d5..fe81c539ef2f 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -163,6 +163,7 @@ config S390
>  	select ARCH_WANTS_THP_SWAP
>  	select BUILDTIME_TABLE_SORT
>  	select CLONE_BACKWARDS2
> +	select DCACHE_WORD_ACCESS if !KMSAN
>  	select DYNAMIC_FTRACE if FUNCTION_TRACER
>  	select FUNCTION_ALIGNMENT_8B if CC_IS_GCC
>  	select FUNCTION_ALIGNMENT_16B if !CC_IS_GCC
> diff --git a/arch/s390/include/asm/asm-extable.h b/arch/s390/include/asm/asm-extable.h
> index 99748c20e767..d23ea0c94e4e 100644
> --- a/arch/s390/include/asm/asm-extable.h
> +++ b/arch/s390/include/asm/asm-extable.h
> @@ -12,6 +12,7 @@
>  #define EX_TYPE_UA_FAULT	3
>  #define EX_TYPE_UA_LOAD_REG	5
>  #define EX_TYPE_UA_LOAD_REGPAIR	6
> +#define EX_TYPE_ZEROPAD		7
>  #define EX_TYPE_FPC		8
>  #define EX_TYPE_UA_MVCOS_TO	9
>  #define EX_TYPE_UA_MVCOS_FROM	10
> @@ -79,6 +80,9 @@
>  #define EX_TABLE_UA_LOAD_REGPAIR(_fault, _target, _regerr, _regzero)	\
>  	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_UA_LOAD_REGPAIR, _regerr, _regzero, 0)
>  
> +#define EX_TABLE_ZEROPAD(_fault, _target, _regdata, _regaddr)		\
> +	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_ZEROPAD, _regdata, _regaddr, 0)
> +
>  #define EX_TABLE_FPC(_fault, _target)					\
>  	__EX_TABLE(__ex_table, _fault, _target, EX_TYPE_FPC, __stringify(%%r0), __stringify(%%r0), 0)
>  
> diff --git a/arch/s390/include/asm/word-at-a-time.h b/arch/s390/include/asm/word-at-a-time.h
> index e9287036392d..eaa19dee7699 100644
> --- a/arch/s390/include/asm/word-at-a-time.h
> +++ b/arch/s390/include/asm/word-at-a-time.h
> @@ -4,6 +4,7 @@
>  
>  #include <linux/bitops.h>
>  #include <linux/wordpart.h>
> +#include <asm/asm-extable.h>
>  #include <asm/bitsperlong.h>
>  
>  struct word_at_a_time {
> @@ -40,4 +41,25 @@ static inline unsigned long zero_bytemask(unsigned long data)
>  	return ~1UL << data;
>  }
>  
> +/*
> + * Load an unaligned word from kernel space.
> + *
> + * In the (very unlikely) case of the word being a page-crosser
> + * and the next page not being mapped, take the exception and
> + * return zeroes in the non-existing part.
> + */
> +static inline unsigned long load_unaligned_zeropad(const void *addr)
> +{
> +	unsigned long data;
> +
> +	asm_inline volatile(
> +		"0:	lg	%[data],0(%[addr])\n"
> +		"1:	nopr	%%r7\n"
> +		EX_TABLE_ZEROPAD(0b, 1b, %[data], %[addr])
> +		EX_TABLE_ZEROPAD(1b, 1b, %[data], %[addr])
> +		: [data] "=d" (data)
> +		: [addr] "a" (addr), "m" (*(unsigned long *)addr));
> +	return data;
> +}
> +
>  #endif /* _ASM_WORD_AT_A_TIME_H */
> diff --git a/arch/s390/mm/extable.c b/arch/s390/mm/extable.c
> index 063b4346742d..7498e858c401 100644
> --- a/arch/s390/mm/extable.c
> +++ b/arch/s390/mm/extable.c
> @@ -50,6 +50,22 @@ static bool ex_handler_ua_load_reg(const struct exception_table_entry *ex,
>  	return true;
>  }
>  
> +static bool ex_handler_zeropad(const struct exception_table_entry *ex, struct pt_regs *regs)
> +{
> +	unsigned int reg_addr = FIELD_GET(EX_DATA_REG_ADDR, ex->data);
> +	unsigned int reg_data = FIELD_GET(EX_DATA_REG_ERR, ex->data);
> +	unsigned long data, addr, offset;
> +
> +	addr = regs->gprs[reg_addr];
> +	offset = addr & (sizeof(unsigned long) - 1);
> +	addr &= ~(sizeof(unsigned long) - 1);
> +	data = *(unsigned long *)addr;
> +	data <<= BITS_PER_BYTE * offset;
> +	regs->gprs[reg_data] = data;
> +	regs->psw.addr = extable_fixup(ex);
> +	return true;
> +}
> +
>  static bool ex_handler_fpc(const struct exception_table_entry *ex, struct pt_regs *regs)
>  {
>  	fpu_sfpc(0);
> @@ -118,6 +134,8 @@ bool fixup_exception(struct pt_regs *regs)
>  		return ex_handler_ua_load_reg(ex, false, regs);
>  	case EX_TYPE_UA_LOAD_REGPAIR:
>  		return ex_handler_ua_load_reg(ex, true, regs);
> +	case EX_TYPE_ZEROPAD:
> +		return ex_handler_zeropad(ex, regs);
>  	case EX_TYPE_FPC:
>  		return ex_handler_fpc(ex, regs);
>  	case EX_TYPE_UA_MVCOS_TO:

Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
