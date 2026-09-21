Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9E06373C1D
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 06:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789973518; cv=none; b=KSry5N5yKyHtG/zxZCylOPD57p8je/LRU9h07MXxw8xsN6moGMiXN/AOcq+vQITvdyqGOtaiiiJ8ALH56OxlpYmiAp8PoJ2HsuxOBHGmKvp46TFa+i9Lmj30f1ts3gqiXDWtNl5BmVD6WZAilPMBVNhgy4FZndrBzdTT3PDj6y8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789973518; c=relaxed/simple;
	bh=rkbv/6sFl9hl/5eevzoMC/0ItSCZY8ETrsp7YEArgCc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ge00oB+5E6Ky6EDDFipWHYdrKse7EJPOk9S4ZkWF4s4bPP2fTyTCFlhJZHZfSv03cJYxQDuyjxxoOY2p/dCv+ZVOR+sBQdz7Nq6XmYZrXLDabUCraNc0WA98g+5aZw/ui8ZATPW8f8vT2PgffmGpbrUfpLEc/cPM6rF2App0W7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iKQSICo1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iKQSICo1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA361F00893;
	Mon, 21 Sep 2026 06:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789973515;
	bh=OUMX+3DrrUJ/4f/y1tIPx/CX6EAZ8y0GntBH69qPEvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iKQSICo1AzDa7cc/2Ipj4zQtUofW2hHbZSyjwTy9yJ+nMgAx/Bpxllci3w3bNPQy6
	 TZK+uahQ2iNvjTnijyKAxH7mQgpa1L6NUb9uaKGK4ESAcDmN3fhExFuuX4WzX+4QVd
	 nRtLUC++U5yxWxKT/v1Io5Uf21sj+KY7hPonqn7hzOOKuitbUQUkT8CKSthQZcvh8Y
	 yJCTgvf/oa59tNNbNnhL2bYMSjQ00nj+qrMZnZwy5DqV/wtPHMlr8YQZtYsFle2tPC
	 OTHog+UVtkK5yC4z0jYgqN2u94U50DCHOaiHkKFYqLpwDReWiVY6p32T6P0tiqmybK
	 LXe/iXZCtS87w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/6] dma: swiotlb: Add an overridable architecture
 pool opt-out
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?QW5lZXNoIEt1bWFyIEsuViAoQXJtKQ==?= <aneesh.kumar@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260921063628.362078-6-aneesh.kumar@kernel.org>
References: <20260921063628.362078-1-aneesh.kumar@kernel.org>
 <20260921063628.362078-6-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 06:51:53 +0000
Message-Id: <20260921065154.9DA361F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] dma: swiotlb: default opt-out incorrectly overrides iommu=3Dsoft
--

commit 8a081ec4054b9ec450c0c293130d0ceb6b8d20fa
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma: swiotlb: Add an overridable architecture pool opt-out

This commit introduces SWIOTLB_INIT_DEFAULT_OFF to allow an architecture
to opt out of SWIOTLB pool initialization without losing placement
constraints.

> diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
> index 0cff255827baf..ce257b20ea9cf 100644
> --- a/arch/x86/kernel/pci-dma.c
> +++ b/arch/x86/kernel/pci-dma.c
> @@ -44,9 +44,13 @@ static unsigned int x86_swiotlb_flags;
>  static void __init pci_swiotlb_detect(void)
>  {
>  	/* don't initialize swiotlb if iommu=3Doff (no_iommu=3D1) */
> -	if (!no_iommu && max_possible_pfn > MAX_DMA32_PFN) {
> -		x86_swiotlb_enable =3D true;
> +	if (no_iommu)
> +		x86_swiotlb_flags |=3D SWIOTLB_INIT_DEFAULT_OFF;

[Severity: High]
When this is combined with iommu=3Dsoft (which sets
SWIOTLB_INIT_ADDRESSING_LIMIT), doesn't this flag overwrite the user's
explicit fallback request?

[ ... ]

> diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
> index c19675846fc1d..46b789eb08063 100644
> --- a/kernel/dma/swiotlb.c
> +++ b/kernel/dma/swiotlb.c
> @@ -563,10 +563,16 @@ swiotlb_select_pool_policy(unsigned int flags)
>  	if (flags & SWIOTLB_INIT_REMAP)
>  		return SWIOTLB_POOL_DEFAULT;
> =20
> -	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
> +	if (swiotlb_force_bounce)
>  		return SWIOTLB_POOL_DEFAULT;
> =20
> -	if (swiotlb_force_bounce)
> +	/*
> +	 * Explicit requirements above override an architecture's default opt-o=
ut.
> +	 */
> +	if (flags & SWIOTLB_INIT_DEFAULT_OFF)
> +		return SWIOTLB_POOL_NONE;
> +
> +	if (flags & SWIOTLB_INIT_ADDRESSING_LIMIT)
>  		return SWIOTLB_POOL_DEFAULT;
> =20
>  	if (swiotlb_kmalloc_needs_bounce())

[Severity: High]
By evaluating SWIOTLB_INIT_DEFAULT_OFF before SWIOTLB_INIT_ADDRESSING_LIMIT
and swiotlb_kmalloc_needs_bounce(), does the default opt-out incorrectly
override explicit requests for a software bounce pool and unaligned kmalloc
bouncing?

For instance, if a user boots an x86 system with iommu=3Doff iommu=3Dsoft,
pci_swiotlb_detect() sets SWIOTLB_INIT_DEFAULT_OFF because of no_iommu=3D1.
The iommu=3Dsoft parameter also sets SWIOTLB_INIT_ADDRESSING_LIMIT.

Because the opt-out is checked first here in swiotlb_select_pool_policy(),
it returns SWIOTLB_POOL_NONE and prevents the pool from being allocated.
Could this lead to DMA mapping failures for devices that cannot address all
system memory, contradicting the commit message which states that iommu=3Ds=
oft
retains the addressing limit?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921063628.3620=
78-1-aneesh.kumar@kernel.org?part=3D5
