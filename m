Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1EB03B7769;
	Fri, 31 Jul 2026 13:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785505158; cv=none; b=OESQzjMXRSusHRXgzYhGG+FHgL8Ug0MZ5w1BiSNXbQSIASoQQ03yHtWgcPEPBxuuIithBsyfXh2UJ1/uktFNvJHejouxnb4hG2SzFSFMPdnXOAEXSxUZgfLDJgWgY8+8xyQHoKeWuQRUlqUq27Lk1YcXAaiVPZAhEvowrccVzW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785505158; c=relaxed/simple;
	bh=uTUx2UDAKy4xcYZVy8G9awlUI65Ugehe8FEZDSrWhpw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uN8tMFHrKpZM3tnQ7sRWb6Gy4XYoCmPH8+DdCYK+pcIcIASQ5i7ICql/h/cTWlDkTjOYJEijLOVOigmCzhcNzNR1a7G4WGKhakad3KBM5Mb3oBfFqBe8Bln8gba2/r30I2HSUu+VuGyH8+OoRwE7FXheHf9nJwHV98FJl9tXtsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WL1J2HYQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WL1J2HYQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81E11F000E9;
	Fri, 31 Jul 2026 13:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785505156;
	bh=KqvbYKRpgpfNbI+C0BU5opU/PsWQl449LBN0qokR2wc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WL1J2HYQ3vHGrXx6Sg61LmeBsrABlvpjIVPo5u2IERoxyp+cLAttM7bQBPkfk0xDa
	 bMC4Bj+Fjq6YssYpqmyvSu7ZuPasCu2GkGzD6xuJLmScKB1crfy9l0/A6eG/NNd+jM
	 z9J3sqycJoMqpKU9aOtiV/upw3Vbz1E7pUEKRJUfHWgn8pByjoSQb4ezTGUnICXLYD
	 8/mmzH2tMHdID59+3jqXomj808Ze6nA+icqYoFzoPznELHvLdp3Yn2OT/0Ic2CrwMU
	 dAPZPXgR1uRhxW8u+FjGQtR2tPoWh9qtc7OgmPEefAQJst7Vap3TVlxHHFPqAX1EJy
	 +V+Pnfw+wqdCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/31] arm64: Share arm64 headers with s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Marc
 Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>
In-Reply-To: <20260731130902.654679-12-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-12-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 13:39:15 +0000
Message-Id: <20260731133915.E81E11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Sharing architecture-private headers directly with another archite=
cture (s390) violates fundamental kernel design principles.
- [High] The `#ifdef ARM64_S390_COMMON` macro creates an incomplete type bu=
ild breakage and inverted logic.
--

--- Patch [11]: [PATCH v5 11/31] arm64: Share arm64 headers with s390 ---
commit ab90259bd4d46a7a1b7b9c187fcf2bfc3985993e
Author: Steffen Eiden <seiden@linux.ibm.com>

arm64: Share arm64 headers with s390

This commit modifies arm64 Makefiles and headers to allow sharing them with
the s390 architecture. It introduces an ARM64_S390_COMMON preprocessor macro
and adds comments to mark shared regions.

> diff --git a/arch/arm64/Makefile b/arch/arm64/Makefile
> index 6b005c8fef706..1cd7cd94a8554 100644
> --- a/arch/arm64/Makefile
> +++ b/arch/arm64/Makefile
> @@ -43,7 +43,9 @@ CC_FLAGS_NO_FPU	:=3D -mgeneral-regs-only
>  KBUILD_CFLAGS	+=3D $(CC_FLAGS_NO_FPU) \
>  		   $(compat_vdso) $(cc_has_k_constraint)
>  KBUILD_CFLAGS	+=3D $(call cc-disable-warning, psabi)
> +KBUILD_CFLAGS	+=3D -DARM64_S390_COMMON

[Severity: High]
Is it appropriate to add a cross-architecture define directly to the arm64
Makefile?

Sharing architecture-private headers directly with another architecture (s3=
90)
violates strict architectural separation. Could this shared code be abstrac=
ted
into generic kernel headers (e.g., under include/linux/, include/kvm/, or
include/asm-generic/) instead of exposing arch/arm64/ headers to s390?

[ ... ]
> diff --git a/arch/arm64/include/asm/kvm_host.h b/arch/arm64/include/asm/k=
vm_host.h
> index 875fc7c3366be..83fefceed952b 100644
> --- a/arch/arm64/include/asm/kvm_host.h
> +++ b/arch/arm64/include/asm/kvm_host.h
[ ... ]
> @@ -832,6 +835,8 @@ extern s64 kvm_nvhe_sym(hyp_physvirt_offset);
>  extern u64 kvm_nvhe_sym(hyp_cpu_logical_map)[NR_CPUS];
>  #define hyp_cpu_logical_map CHOOSE_NVHE_SYM(hyp_cpu_logical_map)
> =20
> +#ifdef ARM64_S390_COMMON
> +
>  struct vcpu_reset_state {
>  	unsigned long	pc;
>  	unsigned long	r0;
> @@ -839,6 +844,8 @@ struct vcpu_reset_state {
>  	bool		reset;
>  };
> =20
> +#endif /* ARM64_S390_COMMON */
> +

[Severity: High]
Will this cause an incomplete type compilation error if ARM64_S390_COMMON is
not defined?

Looking further down in this file, struct kvm_vcpu_arch instantiates this
struct by value outside of any macro guards:

struct kvm_vcpu_arch {
	struct kvm_cpu_context ctxt;
...
	/* Additional reset state */
	struct vcpu_reset_state	reset_state;
...
};

If an architecture includes asm/kvm_host.h without defining the macro, the
compiler skips the definition of struct vcpu_reset_state, leading to a hard
build failure when it parses struct kvm_vcpu_arch.

Additionally, does it make sense that ARM64_S390_COMMON guards
strictly ARM-specific registers (like pc, r0, and pstate)? If s390 defines
this macro to access shared code, it will also pull in these architecture
specific definitions that it cannot use.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D11
