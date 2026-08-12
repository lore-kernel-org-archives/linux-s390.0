Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C05CC3515FD;
	Wed, 12 Aug 2026 16:41:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552903; cv=none; b=Mvq2JXthm8L7atDsL8Sxie8N8U8KPRpaBJ6ZE45kM8I0Pu/UlZKZmJex27YVGh47A4OL4Mo0OJWjk8e55gCFohQoTdSY6vIEExFjapLXHkwul8SFJ6RR8B7YBogMb9IuclBzkXSHZcaD4IkO+gF5743kUF5ZzxxsrIDyrTBZDVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552903; c=relaxed/simple;
	bh=D8FGi5ObNQbyVtlpTliLOfNlz/KUS8Q++cKptM4KhMQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=SWoOADBAjJypg1TaCeYvL5w/T1kNbPms6lbJLKcY5CDbTGNlELCBWtU0im6X+jpzt1XhpTOwB+wuNFbVqERDdjBq/UbcwLQRrMuB6/EKn6a4QQi64eyiEq7pZMK47UsdiXBZ0mt4xq0zBlvj4L1378J8+gxxGnn3Ndt/iDfyMcw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VV5h9lEn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VV5h9lEn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DADFF1F000E9;
	Wed, 12 Aug 2026 16:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552901;
	bh=oEGqIl9xKMDRuD7jt7p6plnnvYSi5uw7BSEu0Y2QZvY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VV5h9lEnwFbTeSAGaQhUzipdV/l66XjXHeqPGEGl7FtfT8K0kclxqraJYxGc/pCOv
	 oZOyphuGgM4dGOHrWRznMLfURDmDluX+IgzBh1pHVi1BLc39RXNW0UL5W0q0bthKTP
	 XbbISROaSMcJTyKnH7ld4zYczxjkPYXkLWo8j16SB29q9LkZSKtG97/K2Cj0c22X0O
	 hnCIH3q1Cl9fnS4U2wSQWU8Jog4/9oXdO/goeUmSeqTiMlVp0ZCWkRJBifibgIxw1q
	 uTwKZaQ39w7uSz/z42rUFxAJsBVWEbMQFxyalo9ZwDnrdmLA+s+zGmvcJ+l1Bo2gii
	 01R8IFsG8gS0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 31/33] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, "Marc Zyngier" <maz@kernel.org>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812153631.3376090-32-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-32-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:41:40 +0000
Message-Id: <20260812164140.DADFF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] kvm_arch_vcpu_ioctl_run() fails to acquire the kvm->srcu read =
lock, leading to a Use-After-Free when accessing memslots during guest abor=
ts.
- [High] Guest-reachable WARN_ONCE on SAE validity intercept enables a host=
 DoS.
- [High] Calling local_irq_enable() immediately after guest_enter_irqoff() =
violates strict RCU extended quiescent state (EQS) rules.
- [High] check_vcpu_requests() fails to handle critical KVM requests like K=
VM_REQ_TLB_FLUSH and KVM_REQ_VM_DEAD.
- [High] Missing IN_GUEST_MODE coordination in the vCPU run loop creates a =
race condition that can delay or drop signals and KVM requests.
- [High] Missing vcpu_load() and vcpu_put() around KVM IOCTLs that modify a=
rchitectural state in kvm_arch_vcpu_ioctl.
--

--- Patch [31]: [PATCH v6 31/33] KVM: s390: arm64: Implement vCPU IOCTLs ---
commit e43ea7af3ba7491497b01c2a0860a8b946aad58d
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vCPU IOCTLs

This commit implements the required vCPU IOCTLs for the s390 arm64 KVM
port. It provides the core structures for register access, lifecycle
management, and the main vCPU execution loop.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c

[ ... ]

