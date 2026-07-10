Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB474189B6;
	Fri, 10 Jul 2026 11:57:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783684651; cv=none; b=M+mYiFfS4b6NxPP6nTjjBfQFvK3VyeBxl038jiCSZmgnttCyiW2TMcTLsdPdvtSwVJT/c472utJaEfIB4at6/IRHbOKTkvvo0c4VXkec549Dl+7GrjmF8VGKzP+LPpozqiCAybl09kLxVAZeY/NbsF7Cik83nzV2MQQydo8iXuY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783684651; c=relaxed/simple;
	bh=kvazcfUq9ZYj6uZ16qwJeVm5v3hO6kSzer36N7uDJU4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjIhigfDhhR+q0fmZ3++6SJXhMjBkbRt7Z+0aYv/gxVBP2thfYJonQiuFCGHvo7hx4BgsFS73Ao5HI0sckPd9a1J6BV97JY79x1D+qZhrRx5+bjAySViFh26OvnFyS0ABDQ+nA0rysN3DdAMQutdHXgO8xOtpMv/Z6pmMRapHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=W0sQt6cU; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="W0sQt6cU"
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66AAmt1d1391207;
	Fri, 10 Jul 2026 11:56:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=9fsiWcwBToyW3gsri5KuLfQd15xA3y
	Q0e3RQdD/aBtg=; b=W0sQt6cUZP/EUAfkWxrsYO13TAF6nT5ZJUfCagHiCHMiux
	T/uWkUm374ULa/kJx5kh20hNOWqEFtu+oYAuwYxt03nqSS03lgdyMRfaiEpjFspO
	H7Cdz9W7BqyPgSG6IJApCNw/2WmfmWLwFgc+WdKdgZYlu5HNbmskuLT+bZI+dsxk
	+XJZCiGFmOOLCwhEEkmH/frrY5aO4Xc3NscL6mKi954xnHgfilPgRRmxCkVcpQmt
	qdGAujdF1VsFjJuntdrl+OOcMOxdnBahDmCYOQZ7LKQCKrpIR2tuL9qTto6Sc2Ss
	6ku20EwL2q8f8IPZ7gHXutUmDUYcDCY9QR2IihSQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sur69kc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 11:56:48 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66ABnnZg007753;
	Fri, 10 Jul 2026 11:56:47 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwj22t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 11:56:47 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66ABueRs27263266
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 11:56:40 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A20A20049;
	Fri, 10 Jul 2026 11:56:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4555020040;
	Fri, 10 Jul 2026 11:56:39 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 11:56:39 +0000 (GMT)
Date: Fri, 10 Jul 2026 13:56:37 +0200
From: Steffen Eiden <seiden@linux.ibm.com>
To: Marc Zyngier <maz@kernel.org>
Cc: kvm@vger.kernel.org, kvmarm@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, Alexander Gordeev <agordeev@linux.ibm.com>,
        Andreas Grapentin <gra@linux.ibm.com>, Arnd Bergmann <arnd@arndb.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        David Hildenbrand <david@kernel.org>,
        Friedrich Welter <fritz@linux.ibm.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v4 09/27] KVM: arm64: Access elements of vcpu_gp_regs
 individually
Message-ID: <20260710115637.984749-H-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-10-seiden@linux.ibm.com>
 <86cxx0ovx5.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86cxx0ovx5.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDExNyBTYWx0ZWRfX4LaHG2cbEDg/
 BIx2/t04jsyLY1n5DJ221VRhumIJmabCnU6WnnKyJ5GXvzBUIiZJZa3dEW8eOzlRLd4INYjc4w+
 N6BWUeIewSS3WCtE/vsmr9nC3Px2pZI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDExNyBTYWx0ZWRfX1OLJhk/mxwBH
 m39hdBM2yJSRl0y7hd/yKzK0tF2OMP5DXdaqyNy9WKoR82s3cZenNU/8ZFwACcRwX48fHLl9y3z
 6LAejCZoFk5FvG5Af2IeeaZboaJLpPLAgf+5cP/CyJwN/e0c/gse+Q0CrBQ1Z/Y1mkb8zID+a6H
 lG+5iUslSBeSjhVVwRCtXPB0ESCug1qFiQhiTu4+v2i9nbRmBCPHiZ+ahx7VP1bZrFxnAOm5EAl
 e9LphNcN26rTn7wRXUqOtBiB2WGurxm836iStnp0awRqfG2mr3pFr5jLkBZY0rXWwYGL4nZFTr8
 CmAPvJB1QqJDMTADPPxKktZIZfdTN+Z4IdDlIiY7v+TmvwE+n0A9/wsmaEbcTfQoVgL8XJ5loQ+
 Zvp10MJ6bMfsijkalBSBN2mWCWT8G/NuciGeU3KY9h9xHEkG9+5mW2fBS9pZgxLvrPxZShSXY9G
 5Yyr+TGleopO9hI6b7g==
