Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7289B370D6E;
	Mon, 31 Aug 2026 20:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788207116; cv=none; b=fldWCHiB84kGoMkPaqIEhwQ5SLqlx4JIqX5Jjv3BUaqVz06rv/ZX29jbmdxv6Lr+pqMLDyC8ajlGh/64BUy0kh7ZvYwGDyhIYdE0IDmUaSY+MqQnGoWeVv28Abp7eXUU+4b0TiJkThPHkwoQy7dTAXXts9QtL7bEtaTlibwZyG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788207116; c=relaxed/simple;
	bh=jjpWt8Q8AXHdC4znax4SMSCtpkKslZiS2euym/X2+78=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qtaoV78svTEjtacEf064AWej+GH7TsImoWB2FsTs8RHEeUbP1OJOoTJF8xdnc5lbuTP7JYWv7Wumn1YdYDQ/M7RHW1aG/MNy8QAdoT3Zos6D1x+Nafrqtums/W4NeF2fG/8kXFrKnyAR1ANsoiFCIgCUVJPXIvyupeU2wS8Qfxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVJgDmYs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVJgDmYs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9955C1F000E9;
	Mon, 31 Aug 2026 20:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788207115;
	bh=v0CarR0WOcwreHntxDBmMlR1EiPC9iedJCYG2vxIgKQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TVJgDmYsL/WqhPwcsT8ecSZPnG/+9XE4VslnM2yk6b22uiUOOP/qodlcngTQ7aJNe
	 8ffLU+m7Q9A6n8n9gWqtQ1xzisvPKB2id8cUjLTuYDvBp0b5MBEjU8gg0HuaDLycQX
	 lGzI0V1uwSCGR/zREfOXSKVpFkz+7bK9CQGwWO4Rlqz3dWbN1fmAgFkG8jFj1n20h2
	 VCCfwAX83u070CwyY8LYl9LZFdwhr5Uy8zfYMEcx+qtSyT6uMCg9CRYVR2lIyM57qV
	 /U9FqdwxFMWT2tUPkXZM8ztO0Vdj/Cj+rpZyVAthcFldCauFSMoTUmXjIOkGEp6b6t
	 2k028Al6UKpKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/20] KVM: s390: arm64: Implement feature
 sanitisation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, kvmarm@lists.linux.dev
In-Reply-To: <20260831145536.913567-13-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-13-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:11:54 +0000
Message-Id: <20260831201154.9955C1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] Hardware Feature Mis-mapping: ARM64_HAS_ECV_CNTPOFF maps to PAN in=
stead of ECV
- [High] Hardware Feature Mis-mapping: ARM64_HAS_HCR_NV1 fails to account f=
or CPUs that remove NV1
- [High] Incomplete Feature Check: ARM64_HAS_RASV1P1_EXTN omits the primary=
 fallback check
- [High] Feature Leakage: MASK_RESERVED uses a blacklist approach, leaking =
unknown features to the guest
- [Low] Undefined reference to __qaaf_qmp causing potential linker errors
- [Low] Integer overflow in kvm_sae_max_vcpus due to u16 return type
--

commit ea4286d0301a7cdfe0535f60a7c1ca1b65c64103
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement feature sanitisation

Implement feature detection and sanitization for arm64 KVM guests on s390.
Queries hardware capabilities using the QAAF instruction and provides acces=
sor
functions for capability mapping.

> diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
> new file mode 100644
> index 0000000000000..39c8ae7e951cf
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/feature.c
> @@ -0,0 +1,165 @@
[ ... ]
> +#define MASK_RESERVED(_qaafp, _id)				\
> +	({							\
> +		u64 *_reg =3D &((_qaafp)->regs[QAAF_REG_##_id]);	\
> +		*_reg =3D (*_reg & ~_id##_RES0) | _id##_RES1;	\
> +	})

[Severity: High]
Does this blacklist approach inadvertently leak unknown features to the gue=
st?

By clearing only the explicitly unarchitected RES0 bits, any valid CPU
features that are not recognized or handled by KVM will be passed through
unconditionally. This goes against the KVM invariants that new guest-visible
features should default off, which could allow a guest to use unsupported
features and lead to hardware traps or hypervisor state corruption.

[ ... ]
> +bool cpus_have_final_cap(unsigned int num)
> +{
> +	u64 reg_val;
> +
> +	switch (num) {
[ ... ]
> +	case ARM64_HAS_RASV1P1_EXTN:
> +		reg_val =3D read_sanitised_ftr_reg(SYS_ID_AA64PFR1_EL1);
> +		return SYS_FIELD_GET(ID_AA64PFR1_EL1, RAS_frac, reg_val) =3D=3D
> +		       ID_AA64PFR1_EL1_RAS_frac_RASv1p1;

[Severity: High]
Is this missing the primary check for the RAS extension?

The check looks exclusively at the fractional extension field RAS_frac in
ID_AA64PFR1_EL1, but ignores the primary ID_AA64PFR0_EL1.RAS field. On
modern CPUs that correctly advertise V1P1 support in ID_AA64PFR0_EL1, this
will return false and break feature discovery.

> +
> +	case ARM64_HAS_HCR_NV1:
> +		reg_val =3D read_sanitised_ftr_reg(SYS_ID_AA64MMFR2_EL1);
> +		return SYS_FIELD_GET(ID_AA64MMFR2_EL1, NV, reg_val) >=3D
> +		       ID_AA64MMFR2_EL1_NV_IMP;

[Severity: High]
Will this misidentify NV2-only systems as having NV1 support?

This check verifies if Nested Virtualization is implemented but ignores
the ID_AA64MMFR4_EL1.E2H0 field. On newer hosts that implement NV2 but
explicitly remove NV1 (such as the Apple M2 series), this function will
return true and attempt to use unsupported NV1 features.

[ ... ]
> +	case ARM64_HAS_ECV_CNTPOFF:
> +		reg_val =3D read_sanitised_ftr_reg(SYS_ID_AA64MMFR1_EL1);
> +		return SYS_FIELD_GET(ID_AA64MMFR1_EL1, PAN, reg_val) >=3D
> +		       ID_AA64MMFR1_EL1_PAN_IMP;

[Severity: High]
Does this check query the wrong register and field for Enhanced Counter
Virtualization (ECV)?

It is querying ID_AA64MMFR1_EL1.PAN instead of ID_AA64MMFR0_EL1.ECV. Because
PAN is widely supported on modern ARM64 CPUs, KVM will incorrectly assume
ECV is present, potentially causing undefined instruction exceptions or
timer misbehavior if those features are used.

> diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
> new file mode 100644
> index 0000000000000..9c902df1f26c6
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/feature.h
> @@ -0,0 +1,87 @@
[ ... ]
> +static inline u32 kvm_sae_supported_sd_formats(void)
> +{
> +	extern struct qaaf_qmc_block __qaaf_qmp;
> +
> +	return __qaaf_qmp.ssdf;
> +}

[Severity: Low]
Is this referencing an undefined symbol?

The symbol __qaaf_qmp does not exist anywhere in the kernel (the actual
structure seems to be exposed via aef_qmc()). While this inline function
is currently dead code, calling it will cause a linker error.

[ ... ]
> +static inline u16 kvm_sae_max_vcpus(void)
> +{
> +	extern struct qaaf_qmc_block __qaaf_qmp;
> +
> +	/* QAAF QMP reports the max id not the max num */
> +	return __qaaf_qmp.maxncpu + 1;
> +}

[Severity: Low]
Can this result in an integer overflow?

The maxncpu field can reach 0xFFFF. Returning maxncpu + 1 cast to a u16
will overflow the 16-bit integer boundary and wrap around to 0. (Also, as
noted above, __qaaf_qmp is an unresolved symbol).

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D12
