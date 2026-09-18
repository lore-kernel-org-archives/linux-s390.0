Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61214EC670;
	Fri, 18 Sep 2026 17:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789753518; cv=none; b=Hes1db1JswwaGshYTszpcwDqn0JeaMaxUPdyaQHI8a0QIpHEq9aqAP547PYZBpqOyrbTEhgb61+OrAntA9s5aXpu+1IcGx/vmu01Sn79hLUt7WmGCi7SqZi6p88TEURqsAqPyGg6qtKGDVD/f1G/iQq4z7kLuUBBGTcLsj51YoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789753518; c=relaxed/simple;
	bh=NoKKM+oi9SzD6+7uMIYRJxCqkzOrYVJ6fjFr0z0+Hig=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=r+5Kll1tlAH6ZzBYXwcPKKbQ4J4lzS3yHNd+XGwQSzrJ1nh7wmeOIuUkKidwN36aG5CCptha9iGDTlLeVBqV+b2jSZch6J+3fqQ8klCRCuSVao06rsbmiQITQ1YtucRnJVnhon6CZs8OTMx+SFPd0ly8f/M4Y/3wUI1AEPLZwFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9Ls1adO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9Ls1adO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C516D1F000FF;
	Fri, 18 Sep 2026 17:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789753509;
	bh=ukjaln4v+rPe6YjcAhIWp0VMO9eGNcYLoh/NfeZnK6c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Z9Ls1adOt29A91x2UbWThgKtnYZaT8fOn46xtGiQfe4kz00xTr98M9IaLP3A52QHh
	 JCyWXONzx+DWlmW9YdXmd0xKglMANkzGZEYX8sVUJzaGb7zeXVQqnsXo73mz/Vs2iH
	 VZ8RCrFs5HBiSAxPvQLJRIHYZ+nhsB6LvlMv5cUojVNt/sINJS6M6xcJ/pMovZ8PLN
	 uPwXmUiwD8u69mr0W5+1Dq04Pq0arsHhcgkm+VBW98Emh5NHLb31EPesNz94j3dDd7
	 nBIvt8gqiMZ6r4hubCNvCjIBY8sqAiZmzFdkJCuDK5CmWAq//IXbsnK0yOKuGSh7Rk
	 MRXMQ1Vif3DEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 26/29] KVM: s390: arm64: Implement vCPU IOCTLs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260918133107.1042730-27-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-27-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:45:08 +0000
Message-Id: <20260918174508.C516D1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] kvm: guest memory corruption due to missing TLB flush on KVM_R=
EQ_TLB_FLUSH
- [High] kvm: host-side hang due to sleepable operation inside SRCU read lo=
ck
- [High] kvm: missed IPIs and vCPU requests due to unprotected IN_GUEST_MOD=
E transition
- [High] kvm: silent state corruption due to missing vcpu_load/put in ioctl=
 dispatcher
- [High] kvm: ABBA deadlock via redundant vcpu_load() in kvm_arch_vcpu_ioct=
l_run
- [High] kvm: sleeping in atomic context in kvm_reset_vcpu()
- [High] kvm: Use-After-Free risk via enabled IRQs inside RCU Extended Quie=
scent State
- [Medium] kvm: host-userspace DoS via WARN_ONCE on SAE validity intercept
- [Medium] kvm: information leak via uninitialized KVM_EXIT_FAIL_ENTRY fiel=
ds
--

commit ca6265bd830c0d19959272a1e3c2c5ff1c794f65
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Implement vCPU IOCTLs

Implement all required vCPU (arch) IOCTLs.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
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
> +		kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu);

[Severity: Critical]
This clears the KVM_REQ_TLB_FLUSH bit, but is the actual hardware TLB flush
instruction or gmap_tlb_flush() missing here? Could this allow the guest to
continue accessing physical memory using stale page table entries?

> +	}
> +
> +	return 1;
> +}
[ ... ]
> +static void arm_vcpu_run(struct kvm_vcpu *vcpu)
> +{
> +	struct kvm_sae_block *sae_block =3D &vcpu->arch.sae_block;
> +
> +	adjust_pc(vcpu);
> +
> +	local_irq_disable();
> +	guest_timing_enter_irqoff();
> +	guest_state_enter_irqoff();
> +	local_irq_enable();
> +
> +	sae64a(sae_block);

[Severity: High]
Are host interrupts being explicitly enabled right after
guest_state_enter_irqoff() transitions context tracking into an RCU Extended
Quiescent State? If a host interrupt fires here, could its handler execute
while RCU is suspended, risking a Use-After-Free?

> +
> +	local_irq_disable();
> +	guest_state_exit_irqoff();
> +	guest_timing_exit_irqoff();
> +	local_irq_enable();
> +}
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

