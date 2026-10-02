Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA31E44163B;
	Fri,  2 Oct 2026 08:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790928053; cv=none; b=uGC57HKVWRxEiUYUZPQDM6VAkC4NAydnv/ZxVSWd+AF+IGony017wV6yjc03w7wz2101guXje2MDvxdRs7Ke0jovAb/Hx7cbjQVrzqVoBTiNCM1wgOsw9/0gxiKWJEDWAxi2HnofScWw3YzjvxO2QbOvd2tWOOuREeest8yOGKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790928053; c=relaxed/simple;
	bh=hlfqSJkn81Ycv/Ivxi3j4dobgJe1/751DNUgE4YsUis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FEQpV+FaR7ZmciDjGSqobrklwOwzRbEVMBb3gcqszlQyGoP5J3vRsThZi1R+bA6+cgbO3t/jNzWyKObwRmA/OlElNSmefvXPVSntGLxw8pmgDNSiPTGi5X7fMx7wg4LivsMmHICntjYIS6bDnKHS06C78PIpAhvnDZqeHXelxKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=P+Hr4W2T; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="P+Hr4W2T"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69265a5c3917135;
	Fri, 2 Oct 2026 08:00:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=p0PPkDbty7ErKuoX9vz6zdk4YAkVKe
	+lc5QseNn0Ko8=; b=P+Hr4W2ToLByzLFfZcGMcJHuclV+C763xAeAnzgFOgxWnp
	pWLXPmnsw02u1WxXUZxY9zYBoYB8w3DnVM/DtSGIsYNaX8Q2XeohWrjId+giqBvL
	gefs0jZGoTtAzeHQBbtXJ+/yW1oFcrpvEykpu694ZAxfU2b1niFy6swPuEvW2c7L
	YDEweDjdfXB13qTDl/GeZ+iO7FU90X4PtW0hpeyTY46HytPxl8SMmzko2Bbozbal
	VjW08M6NriUlINBEYBRGhGW7xUWtQErRbkkbNOMqr6v0wBl5W/UcHsttnx+VV80m
	GG52oKRiV5zQfey3aLzCBrzzqQ0gcQn4sF3ETU+A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5s5r2vk-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:00:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69262eqd2076646;
	Fri, 2 Oct 2026 08:00:22 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h0xcshy6c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 02 Oct 2026 08:00:21 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69280Hvq30212440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 2 Oct 2026 08:00:18 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D395D2004E;
	Fri,  2 Oct 2026 08:00:17 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BC5EF20043;
	Fri,  2 Oct 2026 08:00:16 +0000 (GMT)
Received: from osiris (unknown [9.87.132.225])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Fri,  2 Oct 2026 08:00:16 +0000 (GMT)
Date: Fri, 2 Oct 2026 10:00:15 +0200
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
        Sean Christopherson <seanjc@google.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will@kernel.org>,
        Zenghui Yu <yuzenghui@huawei.com>, Fuad Tabba <fuad.tabba@linux.dev>
Subject: Re: (subset) [PATCH v9 00/24] KVM: s390: Introduce arm64 KVM
Message-ID: <20261002080015.22510-A-seiden@linux.ibm.com>
References: <20260930173441.66762-1-seiden@linux.ibm.com>
 <179085262878.3865846.5787241839391727949.b4-ty@b4>
 <20261001132715.108643-A-seiden@linux.ibm.com>
 <86wls1315l.wl-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86wls1315l.wl-maz@kernel.org>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfX6TTjafE+zJw/
 8IOaDmVbWDcj3fnvYRUKSZmSyPSYC1WIM1utUezfe6ZqcnsDGVAfJmIg8txkrBIouGed3/yEyUA
 +/hGiM5q3QeSXuXvavDUJ84pYEoya/s=
