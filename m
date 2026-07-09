Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEBE274FD1;
	Thu,  9 Jul 2026 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611332; cv=none; b=SzrkN69GwJAgpf6WOH7W0Kfo2jr4ETPmXEYgADCBBvDOfl+CS4F6oVeWGo0akUSshG+TvaBylz5rQa/N+/eIyP6ecpz1k5FL2zEBwFaOH08w33Y3QBZ1IFd82UMnXhpWvkGYSi7f33PqsDRVSakTs/UNi3p/n9vFWVpVms+iTiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611332; c=relaxed/simple;
	bh=oPQXSv2g52xJtgWBnJsfpy38zH0FgrFD3AYTZYlN6ZM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UMXNp1p1RV/+sRAYrE0KosvtI6s0wDu68txtlXdFfX68eANI0uaEw1eEDK57dYQW9FRJTDyz3NoraTjVo4uGOAu+FvqBMtjOBxvBZw8RUOCQAvpqkh4BzT1bFyuyhm42Q+gmoasiw705yysxxgNfMGwxJ5l9y9AHHbZiYSmgKZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=le1x8kq3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="le1x8kq3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E856D1F000E9;
	Thu,  9 Jul 2026 15:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611330;
	bh=pNg8K6zy2bhk+FkBEZVhHC425DP7ktVzsArKjUhL/fc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=le1x8kq3ipO2gVZ/m9eYrNv5sKCJ5aNEdZ0kM8KPQJCKm6wxwKzGrWyH5fEilsgjw
	 zIEB4HwZF6UO/1EXJznflz66Ez57IdB46fPvMxQezLJVQdimFtaNQgWUPzfb6FsiAi
	 WgEcpdePGMi8FoePt+E6gQOiRd4g4ipJ6CqhPRxw/IRQud+nn74SPishkSooum01uQ
	 kpmyeUm282RQTSWp5AxTevWVo5T5ApDJyyCPYjQIQxLrqN04WGmnGSghpgWhwummu+
	 LiMKJG/nGGOXYuWiU5bHdZzkuczUoYlcxq74Iv/VpyXkQirETqZNO0gJ8ELERSh/UV
	 2Kke6JDB21HEw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 17/21] KVM: s390: vsie: Allow guest-3 cpu add and remove
 with vsie sigpif
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-17-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-17-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:35:29 +0000
Message-Id: <20260709153529.E856D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [High] If `_shadow_sca()` encounters a transient error, it prematurely up=
dates the cached MCN but zeroes out the shadow SCA, permanently breaking VS=
IE SIGP handling.
- [High] Dynamic MCN updates fail to clear shadow SCA entries for removed v=
CPUs, leaving stale pointers that the hardware may access.
- [High] Mismatch between cached `vsie_sca->flags` and actual guest SCA for=
mat leads to copying garbage MCN data from wrong offsets.
- [Low] Incorrect pointer type `struct kvm_s390_sie_block *` is used for th=
e guest SCA page.

Pre-existing issues:
- [Critical] get_sca_entry_addr() incorrectly calculates the host physical =
address (HPA) of SCA entries located past the first page, leading to arbitr=
ary host physical memory access.
--

--- Patch [17]: [PATCH 17/21] KVM: s390: vsie: Allow guest-3 cpu add and re=
move with vsie sigpif ---
commit c4d503d35381889298738f17763bcbfdd845d493
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Allow guest-3 cpu add and remove with vsie sigpif

