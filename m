Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE7273EDE4D
	for <linux-s390@vger.kernel.org>; Thu, 10 Sep 2026 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789038661; cv=none; b=WKXXWNULUYhiwVqgWNQ1QCzpT3Uc9ses1I/e1E7Szs/SFKD5VyUQ5iOj/k/Q48Pe4MVjtUSuS05VZm/yTvPrpQjhSzwh+tEVss4PuX/9pv42s+YvO8lit1nbM8qQ4MGG2FxUHEDmQ2R/YM615ZTjSkRSR6Q87XPXEOFhyOoSK6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789038661; c=relaxed/simple;
	bh=R7aWSheERLsLHisdk4PAxkgg+AviosuTIYUe7Lur0KI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=V+3bco1ffhtykO/qhcbtc1SsaSwYiYEjTokORvg8zsfKXhocMPq1ywrO9WAajqEY+TiDvWBGWH5dSHDoEqhJLDkDVF/5yYgmETPNI0v6Vu+YRFbW6fj68Snr5RIZD7Ne4CeNJSEamySthvFDoGiNHfz/Q0P/h8FwxJaaw6psZUg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nZ3uEIui; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nZ3uEIui"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A7F71F000FF;
	Thu, 10 Sep 2026 11:10:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789038659;
	bh=5WCLMUICbLrV2smuxjJBnwJrMbvzTsFe/lkIVSvJJdU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nZ3uEIuipGJWICa2FSagl4tStbzzG6YWlLn+wmjsmiZ5khyspZ0DyRoTkwuEBYbxx
	 bjg5khxaJC8iQejExSxRyP8TvSV9jlV0MQbCbEbGWnhl2Yrmulh+LZJahGlJ48bawj
	 3H9jxAmkhQXAEkwqPEwZl/ObSEmLdSg6/C6vd/Tm7mND0cuqHieUwNVfpXUcK59xKp
	 kbWZVBXMA8iR7fQKOwbPWIL9XY2WeUH2UJzIWdGPyCsbVy7hvPWySf3c/jKoDgUKSV
	 MqU4BQaJBwOVeyworXWlOl1P3tsfhOaBaGVCTas6/ynsrP+OqDYU+1i3A+oxa/vddw
	 LEDOiouULq2zA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/13] s390/chsc_sch: Use kzalloc() for CHSC requests
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260910-s390-cio-ready-v2-3-e931086fdde1@kernel.org>
References: <20260910-s390-cio-ready-v2-0-e931086fdde1@kernel.org>
 <20260910-s390-cio-ready-v2-3-e931086fdde1@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 10 Sep 2026 11:10:58 +0000
Message-Id: <20260910111059.2A7F71F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware Alignment Violation: Replacing get_zeroed_page() with kza=
lloc(PAGE_SIZE) drops the strict 4K page-alignment guarantee required by th=
e CHSC hardware instruction.
--

commit 605eecc8759317b0b4a005d290e0db9d7f1fd0a3
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/chsc_sch: Use kzalloc() for CHSC requests

This commit replaces get_zeroed_page() and free_page() with kzalloc() and
kfree() for CHSC request and response areas. The goal is to simplify the
code and use a more standard API since the memory is assumed not to require
page allocator specifics.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/chsc_sch.c b/drivers/s390/cio/chsc_sch.c
> --- a/drivers/s390/cio/chsc_sch.c
> +++ b/drivers/s390/cio/chsc_sch.c
> @@ -292,7 +292,7 @@ static int chsc_ioctl_start(void __user *user_area)
>  	if (!css_general_characteristics.dynio)
>  		/* It makes no sense to try. */
>  		return -EOPNOTSUPP;
> -	chsc_area =3D (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
> +	chsc_area =3D kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);

[Severity: High]
Does this kzalloc() break the strict 4KB page alignment required by the
CHSC hardware instruction?

When slab debugging (like redzoning) is enabled, the allocated memory block
can be shifted by the redzone size, breaking page alignment.

Passing this unaligned pointer to the CHSC instruction unconditionally
triggers a hardware specification exception (program check) which breaks
channel subsystem I/O functionality.

[ ... ]

> @@ -340,7 +340,7 @@ static int chsc_ioctl_on_close_set(void __user *user_=
area)
>  		ret =3D -ENOMEM;
>  		goto out_unlock;
>  	}
> -	on_close_chsc_area =3D (void *)get_zeroed_page(GFP_DMA | GFP_KERNEL);
> +	on_close_chsc_area =3D kzalloc(PAGE_SIZE, GFP_DMA | GFP_KERNEL);

[Severity: High]
Will this also lose the hardware-required page alignment for the on-close
CHSC command area?

[ ... ]

> @@ -392,7 +392,7 @@ static int chsc_ioctl_start_sync(void __user *user_ar=
ea)
>  	struct chsc_sync_area *chsc_area;
>  	int ret, ccode;
> =20
> -	chsc_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	chsc_area =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Is there a risk of a hardware exception here as well due to the same
alignment issue in chsc_ioctl_start_sync()?

[ ... ]

> @@ -438,7 +438,7 @@ static int chsc_ioctl_info_channel_path(void __user *=
user_cd)
>  		u8 data[PAGE_SIZE - 20];
>  	} __attribute__ ((packed)) *scpcd_area;
> =20
> -	scpcd_area =3D (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> +	scpcd_area =3D kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);

[Severity: High]
Could this silent drop of the 4K page-alignment guarantee cause I/O failure
for the command block allocation in chsc_ioctl_info_channel_path()?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260910-s390-cio-r=
eady-v2-0-e931086fdde1@kernel.org?part=3D3
