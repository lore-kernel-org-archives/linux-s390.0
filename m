Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795790163;
	b=oMdMjW05FB9ePrJasqqqGWEBdgGN0nsKwNSGvmFsil3QujaiAixgfVB4plWaIkG9d34j
	 7dJOiSimN9MjFsU4Sz+8ZYhN0/qxaPiGHS7lONmF7eSpa+g29pc3yAHbzDaRgVyey1eFe
	 +4mEuZUzkEwEJwjJz1rZfQQcyyjbTRfKxGOsFZcWuSHCT8crSvgTqnN6/PDoTCGbOWo+2
	 FUlq8hezyevixRz6J21wo6uZsnwl7FxhSjjVoa0wGPiLAz194mIF2h/KgAI0opVQcNyDu
	 TCButyummLxpAi+TM0fADKzmv6epbFDaWxIu4FDZ2SSr8rPflGV/6klXLPs8dD+EF+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795790163;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=7C5gBPIj69ddVv9sMUWt40x1laoC666bCWFRg/Enq4U=;
	b=Gf3cDoFRP7uOk1KNrfG6X0pnVBwqRlTyLVNn2/yDT5Br/wjWC9TQTOHlhjJ0e4dZRoJj
	 rfFSHVjqgpXfF8+WLpM6n7buAmZftORgDVHOZvRLxIPy22nxHfXEXm+GWpaZHMLZmHf3h
	 vDlXkfFbSO2WAQBGa8hyREU+saAC6nFdY/Nov2w8QJnzJiH5P4CKPdIiHEBk8seyV+Nl+
	 PQ8ilcyvRH4isrthqJO7s/zCmi5lzSEJoz9lWBSwd2KPlKFYk5ZfW3zEsYt9Ff7PMeOkJ
	 NfBnYVDLtvOvDUEScJz5Hwu5MZZCDf1HJfSs+dvPOW6XKxZZ3XC0AFuD7laKBTX36SQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE1Ia2dN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5E1606A31C;
	Fri, 27 Nov 2026 14:36:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QE1Ia2dN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D6781F00893;
	Fri, 27 Nov 2026 14:36:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795790163;
	bh=7C5gBPIj69ddVv9sMUWt40x1laoC666bCWFRg/Enq4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QE1Ia2dNQMICHouDS/6GfDyGz273RcERT4pxi4jGdNZcZ6ALFL3qf+zyNet2IP/am
	 RSrlanazmy1As9mnJeRYt2tpkx/VopvQnHI895qKGEouj8Y6MYrygFn6PCvuINyh9N
	 0tCFG3orM+6Dy/c8YE89HWpp6fe81s83EisnJdYapd7X4bfQ671FDG4TX9W11Zs8fQ
	 nnH1aF1FoK7zdKLD7OJIlzEfP0IB+b7/BysjlezPtc7CwGBkv1IrGn+D0H7ZPDKiHN
	 uR5ZIOvR4PDkSOGCEjgK9IVPFZkosj6uFNreyRHjgG/t9u3i3/8DjyU9EnUzyzl5L2
	 TES9FGCCnqpYA==
Message-ID: <sashiko-outbox-237571@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 10/25] KVM: arm64: Share system register code with
 s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261127-sysreg-v4-10-a6318d18aab5@linux.ibm.com>
References: <20261127-sysreg-v4-0-a6318d18aab5@linux.ibm.com>
 <20261127-sysreg-v4-10-a6318d18aab5@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Nov 2026 14:36:02 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Medium] KVM: arm64: piecemeal sys_regs.c sharing and mixed PAuth/SVE
  changes
--

commit 674857ecf2e2398c1a40ecd629858a2ef61bc1be
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Share system register code with s390