X-Proofpoint-GUID: QewiZpKBES5sTR1z0ckpN5bbItnepDFb
X-Authority-Analysis: v=2.4 cv=Oot/DS/t c=1 sm=1 tr=0 ts=6a50de01 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=JvUMi_Ukf_9PVyXn5B4A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: QewiZpKBES5sTR1z0ckpN5bbItnepDFb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_03,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0 phishscore=0
 malwarescore=0 suspectscore=0 spamscore=0 adultscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100117

On Mon, Jul 06, 2026 at 06:44:06PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:09 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > While for arm64 the members of vcpu_gp_regs are allocated continuous
> > this is not necessarily true for other architectures implementing ARM.
> > 
> > Let vcpu_gp_regs() no longer return the address of the user_pt_regs in
> > the vcpu context but the address of the gp-register array field in the
> > user_pt_reg struct.
> 
> That's an interesting change of semantics, because this excludes PC
> from the GPRs. This is valid on AArch64, but wrong for AArch32 (PC
> really is R15, and is just another GPR).
>

I never looked into AArch32 thanks for pointing this out.

> It isn't a huge deal, and nothing breaks, but that's something that
> you may want to capture.
> 

Shall I add a comment into the commit message that this splits pc from
the gprs for arm32?



...

> >  
> > +#define kvm_vcpu_get_sp_el1(__vcpu) (__ctxt_sys_reg(&(__vcpu)->arch.ctxt, SP_EL1))
> > +#define kvm_vcpu_get_vreg(__vcpu, _n) (&(__vcpu)->arch.ctxt.fp_regs.vregs[_n])
> > +#define kvm_vcpu_get_vregs(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.vregs)
> > +#define kvm_vcpu_get_fpsr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpsr)
> > +#define kvm_vcpu_get_fpcr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpcr)
> > +
> >  u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, u64);
> >  
> >  #define __vcpu_assign_sys_reg(v, r, val)				\
> > diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> > index 5a202cfd27bc..5e1e1faa98c2 100644
> > --- a/arch/arm64/kvm/guest.c
> > +++ b/arch/arm64/kvm/guest.c
> > @@ -62,6 +62,7 @@ const struct kvm_stats_header kvm_vcpu_stats_header = {
> >  		       sizeof(kvm_vcpu_stats_desc),
> >  };
> >  
> > +#ifdef ARM64_S390_COMMON
> 
> I really think this patch (and a few others) needs splitting. What I'd
> like to see is a prefix to this series adding the required arm64
> rework, and only in a subsequent patch add the "make this shared"
> attributes.

Ok, makes sense. I'll do the refactroings first and then add these
markers.

> 
> Also, quite a lot of this patch is about using the existing accessors
> instead of an open-coded version. These changes should be standalone.

Ok I'llsplit this up:

1. vcpu_gp_regs change
2. accessor use

