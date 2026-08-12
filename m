Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66CC2370AC0;
	Wed, 12 Aug 2026 14:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786543443; cv=none; b=R5tIjIBTRojCtQ1vsQR2buPbzdMp374jQSetx9X0tQfIlH0Boft2+T/eQOHKFQLRx/HYHWxMczgH+cMLkNnyUhPWDW/09qQWLI2gMN1z2kUq0s4lwgFaXHabZyjFtX/sPhImGRQVwWu862Nojg7EYJRgBbovwReiIMACKvHr1+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786543443; c=relaxed/simple;
	bh=egl8FWuOjYGAJhOiUpzupKt+0VBnZ5php5F0Xex/8Ek=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XBxK2tt2P40HCjxinHMN7odVASN/9rhNsa+dxJUAwNlpBjKZmaAmA6eX2p4QMCQAZbDKBrx0Kcnpv9/o0J/3jTjmNKDqxttQxou8jDqkkqpr2kDNG4PNyCeiGLJac7PJ1gAipAnlncWpmuGQzZWEYLk2Hhj406zKbj/w2PMyWR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ai9OmcOt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ai9OmcOt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C9961F000E9;
	Wed, 12 Aug 2026 14:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786543439;
	bh=qGprAoRzUuj5OPnNZSsgBznq0Tu5FVJ63lomAapSIRo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ai9OmcOtZrTZ7VZUNkqoz4AqGs5mBu6bzX0NsOze7ynjxK2YCjwBacZk4wVqt/cb5
	 jGu+8IPiLxiCl0HQAfJZZaRC4PklmNgUWU/LJmFPMvvUBX/iVDIdcOOxGanJf753UK
	 SnY003343DTs/eWh/84Bkf9LwrQd1l+/bkBovQBkVN1hoe2liqL0Nz4ICb9y6Mvssj
	 QBaQcErIBWMloyhezrRL/jJ66S3ygocNn6DE5isqwluL4IpFTO6VmCTcjk+PAk1R+b
	 Pe5RQpwGSuODrPuznyY7ebHcF2igX4FlZkjf0b8lT65XMbz+AAyWz6O6X2GitLz6/8
	 EF1KlqaL6t+qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 05/20] KVM: s390: vsie: Move pin/unpin_scb methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>
In-Reply-To: <20260812-vsie-sigpi-v4-5-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-5-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 14:03:58 +0000
Message-Id: <20260812140359.4C9961F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Low] Moving `pin_scb()` and `unpin_scb()` above `pin_guest_page()` and `=
unpin_guest_page()` breaks the build due to implicit function declarations.
--

--- Patch [5]: [PATCH v4 05/20] KVM: s390: vsie: Move pin/unpin_scb methods=
 ---
commit 9ab8e79b084bfe3f666a241f273dcfef094a8a8b
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Move pin/unpin_scb methods

This commit moves the pin_scb() and unpin_scb() functions higher up in
arch/s390/kvm/vsie.c in preparation for subsequent patches.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index eea670530acbc..4b67bde0535fc 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c
> @@ -660,6 +660,39 @@ static int shadow_scb(struct kvm_vcpu *vcpu, struct =
vsie_page *vsie_page)
>  	return rc;
>  }
> =20
> +/* unpin the scb provided by guest 2, marking it as dirty */
> +static void unpin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> +		      gpa_t gpa)
> +{
> +	hpa_t hpa =3D virt_to_phys(vsie_page->scb_o);
> +
> +	if (hpa)
> +		unpin_guest_page(vcpu->kvm, gpa, hpa);

[Severity: Low]
Does moving this function up here cause a build failure?

It looks like unpin_guest_page() is defined later in the file. Calling it
here before it is declared or defined might result in an implicit function
declaration error during compilation.

> +	vsie_page->scb_o =3D NULL;
> +}
> +
> +/*
> + * Pin the scb at gpa provided by guest 2 at vsie_page->scb_o.
> + *
> + * Returns: - 0 if the scb was pinned.
> + *          - > 0 if control has to be given to guest 2
> + */
> +static int pin_scb(struct kvm_vcpu *vcpu, struct vsie_page *vsie_page,
> +		   gpa_t gpa)
> +{
> +	hpa_t hpa;
> +	int rc;
> +
> +	rc =3D pin_guest_page(vcpu->kvm, gpa, &hpa);

[Severity: Low]
Similarly, does this call to pin_guest_page() also trigger an implicit
function declaration error, since it appears to be defined further down in
the file without a forward declaration?

> +	if (rc) {
> +		rc =3D kvm_s390_inject_program_int(vcpu, PGM_ADDRESSING);
> +		WARN_ON_ONCE(rc);
> +		return 1;
> +	}
> +	vsie_page->scb_o =3D phys_to_virt(hpa);
> +	return 0;
> +}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D5
