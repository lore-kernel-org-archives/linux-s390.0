Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E724EE86B
	for <linux-s390@vger.kernel.org>; Wed, 16 Sep 2026 12:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789561441; cv=none; b=PIrGWIDkXvN0bXGh/Gp2MHEAb9MTjL8a+uxADm4teRszUvSYx6NKVpX8Tqs8tsR7IufnfgpmgSTIa9vFGdn/ZHb68KV0/zhZg6Hj9e1P2cNHXFYeOYueZ6E9ORcTnJoO5OVl2wOyHZAMCk07z+TMixCHbzP2S1/mQYDuxkQaJYE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789561441; c=relaxed/simple;
	bh=aCaEQYQbbuP56kn/H5b3kdBS5Y1ikq4+V7PGrZFcvgM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JvIiUr7hAjyljT35ljHo6VWGvIWHhn+LZ0JRrJc3wDCP4IULU1m9m1GjVXkyNuZLNL+2zZ5XNVG+xUHPfqaYKDTz811j6QE1gy/Iw42wHoqHbyW0fOBtagGWnPjD8nzIU0QePVuig1c1MqlUvVGcva+xhCDUM/lGd2VK8nKJdt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ECFuVREO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ECFuVREO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E00E1F000FF;
	Wed, 16 Sep 2026 12:23:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789561439;
	bh=Rd4xFHlSrJpJll1rQKdB+7kIkBQIuqleR6Uuezq7lhQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ECFuVREOhzvPEFqYN5aisdfSDZL36x6tgGlTxgpO3fs7ubunw/bZrQtNisUnadBbF
	 Vx8m5NCdX6R7LCfCb+m6yWq/jM95e03eSChdY2vCx4I+Ca9O5/PiSphAyf/ciLCxmk
	 iI2+ksHPL/T0CbMVn86qkWJcOfWnnO2UuRMGtPMijEiWtui5Uog7N2q7Z7POPDkWi9
	 Is6IAOIsu4/AxSf5B3t5gHVXYtXJZUEt3ihBTh7JcmSGvumJ43BbwhgJwexXMv2rxd
	 mzkaGPMRHA49IsPEem+vG6MI5R/nMfztxeEf0ESqVVPtS+Fthtetju9SYU39ljpA79
	 EBJjMphCTvXIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 12/13] s390/qdio_setup: Use kmalloc() for the SSQD
 request
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260916-s390-cio-ready-v3-12-39e4894637d6@kernel.org>
References: <20260916-s390-cio-ready-v3-0-39e4894637d6@kernel.org>
 <20260916-s390-cio-ready-v3-12-39e4894637d6@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 12:23:58 +0000
Message-Id: <20260916122359.4E00E1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] s390/cio: CHSC command block alignment broken by kmalloc()
--

commit 81f70c4032ffb64f5a06eb9ca6de3a70bfe61e77
Author: Mike Rapoport (Microsoft) <rppt@kernel.org>

s390/qdio_setup: Use kmalloc() for the SSQD request

This commit replaces the use of __get_free_page() with kmalloc() and
free_page() with kfree() for the SSQD request block allocation. It assumes
there is no special requirement for the memory to come directly from the
page allocator.

Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redh=
at.com

> diff --git a/drivers/s390/cio/qdio_setup.c b/drivers/s390/cio/qdio_setup.c
> index d8e9c0872d15d..e1c5c6a8b3b27 100644
> --- a/drivers/s390/cio/qdio_setup.c
> +++ b/drivers/s390/cio/qdio_setup.c
[ ... ]
> @@ -249,7 +249,7 @@ int qdio_setup_get_ssqd(struct qdio_irq *irq_ptr,
> =20
>  	DBF_EVENT("getssqd:%4x", schid->sch_no);
>  	if (!irq_ptr) {
> -		ssqd =3D (struct chsc_ssqd_area *)__get_free_page(GFP_KERNEL);
> +		ssqd =3D kmalloc(PAGE_SIZE, GFP_KERNEL);

[Severity: High]
Does this kmalloc() call break the strict 4K-byte physical page alignment
required for the CHSC command block?

While __get_free_page() guarantees page alignment, kmalloc(PAGE_SIZE) does
not. When memory debugging features like KASAN or SLAB_RED_ZONE are enabled,
metadata is inserted before the object, shifting the payload pointer away
from the page boundary.

Could passing this unaligned pointer to the hardware via chsc_ssqd() trigger
a hardware specification exception (PGM_SPECIFICATION) and kernel crash
during device initialization?=20

It is also worth noting that this same pattern seems to be repeated in=20
follow-up patches in the series, such as the changes in scm.c.

>  		if (!ssqd)
>  			return -ENOMEM;
>  	} else {
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916-s390-cio-r=
eady-v3-0-39e4894637d6@kernel.org?part=3D12
