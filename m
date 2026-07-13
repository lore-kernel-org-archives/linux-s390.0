Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com [209.85.219.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 567073546EB
	for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 18:48:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783968495; cv=none; b=Z+l9+LfYHE4BxqWTeqTU0xLsasyNGIMzh4VfXMgkk9TFvSQjFwnfso4RDj/o60QdQIow4xciqDFr8xoIYhApLdPtzv+o/FUVADf7KbJ6LCFEaBddu8DU376D63IldUMqUv94us0lcZtPX9Wikqg3g3aNFpOCen3gGtGufg/Ms7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783968495; c=relaxed/simple;
	bh=18BF4tvFtN7rb81d7yZbxHf143U9lHFn+oOlQiGvmi0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lLOKKm9Vpfxn3HmSt3GGAEjDZ9RfJsc/9otTauiIZ5HLcdfm5k9Po2i9Pq420PZlLdEPjaY9YULuDxTDan9ny5DrhjpuFAQ8115cm67z4MNG4kO5XlzwFyDbq54mfhcjsTr8Cre0rAwDqxdBGnxbGBxu4nD3tR0uGXFuZAApqGs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CX767FRC; arc=none smtp.client-ip=209.85.219.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CX767FRC"
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-8ff88549786so40962776d6.3
        for <linux-s390@vger.kernel.org>; Mon, 13 Jul 2026 11:48:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1783968491; x=1784573291; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=+4oaM697jjJh0i29DhT77Bw1lzVGGZ7UjxKZh4sSss8=;
        b=CX767FRCtyqDrNTEqwJX01iLxDPq+FYWWfY4KIKDZJLtwErZGSXtdWesg/vTvC/4h3
         KlrUZg/O2W82UlS2Sh6/EljwWVactNzoMpZcFpOp5MVn6D1zQmo7mWSm02YhLU8iT8j7
         hdlkTOemS366h6/9zKLPkhEwC6CfMx05gFDb432EGbNBW+AIU76yGVsJXzZVQcqhLqJy
         W1GW3riQ3vFbsfwxNeCfK/LAyv0hnWwtNo4JE0XimbldCJD3xk0CqgmnzlvDtt6n6IHm
         Cd2kZ4l9koL/PgRvLeu6RTbwa0imttCC0t4NYCNeFx74lVdV3u/fWzDeowHdeAyNTlLg
         KVMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783968491; x=1784573291;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=+4oaM697jjJh0i29DhT77Bw1lzVGGZ7UjxKZh4sSss8=;
        b=pXiVsnGcsV6//Tpq9bj9cEymnkYzdiyM4SLgiOoOILkwBYVjPvW8N+7SDO7HvEPQmu
         KQwAUIlkOQnkvqMvbJ73RdZxM0QgBYHy9ZLMeHH+iLR2WpN+hETmUOwkuWqF8HFVZjXb
         3WguTdP+RQ9AxSg0P5EPJW+Qjx53w452oMtfw9hngwKMi+bEmGWvdHndFd+h7Tm8HlcZ
         wgFYCUQe1rUZiZH8OzTumIgSDfooNmxxEyzVkIXAg7P+aI3EcHmnwdEEJnxpyWw5vUIg
         p2jRo6C1IcyT7EkphWsPRW/amd/qQbmPb4XyQfFa0eL4UgjzZLIzxSzaXoWk45JTnKli
         rJFg==
X-Forwarded-Encrypted: i=1; AHgh+RpNMywo9UbqzczwqwAInz+atgIw7n3BqFBXyRCgq1w0hZrT6Zb58/+rqwLm8yOzirgaNcIiPrMlQXkm@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh/HETTIeJqIO4QEZLsnMLUMV5950MQWhazCB2Uq4PxMAjWF63
	kBkjUeHwNMPL1D29/qOEdIZc9BX0xgvCrCZ2hCe3CTAqTKeqX8veaiQjKFml3iWhCw4=
X-Gm-Gg: AfdE7ck68SuO+9CEgKPs7+YfjRZ1/0tWJhvqEOHx51Spod42lxyo9e89FuPLKcOihK6
	fcCtuZfY3oupdksBgx7BYL4b74qzjGRYNvKXe00uU7+XSFowE/24WJRGjpB3CUJiaf94OYvVpJd
	heu3tnH3rrg/xNQvRIvbgy0/tZCZ2vnl9fjj44EF1iCJpTbDKBnawrSdzZRiLOETI6onORCP83P
	dgbyASPq3tPMjWW4//PpBh4wHdMaBN596oRUODUPv1YthqMG7ML7kjOVD9zuwZc6ZeWc/62RQuX
	W4aw8glqnO92sUNAohSukzet4/aFFQ4pahqOx4inght9e1voe7vENIq7YxOB7lrl1MQD70YEeB0
	EmQHXRA2pTAbYBwbxmYfVvSxuIU8eUWRhxnUa9GdPdpYiqiZTdvMn1r5dsA4IbEtHz/E2Zck=
X-Received: by 2002:a05:6214:e8c:b0:904:49fa:3085 with SMTP id 6a1803df08f44-90449fa364dmr123814316d6.18.1783968491378;
        Mon, 13 Jul 2026 11:48:11 -0700 (PDT)
Received: from ziepe.ca ([159.2.72.92])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8ffd82e8ffdsm139962266d6.37.2026.07.13.11.48.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 11:48:10 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wjLhK-0000000E1oE-0kyB;
	Mon, 13 Jul 2026 15:48:10 -0300
Date: Mon, 13 Jul 2026 15:48:10 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
Cc: iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-coco@lists.linux.dev,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v7 11/22] dma-pool: track decrypted atomic pools and
 select them via attrs
