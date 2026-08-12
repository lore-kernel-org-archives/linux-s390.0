Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE5E3644A2;
	Wed, 12 Aug 2026 16:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786552826; cv=none; b=K3a4a3j64Lu0SBBCYOquZQwoadqFZQSkaVIbcZsl7vLmClKkt2ywF0oO3itSJRc9FoyOjK9nFb6TLhN7LFHzliLcbhAh96ALnxF+ha1mzKbjEkZ2TnB+/AHNlov/9mf6JVGbS9AUJbtJb4Md0K1wXfRfsKCqdwcjyZifRjseUQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786552826; c=relaxed/simple;
	bh=OsTBiKu5UQS6ILOJcAqVh08RGY9BiQEz3iEp54M+VD4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Jf071qhq24RbIJsUa9K7rSNbWHg/AZuTCU6UKRLVMAwnLYGRTzKGCR3cV+FTQ7DjqJG/JOlMG9eh50Z7wHWrOuFudx+tj9dcasMEvnF8l6B1xRUOJKOQUjS8AUKyNycOIGT3xJhYo0W+W+Emzour99bQMLHMtpTLD3t8Hm4iXho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YKVMRd0M; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YKVMRd0M"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 373B21F000E9;
	Wed, 12 Aug 2026 16:40:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786552824;
	bh=qhuirGyo5h2ngsuvvVW+iNGrGd/+ZRmMyeOW6lzDCCs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YKVMRd0MowdnwXfd6jL5MdSj969qRgSYEwWVT9Q9qqid2QVUzrm7EssZbuuZRmz1A
	 UP34vs8xBPqfGFNukpUgCT9gOjjGw5O1CjhtonxSgDd/NBDihEkySnCyrvUtbnbYGS
	 8qdv/mLDu8fSFIlXt0dm8Ja4ebX5I+GehO2JlEqTPO9Jl2Ek3jnXFYvcr8VEk6S1Lp
	 ETAkc8aqX2r/cGKLXy7W0uKhxff8F6i/0Z0FjsXV6d8d0Y/I2jtmFEXA6MVZaUPiOD
	 F1HxuxfUXWtuH+lgEkmu7Hd2a7mI9myc+n2C2qAi9t3vx7A81rspdA6XorMcpGwj/4
	 OQcHDjjnN4bew==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 16/20] KVM: s390: vsie: Allow guest-3 cpu add and
 remove with ssca
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-16-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-16-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 16:40:23 +0000
Message-Id: <20260812164024.373B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [Critical] The main CPU's `vsie_page` is freed twice during `kvm_s390_vsi=
e_destroy()`, leading to a fatal host double-free vulnerability.
- [High] Removed CPUs are not cleared from the shadow system control area (=
SSCA) during configuration changes, leaving stale active entries in hardwar=
e.
- [High] Failure to clear the VSIE_SCA_ESCA flag when transitioning from ES=
CA to BSCA causes memory corruption and infinite re-shadow loops.
- [High] Dynamically changing the SCA format from BSCA to ESCA fails to rep=
in memory, triggering a guest-controllable host WARN_ON_ONCE.
--

--- Patch [16]: [PATCH v4 16/20] KVM: s390: vsie: Allow guest-3 cpu add and=
 remove with ssca ---
commit 73a8d58ca743bc97299afb560aeb506eff16cf44
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca

As we are shadowing the SCA we need to add and remove the pointers to
the shadowed control blocks and sca entries whenever the mcn /
processors in the configuration changes.

It is not expected that the mcn changes frequently for an already
running guest-3 configuration. So we can simply fully re-init the ssca
whenever the mcn changes.

> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -2071,18 +2108,16 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page,
>  	struct vsie_page *vsie_page_n;
>  	hpa_t sca_o_entry_hpa;
>  	hva_t sca_o_entry_hva;
> -	unsigned long *mcn;
>  	gpa_t scb_o_gpa;
>  	int rc;
> =20
>  	if (is_esca)
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block=
, mcn);
> -	else
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block=
, mcn);
> +		__set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);

[Severity: High]
If the guest switches its SCA format from ESCA to BSCA, is_esca will
be false, but does anything clear the VSIE_SCA_ESCA flag?

If the flag remains set, it seems subsequent functions like
sca_mcn_copy() and get_sca_entry_addr() will incorrectly parse the BSCA
using ESCA offsets. Could this lead to memory corruption or infinite
re-shadowing loops since config_changed() would always return true?

[Severity: High]
When dynamically switching from BSCA to ESCA format, does the system
need to repin memory for the additional SCA pages?

If a guest starts with a BSCA (which pins 1-2 pages) and dynamically
switches to ESCA while keeping the same SCA address, the VSIE_SCA_ESCA
flag is set here but the additional pages (up to 5) are not pinned.

Could this cause get_sca_entry_addr() to calculate a page index that
exceeds sca_o_nr_pages:

get_sca_entry_addr() {
    ...
    if (WARN_ON_ONCE(pn >=3D vsie_sca->sca_o_nr_pages))
        return -EINVAL;
    ...
}

tripping the guest-controllable host WARN_ON_ONCE at the bounds check?

> +	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
> =20
>  	/* pin and make shadow for ALL scb in the sca */
>  	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;
> -	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots=
) {

[Severity: High]
Does this loop leave stale active entries in the shadow system control
area (SSCA) when CPUs are removed?

If an unprivileged guest modifies the MCN mask to remove CPUs, this loop
only iterates over the currently set bits in the new MCN mask.

Since the SSCA entries for the removed CPUs are not cleared, won't
hardware continue delivering SIGPIs to these stale entries because it
uses a non-zero ssda to identify active CPUs?

[Severity: Critical]
Does storing the main CPU's vsie_page during this loop lead to a double-free
during VM destruction?

When vsie_page->scb_o->icpua =3D=3D cpu_nr, vsie_sca_update() is called with
the vsie_page. This vsie_page is already tracked in kvm->arch.vsie.pages[],
and vsie_sca_update() also adds it to vsie_sca->pages[cpu_nr].

When the VM is destroyed, kvm_s390_vsie_destroy() frees all pages in
kvm->arch.vsie.pages[], and then iterates over vsie_sca->pages[], freeing
those pages too. Will this blindly free the same main CPU's page twice?

>  		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);
>  		if (rc)
>  			goto err;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D16
