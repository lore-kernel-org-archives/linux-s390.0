Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 556BD38E13F;
	Fri, 18 Sep 2026 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789751600; cv=none; b=JBS4pdxOWVBZ3CIzPb8w//yV4Br5lRqNmzqeRT4WzLU6KbPEprVXtDN2tfwQ9Gib9OucTMTKcYpm6aqFZ/00IIvdYWTz1WcA0eezhq1eFaT5wIMJuuKiZEH4Iv3npa0iqxpehy3Der+Vk4OxonU+TRyO+PuoFOaiZDj/SbrBaxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789751600; c=relaxed/simple;
	bh=RJZclMlJU8CjSKrMUmld/xwDccNc/vh4leirlCYy3jg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dcUiLuDZARaOGX54Jk9XX9gJnYst1cYEMly0j+kOBNSVt6a8fdt3Jtb02vQscfKIiRlPWGBz4vtttdbRE5ZeFrGiFuDevJg8jzQ0IL+GfOixtpYJxlSQ174rmS8Fqt3fMVVdeal63wyyefpFbC9nxCtsTrepLnZBmvTDkeAeIDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JdEJy0K0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JdEJy0K0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87AD41F000FF;
	Fri, 18 Sep 2026 17:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789751598;
	bh=IvdRurE5M/q+DnbS5VrXPcuPdUJtXRHhk4XM4O00ncQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JdEJy0K01ahecml4vmrGOh/kwmimZ5AzmeoLVg8mB2EKDhzgysjplnkq04wZVnWW8
	 H7frcBiW/oOc7CtpDkICEV9gkUlOwSWvSAx+JhLclVZUENGvVog45SwRUYF/01us9U
	 szdPvETtHo4lidqNgQ7NRylO2rMyQaLfXTtPl5kuK2s6rjwQLKyDVzOAM1pdJ1IRVX
	 K8j5WbvFKohsM7ubjo6gBZZ6ncxGyJNGcElSTTbJ3czIAxidBpZklbtLVvuvsLNDLy
	 nE+xeY2BaPety/u/6hzJj0Gc1R0IK7125bWj8NcgZPtV5Ul3vgQp+W1Ez400mYixxP
	 I4mriWuugBrCw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 24/29] KVM: s390: arm64: Implement required functions
Reply-To: sashiko-reviews@lists.linux.dev
To: "Steffen Eiden" <seiden@linux.ibm.com>
Cc: "Marc Zyngier" <maz@kernel.org>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Oliver
 Upton" <oupton@kernel.org>, kvm@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, kvmarm@lists.linux.dev
In-Reply-To: <20260918133107.1042730-25-seiden@linux.ibm.com>
References: <20260918133107.1042730-1-seiden@linux.ibm.com>
 <20260918133107.1042730-25-seiden@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 17:13:17 +0000
Message-Id: <20260918171318.87AD41F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] kvm: arm64: guest-triggerable host infinite loop due to empty ex=
ception stubs
--

commit d9fe4f13dd483ddf56413b5d5c4c9d6582209f75
Author: Steffen Eiden <seiden@linux.ibm.com>
KVM: s390: arm64: Implement required functions

This commit implements various stub functions and simple handlers required
by the shared ARM64 KVM code for the s390 architecture. It includes an
initial smccc handler to stop a vCPU and several exception injection stubs.

> diff --git a/arch/s390/kvm/arm64/handle_exit.c b/arch/s390/kvm/arm64/hand=
le_exit.c
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/handle_exit.c
[ ... ]
> +static int kvm_handle_unknown_ec(struct kvm_vcpu *vcpu)
> +{
> +	u64 esr =3D kvm_vcpu_get_esr(vcpu);
> +
> +	kvm_pr_unimpl("Unknown exception class: esr: %#016llx -- %s\n",
> +		      esr, esr_get_class_string(esr));
> +
> +	kvm_inject_undefined(vcpu);
> +	return 1;
> +}

[Severity: Medium]
Because kvm_inject_undefined() is currently an empty stub, does returning 1
here tell the run loop to resume the guest without modifying its state?

If the guest's PC is not advanced, this can cause the guest to immediately
re-trap the exact same instruction, leading to an infinite trap loop that
pegs the host VCPU thread at 100% and spams the kernel log.

> diff --git a/arch/s390/kvm/arm64/inject_fault.c b/arch/s390/kvm/arm64/inj=
ect_fault.c
> --- /dev/null
> +++ b/arch/s390/kvm/arm64/inject_fault.c
[ ... ]
> +void kvm_inject_undefined(struct kvm_vcpu *vcpu)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +}

[Severity: Medium]
Will leaving this as an empty stub fail to advance the Program Counter or
modify guest registers to actually inject the exception?

Failing to modify the guest state before returning to execution means any
unprivileged guest executing an undefined instruction could trivially trigg=
er
an infinite loop.

> +
> +int kvm_inject_sea(struct kvm_vcpu *vcpu, bool iabt, u64 addr)
> +{
> +	/* Stub until s390 supports arm64 sysregs TODO sysregs*/
> +	return 1;
> +}

[Severity: Medium]
Can returning 1 from this empty memory fault stub identically cause an
infinite loop for unimplemented memory faults?

Since the guest state isn't modified to inject the fault, resuming it will
simply re-execute the failing instruction over and over.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918133107.1042=
730-1-seiden@linux.ibm.com?part=3D24
