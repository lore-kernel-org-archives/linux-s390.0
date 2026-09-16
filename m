Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E89C33C5DD4
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789560892; cv=none; b=Km40yOdOJmDMoNkyyY7P0h7/duxRQNlYvowcn6J7tpAXxC0t305u4ibIV0biMPZyiX6xITuKfHBs6VDsMOG9VhyoAOg2mckC5xmS0dr1CuBAKRGIFH1FllksKZoXffELZM6mz4HAmPl3eo4cTH6k9LH2Al3r2OwQk6MGvTsP7Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789560892; c=relaxed/simple;
	bh=Txd3kAgPG3lOzLq5crTKdOino51HLPAc0a4jmeL/lg4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=dxDwqZZxYUDvi5U2QAj94pUXkGnPTyCOeshzCWRA18kPguNImmmBZt2yG3mdkbi9+ZFVbDt4HjuNM6xzbLT0KQd53bqXDeD89X3crpClg5HFPCNAIUSwQKEQvJDWPAmJXV6b9ecqTJpospvZgLPFOhmeWMekeR3XWuRMXfoLbN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfkcxvEl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfkcxvEl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ECF61F000FF;
	Wed, 16 Sep 2026 12:14:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789560890;
	bh=tFX5hVReL96qkKeHEfJvSg+gTJZYlsyZP2PrT3VkwRc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfkcxvElHqpF9XcwyZsU81HHLMfnjNKYQCGja9D1LLw8Se73fHR3QCk6wj/gxd9tW
	 AsHfx4PccEadUjCIfnPdeIgFeZVH/W5A/XfiyYTSiPGV5UAknFjum0XqjrUXszQZma
	 qnlQad4nmesY6y2ZpGttAkkC0HulaSYAUlxxZwPbhaVG2cxCyNp9rF2979BOOlNtnB
	 /Q4bRjaPNiuOoWkbB9EHsa/AuUqkDcum/tvovI6THL5PY0RyTZNIVHirPP/vwc7XQz
	 0P+jtdrUQiJwXIlQ0OtqPwDDdyBJnFGlUmjbfZLkI5Ch9QW4ngFLPAhJbPo4gEwr7X
	 x9qH7h9g0bG6Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/13] s390/chsc_sch: Use kzalloc() for CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-3-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-3-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:14:49 +0000
Message-Id: <20260916121450.0ECF61F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: kzalloc() breaks 4KB hardware alignment required by chsc=
 instruction
--

commit 54194635e9207f1ada1f8c978b8a14c7a6ba3fc7
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
s390/chsc_sch: Use kzalloc() for CHSC requests

This commit replaces the use of get_zeroed_page() with kzalloc() and=20
free_page() with kfree() for allocating and freeing CHSC request and=20
response areas across several ioctl handlers.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> index b6cb8bb8bcc4b..c8d6871d1841e 100644
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -292,7 +292,7 @@ static int chsc_ioctl_start(void __user *user_area)
>  	if (!css_general_characteristics.dynio)
>  		/* It makes no sense to try. */
>  		return -EOPNOTSUPP;
> -	chsc_area =3D (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
> +	chsc_area =3D kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);

[Severity: High]
Does changing this allocation to kzalloc() break the 4KB hardware page
alignment required by the chsc instruction?

When debugging options like slub debug redzones or kasan are enabled, using
kzalloc() for a page-sized allocation does not guarantee that the returned
pointer is page-aligned. Since the chsc hardware instruction requires the=20
command block operand to reside strictly on a 4KB boundary, passing an=20
unaligned pointer can result in a specification exception=20
(Program Interrupt 0x06) and an immediate kernel panic.

[ ... ]

> @@ -392,7 +392,7 @@ static int chsc_ioctl_start_sync(void __user *user_ar=
ea)
>  	struct chsc_sync_area *chsc_area;
>  	int ret, ccode;
> =20
> -	chsc_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	chsc_area =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
This appears to be another instance where dynamically allocated memory might
not be page-aligned. Could this unaligned pointer also be passed directly to
the chsc() hardware instruction later in this function, triggering the same
specification exception?

[ ... ]

> @@ -438,7 +438,7 @@ static int chsc_ioctl_info_channel_path(void __user *=
user_cd)
>  		u8 data[PAGE_SIZE - 20];
>  	} __attribute__ ((packed)) *scpcd_area;
> =20
> -	scpcd_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	scpcd_area =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
This looks like it matches the same allocation pattern for the channel path
description command block. Will this also lead to an unaligned pointer
being passed to chsc()?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D3
