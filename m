Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD3E4383C93;
	Mon, 31 Aug 2026 20:33:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788208434; cv=none; b=ByI7ipBv67SF7gS+nnumEgjJhTxsWcliBnwlZjGSx7Te1ui3Dm49mnFOQ8eenutrcNpdSuNWdZjBjRM1zzu3BVjQ9IE9mB/7FkZjb5EX2T9Pzl5X5D1AMA+Er2/wBqu3sNRoii1SbzveLETIKjiprlu1wTC1+62nhhNEEgGMX3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788208434; c=relaxed/simple;
	bh=rqvLRQLW2C/hl9nVjV9avJvcx/aCjWNjx0MQv+OFJ0A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jTTccAMGVRfEfubSpHkiwC8vvKUwdtkBmXPFrdgPz2evIf7OkTDigojyxq8BDG3LyHhqnItxv80qoy3g2Bl9JZgR+oOKEYFevfQbdcKJrNwJDupTr9kBsZbyNFci0AVO5Z49utXFRZiV2ith9qEEHpAWuQF2bPpBnNMd+tnZeqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V+IguxIc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V+IguxIc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0892C1F000E9;
	Mon, 31 Aug 2026 20:33:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788208432;
	bh=EOQF6go/RnMqwxHLJugdPRjze0XZP/oR0HcQxThjwxw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V+IguxIcEFTjBj2zeg/+xd2xI4S5Tpwv4Ftwpvl8veGYacXSOLBvsQqm1SIs6iR7L
	 JXU6Tt1Vh2ghXXf2j1jzWqnWJeXP6P5RAfpMwNwheP6ccWpW3KFCrXlq5o1dGvkR8X
	 uJBCcN5jKSWtKBIeSxE0xFnMjmpkiWQqlYsSVHy0yfCeX/fYjPyyB57ho54ow7MRMy
	 KTzlE2TG5RM3XXQqonOT/wUb4CKSPH/CDefRwowOhqyHH+wKSvtMVrHF1JdH1Y5G9N
	 J55ORMyOKJ4v0rtsP1GHx45hFAdp58busmxcG9lBQP3nY8HL6DAOznFIAGcw4R5CPN
	 z6DyCnYQ91okw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/20] KVM: s390: arm64: Implement arm sysreg
 managing infrastructure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Heiko Carstens" <hca@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260831145536.913567-14-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-14-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:33:51 +0000
Message-Id: <20260831203352.0892C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The s390-specific definition of `__vcpu_rmw_sys_reg` incorrect=
ly swaps the register ID (`R`) and value (`V`) parameters compared to the s=
hared ARM64 implementation.
- [Critical] Time-of-Check to Time-of-Use (TOCTOU) race with vCPU preemptio=
n and illegal use of `smp_processor_id()` in a preemptible context causes a=
 host `BUG_ON` panic.
- [High] Missing trap handler for `MIDR_EL1` causes guest crashes with an U=
NDEF exception on boot.
- [High] Guest-reachable `WARN(true)` in `kvm_handle_sys_reg` allows a mali=
cious guest to spam the host kernel log.
--

commit 1e6a91a5668b6ea306fd97aa5d57b2154d91120f
Author: Steffen Eiden <seiden@linux.ibm.com>
KVM: s390: arm64: Implement arm sysreg managing infrastructure

This commit implements the infrastructure for the s390 host to manage arm64
guest system registers. It allows the host to read and write non-ID system
registers using new EASR/SASR instructions, while trapping and handling gue=
st
accesses to ID registers.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> --- a/arch/s390/include/asm/kvm_host_arm64.h
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
> @@ -221,4 +244,183 @@ static inline void kvm_arch_async_page_present_queu=
ed(struct kvm_vcpu *vcpu)
> =20
>  #define kvm_supports_32bit_el0() false
> =20
> +#define __vcpu_sys_reg(__vcpu, __reg) \
> +	vcpu_read_sys_reg(__vcpu, __reg)
> +
> +#define __vcpu_assign_sys_reg(__vcpu, __reg, __val) \
> +	vcpu_write_sys_reg(__vcpu, __val, __reg)
> +
> +#define __vcpu_rmw_sys_reg(C, V, OP, R)		\
> +({						\
> +	u64 __val =3D vcpu_read_sys_reg(C, R);	\
> +	__val OP V;				\
> +	vcpu_write_sys_reg(C, __val, R);	\
+})

[Severity: Critical]
Does this override transpose the register ID and value arguments compared t=
o the
shared ARM64 implementation?

The shared ARM64 code expects this macro to receive (vcpu, reg, op, val).
This s390 override defines it as (C, V, OP, R). Any read-modify-write system
register operation using this macro (for instance, PMU updates) will attemp=
t to
read from a register ID equal to the bitmask value, and use the actual regi=
ster
ID as the bitmask, causing data corruption and host crashes.

