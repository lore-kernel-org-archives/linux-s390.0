Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB0EC13FD86;
	Thu,  8 Aug 2024 13:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723124819; cv=none; b=PLERSCCRpJCXxRhCGvRkh7YJKtFj5hL46wl50XPiNlxGyf3YfUZcjPmOyiyaWMmpvgKbet98+pAqOBRce2ZpC4Q3/F2bzW46HX4wlK9uzUs05q/ro6+QiHexBSs/TCw5yNj+m2EpBpbh0KJwypUv/o+W3v2QI4rN0YBvK4KzyOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723124819; c=relaxed/simple;
	bh=b/9ynZKub7RWoH6Nkxlvmy/Q52MmaRuy6ZQTiWaPwMU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q/YW1V2UqTjrL3LpOxPcSZUpVsC1Yrp3IDRpAotnpd89DOimZq2Mo3xsFWwWlJLjeYtK2MVaqanC2i+vPAJUQCkankT+JnSWdJ0/Cr4qMe1VatnaC5er7Lk8t4G8F3G0/dXebZnABgfZijaLxt5/s6dyW4A5RafGEmTfzqqhAxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDA35C32782;
	Thu,  8 Aug 2024 13:46:56 +0000 (UTC)
Date: Thu, 8 Aug 2024 14:46:54 +0100
From: Catalin Marinas <catalin.marinas@arm.com>
To: Petr =?utf-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
Cc: Baruch Siach <baruch@tkos.co.il>, Christoph Hellwig <hch@lst.de>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
	iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>,
	Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH v5 2/3] dma: replace zone_dma_bits by zone_dma_limit
Message-ID: <ZrTMTrjTwpuHDgnU@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
 <5821a1b2eb82847ccbac0945da040518d6f6f16b.1722578375.git.baruch@tkos.co.il>
 <Zqyo4qjPRHUeUfS5@arm.com>
 <20240807161938.5729b656@mordecai.tesarici.cz>
 <ZrO5okGUljTc9E7N@arm.com>
 <20240808113501.4fde4cb0@mordecai.tesarici.cz>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240808113501.4fde4cb0@mordecai.tesarici.cz>

On Thu, Aug 08, 2024 at 11:35:01AM +0200, Petr Tesařík wrote:
> On Wed, 7 Aug 2024 19:14:58 +0100
> Catalin Marinas <catalin.marinas@arm.com> wrote:
> > With ZONE_DMA32, since all the DMA code assumes that ZONE_DMA32 ends at
> > 4GB CPU address, it doesn't really work for such platforms. If there are
> > 32-bit devices with a corresponding CPU address offset, ZONE_DMA32
> > should end at 36GB on Baruch's platform. But to simplify things, we just
> > ignore this on arm64 and make ZONE_DMA32 empty.
> 
> Ah. That makes sense. It also seems to support my theory that Linux
> memory zones are an obsolete concept and should be replaced by a
> different mechanism.

I agree, they are too coarse-grained. From an API perspective, what we
need is an alloc_pages() that takes a DMA mask or phys address limit,
maybe something similar to memblock_alloc_range_nid(). OTOH, an
advantage of the zones is that by default you keep the lower memory free
by using ZONE_NORMAL as default, you have free lists per zone. Maybe
with some alternative data structures we could efficiently search free
pages based on phys ranges or bitmasks and get rid of the zones but I
haven't put any thoughts into it.

We'd still need some boundaries like *_dma_get_max_cpu_address() to at
least allocate an swiotlb buffer that's suitable for all devices.

> > In some cases where we have the device structure we could instead do a
> > dma_to_phys(DMA_BIT_MASK(32)) but not in the two cases above. I guess if
> > we really want to address this properly, we'd need to introduce a
> > zone_dma32_limit that's initialised by the arch code. For arm64, I'm
> > happy with just having an empty ZONE_DMA32 on such platforms.
> 
> The obvious caveat is that zone boundaries are system-wide, but the
> mapping between bus addresses and CPU addresses depends on the device
> structure. After all, that's why dma_to_phys takes the device as a
> parameter... In fact, a system may have multiple busses behind
> different bridges with a different offset applied by each.

Indeed, and as Robin mentioned, the ACPI/DT code already handle this.

> FYI I want to make more people aware of these issues at this year's
> Plumbers, see https://lpc.events/event/18/contributions/1776/

Looking forward to this. I'll dial in, unfortunately can't make Plumbers
in person this year.

In the meantime, I think this series is a good compromise ;).

-- 
Catalin
