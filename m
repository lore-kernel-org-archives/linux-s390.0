Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3C9042A15C;
	Mon,  6 Jul 2026 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783329712; cv=none; b=eCL+KxyLfv8EKLJBOONGiucMIEdVh234bpmUuVffAL0EhjC5E5mbLGFVcsVwsroikmuKV1VJpsXxSRudYVT39o4SxuGNFv9pgfM75HKmwxQx1m7uWFxMp4YDWTmvVq+S6yjq4eo2BWV/FSROOoDYOeHIY+uS3D1fzIpvaajpCOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783329712; c=relaxed/simple;
	bh=saPk3pBmRM6U63XuVv+puOtKxBvDCowVonTGuTBGr5c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=IgGTpLdyOWyZEO9tIIqnYHt4DquERj0joCTL6UM61eKeyK0vS8ITyGcM529DIqOXHE6yNYefegirWJZisEjtmJcj5LsmSX3mxBvNolP/w8Us+lplj09sZsKJL4ivKBDnVBNXK0osm1Si495NDEZ2PD2J1QhbjU8T3Mi+LBEU9j8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GUpA5iXJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GUpA5iXJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69BC1F000E9;
	Mon,  6 Jul 2026 09:21:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783329707;
	bh=sARha7Q8yG3uNCFK4HQ0DJkOVC6nBxHqVKxdfdFIZ/s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GUpA5iXJ5q+fygz6MQlooxZg3Bgm3pATetlxlQHyb0e5oAmJrKyYQ9Xjjg2VaHlpe
	 7VKmaRdut+hgLdjlj8oJEHkjXS2vsD1x95YLc8nnrGW/EoJS1xawNAeOC8rURQIpCN
	 bJy/Y2XW+AcBUFwV1WuT0JxqLN/7u1l1Qbfi2uLdAaNzGNgZYl7oKBmCn2k4XbmlrU
	 4d+4fe4u91xiGUPhI2ON2NyTo4Xl2kVr4wdPQMcxMfDj4UVzMclhLkLapsScBG6/WT
	 MEdcoLblZ39R09PX93F9Q9oKbGdkTfe/GN6Nznotd+JBEWKejzkO6QwUT/HGFaCofi
	 73h74RZMGblMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 08/27] KVM: arm64: Prepare sharing arm64 code with
 s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvmarm@lists.linux.dev, "Marc
 Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Oliver Upton" <oupton@kernel.org>
In-Reply-To: <20260706085229.979525-9-seiden@linux.ibm.com>
References: <20260706085229.979525-1-seiden@linux.ibm.com>
 <20260706085229.979525-9-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 06 Jul 2026 09:21:46 +0000
Message-Id: <20260706092146.A69BC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] The patch misuses C preprocessor `#ifdef` directives to exclude tra=
cepoints, resulting in catastrophic syntax errors because it leaves stateme=
nts in the global scope.
- [Low] Critical ARM64 functions and definitions are wrapped in `#ifdef ARM=
64_S390_COMMON`, stripping them from standard ARM64 builds and causing unde=
fined reference errors because their callers remain unconditionally compile=
d.
--

commit 651f0f9137d42f2814e4612c746de86e829e6666
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: arm64: Prepare sharing arm64 code with s390

This commit marks functions that s390 can use to implement arm on s390 as
shared functions, without introducing functional changes.

