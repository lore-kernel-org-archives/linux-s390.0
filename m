Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 284F731E852
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:12:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560770; cv=none; b=H4JP15LKnLvQSF6vTi2EV6LXx1d5qlVb28/OOOw4sqs8PgRc2MzWHiEt4w91BK3FKtQ14kFTJZa4asTC6p3HchyKEVlGM5qDrwCAoI/09YFbE2RCH6xjFZuIjcmSiAMC5ckW2ASZWMcoNapSNAWFS6UUbSVOcnXFYW3Y6wU4DP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560770; c=relaxed/simple;
	bh=ravg84VkOcg29uF0q0OGvt7t0llZQhbR20tSKPOdF3k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CVGaqsbeGPRLiK62KFnQGDcwGtvcmXFpx1sHntm4D8ypIeFueBA5YhswJM4gmdAdGnc0G67XURfghBZYWM/lTC3iVZqxY6QQkirzs1TnumsQ2XJAw+mX4zjOy7ZOKPQI9kka8Hz1tr1CIsLxRjm5ZgNznoOL6vx5DewaqYPkmc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IzHhRXcT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IzHhRXcT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77BF91F000FF;
	Wed, 16 Sep 2026 12:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560768;
	bh=xvbBBgSCbBAb3fx7CR0j4+HNu9sPT8WGFZp2o+YbncU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IzHhRXcTwiKUx166x5Yy5iebN3yaT3zM6MdbCGzCseIqLws1bHu6Iuoy9hGuJ+bUd
	 kBvCUojgHvKp79XyWOekYngNIdpgo8SLMYfB/wI1hrmmMwMs4ScglnVGpwKDDyI/BE
	 MAqtIv57BZ7Tq0JzfDIYcMCeHwHV6YMUWtr+cQhUzHOqTFhPIElR3SnPoiB0gLCGc6
	 USkhMThvPH9mbqVb16ywfhYpbuSEv+FvQwAspFs1xFUHq9y9Ufp52G7s4n6jGzCM6L
	 YxfxfHVEhNWBaX2n+bXNqr22rPCMJyCnuCYMPB6V+7nqZ8YkZO9MOo+q+awSEbvUVg
	 0cljIIfWYoVag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/13] s390/cio: Use kzalloc() for CHSC work areas
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-5-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-5-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:12:48 +0000
Message-Id: <20260916121248.77BF91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: kzalloc() breaks CHSC hardware 4K alignment requirement
--

commit a66087fda8920c920a2e60507dcf682684ee9966
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

    s390/cio: Use kzalloc() for CHSC work areas
   =20
    chsc_init() allocates the work area for CHSC commands and
    qdio_allocate() allocates one for CHSC calls during qdio_establish().
   =20
    This memory can be allocated with kmalloc() as there's nothing special
    about it to go directly to the page allocator.

    Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@=
redhat.com

> diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> index c3186c0a372b4..d98f629e89295 100644
> --- a/drivers/s390/cio/chsc.c
> +++ b/drivers/s390/cio/chsc.c
> @@ -1143,7 +1143,7 @@ int __init chsc_init(void)
>  	int ret;
> =20
>  	sei_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
                   ^^^^^^^

[Severity: High]
Can this kzalloc() allocation for sei_page in chsc_init() cause a hardware
specification exception?

The s390 CHSC (Channel Subsystem Call) instruction requires its command-req=
uest
block operands to be strictly aligned on a 4K page boundary. Under kernel d=
ebug
configurations like CONFIG_SLUB_DEBUG or KASAN, kmalloc caches append redzo=
nes
and metadata, which shifts the payload offset within higher-order pages and
breaks the natural page alignment.

Since sei_page is passed to the CHSC instruction, an unaligned operand could
result in a kernel crash.

> -	chsc_page =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	chsc_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
                    ^^^^^^^

[Severity: High]
Does replacing get_zeroed_page() with kzalloc() here similarly break the 4K
page alignment guarantee for chsc_page?

Like sei_page, the global chsc_page in drivers/s390/cio/chsc.c is used dire=
ctly
as a CHSC command block and will fault if it is unaligned. By moving from
get_zeroed_page() to kzalloc(), the strict page alignment guarantee is lost=
 on
debug kernels.

[ ... ]

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index c1e09fa34e774..d137bf8c70664 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
[ ... ]
> @@ -986,7 +986,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned i=
nt no_input_qs,
>  	 * qdio_establish. In case of low memory and swap on a zfcp disk
>  	 * we may not be able to allocate memory otherwise.
>  	 */
> -	irq_ptr->chsc_page =3D get_zeroed_page(GFP_KERNEL);
> +	irq_ptr->chsc_page =3D kzalloc(PAGE_SIZE, GFP_KERNEL);
                             ^^^^^^^

[Severity: High]
Does using kzalloc() here in qdio_allocate() break the 4K alignment
requirement for the per-irq chsc_page?

This per-irq chsc_page in drivers/s390/cio/qdio_main.c is passed to hardware
in qdio_setup_get_ssqd() and set_subchannel_ind(). If CONFIG_SLUB_DEBUG or
KASAN is enabled, the kzalloc payload may not be 4K-aligned, causing a hard=
ware
specification exception during device setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D5