> @@ -284,15 +309,15 @@
> +static int check_vcpu_requests(struct kvm_vcpu *vcpu)
> +{
> +	if (kvm_request_pending(vcpu)) {
> +		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> +			kvm_reset_vcpu(vcpu);
> +		/*
> +		 * Clear IRQ_PENDING requests that were made to guarantee
> +		 * that a VCPU sees new virtual interrupts.
> +		 */
> +		kvm_check_request(KVM_REQ_IRQ_PENDING, vcpu);
> +	}

[Severity: High]
Does this function properly handle all critical KVM requests?

It appears to drop requests like KVM_REQ_TLB_FLUSH and KVM_REQ_VM_DEAD by
not explicitly handling or clearing them. Can this bypass necessary TLB
invalidations and dead VM checks?

> +
> +	return 1;
> +}

[ ... ]

> @@ -390,13 +415,13 @@
> +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block =3D &vcpu->arch.sae_block;
> +
> +	adjust_pc(vcpu);
> +
> +	local_irq_disable();
> +	guest_enter_irqoff();
> +	local_irq_enable();

[Severity: High]
Does this sequence violate RCU extended quiescent state rules?

Calling local_irq_enable() immediately after guest_enter_irqoff() allows
host interrupts to fire while RCU believes the CPU is idle.

> +
> +	sae_block->icptr =3D 0;
> +
> +	sae64a(sae_block);

[ ... ]

> @@ -436,15 +461,15 @@
> +	ret =3D 1;
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason =3D KVM_EXIT_INTR;
> +			ret =3D -EINTR;
> +			continue;
> +		}
> +
> +		if (need_resched())
> +			schedule();
> +
> +		if (ret > 0)
> +			ret =3D check_vcpu_requests(vcpu);
> +
> +		vcpu->arch.sae_block.icptr =3D 0;
> +
> +		arm_vcpu_run(vcpu);

[Severity: High]
Could this loop race with concurrent IPI kicks?

It executes arm_vcpu_run() without coordinating via vcpu->mode =3D IN_GUEST=
_MODE.
A concurrent request kick via kvm_vcpu_kick() might see OUTSIDE_GUEST_MODE
and skip sending the IPI.

> +
> +		ret =3D handle_exit(vcpu);

[Severity: Critical]
Does handle_exit() require SRCU protection here?

The loop calls handle_exit() which routes synchronous exceptions to the gue=
st
abort handler. If the abort handler translates guest addresses and accesses
active memslots without holding kvm->srcu, could a concurrent userspace
operation like KVM_SET_USER_MEMORY_REGION trigger a use-after-free?

> +
> +	} while (ret > 0);

[ ... ]

> @@ -515,15 +540,15 @@
> +long kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned=
 long arg)
> +{
> +	struct kvm_vcpu *vcpu =3D filp->private_data;
> +	void __user *argp =3D (void __user *)arg;
> +	struct kvm_device_attr attr;
> +	int ret;
> +
> +	switch (ioctl) {
> +	case KVM_ARM_VCPU_INIT: {
> +		struct kvm_vcpu_init init;

[Severity: High]
Are vcpu_load() and vcpu_put() required around these ioctls?

Operations like KVM_SET_ONE_REG modify architectural state but do not acqui=
re
the vcpu_load locks, potentially bypassing preempt notifiers and physical-C=
PU
hardware state tracking hooks.

> +
> +		ret =3D -EFAULT;
> +		if (copy_from_user(&init, argp, sizeof(init)))
> +			break;

[ ... ]

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> --- a/arch/s390/kvm/arm64/handle_exit.c
> +++ b/arch/s390/kvm/arm64/handle_exit.c

[ ... ]

> @@ -66,13 +78,13 @@
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

[Severity: High]
Is it safe to use a guest-reachable WARN_ONCE here?

An unprivileged userspace process configuring KVM could set malformed guest
state via KVM_SET_ONE_REG, and the hardware would reject this during
execution, returning a validity intercept. Should this return an error to
userspace instead of triggering a host warning?

> +		ret =3D -EINVAL;
> +		break;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D31
