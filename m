Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 452A03F12DF;
	Fri, 10 Jul 2026 09:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677297; cv=none; b=Ve1YoXJ/Biqv93aqTvpxaAcJu0Kdi7geqgESPG79j/NF4YWMqWH3S0DqVVNMTGy5NEzzE0Ud4VPqfQAR8RlLL1Kt6sFNGUAyeAAvzP68X8euGLKdenSlNrTqwyDEThztlcsuTLR4j3aKJwP6wVKadHu/Sg1xeF+Bz8CedlrtiCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677297; c=relaxed/simple;
	bh=f0LF6EtHzVjMNUCuQP8ONBMBUxNXd9skfsh8Xir2itM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tOsfeXUuGBSxx7JjzPUBEhc8Ao9SHcg2L2risvBwtO84AdtTJw9uLarW0brgJsOaVEuED6o5FOUt6KT0V4Jj1Y01ca5lYJy2J0qisTDOC1tydRyXY6ytZgpfTBliVqhf1xFt8vyHnGY910vAAjHqK5uPjvopH/3s4+8cG6/onyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=hxS4Kj/0; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="hxS4Kj/0"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66A7ma1W605539;
	Fri, 10 Jul 2026 09:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=Vw3LDl3Cthd/R/noN4kr8e2c2V+Exi
	ANntAoAxdwi00=; b=hxS4Kj/0SG6WM+5KQWVR/LHVJ0lwXW1KBknI8OvSNVD85l
	nnyGz9ITzuNVtyPqulBOaRSLEKcXGolQ1+GDNbeqkMf3RR03Ac5M5LyzwkZ+hu93
	mKbaPiCY8shQpSxO5/773b86Av8zfSiBKcIRozXSGg4Fsz0dIu7o5hSBboB3UHNt
	8p9gz9jC0M14qmT93ngAAq1oCFwydUkRiDl6LYVbffJG29jGVCTP5MPz1uEuRSv6
	DynE/eJI0YFsS5VRNpjWJ/zb801ChX4D8gcOEymDjMCeUu4oXJXeeRP5w8IRlWdP
	seKaKUNxCARIoKfp1CiOagy6hpW4EFORjqBYvtcw==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qknwe3n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:54:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66A9nfUN004961;
	Fri, 10 Jul 2026 09:54:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7e0hsadk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 10 Jul 2026 09:54:35 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66A9sSHd40042902
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 Jul 2026 09:54:28 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6CA6A2004B;
	Fri, 10 Jul 2026 09:54:28 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 89FAD20043;
	Fri, 10 Jul 2026 09:54:27 +0000 (GMT)
Received: from osiris (unknown [9.87.147.219])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri, 10 Jul 2026 09:54:27 +0000 (GMT)
Date: Fri, 10 Jul 2026 11:54:26 +0200
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
Subject: Re: [PATCH v4 07/27] arm64: Prepare sharing arm64 headers with s390
Message-ID: <20260710095426.984749-F-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-8-seiden@linux.ibm.com>
 <878q7n7qzi.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <878q7n7qzi.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a50c15b cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=kj9zAlcOel0A:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=vsfpsYCfe5RcM17dGcoA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: MswuiDxkc9j4TY9wZyb_cxruE6NSFssh
X-Proofpoint-ORIG-GUID: MswuiDxkc9j4TY9wZyb_cxruE6NSFssh
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX0rZZO/S8kOE6
 j+GbX4hjZ1VXbfZu1nUT8XGNkqe0q5MNVqqODGlbrXZ0kqJiQyZ8yZVkthB/iCMOcL0OWycuG5Q
 IOKNUu7gQoTsqz78Y2u5nvpO1krzh6o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDA5NiBTYWx0ZWRfX5JgZQIA2d/yR
 8NqgVw/psDGwh6XaHto4aN7LEWFc6foVALdwGwq60h6vYwmMyGcbVSvZNava+Md0TuEsVXmHkOp
 pKdOXQXsCgora9Fu4mTVCM516uLPXxL083gkQiyo7rMd0X3gVBCqGAdpZROHa47U25VkAYlcCTj
 wi2tGjERCqNkNVuBEReuQ2v+3KH6CzIzBl1rDqsu430OZnrcd9vvQxKokow7KzNr77mTx1eLFiV
 OxtYhgbieSKhlUI/+QBec8KMW6GB1OTghcRXAKoMHXyPlGvaMQC3AKb69Q7iil05FQcBACaAgbQ
 MF70xPueF1Z0MqQxLWNFli7kDHwi2Y4/ui+k27cTF1YpV6JAtX6SZSgm9I8WOEuEpX8ZDrSub1p
 CEPTKmj6OfabD3YRFxpWm8fDV0VHIIM0LlODAonTDSPuXBK5II3B3bcSVenDyz9diKwpN+4wi+Q
 rSfWOKt1kNaMQ8cQ3VA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_02,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100096

