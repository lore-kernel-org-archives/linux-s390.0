Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB48171099;
	Mon, 12 Aug 2024 11:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723461735; cv=none; b=MtxggTm+nHJ1wfAzD4SCB+9/qBZ6uModMOh5Nyl11XOLHO7TLSn6lsxG2ZhZjOllf3LdD5UNORpPNUK6EbPE7n2j6tyqA22uuIGwpGPLNWo7xI2vsI0bcK4va/wn8X2WotAxbaqJ5TxBOKlxEzsWuiMfOH+shzKJ3g5XESZTSdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723461735; c=relaxed/simple;
	bh=5IdhKLw+QyJbepYeB6n0yO20gNCF0f7eXEU/f9clFUg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=thLwla5Id1CZdwU2m1Np4+P6XI3PynbWkf8kFNse5leFKdOXQ3drvFRpHN11HkqRVmJ1VEto9HrnK2LxzVGTwvDSj8eLN7z1zsmIM7OwXSADtKhOUEfYaXqYCH+SsQ2/lwP0k5wtZ2rh5lexUc9NgskZnvRSa8i0aiTkvCyYuG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0886CC32782;
	Mon, 12 Aug 2024 11:22:12 +0000 (UTC)
Date: Mon, 12 Aug 2024 12:22:10 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v6 RESED 1/2] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <ZrnwYrZiHJ11xrlr@arm.com>
References: <cover.1723359916.git.baruch@tkos.co.il>
 <17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17c067618b93e5d71f19c37826d54db4299621a3.1723359916.git.baruch@tkos.co.il>

On Sun, Aug 11, 2024 at 10:09:35AM +0300, Baruch Siach wrote:
> From: Catalin Marinas <catalin.marinas@arm.com>
> 
> Hardware DMA limit might not be power of 2. When RAM range starts above
> 0, say 4GB, DMA limit of 30 bits should end at 5GB. A single high bit
> can not encode this limit.
> 
> Use plain address for DMA zone limit.
> 
> Since DMA zone can now potentially span beyond 4GB physical limit of
> DMA32, make sure to use DMA zone for GFP_DMA32 allocations in that case.
> 
> Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> Co-developed-by: Baruch Siach <baruch@tkos.co.il>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

You might want to say that no functional change is expected with this
patch. The patch looks fine.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
