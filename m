Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D25C3A5436
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561389; cv=none; b=rBy+74ewcRessWxftCVAcN/VJXbx1mFBm3zF5rzjsFv/65F3qr+dc6TWwwbs/uYghybM2OAlyWtB2qVrcmufGO/EbCho8efIBic+w0qWy/ChIgxpMnhr7mxUQ8I9/pFM3mqRrqj099jCvrf1UFZqpoWyzXI6M9KOxq51BGeDVlA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561389; c=relaxed/simple;
	bh=ZK+O2odh+CfXc7mFN1xCAE0X6Hz8bF6hZduTPnbzNtE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DDpxKFzhmviuIwm7USRi8+8sMmYTJv2kJ4GbYOI6adT9I+t9/6IHEGGmAC8lcuPOvfn6pc1CYnrMA5CUF7jEEmk+rWq9DHwN/0Evt7O7oCGBpw69isrCXFxkMLp7R5Zj9x24V9jzg61ZAa0iBesVBzDGu3UAvc9LCWfVWehVNxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ze0+fMpr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ze0+fMpr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63111F000FF;
	Wed, 16 Sep 2026 12:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561388;
	bh=RSkkXeEbz5OpGHjtNSrO/ZyTnAAJmfQ610ejzlZUOS4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ze0+fMprfDuag3tfj8UgfNfeU+A9V9fWJxtGynNTFgYm0xMeyj4VZDhF4r8RO6lwX
	 DGoAkvUbLzj3CMeUENDwjMDmzKNKasqw773jt6JThx0Kr8szglMpb3/7rb61NXQ+id
	 mxahVwKKyzCjOZXfXdo34ol6Rl1GoIy8HmvDxNNElzqGvAvndRKRhiItiW8+Q4kTIH
	 lzmxJR3HqHmuDvzPCG/x0AFtnsdfQ9dP/4tPcRvFslHmacKfKJ+e0Jy0T/kcTFEknI
	 hEa6gqROq19b4KXKDbYhG/J2IHydDH9yYwhBny3ayAh0+jKF6VCp+8mkunxKRHiURu
	 WEdXFwboFuAzw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 13/13] s390/scm: Use kmalloc() for SCM information
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-13-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-13-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:23:07 +0000
Message-Id: <20260916122307.A63111F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: kmalloc breaks 4K alignment requirement for CHSC blocks
--

commit 9d079c715a16b3a1d4f369edca3a1cd7d672af83
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/scm: Use kmalloc() for SCM information

This commit replaces __get_free_page() with kmalloc() and free_page() with
kfree() for allocating the SCM information response buffer. It also adopts
__free(kfree) for scoped cleanup of the buffer.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/scm.c b/drivers/s390/cio/scm.c
> index 171212a6d2d9c..b79fe023ab8d1 100644
> --- a/drivers/s390/cio/scm.c
> +++ b/drivers/s390/cio/scm.c
[ ... ]
> @@ -224,12 +225,12 @@ static int scm_add(struct chsc_scm_info *scm_info, =
size_t num)
> =20
>  int scm_update_information(void)
>  {
> -	struct chsc_scm_info *scm_info;
> +	struct chsc_scm_info *scm_info __free(kfree) =3D NULL;
>  	u64 token =3D 0;
>  	size_t num;
>  	int ret;
> =20
> -	scm_info =3D (void *)__get_free_page(GFP_KERNEL | GFP_DMA);
> +	scm_info =3D kmalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Does using kmalloc() here break the 4K page-alignment requirement for CHSC
command blocks?

The S390 architecture specifies that CHSC command blocks must reside on a
strictly 4K-byte boundary.

The hardware instruction executed in chsc() enforces this alignment
requirement and raises a specification exception if violated.

While __get_free_page() intrinsically returns a page-aligned address,
kmalloc(PAGE_SIZE) does not guarantee page alignment.

For example, when CONFIG_SLUB_DEBUG is enabled, the returned pointer is
shifted away from the page boundary by redzones and metadata.

Could passing this misaligned pointer to the hardware instruction break the
architecture contract and cause command failures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D13
