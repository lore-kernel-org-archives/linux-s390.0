Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 873083644B3;
	Wed, 12 Aug 2026 17:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786556758; cv=none; b=gfgH2md/ETqVSZevathMmdJNIw+Xm6zouyNKVl1ghQcgnRnYf19ds2rkkOkXqx7i5HXfDiEdy0BOhMSVitiRw6n7bMkwADcEYUFAjmthFQG7rLW4MyJdN7Z2rLUcDY2d2jIIUg56z4SEIg1IfWZs4oKvNMhQzJYtgO9GxHR79KM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786556758; c=relaxed/simple;
	bh=wbY21i7M7Q/sZSQzHcOT3M3Pvh+fdzZZDGqvoN8kDkA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=N4dqgyj6+RmTyyH4/f3uxaB2f5hmfMC2hESmQRhfz+cHoLnpGBc7FBZ8Z7u2aV9Bgdpl5Fstg4upuASK1EetAIF/bAU8q9JU7CSQ88oKdslJr8g+HSTLcMRowd6CfB9CCf7EXBbLkNrJVKmmxPenMnskuWm7v9T6/Rb2fUit9p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ig6HBv6q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ig6HBv6q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B10CB1F000E9;
	Wed, 12 Aug 2026 17:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786556757;
	bh=JU6UOv+LgfIu7CXPqilPAwmbzoedJ7nnrH2mDnSEO0I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ig6HBv6qrEL9tUQu3C7tN1XJ96OqxGZI4ZmxFWEAFbJkbiDWhqAlubS1A84KuZmCN
	 9NVSjHUhPnjAVP6kLC2NDLKX5kf7TFeUigl+gGNIzUHEGMEhSttPXRW32hHkd1lZ8J
	 4q4D3t4H/BrlYA/POQoAq/W4PAuFUp5XwbS6rsMao2U/6aitglp3ncguKv5aPLd7dd
	 C9b/0iz7HmZG9HbVoMoQMnJWXdiH1jexXWfT1PTsrvweL4LL11NvUVx75C8qqaFEK7
	 8oPyjXWFB6ksMgjxWRLigvszfTlrmXaQdghpVjKuPIVc9jhEBXa2pJ87wkEoBFfx8V
	 0kRje42RqLSzg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 20/20] KVM: s390: vsie: Enable use of VSIE SSCA
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-vsie-sigpi-v4-20-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-20-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 17:45:56 +0000
Message-Id: <20260812174556.B10CB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] Guest-2 can trigger an out-of-bounds array access (both read a=
nd write) in host kernel memory by supplying a malicious `icpua` value.
- [High] The newly introduced VSIE SCA shadowing code contains multiple WAR=
N_ON_ONCE assertions that can be triggered by a malicious guest, leading to=
 a host kernel panic.
- [High] VSIE unconditionally allows nested guests to use SSCA (SIGPI and S=
RSI interpretation) if the host supports it, bypassing the guest-2's negoti=
ated CPU model capabilities.
- [High] Guest-triggerable QEMU/VM abort via invalid or unaligned SCA entry=
 addresses.
--

--- Patch [20]: [PATCH v4 20/20] KVM: s390: vsie: Enable use of VSIE SSCA -=
--
commit 3bbd1f1a442d7f9a9ee468b6c61e02cb8392ba96
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Enable use of VSIE SSCA

This commit enables code paths configuring and using VSIE SIGPI and SRSI.
It adds a new module parameter to globally disable SIGP, but defaults to
enabled on supported hardware to improve guest-3 performance.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index c21603f2745bf..59561d459a4f3 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c

[ ... ]

> @@ -477,6 +482,8 @@ static void __init kvm_s390_cpu_feat_init(void)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
>  	if (sclp.has_astfleie2)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
> +	if (sclp.has_vsie_interp_extf && ssca)
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIGPIF);

[Severity: High]
Does this globally enable SSCA for the VM without verifying if the guest was
provisioned with the feature?

Looking at use_ssca() in arch/s390/kvm/vsie.c, it only checks the host-level
flag kvm->arch.use_ssca:

arch/s390/kvm/vsie.c:use_ssca() {
    if (!kvm->arch.use_ssca)
        return false;
    ...
}

Would this allow a nested guest to use SSCA features even if QEMU explicitly
disabled KVM_S390_VM_CPU_FEAT_SIGPIF for the CPU model, potentially breaking
capability negotiation and live migration?

[ ... ]

> @@ -3389,7 +3393,7 @@ int kvm_arch_init_vm(struct kvm *kvm, unsigned long=
 type)
> =20
>  	kvm->arch.use_pfmfi =3D sclp.has_pfmfi;
>  	kvm->arch.use_skf =3D sclp.has_skey;
> -	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf;
> +	kvm->arch.use_ssca =3D sclp.has_vsie_interp_extf && ssca;

[Severity: Critical]
Is there a potential out-of-bounds array access when validating the guest's
icpua index now that these paths are being used?

In kvm_s390_handle_vsie(), the bounds check compares scb_o->icpua against
KVM_S390_MAX_VSIE_VCPUS:

arch/s390/kvm/vsie.c:kvm_s390_handle_vsie() {
    if (scb_o->icpua >=3D KVM_S390_MAX_VSIE_VCPUS) {
        rc =3D kvm_s390_inject_program_int(vcpu, PGM_SPECIFICATION);
        goto out_unpin;
    }
    ...
}

Since icpua is a signed 16-bit integer, could a negative value bypass this
check?

Additionally, scb_o resides in guest memory. Is there a TOCTOU race where t=
he
guest could change icpua after the check, before it is read again for the
array index in get_vsie_page_cpu_nr()?

arch/s390/kvm/vsie.c:get_vsie_page_cpu_nr() {
    ...
    vsie_page =3D vsie_sca->pages[cpu_nr];
    ...
    WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_new);
}

Could this lead to host memory corruption if an untrusted guest supplies a
malicious index?

[Severity: High]
Could enabling these code paths allow a guest to trigger host kernel panics
via WARN_ON_ONCE assertions?

For example, if a guest configures a nested guest with an unmapped SCA addr=
ess,
pin_guest_pages() or pin_scb() would return a negative error code (like
-EFAULT). This error is assigned to sca_o_nr_pages and triggers a warning:

arch/s390/kvm/vsie.c:pin_sca() {
    ...
    if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages !=3D nr_pages))
    ...
}

Similar warnings exist in get_vsie_page_cpu_nr() and get_vsie_page() when
vsie_page_init() fails. Since KVM guidelines advise against guest-reachable
WARN_ON assertions, should these be converted to avoid host Denial of Servi=
ce?

[Severity: High]
Could this also allow a guest to crash the hypervisor by supplying invalid
nested SCB addresses?

In _shadow_sca(), if the guest provides an unaligned address, it returns
-EINVAL directly:

arch/s390/kvm/vsie.c:_shadow_sca() {
    if (scb_o_gpa & 0x1ffUL) {
        rc =3D -EINVAL;
        goto err;
    }
    ...
}

If the address is unmapped, get_vsie_page_cpu_nr() fails and returns -ENOME=
M.
These error codes appear to propagate up to the main instruction intercept
handler. Will this cause KVM to exit to userspace with the error, aborting
the QEMU process instead of injecting an architectural program exception in=
to
the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D20
