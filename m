Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793992690;
	b=FezwioOFEtlZxOjLPj2DT1v15B3M5QIOM0tGfkwDXOk3nmkzI8zYxznW64FMuhfzOiKI
	 czpT9y7ahXJ6qvGHdYRwGlRxkua06f3t/3jQZ0AvFCI9DoCYFSilQCJycdeQ1cf4GqRkD
	 Ko/lS4UY+Pxf9/2ppHi5angtqibZiBp9RwVmO2t/Lmq/6+SaZ/s8rnp3nzOiREY9Xs4I4
	 QAomFJJY3zpXo2T0nb8h40QSerfPOMyLmqxEhPUSmIGNG0Fb8lvt9G31pXrDYs3ff3ka+
	 Rcd8DSZCe+UKlsKP4Y0lM3jVF4IpBMMEplJCwb8rZXgkmU7+X43kG6/UIEq/w1pX7Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793992690;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=O/WfF4q72VW53Alr6ZZ5MsjjzWOgUG4myB6F5vL1jRY=;
	b=pht/6d9U3jOh3mEruNvrsZPEhqPTXnvOdIVAxlLEHWj2bV6nXUCHaSxzvkdyxU9pzAHZ
	 67FfsZCrRLGXenQwhmBxa6uBjd99KDKJerr+yHLKNJkiA54COmTwANLZjRFXEkxv4FGga
	 p5C+9bwb0O2V8UkVB3sOcQ2u9i3Th1lY1mdffL0aPkypL7SxzXblz0pl3Abj3I9zyi/w3
	 WlM+vMQydssl2nhK4qLYofyDnqEBEfNQ7UDBZOwXvlbT8m5uQfilIUDSaBaT6Mmqb5Xbp
	 HdWFMcjVEL9TFTWXDZ/N20ZpvUVKfP57iXi4iJ1lueqAKW/BXBbhZ4RZyedTNOk9v1g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW1un0yS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03BC5606A326;
	Fri,  6 Nov 2026 19:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WW1un0yS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11FEE1F0089F;
	Fri,  6 Nov 2026 19:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793992689;
	bh=O/WfF4q72VW53Alr6ZZ5MsjjzWOgUG4myB6F5vL1jRY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WW1un0yS9x1HulQr4vhmunOUmTq/qcZxQkKi9siMIZrJ7TeKPyjK4/M5/khz8LJx0
	 v6ADWulqh6UKjtrIWOhf9WKplQhNdrGzE1sIhowPETQ13DqzNFfTky+eRMTOrqXwwC
	 paubLhn7uwC5VNpTOBpdqLvfOv968RYZB9ID0jgKU5nb/S8kHz4O5ylOhHAU751wIO
	 XgtVKQEiWNYeH2UgKULUZOSOCFkxjvjdABmXa1ZAaO19QpeayWtvmVNj6PzfqPTJKu
	 3mUMH1aZQMEasncdJyWfBSPI0wHkitna/OoIVi3S7bd6ZcC4snyP2r/L870C6xFOhe
	 d+4vyCufdHMXg==
Message-ID: <sashiko-outbox-202145@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 17/23] KVM: s390: arm64: Integrate sysreg into the
 host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-17-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-17-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 19:18:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] KVM: s390: arm64: hcrx_el2 not updated after finalizing ID
  regs
- [Medium] KVM: s390: arm64: preemptible smp_processor_id() in
  kvm_handle_sys_reg()
- [Medium] KVM: s390: arm64: missing reset of ctxt.elr_el1, spsr_el1,
  and sp_el1
--

commit 0aa20b7c35188a2ab3cdf479482a3360763c4252
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Integrate sysreg into the host

This commit integrates the arm64 system register management infrastructure
into the s390 host by initializing and resetting system registers on vCPU
creation and reset, finalizing them on the first vCPU run, handling
ESR_ELx_EC_SYS64 exits, and exposing them via KVM_CAP_ONE_REG.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index ba6235629c7d9..62fd71af8968c 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c

[ ... ]

> @@ -271,6 +280,10 @@ int kvm_arch_vcpu_run_pid_change(struct kvm_vcpu *vc=
pu)
>  	if (likely(READ_ONCE(vcpu->pid)))
>  		return 0;
> =20
> +	ret =3D kvm_vcpu_finalize_sys_regs(vcpu);
> +	if (ret)
> +		return ret;
> +
>  	scoped_guard(mutex, &kvm->arch.config_lock)
>  		set_bit(KVM_ARCH_FLAG_HAS_RAN_ONCE, &kvm->arch.flags);
> =20

