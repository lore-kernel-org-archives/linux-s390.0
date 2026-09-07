Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC04456DFD
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777457; cv=none; b=bTxUv3AEusrAJ0xfFTr6J0gqeZAd5R5iYRah4vqBopD60DLR5+rIsXHbk1CmLaRr8UWuoivVxcdCEcPilI1vd9UtQR1VoNhg3C3YoxR7dm33aA2cGRWZJIGcl9bhkC9IO1W+bZH5DRFA33sFXd9W+6fnSBF3d1lB96JPL10T+Tg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777457; c=relaxed/simple;
	bh=o/QaW5/k0ylYWtMwh4v2Wg3M3maLYWURI4Xgj0ewn2Q=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZYgKRux1yltBs3Dz2PRRcjrURuoLg4+tJamD8lEH3FwuzItx4HaJD6wtqIasXkNB0BgmF52t21T4ELzt+6BmW5jtd8XpYDPVCa67QnB/TIEvtNPMO5FoMoqRQHmbVzY1MnmyGzdECgi1c6IahkN+sEqE5r2u/HKebJ4mX3Kt/+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gLEzrTsx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gLEzrTsx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27D691F00A3D;
	Mon,  7 Sep 2026 10:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777455;
	bh=OZfevBoAEELATnTaOHClC3gPbY07Zq+0I9cScXm8bmo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gLEzrTsxmCqKwvB946F4Rm8SZABsT2xN4MVSA7HvGqreGXK4qCnqTegvx1mH6j7mS
	 4jn518SbcTZmc/3UDjqwgJWtFWbenu/Xpe+ELSUNmgAHZuNTrQGL+Zi4PGalwLlvsw
	 3SZEXXpt9RxyE15iDN+KTdr/wKu14/9w5SSyHGq6QTbLRMbK+LU0i83l0eLHsU5XzR
	 hVYtQ3+wlWsjjIlPfu7P3CrJ7yVKi0O42kcnL80MqJq2dnu+H9hRu/CwQraIwS/ccV
	 oUxIilU4t0t98aCJ+g/7Y5oGRM6ifl2m4XV/ihUmajwMZd4+Hz0qRJB7mYqDVYY+cy
	 OuuH7eiCfxmrg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/13] s390/cio: Use kzalloc() for CHSC work areas
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-5-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-5-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:37:34 +0000
Message-Id: <20260907103735.27D691F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing get_zeroed_page() with kzalloc() for CHSC (Channel Subsy=
stem Call) memory blocks breaks the strict 4KB hardware alignment requireme=
nt when SLUB debugging or KASAN is enabled.
--

commit 9694c5915181f336b62527d191701841da8a5e9a
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/cio: Use kzalloc() for CHSC work areas

chsc_init() allocates the work area for chsc commands and
qdio_allocate() allocates one for chsc calls during qdio_establish().
This commit replaces the use of get_zeroed_page() with kzalloc() and
free_page() with kfree() for these allocations.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index c3186c0a372b4..d98f629e89295 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -1143,7 +1143,7 @@ int __init chsc_init(void)
>  	int ret;
> =20
>  	sei_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
> -	chsc_page =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	chsc_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Does replacing get_zeroed_page() with kzalloc() cause a regression by
breaking the strict 4KB hardware alignment requirement for chsc command
blocks?

While kzalloc(PAGE_SIZE) might return page-aligned memory by default, if
slub debugging (like redzoning) or kasan is enabled, metadata is inserted
before the object, shifting the returned pointer away from the page boundar=
y.
Passing this unaligned pointer to the chsc instruction could cause the
hardware to raise a specification exception and crash the system.

[ ... ]

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index c1e09fa34e774..d137bf8c70664 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
> @@ -986,7 +986,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned i=
nt no_input_qs,
>  	 * qdio_establish. In case of low memory and swap on a zfcp disk
>  	 * we may not be able to allocate memory otherwise.
>  	 */
> -	irq_ptr->chsc_page =3D get_zeroed_page(GFP_KERNEL);
> +	irq_ptr->chsc_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Could this allocation introduce a similar regression with 4KB hardware
alignment?

Since the qdio chsc page is also used for hardware instructions in
qdio_setup_get_ssqd() and set_subchannel_ind(), losing the strict page
alignment guarantees of get_zeroed_page() when debugging is enabled might
lead to unaligned command blocks and hardware specification exceptions.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D5