X-Authority-Analysis: v=2.4 cv=HJ5WhYtv c=1 sm=1 tr=0 ts=6abf6497 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=oxOeRRTydUpBoHNR5nMA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-GUID: EP_6xC35w4LYshj_KR8G9Ra7L-auzk1s
X-Proofpoint-ORIG-GUID: ay7HdBwUIxDlv8jnNezyMkEYZ5PrxwQt
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDAzMCBTYWx0ZWRfX/zOtryu/PAoy
 u7oRYSKzJ6rwE0J3so7nc3C2XtU+bC4IT68zcOhGHfu2LJQua2RonwGZblhNH16odNb7944nUYS
 oyKyBt10wL3kC82+PL1/o+R047CDaivfNu1pJKM2tqYlL16657qBEONEp+v3FwryrwPuTX0S7tb
 EfGEh7FriG3LXB7MNajU7eKyIA9sl2UscPzMOg8/ZHzlpENYSPOvfUvhVD1pGgJ4PoKURz/U98E
 16MRnYxnnp9yAIqsoV2wGYiru3TWvr6X6KJt0pchKXd42pxzvW41Hh7cYtOoGHzfcc0Gg8B724N
 IWL1x902hHWn64KuE+EEH7FxrusaC1Q9YqGBQjVjRpmMFXURYbCoMhFRawVj1ELvk5HGAKtOiQ7
 c5ueik/J1ir5to+uydKkTkUYiQLWG4scqJCLlQOhm41nFB1WndowEw7r8NIULOhcfZPJvAnOSf9
 gOpDwkD4W1yXh5UaQPA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_02,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 bulkscore=0 clxscore=1015 lowpriorityscore=0
 spamscore=0 impostorscore=0 phishscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020030