On Mon, Jul 06, 2026 at 10:22:41PM +0100, Marc Zyngier wrote:
> On Mon, 06 Jul 2026 09:52:07 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > Prepare the sharing of arm64 headers with s390 by marking the shared
> > regions or add a comment that the whole file is shared.
> > The regions are marked with:
> > 
> >  #define ARM64_S390_COMMON
> > 
> >  /* insert shared definitions here */
> > 
> >  #endif /* ARM64_S390_COMMON */
> > 
> > The preprocessor symbol ARM64_S390_COMMON is always defined for arm64.
> > Reduce the include scope where possible and beneficial for s390.
> > No functional change.
> > 
> > Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> > ---
> >  arch/arm64/Makefile                  |  2 ++
> >  arch/arm64/include/asm/brk-imm.h     |  1 +
> >  arch/arm64/include/asm/esr.h         |  5 +++--
> >  arch/arm64/include/asm/kvm_arm.h     |  6 ++++--
> >  arch/arm64/include/asm/kvm_emulate.h | 19 ++++++++++++++++++
> >  arch/arm64/include/asm/kvm_host.h    | 28 +++++++++++++++++++++++++++
> >  arch/arm64/include/asm/kvm_mmu.h     |  6 ++++++
> >  arch/arm64/include/asm/ptrace.h      |  9 +++++++++
> >  arch/arm64/include/asm/sysreg.h      | 29 +++++++++++++++++++++++++---
> >  9 files changed, 98 insertions(+), 7 deletions(-)
> > 

...

> >  		vcpu_set_flag((v), e);					\
> >  	} while (0)
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> 
> It'd be worth looking at an initial patch reorganising this file to
> minimise the number of such markers. This is equally valid for other
> files in this patch.
> 
> [...]
> 

So it is fine if I reorganize files a bit to reduce the number of
markes?
I feared it would not. I will reorganize the files a bit then if this
reduces the number of sections. Also if some thiings are required in a
later series I might alreaddy share the stuff if possible if that
reduces the number of regions.


> > diff --git a/arch/arm64/include/asm/kvm_mmu.h b/arch/arm64/include/asm/kvm_mmu.h
> > index 6eae7e7e2a68..b782cae771fe 100644
> > --- a/arch/arm64/include/asm/kvm_mmu.h
> > +++ b/arch/arm64/include/asm/kvm_mmu.h
> > @@ -142,12 +142,15 @@ static __always_inline unsigned long __kern_hyp_va(unsigned long v)
> >  
> >  extern u32 __hyp_va_bits;
> >  
> > +#ifdef ARM64_S390_COMMON
> >  /*
> >   * We currently support using a VM-specified IPA size. For backward
> >   * compatibility, the default IPA size is fixed to 40bits.
> >   */
> >  #define KVM_PHYS_SHIFT	(40)
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #define kvm_phys_shift(mmu)		VTCR_EL2_IPA((mmu)->vtcr)
> >  #define kvm_phys_size(mmu)		(_AC(1, ULL) << kvm_phys_shift(mmu))
> >  #define kvm_phys_mask(mmu)		(kvm_phys_size(mmu) - _AC(1, ULL))
> > @@ -178,9 +181,12 @@ void stage2_unmap_vm(struct kvm *kvm);
> >  int kvm_init_stage2_mmu(struct kvm *kvm, struct kvm_s2_mmu *mmu, unsigned long type);
> >  void kvm_uninit_stage2_mmu(struct kvm *kvm);
> >  void kvm_free_stage2_pgd(struct kvm_s2_mmu *mmu);
> > +#ifdef ARM64_S390_COMMON
> >  int kvm_phys_addr_ioremap(struct kvm *kvm, phys_addr_t guest_ipa,
> >  			  phys_addr_t pa, unsigned long size, bool writable);
> 
> This only serves a purpose for GICv2, and I really hope your HW will
> not implement this. You should probably find a way to avoid dragging
> stuff that doesn't make sense on s390.
> 

good catch, I added this as a mistake. It was a leftover from the early
days.


...

