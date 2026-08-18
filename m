Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F150B224B13;
	Tue, 18 Aug 2026 14:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787062173; cv=none; b=VWyBhnA5u157iOOP0J/Dm3K47Ph3H36OScLcfUEWsPjkj/hb0Mu9eoeNWBxQeLcSYXOqXnmDoe6oC/QROHdfaIoIR3214DY4b34Pz+Rv6uIySm8kdhlFxAm+reQ2bf3B9ZPQU1mfUJP9TgM36BYWzXTWBBciCP8K3I0s/ePW2ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787062173; c=relaxed/simple;
	bh=TPTG8NwpCU9hVjLq9f9CqE3u04NvoQcnRrqhz9uZdSs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VXdeq/1lKFDLo/kgXORFnJRP+zbLbJxJ4ro+Q6iFeIJqTfYHtZenWUJ4cCwuzJCeOk8y5pfwXUKmBN1Zuk7Sycsuf39rnN0tcKMuCgw9zTQc0XtV4uU4lRcuI/bzNNUHxvsYN8bIeMzcOWIbsdahEqvsH+v4YkZSWrf2DJ9aPqo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=L9Z9D2Uj; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="L9Z9D2Uj"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3ef93582570;
	Tue, 18 Aug 2026 14:09:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=6pp6IeSNyuloHhvHuC8eQqDE/bAvUg
	2z+EMprgQBhEI=; b=L9Z9D2Uj4VDkqmT6R6A9de/RM8yuwwS1zxLJc28hM443VF
	7pUJyYi7HP/UDGR1NixISAMJzJUOvq5vSSeMFJFmWmboNAltdA16o39uxkQwwGR0
	Ga8bYcWTP+77IPMTGUQzQVwbaiD9wJqGhQlqjZXQa0qXctkgZCrTbKnPZtus5M4M
	7cKOhSGfh2vGFBHPxluzlr4sE1e+KesdzFfW+23ljtfM45B4Hn4y9PJvJEBP8jdc
	/dt6abmK8qmkUQpRKbNbthfucgDO7qf+Om9/H0ef8ohj+9VX2rmy+NsqjglEze+Z
	FreLng1EgqxcoBCctelsqD+5AZYErhUVQ4sgb5gg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe8a1w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:09:08 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IDxdst011427;
	Tue, 18 Aug 2026 14:09:07 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g354ybb6s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:09:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IE93Ck15728970
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:09:03 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 400B320043;
	Tue, 18 Aug 2026 14:09:03 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C5E322004B;
	Tue, 18 Aug 2026 14:09:02 +0000 (GMT)
Received: from osiris (unknown [9.224.76.185])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Aug 2026 14:09:02 +0000 (GMT)
Date: Tue, 18 Aug 2026 16:09:01 +0200
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
        Friedrich Welter <fritz@linux.ibm.com>, Fuad Tabba <tabba@google.com>,
        Gautam Gala <ggala@linux.ibm.com>,
        Hariharan Mari <hari55@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Hendrik Brueckner <brueckner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>, Joey Gouly <joey.gouly@arm.com>,
        Nico Boehr <nrb@linux.ibm.com>,
        Nina Schoetterl-Glausch <oss@nina.schoetterlglausch.eu>,
        Oliver Upton <oupton@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>
Subject: Re: [PATCH v6 10/33] arm64: Share arm64 headers with s390
Message-ID: <20260818140901.21865-F-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-11-seiden@linux.ibm.com>
 <865x1e17kb.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <865x1e17kb.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX+S0b8sWde/7X
 Epl6rQJtU09xy3YsJjzb0l1P0YvKvrSci2EJjodXlAF7AcYORLdmXkrqzaSX9DrHa7gYNz0wSWQ
 qSZbDgFQ2Soh/r2kojTLOk0oS5ieFgCwK41UI670QC1N4i8GiaOVK1aC7sqcHYjttd5vnVxFOHC
 OakRTPXPFROxAUPC4ug/H5QE6NWZBlf0svwTEPsUlethDgbvE99YCddxuXbsS0WKyVzANz4nqxb
 oYY1o0ens4Mya0M1yKGxM97jX0ifArpuQzFTSjMGDjTSKnaHJ1BpZHqann8RCJedjetnVfgEhYV
 8k5+zEpuo1ksCtBqeFmZ6hq5H4JfrhGFYG8Tzg9pEK/474Ja6iO3Q0DtQWEEhjl8C+7WopLq0iN
 j3FoB3+G1MRW1oKDRwdaaFx1+FxbjWJYYz2PqHOuHSipxYoMQdnaO9dgITX2ikTZrJBIGJXCaJF
 wbDX+lSA22CoF7Ne3Nw==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a846784 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=b29rCS0n7jCfI3c0AuMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: Hrg-rbPVCram5u3eKpOh0Yh0yCIAJVyQ
