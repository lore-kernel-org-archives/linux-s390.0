Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C22FE3822B3;
	Mon, 16 Mar 2026 13:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773668564; cv=none; b=mEo1ZFmkUqq5GomleaCiH43WxZVqmqDbvUQCZs0C1mDIJDVbXKABzGYDCM8G4lVWwFKkf75jSA2l7k2ifqtJ8DD9s4BHPu1Mu9yNicWOdM+RG3jGsUUfd6/zv5MDq7xWpWWbPvP1ivBaMlyzFDuqJmwBLGb94KWBc5mQQGvqAXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773668564; c=relaxed/simple;
	bh=TokSCEPAKBjYuGva7jjIDWcHABvWxLlbyR5R3fxwMbU=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lK98T9ZHFkDzmb1EpZbea44Q5TaP4Q+CBUtxAF/v2OOedR8iGZEUVCFe2NWhVPdJREhiBAcuz7WU+m/RHtlFW1yk0Y2H2b4JDJqeQerGrA9paPjMQ0vXJbVm6F3YBXPvJu/fijKf4LC7UfTiwNeOxSV6qB8eddsNvJOSmFp6dO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=PilOWveG; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="PilOWveG"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62FMj9XX940706;
	Mon, 16 Mar 2026 13:42:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=UVN99J
	C3hm2x+R6r2g9GdadfBP/sDFgWCzTWtnxzPkw=; b=PilOWveG7Ke8VdwCZ0Bh77
	Lydsbr35CEpocaiS6GkkPBx19YifUxHapg27qvGmnSySimxPeEpY5MFX5Ksd2wbr
	KYzsYgvhiUJTXB9V1YAbzp/3LhgAkWTH85SgTHsEW70TDwUMcJWM9IkhQEsbnaKq
	XX1xj5+3/mpbQODS4t2L78jUEcYDUgMYlze0fVtqQUhSvOXDNjAEEJvAf1IS4d83
	MyZogRGyJju/hVvWr5gGlErCtCnfOLmbq+N+A9PVMWUBjAfr8sp8bA/I7M21DAm1
	QhFHZR1r5/48Mus0Ci0/a43lgv22nEp2RJO7gwwkJoYrV8XlPqAjqUPeDghzCcFg
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvybs02my-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:42:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62GAFJUB015746;
	Mon, 16 Mar 2026 13:42:36 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n50hk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Mar 2026 13:42:36 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62GDgWWM22937994
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Mar 2026 13:42:32 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 04D6D2004E;
	Mon, 16 Mar 2026 13:42:32 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5BE220040;
	Mon, 16 Mar 2026 13:42:31 +0000 (GMT)
Received: from p-imbrenda (unknown [9.52.223.175])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with SMTP;
	Mon, 16 Mar 2026 13:42:31 +0000 (GMT)
Date: Mon, 16 Mar 2026 14:42:29 +0100
From: Claudio Imbrenda <imbrenda@linux.ibm.com>
To: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: KVM <kvm@vger.kernel.org>, Janosch Frank <frankja@linux.ibm.com>,
        David
 Hildenbrand <david@kernel.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Thomas Huth <thuth@redhat.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily
 Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Subject: Re: [PATCH v3] KVM: s390: vsie: Avoid injecting machine check on
 signal
