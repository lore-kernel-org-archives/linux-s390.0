Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACCD4468C28;
	Wed, 12 Aug 2026 15:44:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786549441; cv=none; b=ZjqQIS5RzW9QsvcfTx9eUJ/FD/wBzuYtLoEXMhS//Z2GEDqkojbWgvQx7hFwWOlxp6rjs0BdauQ7XtexFPcONvjY1VqXz1go88Yupk4QtB4SBLe/1HkUXda5J5WWy8sWCV/vTqBXF5ujnYp6B3zS1mOBYXEXH8jMUidtWtO2pp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786549441; c=relaxed/simple;
	bh=41SVDeOxvA6VvQstECCAB7S8N1vEtNFfGoZby+JWuL0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DJNcWoiFU9H6MMOCAC+YHUnvD9dPYNyfIz9T1NzHHJ6ehDBKZPrGVEeITyiDsAx+xddodxqrwEPbArZkS6FqvN4AFCj1XrBdYmB+ABkAHE6w0MWQGZLE1bNvZasSS+V7ZXhi+e7+AxujTsi/0Ojw5miuY+wYpSFQu3cmxU2NPW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Up/QCmZi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Up/QCmZi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5F501F00A3A;
	Wed, 12 Aug 2026 15:43:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786549440;
	bh=If3BWT5ZhjVB1p5Q+c8qRucgrGQlMXPHIgOm/5SpkJU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Up/QCmZiz1MdeJ6k4q1/xu85GYcEKBQbumnsna/vZsI3RL7c8x0j6ssBmJSPZQZaT
	 9zNQnTliJOWmiWEM7ZX+8YGqOAUklVET+0cFvUAocOcASDc4VoJPSlyuFWcj6mTNaz
	 K3hu5HVAbvlwKwwvWJG6kfdUs/qImuE0DYB9AbyEsfFTlwrpH/z9np3AfcDf5OWypI
	 ri3bjXt1J7h0gGN50CL6aO7lBk4pmwMhdWv13MBR1O/ab2RacSCAqjd+IsxfPurI9t
	 DvYvzw1Pgk5nAHNs4Vrbq9HSImtJw08tOLpMLFmByDV2QUccuJ6XDhjiZ35j47Gt7y
	 kg4TfVyogmX4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 13/20] KVM: s390: vsie: Add struct vsie_sca with pin
 and unpin methods
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.vom>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260812-vsie-sigpi-v4-13-f19e49666315@linux.ibm.com>
References: <20260812-vsie-sigpi-v4-0-f19e49666315@linux.ibm.com>
 <20260812-vsie-sigpi-v4-13-f19e49666315@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 12 Aug 2026 15:43:59 +0000
Message-Id: <20260812154359.C5F501F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Guest-triggerable WARN_ON_ONCE and implicit cast of negative error=
 code to unsigned int in pin_sca().
--

--- Patch [13]: [PATCH v4 13/20] KVM: s390: vsie: Add struct vsie_sca with =
pin and unpin methods ---
commit ba3e6e1a8cfd384294d05c97179c56428f5bc9cf
Author: Christoph Schlameuss <schlameuss@linux.ibm.com>

KVM: s390: vsie: Add struct vsie_sca with pin and unpin methods

Introduce the struct vsie_sca to hold the SSCA and required management
data along with alloc and free methods to use with the struct. On this
basis we can also add methods {,un}pin_sca() to simplify the pinning
SCAs in g1.

> diff --git a/arch/s390/kvm/vsie.c b/arch/s390/kvm/vsie.c
> index 442e7997ee51b..e632311222002 100644
> --- a/arch/s390/kvm/vsie.c
> +++ b/arch/s390/kvm/vsie.c

[ ... ]

> @@ -845,6 +872,74 @@ static int pin_scb(struct kvm_vcpu *vcpu, struct vsi=
e_page *vsie_page)
>  	return 0;
>  }
> =20
> +/*
> + * Unpin g2 original sca in g1 memory.
> + *
> + * Called with vsie_sca_lock held.
> + */
> +static void unpin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)

[ ... ]

> +/*
> + * Pin g2 original sca in g1 memory.
> + *
> + * Called with vsie_sca_lock held.
> + */
> +static int pin_sca(struct kvm *kvm, struct vsie_sca *vsie_sca)
> +{
> +	bool is_esca =3D test_bit(VSIE_SCA_ESCA, &vsie_sca->flags);
> +	gpa_t offset =3D vsie_sca->sca_gpa & ~PAGE_MASK;
> +	int nr_pages;
> +
> +	if (test_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags))
> +		return 0;
> +
> +	if (is_esca) {
> +		nr_pages =3D 4;
> +		if (offset + sizeof(struct esca_block) > 4 * PAGE_SIZE)
> +			nr_pages =3D 5;
> +	} else {
> +		nr_pages =3D 1;
> +		if (offset + sizeof(struct bsca_block) > PAGE_SIZE)
> +			nr_pages =3D 2;
> +	}
> +
> +	vsie_sca->sca_o_nr_pages =3D pin_guest_pages(kvm, vsie_sca->sca_gpa, nr=
_pages,
> +						   vsie_sca->sca_o_pages);
> +	if (WARN_ON_ONCE(vsie_sca->sca_o_nr_pages !=3D nr_pages))
> +		return -EIO;

[Severity: High]
Can a malicious guest trigger this WARN_ON_ONCE?

If the guest provides an invalid or unmapped physical address for the SCA,
pin_guest_pages() can fail and return a negative error code (like -EINVAL).

Since vsie_sca->sca_o_nr_pages is declared as an unsigned int, the negative=
=20
error code is implicitly cast to a large unsigned value. This causes the=20
subsequent comparison vsie_sca->sca_o_nr_pages !=3D nr_pages to evaluate to=
 true,=20
triggering the WARN_ON_ONCE.

Because guest-reachable warnings can cause a host panic when panic_on_warn =
is=20
enabled, should this code gracefully handle the error code from=20
pin_guest_pages() and return it without warning?

> +	__set_bit(VSIE_SCA_SCA_PINNED, &vsie_sca->flags);
> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260812-vsie-sigpi=
-v4-0-f19e49666315@linux.ibm.com?part=3D13