Message-ID: <20260713184810.GM3133966@ziepe.ca>
References: <20260701054926.825925-1-aneesh.kumar@kernel.org>
 <20260701054926.825925-12-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260701054926.825925-12-aneesh.kumar@kernel.org>

On Wed, Jul 01, 2026 at 11:19:15AM +0530, Aneesh Kumar K.V (Arm) wrote:
> @@ -114,14 +120,17 @@ static int atomic_pool_expand(struct gen_pool *pool, size_t pool_size,
>  	 * Memory in the atomic DMA pools must be unencrypted, the pools do not
>  	 * shrink so no re-encryption occurs in dma_direct_free().
>  	 */
> -	ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> -				   1 << order);
> -	if (ret) {
> -		leak_pages = true;
> -		goto remove_mapping;
> +	if (dma_pool->cc_shared) {
> +		ret = set_memory_decrypted((unsigned long)page_to_virt(page),
> +					   1 << order);
> +		if (ret) {
> +			leak_pages = true;
> +			goto remove_mapping;
> +		}
>  	}

This makes the memory_decrypted conditional, but it doesn't change
the lines a few above:

	addr = dma_common_contiguous_remap(page, pool_size,
			pgprot_decrypted(pgprot_dmacoherent(PAGE_KERNEL)),
                            ^^^^^^^^^^^^
			__builtin_return_address(0));
	if (!addr)
		goto free_page;

It is wrong to pass pgprot_decrypted() to the arch code if
set_memory_decrypted() was not called.

Also it looks at some point the nature of the atomic pool has become
confused. Originally it was just to allocate atomic memory that had
been vmap'd outside the atomic context (to set the non-coherent
pgprot), so every caller was expecting non-cached memory.

Then it was reused to also allocate CC shared memory outside the
atomic context. That was fine for x86 that doesn't use DMA_REMAP but
on ARM64 it now means all atomic pool CC memory is uncached? That
doesn't seem to make any sense...

I suppose along the lines of this patch the solution is to add a
noncoherent property to the pool so we can select the correct
combination:

 noncoherent !SHARED = vmap pgprot_noncached
!noncoherent  SHARED= vmap pgprot_decrypted + set_memory_decrypted
 noncoherent  SHARED = (probably unrealistic in real systems)
!noncoherent !SHARED = normal __dma_direct_alloc_pages()

But I don't view this as that important, the CC hypervisor is probably
going to use the S2 page table to force cachable on all system memory
so the non-cached pgprot is a NOP, but the extra vmap is wasteful and
it is confusing.. So maybe a little fixme is all that is needed here.

Jason
