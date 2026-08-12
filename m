Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F15A4307AB;
	Wed, 12 Aug 2026 16:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552578; cv=none; b=EfVeKU8LpouLdIscp2oX1hVJoamFI3yTMJif778lMupPzb7RQWBeuVh0W6cdd8qoFsNiR+GG8Jhp3nZzxB1W9d1o1DKCvyk+4XaGLVyimxeezqfSrFjpuiAJIYM4K1CnKfe/2j5bBqo/HGjRJKEXHJgir8mWfZQi0HHjtWCL0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552578; c=relaxed/simple;
	bh=9LLYL4ONOE7WlZdSS452sIhub6jf7InboiawIVEIkNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WtFXSsHRstyhiItpCaNjDuTpxytmjSxd8fBc0vdD4k4sdpM+hDmImE9jQCHvdy7JtLmBeCZI/8dwRPZm1VchqK0u6bHMEc8ZBbfZ/P3GI3EKwJzKXlOGqVazabxVPvQLxqm42/XqQx4XaECwL0Sy+TofS0tR6aIwS+isbiKr77A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fW1wbsAa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fW1wbsAa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5DD81F000E9;
	Wed, 12 Aug 2026 16:36:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552576;
	bh=3vj0o0bAk1UQkVkJPKInL6dLED8LR6Mr0doThOhFkBY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fW1wbsAaOqZ6/z8uPb8jjxiScmUQ8FB+gd+5SaKrZpTF6Eg7a2B4rksv+kc151T6I
	 spgawGztiKe7Tj/8muBnvgly1XaL0dI9HV73I7B4gGjne7oQctBJ2Bem0UF3gKPQYB
	 ribzAPFBvwhGfHBmEgpvYDI7BlfBF8O6vzs+Lsn/7XbGxGXVa0IIP/52DR7XCsrkrC
	 cE0jAl/cz+b4vxPdW+74RbOhTIThRnCzWjpHw8UOHlDPIapip9VOMatwdsV0NDXIYC
	 XBC0B6uK6pJmRNMgpVTVqucATKsK07StnyW+KfUvjx4BJrjVO6+S2ZVryUjEwgJa1Y
	 spDaEPao9eQFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 29/33] KVM: s390: arm64: Implement required functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, kvmarm@lists.linux.dev, kvm@vger.kernel.org
In-Reply-To: <20260812153631.3376090-30-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-30-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:36:15 +0000
Message-Id: <20260812163615.B5DD81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Uninitialized lock acquisition causes lockdep splat or kernel cras=
h.
- [High] Empty exception injection stubs cause infinite VCPU exit loops.
--

--- Patch [29]: [PATCH v6 29/33] KVM: s390: arm64: Implement required funct=
ions ---
commit 7893f22f5b221e3beeba9913544dc8c7efcfbfc0
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement required functions
   =20
Implement the mostly trivial functions that the shared arm64 (kvm)
code & headers oblige s390 to implement.

Implement a very basic smccc handler that (non-compliantly) is just able
to stop a vcpu.

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/handle_exit.c
[ ... ]
> +static int kvm_smccc_call_handler(struct kvm_vcpu *vcpu)
> +{
> +	u32 func_id =3D vcpu_get_reg(vcpu, 0);
> +	u64 val =3D PSCI_RET_NOT_SUPPORTED;
> +	int ret =3D 1;
> +
> +	if (func_id =3D=3D PSCI_0_2_FN_SYSTEM_OFF) {
> +		scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {

[Severity: High]
Can this cause a lockdep splat or kernel crash?

This lock is an arm64-specific state that does not appear to be initialized=
=20
via spin_lock_init() in the s390 VCPU creation path.=20

If a guest triggers an SMC/HVC trap with func_id =3D=3D PSCI_0_2_FN_SYSTEM_=
OFF,=20
the host handles this in kvm_smccc_call_handler() and attempts to acquire=20
vcpu->arch.mp_state_lock. Attempting to acquire the uninitialized lock here
will cause a crash or lockdep warning.

> +			WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
> +		}
[ ... ]
> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/inject_fault.c
[ ... ]
> +void kvm_inject_undefined(struct kvm_vcpu *vcpu)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +}
> +
> +int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	return 1;
> +}

[Severity: High]
Do these empty stubs cause an infinite exit loop?

If a guest executes an undefined instruction or accesses an unmapped memory=
=20
address, the host KVM code attempts to inject an exception via=20
kvm_inject_undefined() or kvm_inject_sea().=20

Because these functions are empty stubs, they do not advance the guest PC o=
r=20
alter its exception state. When the exit handler returns 1 to resume=20
execution, the guest will immediately re-execute the exact same faulting=20
instruction and trap again indefinitely. Any unprivileged guest process can=
=20
trigger this to cause a denial of service against the host and the VM.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D29