Message-ID: <20260316144229.2074fe5a@p-imbrenda>
In-Reply-To: <20260316130947.40466-1-borntraeger@linux.ibm.com>
References: <20260316130947.40466-1-borntraeger@linux.ibm.com>
Organization: IBM
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=MMttWcZl c=1 sm=1 tr=0 ts=69b808cd cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=kj9zAlcOel0A:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=522wedpwt5l_Ht9sG1UA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: IbvW0IyQBcs4UBec58rlH6iDYxDxitZw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDEwNCBTYWx0ZWRfXx8Def5qjAjAP
 eM8Al59iwuc9yeDIDH35VX8inzeuUaytXW/iuRTJlD/qOyiAhfgUCZs2hX4ahJYRabXA2efWFC+
 ZlGnkWDiwxWnNqCZVfZAkLHMwXAlIOWXWGtDk9ntS3A+19iy2tgy+p9CRQcyHEew5E/1ppWOSdb
 jaJXzgC7hQ7JTi54j6wQ+kAGIueYZueoGltM69ne5oAvss1j3mq9WSmVlAEeQzObkKBrGCru8DX
 V9g/lnLRzgw5DTfvFrbBwbFhLnVUQmbnVK3bSYpJvNUp3WMUaMRmJGx6rmReJTvUP8iPIIeN+Wu
 Uq7sXJxERA30cha597zJ9MeRVnX0dW/gtlmNQPOZ7vF1Y9JlD/nw+o+dKEngIvthgODJ2PIPmQw
 DCZNOUzXdUkEjimwLghq2uwmXLyp2UxgE/njPFDhttf3bJCtZwOGL2onyfNiu0qeBf2wJlDqvMv
 45BriW0aO8Oa9zvE1Bw==
X-Proofpoint-GUID: IbvW0IyQBcs4UBec58rlH6iDYxDxitZw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_04,2026-03-16_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0
 priorityscore=1501 impostorscore=0 adultscore=0 phishscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603160104

On Mon, 16 Mar 2026 14:09:47 +0100
Christian Borntraeger <borntraeger@linux.ibm.com> wrote:

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

With Heiko's comments addresssed:
Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

