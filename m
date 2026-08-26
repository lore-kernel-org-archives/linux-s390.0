Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF231422E24;
	Wed, 26 Aug 2026 15:23:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787757814; cv=none; b=NJ2pT7RbBhXrt/L6yeCOL1HrL9SnuYzVw5t/YzDoI24teaqagr+T7GJf1PvrHOys8K0ycv6/pjySWm/2QLm7mBewy6Rtu5d0iiQJffO1hxdzQAwlDIaZPgiFE9vZtbSs7U5oVzpPv5znErRE3CUbZUh6pxPG9QSAHHHRLZG/XLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787757814; c=relaxed/simple;
	bh=Gn8tAvlG0V6J8gL7jKAHXRm8IOyLX9+ogs8vz7MdhPE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QXFjgWomnfVttZjkXs0tvud0AYag8ZKoPj5hUFa3qpy28+vDQ5m8nNbLqpbVvRWoHiC03NkJW4MlN7YIWADAYVhqfcat+M6nllm+jd8i/cOIa3acAfMGUea3MXYT3aYK5Oqr6hKMMuXk2QNuiKf/EXJ3dC/nEUAvqwD7ZUYqcwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hGrnqxBA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hGrnqxBA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9A241F00A3A;
	Wed, 26 Aug 2026 15:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787757808;
	bh=tlmOaRFQQaTUMx0/LttoOvcMkrSqqtbc1Ma0GPpqqeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hGrnqxBApYKMC88DKoMEBFXgPi7GvOEmOG0X64hObFaqDjN4cV10C1UtcqbZw5RrD
	 +EEtRqJ82aZMm8XGtSn/egvTBwb3PefGVvvqscrCz4zPPVGDXcIw2MJXT3o48zqmS5
	 KLK4HJ8p6lpMF9oBO+mYn1ZvOCA9FkXGvpbDNNohXtuFE/x5OxwloBunV7G72faIMM
	 n6UANbkBgjw/DUkXlyLTcOyA6uLQ36aw3cgjsBN0/+EiAvs5Ppg5ww7xICFa6VFwbG
	 mjcNjgEr+xlUqXnuX6ED4sdOMBiyNwvEFZ+EGaHbCEIw2B2hZVo/VBhDxxOYSodFxh
	 gPZnAE7m/lKrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 17/21] KVM: s390: vsie: Allow guest-3 cpu add and
 remove with ssca
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260826-vsie-sigpi-v5-17-cf471edb46b2@linux.ibm.com>
References: <20260826-vsie-sigpi-v5-0-cf471edb46b2@linux.ibm.com>
 <20260826-vsie-sigpi-v5-17-cf471edb46b2@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 26 Aug 2026 15:23:27 +0000
Message-Id: <20260826152327.A9A241F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Shadow SCA does not clear entries for CPUs that are removed from t=
he configuration, leading to incorrect SIGP delivery.
--

commit c4d994f0fee41044da7d25bf24f02291a68cd80a
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Allow guest-3 cpu add and remove with ssca

As we are shadowing the SCA we need to add and remove the pointers to
the shadowed control blocks and sca entries whenever the mcn /
processors in the configuration changes.

> diff --git a/arch/s390/kvm/s390/vsie.c b/arch/s390/kvm/s390/vsie.c
> index 4bd11eaa7d81d..6e42b00206bd9 100644
> --- a/arch/s390/kvm/s390/vsie.c
> +++ b/arch/s390/kvm/s390/vsie.c

[ ... ]

> @@ -2126,17 +2163,17 @@ static int _shadow_sca(struct kvm_vcpu *vcpu, str=
uct vsie_page *vsie_page,
>  	bool is_esca =3D sie_uses_esca(vsie_page->scb_o);
>  	unsigned int cpu_nr, cpu_slots;
>  	hpa_t sca_o_entry_hpa;
> -	unsigned long *mcn;
>  	int rc;
> =20
>  	if (is_esca)
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct esca_block=
, mcn);
> +		set_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
>  	else
> -		mcn =3D phys_to_virt(sca_o_hpa(vsie_sca)) + offsetof(struct bsca_block=
, mcn);
> +		clear_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	sca_mcn_copy(vsie_sca, phys_to_virt(sca_o_hpa(vsie_sca)));
> =20
>  	/* pin and make shadow for ALL scb in the sca */
>  	cpu_slots =3D is_esca ? KVM_S390_MAX_VSIE_VCPUS : KVM_S390_BSCA_CPU_SLO=
TS;
> -	for_each_set_bit_inv(cpu_nr, mcn, cpu_slots) {
> +	for_each_set_bit_inv(cpu_nr, (unsigned long *)&vsie_sca->mcn, cpu_slots=
) {

[Severity: High]
Does this code skip clearing entries for CPUs that are removed from the
configuration?

When guest-2 removes a CPU, its bit is cleared in the original SCA's mcn.
Then KVM detects the mcn change and calls _shadow_sca().

Since this loop copies the new mcn and iterates only over the set bits using
for_each_set_bit_inv(), won't the ssca.cpu entries for the removed CPUs be
skipped and never zeroed out?

Because the hardware SSCA structure lacks an mcn mask and relies on ssda =
=3D=3D 0
to identify non-existent CPUs, could the hardware continue to use the stale,
non-zero shadow pointers and process SIGPs for removed CPUs instead of
returning CC 3 (Not Operational)?

>  		rc =3D get_sca_entry_addr(vcpu->kvm, vsie_sca, cpu_nr, NULL, &sca_o_en=
try_hpa);
>  		if (rc)
>  			break;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260826-vsie-sigpi=
-v5-0-cf471edb46b2@linux.ibm.com?part=3D17
