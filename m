Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FD2546EC99
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:12:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038723; cv=none; b=KtUvGA3Q85hecqKDiNO0P/KsizKMV7g/i9X0AyL1WJYs++q2DrIH4LySRHtplncNqgnh4ZonOLpIi3TJnlaW5IAlqGnmqFDT3B57zLoNAgjnUu50UpyfsYT3UxCkoYEzp624jqWIgjDpSYiFhuroA7PgoFeH/SS4NcSib2bUnc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038723; c=relaxed/simple;
	bh=gbHmsGmAMjOArX9OHvspDul/iJJP0XTTlVivBlWAXQk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YXdJEbY5Jg7MnkLDDO+OgTbswZA2xGHtnhyCYLZZelSfMfX5QYAG+RNzDk/I7HMCK/w9/pT1SHbMPiq62gIIwPK2m2ZeKPY0E5HYkoVm5aBcY4YZTn4vViJA9LxQkJ/KPgjJILSQYy+0sHxwR2r6FMNxQJTtchZokYLewNQDW5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lOGMt48X; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lOGMt48X"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2FB91F000FF;
	Thu, 10 Sep 2026 11:12:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038722;
	bh=htSRY9z+V2jMFgYRnHEgU/nA40dCXYzyBjhJsH8y8Wk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lOGMt48Xar06boF8f7S9XlSw/TIjTAu4nEYnaLHTW3ooOqEmo4R0oP/AJz7PDvjH/
	 6vOdHzukZrfzQJAySIdbjIp0+CtW4O3VTtreiloDvgKlmig16hYyRduK5xyMc7EttV
	 ypRbzQGiFFb/UDbsjEL1IVHq5SheGavkuJOfGLLQ7URc6lQm3m53/Fnzq1lEIsQVH5
	 9b3q0yjOEupn13smCy5iFl07p00P3OEEiJfccfn+sFwzKCIIevyb/isWXOU4NSqJZq
	 /udd8E20+o7xpMR/yalxfqwuoFTKcAit1/+f7fkw2BwBQLH+bLzRkkOc+2BlHIQZcQ
	 vmtHMkd+xcvzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/13] s390/cio: Use kzalloc() for CHSC work areas
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-5-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-5-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:12:01 +0000
Message-Id: <20260910111201.E2FB91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware Alignment Violation: Replacing `get_zeroed_page()` with `=
kzalloc(PAGE_SIZE)` breaks the strict 4K hardware alignment requirement for=
 S/390 CHSC command blocks.
--

commit 30a8ee9cd7633040e19703afbcfd0201f58a6178
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/cio: Use kzalloc() for CHSC work areas

This commit replaces the use of get_zeroed_page() with kzalloc() for alloca=
ting
CHSC work areas. The change is intended to provide a cleaner API and remove
the need for type casts.

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
Does this break the strict 4K hardware alignment requirement for S/390 CHSC
command blocks?

The S/390 chsc instruction requires its command block operand to be exactly
4K-aligned. While get_zeroed_page() guarantees page alignment via the buddy
allocator, kzalloc(PAGE_SIZE) does not provide this strict guarantee. If
CONFIG_SLUB_DEBUG (such as SLAB_RED_ZONE) or CONFIG_KASAN are enabled,
metadata is added to the slab object, shifting the returned pointer off the
page boundary. This unaligned address will cause the CPU to raise a
specification exception (PGM 06) and trigger a kernel panic when the
hardware instruction executes.

This isn't a bug introduced by this specific patch, but the same alignment
requirement also seems to apply to the cub array pointers in cub_alloc()
(from s390/chsc: Use kzalloc() for CUBs) and chsc_area in chsc_ioctl_start()
(from s390/chsc_sch: Use kzalloc() for CHSC requests) introduced earlier
in this patch series.

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
Does this allocation in qdio_allocate() also violate the 4K hardware alignm=
ent
requirement for the QDIO-specific CHSC command blocks?

Like the change in chsc_init(), allocating this with kzalloc() instead of
get_zeroed_page() risks returning an unaligned address when SLUB debugging
or KASAN are enabled, deterministically crashing the kernel on I/O setup.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D5