> 
> >  static bool core_reg_offset_is_vreg(u64 off)
> >  {
> >  	return off >= KVM_REG_ARM_CORE_REG(fp_regs.vregs) &&
> > @@ -134,19 +135,19 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	     KVM_REG_ARM_CORE_REG(regs.regs[30]):
> >  		off -= KVM_REG_ARM_CORE_REG(regs.regs[0]);
> >  		off /= 2;
> > -		return &vcpu->arch.ctxt.regs.regs[off];
> > +		return &vcpu_gp_regs(vcpu)[off];
> >  
> >  	case KVM_REG_ARM_CORE_REG(regs.sp):
> > -		return &vcpu->arch.ctxt.regs.sp;
> > +		return vcpu_sp_el0(vcpu);
> >  
> >  	case KVM_REG_ARM_CORE_REG(regs.pc):
> > -		return &vcpu->arch.ctxt.regs.pc;
> > +		return vcpu_pc(vcpu);
> >  
> >  	case KVM_REG_ARM_CORE_REG(regs.pstate):
> > -		return &vcpu->arch.ctxt.regs.pstate;
> > +		return vcpu_cpsr(vcpu);
> >  
> >  	case KVM_REG_ARM_CORE_REG(sp_el1):
> > -		return __ctxt_sys_reg(&vcpu->arch.ctxt, SP_EL1);
> > +		return  kvm_vcpu_get_sp_el1(vcpu);
> >  
> >  	case KVM_REG_ARM_CORE_REG(elr_el1):
> >  		return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
> > @@ -170,13 +171,13 @@ static void *core_reg_addr(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	     KVM_REG_ARM_CORE_REG(fp_regs.vregs[31]):
> >  		off -= KVM_REG_ARM_CORE_REG(fp_regs.vregs[0]);
> >  		off /= 4;
> > -		return &vcpu->arch.ctxt.fp_regs.vregs[off];
> > +		return kvm_vcpu_get_vreg(vcpu, off);
> >  
> >  	case KVM_REG_ARM_CORE_REG(fp_regs.fpsr):
> > -		return &vcpu->arch.ctxt.fp_regs.fpsr;
> > +		return  kvm_vcpu_get_fpsr(vcpu);
> >  
> >  	case KVM_REG_ARM_CORE_REG(fp_regs.fpcr):
> > -		return &vcpu->arch.ctxt.fp_regs.fpcr;
> > +		return  kvm_vcpu_get_fpcr(vcpu);
> 
> Odd additional spaces (3 instances).

thanks.

> 
> >  
> >  	default:
> >  		return NULL;
> > @@ -306,6 +307,8 @@ static int set_core_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg)
> >  	return err;
> >  }
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
> >  #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
> >  #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
> > diff --git a/arch/arm64/kvm/hyp/exception.c b/arch/arm64/kvm/hyp/exception.c
> > index bef40ddb16db..82611442a2d1 100644
> > --- a/arch/arm64/kvm/hyp/exception.c
> > +++ b/arch/arm64/kvm/hyp/exception.c
> > @@ -277,6 +277,9 @@ static const u8 return_offsets[8][2] = {
> >  	[7] = { 4, 4 },		/* FIQ, unused */
> >  };
> >  
> > +#define OFFSETOF_PT_REG(__r) offsetof(struct user_pt_regs, __r)
> > +#define COMPAT_IDX(__c) ((OFFSETOF_PT_REG(__c) - OFFSETOF_PT_REG(regs[0])) / sizeof(u64))
> > +
> 
> Oh $gawd, this is... awful.
> 
> >  static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
> >  {
> >  	unsigned long spsr = *vcpu_cpsr(vcpu);
> > @@ -292,12 +295,12 @@ static void enter_exception32(struct kvm_vcpu *vcpu, u32 mode, u32 vect_offset)
> >  	switch(mode) {
> >  	case PSR_AA32_MODE_ABT:
> >  		__vcpu_write_spsr_abt(vcpu, host_spsr_to_spsr32(spsr));
> > -		vcpu_gp_regs(vcpu)->compat_lr_abt = return_address;
> > +		vcpu_gp_regs(vcpu)[COMPAT_IDX(compat_lr_abt)] = return_address;
> >  		break;
> 
> Stupid idea: why don't you simply have new #defines that make the
> register number standalone, and make ptrace.h use that? Something line
> this (which can obviously be extended to all the compat registers):
> 
> diff --git a/arch/arm64/include/asm/ptrace.h b/arch/arm64/include/asm/ptrace.h
> index 39582511ad72f..2d3d324d2598e 100644
> --- a/arch/arm64/include/asm/ptrace.h
> +++ b/arch/arm64/include/asm/ptrace.h
> @@ -104,6 +104,10 @@
>  #define COMPAT_USER_SZ	296
>  
>  /* Architecturally defined mapping between AArch32 and AArch64 registers */
> +enum aarch32_reg_mapping {
> +	__compat_lr_und = 22,
> +};
> +
>  #define compat_usr(x)	regs[(x)]
>  #define compat_fp	regs[11]
>  #define compat_sp	regs[13]
> @@ -115,7 +119,7 @@
>  #define compat_sp_svc	regs[19]
>  #define compat_lr_abt	regs[20]
>  #define compat_sp_abt	regs[21]
> -#define compat_lr_und	regs[22]
> +#define compat_lr_und	regs[__compat_lr_und]
>  #define compat_sp_und	regs[23]
>  #define compat_r8_fiq	regs[24]
>  #define compat_r9_fiq	regs[25]
> 
> and then your #defines from hell can go?

Great suggestion I do not like this macro hell myself. I'll implement it
that way. Should I convert all compat_* regs to this concept or just the
ones I need?

	Steffen