> > +#ifdef ARM64_S390_COMMON
> > +
> >  /*
> >   * Instructions for modifying PSTATE fields.
> >   * As per Arm ARM for v8-A, Section "C.5.1.3 op0 == 0b00, architectural hints,
> > @@ -91,8 +99,6 @@
> >   */
> >  #define pstate_field(op1, op2)		((op1) << Op1_shift | (op2) << Op2_shift)
> >  #define PSTATE_Imm_shift		CRm_shift
> > -#define ENCODE_PSTATE(x, r)		(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
> > -#define SET_PSTATE(x, r)		__emit_inst(ENCODE_PSTATE(x, r))
> >  
> >  #define PSTATE_PAN			pstate_field(0, 4)
> >  #define PSTATE_UAO			pstate_field(0, 3)
> > @@ -100,6 +106,11 @@
> >  #define PSTATE_DIT			pstate_field(3, 2)
> >  #define PSTATE_TCO			pstate_field(3, 4)
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> > +#define ENCODE_PSTATE(x, r)		(0xd500401f | PSTATE_ ## r | ((!!x) << PSTATE_Imm_shift))
> > +#define SET_PSTATE(x, r)		__emit_inst(ENCODE_PSTATE(x, r))
> > +
> >  #define SET_PSTATE_PAN(x)		SET_PSTATE((x), PAN)
> >  #define SET_PSTATE_UAO(x)		SET_PSTATE((x), UAO)
> >  #define SET_PSTATE_SSBS(x)		SET_PSTATE((x), SSBS)
> > @@ -123,6 +134,8 @@
> >  #define GSB_SYS_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 0, 31)
> >  #define GSB_ACK_BARRIER_INSN		__SYS_BARRIER_INSN(1, 0, 12, 0, 1, 31)
> 
> What is the reason to avoid dragging these definitions? They seem
> extremely similar to the rest.
> 

They emit arm64 instructions, dont they?

> >
> > +#ifdef ARM64_S390_COMMON
> > +
> >  /* Data cache zero operations */
> >  #define SYS_DC_ISW			sys_insn(1, 0, 7, 6, 2)
> >  #define SYS_DC_IGSW			sys_insn(1, 0, 7, 6, 4)
> > @@ -835,6 +848,8 @@
> >  #define SCTLR_ELx_A	 (BIT(1))
> >  #define SCTLR_ELx_M	 (BIT(0))
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #ifdef CONFIG_CPU_BIG_ENDIAN
> >  #define ENDIAN_SET_EL2		SCTLR_ELx_EE
> >  #else
> > @@ -869,6 +884,8 @@
> >  	 SCTLR_EL1_LSMAOE | SCTLR_EL1_nTLSMD | SCTLR_EL1_EIS   | \
> >  	 SCTLR_EL1_TSCXT  | SCTLR_EL1_EOS)
> >  
> > +#ifdef ARM64_S390_COMMON
> > +
> >  /* MAIR_ELx memory attributes (used by Linux) */
> >  #define MAIR_ATTR_DEVICE_nGnRnE		UL(0x00)
> >  #define MAIR_ATTR_DEVICE_nGnRE		UL(0x04)
> > @@ -1105,6 +1122,8 @@
> >  #define GICV5_GICR_CDNMIA_TYPE_MASK	GENMASK_ULL(31, 29)
> >  #define GICV5_GICR_CDNMIA_ID_MASK	GENMASK_ULL(23, 0)
> >  
> > +#endif /* ARM64_S390_COMMON */
> > +
> >  #define gicr_insn(insn)			read_sysreg_s(GICV5_OP_GICR_##insn)
> >  #define gic_insn(v, insn)		write_sysreg_s(v, GICV5_OP_GIC_##insn)
> >  
> > @@ -1254,6 +1273,8 @@
> >  	par;								\
> >  })
> >  
> > +#ifdef ARM64_S390_COMMON
> > +
> >  #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
> >  
> >  #define SYS_FIELD_GET(reg, field, val)		\
> > @@ -1266,6 +1287,8 @@
> >  		 FIELD_PREP(reg##_##field##_MASK,	\
> >  			    SYS_FIELD_VALUE(reg, field, val))
> >  
> > -#endif
> > +#endif /* ARM64_S390_COMMON */
> > +
> > +#endif /* __ASSEMBLER__ */
> >  
> >  #endif	/* __ASM_SYSREG_H */
> 
> Overall, the fine-grained tagging is a bit hard to read, and there is
> no obvious rationale on why some bits are needed, and not others are
> not.
>

Sometimes the reason that it is not used is that they are not used yet
but will in a later series. I defenitely can add a few more function
that we need right now to reduce the scatter.

> It definitely looks more manageable than the previous iteration, but
> as I said above, it would benefit from a less scattergun approach.
That is great to hear!

I tried to move as little arm code as possible. This is probably the
other extreme compared to the first attempts where I moved everything.
I will try out moving a few functions/defenitions inside the
headers/functions to resuce the scattering.

	Steffen

