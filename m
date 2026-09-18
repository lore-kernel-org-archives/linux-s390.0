Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 688BF50EBE6;
	Fri, 18 Sep 2026 16:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789747364; cv=none; b=gTqpxxBpzJHZgShuwpT2NfwsQJcGTBF9ZAHcNWgN6lTepDJRcXxnba7dSC9XSnCgaxAgQkDXcfXIfy9wWWPSUYR1mi81PNB/Q166cf0rPRjb+fdJf36FM42GmO5NSwFBPuZKbZC3lJh4/lCXJj0GFbJct5tHg1RVaPJTH7D/VlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789747364; c=relaxed/simple;
	bh=zjF/nuHT+hcfXEUDyCAdFezyJns04a6a11r//OXWfq4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EIUem7a1z4kD8isc8L/EljWvpZ6GJrWk3AiUEILAI2/m02tPN1RGH0UA0wVICyTYb+a4/de/S/q6ZqVX2/9agI+HLHYPpPNQALzvv8yotRGJW3mK/xa9f6ebZpvAli9JLIPDIRVrQUfvV34SxGCTdtq5QtR8k7I1gmqDbOm9d5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZtyKogZc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZtyKogZc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BED01F000FF;
	Fri, 18 Sep 2026 16:02:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789747363;
	bh=eiyaJssRbAoYsQp/Go8UZ9f6pmSgejn6LSoraAWiD4E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ZtyKogZcD+MckK9V9ttpge7MSas3sn40aLicdy0P7dDBRHj3+iU2XEKJ8jYVJE/uf
	 Rkm7BFoq88Wt8Ih+vJPXaHBMSt2KXAge9TQSkoSCRpLlGGOemMC/Ip+mUSP514JqVD
	 54xRxgfeVyo+prb40B1aruJ3eEjgwIEaaQQtaY/lFIerDoAmv14Lp1geVyRhCUnnu5
	 GhOgRehQoMddWb5fYsLNhLnm2v3FStp6hB/Ot7G82jwP0iEky6wFhyS4gHHyR9hNry
	 YIM1gJM9Jd5eWhD1ZNcVQShkUhNz3BRBJEt/+q9GMfU+Kg+hJXA06DaHSq/68dADtB
	 pACGvwMThgf3g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 17/29] KVM: arm64: Share arm64 code with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260918133107.1042730-18-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-18-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 16:02:42 +0000
Message-Id: <20260918160242.8BED01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] kvm: arm64: severe cross-architecture coupling using preprocesso=
r markers
- [Low] kvm: arm64: incomplete abstraction of ELR_EL1 and SPSR registers
--

commit 336c61211f9a8d50d065b41830fda851e8868db0
Author: Steffen Eiden <seiden@linux.ibm.com>
Subject: KVM: arm64: Share arm64 code with s390

This commit marks functions in the arm64 KVM implementation that s390 can=20
use as shared functions. It does this by wrapping them in ARM64_S390_COMMON=
=20
preprocessor guards.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 8b080804bc90b..6b92a3c1d490d 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1603,6 +1603,7 @@ static unsigned long system_supported_vcpu_features=
(void)
>  	return features;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,

[Severity: Medium]
Does this approach create a severe cross-architecture coupling?

Using a preprocessor macro like this as a purely textual marker for an awk=
=20
script (copy-arm64c.awk) on s390 to blindly extract arm64 C code leaves
callers unprotected. To prevent the arm64 build from failing, the macro must
be globally appended to KBUILD_CFLAGS in arch/arm64/Makefile, because
callers of the wrapped functions (e.g., kvm_arm_num_regs() calling
num_core_regs()) are left outside the macro block.

Should cross-architecture sharing be properly implemented via common kernel
directories (such as virt/kvm), rather than by parsing macros?

[ ... ]
> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index 773f6c8e50265..6ca5a9f357cdb 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -62,6 +62,7 @@ const struct kvm_stats_header kvm_vcpu_stats_header =3D=
 {
>  		       sizeof(kvm_vcpu_stats_desc),
>  };
> =20
> +#ifdef ARM64_S390_COMMON
>  static bool core_reg_offset_is_vreg(u64 off)

[Severity: Low]
Does this incomplete abstraction force downstream workarounds in s390?

By wrapping this section to share it with s390, the abstraction of register
accesses remains incomplete. For instance, core_reg_addr() accesses ELR_EL1
and all SPSR variants by directly referencing the ARM64-specific
vcpu->arch.ctxt structure:

case KVM_REG_ARM_CORE_REG(elr_el1):
        return __ctxt_sys_reg(&vcpu->arch.ctxt, ELR_EL1);
case KVM_REG_ARM_CORE_REG(spsr[KVM_SPSR_ABT]):
        return &vcpu->arch.ctxt.spsr_abt;

Does this force the s390 architecture to artificially replicate the ARM64
kvm_cpu_context layout with dummy structures (like spsr_abt) to allow the
extracted code to compile, defeating the purpose of the register abstraction
layer?

[ ... ]
> @@ -543,6 +546,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcp=
u, struct kvm_regs *regs)
>  	return -EINVAL;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
>  				 u64 __user *uindices)

[Severity: Medium]
This is another instance of wrapping arm64 code with s390-specific macros
for code extraction. Are callers of this function properly protected?

For example, callers like kvm_arm_num_regs() that call num_core_regs()
remain outside the macro block, leading to the same architectural coupling
issues mentioned above.

[ ... ]
> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> index d1c3a352d5a22..5161102da5077 100644
> --- a/arch/arm64/kvm/mmio.c
> +++ b/arch/arm64/kvm/mmio.c
> @@ -10,6 +10,7 @@
> =20
>  #include "trace.h"
> =20
> +#ifdef ARM64_S390_COMMON
>  void kvm_mmio_write_buf(void *buf, unsigned int len, unsigned long data)

[Severity: Medium]
Here the macro is used to wrap almost the entire file's contents, showing
the extreme extent of this cross-architecture code sharing mechanism.=20

Does this indicate that the shared logic should be abstracted into a common
file rather than conditionally compiled out of arm64 specific files?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D17
