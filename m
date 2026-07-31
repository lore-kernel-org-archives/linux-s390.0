Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D64F642EEDA;
	Fri, 31 Jul 2026 14:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785508926; cv=none; b=KNgNDls4y2R/v86W36YLU1U/0EO49zyrecFxmd31fFgMLH7hgBDzU9lfCmBiX5ET1c0rgld1IxKu0qsHAFc7Yv5NP665xUK6Ep3T2l0nmRydmLeImY23lmJAOLspwKvnCKPzGgNl1GHqiKaGxiPHaQIRUmC/IKM5fhRub7So1wo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785508926; c=relaxed/simple;
	bh=ndZXO9u7h4amBq4dRMui/3yJw7adZm3KjH1DMt6ewes=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hUTrmzhPrKHkVUhJUy/cb0afm7e7mk1keAK/lNwuU0OYByrA+tI4MEW6LiirmToxF4lJnoe4MWH8mqtFdi2fk0EAZUqykMShUCg94QWTcnhiR/gr9iDfKnvagOopqhE1DLxroOkktAFbYCtVKFFJFAJkT0FS/bBdwPP4mblvi7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9PkhhUF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9PkhhUF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83AE51F000E9;
	Fri, 31 Jul 2026 14:42:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785508924;
	bh=gXrgjksxUZgOPRCkuIsyhLXhcXdd35awagwQEN82I5o=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Q9PkhhUFxaAC+oG2LtPLGD1at3IcRvS8WUhBcm/EqvSVHomZhL2M5PKidMByAcTtT
	 Jr8vOpn4vHhnfba4XDGMaer1iXXbpcVOzzazKggKgwBWS3ndik0oEkJnTjfeWg9XMs
	 mK6+8GqCTYxDkwLMURQWQi0ZezPsbg70RrNmFAc4f5MOCX5XMLUfTpWIL0DLnup52M
	 y4w5otZbMfQj8lIPYkXzKVXVIm1RR+b9217c57LLyGntUs5h19Ufmf9G2isXdenc6h
	 8fYiAhiJ3BiYDbz9D99X1eoqhrWqWm5XisBvH32rsg6Mt2Nn7+TUjWkC97B4HwQL+h
	 vVMhBTGs+5ByQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 29/31] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260731130902.654679-30-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-30-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:42:02 +0000
Message-Id: <20260731144203.83AE51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] VCPU run loop calls schedule() and might_fault() while preempt=
ion is disabled by kernel_fpu_begin().
- [High] Guest- or host-userspace-reachable WARN_ONCE triggers allow log sp=
amming and potential kernel panics.
- [High] Calling local_irq_enable() immediately after guest_enter_irqoff() =
breaks RCU extended quiescent state invariants.
- [High] The vCPU run loop fails to set IN_GUEST_MODE, leading to lost cros=
s-vCPU IPIs.
- [Medium] KVM_ARM_VCPU_FINALIZE silently accepts all feature requests by r=
eturning success (0) unconditionally.
--

--- Patch [29]: [PATCH v5 29/31] KVM: s390: arm64: Implement vCPU IOCTLs ---
commit 5a1c5a40e465ee169cdb685d1f98ec6e23195cc2
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vCPU IOCTLs

This commit implements all required vCPU IOCTLs for KVM s390 arm64.
It introduces handlers for KVM_RUN, KVM_SET_ONE_REG, and feature
finalization logic.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c

[ ... ]

> @@ -385,8 +385,11 @@ static void arm_vcpu_run(struct kvm_vcpu *vcpu)
>  	adjust_pc(vcpu);
> =20
>  	local_irq_disable();
>  	guest_enter_irqoff();
>  	local_irq_enable();

[Severity: High]
Does calling local_irq_enable() immediately after guest_enter_irqoff() break
RCU extended quiescent state invariants? guest_enter_irqoff() explicitly
transitions the CPU into an RCU Extended Quiescent State (EQS), instructing
RCU to ignore this CPU. Enabling hardware interrupts here allows them to fi=
re
while the CPU is still marked as being in an EQS. Any interrupt handler that
executes would run with RCU not watching, bypassing read-side protections.

