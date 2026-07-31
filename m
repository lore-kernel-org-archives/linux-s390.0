Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A57D428494;
	Fri, 31 Jul 2026 13:36:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785504972; cv=none; b=iP8jR5+BKWjoFfFd+18mVG8fcj/Dp8USlpdwAbwcptEFSXB5cFz7w4GkClk2RyFP0HPTSSfRlKX8oRpqMk1JMmvkHA0jKIk89ZmD7mEOBpa9OyKoSwZoy1r7Cksd9ZXaigZj/q1C1RZS8+r89jlqvm3tSKiXVEvnvd9ARlr0dK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785504972; c=relaxed/simple;
	bh=JqFRv6vSQM139dcEm/27QDYsF/EixbasJBvMVce5yTc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JmHuJ/HGo+9pn0fyv4oe8WA/ZFotr/Vn3WyMELSiOKzex/43h34y5u51mIXOPDHm1gQHxzxfB6iVRlnKF+ADZgccNMCsTJwVT96D6P5/Qf2O9IlN83Zqfxiw99I8TCMSqyID5+uMvqYk7CZI9mKA8p/KuK6BnhrcpBMNWMrPxzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PvRXHhy9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PvRXHhy9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 999A51F000E9;
	Fri, 31 Jul 2026 13:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785504969;
	bh=j+qZA+5v1cEPX8lnHZpILv+Fytelsq7GlKN1S8M68Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PvRXHhy9GEjuXJyp8MpRDdxFpNt2IaXgEBn14mip98J8eYjYLrJ9no9WGjpTp0cnB
	 Xsyp85FKsbZHSVICQ2xSXRgTYuLno1hE4h5sW+nrYVl+LoDhsVAK6iqZ5zkhmKl0xs
	 nz+s559XR64uAiGNmLBtOhKft0f8Eldl7NWJ4TKiqb1g+/c58d3V3VGlAbH+Sgk+jb
	 X87woJI0D6ojhkNKV2wYdZXIRaC82jBCWu5817oBfM4aO2M7LGpVjsV5B64GZ1cnPi
	 0Q9SmsvKNV1BOX1qBeT48KIxhaWLRFt1vFu2+vYUiGGf4JJPmhgjDy/lbAEaS2Se/b
	 JKwmfJpGChShA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 08/31] KVM: arm64: Use accessor functions for gprs
 during reset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-9-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:36:08 +0000
Message-Id: <20260731133608.999A51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] The macro `kvm_vcpu_get_vregs` incorrectly applies the address-o=
f operator (`&`) to an array, altering its C semantics.
- [Low] The macro `compat_lr_abt` expands to an undeclared identifier `__co=
mpat_lr_ab` instead of `__compat_lr_abt`.
--

--- Patch [8]: [PATCH v5 08/31] KVM: arm64: Use accessor functions for gprs=
 during reset ---
commit 2e02b3a81c0140da07e44b13884114278108bf3e
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Use accessor functions for gprs during reset

Instead of accessing the value directly use assessor function that
abstract the actual location of the register values. Enable other
KVM implementations to reuse this code.

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index 1094a5997fc24..4a23d3662d6b3 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -1183,6 +1183,12 @@ static inline u64 *___ctxt_sys_reg(const struct kv=
m_cpu_context *ctxt, int r)
> =20
>  #define ctxt_sys_reg(c,r)	(*__ctxt_sys_reg(c,r))
> =20
> +#define kvm_vcpu_get_sp_el1(__vcpu) (__ctxt_sys_reg(&(__vcpu)->arch.ctxt=
, SP_EL1))
> +#define kvm_vcpu_get_vreg(__vcpu, _n) (&(__vcpu)->arch.ctxt.fp_regs.vreg=
s[_n])
> +#define kvm_vcpu_get_vregs(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.vregs)

[Severity: Medium]
Does this macro incorrectly apply the address-of operator (&) to the vregs
array, altering its C semantics?

If a developer uses this macro with sizeof(), for example:
memset(kvm_vcpu_get_vregs(vcpu), 0, sizeof(kvm_vcpu_get_vregs(vcpu)))

sizeof() will evaluate to 8 bytes (the size of a pointer) instead of the
actual array size (512 bytes). This can lead to a silent partial memory
operation.

Could this accessor provide unexpected pointer-to-array semantics rather
than decaying to a normal pointer?

> +#define kvm_vcpu_get_fpsr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpsr)
> +#define kvm_vcpu_get_fpcr(__vcpu) (&(__vcpu)->arch.ctxt.fp_regs.fpcr)
> +
>  u64 kvm_vcpu_apply_reg_masks(const struct kvm_vcpu *, enum vcpu_sysreg, =
u64);

I also noticed an issue in arch/arm64/include/asm/ptrace.h introduced in the
patch "arm64: ptrace: Use constants for compat register numbers":

arch/arm64/include/asm/ptrace.h:
> #define compat_lr_abt	regs[__compat_lr_ab]

[Severity: Low]
Can the compat_lr_abt macro fail to compile? It expands to an undeclared
identifier __compat_lr_ab instead of __compat_lr_abt.

Any code attempting to use the compat_lr_abt macro will fail to compile bec=
ause
__compat_lr_ab is undefined.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D8
