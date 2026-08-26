Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC16313534;
	Wed, 26 Aug 2026 15:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787758425; cv=none; b=k6hU41kr7PExk8QySYKruMFAGsBwvReo+yqHw7DvETvj03xtZ2uGc07CE7oBK/YnALl3YC/uNHhZL3l9d88oDnqFT6btomYTSGMUlPbQR4qyS/E8RIj+b0vIupMo6vwsXAZwHcv3m7odMM2K8lEbZiANOpSC5EY6uxHmdTWcUr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787758425; c=relaxed/simple;
	bh=j+wd8fqvLWFdOVqawyXM2+z6pwWB/GNdVvItpSW/+/0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aM6sYwR5WZnEiH0A5v8EI/QCXZTMMhCSOHlHiFE3U7imNEMt34qTB2M4eWNhvUiDnKLyn29Gyel1HULzITeiyRhqVJyKCo592Zw3F+ixhlqYM8pmFOdV/gnirgx2cxrIksUT7MjffldmWzsDlg7kDIbO39u+3uYAIlajhAitrYw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=L0VSm5lB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="L0VSm5lB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3F8B1F000E9;
	Wed, 26 Aug 2026 15:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787758420;
	bh=xvq7Nb6ZfFHgB62O1f1JAI7ovQaW7aY9gKzT37vlfWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=L0VSm5lBgPBpy+16+haNFdrFXUtBEirEwGSlCrZOoZ2Gk6T+NiqgGRlStqePleQ9P
	 rPFnjRLSe7xTzGUJgViI89oKv1yTSf0RjIChyrQPQVgQnMQGeYp23zwoIuo3uEZPo6
	 8TPHuGVZUFHWlwSgwBT97FgOLJv2Ym003MMVDC/en+SvBa7hKfKnxpZaDzY6kR+QRx
	 on0NsPP+KnbjR/Ce8s8j+Frgq+3amC/I0oTgYJ+1CIk6acnGr5UwhgNq+ZO2hp59QF
	 8gszHn7h7OLgmF79AeVNS/aY4YR2l67kvx4uOYmPJh+MnzQu8SAa1v3zPfa32EiaM9
	 jQoftVJjgWd0g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/21] KVM: s390: vsie: Enable use of VSIE SSCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260826-vsie-sigpi-v5-21-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-21-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:33:39 +0000
Message-Id: <20260826153339.B3F8B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] get_vsie_page_cpu_nr() erroneously wraps a positive return cod=
e (1) in ERR_PTR(), bypassing IS_ERR() checks and causing a host kernel pan=
ic.
- [High] VSIE SIGPI interpretation feature is globally enabled, bypassing K=
VM CPU feature negotiation and leaking the feature to nested guests.
- [High] get_vsie_sca() propagates validation and pinning errors as ERR_PTR=
(-EINVAL), crashing the VM instead of injecting an intercept.
--

commit accdb605c2c295d895867d6cf5f606b51df2bb5a
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Enable use of VSIE SSCA

This commit enables the use of VSIE SSCA code paths for handling SIGPI
and SRSI instructions without exiting VSIE. The feature defaults to true
on supported hardware.

> diff --git a/arch/s390/kvm/s390/s390.c b/arch/s390/kvm/s390/s390.c
> index a1ce75be3955b..ffa5bbb8713bc 100644
> --- a/arch/s390/kvm/s390/s390.c
> +++ b/arch/s390/kvm/s390/s390.c
[ ... ]
> @@ -3363,7 +3367,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
> =20
>  	kvm->arch.use_pfmfi =3D sclp.has_pfmfi;
>  	kvm->arch.use_skf =3D sclp.has_skey;
> -	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf;
> +	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf && ssca;

[Severity: High]
Does this bypass KVM CPU feature negotiation and leak the SSCA feature to
nested guests?

When ssca is enabled here, use_ssca() in arch/s390/kvm/s390/vsie.c relies
purely on kvm->arch.use_ssca:

arch/s390/kvm/s390/vsie.c:use_ssca() {
	if (!kvm->arch.use_ssca)
		return false;
...
}

The hardware intercept bits are then unconditionally copied to the shadow S=
CB
without validating the guest's CPU feature model:

arch/s390/kvm/s390/vsie.c:prepare_scb() {
...
	if (vsie_page->vsie_sca) {
		scb_s->eca |=3D scb_o->eca & ECA_SIGPI;
		scb_s->ecb |=3D scb_o->ecb & ECB_SRSI;
...
}

Could this break live migration by exposing hardware features to the guest
without QEMU explicitly opting in via the KVM_S390_VM_CPU_FEAT_SIGPIF CPU
feature?

[Severity: Critical]
Does enabling this feature expose a host kernel panic when handling invalid
SCB addresses?

Enabling use_ssca routes execution to get_vsie_page_cpu_nr() in
kvm_s390_handle_vsie(). If an L1 guest provides an invalid SCB address,
init_vsie_page() injects a program interrupt and returns 1. However,
get_vsie_page_cpu_nr() wraps this positive return code in ERR_PTR:

arch/s390/kvm/s390/vsie.c:get_vsie_page_cpu_nr() {
...
	rc =3D init_vsie_page(vcpu, vsie_page_new, scb_gpa);
	if (rc) {
		put_vsie_page(vsie_page);
		return ERR_PTR(rc);
	}
...
}

The caller then checks IS_ERR(vsie_page), which evaluates to false for a
positive value like (void*)1:

arch/s390/kvm/s390/vsie.c:kvm_s390_handle_vsie() {
...
		vsie_page =3D get_vsie_page_cpu_nr(vcpu, vsie_sca, scb_addr,
						 scb_o->icpua & KVM_S390_CPU_MASK);
		if (IS_ERR(vsie_page)) {
			rc =3D PTR_ERR(vsie_page);
...
}

Will this allow execution to proceed and dereference the invalid pointer,
leading to a full host denial of service?

[Severity: High]
Can an invalid SCA origin provided by an L1 guest cause a complete VM abort?

Similar to the regression above, the newly reachable get_vsie_sca()
converts the return code 1 from validate_scao() into a hard -EINVAL error:

arch/s390/kvm/s390/vsie.c:get_vsie_sca() {
...
	rc =3D validate_scao(vcpu, scb_o, sca_gpa);
	if (rc)
		return ERR_PTR(-EINVAL);
...
}

It also propagates pinning errors directly as hard errors rather than
injecting intercepts:

arch/s390/kvm/s390/vsie.c:get_vsie_sca() {
...
	rc =3D pin_sca(kvm, vsie_sca);
	if (rc) {
		vsie_sca->sca_gpa =3D ULONG_MAX;
		put_vsie_sca(vsie_sca);
		vsie_sca =3D ERR_PTR(rc);
		goto out;
	}
...
}

These errors are propagated all the way up to kvm_arch_vcpu_ioctl_run(),
which returns -EINVAL to QEMU and aborts the entire VM. Is it
intended to crash the VM instead of gracefully resuming the guest with an
intercept when a misaligned or unmapped SCAO is encountered?

>  	spin_lock_init(&kvm->arch.start_stop_lock);
>  	kvm_s390_vsie_init(kvm);
>  	if (use_gisa)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D21
