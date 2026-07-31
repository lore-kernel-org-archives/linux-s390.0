Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6497633D6F0;
	Fri, 31 Jul 2026 14:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785507852; cv=none; b=UiFmx7xanVxh191Xsy0w+zbfZj7FfzycOTshjWxpwT8x3O1KRGt7b/MmR4F10aqitvoh0My/2TWBjYfChkODZjYWHYZY27tT/p5QdN8WqlVRtTxCIFmzxIyat9WJfvzOFThD8sDs6/26k7fgcjrRrKU/c86dl6CtfGkFuprgmig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785507852; c=relaxed/simple;
	bh=GB23r51zt3xYLF50NVb5DfYRWulZgOgyuBsgWNEiS8U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=nP82mS2aMT0NDqqJyI4Jh+UGbJMTL9SNDdfOqbeMbwiMKqKa+O7SgHm1wXhEookFXtxxAyFSSQbk+MYSKBJtc1SXD/QzNMTdk8m1Yabrkmk5iNDEKvwRNq/6xUktYpTmbcDZMEfkBiJKryNRBkxgylDXjgBkSZyfeazNqKbmJwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYQ8Ehmt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYQ8Ehmt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70AAE1F000E9;
	Fri, 31 Jul 2026 14:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785507850;
	bh=rVM0EENtQi0BlExzl9rrrE3I0bGyCVdicPaTxH4Ywaw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HYQ8EhmtcD6FNclrvTe1ihDzdKIpWf0NwtpSSWkqh/NZ1OFDzRsD2eyVxYk5YRZlG
	 kxNYpaIcrpmpqXWRCsmqN386FzNq9Fr/bshEn4qK0FIaBjnBtox5VG/2Bz8Zfsvqju
	 If1W/45aynPK729QfnCOzZBmjvXjGMaBW8IKxKwjk+BzAMDPg2K7dWN4a76bj14z4s
	 vHrzEsTchdVZoNOYks4qCfFu/sfgNm3aJhcJ0H7hwYuEecYR86u2XHqI7lYVTjQYQg
	 q2UMGLUuon1HA5PEObGlPMHXVlo505/oJsBrud0fyEx9bv7Cqkb9cKIdnKHP0QiyiQ
	 2MXuPX0c0XvAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 27/31] KVM: s390: arm64: Implement required functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvmarm@lists.linux.dev, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-28-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-28-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:24:09 +0000
Message-Id: <20260731142410.70AAE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [Critical] Uninitialized spinlock `mp_state_lock` triggers guest-to-host =
kernel panic
- [Critical] Infinite VM-Exit Loop on Stubbed Exception Injection
- [High] Incomplete SMP System Shutdown in PSCI SYSTEM_OFF handler
- [Medium] KVM Feature Enumeration Violation (HVC trapping unconditionally =
enabled)
- [Low] Compilation Errors / Undefined Constants
--

--- Patch [27]: [PATCH v5 27/31] KVM: s390: arm64: Implement required funct=
ions ---
commit 9ebfb4dc7b6b58f4a7a2e0419672a287a40a3f1e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement required functions

This commit implements the mostly trivial functions required by the shared
arm64 KVM code for s390. It also adds a very basic smccc handler that
can stop a vcpu.

> diff --git a/arch/s390/include/arm64/kvm_emulate.h b/arch/s390/include/ar=
m64/kvm_emulate.h
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/include/arm64/kvm_emulate.h

[ ... ]

> +static inline bool vcpu_mode_priv(const struct kvm_vcpu *vcpu)
> +{
> +	u32 mode =3D *vcpu_cpsr(vcpu) & PSR_MODE_MASK;
> +
> +	return mode !=3D PSR_MODE_EL0t;
> +}

[Severity: Low]
Does s390 have definitions for PSR_MODE_MASK or PSR_MODE_EL0t? This file
includes the host's <asm/ptrace.h> instead of the newly created
<arm64/ptrace.h>, which might result in missing macros and build failures.

