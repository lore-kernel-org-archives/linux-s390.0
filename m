Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8215C46C84D;
	Mon,  7 Sep 2026 10:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788778589; cv=none; b=lIVplb98yqea5P/hTwexoevxOsHB16jBrCiFxEg0fKha3tefyelz9cNSiGPriO7K25Iu9cuopMI6OD49k88YVHz3NtwcwjH/HBQsfrCJwZWoEGyS3nedcLvpL3T38hK7niauJzu9nD/iJ6eVXYhAbldsH2Y3yCOjw8tQak1XmmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788778589; c=relaxed/simple;
	bh=usdN3jSlya+ao+46gyu45NdqkSBJybrHEaayUPgYpqQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=InKfZLsToNylfqbrvzUqqsfywL9LROrw+T0rQZIkjmCRKV4d+V8cdAHMPJnQuUABkqKWH8bR+quqZq1dyEHNr6MQ+SD0AR68JBRBlimYg13uU31wzhbNNZ2kICa9pQe8L3Im2yfa5MwkSPjgZdL+IMBoh81RAkvknALzzuWDCwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGQCqLX1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGQCqLX1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D12BF1F00A3A;
	Mon,  7 Sep 2026 10:56:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788778588;
	bh=wFz7vOmGpVcX33druo+Q++r087HQ4nztgPfOzj0kMlw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=VGQCqLX1BlJgGYByoIGn1J8kuP7nOTWDBYUJGiCYh14XarHfou+lvHeHyFeippO4o
	 pSgUOAxceLuF6VP2eJaQaAf34tEiFGTOu2tEz4F34MYOtzGSegI80WgjQIX2GjDBFE
	 0X7I1DxTDrhc0qfycFriXNk387Px/eI7/Pg8Qs1kvAfo1cvZkQ6R70yEekTjX76Pox
	 9ax//JVtcWOMuVw3IyvuQSv+vLETd3eSR6QUjtkDrMgyA6/2ERTnZxb5pNXTGE5/AZ
	 5yLN+I5hcXhTDm5uw/VZP0AlCUYOxiYyM7omHv7E7n64YI7pNU4zhu8Xip92hPgH0t
	 Ew5CkM2ADfFQQ==
Date: Mon, 7 Sep 2026 13:56:22 +0300
From: Mike Rapoport <rppt@kernel.org>
To: sashiko-reviews@lists.linux.dev
Cc: linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>
Subject: Re: [PATCH 01/13] s390/chsc: Use kzalloc() for CUBs
Message-ID: <ap6YVscl-NxisYnj@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-1-ca7f39806234@kernel.org>
 <20260907103719.32D671F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260907103719.32D671F00A3A@smtp.kernel.org>

On Mon, Sep 07, 2026 at 10:37:18AM +0000, sashiko-bot@kernel.org wrote:
> Thank you for your contribution! Sashiko AI review found 2 potential issue(s) to consider:
> 
> New issues:
> - [Critical] Hardware Alignment Violation
> 
> Pre-existing issues:
> - [High] DMA Use-After-Free
> --
> 
> commit c0b30acb33e9033572c3388a78f4e8cd3bf3f838
> Author: Mike Rapoport (Microsoft) <rppt@kernel.org>
> 
> s390/chsc: Use kzalloc() for CUBs
> 
> cub_alloc() allocates the channel measurement unit blocks and their
> extended counterparts.
> 
> This memory can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
> 
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@redhat.com
> 
> > diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
> > index 9689f722c863c..60a4a7e6086ce 100644
> > --- a/drivers/s390/cio/chsc.c
> > +++ b/drivers/s390/cio/chsc.c
> > @@ -931,12 +931,12 @@ static int cub_alloc(struct channel_subsystem *css)
> >  	int i;
> >  
> >  	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
> > -		css->cub[i] = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
> > +		css->cub[i] = kzalloc(PAGE_SIZE, GFP_KERNEL | GFP_DMA);
> 
> [Severity: Critical]
> Does replacing get_zeroed_page() with kzalloc() break hardware alignment
> requirements?

No, kmalloc guarantees PAGE_SIZE alignment for PAGE_SIZE allocations.

I really need Chris to merge this :)
https://github.com/masoncl/review-prompts/pull/97
 
> The original get_zeroed_page() allocated directly from the page allocator,
> which strictly guarantees 4KB page alignment. kzalloc(PAGE_SIZE) allocates
> from the generic slab allocator, which does not guarantee page alignment
> when slab debugging (SLUB_DEBUG) or KASAN is enabled due to redzones and
> padding.
> 
> When these pointers are passed to the hardware:
> 
> drivers/s390/cio/chsc.c:__chsc_do_secm() {
>     ...
>     for (i = 0; i < CSS_NUM_CUB_PAGES; i++)
>         secm_area->cub[i] = (__force dma64_t)virt_to_dma32(css->cub[i]);
>     ...
> }
> 
> The s390 Store Extended Channel Measurement (SECM) hardware expects the
> measurement unit blocks to be strictly aligned to a 4KB boundary. If the
> pointer from kzalloc() is not aligned, the hardware will either reject the
> instruction or mask off the lower 12 bits, writing DMA data to the start
> of the slab page instead of the object offset. This can silently overwrite
> redzones or preceding objects in the slab.
> 
> Can we continue to use a page-aligned allocator for these DMA blocks?
> 
> >  		if (!css->cub[i])
> >  			return -ENOMEM;
> >  	}
> [ ... ]
> > @@ -949,11 +949,11 @@ static void cub_free(struct channel_subsystem *css)
> >  	int i;
> >  
> >  	for (i = 0; i < CSS_NUM_CUB_PAGES; i++) {
> > -		free_page((unsigned long)css->cub[i]);
> > +		kfree(css->cub[i]);
> >  		css->cub[i] = NULL;
> >  	}
> >  	for (i = 0; i < CSS_NUM_ECUB_PAGES; i++) {
> > -		free_page((unsigned long)css->ecub[i]);
> > +		kfree(css->ecub[i]);
> >  		css->ecub[i] = NULL;
> >  	}
> >  }
> 
> [Severity: High]
> This isn't a bug introduced by this patch, but can this error path lead to a
> DMA use-after-free?
> 
> In the rollback path of chsc_secm() which eventually calls cub_free():
> 
> drivers/s390/cio/chsc.c:chsc_secm() {
>     ...
>     if (!ret) {
>         css->cm_enabled = enable;
>         if (css->cm_enabled) {
>             ret = chsc_add_cmg_attr(css);
>             if (ret) {
>                 __chsc_do_secm(css, 0);
>                 css->cm_enabled = 0;
>             }
>     ...
> out:
>     if (!css->cm_enabled)
>         cub_free(css);
> 
> If __chsc_do_secm(css, 0) fails (for example, returning -EBUSY because the
> channel subsystem is busy), the hardware ignores the stop command and
> continues performing DMA writes to the allocated memory blocks.
> 
> However, the code ignores the return value, unconditionally clears
> css->cm_enabled, and frees the DMA memory via cub_free(). The hardware will
> then continue to update the measurement blocks in the freed memory.
> 
> Should this path handle the failure of __chsc_do_secm() before freeing the
> memory?
> 
> -- 
> Sashiko AI review · https://sashiko.dev/#/patchset/20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org?part=1

-- 
Sincerely yours,
Mike.