On Thu, Oct 01, 2026 at 04:12:38PM +0100, Marc Zyngier wrote:
> On Thu, 01 Oct 2026 14:27:15 +0100,
> Steffen Eiden <seiden@linux.ibm.com> wrote:
> > 
> > On Thu, Oct 01, 2026 at 12:04:51PM +0100, Marc Zyngier wrote:
> > > On Wed, 30 Sep 2026 19:34:15 +0200, Steffen Eiden wrote:
> > > > Introduce arm-on-s390. Enable KVM-accelerated ARM CPU virtualisation on s390.
> > > > 
> > > > The new KVM functionally depends on KVM/vfio: Use file-based reference
> > > > counting for KVM [5] The series itself should apply w/o those.
> > > > 
> > > > For the original, now partially outdated, cover letter, have a look at versions
> > > > one to three [1].
> > > > 
> > > > [...]
> > > 
> > > Applied to next, thanks!
> > > 
> > > [05/24] arm64: ptrace: Use constants for compat register numbers
> > >         commit: 295d3df9b1e425099a4eb37954a02c4a08fdb496
> > > [06/24] arm64: sysreg: Convert SPSR_ELx to automatic register generation
> > >         commit: d3d78520068779779e1ed7aa0dd8a3ce63e1ca43
> > > [07/24] KVM: arm64: Access elements of vcpu_gp_regs individually
> > >         commit: 29d92585ab987bb80b1e78d811aaea2a8db86e62
> > > [08/24] KVM: arm64: Use accessor functions for core regs
> > >         commit: 89ed62818f10e38e64fea46d43ee6455a1beb647
> > > [09/24] arm64: Prepare sharing arm64 headers with s390
> > >         commit: df6a70516adec8b7f5fa49e1755d8ee33d980d9c
> > > [10/24] arm64: Share arm64 headers with s390
> > >         commit: c7e18ba462536e870b0ff4deca581babcac9135b
> > > [11/24] KVM: arm64: Share arm64 code with s390
> > >         commit: dcb776bfcccc9662001a75b99dbfbef55f46eb31
> > > 
> > > Note that there were a few conflicts. Please check that I resolved
> > > them correctly.
> > 
> > 
> > After rebasing on those the arm-on-s390 part does not build anymore :( 
> 
> Well, that's sort of expected. The kvmarm tree doesn't have the S390
> stuff yet, and contains tons of new stuff.
>

yes, but sometimes I like to dream 

> > We are missing the definition of
> > static __always_inline bool esr_abt_is_s1ptw(unsigned long esr)
> > 
> > 
> > quick fix: 
> > 
> > on top of [10/24]  arm64: Share arm64 headers with s390
> > 
> > diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/asm/kvm_emulate.h
> > index bf35cbe8ddcb..0708f792c631 100644
> > --- a/arch/arm64/include/asm/kvm_emulate.h
> > +++ b/arch/arm64/include/asm/kvm_emulate.h
> > @@ -367,10 +367,13 @@ static __always_inline u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
> >         return vcpu->arch.fault.esr_el2;
> >  }
> > 
> > +#if ARM64_S390_COMMON == 1
> >  static __always_inline bool esr_abt_is_s1ptw(unsigned long esr)
> >  {
> >         return esr & ESR_ELx_S1PTW;
> >  }
> > +
> > +#endif /* ARM64_S390_COMMON == 1 */
> > 
> >  static __always_inline bool esr_abt_is_exec_fault(unsigned long esr)
> >  {
> > 
> > 
> > 
> > A cleaner solution it to move this defenition just below  
> > void kvm_vcpu_wfi(struct kvm_vcpu *vcpu) in 
> > [09/24] arm64: Prepare sharing arm64 headers with s390
> > and expand the shared region in the following patch.
> 
> I'm redoing the merge and fixing it as follows (note that the
> ARM64_S390_COMMON guards are already present):
> 
> @@ -336,16 +367,6 @@ static __always_inline u64 kvm_vcpu_get_esr(const struct kvm_vcpu *vcpu)
>  	return vcpu->arch.fault.esr_el2;
>  }
>  
> -static __always_inline bool esr_abt_is_s1ptw(unsigned long esr)
> -{
> -	return esr & ESR_ELx_S1PTW;
> -}
> -
> -static __always_inline bool esr_abt_is_exec_fault(unsigned long esr)
> -{
> -	return esr_trap_is_iabt(esr) && !esr_abt_is_s1ptw(esr);
> -}
> -
>  static inline bool guest_hyp_wfx_traps_enabled(const struct kvm_vcpu *vcpu)
>  {
>  	u64 esr = kvm_vcpu_get_esr(vcpu);
> @@ -389,6 +410,12 @@ static inline u64 kvm_vcpu_get_disr(const struct kvm_vcpu *vcpu)
>  	return vcpu->arch.fault.disr_el1;
>  }
>  
> +#if ARM64_S390_COMMON == 1
> +static __always_inline bool esr_abt_is_s1ptw(unsigned long esr)
> +{
> +	return esr & ESR_ELx_S1PTW;
> +}
> +
>  static inline u32 kvm_vcpu_hvc_get_imm(const struct kvm_vcpu *vcpu)
>  {
>  	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_xVC_IMM_MASK;
> @@ -456,6 +483,13 @@ static __always_inline u8 kvm_vcpu_trap_get_fault(const struct kvm_vcpu *vcpu)
>  	return kvm_vcpu_get_esr(vcpu) & ESR_ELx_FSC;
>  }
>  
> +#endif /* ARM64_S390_COMMON == 1 */
> +
> +static __always_inline bool esr_abt_is_exec_fault(unsigned long esr)
> +{
> +	return esr_trap_is_iabt(esr) && !esr_abt_is_s1ptw(esr);
> +}
> +
>  static inline
>  bool kvm_vcpu_trap_is_permission_fault(const struct kvm_vcpu *vcpu)
>  {
>
> 
> Does this work for you?
>

Yes the positioning of the functions look good. It builds on top of
kvmarm/next + this (sightly relocated (line numbes are different) patch
+ arm on s390 stuff.

I'll work on a verification tool for you guys to make this process
easier.

Thank you.

	Steffen

