Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0516A30C177;
	Fri, 31 Jul 2026 14:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785506776; cv=none; b=YncNELYnyol0i5ljCE/IuMNtREPjpvB8FIMKrnlC3noez/ovupaLOQYafqtknH/PWupfPiA6T0qdRlMbF+eQwVdW0CBz9OywJWv959Y/SU6xIUE7jPNKjQcSN1LYKiuAbDjXHNetyEHw6HX7zV03pOqhePbEsvtMRz90qgmCrl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785506776; c=relaxed/simple;
	bh=2XJNKzSrAaNcAoO16AkSyNbSWNoU1Pu8TWrXqgZ+Fvo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QOXEt8vQDZvKhMsxBHIwT6araUmhH/pmil7uhUiVPtGu8OLXSHi8xhMcFA4F8pyBHjoxP9BSnvqC1wbQxT3O2mLMmvLZTq9pT5TWoxAdhsCk3saRQrAYFgMlYvGG8HD2WwQU/7UGlPcjbJMj2gf6pmAIqlkL+TLZVhWHVNnky7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hWLMDLJg; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hWLMDLJg"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36B11F000E9;
	Fri, 31 Jul 2026 14:06:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785506774;
	bh=wWxQCp6CMDahR2U8BZQBdj/EXLzKWUE2WEuj9LkSD+g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hWLMDLJguaco0wccNaZs1CnTpzgTud6E6PdUP32Q17ZlKHwiCOITYFfSqWWyqI3bV
	 gRkMvCU6aOhFK1olr4Gcv5mhl05+aoIpLVByvt/CyeD8kF6q7JfpqxvOGs76iG2buO
	 N/qbsH6cnPAABoA7928WMWpZLKaVMhM4qLYG14pt4qn7/ZRFoGgs0fi7k300xAYtPH
	 fwioWr2Yzkixt/5WleoynBlQzpUbhgPlpIuITYPxGHN7/ZhZ7MXxjEMh2ZfH1SQa0G
	 JAN59YrC16LvIjKQspC7lqCMdmRAm4qF9p3GS6mWy5/wnhv2uDibksAgpriEE5sD1X
	 /9IXQGav2qoJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 26/31] KVM: s390: Add basic arm64 kvm module
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvmarm@lists.linux.dev, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Oliver
 Upton" <oupton@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260731130902.654679-27-seiden@linux.ibm.com>
References: <20260731130902.654679-1-seiden@linux.ibm.com>
 <20260731130902.654679-27-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 14:06:13 +0000
Message-Id: <20260731140613.D36B11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Integer underflow in `kvm_max_guest_address()` leading to validati=
on bypass.
- [Low] Missing EXPORT_SYMBOL for `kvm_init_with_dev` causes linker failure=
 for modules.
--

--- Patch [26]: [PATCH v5 26/31] KVM: s390: Add basic arm64 kvm module ---
commit 0b59f30d55223ee112ff6a32812059d6b6bf4d71
Author: Steffen Eiden <seiden@linux.ibm.com>

KVM: s390: Add basic arm64 kvm module

This commit adds the basic code and boilerplate for the new arm64 on s390=20
KVM implementation. It includes kernel module initialization, tracing=20
scaffolding, and initial VCPU interaction functions.

> diff --git a/arch/s390/kvm/arm64/arm.c b/arch/s390/kvm/arm64/arm.c
> new file mode 100644
> index 0000000000000..8e17b7eef8131
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/arm.c

[ ... ]

> +static u64 kvm_max_guest_address(void)
> +{
> +	u64 max_addr;
> +
> +	if (sclp.hamax =3D=3D U64_MAX)
> +		max_addr =3D TASK_SIZE_MAX;
> +	else
> +		max_addr =3D min_t(u64, TASK_SIZE_MAX, sclp.hamax);
> +	return ALIGN_DOWN(max_addr + 1, 1 << 30) - 1;
> +}

[Severity: High]
Does this calculation risk an integer underflow if max_addr + 1 is less than
1GB (1 << 30)?

If the host machine (such as a small LPAR or z/VM guest) has a hardware
absolute memory limit (sclp.hamax) below 1GB minus 1, ALIGN_DOWN() will
return 0. Subtracting 1 from 0 in unsigned 64-bit arithmetic causes an
underflow to U64_MAX.

This underflow propagates to get_kvm_ipa_limit(), turning into an invalid
0xFFFFFFFF limit that bypasses the IPA size check in
kvm_vm_type_ipa_size_shift(). This could allow untrusted user space to
request arbitrarily large IPA sizes, resulting in massive unbounded page
table allocations in gmap_new().

[ ... ]

> +static int __init kvm_s390_arm64_init(void)
> +{
> +	if (!sclp.has_aef)
> +		return -ENXIO;
> +
> +	return kvm_init_with_dev(sizeof(struct kvm_vcpu), 0, THIS_MODULE,
> +				 KVM_DEV_NAME, MISC_DYNAMIC_MINOR);
> +}

[Severity: Low]
Does kvm_init_with_dev() need an EXPORT_SYMBOL or
EXPORT_SYMBOL_FOR_KVM_INTERNAL in virt/kvm/kvm_main.c?

If CONFIG_KVM is built as a loadable module, calling the unexported
kvm_init_with_dev() here will cause an undefined reference linker failure
during kernel compilation.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260731130902.6546=
79-1-seiden@linux.ibm.com?part=3D26