[Severity: Medium]
Should kvm_arch_vcpu_run_pid_change() recompute vcpu->arch.hcrx_el2 (for
example via vcpu_reset_hcrx()) after finalizing ID registers?

vcpu_reset_hcrx() sets HCRX_EL2_MSCEn from ID_AA64ISAR2_EL1 during
kvm_reset_vcpu() at KVM_ARM_VCPU_INIT time.  Because KVM_SET_ONE_REG is
only permitted after KVM_ARM_VCPU_INIT, if userspace clears FEAT_MOPS in
SYS_ID_AA64ISAR2_EL1 before the first KVM_RUN, vcpu->arch.hcrx_el2 retains
the stale HCRX_EL2_MSCEn bit and kvm_arch_vcpu_ioctl_run() leaves MOPS
instructions enabled in hardware for the guest.

[ ... ]

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> index e0c7773c2165d..1653163ed6d65 100644
> --- a/arch/s390/kvm/arm64/handle_exit.c
> +++ b/arch/s390/kvm/arm64/handle_exit.c
> @@ -62,6 +62,7 @@ static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
>  static exit_handle_fn arm_exit_handlers[] =3D {
>  	[0 ... ESR_ELx_EC_MAX]	=3D kvm_handle_unknown_ec,
>  	[ESR_ELx_EC_HVC64]	=3D handle_hvc,
> +	[ESR_ELx_EC_SYS64]	=3D kvm_handle_sys_reg,
>  	[ESR_ELx_EC_IABT_LOW]	=3D kvm_handle_guest_abort,
>  	[ESR_ELx_EC_DABT_LOW]	=3D kvm_handle_guest_abort,
>  };

[Severity: Medium]
Does calling kvm_handle_sys_reg() from handle_exit() invoke
_vcpu_read_sys_reg() and _vcpu_write_sys_reg() in preemptible context while
the vCPU is loaded?

In kvm_arch_vcpu_ioctl_run(), handle_exit() runs after local_irq_enable()
with preemption enabled and vcpu_is_loaded(vcpu) true.  When a guest traps
on a save-area system register such as OSLSR_EL1 or SCXTNUM_EL0/EL1,
kvm_handle_sys_reg() -> perform_access() calls vcpu_read_sys_reg() or
vcpu_write_sys_reg():

arch/s390/include/asm/kvm_host_arm64.h:_vcpu_read_sys_reg()
	KVM_BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu, (C)->kvm=
);

Under CONFIG_DEBUG_PREEMPT=3Dy this triggers a "using smp_processor_id() in
preemptible code" splat, and if the vCPU thread is preempted and migrated
between smp_processor_id() and reading (C)->cpu, KVM_BUG_ON() fires and
terminates the VM.

> diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
> index e4cdce1dbf9d2..0339901f5fd08 100644
> --- a/arch/s390/kvm/arm64/reset.c
> +++ b/arch/s390/kvm/arm64/reset.c

[ ... ]

> @@ -43,9 +80,14 @@ void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
>  		vcpu_put(vcpu);
> =20
>  	kvm_reset_vcpu_core(vcpu);
> +	kvm_reset_sys_regs(vcpu);
> =20
>  	/* Reset special registers */
>  	vcpu_reset_hcr(vcpu);
> +	vcpu_reset_hcrx(vcpu);
> +	vcpu_reset_cptr(vcpu);
> +	vcpu_reset_cnthctl(vcpu);
> +	vcpu_reset_icc(vcpu);

[Severity: Medium]
Does kvm_reset_vcpu() leave vcpu->arch.ctxt.elr_el1,
vcpu->arch.ctxt.spsr_el1, and vcpu->arch.sae_block.sp_el1 unreset when a
vCPU is reset after running?

Neither kvm_reset_vcpu_core() nor kvm_reset_sys_regs() resets those fields
because sys_reg_descs[] has no entries for ELR_EL1, SPSR_EL1, or SP_EL1.
On the next guest entry after a vCPU reset, kvm_arch_vcpu_ioctl_run()
writes the stale ctxt.elr_el1 and ctxt.spsr_el1 values back into
SYS_ELR_EL1 and SYS_SPSR_EL1 in the hardware save area.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D17
