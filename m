Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D921344AB8A
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777503; cv=none; b=dvZTLDwW9a6s+rMdl1aGlglIZ9/2L9QAoTvLfnvtHO69dfL99ZOcfQ/e1NVFlRoN0jSGnVxJTxA9pG4ZG0KySM5PXPQ3aIXJ/oZsvqxfbZbEA/bo1X6OZJTRqQ85DOJ3cvF8moJSwjQSpDXoR02hjhw+lGa5bZ0ItcKXcmRHBDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777503; c=relaxed/simple;
	bh=CNpN+09q/4vFa4mIOyMLdoN56PC9e/8YzINI5p2dm1U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G4l2LKDls2hjNdWlMRj+tvcPdRpkh8rRgkca1zLhOOYh5lke09IGs2BcBkBEkg2YMKHv0qolPlKSMBl/qBDcL1JNJtmgNyo+Gio3rDSEWZ8g3+/je3/5svUxypx54NtuNNOaBW20tvBiUkln01yDwnUUJueDhx/gIH+clqufWZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m5RDkTLm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m5RDkTLm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 287201F00ADF;
	Mon,  7 Sep 2026 10:38:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777501;
	bh=tMbixtzLuNoNpPKXZ+cSKD3r5M7hmemqHzn696WWnLw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m5RDkTLmsYwg0+AigPAerlP4JGbPnKJVeifSLeNaav0FadRnUgG1NsumnSSrXGmvY
	 zH4Jc8VbshHLb4ws3Qp55gfoyAqZ3y9JaRYX9fAY67EiExUinxpfvvCOsLOhdEQx+C
	 kHvLdg1xdyBNKRllpxaRiJeVsch06quTrOlj+1/AwxH89lFCVE3O36Q6Jqq7ASPvKO
	 Vq5p43N1W9v5RB4/IU5BGLGN2xmwyXwgjmr+H+TZCZhFh+e/HGla8r1JB20H/Mu7/S
	 lMOoG2qAyn18QkELFPD8nyJZ20/GuXTcnMfuafF3Bz4bNg+nZpQUioPZX2xkU0UIlF
	 6N0tsXYvLNrmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/13] s390/qdio_main: Use kzalloc() for the IRQ
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-8-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-8-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:38:20 +0000
Message-Id: <20260907103821.287201F00ADF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Replacing get_zeroed_page() with kzalloc(PAGE_SIZE) drops strict p=
age-alignment guarantees, violating the 256-byte hardware alignment require=
ment for the embedded struct qib when SLUB debugging is enabled.
- [Low] Stale comment regarding kmemleak scanning for irq_ptr.
--

commit ca3c961e09a135301359d791ffa1a2e2f24317b3
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_main: Use kzalloc() for the IRQ structure

This commit replaces the use of get_zeroed_page() and free_page() for the
QDIO IRQ structure with kzalloc() and kfree(). It aims to improve API usage
by eliminating casts and the need to track object size on free.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index d137bf8c70664..6b9442bae7ffd 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
[ ... ]
> @@ -961,7 +962,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned i=
nt no_input_qs,
>  	    no_output_qs > QDIO_MAX_QUEUES_PER_IRQ)
>  		return -EINVAL;
> =20
> -	irq_ptr =3D (void *) get_zeroed_page(GFP_KERNEL);
> +	irq_ptr =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does this allocation still meet the strict alignment requirements for the
embedded Queue Information Block (QIB) structure?

The QDIO hardware strictly requires the physical address of the QIB to be
256-byte aligned. Since struct qib is the first member of struct qdio_irq, =
it
was safely page-aligned when using get_zeroed_page().

With kzalloc(PAGE_SIZE), if CONFIG_SLUB_DEBUG is enabled and redzoning is
active, objects in power-of-two slab caches (like kmalloc-4096) are prefixed
with redzones. This shifts the object's starting address away from the
natural page boundary, falling back to ARCH_KMALLOC_MINALIGN (8 bytes on
s390).

Could this cause the physical address of irq_ptr->qib to be unaligned and
lead to hardware I/O operations failing?

[Severity: Low]
This isn't a bug, but does this change make the kmemleak comment and
annotation further down in qdio_allocate() obsolete?

drivers/s390/cio/qdio_main.c:qdio_allocate() {
    ...
	/* kmemleak doesn't scan the page-allocated irq_ptr: */
	kmemleak_not_leak(irq_ptr->ccw);
    ...
}

Since irq_ptr is now allocated using kzalloc(), the slab allocator will
automatically track it for kmemleak, making the workaround comment incorrect
and the kmemleak_not_leak() call functionally unnecessary.

>  	if (!irq_ptr)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D8
