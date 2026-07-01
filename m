Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A38139B971
	for <linux-s390@vger.kernel.org>; Wed,  1 Jul 2026 06:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782886110; cv=none; b=ax13iN27DuEvYCuzmB1ZWe7tZ4CVYxlxsgf+p6h7Pq0ZHrFTJYc3pi4RTbGrOEXOf9hIr0xwDqgE2gxvjxVYOSNczWwbA9ekBUSG4SLQ3aMrOZWe2kydA5l/PeWy/GgVOMBopIEH9KdeJiJker7v6sHOCoMPHlaj6YwK3V42Xdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782886110; c=relaxed/simple;
	bh=VJTmhXg4INSWQ0/7I4yMkzw1CxEX2e6uvgietfjmvxU=;
	h=From:Subject:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ce/PDO2s3N7M77LZCS4M6z1WNvST8N4KUtggCo0nHrj3Wsglq8RhvrHECtxw/WIg21z2lOpOxf03whGLMWM6+JHrqt+9ueBCPnDLEdDCsvpXJL/6z38b2Uu1fvAdcw0CUHoGUqV2AfK2mIfgQbxyvnPCX6q9TT/JKPjTLFUhSlY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h67EzNXw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h67EzNXw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5755F1F000E9;
	Wed,  1 Jul 2026 06:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782886106;
	bh=45KvLBH7bb1F28kzAQgGf31dZ2NOl2XhStMl5XUA1PE=;
	h=From:Subject:Reply-To:Cc:In-Reply-To:References:Date;
	b=h67EzNXwUK+Ms7q0sV1lG8pcUgEuZAcVYr3sy0KMTTNX8lVJZ4N4DTowwGaQkd/xJ
	 dNo4xt7+gGOAw583dvMJ6oJlH70PjMMsHlEARWP2oB651cLcSC073o9dderfpk9yEW
	 zPFS2oMOO6xqCs7sNUE2MVCLZAfvXXhZrf3WdHsZf4rvf8miEw5ZZ7PTumCTW6tlpu
	 cl0xy4imvX0z+as/bXnXufvH1j3o5kh+sx4WKHh3G/OUDmcD0mYxKt7lbMNCvRdSOU
	 5W86WueGw1z3XKXfAcvypcDuIAYHDjSs6youck6JiP9Px57PeHOFhiDp5AItx9gV/v
	 k5AO9M0T0LyMg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 02/22] dma-pool: fix page leak in
 atomic_pool_expand() cleanup
Reply-To: sashiko-reviews@lists.linux.dev
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260701054926.825925-3-aneesh.kumar@kernel.org>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-3-aneesh.kumar@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 Jul 2026 06:08:25 +0000
Message-Id: <20260701060826.5755F1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Medium] Pages allocated from CMA are incorrectly freed using `__free_pag=
es()` instead of `dma_release_from_contiguous()`, permanently leaking CMA t=
racking capacity.
--

commit ede353d82bd6f31cd894661b3fa06b014104f3cc
Author: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>

dma-pool: fix page leak in atomic_pool_expand() cleanup
   =20
atomic_pool_expand() frees the allocated pages from the remove_mapping
error path only when CONFIG_DMA_DIRECT_REMAP is enabled. This patch ensures
the pages are always freed on failure paths by moving the __free_pages() ca=
ll
outside the CONFIG_DMA_DIRECT_REMAP block.

> diff --git a/kernel/dma/pool.c b/kernel/dma/pool.c
> index 2b2fbb7092429..b0303efbc1532 100644
> --- a/kernel/dma/pool.c
> +++ b/kernel/dma/pool.c

[ ... ]

> @@ -130,14 +133,15 @@ static int atomic_pool_expand(struct gen_pool *pool=
, size_t pool_size,
>  				   1 << order);
>  	if (WARN_ON_ONCE(ret)) {
>  		/* Decrypt succeeded but encrypt failed, purposely leak */
> -		goto out;
> +		leak_pages =3D true;
>  	}
>  remove_mapping:
>  #ifdef CONFIG_DMA_DIRECT_REMAP
>  	dma_common_free_remap(addr, pool_size);
>  free_page:
> -	__free_pages(page, order);
>  #endif
> +	if (!leak_pages)
> +		__free_pages(page, order);
                ^^^^^^^^^^^^^^^^^^^^^^^^^
[Severity: Medium]
This is a pre-existing issue, but does this cleanup path correctly handle
pages allocated from CMA?

Looking at the allocation logic earlier in atomic_pool_expand():

	do {
		pool_size =3D 1 << (PAGE_SHIFT + order);
		if (cma_in_zone(gfp))
			page =3D dma_alloc_from_contiguous(NULL, 1 << order,
							 order, false);
		if (!page)
			page =3D alloc_pages(gfp | __GFP_NOWARN, order);
	} while (!page && order-- > 0);

If the page was allocated via dma_alloc_from_contiguous(), freeing it
directly with __free_pages() bypasses the CMA bitmap cleanup. This returns
the page to the buddy allocator but permanently reduces the memory available
for contiguous allocations.

Should this instead check if the page came from CMA and call
dma_release_from_contiguous() accordingly?

>  out:
>  	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260701054926.8259=
25-1-aneesh.kumar@kernel.org?part=3D2
