Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794677033;
	b=prmjnf0UGNOMdBLWPZLpO2vYygqSV9iiqQYnWn15AblC6nSCq9HcvgPCCsP+iK6uvHnu
	 IcH+5s/5tBvEG1S+CfbQuat2XhNktFzBIFxju7zb7332YwqBmoWsqVTgT0z3t0/lJkwu7
	 9wmx0ahKfp7Zvf63Fy9MjZerc+yHnTR1dzZjq6Ta2nthcRscg1dRyLlwZoRObi8MZQmNK
	 s6dRyrfjYT9FUpWv2ruTnQxnrp40h2x+rxughQeX0Vghm6jvI8wt6jctEe31nukfMB1CR
	 wrJtqWEQMRXpo1pPe3lseoIWxbjTNvfRDfHkqG+i0w+HpGOgqMxqe1lJlwpViAlWhOw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794677033;
	h=Received:DKIM-Signature:Received:Date:Message-ID:From:To:Cc:Subject:
	 In-Reply-To:References:User-Agent:MIME-Version:Content-Type:
	 X-SA-Exim-Connect-IP:X-SA-Exim-Rcpt-To:X-SA-Exim-Mail-From:
	 X-SA-Exim-Scanned;
	bh=jCgnmtgOCdPYkEDmr+VTaAMsNukSPghc49+bvrtNoAA=;
	b=qkp9+rFxPNRAJ8R1qRpqdjNRwTLsXHy6HG6EHTfTyvTJYLNva7FALji7FhTutY54xxXO
	 1BtQL4YzqjI6pKqTM/sy2tUSkD2ZeQ+y23sw2uXo5T8VQqwLhlGdd6KUyBfs8mw6XwAAF
	 vQYIwgKyF+Ev8lxc5ju4RHHugKURn5Sh0Vr8bmR2KVtvyQbjrQKSXpcA7H7Cxtog5eOip
	 P6tyvIkEcSKvUklwpEJWZ1siRmPXs69sX8ekTTGJgxQckLW8RQiHWkAJXDHVQRj03Q+eq
	 e9MsbOM5uW/2fsfp2X5xRIAIWKegI4k+Q1PsN81gVIO51VHPHSLY8nICTic73fzE5Kw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVH10VSU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B805B606A329;
	Sat, 14 Nov 2026 17:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cVH10VSU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05CB21F000C4;
	Sat, 14 Nov 2026 17:23:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794677033;
	bh=jCgnmtgOCdPYkEDmr+VTaAMsNukSPghc49+bvrtNoAA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References;
	b=cVH10VSU7hl5YcDZSYF7i2POZOcTnx2uLsHfvyXL6HXXY89/pdwTo84I4mtY3aUGy
	 VGcpOEv/ycaxIsJcpg1qczl9+hr1LSfFcBDEk8WmmMimYp7bYFra3WOrXwPTIfoqhT
	 qRHO7swK1RIOrMcqmc0e1+GmzufCKoA4ZRIe0VtWGiRPZ5vXbHsRZfKo/AAbq9RDRV
	 AyhN4o10/D81jgESOZKmqOjpzpo7oJ2sOqpfNxp9+22RIns1l7ifNffcSjiYaGDFrQ
	 75D18SAdBX+bI3AqEidhNDJyiSrB4lIpbX9DBK7UjnoTu4jttoHb3muNtBO+cFW/F7
	 A7X1UiQa4EVxA==
Received: from sofa.misterjones.org ([185.219.108.64] helo=lobster-girl.misterjones.org)
	by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <maz@kernel.org>)
	id 1xSHTi-0000000Fpux-2LPy;
	Sat, 14 Nov 2026 17:23:50 +0000
