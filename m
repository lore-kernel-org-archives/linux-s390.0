Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45F81442108;
	Mon,  6 Jul 2026 10:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783333005; cv=none; b=JCcLBmbxJMSOOvoQALvPX26VKmGu13sRD3xhr9S49P5+WeKnPPAqr9khe+Jzp5Pdm36f2MLaAm6zHf4rOgfdqbyFcqOSV8Dtm/o493eEHfQAKsdUCXOeYWrVL5tUN8jlfLCoije9u1cZUh0h7LVgfI8gVVSOTEwcg1goQEGaklI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783333005; c=relaxed/simple;
	bh=7SrU/iePr5+vWkkl3oywkUabdE78XwNV4MJNcBwtgYc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DelSQc/OUgubeEmlvksJAzDEpI21dKJ7vV1U8XatTYNAzKIkTfXqqi51xlHIH55nf7/ebQ2IKNiL0+Kh4IWCm6xHjpoyOto4Wy42lsjCQcb3i/rsfhmCZ6/4vZNMAU5TJuVT48O/72AlKDsEMl5oXL2e++kEew8NmQQcqWLyIXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hm30TbrZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hm30TbrZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69DCC1F000E9;
	Mon,  6 Jul 2026 10:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783333003;
	bh=yrisIXx6y+gv4MP7X9h+3PO47CAPhJud1/GPbP+xDwc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Hm30TbrZQKsmmpPxl9CY30PfmPAS2LBw+KCGI0W5FNScvU8aE0Khy2jwakIz/Enh3
	 vjq5sMbIz/287K1enBuVNMHoc75Yuq+HabIUd0Eup3YggYEANeBkYWd4uvotXPV7sz
	 9XFwvgkIUCTs8km7v9kXJTm7cDiKmYYj/vL1u/7CK44GkZ9h6RkbL9xjNE6blApkKt
	 LmfOuvCnASrR8f99wJnoIszkT2KaAIm+/r0g4FDhKyEqJsUnk5hXoCiwu6uX7ChPPc
	 DAO1jhcN4LuFkC82Pn/6nbo6e13JhFpGo4e+iesEHa74KndSVGJuXyWUjNUBRiCa3Z
	 kL0Vc5d69iDvA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 25/27] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260706085229.979525-26-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-26-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 10:16:41 +0000
Message-Id: <20260706101643.69DCC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] Guest vector registers are not properly reset when KVM_REQ_VCPU_RE=
SET is processed during the KVM_RUN loop.
- [High] Userspace-reachable WARN_ONCE during validity intercept handling a=
llows unprivileged processes to taint or panic the kernel.
- [High] Executing local_irq_enable() while in an RCU extended quiescent st=
ate (EQS) triggers lockdep warnings and system crashes.
- [High] Guest PC increment is overwritten and lost due to calling `adjust_=
pc` before `vcpu_put`.
- [High] Missing `vcpu_load()` and `vcpu_put()` around KVM IOCTLs modifying=
 architectural state.
- [Medium] KVM_GET_REG_LIST ioctl returns a positive integer instead of 0 o=
n success.
- [Medium] KVM_ARM_VCPU_FINALIZE ioctl unconditionally returns 0, failing t=
o reject unrecognized features.
--

commit 13eb2c521ea373c254d3f7904b5979dc114e1d21
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Implement vCPU IOCTLs

Implement all vCPU IOCTLs.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -375,6 +375,18 @@ static void arm_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>  	struct kvm_sae_block *sae_block =3D &vcpu->arch.sae_block;
> =20
>  	adjust_pc(vcpu);
> =20
>  	local_irq_disable();
>  	guest_enter_irqoff();
>  	local_irq_enable();

[Severity: High]
Could enabling interrupts immediately after entering the guest context
trigger an RCU-idle splat?

guest_enter_irqoff() places the CPU into an RCU extended quiescent state
(EQS). Calling local_irq_enable() inside this state violates the API
contract since it makes the kernel preemptible while RCU is not watching,
which can lead to lockdep warnings and system stalls.

