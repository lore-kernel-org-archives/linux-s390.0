Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9D4B4CCDCA;
	Mon, 31 Aug 2026 19:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788203036; cv=none; b=aJvDdK9vb6Cn/e4rRSVb/JiWAam9WSoRMmuk3JZFYRxl0UsWgG/Kpgzif980hjTIoAKBiOO/iC4Qa5Jf6Gdl81cUGFdDpUieeZE+JbxAC+ONw/Ki0P3L6uyFZEUO0rJgCFy0rQ0liLnTjGPR7hOOpxDxG0hFNI02QUeaYDIE3ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788203036; c=relaxed/simple;
	bh=ew6KTKnVTvXtp+8OvCAQmyBEo3a5UhhD54vWIE9UHN8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o38+6jdWvhkn688djgufIuvccyGimW5c4WkXktQ7Nu7igShXU/JTYSCH/xI0qxRj7dh6zk/dKYwB23s0sdhkvy3vJkig2n+1baj4Xh3NKRYyjYehcrxmc8T5l0B9elIisxJdaL9ZXwaU3MlLH/JNo/rx2QzQBp7iZ9AugMakoRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TAWwUpHk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TAWwUpHk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B76C01F000E9;
	Mon, 31 Aug 2026 19:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788203035;
	bh=4ZFse3DtnwVfl3DroShBdSIEQn/yKrVT+wEsymoqJfk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TAWwUpHk2NG8rnDbtTI0YE7YRNcmJoGUvKTQpTu49SdrWjMQjxD35QlUfYVLyEp8c
	 J4HQyCAAxiVhIIrPumFlugPtZR7jFp4n6neIdGgFL/5s1XRNXF107cKrNeWEoQYJzY
	 51Ooq7YTFLWyHNqCk1cRZne7GjHuGTdGij6v27axLkvBa8Mk6vf0vRpK2Hap1W480x
	 7EXUi76zYCWho6Hfdk7SMAYae8PgltNpbC1iZV03BmtG+2ExsIKvteKtAfNqx/pUHz
	 Omdmk0L3QTGTRjGGX69GOZ3XmcAKFNu+Eci/xaFLFDBdIQm2XKeNhUihCyQQrNhbkN
	 hxm6wS5U4qPhQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 10/23] arm64: Share arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260831144802.834315-11-seiden@linux.ibm.com>
References: <20260831144802.834315-1-seiden@linux.ibm.com>
 <20260831144802.834315-11-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 19:03:54 +0000
Message-Id: <20260831190354.B76C01F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] Using #ifdef ARM64_S390_COMMON as a marker for shared code hides=
 critical macros from userspace tools, breaking their compilation.
--

commit ef8ab1698ed178bf6b33deea77a5a3895fabd918
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Share arm64 headers with s390

This commit modifies arm64 headers to allow sharing definitions with s390 by
enclosing shared regions within an ARM64_S390_COMMON ifdef block. The
preprocessor symbol is defined for arm64 via the Makefile.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..12cbad460258f 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -45,6 +45,11 @@ KBUILD_CFLAGS	+=3D $(CC_FLAGS_NO_FPU) \
>  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, psabi)
>  KBUILD_AFLAGS	+=3D $(compat_vdso)
> =20
> +# Enable all code shared to s390
> +KBUILD_CFLAGS	+=3D -DARM64_S390_COMMON

[Severity: Medium]
Will this break standalone compilation environments? The macro is only
injected into the core kernel build flags (KBUILD_CFLAGS) in
arch/arm64/Makefile. Standalone tools like KVM selftests or perf, as well
as out-of-tree tracing scripts that do not inherit these core flags, will
not have ARM64_S390_COMMON defined.

[ ... ]

> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index 5261c21a437cc..a8ddce3921b87 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
> @@ -39,6 +39,7 @@
> =20
>  #define KVM_MAX_VCPUS VGIC_V3_MAX_CPUS
> =20
> +#ifdef ARM64_S390_COMMON
>  #define KVM_VCPU_MAX_FEATURES 10

[Severity: Medium]
Does this code break the struct kvm_arch definition for environments where
ARM64_S390_COMMON is not defined? The KVM_VCPU_MAX_FEATURES macro in
arch/arm64/include/asm/kvm_host.h is hidden inside the ifdef block, but it
is used outside the block to define the size in
DECLARE_BITMAP(vcpu_features, KVM_VCPU_MAX_FEATURES).

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
Does hiding the sys_reg macro inside the ifdef block break the compilation
of all SYS_* registers for tools that sync arch/arm64/include/asm/sysreg.h?
If the tool does not define ARM64_S390_COMMON, dependent macros like
SYS_SCTLR_EL1 will become undefined.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831144802.8343=
15-1-seiden@linux.ibm.com?part=3D10
