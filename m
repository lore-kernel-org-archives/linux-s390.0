Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84987471CF0
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039256; cv=none; b=WhyTqzaQmUg4dCbHZt/5EkgZnPXKnNBlIVRDavXOWau2Tfti9rpZcc4t7Hp+cP4eVcEazPd78gZVxTzzva4f+zcOWlfjgw4Ab3Pv2YnyyypczOgqBonhNhKAhVQOWPZcEQv2JV/sQ6EiRctoK3yTbiRTn3MQqW9T1Ns9yV9GDvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039256; c=relaxed/simple;
	bh=P+o4rMrMi9CwtXGa2uoympt4ozl/vHK/MGCEurA63vA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mcd8i0cLhdEiIEf/ZNTir581Oo1WXdHvTsPwXfpGqjVY6g8GU/gifJqC8zG3owGgcnQ7cq/TpFEeUO6EZ63gfXIcMw3jH8N/qsXDpig9ln3XG1fY6VyEehGmpowMukB++/xKwar0S3KaexiEsNREeEuWfNGdsxdJdiXQwJ5N09A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brGkgce+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brGkgce+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B48DF1F000FF;
	Thu, 10 Sep 2026 11:20:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039255;
	bh=6Wif6LZpSpYxi7HcgawEWpa9C+edAc+ZWvwPd5ZRytQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=brGkgce+ojjn5arBDhHafn5DeWdLoy5RNLMbU3WAI8DtZl+NZ1P2reGmDTLxWCUnk
	 //I678Hl/JI2l7ofX9je4pE1wNTGviz8uWhXPMTklhyg3dzzh8Sp7EHhEFVuh4hFiy
	 RYpmDFyfBE5dS4Kg+p4HCuxuUQ4xOcwdbxASMnVG463ZfOPUbkqx/pDTDq2Kh/UWwj
	 HQOR/tdbkXkl0rlg4fyGcF5Edgg57K3uslJsIZHevh4QIiPf9wq9a2aEDbPpGPkBPS
	 YPUus0oVjH6ZKzheYkjFlF/dmKZLtmZInWJ4RErdyb6z1IGP0s1yh1YxUnUjS75x0z
	 mkuMc8W5eqhuw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/13] s390/qdio_main: Use kzalloc() for the IRQ
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260910-s390-cio-ready-v2-8-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-8-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:20:54 +0000
Message-Id: <20260910112054.B48DF1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing get_zeroed_page() with kzalloc() removes the guaranteed =
page alignment, breaking the strict 256-byte hardware alignment requirement=
 for the embedded Queue Information Block (QIB) when SLUB debugging or KASA=
N is enabled.
--

commit a99e5dce5d241e395d31c60a1569a9ca578e1287
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
s390/qdio_main: Use kzalloc() for the IRQ structure

This commit replaces the page allocator with kzalloc() for the QDIO irq
structure. It also cleans up the kmemleak tracking since the IRQ structure
is now tracked by the slab allocator.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_main.c b/drivers/s390/cio/qdio_main.c
> index d137bf8c70664..28eb8602ca97e 100644
> --- a/drivers/s390/cio/qdio_main.c
> +++ b/drivers/s390/cio/qdio_main.c
[ ... ]
> @@ -961,7 +961,7 @@ int qdio_allocate(struct ccw_device *cdev, unsigned i=
nt no_input_qs,
>  	    no_output_qs > QDIO_MAX_QUEUES_PER_IRQ)
>  		return -EINVAL;
> =20
> -	irq_ptr =3D (void *) get_zeroed_page(GFP_KERNEL);
> +	irq_ptr =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does replacing get_zeroed_page() with kzalloc() remove the guaranteed page
alignment for the Queue Information Block (QIB)?

The struct qdio_irq embeds struct qib as its first member. The IBM channel
subsystem requires the QIB physical address to be strictly 256-byte aligned.

When the kernel is configured with CONFIG_SLUB_DEBUG and redzoning is
active, or when KASAN is enabled, SLUB adds a red_left_pad before the
object in the slab. This means the pointer returned by kzalloc() is offset
from the page boundary.

If this unaligned virtual address is passed to virt_to_dma64(&irq_ptr->qib)
and written to the QDR, will the channel subsystem truncate the lower bits
and read invalid memory, or generate a hardware check?

>  	if (!irq_ptr)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D8
