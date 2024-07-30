Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C095197A83;
	Tue, 30 Jul 2024 15:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722353697; cv=none; b=VCSPLqN3GAsi0xYuDTScj7AqIW1BPpbjbxbZU4dE4o/1XdGnLt+u5m0y8OrZPDHPAvoaWcIx1oP2jq1tcxc53ZtKIZpaEoI9Rqfytub8c5nK67zzbjNGsWm3ddJeb6k/ZVC8rNaDoUxbRGW88rOcd9yJGjS5bpkh5BSjn5tmfBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722353697; c=relaxed/simple;
	bh=X1NFVd8WVfKCgTQ1WtKhkEBjmpQtmCjGwhv4mThHX8o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lzjH4sv0/Cvkj6TLvMmW4eHAxQJM2oZyYX04befdFY7skMGo+pp8ymewiWVZ9YBUvIS7nimxBxooPvTTVOEyDGvxK1EaJ9bbqnj0r7wnx6v8/2sZgNjC/tPaHOBWIv2NTjfrY+eylVrBzu6SDqd5jAojFx72iskIGSXu0yUPWLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 2202D68AA6; Tue, 30 Jul 2024 17:34:51 +0200 (CEST)
Date: Tue, 30 Jul 2024 17:34:50 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: kernel test robot <lkp@intel.com>, Baruch Siach <baruch@tkos.co.il>,
	Christoph Hellwig <hch@lst.de>,
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
Message-ID: <20240730153450.GA30021@lst.de>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il> <202407300338.oaUo6jtB-lkp@intel.com> <20240730021208.GA8272@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240730021208.GA8272@thelio-3990X>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Mon, Jul 29, 2024 at 07:12:08PM -0700, Nathan Chancellor wrote:
> >          |             ~~~~~~~~~~~~~~                   ^~~~~~~~~~~~~~~~
> >    include/linux/dma-mapping.h:77:40: note: expanded from macro 'DMA_BIT_MASK'
> >       77 | #define DMA_BIT_MASK(n) (((n) == 64) ? ~0ULL : ((1ULL<<(n))-1))
> >          |                                        ^~~~~
> >    2 warnings generated.
> 
> FWIW, this is likely a false positive due to an issue in Clang with the
> control flow graph for global variables:
> 
> https://github.com/ClangBuiltLinux/linux/issues/92
> 
> DMA_BIT_MASK() has been the biggest offender :/ If there is any way to
> refactor this code to avoid this, that would be great (as that has been
> one of our longest outstanding issues and getting it fixed in the
> compiler does not seem super easy at this point).

I have no idea what you'd want changed here, but I'll happily take
patches.

