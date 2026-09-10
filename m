Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B1A47206D
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789039322; cv=none; b=tuyWdWnoPI3nGDNE7RBXwyoT8fgqpBvJRwyfLj6FrKmy9vqiY+VjnwVTCH8l36fBIIoCyOQpKhcMEJnkKBIiwe87Dd05SL8w7RTpk9di200blqSNUiKnSuFgRyJGZvaxHovy4G7cuV3RgqXY6LpD1/UWKDzjZ7/o93XCl8IIwWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789039322; c=relaxed/simple;
	bh=1s501eh4dblQishGYAQBIK1PGjgMrmbyxFvaESBpzuQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tmKhxClNlLhBMZN4MAFdSzfKRkglZmYnMdBhZwEdeQg2tseU0VHaN9MWwOyVpmvoPzp7OWYf1XroK7H0kRAzv2pFZylOi/0rBABrhcLbPY9OiBUFMLgLU/PqXWm2GeHPaZQHl1Fq8NMy4Vt5Mw9cGGlf6ch6LB+D5aMLaVHctrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D2RfmNbP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D2RfmNbP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38C01F000FF;
	Thu, 10 Sep 2026 11:22:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789039320;
	bh=fywe/WJn9Ffj9YePz3SG5yyT+7v4LNrNlb37HT8/KP0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D2RfmNbPFcixL6i2Fc1Tc29acY/Ijm5G+sJHsBOuwsbWwXWK2bgd+QipXB+vMPgjj
	 7ZyP7XEqJfikcG45lTDgJ9KLNtslpaHmqmo9kJNF20rfcGdzejPfcOoMotcV2/ELvE
	 dFNb78R8wNEW/0NZuZgenvYK0S+g/86MfIiqYlXqgNNQmFXMttf4VDNPvPNJVWdCbm
	 XJIvyytrVPXd03EH9T4zSl3kPqakA2EzCoPNBFC8ne/hjNir/LxAWIHzVaqy4uZCXH
	 RAtzfLTc5RxOsKuiWf275KfTN7LpacOGWvHnJr8hFrtHPJwHy9pcWThZB0SNhxGvbM
	 m7e9s7KCIVsCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/13] s390/scm: Use kmalloc() for SCM information
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-13-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-13-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:22:00 +0000
Message-Id: <20260910112200.A38C01F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Replacing __get_free_page() with kmalloc() breaks the strict 4K-by=
te hardware alignment requirement for the CHSC command block, leading to a =
specification exception (kernel panic).
--

commit 9a0607c813ec0f02b4147f95093917e38b21c342
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/scm: Use kmalloc() for SCM information

This commit replaces the page allocator with kmalloc for allocating the
response buffer in scm_update_information(), and introduces scope-based
cleanup using __free(kfree).

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
Does switching to kmalloc here introduce a regression by breaking the
hardware alignment requirements for the CHSC command block?

While __get_free_page() guarantees strict page alignment, kmalloc() does not
guarantee 4KB alignment. When debugging options like SLUB_DEBUG or KASAN are
enabled, they add metadata that shifts the returned object away from the pa=
ge
boundary.

This buffer is eventually passed to the hardware chsc instruction in
chsc_scm_info():

drivers/s390/cio/chsc.c:chsc_scm_info() {
    ...
    ccode =3D chsc(scm_area);
    ...
}

If the address is unaligned, could the CPU throw a specification exception
resulting in a kernel panic?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D13
