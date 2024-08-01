Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572EB1B142B;
	Thu,  1 Aug 2024 15:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722525776; cv=none; b=fMHvfeMbWUqKZWPOSp9bAwWgQnxhopG42yG5na8mrpwQQ7MlJ7M0otQX0G+qpWKZo3cdlb+O9PYcR8A0cVuD7u2sI31C+b+VfSIvzUJ++Y1/BEwxoiZeLI1mEpqclxks6zjgl0SsVxZYYY/2YzBn7r+OnGfbU5fpPwRde4RlYTU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722525776; c=relaxed/simple;
	bh=MCfSDdIjcHZQ9l663dFR3qY6umGQeR97WyGmOHY9GQc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=t2ARvRB8W5dPC2GeYLbCa8gVZnyrkEF01ukx8XFYLlAPL5juwv6j87D7aQgOIUx9WCXRAthunC626oMxkhOJbhebB+8Rrea4vsBNY0mRVT6k3RXRBTKXv7RadICBRsVrWdvVhgukBDWNeqD6siLbiblRMBJwPjCOGn0rRcugbXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Knkt0BM+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Knkt0BM+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E072FC32786;
	Thu,  1 Aug 2024 15:22:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722525775;
	bh=MCfSDdIjcHZQ9l663dFR3qY6umGQeR97WyGmOHY9GQc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Knkt0BM+MQksHfY/hnZ5m9c3nrY9foJmh8e9BoyHVve6RRLlCuddPDzrCGNCt/ftL
	 mJF1PBOEm4zuxZ3M4vi/Iql7r+0kclcoSgV9S9lPeNHT6ZcMEgXBv/31FWDFXpO9Qb
	 LgXolyyLaYGMKNhDuoXGyMRYwXifC+krPUjWBUsvb83wmz1H14Vz5okPqc/h8Ia081
	 +3ol8UNGML6OUyf9IM8ssrnducmo4Qp4OTOssdyBMF37pqAa9Wv7R9XPFa7QB9+a9l
	 4HzHa7PCR4h177R7pzQ5I1b5muNgo5WbJxJ4fv7jpaXCsxPzGrcizXKCx38obDNCND
	 nUpMq3yjdLwOw==
Date: Thu, 1 Aug 2024 08:22:53 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: kernel test robot <lkp@intel.com>, Baruch Siach <baruch@tkos.co.il>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, llvm@lists.linux.dev,
	oe-kbuild-all@lists.linux.dev, linux-s390@vger.kernel.org,
	Ramon Fried <ramon@neureality.ai>,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Robin Murphy <robin.murphy@arm.com>, linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev, Elad Nachman <enachman@marvell.com>,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v3 2/3] dma-mapping: replace zone_dma_bits by
 zone_dma_limit
Message-ID: <20240801152253.GA122261@thelio-3990X>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il>
 <202407300338.oaUo6jtB-lkp@intel.com>
 <20240730021208.GA8272@thelio-3990X>
 <20240730153450.GA30021@lst.de>
 <20240801012424.GA1640480@thelio-3990X>
 <20240801134454.GB2245@lst.de>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801134454.GB2245@lst.de>

On Thu, Aug 01, 2024 at 03:44:54PM +0200, Christoph Hellwig wrote:
> On Wed, Jul 31, 2024 at 06:24:24PM -0700, Nathan Chancellor wrote:
> > Unfortunately, I am not sure either... I do not see anything obviously,
> > so perhaps it could just be avoided with the __diag() infrastructure?
> > 
> > diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> > index 3dbc0b89d6fb..b58e7eb9c8f1 100644
> > --- a/kernel/dma/direct.c
> > +++ b/kernel/dma/direct.c
> > @@ -20,7 +20,12 @@
> >   * it for entirely different regions. In that case the arch code needs to
> >   * override the variable below for dma-direct to work properly.
> >   */
> > +__diag_push();
> > +__diag_ignore(clang, 13, "-Wconstant-conversion",
> > +	      "Clang incorrectly thinks the n == 64 case in DMA_BIT_MASK() can happen here,"
> > +	      "which would truncate with a 32-bit phys_addr_t");
> >  phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);
> 
> So..  The code above is clearly wrong, as DMA_BIT_MASK always returns a
> u64, and phys_addr_t can be smaller than that.  So at least in this case
> the warning seems perfectly valid and the code has issues because it is
> mixing different concepts.

Sure, that seems like a reasonable way to look at things even if the
warning itself is a false positive.

> Where do you see warnings like this upstream?

I don't see this upstream, this is from patch 2 of this series:

https://lore.kernel.org/053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il/

Cheers,
Nathan
