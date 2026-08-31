Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D053A7F45;
	Mon, 31 Aug 2026 21:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788212840; cv=none; b=LPKsMFd5n3WODnrXUnTfkW5imktgRGFPnN+SacnzRyt2/SMI/tywS/Z+U8R3x4wPZr0TES9tEnRjMQj5B7GcU4ytahx33ePcoCqtvMxMJXlNI4kYUTrpW4Nk/PRTQEdL0hhirMuQxWCJlIV9OWEwv39tRgG8nFESnIIpEzzoSCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788212840; c=relaxed/simple;
	bh=wtG4pCWQpJon+A04RrXYFBnzPLt9h9bL5sUesgelXQA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sYXAJ7JPo1864f8+ylnEPHxKVAWEM6+awNo8bx5N51gBaPq1t98hG+LSNnMXZlBRB2pejed63XkDQRd6uyvEOeyZ1pwLKM2hFZLBiCCeJhF379wI4YxkK9FEMrrG3+lZwQBnQFay81vKqUY0XE5IhFWNt1kozM4FiNH8MHY4154=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NIXYyJcW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NIXYyJcW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8FD1F000E9;
	Mon, 31 Aug 2026 21:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788212838;
	bh=+178ACKBgKjWipPvRDkjg/uxFLshbj+HPaJmlSTEVrM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NIXYyJcW1aw1KOM+XUer9Sc0y76VdED1lXmU7+pOQaaUSLfMKYt5cz5uOXFj2OBAW
	 IgbE4OtqPG1cC3VxVzUPA/15jkqJu0oyDEyZG9IQXkWEYEcLQzG15MEQ3Cwt6yEVTa
	 UB5QTt3JtLr6RNj6R0JUVgBUPc6b5/+RzzzjoEJ25kLPv1Fhc0S1ZcA8A26m0JP146
	 s5WMHQErBW+qLP7ZUsjKJZkkEUlHadS+LX9TeAOI/pivayF51HrwSzKLGrVsXDR8L4
	 awks4v20lKE4nAIN7KFAArLVhQVca7jzc+uAzPZ0sraHgHbDYgYIjkF2XXFxDnkYC6
	 PpODWyvKGDRbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 21/23] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Oliver Upton" <oupton@kernel.org>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260831144802.834315-22-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-22-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:47:17 +0000
Message-Id: <20260831214717.EC8FD1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [Critical] Double vcpu_load() call in kvm_arch_vcpu_ioctl_run causes pree=
mpt notifier list corruption.
- [Critical] Unhandled generic vCPU requests cause an infinite loop in chec=
k_vcpu_requests.
- [High] Missing vcpu_load() and vcpu_put() around architectural KVM IOCTLs.
- [High] Host-userspace reachable WARN_ONCE for SAE validity intercepts ena=
bles Denial of Service.
- [High] KVM_ARM_VCPU_FINALIZE uses incorrect initialization gates and sile=
ntly ignores feature finalization.
- [High] TOCTOU race in KVM request checking due to host IRQs being enabled=
 before guest entry.
- [Low] The return value of check_vcpu_requests() is dead code and incorrec=
tly handled.
--

commit 3e429b0d42b7560ba0a2cd3dac96eb26a3ffe9cd
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement vCPU IOCTLs

This commit implements the required architectural vCPU IOCTLs for arm64
on s390. It adds the main vCPU execution loop, state initialization,
feature finalization, and handling of architectural registers.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index 7df0e4e697e80..3caa72f780a52 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -223,6 +247,388 @@ static unsigned long system_supported_vcpu_features=
(void)
>  	return features;
>  }
> =20
[ ... ]
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
> +
> +	return 1;
> +}

[Severity: Critical]
Does this code handle other generic KVM requests properly?

If a request other than KVM_REQ_VCPU_RESET or KVM_REQ_IRQ_PENDING is made
(such as KVM_REQ_SLEEP), it seems it will remain pending.

This could interact with the run loop in kvm_arch_vcpu_ioctl_run():

kvm_arch_vcpu_ioctl_run() {
    ...
    if (kvm_request_pending(vcpu)) {
        vcpu->mode =3D OUTSIDE_GUEST_MODE;
        continue;
    }
    ...
}

Because the unhandled request is never cleared, would the vCPU thread become
permanently stuck in an infinite loop without entering the guest?