> diff --git a/arch/arm64/kvm/arm.c b/arch/arm64/kvm/arm.c
> index 50adfff75be82..c992308b2dceb 100644
> --- a/arch/arm64/kvm/arm.c
> +++ b/arch/arm64/kvm/arm.c
> @@ -1580,6 +1580,7 @@ static unsigned long system_supported_vcpu_features=
(void)
>  	return features;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static int kvm_vcpu_init_check_features(struct kvm_vcpu *vcpu,
>  					const struct kvm_vcpu_init *init)
>  {

[Severity: Low]
Will this cause undefined reference errors on standard ARM64 builds?=20

The caller of kvm_vcpu_init_check_features() remains unconditionally compil=
ed,
so the symbol will be missing when ARM64_S390_COMMON is not defined.

> diff --git a/arch/arm64/kvm/guest.c b/arch/arm64/kvm/guest.c
> index b01d6622b8720..5a202cfd27bcb 100644
> --- a/arch/arm64/kvm/guest.c
> +++ b/arch/arm64/kvm/guest.c
> @@ -543,6 +543,7 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcp=
u, struct kvm_regs *regs)
>  	return -EINVAL;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static int copy_core_reg_indices(const struct kvm_vcpu *vcpu,
>  				 u64 __user *uindices)
>  {

[Severity: Low]
Does this missing symbol cause a link failure for kvm_arm_copy_reg_indices(=
)?
The function is compiled out here, but the caller isn't.

> diff --git a/arch/arm64/kvm/handle_exit.c b/arch/arm64/kvm/handle_exit.c
> index 54aedf93c78b6..d511af145ee6a 100644
> --- a/arch/arm64/kvm/handle_exit.c
> +++ b/arch/arm64/kvm/handle_exit.c
> @@ -213,6 +213,7 @@ static int kvm_handle_guest_debug(struct kvm_vcpu *vc=
pu)
>  	return 0;
>  }
> =20
> +#ifdef ARM64_S390_COMMON
>  static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
>  {

[Severity: Low]
Will this lead to an undefined reference?=20

kvm_handle_unknown_ec() is conditionally removed here, but it remains
referenced in the unconditionally compiled arm_exit_handlers array.

[ ... ]

> @@ -404,6 +407,7 @@ static exit_handle_fn arm_exit_handlers[] =3D {
>  	[ESR_ELx_EC_GCS]	=3D kvm_handle_gcs,
>  };
> =20
> +#ifdef ARM64_S390_COMMON
>  static exit_handle_fn kvm_get_exit_handler(struct kvm_vcpu *vcpu)
>  {

[Severity: Low]
Is it intentional to compile out kvm_get_exit_handler() and
handle_trap_exceptions()?=20

The handle_exit() caller relies on them unconditionally, which may cause a
build failure.

> diff --git a/arch/arm64/kvm/mmio.c b/arch/arm64/kvm/mmio.c
> index e2285ed8c91de..876d56dd5b640 100644
> --- a/arch/arm64/kvm/mmio.c
> +++ b/arch/arm64/kvm/mmio.c

[ ... ]

> @@ -135,8 +136,11 @@ int kvm_handle_mmio_return(struct kvm_vcpu *vcpu)
>  		if (!kvm_vcpu_dabt_issf(vcpu))
>  			data =3D data & 0xffffffff;
> =20
> +#endif /* ARM64_S390_COMMON */
>  		trace_kvm_mmio(KVM_TRACE_MMIO_READ, len, run->mmio.phys_addr,
>  			       &data);
> +		//TODO  tracing
> +#ifdef ARM64_S390_COMMON
>  		data =3D vcpu_data_host_to_guest(vcpu, data, len);
>  		vcpu_set_reg(vcpu, kvm_vcpu_dabt_get_rd(vcpu), data);
>  	}

[Severity: Low]
Does this inverted preprocessor logic break the build on standard ARM64?

Since kvm_handle_mmio_return() starts inside an ifdef ARM64_S390_COMMON blo=
ck,
placing an endif here exposes the trace_kvm_mmio() call to the global scope
when the flag is not set, resulting in invalid C syntax.

[ ... ]

> @@ -171,8 +175,11 @@ int io_mem_abort(struct kvm_vcpu *vcpu, phys_addr_t =
fault_ipa)
>  	 * though, so directly deliver an exception to the guest.
>  	 */
>  	if (!kvm_vcpu_dabt_isvalid(vcpu)) {
> +#endif /* ARM64_S390_COMMON */
>  		trace_kvm_mmio_nisv(*vcpu_pc(vcpu), esr,
>  				    kvm_vcpu_get_hfar(vcpu), fault_ipa);
> +		//TODO tracing
> +#ifdef ARM64_S390_COMMON
> =20
>  		if (vcpu_is_protected(vcpu))
>  			return kvm_inject_sea_dabt(vcpu, kvm_vcpu_get_hfar(vcpu));

[Severity: Low]
Similar to the issue above, does this leave trace_kvm_mmio_nisv() in the
global scope and cause syntax errors when ARM64_S390_COMMON is undefined?

> diff --git a/arch/arm64/kvm/reset.c b/arch/arm64/kvm/reset.c
> index b963fd975aaca..faab6f03f3655 100644
> --- a/arch/arm64/kvm/reset.c
> +++ b/arch/arm64/kvm/reset.c
> @@ -34,6 +34,7 @@
>  static u32 __ro_after_init kvm_ipa_limit;
>  unsigned int __ro_after_init kvm_host_sve_max_vl;
> =20
> +#ifdef ARM64_S390_COMMON
>  /*
>   * ARMv8 Reset Values
>   */
> @@ -46,6 +47,8 @@ unsigned int __ro_after_init kvm_host_sve_max_vl;
>  #define VCPU_RESET_PSTATE_SVC	(PSR_AA32_MODE_SVC | PSR_AA32_A_BIT | \
>  				 PSR_AA32_I_BIT | PSR_AA32_F_BIT)
> =20
> +#endif /* ARM64_S390_COMMON */

[Severity: Low]
Could stripping out these reset value macros cause compilation to fail?=20

They appear to be used in unconditional kvm_reset_vcpu() initialization log=
ic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260706085229.9795=
25-1-seiden@linux.ibm.com?part=3D8