X-Proofpoint-GUID: iK7_tgK7xwr2kuhDrfqwzUg5EW0dLA27
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwMyBTYWx0ZWRfX5ZC2fpZ2vCDs
 AYwZoUuM64qLhHFbxK5SRavAJ5dbsu5C8t0kZk33Ltz4CJRPihCJ8JxL5P7bPbaA7VXt8A5h/39
 BKlSV+O46RWD5cMmHvf8OTTzYHeTwsM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180103

On Thu, Aug 13, 2026 at 02:19:48PM +0100, Marc Zyngier wrote:
> On Wed, 12 Aug 2026 16:36:06 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Allow sharing of arm64 headers with s390 by marking the shared regions
> > or add a comment that the whole file is shared.
> > 
> > The shared regions are marked with:
> > 
> >  #ifdef ARM64_S390_COMMON
> > 
> >  /* insert shared definitions here */
> > 
> >  #endif /* ARM64_S390_COMMON */
> > 
> > The preprocessor symbol ARM64_S390_COMMON is always defined for arm64.
> > s390 later will generate its own view of arm64 headers based on the
> > content inside the ifdef/endif block.
> > 
> > No functional change.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/arm64/Makefile                  |  2 ++
> >  arch/arm64/include/asm/brk-imm.h     |  1 +
> >  arch/arm64/include/asm/esr.h         |  1 +
> >  arch/arm64/include/asm/kvm_arm.h     |  1 +
> >  arch/arm64/include/asm/kvm_emulate.h | 18 ++++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h    | 20 ++++++++++++++++++++
> >  arch/arm64/include/asm/ptrace.h      |  4 ++++
> >  arch/arm64/include/asm/sysreg.h      | 15 +++++++++++++++
> >  8 files changed, 62 insertions(+)
> > 

...

> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index a34a9417ff4d..09f04a5686a1 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
> >  int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
> >  int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
> >  
> > +#ifdef ARM64_S390_COMMON
> >  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
> >  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);
> >  int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr);
> > @@ -62,6 +63,8 @@ static inline int kvm_inject_sea_iabt(struct kvm_vcpu *vcpu, u64 addr)
> >  	return kvm_inject_sea(vcpu, true, addr);
> >  }
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  static inline int kvm_inject_serror(struct kvm_vcpu *vcpu)
> >  {
> >  	/*
> > @@ -185,6 +188,7 @@ static inline void vcpu_set_thumb(struct kvm_vcpu *vcpu)
> >  	*vcpu_cpsr(vcpu) |= PSR_AA32_T_BIT;
> >  }
> >  
> > +#ifdef ARM64_S390_COMMON
> >  /*
> >   * vcpu_get_reg and vcpu_set_reg should always be passed a register number
> >   * coming from a read of ESR_EL2. Otherwise, it may give the wrong result on
> > @@ -203,6 +207,8 @@ static __always_inline void vcpu_set_reg(struct kvm_vcpu *vcpu, u8 reg_num,
> >  		vcpu_gp_regs(vcpu)[reg_num] = val;
> >  }
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  static inline bool vcpu_is_el2_ctxt(const struct kvm_cpu_context *ctxt)
> >  {
> >  	switch (ctxt->regs.pstate & (PSR_MODE32_BIT | PSR_MODE_MASK)) {
> > @@ -405,6 +411,7 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
> >  	return vcpu->arch.fault.disr_el1;
> >  }
> >  
> > +#ifdef ARM64_S390_COMMON
> >  static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
> >  {
> >  	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
> > @@ -482,6 +489,8 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
> >  	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
> >  }
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  static inline
> >  bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
> >  {
> > @@ -522,6 +531,7 @@ static __always_inline int kvm_vcpu_sys_get_rt(struct kvm_vcpu *vcpu)
> >  	return ESR_ELx_SYS64_ISS_RT(esr);
> >  }
> >  
> > +#ifdef ARM64_S390_COMMON
> 
> I'm curious about the reasons for skipping a bunch of architectural
> helpers:
> 
> - kvm_vcpu_trap_is_permission_fault()
we need the s390 state for this function -> we overload it
the only use is in shared arm64 code for is_write_fault
> - kvm_vcpu_trap_is_translation_fault()
> - kvm_vcpu_trap_get_perm_fault_granule()
> - kvm_vcpu_abt_issea()
as s390 mm works differntly in comparison to ARMs (suprise :) )
we do not need those


> - kvm_vcpu_sys_get_rt()
I'll add using this function in the next series (sysreg enablement)
I can do that now - It reduces the churn to the next series.

> 
> I really think you should include anything that is exclusively derived
> from architectural state, specially that these helpers are strictly
> dependent on stuff you already include.
> 
> Any particular reason why this isn't the case?

These functions operate right at the border where the s390 architectural
state (host view) and the arm64 architectural state (guest view) meet.

Especially, for the memory management of the guest we need to use
s390 based guest memory management (gmap) as the host only knows s390
(+SAE & friends to actually run an arm64 guest)

The s390 host work here is to convert the s390-state into arm64 state
for the guest. e.g. convert a s390 translation fault into a data abort (if
applicable)

The code in the second series should make this more
clear. As we now are clear on the code-sharing concept I will sent a
respin of the second series using the new sharing approach ASAP.


> 
> >  static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
> >  {
> >  	if (kvm_vcpu_abt_iss1tw(vcpu)) {
> > @@ -546,6 +556,8 @@ static inline bool kvm_is_write_fault(struct kvm_vcpu *vcpu)
> >  	return kvm_vcpu_dabt_iswrite(vcpu);
> >  }
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  static inline unsigned long kvm_vcpu_get_mpidr_aff(struct kvm_vcpu *vcpu)
> >  {
> >  	return __vcpu_sys_reg(vcpu, MPIDR_EL1) & MPIDR_HWID_BITMASK;
> > @@ -587,6 +599,7 @@ static inline bool kvm_vcpu_is_be(struct kvm_vcpu *vcpu)
> >  	return vcpu_read_sys_reg(vcpu, r) & bit;
> >  }
> >  
> > +#ifdef ARM64_S390_COMMON
> 
> Similarly, you have dropped
> 
> - kvm_vcpu_set_be()
> 
> - kvm_vcpu_is_be()
> 
> I suspect that your implementation is LE only (it'd better be, as
> we're dropping BE support right now), but it would make a lot more
> sense if you could rely on the guest architectural state (which must
> be accurate) rather than short-cutting things in your own
> implementation.

Yes, you are right we are LE only. Therefore, I defined the function to
false such that the compiler/linker can optimize-out unreachable code.
This is true for a couple of function-shortcuts.

I would like to keep it that way if this is no show stopper for you.


...

> > diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> > index 22770c1132cb..e6b3d42abb08 100644
> > --- a/arch/arm64/include/asm/kvm_host.h
> > +++ b/arch/arm64/include/asm/kvm_host.h
> > @@ -39,6 +39,7 @@
> >  
> >  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
> >  
> > +#ifdef ARM64_S390_COMMON
> >  #define KVM_VCPU_MAX_FEATURES 10
> >  #define KVM_VCPU_VALID_FEATURES	(BIT(KVM_VCPU_MAX_FEATURES) - 1)
> >  
> > @@ -86,6 +87,8 @@
> >  /* Unhandled SEAs are taken to userspace */
> >  #define KVM_ARCH_FLAG_EXIT_SEA				11
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
> >  				     KVM_DIRTY_LOG_INITIALLY_SET)
> >  
> > @@ -836,6 +839,8 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
> >  extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
> >  #define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
> >  
> > +#ifdef ARM64_S390_COMMON
> > +
> >  struct vcpu_reset_state {
> >  	unsigned long	pc;
> >  	unsigned long	r0;
> > @@ -843,6 +848,8 @@ struct vcpu_reset_state {
> >  	bool		reset;
> >  };
> >  
> > +#endif /* ARM64_S390_COMMON */
> 
> Given that this is a standalone structure without any dependency,
> could you simply move it to a "nicer" place as part of the reshuffling
> patch?
> 

Yes, no problem.

I just wanted to limit the number of moves. I'll guess we will meet in
the middle somewhere :) 


...

> > @@ -1248,6 +1259,8 @@ int kvm_arm_set_reg(struct kvm_vcpu *vcpu, const struct kvm_one_reg *reg);
> >  unsigned long kvm_arm_num_sys_reg_descs(struct kvm_vcpu *vcpu);
> >  int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *vcpu, u64 __user *uindices);
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  int __kvm_arm_vcpu_get_events(struct kvm_vcpu *vcpu,
> >  			      struct kvm_vcpu_events *events);
> >  
> > @@ -1326,6 +1339,7 @@ int __init populate_nv_trap_config(void);
> >  
> >  void kvm_calculate_traps(struct kvm_vcpu *vcpu);
> >  
> > +#ifdef ARM64_S390_COMMON
> >  /* MMIO helpers */
> >  void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data);
> >  unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
> > @@ -1333,6 +1347,8 @@ unsigned long kvm_mmio_read_buf(const void *buf, unsigned int len);
> >  int kvm_handle_mmio_return(struct kvm_vcpu *vcpu);
> >  int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t fault_ipa);
> >  
> > +#endif /* ARM64_S390_COMMON */
> 
> Similarly, it'd be marginally better if you moved some of these
> prototypes together, as below (untested).
> 

Will do.

	Steffen

...