[ ... ]
> +int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu)
> +{
> +	DECLARE_KERNEL_FPU_ONSTACK32(fpu_save);
> +	struct kvm_run *kvm_run =3D vcpu->run;
> +	int ret;
> +
> +	if (kvm_run->exit_reason =3D=3D KVM_EXIT_MMIO) {
> +		ret =3D kvm_handle_mmio_return(vcpu);
> +		if (ret <=3D 0)
> +			return ret;
> +	}
> +
> +	vcpu_load(vcpu);

[Severity: Critical]
Could this corrupt the per-CPU preempt notifiers hlist?

The generic KVM ioctl handler in virt/kvm/kvm_main.c already calls
vcpu_load() before invoking kvm_arch_vcpu_ioctl_run(). Calling it a second
time here registers the preempt notifier twice, which appears to create a
self-referential cycle in the hlist and could cause a kernel panic during
scheduling.

[ ... ]
> +	do {
> +		if (signal_pending(current)) {
> +			kvm_run->exit_reason =3D KVM_EXIT_INTR;
> +			ret =3D -EINTR;
> +			break;
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
> +		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
> +
> +		if (kvm_request_pending(vcpu)) {
> +			vcpu->mode =3D OUTSIDE_GUEST_MODE;
> +			continue;
> +		}
> +
> +		kvm_vcpu_srcu_read_unlock(vcpu);
> +
> +		arm_vcpu_run(vcpu);
> +
> +		vcpu->mode =3D OUTSIDE_GUEST_MODE;
> +
> +		kvm_vcpu_srcu_read_lock(vcpu);
> +
> +		ret =3D handle_exit(vcpu);

[Severity: Low]
Is the return value from check_vcpu_requests() intentionally ignored?

The result is assigned to ret, but there is no check to break out of the
loop if it returns an error. The value is then overwritten by the call to
handle_exit(). If check_vcpu_requests() ever returns an error code, it
appears it would be silently discarded.

[Severity: High]
Is there a race condition here when checking requests with host interrupts
enabled?

The vCPU mode transitions to IN_GUEST_MODE and requests are checked before
interrupts are disabled in arm_vcpu_run(). Furthermore, arm_vcpu_run()
re-enables interrupts just before the sae64a instruction:

arm_vcpu_run() {
    ...
    local_irq_disable();
    guest_timing_enter_irqoff();
    guest_state_enter_irqoff();
    local_irq_enable();

    sae_block->icptr =3D 0;

    sae64a(sae_block);
    ...
}

If an IPI arrives during this window after the request check but before
sae64a executes, would the kick be lost and leave the vCPU in the guest
without processing the request?

[ ... ]
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
[ ... ]
> +	case KVM_SET_ONE_REG:
> +	case KVM_GET_ONE_REG: {
> +		struct kvm_one_reg reg;
> +
> +		ret =3D -ENOEXEC;
> +		if (unlikely(!kvm_vcpu_initialized(vcpu)))
> +			break;
> +
> +		ret =3D -EFAULT;
> +		if (copy_from_user(&reg, argp, sizeof(reg)))
> +			break;
> +
> +		if (kvm_check_request(KVM_REQ_VCPU_RESET, vcpu))
> +			kvm_reset_vcpu(vcpu);
> +
> +		if (ioctl =3D=3D KVM_SET_ONE_REG)
> +			ret =3D kvm_arm_set_reg(vcpu, &reg);
> +		else
> +			ret =3D kvm_arm_get_reg(vcpu, &reg);
> +		break;
> +	}

[Severity: High]
Are vcpu_load() and vcpu_put() required around these architectural ioctls?

The kvm_arch_vcpu_ioctl() function routes operations like KVM_SET_ONE_REG a=
nd
KVM_GET_ONE_REG, but it appears to lack the necessary vcpu_load() and
vcpu_put() bracketing.

Since generic KVM does not hold the vCPU lock when delegating to
kvm_arch_vcpu_ioctl(), could this allow VCPU state to be modified without
proper synchronization?

[ ... ]
> +	case KVM_ARM_VCPU_FINALIZE: {
> +		int what;
> +
> +		if (!kvm_vcpu_initialized(vcpu))
> +			return -ENOEXEC;
> +
> +		if (get_user(what, (const int __user *)argp))
> +			return -EFAULT;
> +
> +		ret =3D kvm_arm_vcpu_finalize(vcpu, what);
> +		break;
> +	}

[Severity: High]
Does this code use the correct gate to reject finalization calls?

The operation is gated using !kvm_vcpu_initialized(), but it seems it should
be rejected if the guest has already run. Should this be using
vcpu_has_run_once(vcpu) instead?

Additionally, kvm_arm_vcpu_finalize() in arch/s390/kvm/arm64/reset.c
unconditionally returns 0:

kvm_arm_vcpu_finalize() {
    return 0;
}

Could this cause KVM to silently accept any unsupported features requested =
by
userspace?

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> new file mode 100644
> index 0000000000000..1286a64783e07
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/handle_exit.c
[ ... ]
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
> +	case SAE_ICPTR_HOST_ACCESS_EXCEPTION:
> +	case SAE_ICPTR_SYNCHRONOUS_EXCEPTION:
> +		ret =3D handle_trap_exceptions(vcpu);
> +		break;
> +	default:
> +		WARN_ONCE(true, "SAE: unknown interception reason 0x%02x",
> +			  icptr);
> +		ret =3D -EINVAL;
> +	}
> +	return ret;
> +}

[Severity: High]
Are these WARN_ONCE calls reachable by unprivileged userspace or guests?

If userspace injects a malformed SAE state or an unknown intercept code, it
could trigger these warnings. Reaching a WARN_ONCE from guest-controlled
or host-userspace-controlled state can lead to a Denial of Service via log
flooding or a kernel panic if panic_on_warn is enabled.

Could these be changed to return an error or use pr_warn_once() instead?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D21
