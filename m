Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2BE3ADBA2;
	Mon, 31 Aug 2026 22:35:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788215751; cv=none; b=DP6CM7iF1szsXSWRDJpu7gjrflA2Dv9oFkFUIHVYiyBUsZjuXtK23xgxFdTh/t1m32lEJ288RC/B4Oft/DfNvS3BFwZFliWXbNfpxoHtPFrgEcePy+Rlryrod1izE9ho41yViWs0c8J+Zo8qoUdu/RY4GG8U5YYGobwnaZjv88c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788215751; c=relaxed/simple;
	bh=zhmO5QrKKNIlZXqF6UYN1EzpW8J8CkQI1bcVBz70xDo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DE4J/rRxh87HwGNNKyRikO3bcGiuf/Y6RTXJRAYKZtnrgybs02AsGPaXv3yCERG7I6x2Nc0rAO9Wda2EACR3UKITfsAKKB91vjuF7RqL8t0jsHuA/zzEUzOOlrATeWmsZjhgZ8GBEuAixM2n1ufGngdkUsPiNr5zlxkLBynCroI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nr7jq5wt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nr7jq5wt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 953B91F000E9;
	Mon, 31 Aug 2026 22:35:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788215750;
	bh=XHscgRXbY+iwWXHAOxPC2HDyEFw2GKGH7pZSYVo8wnk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nr7jq5wt8+iMlI8BYrOS/QxYFfzplIeGIWf4R9eZ5aEr0iLVQczYCbFFx/smqZxZ6
	 jn34cDrJVYHjfODRKMr/XRlA/sxwTNCsARKuwT7wv9sXzG0rAStvEGGOXhYHFLh3Nk
	 589FeuyDM9nvzLhVcO7J/Ys28bxofRF/fAcLlo38qlv/uWGhZev/1wOpE2UA3LU8zB
	 pRqlApXyFctNt8O/nhS5kqmP70FUo2yugecCpALYvTaKLj9xtGPh0A9qmhaMD3HnHq
	 EvTFKMHazNLybpg9GYEd/iuYNSQhTI9jRZjhOQS6cEsHV97BMEhXYO3gFif/yS9oY2
	 Yx25V25N6AX1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 19/20] KVM: s390: arm64: Promote PTRAUTH capability
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvmarm@lists.linux.dev, "Vasily Gorbik" <gor@linux.ibm.com>, "Marc
 Zyngier" <maz@kernel.org>, kvm@vger.kernel.org
In-Reply-To: <20260831145536.913567-20-seiden@linux.ibm.com>
References: <20260831145536.913567-1-seiden@linux.ibm.com>
 <20260831145536.913567-20-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 22:35:49 +0000
Message-Id: <20260831223549.953B91F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Missing PTRAUTH traps configuration causes guest crashes.
- [Low] Macro redefinition of 'vcpu_has_ptrauth' causes a build failure.
--

commit cda854ae1be029b75a496434857cbf27f60d5cc0
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: arm64: Promote PTRAUTH capability
   =20
Promote the pointer authentication capability if supported by hardware.

> diff --git a/arch/s390/include/asm/kvm_host_arm64.h b/arch/s390/include/a=
sm/kvm_host_arm64.h
> index 73eb09e98848f..32facf0457049 100644
> --- a/arch/s390/include/asm/kvm_host_arm64.h
> +++ b/arch/s390/include/asm/kvm_host_arm64.h
> @@ -32,6 +32,8 @@ bool cpus_have_final_cap(unsigned int num);
>  #define KVM_HAVE_MMU_RWLOCK
>  #define KVM_MAX_VCPUS 1
>  #define KVM_S390_ARM64_IMPL_FEATURES (		\
> +	 BIT(KVM_ARM_VCPU_PTRAUTH_ADDRESS) |	\
> +	 BIT(KVM_ARM_VCPU_PTRAUTH_GENERIC) |	\
>  	 BIT(KVM_ARM_VCPU_SVE)			\
>  )

[Severity: High]
Does promoting these PTRAUTH capabilities lead to a guest crash?

When a guest executes Pointer Authentication instructions, the hardware che=
cks
the Hypervisor Configuration Register (HCR_EL2) bits HCR_API and HCR_APK.
Because vcpu_reset_hcr() hardcodes vcpu->arch.hcr_elz and omits these bits:

arch/s390/kvm/arm64/reset.c:vcpu_reset_hcr() {
        vcpu->arch.hcr_elz =3D HCR_EL2_E2H | HCR_EL2_RW | HCR_EL2_AMO |
                             HCR_EL2_IMO | HCR_EL2_FMO | HCR_EL2_PTW;
        /* traps */
        vcpu->arch.hcr_elz |=3D HCR_EL2_TSC | HCR_EL2_TID1 | HCR_EL2_TID2 |
                              HCR_EL2_TID3 | HCR_EL2_TID4 | HCR_EL2_TID5 |
                              HCR_EL2_TIDCP | HCR_EL2_TLOR;
}

PTRAUTH instructions will unconditionally trap to the hypervisor with
ESR_ELx_EC_PAC. Since arm_exit_handlers[] lacks a handler for ESR_ELx_EC_PA=
C:

arch/s390/kvm/arm64/handle_exit.c:arm_exit_handlers[] =3D {
        [0 ... ESR_ELx_EC_MAX]  =3D kvm_handle_unknown_ec,
        [ESR_ELx_EC_HVC64]      =3D handle_hvc,
        [ESR_ELx_EC_SYS64]      =3D kvm_handle_sys_reg,
        [ESR_ELx_EC_IABT_LOW]   =3D kvm_handle_guest_abort,
        [ESR_ELx_EC_DABT_LOW]   =3D kvm_handle_guest_abort,
};

It seems the hypervisor will fall back to kvm_handle_unknown_ec(), injecting
an unexpected undefined instruction exception back to the guest and crashing
it. Should we configure the traps or add an exit handler before enabling th=
is?

[ ... ]

> diff --git a/arch/s390/kvm/arm64/feature.h b/arch/s390/kvm/arm64/feature.h
> index 892cf8bcf3a12..c11ac0daa4287 100644
> --- a/arch/s390/kvm/arm64/feature.h
> +++ b/arch/s390/kvm/arm64/feature.h
> @@ -94,4 +94,9 @@ static inline u64 kvm_sae_irptc(void)
> =20
>  bool system_supports_sve(void);
> =20
> +#define vcpu_has_ptrauth(vcpu)						\
> +	 (vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_ADDRESS) ||       \
> +	  vcpu_has_feature(vcpu, KVM_ARM_VCPU_PTRAUTH_GENERIC))

[Severity: Low]
Can this macro redefinition cause a build failure on s390?

Because the C files including this header (like arm.c and feature.c) also
include <linux/kvm_host.h>, they transitively include <arm64/kvm_host.h>.
Since CONFIG_ARM64_PTR_AUTH is not set on s390, <arm64/kvm_host.h> defines
vcpu_has_ptrauth(vcpu) as false.

Redefining it here without first using #undef vcpu_has_ptrauth might trigger
a -Wmacro-redefined warning, which breaks the build if -Werror is used.

> +bool system_has_full_ptr_auth(void);
> +
>  #endif /* ARCH_S390_KVM_FEATURE_H */

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831145536.9135=
67-1-seiden@linux.ibm.com?part=3D19