> ---
> v1->v2:
> instead of a band-aid, make the machine check more direct
> v2->v3:
> avoid overloading the rc variable in vsie.c
> 
>  arch/s390/include/asm/kvm_host.h   |  3 +++
>  arch/s390/include/asm/stacktrace.h |  2 +-
>  arch/s390/kernel/asm-offsets.c     |  2 +-
>  arch/s390/kernel/entry.S           |  4 ++--
>  arch/s390/kernel/nmi.c             |  4 ++--
>  arch/s390/kvm/kvm-s390.c           | 15 ++++++++-------
>  arch/s390/kvm/vsie.c               |  7 +++++--
>  7 files changed, 22 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/s390/include/asm/kvm_host.h b/arch/s390/include/asm/kvm_host.h
> index 64a50f0862aa..3039c88daa63 100644
> --- a/arch/s390/include/asm/kvm_host.h
> +++ b/arch/s390/include/asm/kvm_host.h
> @@ -710,6 +710,9 @@ void kvm_arch_crypto_clear_masks(struct kvm *kvm);
>  void kvm_arch_crypto_set_masks(struct kvm *kvm, unsigned long *apm,
>  			       unsigned long *aqm, unsigned long *adm);
>  
> +#define SIE64_RETURN_NORMAL	0
> +#define SIE64_RETURN_MCCK	1
> +
>  int __sie64a(phys_addr_t sie_block_phys, struct kvm_s390_sie_block *sie_block, u64 *rsa,
>  	     unsigned long gasce);
>  
> diff --git a/arch/s390/include/asm/stacktrace.h b/arch/s390/include/asm/stacktrace.h
> index c9ae680a28af..ac3606c3babe 100644
> --- a/arch/s390/include/asm/stacktrace.h
> +++ b/arch/s390/include/asm/stacktrace.h
> @@ -62,7 +62,7 @@ struct stack_frame {
>  		struct {
>  			unsigned long sie_control_block;
>  			unsigned long sie_savearea;
> -			unsigned long sie_reason;
> +			unsigned long sie_return;
>  			unsigned long sie_flags;
>  			unsigned long sie_control_block_phys;
>  			unsigned long sie_guest_asce;
> diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
> index e1a5b5b54e4f..fbd26f3e9f96 100644
> --- a/arch/s390/kernel/asm-offsets.c
> +++ b/arch/s390/kernel/asm-offsets.c
> @@ -63,7 +63,7 @@ int main(void)
>  	OFFSET(__SF_EMPTY, stack_frame, empty[0]);
>  	OFFSET(__SF_SIE_CONTROL, stack_frame, sie_control_block);
>  	OFFSET(__SF_SIE_SAVEAREA, stack_frame, sie_savearea);
> -	OFFSET(__SF_SIE_REASON, stack_frame, sie_reason);
> +	OFFSET(__SF_SIE_RETURN, stack_frame, sie_return);
>  	OFFSET(__SF_SIE_FLAGS, stack_frame, sie_flags);
>  	OFFSET(__SF_SIE_CONTROL_PHYS, stack_frame, sie_control_block_phys);
>  	OFFSET(__SF_SIE_GUEST_ASCE, stack_frame, sie_guest_asce);
> diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
> index 4873fe9d891b..5817cb47b2d0 100644
> --- a/arch/s390/kernel/entry.S
> +++ b/arch/s390/kernel/entry.S
> @@ -200,7 +200,7 @@ SYM_FUNC_START(__sie64a)
>  	stg	%r3,__SF_SIE_CONTROL(%r15)	# ...and virtual addresses
>  	stg	%r4,__SF_SIE_SAVEAREA(%r15)	# save guest register save area
>  	stg	%r5,__SF_SIE_GUEST_ASCE(%r15)	# save guest asce
> -	xc	__SF_SIE_REASON(8,%r15),__SF_SIE_REASON(%r15) # reason code = 0
> +	xc	__SF_SIE_RETURN(8,%r15),__SF_SIE_RETURN(%r15) # return code = 0
>  	mvc	__SF_SIE_FLAGS(8,%r15),__TI_flags(%r14) # copy thread flags
>  	lmg	%r0,%r13,0(%r4)			# load guest gprs 0-13
>  	mvi	__TI_sie(%r14),1
> @@ -237,7 +237,7 @@ SYM_INNER_LABEL(sie_exit, SYM_L_GLOBAL)
>  	xgr	%r4,%r4
>  	xgr	%r5,%r5
>  	lmg	%r6,%r14,__SF_GPRS(%r15)	# restore kernel registers
> -	lg	%r2,__SF_SIE_REASON(%r15)	# return exit reason code
> +	lg	%r2,__SF_SIE_RETURN(%r15)	# return sie return code
>  	BR_EX	%r14
>  SYM_FUNC_END(__sie64a)
>  EXPORT_SYMBOL(__sie64a)
> diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
> index a55abbf65333..fc1f775e4517 100644
> --- a/arch/s390/kernel/nmi.c
> +++ b/arch/s390/kernel/nmi.c
> @@ -487,8 +487,8 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
>  	mcck_dam_code = (mci.val & MCIC_SUBCLASS_MASK);
>  	if (test_cpu_flag(CIF_MCCK_GUEST) &&
>  	(mcck_dam_code & MCCK_CODE_NO_GUEST) != mcck_dam_code) {
> -		/* Set exit reason code for host's later handling */
> -		*((long *)(regs->gprs[15] + __SF_SIE_REASON)) = -EINTR;
> +		/* Set sie return code for host's later handling */
> +		*((long *)(regs->gprs[15] + __SF_SIE_RETURN)) = SIE64_RETURN_MCCK;
>  	}
>  	clear_cpu_flag(CIF_MCCK_GUEST);
>  
> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 1668580008c6..b93722b57d1c 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
> @@ -4617,7 +4617,7 @@ static int vcpu_post_run_handle_fault(struct kvm_vcpu *vcpu)
>  	return 0;
>  }
>  
> -static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
> +static int vcpu_post_run(struct kvm_vcpu *vcpu, int sie_return)
>  {
>  	struct mcck_volatile_info *mcck_info;
>  	struct sie_page *sie_page;
> @@ -4633,13 +4633,14 @@ static int vcpu_post_run(struct kvm_vcpu *vcpu, int exit_reason)
>  	vcpu->run->s.regs.gprs[14] = vcpu->arch.sie_block->gg14;
>  	vcpu->run->s.regs.gprs[15] = vcpu->arch.sie_block->gg15;
>  
> -	if (exit_reason == -EINTR) {
> +	if (sie_return == SIE64_RETURN_MCCK) {
>  		sie_page = container_of(vcpu->arch.sie_block,
>  					struct sie_page, sie_block);
>  		mcck_info = &sie_page->mcck_info;
>  		kvm_s390_reinject_machine_check(vcpu, mcck_info);
>  		return 0;
>  	}
> +	WARN_ON(sie_return != SIE64_RETURN_NORMAL);
>  
>  	if (vcpu->arch.sie_block->icptcode > 0) {
>  		rc = kvm_handle_sie_intercept(vcpu);
> @@ -4678,7 +4679,7 @@ int noinstr kvm_s390_enter_exit_sie(struct kvm_s390_sie_block *scb,
>  #define PSW_INT_MASK (PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_MCHECK)
>  static int __vcpu_run(struct kvm_vcpu *vcpu)
>  {
> -	int rc, exit_reason;
> +	int rc, sie_return;
>  	struct sie_page *sie_page = (struct sie_page *)vcpu->arch.sie_block;
>  
>  	/*
> @@ -4718,9 +4719,9 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  		guest_timing_enter_irqoff();
>  		__disable_cpu_timer_accounting(vcpu);
>  
> -		exit_reason = kvm_s390_enter_exit_sie(vcpu->arch.sie_block,
> -						      vcpu->run->s.regs.gprs,
> -						      vcpu->arch.gmap->asce.val);
> +		sie_return = kvm_s390_enter_exit_sie(vcpu->arch.sie_block,
> +						     vcpu->run->s.regs.gprs,
> +						     vcpu->arch.gmap->asce.val);
>  
>  		__enable_cpu_timer_accounting(vcpu);
>  		guest_timing_exit_irqoff();
> @@ -4743,7 +4744,7 @@ static int __vcpu_run(struct kvm_vcpu *vcpu)
>  		}
>  		kvm_vcpu_srcu_read_lock(vcpu);
>  
> -		rc = vcpu_post_run(vcpu, exit_reason);
> +		rc = vcpu_post_run(vcpu, sie_return);
>  		if (rc || guestdbg_exit_pending(vcpu)) {
>  			kvm_vcpu_srcu_read_unlock(vcpu);
>  			break;
> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index c0d36afd4023..42c53134e0b8 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -1123,6 +1123,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>  	struct kvm_s390_sie_block *scb_s = &vsie_page->scb_s;
>  	struct kvm_s390_sie_block *scb_o = vsie_page->scb_o;
>  	int guest_bp_isolation;
> +	int sie_return = SIE64_RETURN_NORMAL;
>  	int rc = 0;
>  
>  	handle_last_fault(vcpu, vsie_page, sg);
> @@ -1163,7 +1164,7 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>  			goto xfer_to_guest_mode_check;
>  		}
>  		guest_timing_enter_irqoff();
> -		rc = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
> +		sie_return = kvm_s390_enter_exit_sie(scb_s, vcpu->run->s.regs.gprs, sg->asce.val);
>  		guest_timing_exit_irqoff();
>  		local_irq_enable();
>  	}
> @@ -1178,11 +1179,13 @@ static int do_vsie_run(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page, struc
>  
>  	kvm_vcpu_srcu_read_lock(vcpu);
>  
> -	if (rc == -EINTR) {
> +	if (sie_return == SIE64_RETURN_MCCK) {
>  		kvm_s390_reinject_machine_check(vcpu, &vsie_page->mcck_info);
>  		return 0;
>  	}
>  
> +	WARN_ON(sie_return != SIE64_RETURN_NORMAL);
> +
>  	if (rc > 0)
>  		rc = 0; /* we could still have an icpt */
>  	else if (current->thread.gmap_int_code)

