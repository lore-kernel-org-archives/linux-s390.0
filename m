Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 998E939B942;
	Mon, 16 Mar 2026 13:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773669482; cv=none; b=gl9dOivIbc4wR4fpsA15JI2kc79qhi2k9EB8pgnyXiAOzis8jr5mpUpQgwgGcGAnExNnBFbCG0v1W60dBnIWjb0W4uZkdxXwn+ZblvlsPc4+oVIj7oO+L6X+Z5Eash1tOaKZ90T53vP3/YWgfGgI3a8GM8P0vcvHoryICsZNdN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773669482; c=relaxed/simple;
	bh=g4Pcf/3mAUQ4ibxy830UjpOZDoP/gXkpWKxAViragtQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MlPGfdFxC86EupvSTlzLHufhdyFaNDojdzzAg5NFu31F+p1uYdg5uY5Xl6VGOxy7blUAh7qP4wltElqQutA4StD7f2AOaJotCmWS5W8eDBFvkvrux+OtiYf/xmvqvauhdm4zVJfNzFSTjRuISp6jByjMdfeL/AwWKT4/ZZ/irp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lgmtjUeb; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lgmtjUeb"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62G3ZdqM1512429;
	Mon, 16 Mar 2026 13:57:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=wNf6D8
	1oPv25O3OAWq36ixWnKe7zGbJ94KhL6Pflc9s=; b=lgmtjUebA+Me1HxYh7r9Xn
	cdQfkt6jN6cuJlrBE4Bnlw/QB0B4WYF2MtysKLVkYMw7RNp3QOrBV96jdgKb49SB
	NBYDT2mOKb2qgLXrnBkB10cZkuHOi1Z4rgjlF/xazllwJO/MUcohYX+yf9w72LiA
	BA46FWYZNGWurpi+ncpZ+UF5PoTKf0dZt4RxpT3WNF9HxQkEzWc3hFbGldkNui9k
	TSrLgH6waC2X9qe1d9G6LFjF4jagph1NVmd36tJpLBYxwA15uT9GgpAeK/aY0Y9N
	qCDR3HZW+OCLH+Gc1FiZZzjjDXWTzY3hwJrZ5OfbScfv8D1n9p+oAwBnNU+Lgsqg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hr081-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:57:56 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G9kCO5004559;
	Mon, 16 Mar 2026 13:57:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwj0s566t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:57:55 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GDvppE46465354
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:57:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A199F20049;
	Mon, 16 Mar 2026 13:57:51 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 35A9420040;
	Mon, 16 Mar 2026 13:57:51 +0000 (GMT)
Received: from [9.87.137.218] (unknown [9.87.137.218])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 16 Mar 2026 13:57:51 +0000 (GMT)
Message-ID: <cf8b6d86-0919-4644-aaa3-de3241df2684@linux.ibm.com>
Date: Mon, 16 Mar 2026 14:57:50 +0100
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] KVM: s390: vsie: Avoid injecting machine check on
 signal
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
        KVM <kvm@vger.kernel.org>
Cc: David Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
References: <20260316130947.40466-1-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Janosch Frank <frankja@linux.ibm.com>
Autocrypt: addr=frankja@linux.ibm.com; keydata=
 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
In-Reply-To: <20260316130947.40466-1-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: hKJMJ-7JgCgrPe76_YcIxNNyDUVJ5wF7
X-Proofpoint-ORIG-GUID: hKJMJ-7JgCgrPe76_YcIxNNyDUVJ5wF7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNCBTYWx0ZWRfX38UMMyP740zM
 KRNl5V+0aH7P0yJBatAAD5cxxpRxOIkS9Lxm2uVPVnjok52qDtKeLMY29Q18KS/hfoHnUAo7d5L
 o5INavh/QyLLk+zYY/npbUx14DpwnntVymhRWllufFjfRXo+e4Inspr3FmvWtwoPfhF9KAQgzKt
 fi8nPdV8t/PJkn6k27+R2/hZotIggl3qXs1mcSg19Z7l2oW6T0Q//FJbCGW6zGFSbzF0lAIdAup
 HVxgRNSYeL+1aaT6l1rZKymIhyDPG/yY9p0k4WJdZEqA+Jon/Y9do/xKdWpMT/cXTAE/C4DRkb1
 lIVsM9Ui8lCjGMIBYfjEK8JQjQF5SKGY+DknWqzzd24q12sBqlnwLqnC5lMO0kn+MHhxe2xcTaJ
 LTtAfeDl8xtJrJTR0bjWBdYKSHDAkmvQeDj8l3jLJTUASgFDjV+QG0uDpfnGawprGk3j+APxBFu
 esccbeThZJOw9q2myYw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b80c64 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=AAMpXutBbnW3hWGc11kA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160104