> +/**
> + * _vcpu_read_sys_reg() - read a guest sysreg with easr
> + * - R - sysreg id; must be readable by easr; must be compile time const=
ant
> + *
> + *   if SYSREGS_ON_CPU: proceed with flags =3D 0
> + *   otherwise:         proceed with either
> + *                         read:  flags =3D EASR_FLAG_SA
> + *                         write: flags =3D SASR_FLAG_INITIALIZED
> + *
> + */
> +#define _vcpu_read_sys_reg(C, R) \
> +	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
> +		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu); \
> +		(vcpu_is_loaded(C)) \
> +			? __vcpu_read_sr((C), (R), 0) \
> +			: __vcpu_read_sr((C), (R), EASR_FLAG_SA); })
> +
> +/**
> + * _vcpu_write_sys_reg() - write a guest sysreg with sasr
> + * - R - sysreg id; must be readable by sasr; must be compile time const=
ant
> +
> + *   if SYSREGS_ON_CPU: proceed with flags =3D 0
> + *   otherwise:         proceed with either
> + *                         read:  flags =3D EASR_FLAG_SA
> + *                         write: flags =3D SASR_FLAG_INITIALIZED
> + */
> +#define _vcpu_write_sys_reg(C, V, R) \
> +	({	BUILD_BUG_ON(!__builtin_constant_p((R))); \
> +		BUG_ON(vcpu_is_loaded(C) && smp_processor_id() !=3D (C)->cpu); \
> +		(vcpu_is_loaded(C)) \
> +			? __vcpu_write_sr((C), (V), (R), 0) \
> +			: __vcpu_write_sr((C), (V), (R), SASR_FLAG_INITIALIZED); })

[Severity: Critical]
Is it safe to call smp_processor_id() in these macros?

These macros are invoked by kvm_handle_sys_reg(), which executes in a
preemptible context. Calling smp_processor_id() here will trigger a kernel
warning.

Furthermore, if the vCPU thread is preempted and migrated between evaluating
smp_processor_id() and checking (C)->cpu, this BUG_ON() will panic the host=
. A
guest could repeatedly trigger sysreg exits to intentionally cause a host d=
enial
of service.

[ ... ]

> diff --git a/arch/s390/kvm/arm64/sys_regs.c b/arch/s390/kvm/arm64/sys_reg=
s.c
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/sys_regs.c
> @@ -0,0 +1,750 @@

[ ... ]

> +static const struct sys_reg_desc sys_reg_descs[] =3D {
> +	/* Op0 =3D 2 */
> +	{ SYS_DESC(SYS_OSLAR_EL1), trap_oslar_el1 },
> +	{ SYS_DESC(SYS_OSLSR_EL1), trap_oslsr_el1, reset_oslsr_el1, OSLSR_EL1,
> +	  OSLSR_EL1_OSLM_IMPLEMENTED, NULL, set_oslsr_el1 },
> +
> +	/* Op0 =3D 3 */
> +	/* Op1 =3D 0 */
> +	/* CRn =3D 0 */
> +	/* CRm =3D 0 */
> +
> +	{ SYS_DESC(SYS_MIDR_EL1), NULL, reset_midr, 0, GENMASK_ULL(31, 0),
> +	  get_id_reg, set_imp_id_reg },

[Severity: High]
Does this missing access handler cause guest boot failures?

The access handler here is set to NULL instead of access_imp_id_reg. When a
guest reads MIDR_EL1 (which Linux does early in boot), kvm_handle_sys_reg()=
 uses
perform_access(). Since the handler is NULL, this will fall back to bad_tra=
p(),
injecting an undefined instruction exception into the guest and printing a
WARN_ONCE on the host.

[ ... ]

> +int kvm_handle_sys_reg(struct kvm_vcpu *vcpu)
> +{
> +	const struct sys_reg_desc *desc =3D NULL;
> +	struct sys_reg_params params;
> +	unsigned long esr =3D kvm_vcpu_get_esr(vcpu);
> +	int Rt =3D kvm_vcpu_sys_get_rt(vcpu);
> +
> +	trace_kvm_handle_sys_reg(esr);
> +
> +	params =3D esr_sys64_to_params(esr);
> +	params.regval =3D vcpu_get_reg(vcpu, Rt);
> +
> +	/* System registers have Op0=3D=3D{2,3}, as per DDI487 J.a C5.1.2 */
> +	if (params.Op0 =3D=3D 2 || params.Op0 =3D=3D 3)
> +		desc =3D find_reg(&params, sys_reg_descs, num_sys_reg_descs);
> +	else
> +		WARN(true, "system instruction handling not supported");

[Severity: High]
Can a malicious guest trigger this warning to flood the host kernel log?

If a guest intentionally executes a trapped cache maintenance instruction
(like DC CIVAC), it generates an exception with Op0 =3D=3D 1. This hits the
unconditional WARN() here, violating KVM guidelines against guest-reachable
assertions and allowing a denial of service via log spam.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D13
