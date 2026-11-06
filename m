Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989056;
	b=1XtelzUJBdAV1D9T14OWJSwDB/PMlQbDCWpkH5Wrk++2GUleuHU+xxiMoM7WSlg1mfqa
	 z9oZt70KBFLdSo0KcghLuQLXHgJOWPSXDigzPqEpi+QIc/mc77ZSR7LNCurJQBMdC4ccu
	 iLQ8K5mVPsDrLiSerDLdU6oOBRhhXAx7rfJ1cc5Vxqr/wlhojgOiv0uEUM7k4AubX4hLL
	 F6Hv1kWRyHSUAsLAmEfO2R0HfUpjqKeBXxXTVTCHAQPPHMrpveg1wX7dZtmNCaIykocL/
	 1pHhsq+7iz5479kXuCl0/9JZGGz88nBZnlmBp4vuVnUpS8SI6tfN4qL46oz9YRBMl1Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989056;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=F0qkdeW9NAwTpGhGXz4KXbB5dgSQg8TK+EZRzv3+Fzo=;
	b=2LyM3zyLVJpKceIsb/ROls2FYGdWyZB+rdPTLQb6nJuJyMZOo2ITzfJwGcCuPXDtUAqc
	 jJ6TqPvaOQD9T7RZa3JpPv0/K/JyAp/lN/uFQX1rGlzRc9byfYduM1Y+jD/qXrYvVOUvv
	 4ePfJhjZBAWE4ImmOJUTUj3xYx657Z8HWMP5WWQLGYBEUw1TkS1NyXBmGiH1Z9mV9EnBF
	 ELV3ozmxTIjYbzCK3QIkOwfQyna2CBZd6CVJlMx6zaFVC5ZlxFyYbd5Od72FAlfD2mRfn
	 ahmmRzNUcsEwBIgdZtzQcoI3LyH2wjFWg+sM7/dZshN9f3mLz68LMHLqyd1YVa5u35A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSw2e4AN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F57606A326;
	Fri,  6 Nov 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JSw2e4AN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1BC61F0089F;
	Fri,  6 Nov 2026 18:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793989056;
	bh=F0qkdeW9NAwTpGhGXz4KXbB5dgSQg8TK+EZRzv3+Fzo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JSw2e4ANSksUNA1pfilCZBigNCHiYSObSAJdqJfoIjV3jjHfKTdtNeBfxN5uOcETB
	 l4BCLzZPyNiRLN+p+kBTm5ip8KWFyBXEB73AOC7WffVF0/EkgPed8UBKgBsyuQjnHg
	 DnTD7xlHiUR8gTQpjdJh8+Zu7nInbwgC+bysCCVdemja2wZee/3vkMFkTwUauhFhT1
	 Ch5RMWaI9MnthuTYtygOv3/VzwuU5qu3rRnYqGAzi77ZOhNX0SoBgxSds+zmEWe6NS
	 elHCMhK9twzJvAPCSL7kYvs2ysFdEEoEkTMPUdRBFT2Y697/1BDlgnJZZEPJwJwAuG
	 VfXdB6en18C0Q==
Message-ID: <sashiko-outbox-202007@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 15/23] KVM: s390: arm64: Implement feature
 sanitisation
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Marc Zyngier" <maz@kernel.org>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-sysreg-v3-15-75e95980fb10@linux.ibm.com>
References: <20261106-sysreg-v3-0-75e95980fb10@linux.ibm.com>
 <20261106-sysreg-v3-15-75e95980fb10@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 18:17:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] KVM: s390: wrong ARM64_HAS_HCR_NV1 check in
  cpus_have_final_cap()
- [Low] KVM: s390: missing ID_AFR0_EL1 masking in
  kvm_arm_host_sanitize_features()
- [Low] KVM: s390: malformed kernel-doc comment for
  read_sanitised_ftr_reg()
--

commit 1c037e7c3587ba94101456185c381c6fbc670b9c
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Implement feature sanitisation

This commit implements feature detection and ID register sanitization for
arm64 KVM guests on s390 using capabilities queried via QAAF.