On 3/16/26 14:09, Christian Borntraeger wrote:
> The recent XFER_TO_GUEST_WORK change resulted in a situation, where the
> vsie code would interpret a signal during work as a machine check during
> SIE as both use the EINTR return code.
> The exit_reason of the sie64a function has nothing to do with the
> kvm_run exit_reason. Rename it and define a specific code for machine
> checks instead of abusing -EINTR.
> rename exit_reason into sie_return to avoid the naming conflict
> and change the code flow in vsie.c to have a separate variable for rc
> and sie_return.
> 
> Fixes: 2bd1337a1295e ("KVM: s390: Use generic VIRT_XFER_TO_GUEST_WORK functions")
> Signed-off-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> ---
> v1->v2:
> instead of a band-aid, make the machine check more direct
> v2->v3:
> avoid overloading the rc variable in vsie.c
> 
>   arch/s390/include/asm/kvm_host.h   |  3 +++
>   arch/s390/include/asm/stacktrace.h |  2 +-
>   arch/s390/kernel/asm-offsets.c     |  2 +-
>   arch/s390/kernel/entry.S           |  4 ++--
>   arch/s390/kernel/nmi.c             |  4 ++--
>   arch/s390/kvm/kvm-s390.c           | 15 ++++++++-------
>   arch/s390/kvm/vsie.c               |  7 +++++--
>   7 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 64a50f0862aa..3039c88daa63 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -710,6 +710,9 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>   void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>   			       unsigned long *aqm, unsigned long *adm);
>   
> +#define SIE64_RETURN_NORMAL	0
> +#define SIE64_RETURN_MCCK	1
> +
>   int __sie64a(phys_addr_t sie_block_phys, struct kvm_s390_sie_block *sie_block, u64 *rsa,
>   	     unsigned long gasce);
>   
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index c9ae680a28af..ac3606c3babe 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -62,7 +62,7 @@ struct stack_frame {
>   		struct {
>   			unsigned long sie_control_block;
>   			unsigned long sie_savearea;
> -			unsigned long sie_reason;
> +			unsigned long sie_return;
>   			unsigned long sie_flags;
>   			unsigned long sie_control_block_phys;
>   			unsigned long sie_guest_asce;
> diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
> index e1a5b5b54e4f..fbd26f3e9f96 100644
> --- a/arch/s390/kernel/asm-offsets.c
> +++ b/arch/s390/kernel/asm-offsets.c
> @@ -63,7 +63,7 @@ int main(void)
>   	OFFSET(__SF_EMPTY, stack_frame, empty[0]);
>   	OFFSET(__SF_SIE_CONTROL, stack_frame, sie_control_block);
>   	OFFSET(__SF_SIE_SAVEAREA, stack_frame, sie_savearea);
> -	OFFSET(__SF_SIE_REASON, stack_frame, sie_reason);
> +	OFFSET(__SF_SIE_RETURN, stack_frame, sie_return);
>   	OFFSET(__SF_SIE_FLAGS, stack_frame, sie_flags);
>   	OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
>   	OFFSET(__SF_SIE_GUEST_ASCE, stack_frame, sie_guest_asce);
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 4873fe9d891b..5817cb47b2d0 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -200,7 +200,7 @@ SYM_FUNC_START(__sie64a)
>   	stg	%r3,__SF_SIE_CONTROL(%r15)	# ...and virtual addresses
>   	stg	%r4,__SF_SIE_SAVEAREA(%r15)	# save guest register save area
>   	stg	%r5,__SF_SIE_GUEST_ASCE(%r15)	# save guest asce
> -	xc	__SF_SIE_REASON(8,%r15),__SF_SIE_REASON(%r15) # reason code = 0
> +	xc	__SF_SIE_RETURN(8,%r15),__SF_SIE_RETURN(%r15) # return code = 0
>   	mvc	__SF_SIE_FLAGS(8,%r15),__TI_flags(%r14) # copy thread flags
>   	lmg	%r0,%r13,0(%r4)			# load guest gprs 0-13
>   	mvi	__TI_sie(%r14),1
> @@ -237,7 +237,7 @@ SYM_INNER_LABEL(sie_exit, SYM_L_GLOBAL)
>   	xgr	%r4,%r4
>   	xgr	%r5,%r5
>   	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> -	lg	%r2,__SF_SIE_REASON(%r15)	# return exit reason code
> +	lg	%r2,__SF_SIE_RETURN(%r15)	# return sie return code
>   	BR_EX	%r14
>   SYM_FUNC_END(__sie64a)
>   EXPORT_SYMBOL(__sie64a)
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index a55abbf65333..fc1f775e4517 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -487,8 +487,8 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
>   	mcck_dam_code = (mci.val & MCIC_SUBCLASS_MASK);
>   	if (test_cpu_flag(CIF_MCCK_GUEST) &&
>   	(mcck_dam_code & MCCK_CODE_NO_GUEST) != mcck_dam_code) {
> -		/* Set exit reason code for host's later handling */
> -		*((long *)(regs->gprs[15] + __SF_SIE_REASON)) = -EINTR;
> +		/* Set sie return code for host's later handling */
> +		*((long *)(regs->gprs[15] + __SF_SIE_RETURN)) = SIE64_RETURN_MCCK;

We don't need to cast this to long anymore, do we?
Since sie_return is ulong, and we if we stay with positive numbers ulong 
would make the most sense.

Although I'd prefer a cast to stack_frame but I'm unsure if that would 
make it more readable if we stay with a one line change.

Rest looks good to me
