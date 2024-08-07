Received: from bee.tesarici.cz (bee.tesarici.cz [37.205.15.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E268E7E58D;
	Wed,  7 Aug 2024 14:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.15.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723039985; cv=none; b=tzfObsosqbnghzGdGGohDcVYT0jwsKjPMODzAu7ogYoGJpNV9VYz8/2HamNYkEgRsLjuarMLbPWmJbZmBADfkVN2ssEOcDoT2AtByYuJmgfeUSk4b/n2F4hvzLI9utUhwTdNIl7VU9FyWzZg9Z9EywvjbF+pE/3gbuUHvFcY2nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723039985; c=relaxed/simple;
	bh=yHTo7ae4Y2KUSWICl1rsVbC17Jj0VNMnmBcR54CKcSg=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Iflviq5KDXzf+URo5MqnBwioWWsKDNH/hj+B9wuIp5fHRXBTjsZrMvthqAbFrTk8Ae6hz4InM7TLS4riNlUesA6E3zQfPomdn2EhKaFUOVE6adKCCmkcUuKKQlQqZiWV2m9HeEmkFLF39OxK2fxCiZA/uAKaaGJYiIJAeGuWHQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=EhwlHvbT; arc=none smtp.client-ip=37.205.15.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="EhwlHvbT"
Received: from mordecai.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-3010-3bd6-8521-caf1.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:3010:3bd6:8521:caf1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 1BDDE1D28CB;
	Wed,  7 Aug 2024 16:12:54 +0200 (CEST)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1723039974; bh=2S1kScCclltNXckE/Lkx2qPVy9xVi/sU3tCNDVWrwmg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=EhwlHvbTz35VhAI2Qpj0xb9g7XfyNlUdLT2PhofPUJObSVEfk1Rz+kAynf4vRyIUu
	 ZSmLQQDu+kYFQY76651Xk1pzwK49hhn0qV9lrrdrvfzk44MTygPvccjXpYKlYgqZ6P
	 fKSG+xtWjx1PGAmqW+Ru9Jxrm8kTocZVHIf7Ct5F5dwAfJVorHfTti2Yn2AG1RZl+T
	 QfwOcSNtu+xhAwEW6hotsHWoZOw4ky06J8J7F0GfieIZRu2xjf2bq8Qg8MdyK+vrq0
	 HFqN+Nk021WWKDV+ToPaSKGAIAOKhQgKGN14gbNUSk1Zi/5ISVMtunOHWaVwbBfnX8
	 tCEJa3xWKB5yg==
Date: Wed, 7 Aug 2024 16:12:48 +0200
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Robin Murphy <robin.murphy@arm.com>, Baruch Siach <baruch@tkos.co.il>,
 Christoph Hellwig <hch@lst.de>, Marek Szyprowski
 <m.szyprowski@samsung.com>, Will Deacon <will@kernel.org>,
 iommu@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, Ramon Fried <ramon@neureality.ai>, Elad Nachman
 <enachman@marvell.com>
Subject: Re: [PATCH v5 1/3] dma: improve DMA zone selection
Message-ID: <20240807161248.37a618f2@mordecai.tesarici.cz>
In-Reply-To: <ZrN9mRoQj2lTo6L5@arm.com>
References: <cover.1722578375.git.baruch@tkos.co.il>
	<5200f289af1a9b80dfd329b6ed3d54e1d4a02876.1722578375.git.baruch@tkos.co.il>
	<8230985e-1581-411f-895c-b49065234520@arm.com>
	<ZrN9mRoQj2lTo6L5@arm.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.42; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 7 Aug 2024 14:58:49 +0100
Catalin Marinas <catalin.marinas@arm.com> wrote:

> Thanks Robin for having a look.
> 
> On Wed, Aug 07, 2024 at 02:13:06PM +0100, Robin Murphy wrote:
> > On 2024-08-02 7:03 am, Baruch Siach wrote:  
> > > When device DMA limit does not fit in DMA32 zone it should use DMA zone,
> > > even when DMA zone is stricter than needed.
> > > 
> > > Same goes for devices that can't allocate from the entire normal zone.
> > > Limit to DMA32 in that case.  
> > 
> > Per the bot report this only works for CONFIG_ARCH_KEEP_MEMBLOCK,  
> 
> Yeah, I just noticed.
> 
> > however
> > the whole concept looks wrong anyway. The logic here is that we're only
> > forcing a particular zone if there's *no* chance of the higher zone being
> > usable. For example, ignoring offsets for simplicity, if we have a 40-bit
> > DMA mask then we *do* want to initially try allocating from ZONE_NORMAL even
> > if max_pfn is above 40 bits, since we still might get a usable allocation
> > from between 32 and 40 bits, and if we don't, then we'll fall back to
> > retrying from the DMA zone(s) anyway.  
> 
> Ah, I did not read the code further down in __dma_direct_alloc_pages(),
> it does fall back to a GFP_DMA allocation if !dma_coherent_ok().
> Similarly with swiotlb_alloc_tlb(), it keeps retrying until the
> allocation fails.

Er, you certainly mean it keeps retrying as long as the allocation
fails.

Yes, that's true. The initial GFP zone flags are a best-effort guess,
and a stricter zone can be chosen in the end. This whole logic tries to
select the highest zone that satisfies the limit, because allocating
some pages and freeing them immediately is wasteful, especially for
high-order allocations.

> So yes, this patch can be dropped.

+1

Petr T