> diff --git a/arch/s390/kvm/arm64/feature.c b/arch/s390/kvm/arm64/feature.c
> new file mode 100644
> index 0000000000000..f8b23ba85f9ef
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/feature.c
> @@ -0,0 +1,163 @@

[ ... ]

> +void __init kvm_arm_host_sanitize_features(struct qaaf_qmc_block *qaaf_q=
mc)
> +{

[ ... ]

> +	MASK_RESERVED(qaaf_qmc, ID_PFR0_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_PFR1_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_PFR2_EL1);
> +
> +	MASK_RESERVED(qaaf_qmc, ID_DFR0_EL1);
> +	MASK_RESERVED(qaaf_qmc, ID_DFR1_EL1);
> +
> +	MASK_RESERVED(qaaf_qmc, ID_MMFR0_EL1);

[Severity: Low]
Should kvm_arm_host_sanitize_features() also mask reserved bits for
ID_AFR0_EL1?  kvm_qaaf_read_ftr_reg() exposes
qmc_sanitized.regs[QAAF_REG_ID_AFR0_EL1], and without
MASK_RESERVED(qaaf_qmc, ID_AFR0_EL1) its reserved bits [63:16] remain
unmasked when queried via read_sanitised_ftr_reg().

[ ... ]

> +bool cpus_have_final_cap(unsigned int num)
> +{
> +	u64 reg_val;
> +
> +	switch (num) {

[ ... ]

> +	case ARM64_HAS_HCR_NV1:
> +		reg_val =3D read_sanitised_ftr_reg(SYS_ID_AA64MMFR4_EL1);
> +		return SYS_FIELD_GET(ID_AA64MMFR4_EL1, E2H0, reg_val) =3D=3D
> +		       ID_AA64MMFR4_EL1_E2H0_IMP;

[Severity: Medium]
Does the ARM64_HAS_HCR_NV1 case check for FEAT_E2H0 instead of HCR_EL2.NV1
support?

In the Arm architecture, ID_AA64MMFR4_EL1.E2H0 is a signed field where 0
(ID_AA64MMFR4_EL1_E2H0_IMP) means HCR_EL2.E2H can be programmed to 0, 0xf
(ID_AA64MMFR4_EL1_E2H0_NI) means E2H0 is not implemented but HCR_EL2.NV1 is
supported if nested virtualization is present, and 0xe
(ID_AA64MMFR4_EL1_E2H0_NI_NV1) means neither is implemented.  On arm64,
has_nv1() checks for nested virtualization support and that E2H0 is not
NI_NV1:

arch/arm64/kernel/cpufeature.c:has_nv1() {
	return (__system_matches_cap(ARM64_HAS_NESTED_VIRT) &&
		!(has_cpuid_feature(entry, scope) ||
		  is_midr_in_range_list(nv1_ni_list)));
}

Checking E2H0 =3D=3D ID_AA64MMFR4_EL1_E2H0_IMP causes cpus_have_final_cap()=
 to
return true whenever E2H0 is 0 even though nested virtualization is not
supported on s390, and false when E2H0 is 0xf.

[ ... ]

> diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
> new file mode 100644
> index 0000000000000..0a59047fda6ef
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/feature.h
> @@ -0,0 +1,86 @@

[ ... ]

> +/**
> + * read_sanitised_ftr_reg() - Get the value of a sys register
> + *
> + * @id - ARM sysreg id
> + *
> + * Get the value of a sys register describing the host configuration.
> + * The returned value indicates support by the machine (HW/FW)
> + * after some sanitisation.
> + *
> + * Example:
> + *	read_sanitised_ftr_reg(SYS_ID_AA64PFR0_EL1)
> + *
> + * Return: Sanitised HW value of the specified register
> + */
> +static inline u64 read_sanitised_ftr_reg(u32 id)

[Severity: Low]
This isn't a bug, but the kernel-doc comment uses "@id -" instead of "@id:",
which causes scripts/kernel-doc to warn that the parameter is not described
in read_sanitised_ftr_reg().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-sysreg-v3-=
0-75e95980fb10@linux.ibm.com?part=3D15
