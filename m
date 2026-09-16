Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAE7E4AA3EA
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561043; cv=none; b=hhpIDy+0Z6uGu8XsNesxjyhljHxhBEsl6eCvZTt6p89E/7r3Uj4iCz0DoaAciJEzBfylIQJZuFz7j5xug7BIwXUd9JlsaHnYpNM2KASfKzChnQ0RQlHtGcwhJd9jE8uzFHfZmVQzVZB0RWo8QjCcn28y9IYyB5QtgbwLulX3mXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561043; c=relaxed/simple;
	bh=mVOk9ZE65/FXyBByIpgRYL1pFSfGiQO7JJrjnSNsozQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Zg1REHqb498uQyugG2TtyeqNOBubZcVBZYqAstX+2HMp/mjVeWEAWeaqGRd0Gkt9PFWeEwWIyA2bFlHyB6I3E5nfUgmIagkWWXLQZcO9nrJFbQFnnFYpiHa7L7n89Az3KBRsTX4UpNCj8VCn2qW2sGy+Co++K7TtXPlGkBrcLUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eS0fHe3b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eS0fHe3b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424FF1F00893;
	Wed, 16 Sep 2026 12:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561041;
	bh=NbBlSvEOGvRbk1o+hsSUJ3ZHE2wgmUxcOG7oaiOV5vw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eS0fHe3bffPnPMRLBe+ASVsOjdzFycHeeCQB7GdYEK6aaA2QfzFWQP3/ruCxfS1pg
	 E9Fzw44zDv1wfT/k02gjV+u+S/u9JO93JavxFbmbMGCTxdNggemmH65C018PSYGRFB
	 dKELsayFJ2T6xaZIbcZzYoPzXKDYZKZlejlyoIVpMj/emtg2SpVhVaU4RsfDunU2tA
	 7cZsHdwxde1IfWz07sYWTMx6hrSDIIbG0erdZaz6isY98M+B+83+NPcLRRbXVClJnY
	 gjEiZaihI3p/e7HiR1fn6T2DwHM/a0RC1avOeY3hr6HSF+RZiH61bK0ZvpV2E+ZxUG
	 L5w/fC84L4GhA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 08/13] s390/qdio_main: Use kzalloc() for the IRQ
 structure
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-8-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-8-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:17:20 +0000
Message-Id: <20260916121721.424FF1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/qdio: kzalloc() breaks strict hardware alignment for qib and =
chsc_page
--

commit 9f2f47b6eeaa2161812dfa4d13374862da2270d0
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
s390/qdio_main: Use kzalloc() for the IRQ structure

This commit modifies the memory allocation for the QDIO IRQ structure,=20
switching from the page allocator to the slab allocator. It replaces=20
get_zeroed_page() with kzalloc() and updates the free paths to use kfree().=
=20
It also removes a related kmemleak exemption.

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
Does this kzalloc() replacement break the architectural alignment guarantee=
s=20
for the QDIO irq structure?

The irq_ptr contains a struct qib which has a strict 256-byte architectural
alignment requirement. Additionally, the irq_ptr->chsc_page allocated later
in qdio_allocate() (which was also converted to kzalloc in an earlier patch)
is passed to the CHSC instruction, which strictly mandates 4096-byte (page)
alignment.

When memory debugging features like CONFIG_SLUB_DEBUG (redzoning) or KASAN
are enabled, kzalloc() can return a pointer offset by the redzone size,=20
breaking these 256-byte and 4096-byte structural alignment guarantees.

Could passing this unaligned memory to the CHSC hardware instruction=20
trigger a hardware specification exception during device initialization?

>  	if (!irq_ptr)
>  		return -ENOMEM;
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D8
