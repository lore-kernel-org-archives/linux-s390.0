Received: from mail.tkos.co.il (wiki.tkos.co.il [84.110.109.230])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43D063C3C;
	Thu, 25 Jul 2024 11:56:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=84.110.109.230
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721908596; cv=none; b=WW1DEH/DwWTaeE15B2tDiI6cdI2h3ZsnFO0dVU+RA8vr4byfvhqjQlAPmE80VOXQGrqv62jv1lL/JgFG9CxXpmqCRjAKSS4qIVZkYDMXqgve811rdlnuWcjyQRd5DIzgdGcrf12KS7LSGBtitoYg2YHdVp9mT4jS9dXgWo4+ulE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721908596; c=relaxed/simple;
	bh=yE1dvBcrEBKnorpECP4pOnlN7nPfgUokWU3jR2HlwE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s/f5x6fYVVUy8HTc2pmWlwZ6xiAATQGSiiztkt71a10NY5a+B/gyorKm73fKvq805f90jB7v+EVH6aM33Y9lZKNZ0GxLgfywta9a1aScIeg2CSu3iNY4sjtQ7CKEtowN8Nr4xMIVtAzA1E98LFyDf9j5fXgd/0HfFSvRVwSR33A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il; spf=pass smtp.mailfrom=tkos.co.il; dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b=bizVwSo2; arc=none smtp.client-ip=84.110.109.230
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tkos.co.il
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tkos.co.il header.i=@tkos.co.il header.b="bizVwSo2"
Received: from localhost (unknown [10.0.8.2])
	by mail.tkos.co.il (Postfix) with ESMTP id 284E14404C3;
	Thu, 25 Jul 2024 14:47:51 +0300 (IDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tkos.co.il;
	s=default; t=1721908071;
	bh=yE1dvBcrEBKnorpECP4pOnlN7nPfgUokWU3jR2HlwE8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=bizVwSo2WQmGu0wUpHnYrd0vmUJZSj2EFi5MQvsuSsHcUPIlfFUeav8XA1ADfxEht
	 swspOZXXy6Ab7EMunaOnm8NHsgOT9449191hCTw2/CpoAtwSwSaAwbieaI7844BSro
	 ptDyP9e+pI/vXYmBCpx+M0RmTU+Lr81JVG8wPU3ZSwi4+YXygklxhz7lCo6Gusy58K
	 seXAU/M/7An4QuSEy4KgL1CDRjrevZeRuLYxoakcQey6W84qW98DoLWlQoXDC09PaI
	 4x/s1EdCLdeCgMg6IPGd80vPUq/70SWVPgWUFJSRDxadbEb9i2o8jR+4Mi0NXSi22V
	 /YANXGITTzdfw==
From: Baruch Siach <baruch@tkos.co.il>
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Christoph Hellwig <hch@lst.de>,  Marek Szyprowski
 <m.szyprowski@samsung.com>,  Rob Herring <robh@kernel.org>,  Saravana
 Kannan <saravanak@google.com>,  Will Deacon <will@kernel.org>,  Robin
 Murphy <robin.murphy@arm.com>,  iommu@lists.linux.dev,
  devicetree@vger.kernel.org,  linux-arm-kernel@lists.infradead.org,
  linux-kernel@vger.kernel.org,  linuxppc-dev@lists.ozlabs.org,
  linux-s390@vger.kernel.org,  Petr =?utf-8?B?VGVzYcWZw61r?=
 <petr@tesarici.cz>,  Ramon
 Fried <ramon@neureality.ai>,  Elad Nachman <enachman@marvell.com>
Subject: Re: [PATCH RFC v2 2/5] of: get dma area lower limit
In-Reply-To: <ZnH-VU2iz9Q2KLbr@arm.com> (Catalin Marinas's message of "Tue, 18
	Jun 2024 22:38:29 +0100")
References: <cover.1712642324.git.baruch@tkos.co.il>
	<230ea13ef8e9f576df849e1b03406184ca890ba8.1712642324.git.baruch@tkos.co.il>
	<ZnH-VU2iz9Q2KLbr@arm.com>
Date: Thu, 25 Jul 2024 14:49:01 +0300
Message-ID: <87cyn1k7yq.fsf@tarshish>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hi Catalin,

On Tue, Jun 18 2024, Catalin Marinas wrote:
> On Tue, Apr 09, 2024 at 09:17:55AM +0300, Baruch Siach wrote:
>> of_dma_get_max_cpu_address() returns the highest CPU address that
>> devices can use for DMA. The implicit assumption is that all CPU
>> addresses below that limit are suitable for DMA. However the
>> 'dma-ranges' property this code uses also encodes a lower limit for DMA
>> that is potentially non zero.
>> 
>> Rename to of_dma_get_cpu_limits(), and extend to retrieve also the lower
>> limit for the same 'dma-ranges' property describing the high limit.
>
> I don't understand the reason for the lower limit. The way the Linux
> zones work is that ZONE_DMA always starts from the start of the RAM. It
> doesn't matter whether it's 0 or not, you'd not allocate below the start
> of RAM anyway. If you have a device that cannot use the bottom of the
> RAM, it is pretty broken and not supported by Linux.

I won't argue with that assertion. My target system RAM happens to start
at that the lower end of devices DMA zone, so I'm fine with skipping
this patch.

Just curious. What is the inherent limitation that prevents Linux from
supporting DMA zone with lower limit above RAM start?

Thanks,
baruch

-- 
                                                     ~. .~   Tk Open Systems
=}------------------------------------------------ooO--U--Ooo------------{=
   - baruch@tkos.co.il - tel: +972.52.368.4656, http://www.tkos.co.il -
