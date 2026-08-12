Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 038A544DB6D;
	Wed, 12 Aug 2026 16:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786551612; cv=none; b=PcZdaUaGvNFLpKGas7sJEZh9wqDdY7OBm2IjpiUgID9ACIYdrkTubv98GOjKlU6ckUtwc24OHgmrRVjh6t9x3qahkFhu3YH2asCFk459kGp/wwSAu94dTIXJpMpCosQvZEaCPXp2Jmckq44XsTU0PF85K42Py7iL1NXGRZqw7Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786551612; c=relaxed/simple;
	bh=+NWfW28nbPmYfTbko0osMS5UamyB4ywhIenqw+HHgko=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=kPq8w8jEEVl9nzLOc8wGC1xmPTh+3+C7DrP8T1es3lyCDAJlan8UMXU2R/+mWV/xXsG0ToTKBHvNE19yoXry8VxvM+Sb2gq4WbOjmCP9h49c742p6aUo7ONqjARV3nT4uAfAysvv5JDAE30EuASgffW/tJCNTwxdor6nhMYIo90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S39IFU/z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="S39IFU/z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB031F000E9;
	Wed, 12 Aug 2026 16:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786551610;
	bh=OY0Va5TMCH71I+jF9Yi14gEWikEzj7wpJatvmXwLXe0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=S39IFU/zjniTN5Cat1Lz4mC5KIetOOv2XwVPAgxX+zFimDZsCQ35xdouNgt1SBiZq
	 MLaC6Px8HFxbO8O92juhS4s+NL+Fobefj4FeEe5pSpoeCglRaN9+/Fd4QgSmp67eKQ
	 dH5VwP5Wk967N7ULu1+99CV5DwpQoKiIuR3BEnnGTBjm+IieGfBHALDccAv6jKNqZ0
	 uULO+8TXTiGpchqAmzJBPCiEh9KIck0ezrowQJCXrI1iJrciIrZksPvFr3Fet5rWVN
	 5+VTp54ys1F4dj69K8bwZvQ7byK48QgUjXZaWhpKNoRW8iWZ3qh+Kq7/zoB27CLV0x
	 NbYe1WV9G6QxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 10/33] arm64: Share arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, kvmarm@lists.linux.dev, "Heiko
 Carstens" <hca@linux.ibm.com>, "Oliver Upton" <oupton@kernel.org>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Marc Zyngier" <maz@kernel.org>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812153631.3376090-11-seiden@linux.ibm.com>
References: <20260812153631.3376090-1-seiden@linux.ibm.com>
 <20260812153631.3376090-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:20:09 +0000
Message-Id: <20260812162010.1AB031F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Medium] Gating core arm64 macros behind `#ifdef ARM64_S390_COMMON` break=
s userspace tooling (perf, KVM selftests, BPF) and creates inconsistent hea=
der views for linker scripts.
- [Medium] Using active C preprocessor `#ifdef` blocks as text-extraction m=
arkers for another architecture creates fragile coupling and pollutes the a=
rm64 build system.
--

--- Patch [10]: [PATCH v6 10/33] arm64: Share arm64 headers with s390 ---
commit 20e1eb14886be076f6d4d8836cb6c7175057685e
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Share arm64 headers with s390

Allow sharing of arm64 headers with s390 by marking the shared regions
or add a comment that the whole file is shared. The preprocessor symbol
ARM64_S390_COMMON is always defined for arm64.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..1cd7cd94a8554 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -43,7 +43,9 @@ CC_FLAGS_NO_FPU	:=3D -mgeneral-regs-only
>  KBUILD_CFLAGS	+=3D $(CC_FLAGS_NO_FPU) \
>  		   $(compat_vdso) $(cc_has_k_constraint)
>  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, psabi)
> +KBUILD_CFLAGS	+=3D -DARM64_S390_COMMON
>  KBUILD_AFLAGS	+=3D $(compat_vdso)
> +KBUILD_AFLAGS	+=3D -DARM64_S390_COMMON

[Severity: Medium]
Since this macro is injected into C and assembly compilation flags, does th=
is
omit it from KBUILD_CPPFLAGS used for linker scripts?

Could this create an inconsistency where the C and assembly code sees the s=
hared
blocks, but the linker script preprocessing silently strips them?

[ ... ]

> diff --git a/arch/arm64/include/asm/kvm_emulate.h b/arch/arm64/include/as=
m/kvm_emulate.h
> index a34a9417ff4da..09f04a5686a18 100644
> --- a/arch/arm64/include/asm/kvm_emulate.h
> +++ b/arch/arm64/include/asm/kvm_emulate.h
> @@ -47,6 +47,7 @@ void kvm_skip_instr32(struct kvm_vcpu *vcpu);
>  int kvm_inject_dabt_excl_atomic(struct kvm_vcpu *vcpu, u64 addr);
>  int kvm_inject_serror_esr(struct kvm_vcpu *vcpu, u64 esr);
> =20
> +#ifdef ARM64_S390_COMMON
>  void kvm_inject_undefined(struct kvm_vcpu *vcpu);
>  void kvm_inject_sync(struct kvm_vcpu *vcpu, u64 esr);

[Severity: Medium]
Is using an active C preprocessor macro as a text-extraction marker for
another architecture a robust design?

By using an active ifdef to delineate text for an s390 extraction script, it
forces arm64 to modify its global Makefiles just to parse its own native
headers. Would it be safer to use specially formatted code comments for scr=
ipt
scraping to avoid altering C preprocessor semantics?

[ ... ]

> diff --git a/arch/arm64/include/asm/sysreg.h b/arch/arm64/include/asm/sys=
reg.h
> index ab205f9db94ad..1c5c4df260bea 100644
> --- a/arch/arm64/include/asm/sysreg.h
> +++ b/arch/arm64/include/asm/sysreg.h
> @@ -16,6 +16,8 @@
> =20
>  #include <asm/gpr-num.h>
> =20
> +#ifdef ARM64_S390_COMMON
> +
>  /*
>   * ARMv8 ARM reserves the following encoding for system registers:
>   * (Ref: ARMv8 ARM, Section: "System instruction class encoding overview=
",
> @@ -50,6 +52,8 @@
>  #define sys_reg_CRm(id)	(((id) >> CRm_shift) & CRm_mask)
>  #define sys_reg_Op2(id)	(((id) >> Op2_shift) & Op2_mask)
> =20
> +#endif /* ARM64_S390_COMMON */

[Severity: Medium]
Will gating fundamental arm64 macros like sys_reg() behind this macro break
userspace tooling (such as perf, KVM selftests, and BPF)?

When these headers are synced to tools/, their independent Makefiles will n=
ot
inherit the kernel's KBUILD_CFLAGS. This means the macro is undefined and
core arm64 macros are completely hidden from those builds.

[ ... ]

> @@ -1251,6 +1262,8 @@
>  	par;								\
>  })
> =20
> +#ifdef ARM64_S390_COMMON
> +
>  #define SYS_FIELD_VALUE(reg, field, val)	reg##_##field##_##val
> =20
>  #define SYS_FIELD_GET(reg, field, val)		\

[Severity: Medium]
Similar to the sys_reg() macro above, does hiding widely used field-extract=
ion
macros behind this conditional break builds for external tools that lack the
new compiler flag when headers are synced?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812153631.3376=
090-1-seiden@linux.ibm.com?part=3D10
