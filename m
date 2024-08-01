Received: from verein.lst.de (verein.lst.de [213.95.11.211])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 537D861FF2;
	Thu,  1 Aug 2024 13:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.95.11.211
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722519900; cv=none; b=E+ZWDdKh+9Max6VGzIaOj42DpLjfUwkI/0iK+rcnZLGOf2Ao1qdPTCY5PflzOspB5T1A5A11weSabaiFLRZuIyW9aLWwzN8pFyb4cn5LE9bhqpkdpk7RckkR/THRH1la5Hj1wQh/gL1zC2eFp4sVvxFCVhJDllozwj29FBgUT0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722519900; c=relaxed/simple;
	bh=4dL6Itz39mYJ9Wr7cu8pndgS/85yRfhwv6/n0Iuyau8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MeBWyUm/0RYtetoJYarKe+CV+2qa6/m9E+RQrBfl306cqG81QzXCD0KtXH//r7v6glhqPcjfIZIOiJjNTI/fmesznRTIf0k9IPanHz3o2UY9aAYVDck0rffB3UIUDKwL5AEtMt1ADOnBUPaButB2pDNEWnZRkcAGcwTgOrBBNaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de; spf=pass smtp.mailfrom=lst.de; arc=none smtp.client-ip=213.95.11.211
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lst.de
Received: by verein.lst.de (Postfix, from userid 2407)
	id 4F21868D0A; Thu,  1 Aug 2024 15:44:54 +0200 (CEST)
Date: Thu, 1 Aug 2024 15:44:54 +0200
From: Christoph Hellwig <hch@lst.de>
To: Nathan Chancellor <nathan@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>, kernel test robot <lkp@intel.com>,
	Baruch Siach <baruch@tkos.co.il>,
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
Message-ID: <20240801134454.GB2245@lst.de>
References: <053fa4806a2c63efcde80caca473a8b670a2701c.1722249878.git.baruch@tkos.co.il> <202407300338.oaUo6jtB-lkp@intel.com> <20240730021208.GA8272@thelio-3990X> <20240730153450.GA30021@lst.de> <20240801012424.GA1640480@thelio-3990X>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240801012424.GA1640480@thelio-3990X>
User-Agent: Mutt/1.5.17 (2007-11-01)

On Wed, Jul 31, 2024 at 06:24:24PM -0700, Nathan Chancellor wrote:
> Unfortunately, I am not sure either... I do not see anything obviously,
> so perhaps it could just be avoided with the __diag() infrastructure?
> 
> diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
> index 3dbc0b89d6fb..b58e7eb9c8f1 100644
> --- a/kernel/dma/direct.c
> +++ b/kernel/dma/direct.c
> @@ -20,7 +20,12 @@
>   * it for entirely different regions. In that case the arch code needs to
>   * override the variable below for dma-direct to work properly.
>   */
> +__diag_push();
> +__diag_ignore(clang, 13, "-Wconstant-conversion",
> +	      "Clang incorrectly thinks the n == 64 case in DMA_BIT_MASK() can happen here,"
> +	      "which would truncate with a 32-bit phys_addr_t");
>  phys_addr_t zone_dma_limit __ro_after_init = DMA_BIT_MASK(24);

So..  The code above is clearly wrong, as DMA_BIT_MASK always returns a
u64, and phys_addr_t can be smaller than that.  So at least in this case
the warning seems perfectly valid and the code has issues because it is
mixing different concepts.

Where do you see warnings like this upstream?

