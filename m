Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7569536D513;
	Thu,  9 Jul 2026 15:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783611098; cv=none; b=VzaoylVui23XDJWp9bUUFDy8mgZJPq3nv59Ovqh0WqzTydEbvn1iT/shcp/+2WtpOWRGJVvTkpoDtlJKK8gyg1J4KB4FuGeKVF2Cp3815Rzq/eE0XPtXQI0PDyLo2KkNEe/W7igl3+Jx905m/ztXNcMrpfXB5IguAitcIgeT8Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783611098; c=relaxed/simple;
	bh=5CRTFTqXj2/NgNWU27UBNIhUtpfUyAXgGfxItOcUcZc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=LSxAz0ToCd1TcwiJ7o1DdAgoHYvbBimbLyWxJwELHebL4eJ35X6BTw0GsugePigdUhdqxsPaWXDNJmo+/Vsr/2FtX8S3cHX8Q9T2c4+nqCe8BgfCgmugnsPOKNdZ8FiaXqnXkK3AmeEa5pZMjB7MWmA8JTeElTj3bW55Q4O0HLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrcnp6TX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrcnp6TX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C1221F000E9;
	Thu,  9 Jul 2026 15:31:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783611096;
	bh=ogPSffQAlJzFy80VOEmOWldl0ywqDj4UnSbHxqm71+U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mrcnp6TXbOTC/PMSIICPsAnzlvy14Ygjwk1wjqPJO03EB7TOOI41Vi4nMc4MDAn/P
	 p7Keav+boL3+WdNclgLBVpkWduV4JFr2UiHuItcIoZg2oIGMXhYLpQ2s+Ztdo+exdJ
	 cWJY5iVFJji4MgvqyG1I0Kj+HEeaG+Spn4N3yhpxfgLEhMpK8D3VL2o6qBbOg+Yy3J
	 70jvmcxu44zqE57AI9bizIYbNtyeB4h6PRxKzQR2zN/9jAhCe+d0+IV2U039a7z/ya
	 5ukMfoj1zTGaTmO6qP48TMB6mFWnOd9u8ZUNBDYLFRtWVecmeejLsK9ZunF1GjwiSa
	 /Qekzr1Zzt7nQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 15/21] KVM: s390: vsie: Add struct vsie_sca with pin and
 unpin
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709-vsie-sigpi-v1-15-ea9f12066408@linux.ibm.com>
References: <20260709-vsie-sigpi-v1-0-ea9f12066408@linux.ibm.com>
 <20260709-vsie-sigpi-v1-15-ea9f12066408@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 15:31:35 +0000
Message-Id: <20260709153135.9C1221F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Guest-triggerable WARN_ON_ONCE and negative error code truncation =
in pin_sca().
- [High] Unconditional pinning of 5 pages for ESCA breaks valid guest confi=
gurations due to over-pinning.
- [High] The dynamically allocated `struct vsie_sca` leaves its embedded `m=
utex` and `ref_count` uninitialized.
- [High] Missing NULL pointer check in `free_vsie_sca` can crash the kernel=
 on error paths.
- [Low] Unused static functions trigger compiler warnings and break builds =
with `-Werror`.
--

--- Patch [15]: [PATCH 15/21] KVM: s390: vsie: Add struct vsie_sca with pin=
 and unpin ---
commit e9a459801d0d13c2945b7f63700e761f8e46bb25
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add struct vsie_sca with pin and unpin

Introduce the struct vsie_sca to hold the SSCA and required management
data along with alloc and free methods to use with the struct.

> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
[ ... ]
> @@ -831,6 +854,60 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page,
[ ... ]
> +static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
> +{
> +	bool is_esca =3D test_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	int nr_pages =3D KVM_S390_MAX_SCA_PAGES;

[Severity: High]
Will this unconditionally pin 5 pages for ESCA blocks, even if the
16,128-byte block only spans 4 pages depending on its alignment?

If a nested guest allocates an ESCA block adjacent to unbacked memory,
could pin_guest_pages() attempt to pin a 5th unbacked page and fail
with -EFAULT, incorrectly rejecting a valid guest configuration?

> +
> +	if (test_bit(VSIE_SCA_PINNED, &vsie_sca->flags))
> +		return 0;
> +
> +	if (!is_esca) {
> +		nr_pages =3D 1;
> +		if ((vsie_sca->sca_gpa & ~PAGE_MASK) + sizeof(struct bsca_block) > PAG=
E_SIZE)
> +			nr_pages =3D 2;
> +	}
> +
> +	vsie_sca->sca_o_nr_pages =3D pin_guest_pages(kvm, vsie_sca->sca_gpa, nr=
_pages,
> +						   vsie_sca->sca_o_pages);
> +	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages !=3D nr_pages))

[Severity: High]
If the guest provides an invalid physical address for sca_gpa,
pin_guest_pages() will legitimately fail and return -EFAULT.

Because sca_o_nr_pages is an unsigned long, will this negative error
code be implicitly cast to a huge positive number?

This would cause the WARN_ON_ONCE() to evaluate to true. Does this allow
a malicious guest to intentionally trigger a host kernel warning,
leading to a denial of service if panic_on_warn is enabled?

> +		return -EIO;
> +	__set_bit(VSIE_SCA_PINNED, &vsie_sca->flags);
> +
> +	return 0;
> +}
> +
> +static void free_vsie_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
> +{
> +	free_pages_exact(vsie_sca, sizeof(*vsie_sca));

[Severity: High]
Is it possible for free_vsie_sca() to be called with a NULL pointer
during error cleanup?

Unlike kfree(), free_pages_exact() is not NULL-safe for allocations larger
than PAGE_SIZE. Since struct vsie_sca is roughly 10.5 KB, free_pages_exact()
will attempt to free invalid low-memory addresses starting at 4096 on its
second iteration, which would crash the kernel.

> +}
> +
> +static struct vsie_sca *alloc_vsie_sca(void)
> +{
> +	return alloc_pages_exact(sizeof(struct vsie_sca), GFP_KERNEL_ACCOUNT | =
__GFP_ZERO);

[Severity: High]
Does relying solely on __GFP_ZERO leave the embedded mutex and ref_count
uninitialized?

Locking a zero-filled mutex is a structural defect that triggers lockdep
splats or kernel panics because its internal spinlock and wait queues
are not initialized.  Should this function call mutex_init() and
atomic_set() before returning the allocated structure?

[Severity: Low]
This patch introduces alloc_vsie_sca(), free_vsie_sca(), pin_sca(), and
unpin_sca() as static functions, but they don't appear to be invoked
anywhere in this file.

Could this trigger -Wunused-function compiler warnings and break builds
that compile with -Werror?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-vsie-sigpi=
-v1-0-ea9f12066408@linux.ibm.com?part=3D15
