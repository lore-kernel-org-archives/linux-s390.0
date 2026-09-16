Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F0A499F11
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561012; cv=none; b=ByW9GLfluAOe2QNW8cyduL/dMVw/S5UTYaLqpQmVhJbRwj29dK31isJTNjkNnAa2W0sDNdFycYQ+nn7H+9SmKNZot2NBEtggsID0xDesyexkRBmWZ1WAUx/eRP8uFqcZG77OGTSzpB7ErlKxJiv/xz3Ln9AChLLD4cFU9SyKKyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561012; c=relaxed/simple;
	bh=Qc/y85UZ7K2Wq+Y65RdW82il8k1oZ3ELQjvuU24NzWM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=uAOksx9W/1XA+jEIm8BkBiRpSgDtA2DrGCHFfWsNZEu6yIRPwcqOttuRUqgTNXOBHO1UE9tX5/tdojYOVcmt0N02gq7GxDi50Igmqga6Li3FA5CYh6u0Sii74DdM9ZOO7hICe3aowGV4bUbUoBi3MjSxU4t8aT7uJqJAB5Xl6BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3Md1cDN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3Md1cDN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 597641F000FF;
	Wed, 16 Sep 2026 12:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561010;
	bh=TTaoyCQx5U9ociCS+TG5cMVaSRGWPBiIZSprOl5eJ8c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l3Md1cDNno99fTnAGLMtmyAzIioV08yO1MXROGWkSSYPpi7YDhEmsG+fx1GSLfBcm
	 VoTws3CAS2C4MZVFadyNsH4MNyG436NZETFJdPOfNNiM172wGL3Adi6MRSLdLw+z+3
	 4ksLCj0FZpfznzBwyqXXoYslvp1SsLI3wWNhzi4WhK3bnTGrWog/5ObiKeVducTXbl
	 C/MshGIXFXqUqJ6MH9XTfU9ewh6xLS7gC6SLMM3fyVzuwuDahLsThWDwvr7yepTcEe
	 rCvelhDVXW+hoRCgdCCiX0qLxMDl5ooeA+AfD9z7WUudW9Qz9pLXs+FQl1nVFdRYqf
	 eLhJbqZyA+GOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/13] s390/qdio_main: Use kzalloc() for the QDR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-9-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-9-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:16:49 +0000
Message-Id: <20260916121650.597641F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/qdio: kzalloc loses required hardware page alignment for QDR =
and CHSC
--

commit c802b7f29143c62b6663a20acaa96b4a8ed1cfb1
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_main: Use kzalloc() for the QDR

This commit changes the allocation of the Queue Description Record (QDR) fr=
om
the page allocator to kzalloc(). The intent is to use a better API and avoid
tracking the size of the freed object, as both allocators use per-CPU lists
for the fast path.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index 28eb8602ca97e..889f63f94a4a7 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c

[ ... ]

> @@ -988,7 +988,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned i=
nt no_input_qs,
>  		goto err_chsc;
> =20
>  	/* qdr is used in ccw1.cda which is u32 */
> -	irq_ptr->qdr =3D (struct qdr *) get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	irq_ptr->qdr =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Will replacing the page allocator with kzalloc() break the 4K page-alignment
guarantee necessary for QDR hardware interactions?

When CONFIG_SLUB_DEBUG (redzoning) or KASAN is enabled, SLUB prepends metad=
ata
to the object, shifting it away from the page boundary. If an unaligned
physical address is passed to the s390 channel subsystem hardware, it either
truncates the lower bits (causing silent DMA corruption by accessing adjace=
nt
slab metadata) or raises a specification exception, leading to I/O device
failure. This could affect QDIO device initialization (e.g., zfcp, qeth) on
debug kernels.

Are there similar alignment issues with irq_ptr->chsc_page and irq_ptr
allocated earlier in qdio_allocate()? CHSC command blocks require strict 4K
page alignment, and struct qib (embedded in struct qdio_irq) requires 256-b=
yte
hardware alignment. It appears kzalloc() will lose these guarantees under S=
LUB
debugging as well.

>  	if (!irq_ptr->qdr)
>  		goto err_qdr;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D9