Date: Sat, 14 Nov 2026 17:27:09 +0000
Message-ID: <87ik1z8gsy.wl-maz@kernel.org>
From: Marc Zyngier <maz@kernel.org>
To: Steffen Eiden <seiden@linux.ibm.com>
Cc: Oliver Upton <oupton@kernel.org>,
	Fuad Tabba <fuad.tabba@linux.dev>,
	Joey Gouly <joey.gouly@arm.com>,
	Suzuki K Poulose <suzuki.poulose@arm.com>,
	Zenghui Yu <yuzenghui@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Andreas Grapentin <gra@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Janosch Frank <frankja@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	David Hildenbrand <david@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Friedrich Welter <fritz@linux.ibm.com>,
	Gautam Gala <ggala@linux.ibm.com>,
	Hariharan Mari <hari55@linux.ibm.com>,
	Hendrik Brueckner <brueckner@linux.ibm.com>,
	Nico Boehr <nrb@linux.ibm.com>,
	Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Paolo Bonzini <pbonzini@redhat.com>,
	linux-arm-kernel@lists.infradead.org,
	kvmarm@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	linux-s390@vger.kernel.org,
	Nina Schoetterl-Glausch <nsg@linux.ibm.com>
Subject: Re: [PATCH v3 01/23] KVM: arm64: Refactor idreg caching into dedicated structure
In-Reply-To: <20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
	<20261106-sysreg-v3-1-75e95980fb10@linux.ibm.com>
User-Agent: Wanderlust/2.15.9 (Almost Unreal) SEMI-EPG/1.14.7 (Harue)
 FLIM-LB/1.14.9 (=?UTF-8?B?R29qxY0=?=) APEL-LB/10.8 EasyPG/1.0.0 Emacs/30.1
 (aarch64-unknown-linux-gnu) MULE/6.0 (HANACHIRUSATO)
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0 (generated by SEMI-EPG 1.14.7 - "Harue")
Content-Type: text/plain; charset=US-ASCII
X-SA-Exim-Connect-IP: 185.219.108.64
X-SA-Exim-Rcpt-To: seiden@linux.ibm.com, oupton@kernel.org, fuad.tabba@linux.dev, joey.gouly@arm.com, suzuki.poulose@arm.com, yuzenghui@huawei.com, catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com, gra@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, imbrenda@linux.ibm.com, david@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, svens@linux.ibm.com, fritz@linux.ibm.com, ggala@linux.ibm.com, hari55@linux.ibm.com, brueckner@linux.ibm.com, nrb@linux.ibm.com, Ulrich.Weigand@de.ibm.com, arnd@arndb.de, pbonzini@redhat.com, linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, nsg@linux.ibm.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false