[ ... ]
> @@ -396,6 +408,61 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  {
>  	DECLARE_KERNEL_FPU_ONSTACK32(fpu_save);
>  	struct kvm_run *kvm_run =3D vcpu->run;
>  	int ret;
[ ... ]
>  	kernel_fpu_begin(&fpu_save, KERNEL_FPC | KERNEL_VXR);
>  	load_vx_regs((vcpu->arch.ctxt.vregs));
> =20
>  	if (!vcpu->wants_to_run) {
>  		ret =3D -EINTR;
>  		goto out;
>  	}
> =20
>  	kvm_sigset_activate(vcpu);
> =20
>  	might_fault();
> =20
>  	ret =3D 1;
>  	do {
[ ... ]
>  		if (ret > 0)
>  			ret =3D check_vcpu_requests(vcpu);

[Severity: High]
If a KVM_REQ_VCPU_RESET is pending and processed by check_vcpu_requests(),
the memory copy of the core registers is zeroed out by kvm_reset_vcpu().
However, the hardware CPU vector registers were already loaded before the
loop via load_vx_regs().

When the loop exits, won't save_vx_regs() copy the stale hardware state back
into memory, completely overriding the reset we just performed?

[ ... ]
>  		arm_vcpu_run(vcpu);
> =20
>  		ret =3D handle_exit(vcpu);
> =20
>  	} while (ret > 0);
> =20
>  	kvm_sigset_deactivate(vcpu);
>  out:
>  	if (unlikely(vcpu_get_flag(vcpu, INCREMENT_PC)))
>  		adjust_pc(vcpu);
> =20
>  	save_vx_regs(vcpu->arch.ctxt.vregs);
>  	kernel_fpu_end(&fpu_save, KERNEL_FPC | KERNEL_VXR);
>  	vcpu_put(vcpu);

[Severity: High]
Does this sequence overwrite the PC increment?

adjust_pc() modifies the PC in the vCPU's memory state, but the immediate
subsequent call to vcpu_put() executes the stiasrm hardware instruction.
This dumps the current internal hardware register state (with the
un-incremented PC) into the exact same memory save area.

Could this permanently overwrite the software increment and cause infinite
guest execution loops?

[ ... ]
> @@ -463,6 +530,95 @@ long kvm_arch_vcpu_ioctl(struct file *filp, unsigned=
 int ioctl, unsigned long ar
>  {
>  	struct kvm_vcpu *vcpu =3D filp->private_data;
>  	void __user *argp =3D (void __user *)arg;
>  	struct kvm_device_attr attr;
>  	int ret;
> =20
>  	switch (ioctl) {

[Severity: High]
Are we missing calls to vcpu_load() and vcpu_put() around these IOCTLs?

Operations like KVM_SET_ONE_REG and KVM_ARM_VCPU_INIT directly modify or
read the vCPU architectural state. The KVM subsystem mandates that IOCTLs
modifying architectural state must use these wrappers to manage vCPU
attachment.

Without them, could this lead to hardware state synchronization issues or
leaked preempt notifiers?

[ ... ]
>  	case KVM_GET_REG_LIST: {
>  		struct kvm_reg_list __user *user_list =3D argp;
>  		struct kvm_reg_list reg_list;
>  		unsigned int n;
[ ... ]
>  		n =3D reg_list.n;
>  		reg_list.n =3D kvm_arm_num_regs(vcpu);
>  		if (copy_to_user(user_list, &reg_list, sizeof(reg_list)))
>  			break;
>  		ret =3D -E2BIG;
>  		if (n < reg_list.n)
>  			break;
>  		ret =3D kvm_arm_copy_reg_indices(vcpu, user_list->reg);
>  		break;
>  	}

[Severity: Medium]
Should this explicitly return 0 on success?

kvm_arm_copy_reg_indices() returns the positive number of registers copied.
Passing this positive count directly back to userspace goes against the KVM
ABI requirement that this ioctl returns 0 on success.

Could this cause userspace programs like QEMU to misinterpret a successful
call as an error?

[ ... ]
> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> --- a/arch/s390/kvm/arm64/handle_exit.c
> +++ b/arch/s390/kvm/arm64/handle_exit.c
[ ... ]
> @@ -55,6 +57,35 @@ exit_handle_fn arm_exit_handlers[] =3D {
>  	[ESR_ELx_EC_HVC64]	=3D handle_hvc,
>  };
> =20
> +int handle_exit(struct kvm_vcpu *vcpu)
> +{
> +	u8 icptr =3D vcpu->arch.sae_block.icptr;
> +	int ret =3D 1;
> +
> +	switch (icptr) {
> +	case SAE_ICPTR_SPURIOUS:
> +		break;
> +	case SAE_ICPTR_VALIDITY:
> +		WARN_ONCE(true, "SAE: validity intercept. vir: 0x%04x",
> +			  vcpu->arch.sae_block.vir);
> +		ret =3D -EINVAL;
> +		break;

[Severity: High]
Is it safe to have a WARN_ONCE here?

Unprivileged host userspace can set arbitrary guest register states via
KVM_SET_ONE_REG prior to calling KVM_RUN. This allows a malicious userspace
process to intentionally construct an invalid CPU state that hardware
rejects.

Would this allow an unprivileged process to drive this warning condition and
create a host-side denial of service vector if panic_on_warn is enabled?

[ ... ]
> diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/reset.c
[ ... ]
> +int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
> +{
> +	return 0;
> +}

[Severity: Medium]
Should this validate the feature parameter instead of unconditionally
returning 0?

The KVM API specifies that finalizing an unsupported or invalid feature must
fail with -EINVAL or -EPERM. Returning 0 silently acknowledges invalid
feature finalizations.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D25