This commit enables dynamically adding and removing guest-3 CPUs in KVM
by shadowing the SCA and re-initializing the shadow SCA whenever the guest's
multi-cpu configuration (MCN) changes. It introduces caching and comparison
of the expected MCN to detect when the layout changes.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 74455c689c51b..de8931e714ca2 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> +static void sca_mcn_copy(struct vsie_sca *vsie_sca, void *sca)
> +{
> +	int offset =3D offsetof(struct bsca_block, mcn);
> +	int size =3D BYTES_PER_LONG;
> +
> +	if (test_bit(VSIE_SCA_ESCA, &vsie_sca->flags)) {

[Severity: High]
If a guest switches a control block from BSCA to ESCA (or vice versa) while
keeping the same physical sca_gpa, will the cached VSIE_SCA_ESCA flag in
vsie_sca->flags be stale?

Later in _shadow_sca(), the layout is determined dynamically using
sie_uses_esca(vsie_page->scb_o). If these disagree, could sca_mcn_copy() re=
ad
garbage memory from the wrong MCN offset?

> +		offset =3D offsetof(struct esca_block, mcn);
> +		size =3D BYTES_PER_LONG * 4;
> +	}
> +	memcpy(&vsie_sca->mcn, sca + offset, size);
> +}
[ ... ]
>  static int _shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_pag=
e,
>  		       struct vsie_sca *vsie_sca)
>  {
[ ... ]
> -	if (is_esca)
> -		mcn =3D phys_to_virt(sca_o_hpa) + offsetof(struct esca_block, mcn);
> -	else
> -		mcn =3D phys_to_virt(sca_o_hpa) + offsetof(struct bsca_block, mcn);
> +	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa));

[Severity: High]
If _shadow_sca() encounters an error later in this function, could this ear=
ly
copy of the MCN cause permanent failures?

If _shadow_sca() returns an error, vsie_sca->mcn will already be updated to
the new value, while the error path zeroes out the shadow SCA but leaves
vsie_sca->ssca.osca unmodified.

On the next VSIE entry retry, shadow_sca() will see that sca_mcn_equals() is
true, and skip re-initializing the shadow SCA. Does this leave the guest
with a broken SIGP configuration permanently?

> =20
>  	/* pin and make shadow for ALL scb in the sca */
>  	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;
> -	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots=
) {

[Severity: High]
Does this loop exclusively iterate over the bits set in the new MCN?

If a vCPU was removed by the guest (its MCN bit transitions from 1 to 0), t=
he
loop skips that CPU index entirely. Does this mean the ssda and ossea
pointers for the removed CPU are never cleared, leaving stale pointers that
the hardware might still access?

>  		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);

[Severity: Critical]
This is a pre-existing issue, but looking at get_sca_entry_addr() called
here, is there a problem with how it calculates the host physical address
for SCA entries past the first page?

arch/s390/kvm/vsie.c:get_sca_entry_addr() {
    ...
    if (hpa)
        *hpa =3D vsie_sca->sca_o_pages[pn].hpa + offset;
    ...
}

Because offset is the total byte offset from the start of the SCA block, and
sca_o_pages[pn].hpa is already the physical address of the specific pn-th
page, does adding offset again push the resulting HPA massively out of
bounds?

>  		if (rc)
>  			goto err;
[ ... ]
>  /* Shadow or reshadow the SCA on VSIE enter. */
>  static int shadow_sca(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page=
, struct vsie_sca *vsie_sca)
>  {
> -	int rc =3D 0;
> +	struct kvm_s390_sie_block *sca_o =3D phys_to_virt(vsie_sca->sca_o_pages=
[0].hpa);

[Severity: Low]
This isn't a bug, but sca_o is typed as a State Control Block
(struct kvm_s390_sie_block *) when the memory appears to actually be a Syst=
em
Control Area (struct bsca_block or struct esca_block). Could this static
typing make the code confusing to read?

> +	bool do_init_ssca;
> =20
> -	guard(rwsem_write)(&vcpu->kvm->arch.vsie.vsie_sca_lock);
> -	if (!vsie_sca->ssca.osca)
> -		rc =3D _shadow_sca(vcpu, vsie_page, vsie_sca);
> +	scoped_guard(rwsem_read, &vcpu->kvm->arch.vsie.vsie_sca_lock) {
> +		do_init_ssca =3D !vsie_sca->ssca.osca;
> +		do_init_ssca =3D do_init_ssca || !sca_mcn_equals(vsie_sca, sca_o);
> +		if (!do_init_ssca)
> +			return 0;
> +	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D17
