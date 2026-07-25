Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com [209.85.222.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62A7B2931DA
	for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 14:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784989961; cv=none; b=tCk0wn5THM/zdlydRV7sc3Y3pe3Zh4d2NSJaMnMRLJkzzH2E0k+HzY/5v1/gJUTdR3mpKxatks4TPNUn6F05o7bHHBC82/oAyk1XbbcawiOoqpgHk/yWZ5EobCaIm7MiOya2PF2+VVQUFOvsToxYhQZPVxMf5geeyDNhfxdI5cA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784989961; c=relaxed/simple;
	bh=S27wxW5RiXGSWAyfDHFRMon4Va9e0JZw9F8o+Hg7Llk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QnqXidPTTnny7KJawQwWPxmM8WiNJLKbOt3hjmJqQwedAuAQ5AVua9RoIGv5ZHD+uGjUZQ5sxFzTQLehy1d2wMmT/6iOrvbC2T84kKYh0Y1+em5Xty1dnXn840f0pG71WW94/77UTS+wHKaSFL7J4yIoqbShxpAGT4mJ35bsIS4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=od6f7N5+; arc=none smtp.client-ip=209.85.222.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="od6f7N5+"
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-97715c7df46so307197241.0
        for <linux-s390@vger.kernel.org>; Sat, 25 Jul 2026 07:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1784989958; x=1785594758; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=MDjgTbE6npl3ZujjcO5BO0pJ+G7Th/Ah/Rj5MPFfgH0=;
        b=od6f7N5+c/puL96q6ep+Pcv/AjWLRZdlfywunb5GfkKpEdmOM0WWGWaG4tfpu54Jpf
         zYYOZhS/SWBerpTP40Y7TGtfsGi2t3FzQnRPFYc7LxKWIkmMq/xvzdcaRHiQYALGigsu
         u4V+EMZvlMD0Qub9q/lNRghHipTNlxa4HAsnIwjMovH8ec3S/mhVckUo2ItkNadubPvQ
         r4Xjy5Z5eGAXSpsUyrL4taf3u8QXIVidiyG8i04qpAYyf5K5vtYywdoFE5sd7ybdyx8M
         3wjeBErlr1fYyxC5CdlxDVEnb5CAW4DCcxwD2CSB0Ty61Ovv3kfHEkYQa0ZXLSbyt1AV
         iXfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784989958; x=1785594758;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=MDjgTbE6npl3ZujjcO5BO0pJ+G7Th/Ah/Rj5MPFfgH0=;
        b=XuwC5oSUOkZDCb0KEigkdkiPu/OuuWSwtlOiJv+UqdIzZ3zSfkWeYH4RGSTBoMIYYT
         zYI5yQYIAYT0dbDm3VjTfqckQPoKrA/h7U2E+mTL4Dn8dYPabFBkD6j5H0HmfgUT0p3F
         NKkydiwLA8qt2xrD7E3s6rVtcAJeh/7SXWEXlhfTiVmbquTZLl58W8FK8LxwhABDhDvJ
         dAQ/RBRJ3d6s76ohr8jU9sZiITFBjQ55M8UGqVyHo/aa2hJcTm3d06grbo6YYhUosiDP
         WLk9CdxwA8/nwTQ9I71/iKYDF0OtTIXlQhFwujfhiatu2qJVyCmx9f8f8gStpg0gc6ne
         dt3g==
X-Forwarded-Encrypted: i=1; AHgh+RrH76ubVtLb5KFo4Tyks2+LWWly5h5qLsKQYFtEnP2nfy41rBzuaFV4s+nSPug0TylPMy8eqKMP8Xga@vger.kernel.org
X-Gm-Message-State: AOJu0Yzzo144nLrZ+yKvFH5lXAofp/7gUPEuQ2XL6xKiIBSRybloNe4B
	qm8YzskcbmQhb4Yrm3rk8Yy5c/scBO2+BMg7ZWdhgbPKlbgZQoqM//menD/l+hQwNIE=
X-Gm-Gg: AR+sD11w/rJpC4NxNQJ4nts4Eg3PB6/clFGHPeBfm/+tZZxzBqD0NrtQHkJZJSyHF0R
	deYWiIa+idlUr8Quv9BvlasAskQiY3WQ5qCIvzCQPUhTznBuMGR0aH7wnGOj17iXD3qhGIjwopv
	v4PCnl4WFBthc9+4xDYPCu7s0a+n4u2IPV2TWn76zMrJX1twr0PEaodnYwYGjNltc61zqHSj6C+
	3cAAEgou3bCFpEt8HUlrVWeKDUmMO/beWcmsMJAoGJv4+ONrGAhSjjCDs+k5G4cAUGENSwZ97XQ
	kTE2zZ3+CCOIKKtzSSpkjSCX9iZLrjB0Pckzt5xvip8kTXG3Yp7Js08VBFpSQVE+kuZhmbYouyk
	qOS/WwCB3VDjzPDyD8xvBlxRikzCMOTUy7SoqielWZccEjlwcFOeafAkIV2/dN1A=
X-Received: by 2002:a05:6102:5794:b0:74a:b5e3:e96f with SMTP id ada2fe7eead31-7503e26761cmr1503853137.7.1784989958188;
        Sat, 25 Jul 2026 07:32:38 -0700 (PDT)
Received: from ziepe.ca ([12.18.163.234])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-750362e67cfsm1546647137.8.2026.07.25.07.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jul 2026 07:32:37 -0700 (PDT)
Received: from jgg by NV-9X0Z6D3.localdomain with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wndQX-000000000hB-3EP5;
	Sat, 25 Jul 2026 11:32:33 -0300
Date: Sat, 25 Jul 2026 11:32:33 -0300
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
Message-ID: <amTJAXNy9fGFrve6@ziepe.ca>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <20260721124056.GK110966@unreal>
 <amEglRH3u6UFFnIQ@ziepe.ca>
 <20260723075108.GB110966@unreal>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260723075108.GB110966@unreal>

On Thu, Jul 23, 2026 at 10:51:08AM +0300, Leon Romanovsky wrote:
> On Wed, Jul 22, 2026 at 04:57:09PM -0300, Jason Gunthorpe wrote:
> > On Tue, Jul 21, 2026 at 03:40:56PM +0300, Leon Romanovsky wrote:
> > 
> > > Why don't we continue the effort to remove "struct page" entirely
> > > from the DMA API internals?
> > > 
> > > IMHO, everything not exposed to DMA API users should use
> > > phys_addr_t, including the DMA address pool.
> > 
> > The alloc interfaces return a struct page, that is why this stuff is
> > organized like this. Look at dma_alloc_pages()
> 
> And I didn't say that we should change dma_alloc_pages(). It is external
> API, which needs to be struct *page. I'm talking about internals.
> 
> Even dma_alloc_pages() flow shows how convoluted and non-uniform
> the code underneath which performs translations all the time.

Yeah, but I don't really want to go from phys/virt to page, I'd rather
see the other direction that is easier to reason about

Maybe some small wrapper that returned phys or whatever would clean
this up

Jason