> =20
>  	sae_block->icptr =3D 0;
> =20
>  	sae64a(sae_block);
> =20

[ ... ]

> @@ -420,25 +420,38 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
>  	vcpu_load(vcpu);
> =20
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
>  		if (signal_pending(current)) {
>  			kvm_run->exit_reason =3D KVM_EXIT_INTR;
>  			ret =3D -EINTR;
>  			continue;
>  		}
> =20
>  		if (need_resched())
>  			schedule();

[Severity: Critical]
Does this code call schedule() and might_fault() while preemption is disabl=
ed?
kernel_fpu_begin() disables preemption to safely manage hardware FPU state.
Inside this atomic section, the code calls might_fault() and schedule(), wh=
ich
will trigger a fatal scheduling while atomic BUG or cause silent FPU state
corruption.

> =20
>  		if (ret > 0)
>  			ret =3D check_vcpu_requests(vcpu);
> =20
>  		vcpu->arch.sae_block.icptr =3D 0;
> =20
>  		arm_vcpu_run(vcpu);

[Severity: High]
Does this loop need to set vcpu->mode =3D IN_GUEST_MODE before entering the
guest execution phase? When another thread or vCPU makes a request (like
injecting an IRQ via kvm_make_request()), it checks the target vCPU mode
and issues an IPI via kvm_vcpu_kick() if the target is in IN_GUEST_MODE.
Because this run loop never sets vcpu->mode, kicks might be silently ignored
and the guest might not be interrupted to process requests.

> =20
>  		ret =3D handle_exit(vcpu);
> =20
>  	} while (ret > 0);

[ ... ]

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> --- a/arch/s390/kvm/arm64/handle_exit.c
> +++ b/arch/s390/kvm/arm64/handle_exit.c
> @@ -58,15 +58,18 @@ int handle_exit(struct kvm_vcpu *vcpu)
>  	u8 icptr =3D vcpu->arch.sae_block.icptr;
>  	int ret =3D 1;
> =20
>  	switch (icptr) {
>  	case SAE_ICPTR_SPURIOUS:
>  		break;
>  	case SAE_ICPTR_VALIDITY:
>  		WARN_ONCE(true, "SAE: validity intercept. vir: 0x%04x",
>  			  vcpu->arch.sae_block.vir);

[Severity: High]
Is it safe to use a WARN_ONCE here that can be triggered by userspace?
Host userspace could use KVM_SET_ONE_REG to configure an invalid vCPU state,
then invoke KVM_RUN. The hardware would immediately exit with a validity
intercept (SAE_ICPTR_VALIDITY), hitting this macro. A malicious guest or
unprivileged host userspace could trigger this to spam the host logs, or
cause a full host kernel panic if panic_on_warn is set.

>  		ret =3D -EINVAL;
>  		break;
>  	case SAE_ICPTR_HOST_ACCESS_EXCEPTION:
>  	case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
>  		ret =3D handle_trap_exceptions(vcpu);
>  		break;
>  	default:
>  		WARN_ONCE(true, "SAE: unknown interception reason 0x%02x",
>  			  icptr);

[Severity: High]
Could this WARN_ONCE also be triggered by an unprivileged host userspace
process controlling the VM, leading to a potential kernel panic?

>  		ret =3D -EINVAL;
>  	}
>  	return ret;
>  }

[ ... ]

> diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
> --- a/arch/s390/kvm/arm64/reset.c
> +++ b/arch/s390/kvm/arm64/reset.c
> @@ -71,6 +71,6 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> =20
>  int kvm_arm_vcpu_finalize(struct kvm_vcpu *vcpu, int feature)
>  {
>  	return 0;
>  }

[Severity: Medium]
Should this function validate the feature ID instead of unconditionally
returning 0? Returning success for all requests could mislead userspace into
believing unsupported features were successfully enabled, potentially causi=
ng
subtle runtime misconfigurations or migration failures.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D29
