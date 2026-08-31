Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEC6D37FF7A;
	Mon, 31 Aug 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210945; cv=none; b=mhWG82QPolrFk64CNEuzOSiTshaD40vxjl+OXlXsj/IyZEDm2mKba7cTq/mVn6+WsR1c5QkKSMXwkmRsb3ykqaIrdukbfTGfa6fZHfvRrdDqlV03xHuA/G8Bi0/HBwUdCFW0QgVgVKCr4vzCj7ssLmFVUa7rrZKc8pOxFYH1XlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210945; c=relaxed/simple;
	bh=JdDS56QbjwSFpUqRjsyyl8mRjgs3Pduz1Zv3+lEabMw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XV8jFxF7/TPM3noaTImBbyIKl10gP/Lt8J4VDsQ9zX9p1A7LsAKZS0ilUGZTRpR8mLpJvuzTkhQJnm23Vd9KXDEQFOT0BCFnJwhXXgcd72TGHlzU6bIihyH4V8or1eFq5KQm8lHOEkghvYyqszOqY7XGcIQPT6/w21S1MLBOnvg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMVBwMGL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMVBwMGL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5990F1F000E9;
	Mon, 31 Aug 2026 21:15:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210943;
	bh=B0GksqZHkDVaG6MPNLLvtMEp11FMSY3oiUnSYNnV/kU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fMVBwMGLaTEtORZ26az9A/rgDaq6lfTtKrLYNscyqs6TH2f7L30Q5QIAzR0TBD3ar
	 AnIy1pOf72UlZ3h3nYhItzLBvR1sWSnmPAdOdLE+hNKAvOwhB3voTPb1MRqnRvHNGE
	 7j4m57moHvzHZkmq4Q4R+1J/naygNfV+Up/KxBFoYN5ricDEKG7GOBOMicfIgCi88A
	 sZn70kpdwLJdNz9BSb7++ALwD1+tIg6ZUI87Ja0/cVjGxmfaOFns+FQghhhtyxkrlo
	 O1a5IP39sg+edUk1Tfkx3xwOFzcHrt+5fHjIO30njgv58hpwJMmnjPoGfBijwhWr4T
	 LsalQDwaJ45xw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/20] KVM: s390: arm64: Integrate sysreg into the
 host
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831145536.913567-15-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-15-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 21:15:42 +0000
Message-Id: <20260831211543.5990F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Preemption and interrupts are erroneously re-enabled prior to gues=
t entry and host sysreg writes, causing unstable `smp_processor_id()` usage=
 and race conditions.

Pre-existing issues:
- [High] Missed KVM vCPU request (lost IPI) due to checking requests with i=
nterrupts enabled before entering guest mode.
--

commit 1f3a8a06b031d71852642f3d9a86276d457c62ad
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: s390: arm64: Integrate sysreg into the host

This commit integrates the system register managing infrastructure into the
host. It initializes sysregs during vcpu init, finalizes them on PID change,
and lets userspace read and modify guest system registers.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> index c573a3da5766e..3a0bba6e0a062 100644
> --- a/arch/s390/kvm/arm64/arm.c
> +++ b/arch/s390/kvm/arm64/arm.c
[ ... ]
> @@ -390,10 +399,20 @@ static void arm_vcpu_run(struct kvm_vcpu *vcpu)
>  	guest_state_enter_irqoff();
>  	local_irq_enable();
> =20
> +	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcr_elz, SYS_HCR_EL2);
> +	vcpu_write_host_sys_reg(vcpu, vcpu->arch.hcrx_elz, SYS_HCRX_EL2);
> +	vcpu_write_host_sys_reg(vcpu, vcpu->arch.mpidr, SYS_VMPIDR_EL2);
> +
> +	_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.elr_el1, SYS_ELR_EL1);
> +	_vcpu_write_sys_reg(vcpu, vcpu->arch.ctxt.spsr_el1, SYS_SPSR_EL1);

[Severity: High]
Does calling _vcpu_write_sys_reg() here cause problems with preemption being
enabled?

Because local_irq_enable() is called immediately before these sysreg writes,
the thread is fully preemptible. The _vcpu_write_sys_reg() macro invokes
smp_processor_id(), which triggers a CONFIG_DEBUG_PREEMPT BUG when used in
preemptible code.

Additionally, if the thread is preempted and migrated to another CPU during
this window, could this race condition cause the sysregs to be written to t=
he
wrong physical CPU?

>  	sae_block->icptr =3D 0;
> =20
>  	sae64a(sae_block);
> =20
> +	vcpu->arch.ctxt.elr_el1 =3D _vcpu_read_sys_reg(vcpu, SYS_ELR_EL1);
> +	vcpu->arch.ctxt.spsr_el1 =3D _vcpu_read_sys_reg(vcpu, SYS_SPSR_EL1);
> +
>  	local_irq_disable();
>  	guest_state_exit_irqoff();
>  	guest_timing_exit_irqoff();
>  	local_irq_enable();

[Severity: High]
Does this sequence leave the actual guest execution window completely
preemptible?

It appears the logic disables IRQs only to satisfy the
guest_state_exit_irqoff() function, which mirrors the potentially inverted
logic for the entry path above.


While reviewing this patch, I also noticed a pre-existing issue in the vCPU
run loop:

arch/s390/kvm/arm64/arm.c:kvm_arch_vcpu_ioctl_run() {
	...
		smp_store_mb(vcpu->mode, IN_GUEST_MODE);

		if (kvm_request_pending(vcpu)) {
			vcpu->mode =3D OUTSIDE_GUEST_MODE;
			continue;
		}
	...
}

[Severity: High]
This is a pre-existing issue, but does checking kvm_request_pending() here
while host interrupts are fully enabled leave a race window for lost IPIs?

The vCPU run loop sets vcpu->mode =3D IN_GUEST_MODE and checks
kvm_request_pending() while host interrupts are fully enabled. Consequently=
, if
an IPI arrives immediately after the check, the host will consume it right
away. The vCPU thread could then proceed to enter the guest without noticing
the request, causing the request to be missed until a subsequent unrelated
exit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D14