[Severity: High]
Doesn't the generic KVM core code already acquire vcpu->mutex via
vcpu_load() before calling kvm_arch_vcpu_ioctl_run()? Could calling
vcpu_load() again here cause an immediate self-deadlock on vcpu->mutex?

> +
> +	kernel_fpu_begin(&fpu_save, KERNEL_FPC | KERNEL_VXR);
> +	load_vx_regs((vcpu->arch.ctxt.vregs));
[ ... ]
> +	might_fault();
> +
> +	kvm_vcpu_srcu_read_lock(vcpu);
> +
> +	ret =3D 1;
> +	while (ret > 0) {
> +	=09
> +		ret =3D kvm_xfer_to_guest_mode_handle_work(vcpu);

[Severity: High]
Does kvm_xfer_to_guest_mode_handle_work() perform sleepable operations
(like processing TIF_NEED_RESCHED or signals) while the SRCU read lock is
held? Might this stall the SRCU grace period indefinitely and hang the host
during VM operations like memslot updates?

> +		if (!ret)
> +			ret =3D 1;
> +
> +		if (ret > 0)
> +			ret =3D check_vcpu_requests(vcpu);
> +
> +		if (ret <=3D 0)
> +			break;
> +
> +		vcpu->arch.sae_block.icptr =3D 0;
> +
> +		smp_store_mb(vcpu->mode, IN_GUEST_MODE);
> +
> +		if (kvm_request_pending(vcpu)) {
> +			vcpu->mode =3D OUTSIDE_GUEST_MODE;
> +			continue;
> +		}

[Severity: High]
Is the transition to IN_GUEST_MODE and the check for pending requests
happening before local interrupts are disabled? If a concurrent vCPU kick
occurs immediately after the check, could the host handle the IPI and the
vCPU enter the guest without re-checking requests, thereby missing the kick?

> +
> +		kvm_vcpu_srcu_read_unlock(vcpu);
> +
> +		arm_vcpu_run(vcpu);
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
> +		struct kvm_vcpu_init init;

[Severity: High]
Do KVM_ARM_VCPU_INIT and KVM_SET_ONE_REG modify architectural state without
calling vcpu_load() and vcpu_put()? Could this lead to physical CPU state
corruption or leaked preempt notifiers if the vCPU is not properly bound to
the physical CPU during these modifications?

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

[Severity: Medium]
Could this WARN_ONCE be triggered by an unprivileged host-userspace process
providing malformed VCPU state via ioctls? KVM guidelines generally forbid
userspace-reachable warnings since they can act as a denial of service if
panic_on_warn is set. Should this return an error instead?

> +		vcpu->run->exit_reason =3D KVM_EXIT_FAIL_ENTRY;
> +		ret =3D 0;
> +		break;

[Severity: Medium]
Does this leave the hardware_entry_failure_reason and cpu fields of
vcpu->run->fail_entry uninitialized before returning to userspace? Could
this potentially leak stale kernel memory from the shared kvm_run union?

> +	case SAE_ICPTR_GUEST_ADDRESS_SIZE:
[ ... ]
> diff --git a/arch/s390/kvm/arm64/reset.c b/arch/s390/kvm/arm64/reset.c
> --- a/arch/s390/kvm/arm64/reset.c
> +++ b/arch/s390/kvm/arm64/reset.c
[ ... ]
> +void kvm_reset_vcpu(struct kvm_vcpu *vcpu)
> +{
> +	struct vcpu_reset_state reset_state;
> +	bool loaded;
> +
> +	scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {
> +		reset_state =3D vcpu->arch.reset_state;
> +		vcpu->arch.reset_state.reset =3D false;
> +	}
> +
> +	/*
> +	 * Disable preemption around the vcpu reset as we might otherwise race =
with
> +	 * preempt notifiers which call stiasrm/lasrm from put/load
> +	 */
> +	preempt_disable();
> +
> +	/* The reset must run with an unloaded save area */
> +	loaded =3D vcpu_is_loaded(vcpu);
> +	if (loaded)
> +		vcpu_put(vcpu);

[Severity: High]
Are we calling vcpu_put() and vcpu_load() (which acquire the sleepable
vcpu->mutex) while inside a preempt_disable() block? Could this cause a
BUG: sleeping function called from invalid context panic during a vCPU
reset?

> +
> +	kvm_reset_vcpu_core(vcpu);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D26