This commit wraps selected system register helpers, pointer authentication
checks, and SVE register definitions in ARM64_S390_COMMON guards so they
can be compiled into the s390 KVM implementation for arm64 guests.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index a148e80d0aef7..4d44b638b7d38 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -361,6 +361,7 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
>  	kvm_arm_teardown_hypercalls(kvm);
>  }
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  static bool kvm_has_full_ptr_auth(void)
>  {
>  	bool apa, gpa, api, gpi, apa3, gpa3;
> @@ -395,6 +396,8 @@ static bool kvm_has_full_ptr_auth(void)
>  		(apa + api + apa3) =3D=3D 1);
>  }
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  int kvm_vm_ioctl_check_extension(struct kvm *kvm, long ext)
>  {
>  	int r;
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index ba4570c52a916..c9780845ef177 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -307,12 +307,12 @@ static int set_core_reg(struct kvm_vcpu *vcpu, cons=
t struct kvm_one_reg *reg)
>  	return err;
>  }
> =20
> -#endif /* ARM64_S390_COMMON =3D=3D 1 */
> -
>  #define vq_word(vq) (((vq) - SVE_VQ_MIN) / 64)
>  #define vq_mask(vq) ((u64)1 << ((vq) - SVE_VQ_MIN) % 64)
>  #define vq_present(vqs, vq) (!!((vqs)[vq_word(vq)] & vq_mask(vq)))
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  static int get_sve_vls(struct kvm_vcpu *vcpu, const struct kvm_one_reg *=
reg)

[ ... ]

> diff --git a/arch/arm64/kvm/sys_regs.c b/arch/arm64/kvm/sys_regs.c
> index abc49d4968f6c..6bd200694b143 100644
> --- a/arch/arm64/kvm/sys_regs.c
> +++ b/arch/arm64/kvm/sys_regs.c

[ ... ]

> @@ -3219,6 +3237,7 @@ static void init_imp_id_regs(void)
>  	boot_cpu_aidr_val =3D read_sysreg(aidr_el1);
>  }
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  static u64 reset_imp_id_reg(struct kvm_vcpu *vcpu, const struct sys_reg_=
desc *r)
>  {
>  	switch (reg_to_encoding(r)) {
> @@ -3276,6 +3295,8 @@ static int set_imp_id_reg(struct kvm_vcpu *vcpu, co=
nst struct sys_reg_desc *r,
>  	.val =3D mask,					\
>  	}
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  static u64 reset_mdcr(struct kvm_vcpu *vcpu, const struct sys_reg_desc *=
r)
>  {
>  	__vcpu_assign_sys_reg(vcpu, r->reg, vcpu->kvm->arch.nr_pmu_counters);

[ ... ]

> @@ -5446,6 +5470,7 @@ int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
>  	return 1;
>  }
> =20
> +#if ARM64_S390_COMMON =3D=3D 1
>  static void reset_vm_ftr_id_reg(struct kvm_vcpu *vcpu, const struct sys_=
reg_desc *reg)
>  {
>  	u32 id =3D reg_to_encoding(reg);
> @@ -5787,6 +5812,8 @@ int kvm_arm_copy_sys_reg_indices(struct kvm_vcpu *v=
cpu, u64 __user *uindices)
>  	return write_demux_regids(uindices);
>  }
> =20
> +#endif /* ARM64_S390_COMMON =3D=3D 1 */
> +
>  #define KVM_ARM_FEATURE_ID_RANGE_INDEX(r)			\

[Severity: Medium]
As reported by Marc Zyngier on v2 [1], why does this patch slice
arch/arm64/kvm/sys_regs.c into nine scattered ARM64_S390_COMMON blocks
instead of sharing the file and sys_reg_descs as a whole through state
access indirection?

Leaving sys_reg_descs, kvm_reset_sys_regs(), kvm_handle_sys_reg(),
arm64_check_features(), and finalize_sys_regs() outside the shared sections
causes commit "KVM: s390: arm64: Implement arm system register managing
infrastructure" to duplicate the architectural system register table and
core handling logic in arch/s390/kvm/arm64/sys_regs.c.

In addition, bundling kvm_has_full_ptr_auth() in arch/arm64/kvm/arm.c and
SVE helpers in arch/arm64/kvm/guest.c into this commit mixes unrelated
pointer authentication and SVE changes (including moving ARM64_S390_COMMON
markers added earlier in commit "KVM: arm64: Share arm64 code with s390")
with system register sharing.

[1] https://lore.kernel.org/r/87o6ehmkzz.wl-maz@kernel.org

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261127-sysreg-v4-=
0-a6318d18aab5@linux.ibm.com?part=3D10
