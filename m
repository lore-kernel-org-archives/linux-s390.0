Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02216DC03;
	Thu,  1 Aug 2024 08:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722502589; cv=none; b=LNe9A+V2yFtX4gYev/eiWaovci9sSmu0cjj8dNZmkyJLjYYPOUXaDmboeVGSOF5LOINqs+XCv6tOtooMeLHzAasZFtfTjYRAQXDZf5PcWBO+hHxCKTjjwusWtm3Kp9LLsMWVmYD9IUfW2PWYZqX+utiK9Gp7iRR8PXUnW4vR82c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722502589; c=relaxed/simple;
	bh=gasShVklXtnURSjjlRHxVFBQqgcLsrB/+LM4kI3fLk4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lacSiHFWn6RxYeH2A1aGzbEI1or5Cqitjnd9z9FiYpgI94rcaTXP+7HUToOOTApupQfbDt+pXrny9b0djCQzubCtjhhqH5UC5HMnRVGMQhxbATpxeG2JJxZEPrh+9FAxezqFOwUTM6TVKEbFos3cOYQjO2nkyH4d0/yyUK9nZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E209C32786;
	Thu,  1 Aug 2024 08:56:26 +0000 (UTC)
Date: Thu, 1 Aug 2024 09:56:23 +0100
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
Subject: Re: [PATCH v4 1/2] dma: improve DMA zone selection
Message-ID: <ZqtNtxKxBurIQEq0@arm.com>
References: <cover.1722499975.git.baruch@tkos.co.il>
 <f8f4da7ea3ead153ca21e628ca90e24fd0e7206e.1722499975.git.baruch@tkos.co.il>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f8f4da7ea3ead153ca21e628ca90e24fd0e7206e.1722499975.git.baruch@tkos.co.il>

On Thu, Aug 01, 2024 at 11:25:06AM +0300, Baruch Siach wrote:
> When device DMA limit does not fit in DMA32 zone it should use DMA zone,
> even when DMA zone is stricter than needed.
> 
> Same goes for devices that can't allocate from the entire normal zone.
> Limit to DMA32 in that case.
> 
> Reported-by: Catalin Marinas <catalin.marinas@arm.com>
> Signed-off-by: Baruch Siach <baruch@tkos.co.il>

This looks fine to me now.

Reviewed-by: Catalin Marinas <catalin.marinas@arm.com>