On Fri, 06 Nov 2026 16:07:34 +0000,
Steffen Eiden <seiden@linux.ibm.com> wrote:
> 
> Move VM-wide ID register emulation fields from struct kvm_arch into a
> new struct kvm_vm_id_regs. The new struct is placed in a shared region.
> Update all users to use the new structure.
> 
> No functional changes.
> 
> Co-developed-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Signed-off-by: Nina Schoetterl-Glausch <nsg@linux.ibm.com>
> Co-developed-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Andreas Grapentin <gra@linux.ibm.com>
> Signed-off-by: Steffen Eiden <seiden@linux.ibm.com>
> ---
>  arch/arm64/include/asm/kvm_host.h  | 50 ++++++++++++++++++++------------------
>  arch/arm64/kvm/config.c            | 10 ++++----
>  arch/arm64/kvm/hyp/nvhe/pkvm.c     |  7 +++---
>  arch/arm64/kvm/hyp/nvhe/sys_regs.c |  4 +--
>  arch/arm64/kvm/sys_regs.c          |  2 +-
>  5 files changed, 39 insertions(+), 34 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
> index 97332ffcb130..7f051dad79c7 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -105,6 +105,25 @@ struct vcpu_reset_state {
>  	bool		reset;
>  };
>  
> +struct kvm_vm_id_regs {
> +	/*
> +	 * Emulated CPU ID registers per VM
> +	 * (Op0, Op1, CRn, CRm, Op2) of the ID registers to be saved in it
> +	 * is (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8.
> +	 *
> +	 * These emulated idregs are VM-wide, but accessed from the context of a vCPU.
> +	 * Atomic access to multiple idregs are guarded by kvm_arch.config_lock.
> +	 */
> +#define IDREG_IDX(id)		(((sys_reg_CRm(id) - 1) << 3) | sys_reg_Op2(id))
> +#define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
> +	u64 ftr_reg[KVM_ARM_ID_REG_NUM];

I'm OK with changing the name of the array, but then you need to be
consistent and change the name of the indexing macros throughout the
code. This should be a preliminary change.

> +
> +	u64 midr_el1;
> +	u64 revidr_el1;
> +	u64 aidr_el1;
> +	u64 ctr_el0;
> +};
> +
>  #endif /* ARM64_S390_COMMON == 1 */
>  
>  #define KVM_DIRTY_LOG_MANUAL_CAPS   (KVM_DIRTY_LOG_MANUAL_PROTECT_ENABLE | \
> @@ -478,22 +497,7 @@ struct kvm_arch {
>  	struct kvm_smccc_features smccc_feat;
>  	struct maple_tree smccc_filter;
>  
> -	/*
> -	 * Emulated CPU ID registers per VM
> -	 * (Op0, Op1, CRn, CRm, Op2) of the ID registers to be saved in it
> -	 * is (3, 0, 0, crm, op2), where 1<=crm<8, 0<=op2<8.
> -	 *
> -	 * These emulated idregs are VM-wide, but accessed from the context of a vCPU.
> -	 * Atomic access to multiple idregs are guarded by kvm_arch.config_lock.
> -	 */
> -#define IDREG_IDX(id)		(((sys_reg_CRm(id) - 1) << 3) | sys_reg_Op2(id))
> -#define KVM_ARM_ID_REG_NUM	(IDREG_IDX(sys_reg(3, 0, 0, 7, 7)) + 1)
> -	u64 id_regs[KVM_ARM_ID_REG_NUM];
> -
> -	u64 midr_el1;
> -	u64 revidr_el1;
> -	u64 aidr_el1;
> -	u64 ctr_el0;
> +	struct kvm_vm_id_regs id_regs;
>  
>  	/* Masks for VNCR-backed and general EL2 sysregs */
>  	struct kvm_sysreg_masks	*sysreg_masks;
> @@ -1634,19 +1638,19 @@ void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
>  bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
>  bool kvm_pkvm_vcpu_is_powered_off(struct kvm_vcpu *vcpu);
>  
> -static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
> +static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
>  {
>  	switch (reg) {
>  	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
> -		return &ka->id_regs[IDREG_IDX(reg)];
> +		return &id_regs->ftr_reg[IDREG_IDX(reg)];
>  	case SYS_CTR_EL0:
> -		return &ka->ctr_el0;
> +		return &id_regs->ctr_el0;
>  	case SYS_MIDR_EL1:
> -		return &ka->midr_el1;
> +		return &id_regs->midr_el1;
>  	case SYS_REVIDR_EL1:
> -		return &ka->revidr_el1;
> +		return &id_regs->revidr_el1;
>  	case SYS_AIDR_EL1:
> -		return &ka->aidr_el1;
> +		return &id_regs->aidr_el1;
>  	default:
>  		WARN_ON_ONCE(1);
>  		return NULL;
> @@ -1654,7 +1658,7 @@ static inline u64 *__vm_id_reg(struct kvm_arch *ka, u32 reg)
>  }
>  
>  #define kvm_read_vm_id_reg(kvm, reg)					\
> -	({ u64 __val = *__vm_id_reg(&(kvm)->arch, reg); __val; })
> +	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
>  
>  void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
>  
> diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
> index adaf26ab93b8..49bbe68c0b9e 100644
> --- a/arch/arm64/kvm/config.c
> +++ b/arch/arm64/kvm/config.c
> @@ -1467,11 +1467,11 @@ static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
>  			resx.res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
>  	}
>  
> -	val = kvm->arch.id_regs[r->idreg_idx];
> -	kvm->arch.id_regs[r->idreg_idx] &= ~resx.res0;
> -	kvm->arch.id_regs[r->idreg_idx] |= resx.res1;
> +	val = kvm->arch.id_regs.ftr_reg[r->idreg_idx];
> +	kvm->arch.id_regs.ftr_reg[r->idreg_idx] &= ~resx.res0;
> +	kvm->arch.id_regs.ftr_reg[r->idreg_idx] |= resx.res1;
>
> -	return val != kvm->arch.id_regs[r->idreg_idx];
> +	return val != kvm->arch.id_regs.ftr_reg[r->idreg_idx];
>  }
>  
>  void kvm_idregs_enforce_dependencies(struct kvm *kvm)
> @@ -1488,7 +1488,7 @@ void kvm_idregs_enforce_dependencies(struct kvm *kvm)
>  
>  static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
>  {
> -	u64 regval = kvm->arch.id_regs[map->regidx];
> +	u64 regval = kvm->arch.id_regs.ftr_reg[map->regidx];
>  	u64 regfld = (regval >> map->shift) & GENMASK(map->width - 1, 0);
>  
>  	if (map->sign) {

All this stuff should really be cleaned up by introducing the correct
level of abstraction. I have a local untested hack that does this:

diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/kvm_host.h
index ed00637f1d7a8..65d34e2da17d2 100644
--- a/arch/arm64/include/asm/kvm_host.h
+++ b/arch/arm64/include/asm/kvm_host.h
@@ -1639,11 +1639,16 @@ void kvm_arm_vcpu_power_off(struct kvm_vcpu *vcpu);
 bool kvm_arm_vcpu_stopped(struct kvm_vcpu *vcpu);
 bool kvm_pkvm_vcpu_is_powered_off(struct kvm_vcpu *vcpu);
 
+static inline u64 *__vm_ftr_reg_by_idx(struct kvm_vm_id_regs *id_regs, u32 idx)
+{
+	return &id_regs->ftr_reg[idx];
+}
+
 static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
 {
 	switch (reg) {
 	case sys_reg(3, 0, 0, 1, 0) ... sys_reg(3, 0, 0, 7, 7):
-		return &id_regs->ftr_reg[IDREG_IDX(reg)];
+		return __vm_ftr_reg_by_idx(id_regs, IDREG_IDX(reg));
 	case SYS_CTR_EL0:
 		return &id_regs->ctr_el0;
 	case SYS_MIDR_EL1:
@@ -1658,8 +1663,14 @@ static inline u64 *__vm_id_reg(struct kvm_vm_id_regs *id_regs, u32 reg)
 	}
 }
 
-#define kvm_read_vm_id_reg(kvm, reg)					\
-	({ u64 __val = *__vm_id_reg(&(kvm)->arch.id_regs, reg); __val; })
+#define kvm_get_vm_ftr_reg_by_idx(kvm, idx)					\
+	({ u64 *__valp = __vm_ftr_reg_by_idx(&(kvm)->arch.id_regs, idx); __valp; })
+
+#define kvm_get_vm_id_reg(kvm, reg)					\
+	({ u64 *__valp = __vm_id_reg(&(kvm)->arch.id_regs, reg); __valp; })
+
+#define kvm_read_vm_id_reg(kvm, reg)				\
+	({ u64 __val = *kvm_get_vm_id_reg(kvm, reg); __val; })
 
 void kvm_set_vm_id_reg(struct kvm *kvm, u32 reg, u64 val);
 
diff --git a/arch/arm64/kvm/config.c b/arch/arm64/kvm/config.c
index 399693203e934..37eae14c3924a 100644
--- a/arch/arm64/kvm/config.c
+++ b/arch/arm64/kvm/config.c
@@ -1565,7 +1565,7 @@ static const struct reg_feat_map_desc *idreg_feat_maps[] = {
 static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
 {
 	struct resx resx = {};
-	u64 val;
+	u64 val, *valp;
 
 	for (int i = 0; i < r->bit_feat_map_sz; i++) {
 		if ((r->bit_feat_map[i].flags & CALL_FUNC) &&
@@ -1573,11 +1573,12 @@ static bool idreg_apply_deps(struct kvm *kvm, const struct reg_feat_map_desc *r)
 			resx.res0 |= reg_feat_map_bits(&r->bit_feat_map[i]);
 	}
 
-	val = kvm->arch.id_regs.ftr_reg[r->idreg_idx];
-	kvm->arch.id_regs.ftr_reg[r->idreg_idx] &= ~resx.res0;
-	kvm->arch.id_regs.ftr_reg[r->idreg_idx] |= resx.res1;
+	valp = kvm_get_vm_ftr_reg_by_idx(kvm, r->idreg_idx);
+	val = *valp;
+	*valp &= ~resx.res0;
+	*valp |= resx.res1;
 
-	return val != kvm->arch.id_regs.ftr_reg[r->idreg_idx];
+	return val != *valp;
 }
 
 void kvm_idregs_enforce_dependencies(struct kvm *kvm)
@@ -1594,7 +1595,7 @@ void kvm_idregs_enforce_dependencies(struct kvm *kvm)
 
 static bool idreg_feat_match(struct kvm *kvm, const struct reg_bits_to_feat_map *map)
 {
-	u64 regval = kvm->arch.id_regs.ftr_reg[map->regidx];
+	u64 regval = *kvm_get_vm_ftr_reg_by_idx(kvm, map->regidx);
 	u64 regfld = (regval >> map->shift) & GENMASK(map->width - 1, 0);
 
 	if (map->sign) {

> diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> index fc0475f0877d..41ee83290697 100644
> --- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
> +++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
> @@ -399,7 +399,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
>  	DECLARE_BITMAP(allowed_features, KVM_VCPU_MAX_FEATURES);
>  
>  	/* CTR_EL0 is always under host control, even for protected VMs. */
> -	hyp_vm->kvm.arch.ctr_el0 = host_kvm->arch.ctr_el0;
> +	hyp_vm->kvm.arch.id_regs.ctr_el0 = host_kvm->arch.id_regs.ctr_el0;

This stuff is just terrible code, and needs to be cleaned up. It
should read something like:

diff --git a/arch/arm64/kvm/hyp/nvhe/pkvm.c b/arch/arm64/kvm/hyp/nvhe/pkvm.c
index ef936dee20ad3..ad100df6a8b0d 100644
--- a/arch/arm64/kvm/hyp/nvhe/pkvm.c
+++ b/arch/arm64/kvm/hyp/nvhe/pkvm.c
@@ -413,7 +413,7 @@ static void pkvm_init_features_from_host(struct pkvm_hyp_vm *hyp_vm, const struc
 	DECLARE_BITMAP(allowed_features, KVM_VCPU_MAX_FEATURES);
 
 	/* CTR_EL0 is always under host control, even for protected VMs. */
-	hyp_vm->kvm.arch.id_regs.ctr_el0 = host_kvm->arch.id_regs.ctr_el0;
+	*kvm_get_vm_id_reg(kvm, SYS_CTR_EL0) = kvm_read_vm_id_reg((struct kvm *)host_kvm, SYS_CTR_EL0);
 
 	/*
 	 * pKVM runs only GICv3. Anything else becomes 0, the model of a VM

Overall, I'd like to see a first patch introducing helpers that the
code uses everywhere possible, then another patch that introduces the
structure, the renaming, and changes the accessors without touching
the rest of the code.

Thanks,

	M.

-- 
Jazz isn't dead. It just smells funny.
