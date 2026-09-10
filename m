Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9C80471416
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039197; cv=none; b=jh6WsqvCsaJW03img8I89kaDy/VrrOFUyCqWOJNHlsOAw6oAs8KMGIurS4u8Cxyx6uC1hKtMquoMmEARvM321ACuOYyMLx7POg18x6BnTKe3tneQlW0oPuPi0OTXQkPcsGKAyIEkI4Xrqt+IEwhtSa3R/nqv+AD34Uj1fPZ5mrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039197; c=relaxed/simple;
	bh=GLz+NVbR7+eaQRvamF59slhuSF31sVhCWWD2VMbKpoQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=loYogn7ldNNAyuyvkD13LSc1zL3UOv36/BzVPF0M8wgUlMY68a4P+i3FahxEPZ2F6iKvgVcn2ePBjImagBGVkXBedWNhMlLwqrO9zuCNhYgFLUi6mbtkFYUE8Te2QmUJRh8tBaxqSl7IMDfmS/3Od0TfdMUpc1b2rSWLuse4h+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GAUmLZrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GAUmLZrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D18B31F000FF;
	Thu, 10 Sep 2026 11:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039194;
	bh=QiXehDHQqNK90Zln1P7oKVJUstCGth/gof3V+gPMq4U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GAUmLZrkV7RhToVxPwBkS0TCW31LKlPGLOuZQZbFFrGWG+0FadKlWKQG+k00TxqkL
	 3v2BNSsoAznsDklLdxuUlFqrwKdf5JDkuCvWF89giH2y9pSa/ksFdYIy/FwoyqFFOW
	 9lcRAh+X/EDrBzlCmXIESi6oaQWhZgXeP577dzFqBPIHLNsNwDSqpgPpnTBY3neeN2
	 M1tANc+V8zUGirAwCoX9zpQQ9uFgdajxupzYg19QId5ZX4MeyRXkxuFa2sEjGaijU8
	 TDltIrilbNFlu6VatDS4aEHdH2Ug55VjPjbkcoKDc54iINf2AXz4GAuqzR4qnW4YK/
	 PBNrNAwuMUx1Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/13] s390/qdio_setup: Use kzalloc() for the SSQD
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-12-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-12-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:19:53 +0000
Message-Id: <20260910111953.D18B31F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware Alignment Violation in CHSC command block allocation
--

commit 43772ff0bb381f4318bb2f363719b4922b09d117
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_setup: Use kzalloc() for the SSQD request

This commit modifies qdio_setup_get_ssqd() to use kzalloc() instead of
__get_free_page() for allocating the Store Subchannel QDIO Data (SSQD)
CHSC command block. It also replaces the corresponding free_page() call
with kfree().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
> --- a/drivers/s390/cio/qdio_setup.c
> +++ b/drivers/s390/cio/qdio_setup.c
> @@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
> =20
>  	DBF_EVENT("getssqd:%4x", schid->sch_no);
>  	if (!irq_ptr) {
> -		ssqd =3D (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
> +		ssqd =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
In drivers/s390/cio/qdio_setup.c:qdio_setup_get_ssqd(), does this allocation
maintain the strict page alignment (4K boundary) required by the S/390 CHSC
instruction?

While kzalloc() with PAGE_SIZE might naturally align to 4K on standard
configurations, this guarantee is lost when CONFIG_SLUB_DEBUG (e.g., object
poisoning or redzoning) or KASAN is enabled. Under these configurations, SL=
UB
adds metadata or padding before the object, shifting the returned pointer o=
ff
the page boundary.

Passing an unaligned address to the CHSC hardware instruction triggers a
hardware specification exception (Program Check 0x06) and a kernel crash
deterministically during QDIO device setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D12
