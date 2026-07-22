Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E0BD27F017;
	Wed, 22 Jul 2026 17:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741215; cv=none; b=l68bOUHURoO+U68+eY5aJtOAfkK3sKSLJxve+mTUWYbysdU8goy1+wiFnv+GR81dfa8+qmxNd4jfSH4sADbduQvYaHUleci77WOLop8EVzslXPv+LRaOprEHlO+NZ/ooTmxi/fCcXinrVZc5D7bP3fiH2g4D56KTSBbJxNSr0rY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741215; c=relaxed/simple;
	bh=riMmJuRNJMpDxdhz97Gb5/uRSMVjIulfiLv8wpnxE0U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y65Tp6zpz9HP03SedE/vfArrFGPa5pjUqLSFhmxaOwNel4Ch+YXBPCWCwXu9GCuRsYmE+UeN4Oyr4fcphaL+PiNBdjDUROqRB83IyErznDGBz0sGcFiWhDGevxsMLnjE87iZoSn1KsN5ECirGs3Lk8dEGH54Ltqv/pQThg4BUTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRxRZ8Qo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRxRZ8Qo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 848261F000E9;
	Wed, 22 Jul 2026 17:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741211;
	bh=b/VDB3QqOd3N1C5/4R/O1Io4qFYuaqxVNSqacJ/Q1aA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RRxRZ8Qo7cPKkAUH+h9sWKJ+rXheqWYkszwRhM3gjkIMnnJ8nG8yBdczDFpR9Mtv8
	 HLlCDw3TPImsyYqc4f2gfUxNVTDf2JxxX6QlfW4MOMSzN2rz8hZhCyiqjP5YpGxrVa
	 tkeQHhXBpnNUm+WniEkshW+nwEFj8AF5+jnpQfVGQw4X7FWatTZmDHEVZujfx8me/X
	 5xW/jBKhlglIanQJVBjR0w95uEW+RmRQfkuStpK6HSi7MGKkKNkyYxy4GOzZ/KOHhF
	 OX2nkp4LfyVIShVbuqdhipxShJAtQJdk4NNYDxF2wrmrrzkFMCzoj7Vk7U0oyv9/1D
	 ZVQvBFoDblh1g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260722170621.1686-7-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:26:51 +0000
Message-Id: <20260722172651.848261F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The AIBV size calculation systematically overestimates the require=
d memory size, leading to false rejection of valid AIBV configurations loca=
ted near page boundaries.
--

--- Patch [6]: [PATCH v4 6/6] KVM: s390: pci: Validate AIBV and AISB before=
 pinning guest pages ---
commit 4b6ef516a235f953d1559a623689c91ffb836199
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

This commit adds validation checks for the guest-provided AIBV and AISB=20
addresses before pinning them. It ensures the AIBV does not exceed a single=
=20
page boundary and that the AISB is aligned properly to 8 bytes.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index d76b2c5484aca..e55e75b81b516 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

> @@ -268,6 +268,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  		return gisc;
> =20
>  	/* Replace AIBV address */
> +	size =3D BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
> +	size +=3D (fib->fmt0.aibvo / 8) + 1;
> +	npages =3D DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE=
);
> +	if (npages > 1) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +

[Severity: High]
Does this size calculation artificially inflate the required AIBV memory sp=
ace=20
and falsely reject valid guest configurations?

If a guest places a 1-MSI vector AIBV near the end of a physical page, such=
=20
as at page offset 4088, the size formula calculates at least 9 bytes (8=20
bytes from BITS_TO_LONGS(1) plus 1 arbitrary byte).=20

This inflated size (4088 + 9 =3D 4097) crosses the page boundary, causing K=
VM=20
to mistakenly reject a perfectly valid, 8-byte aligned memory placement wit=
h=20
-EINVAL. Can this formula be adjusted to calculate the exact size required?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D6
