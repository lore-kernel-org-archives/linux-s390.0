Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E02281BA86A;
	Tue, 30 Jul 2024 15:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722354743; cv=none; b=AiQeya1VEGK55/pxT4LODLrvzLbg1WOTJm/7l2T0pZ3PJvCVrMZ4eMhZGLvvBAqLUoCWWt9fwr4k+9r9LWjjl69pbD0pDkNoX/4oGsr0qD9OauY+Wqsa5Jm2bOKSFRK9UznMeRFdWdpdsPE3ZWmNLzGY6nc1nkML3yczSyMYN0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722354743; c=relaxed/simple;
	bh=rUvvu/5IiJ35ef2e9tGtmgBISeqqhFMjWRdqmqHbxMo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=vD56anfn6dU1ZT/ST6sg+DTTkcR/6/O5RbWwIdZP6BygBd+u8PqdMS4aZImK5GqwpUqP0cFzPZ31Gz0jTaPW+UsqQkxJVbi2trE2yFliS6U3xYGWiZAMCgrUD9b/4I1+o4kvM82qEh6JP2rXwBBeDCE0v1ynn0nZdYP9XaCex1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B36C4AF0A;
	Tue, 30 Jul 2024 15:52:19 +0000 (UTC)
Date: Tue, 30 Jul 2024 16:52:17 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Baruch Siach <baruch@tkos.co.il>
Cc: Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>,
	Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC v2 2/5] of: get dma area lower limit
Message-ID: <ZqkMMW_mz4C66I2e@arm.com>
References: <cover.1712642324.git.baruch@tkos.co.il>
 <230ea13ef8e9f576df849e1b03406184ca890ba8.1712642324.git.baruch@tkos.co.il>
 <ZnH-VU2iz9Q2KLbr@arm.com>
 <87cyn1k7yq.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyn1k7yq.fsf@tarshish>

On Thu, Jul 25, 2024 at 02:49:01PM +0300, Baruch Siach wrote:
> Hi Catalin,
> 
> On Tue, Jun 18 2024, Catalin Marinas wrote:
> > On Tue, Apr 09, 2024 at 09:17:55AM +0300, Baruch Siach wrote:
> >> of_dma_get_max_cpu_address() returns the highest CPU address that
> >> devices can use for DMA. The implicit assumption is that all CPU
> >> addresses below that limit are suitable for DMA. However the
> >> 'dma-ranges' property this code uses also encodes a lower limit for DMA
> >> that is potentially non zero.
> >> 
> >> Rename to of_dma_get_cpu_limits(), and extend to retrieve also the lower
> >> limit for the same 'dma-ranges' property describing the high limit.
> >
> > I don't understand the reason for the lower limit. The way the Linux
> > zones work is that ZONE_DMA always starts from the start of the RAM. It
> > doesn't matter whether it's 0 or not, you'd not allocate below the start
> > of RAM anyway. If you have a device that cannot use the bottom of the
> > RAM, it is pretty broken and not supported by Linux.
> 
> I won't argue with that assertion. My target system RAM happens to start
> at that the lower end of devices DMA zone, so I'm fine with skipping
> this patch.
> 
> Just curious. What is the inherent limitation that prevents Linux from
> supporting DMA zone with lower limit above RAM start?

It's the way the zone allocation fallback mechanism works. Let's say a
ZONE_DMA32 allocation fails, it falls back to ZONE_DMA and it's supposed
to be compatible with the GFP_DMA32 request. If you have some other zone
below ZONE_DMA, it should also be compatible with GFP_DMA allocations.

-- 
Catalin
