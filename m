Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B74342CAF6
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777808; cv=none; b=StEDENDvRHVOhXR1RiAHKqccOeSlKCW/gw10Pg8Ed0nDOS2nOit2pyRrOsJZN3h2IthUsfWjvsLxLKBdxzNN9okF4o2uQIAtras0KIL9xfnNFiIUEgzWssYxjt4AbenhwSfS17+FHjLtDw/M65V0r/nAWVCsYFNJUy8B81AdPFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777808; c=relaxed/simple;
	bh=VeCJ7eX0Koa13EgHwL3wpk1rDsLseSC3cAjOH8eTUCM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YD8ykVumkdoVf7f8LWExZ9lfhkV664adRqZ385O+mC+Awu7+JU/7Y0Vy1bhf8VFhRKCO1K40uPmo6BWr04Y2zgh4f2suDX6HLrNUjOlZPhzQ92PGFWq18P4/shaLJN7XPu8eaLSiwV+wJISSvbFq+uS5C6fHIKNvMRoTsKXcmVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGz2xyhH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGz2xyhH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C749D1F00A3A;
	Mon,  7 Sep 2026 10:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777807;
	bh=8TGYKO7bTC7Ns4zSEJLvctCLnpzzKE3/Z0b5K94nFKg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oGz2xyhHIw5WssVvWKe1DmSS+HHLscVT4T0YwkWeKJd+sevCoo7FD7iOkd2gHfngb
	 WqAOjPtsr7LwcfCBCXyM8mVT1pVY6KczB92Ef862IRc21QJikFieFgM888vIMUw48h
	 0chbJwyOYIRshI0/EOlPaRXmL4DjV/qYGwnD3/5JEepoxgI3rLzapEomwPrDMfdHcM
	 E5PzdnnlaDA2V2B7nhjEbSqqdBDy+J2gkqizVbDA6IL2RfJQf/QM4o7Bav67g1hkGK
	 nm49aoKSWEZ8mrhRFLjCZlKnLULSEJtRKcUXaMdRssAQmRPY8Yn091a4uDNEfyRrAL
	 qOqAhwfYqsgOQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/13] s390/qdio_setup: Use kzalloc() for the SSQD
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-12-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-12-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:43:25 +0000
Message-Id: <20260907104325.C749D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Hardware specification exception due to unaligned CHSC command blo=
ck allocation.
--

commit e45e0f584b812bc3fd8eb8fb6e196dc061a1cf06
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_setup: Use kzalloc() for the SSQD request

This commit replaces the use of __get_free_page() and free_page() with
kzalloc() and kfree() for allocating the SSQD request block in
qdio_setup_get_ssqd().

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
> index 7ca8f61a2387b..c0215a7d29a81 100644
> --- a/drivers/s390/cio/qdio_setup.c
> +++ b/drivers/s390/cio/qdio_setup.c
> @@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
> =20
>  	DBF_EVENT("getssqd:%4x", schid->sch_no);
>  	if (!irq_ptr) {
> -		ssqd =3D (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
> +		ssqd =3D kzalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Will this kzalloc() allocation guarantee the strict page alignment required=
 by
the hardware?

Under SLUB debug configurations (like redzoning or poisoning), kzalloc() do=
es
not guarantee page-aligned addresses. The previously used __get_free_page()
ensured this alignment.

When this unaligned memory block is later passed to the hardware CHSC
instruction via chsc_ssqd(), could it trigger a hardware specification
exception (PGM 0x06) and lead to a kernel panic during QDIO device setup?

>  		if (!ssqd)
>  			return -ENOMEM;
>  	} else {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D12