> +static inline void kvm_skip_instr(struct kvm_vcpu *vcpu)
> +{
> +	*vcpu_pc(vcpu) +=3D 4;
> +	*vcpu_cpsr(vcpu) &=3D ~PSR_BTYPE_MASK;
> +
> +	/* advance the singlestep state machine */
> +	*vcpu_cpsr(vcpu) &=3D ~SPSR_EL1_SS;
> +}

[Severity: Low]
Is SPSR_EL1_SS defined anywhere in this tree? The ARM64 macro is usually
named DBG_SPSR_SS, so this looks like it might fail to compile. Additionall=
y,
PSR_BTYPE_MASK would also require the <arm64/ptrace.h> header to be include=
d.

[ ... ]

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

[Severity: Medium]
Should the PSCI SYSTEM_OFF feature be unconditionally exposed to the guest?
According to KVM subsystem guidelines, any new guest-visible behavior must =
be
off by default and discoverable through standard capability enumeration
interfaces to ensure capability negotiation and live migration work properl=
y.

> +		scoped_guard(spinlock, &vcpu->arch.mp_state_lock) {

[Severity: Critical]
Has the vcpu->arch.mp_state_lock been initialized for s390 vCPUs? If this is
a zero-allocated structure and the spinlock lacks the required magic number,
could an untrusted guest executing an HVC call trigger a host kernel panic =
on
kernels configured with CONFIG_DEBUG_SPINLOCK?

> +			WRITE_ONCE(vcpu->arch.mp_state.mp_state, KVM_MP_STATE_STOPPED);
> +		}
> +		kvm_make_all_cpus_request(vcpu->kvm, KVM_REQ_SLEEP);

[Severity: Low]
Is KVM_REQ_SLEEP defined for s390? This macro is typically specific to ARM64
and RISC-V, which might cause a compilation error here.

[Severity: High]
Will this properly stop all vCPUs in an SMP guest? The code updates the pow=
er
state to KVM_MP_STATE_STOPPED only for the currently executing vCPU. When t=
he
broadcasted KVM_REQ_SLEEP request is processed by the other vCPUs, won't th=
ey
check their own unmodified states and immediately resume guest execution?

> +		memset(&vcpu->run->system_event, 0,
> +		       sizeof(vcpu->run->system_event));

[ ... ]

> +static int handle_hvc(struct kvm_vcpu *vcpu)
> +{
> +	vcpu->stat.hvc_exit_stat++;
> +	return kvm_smccc_call_handler(vcpu);
> +}
> +
> +exit_handle_fn arm_exit_handlers[] =3D {
> +	[0 ... ESR_ELx_EC_MAX]	=3D kvm_handle_unknown_ec,
> +	[ESR_ELx_EC_HVC64]	=3D handle_hvc,
> +};

[Severity: Medium]
Similar to the PSCI SYSTEM_OFF issue above, should HVC64 trapping be
unconditionally enabled and mapped to handle_hvc without any capability
checks? KVM guidelines require new emulated instructions and exit reasons to
be enumerable and default to off.

[ ... ]

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> new file mode 100644
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/inject_fault.c
> @@ -0,0 +1,21 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +#include <arm64/kvm_emulate.h>
> +
> +/**
> + * kvm_inject_undefined - inject an undefined instruction into the guest
> + * @vcpu: The vCPU in which to inject the exception
> + *
> + * It is assumed that this code is called from the VCPU thread and that =
the
> + * VCPU therefore is not currently executing guest code.
> + */
> +void kvm_inject_undefined(struct kvm_vcpu *vcpu)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +}

[Severity: Critical]
Since this is an empty stub, will it cause an infinite VM-exit loop? If
kvm_handle_unknown_ec() calls kvm_inject_undefined() to handle an unknown
instruction, it will immediately return 1 to KVM's run loop. Because this
stub fails to advance the guest PC or inject an actual fault, won't the gue=
st
re-execute the exact same faulting instruction and immediately trap again,
leading to a 100% host CPU lockup?

> +
> +int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	return 1;
> +}

[Severity: Critical]
Similar to kvm_inject_undefined(), won't returning 1 from this empty stub
immediately resume the guest without altering its execution state, resulting
in an inescapable infinite loop if a synchronous external abort occurs?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D27
