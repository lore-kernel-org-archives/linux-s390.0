Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB703E16B9
	for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 19:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784750233; cv=none; b=IP9kyI/5DWEVTmAUWK5ztbe0RALrOJnYXSM1cFWc0sXMo0yVZ5MhhDYxO6rMpHcUnrdzFPsf0p0Mp4RVsaeKf+8nLce1bTq9jFx5qj4jPt9jzkqjpXUnhwomTtlHbBBzEXmcKZC/zdJ8f6RBvVcEzKw98WuAfHzRKv4q6fBIfic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784750233; c=relaxed/simple;
	bh=tJmj53zfWsNVLl4x+pL+wraxm36ZaOa5Vnqva167EKc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YYRt4Y3NNEvqi//tzdbBWMDrhffBwMnMQf2AB0wQ4dbMWx43IM6JYyJL732/LMZYXVEE0qbSMBzIkT/vJgqxNFrFGRCl4U9F4EuQofcVfyZQMYu26hBgjZ7+HhOJvFsbdUjIm16eWDlJKjbN7o6p/870vmFOBnmOd1XG+1B7lf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=oDZA4Pf+; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="oDZA4Pf+"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-2cc61541f8cso78858235ad.0
        for <linux-s390@vger.kernel.org>; Wed, 22 Jul 2026 12:57:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784750231; x=1785355031; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=N2NbIgCir1Hq8D+FOL5JeKeK13r88FeOdRS8YSok+dE=;
        b=oDZA4Pf+wgi15rPXFudIBMaZZDQVIZlLC5iyTBPzr/va5Onl2D6fdTymLvEKNVOVNe
         sGpoX+hCiQ5pvbPEGyCkivu+ujIFxVWgiLoawEdUoeLS1wb2DC7BMGUyAN8MB1Oimj5O
         hpqNzSH5XVPlU/Ugc60WGKqaXEsYZHVlWqffu9H5G/Y19X+ZK6lh5xc/KAm8oBD4qFu9
         xXwtl4ZRhFSczpnnkkiCGxfcC9sGmzVlvJVapH2+l1o0x11GMvxoDa8rxY+B/d0voqW9
         7bAvEhiWBEgdGbGR4eb0WX+X9mfOHNVZh5SbEVQW1d9u3Rlpyd+CkJD7FgSu3GbtaaXE
         FZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784750231; x=1785355031;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=N2NbIgCir1Hq8D+FOL5JeKeK13r88FeOdRS8YSok+dE=;
        b=b9YKJQ3k26eE8DuVf+91fhwYaGVEGF+CeOtL9F7B0C/xWF+SeZ4EBo2bAsAV9Le2+x
         JAidWBGpZpzd1eZ4HOBKI0IHcv1L1iZskAzr+U6iz5xWv1o/aam6dD3D2tk4pbKLh/Ov
         PmIG0Fncb8Quyf59wK75aygXcXb3i1lIAUVWyMaijhegCisTOmD5FsvOWcujLD8X/dvf
         xSl0zqmolYvh63y/Ku6PnJ8HYdEGclbeT6bNocIf31N4JYYa+vJwi+ApGijDe8ovBeA4
         ovORg7ScvdBlXtOAIe/c7HZfZ5nwKKh01Woc0yUZQtpbTrxGGYcjlENudx7th27e3WnP
         VNrw==
X-Forwarded-Encrypted: i=1; AHgh+RpSluyzcu0FDAZRuJ0XbUKXLX7wU3HgjplUNr21BvR2uFSEM2hQ+0nZh7fCnL/OBtSu7horZqMRtfLl@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5Yy8PxLRc/9zhMfN54xfA9lanBew4AyLheLHbbAU7UDF+7nc3
	32/Ief0ud3ANaql8hDO/1Z79f03/s4fwxQyuhvxf419vED4x+LRL205NXMzAHKKAbkM=
X-Gm-Gg: AR+sD12Seud+Euu/VWcHOCHAqxwwngLDeZa0sw/g+RhWW2n9bCrMfEinn7jT6QjLD9W
	+KNz2hUDLly/XEBnl9muSKp5VDofrzLxUVDkEiV/UFMtZZWzN9akDDELG8dx9mNyWjoSwl5t2Y9
	LtWKD2QxUSSLTxhiehRmavqcQgwgGxtbxCFvvMXrhXZoyC2RdNpem9EyQbKXKQMYrBM5EpJDzuk
	j8MbIZ3B5osXcEJcPhdsk5rJHRIJraQ6Vpqu9KiOYu1nHm54/7pdp6G8MMfrkszJTydPto54Urj
	/GnIGgYYIGnOsQOinWqaSEASteou0bRK1ULzXCP0dI5w1rqToay7q9prT4ZmDJWfQf1OZpDMfNB
	ONHl5+UxP/3l7f7i8kT9Oea7fZRGMs5EXc47Az+PMbK6rSZUfPtfd
X-Received: by 2002:a17:903:4410:b0:2cb:402:70cc with SMTP id d9443c01a7336-2cf8df30504mr51520965ad.28.1784750231136;
        Wed, 22 Jul 2026 12:57:11 -0700 (PDT)
Received: from ziepe.ca ([216.228.115.8])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3147dc6162csm11833170eec.7.2026.07.22.12.57.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2026 12:57:10 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wmd42-000000002HD-06RY;
	Wed, 22 Jul 2026 16:57:10 -0300
Date: Wed, 22 Jul 2026 16:57:09 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Leon Romanovsky <leon@kernel.org>
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>, linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org
Subject: Re: [PATCH v8 00/23] dma-mapping: Track shared DMA state through
 direct, pool and swiotlb paths
Message-ID: <amEglRH3u6UFFnIQ@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260721124056.GK110966@unreal>

On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:

> Why don't we continue the effort to remove "struct page" entirely
> from the DMA API internals?
> 
> IMHO, everything not exposed to DMA API users should use
> phys_addr_t, including the DMA address pool.

The alloc interfaces return a struct page, that is why this stuff is
organized like this. Look at dma_alloc_pages()

There is also an API that forms a scatterlist that has to be struct
page as well

Jason
