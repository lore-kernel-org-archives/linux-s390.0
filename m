Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7481541A79E;
	Thu,  9 Jul 2026 15:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611873; cv=none; b=tn5/x77m4fGy4hMKTBxxBPARl7BTnRAajyPueOiMDrtM3Cw9mk0pd/ddRVVO/lMeaQHCxhzXnnmBpknN9INyhQNlJ57kwrJdUwJoW4Sz0JGHpXBL5aW6XgN68EcufOW0FAeT3eLEp5keol5xBwD7Q9KnczSIUc47fydm8df5+HM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611873; c=relaxed/simple;
	bh=MrX8OdIzH9N7iTay1zKBFzN7FEHY2oBThzz11rkJMVE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dEu2oXiuKie+0TOPznfVcrVERPbpfOUnVB4laD++gs+JFGD18//BIxQmGeX6xbKJEqgEAzfa5OqqsYqrn/uZifp+I5E+8940BiLUockfBa2j0JPJ9GE538iDTrbD9Dd+F94e+ye34EGKjkoWS0UL4T9RV5MwQYKIa+DL30khycE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oN3UKuqa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oN3UKuqa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F363E1F000E9;
	Thu,  9 Jul 2026 15:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611871;
	bh=3+fOXFYwSTWeqxYdS/eOrRt4aKpQTRKm0Ls1J2wEe68=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oN3UKuqaqmqab7VSHA40NICMhQ4ab/6LywTIDeY4CPQtE/JQu3Nvx0hRH1gQAM0R6
	 d2q6yr0xSmBHV3cGQ0OBto0X9wDcJklzMqYuj4R57M89axjlEZ3WY+/Pm5Jnymac+n
	 DxHhIXXdRt6kSOF1T6JzOZDeswx9vh1VVCdVEsogiYF2IPuVCUmLx2vtHKDL8CTQ4T
	 VZBQUaFAQapnr+7xtRauV+6aPWFejHUS164s4eJkvoX+05SlPpwBnzS2oL4pF2RL53
	 xOdYX1xdutUpVM1BTqQJizigone+z9s9oAa9XYidtoQQwWcVaz6keIFXvgQfSXW6ES
	 QAUbrTSt68+lQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 21/21] KVM: s390: vsie: Enable VSIE SIGPI
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260709-vsie-sigpi-v1-21-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-21-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:44:30 +0000
Message-Id: <20260709154430.F363E1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [Critical] The guest-controlled `icpua` field is used as an array index i=
nto `vsie_sca->pages` without bounds checking, allowing an attacker to corr=
upt arbitrary host kernel memory.
- [High] A guest can permanently leak vsie_sca structures by providing an i=
nvalid SCAO, eventually exhausting the vsie_sca pool and breaking nested vi=
rtualization.
- [High] A malicious guest can intentionally trigger host kernel warnings (=
WARN_ON_ONCE) by supplying unmapped guest physical addresses in the System =
Control Area (SCA) structures.
--

--- Patch [21]: [PATCH 21/21] KVM: s390: vsie: Enable VSIE SIGPI ---
commit ea08ed257ee1485d9e9b61914b578f7cc9773f7a
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Enable VSIE SIGPI
   =20
Finally enable code paths actually configuring and using VSIE SIGPI.
SIGP can be globally disabled in the KVM module configuration but will
be enabled by default if the machine (IBM z16 onwards) supports it.

> diff --git a/arch/s390/kvm/kvm-s390.c b/arch/s390/kvm/kvm-s390.c
> index 481e566fe228b..854de405d08c7 100644
> --- a/arch/s390/kvm/kvm-s390.c
> +++ b/arch/s390/kvm/kvm-s390.c
[ ... ]
> @@ -476,6 +481,8 @@ static void __init kvm_s390_cpu_feat_init(void)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_KSS);
>  	if (sclp.has_astfleie2)
>  		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_ASTFLEIE2);
> +	if (sclp.has_vsie_sigpif && vsie_sigpi)
> +		allow_cpu_feat(KVM_S390_VM_CPU_FEAT_SIGPIF);

[Severity: High]
Does enabling this feature expose a resource leak when providing an invalid
SCAO address?

Looking at get_vsie_sca() in arch/s390/kvm/vsie.c, if a guest provides an
unmapped SCAO address, pin_sca() fails and returns an error:

arch/s390/kvm/vsie.c:get_vsie_sca() {
    ...
	rc =3D pin_sca(kvm, vsie_sca);
	if (rc) {
		vsie_sca =3D ERR_PTR(rc);
		goto out;
	}
    ...
}

It appears the newly added vsie_sca object is left in the kvm->arch.vsie.sc=
as
array with an undecremented ref_count, permanently leaking it from the
reusable pool.

[Severity: High]
Can a guest intentionally trigger host kernel warnings by supplying unmapped
guest physical addresses in the System Control Area structures?

When a guest provides an unbacked SCA address, pin_guest_pages() in pin_sca=
()
returns -EFAULT, which directly triggers the host WARN_ON_ONCE:

arch/s390/kvm/vsie.c:pin_sca() {
    ...
	vsie_sca->sca_o_nr_pages =3D pin_guest_pages(kvm, vsie_sca->sca_gpa, nr_pa=
ges,
						   vsie_sca->sca_o_pages);
	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages !=3D nr_pages))
		return -EIO;
    ...
}

Similarly, in get_vsie_page_cpu_nr(), if the SCB address is unmapped,
vsie_page_init() returns -ENOMEM and also triggers a WARN_ON_ONCE:

arch/s390/kvm/vsie.c:get_vsie_page_cpu_nr() {
    ...
		scoped_guard(mutex, &vcpu->kvm->arch.vsie.mutex) {
			unpin_scb(vcpu->kvm, vsie_page);
			rc =3D vsie_page_init(vcpu, vsie_page, scb_gpa);
		}
		if (WARN_ON_ONCE(rc)) {
    ...
}

[Severity: Critical]
Does this enablement allow an out-of-bounds array access in
get_vsie_page_cpu_nr()?

In get_vsie_page_cpu_nr(), the guest-controlled cpu_nr (which comes from
icpua and can be up to 65535) is used as an index to read from and write to
the pages array, which is only sized to 256:

arch/s390/kvm/vsie.c:get_vsie_page_cpu_nr() {
    ...
	vsie_page =3D vsie_sca->pages[cpu_nr];
	if (!vsie_page) {
		vsie_page_new =3D alloc_vsie_page(vcpu->kvm);
		...
		scoped_guard(mutex, &vsie_sca->mutex) {
			vsie_page =3D vsie_sca->pages[cpu_nr];
			if (!vsie_page) {
				WRITE_ONCE(vsie_sca->pages[cpu_nr], vsie_page_new);
    ...
}

Could this corrupt adjacent host kernel memory structures?

>  	/*
>  	 * KVM_S390_VM_CPU_FEAT_SKEY: Wrong shadow of PTE.I bits will make
>  	 * all skey handling functions read/set the skey from the PGSTE

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D21
