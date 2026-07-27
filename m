Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E28C63ABD82;
	Mon, 27 Jul 2026 11:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785152424; cv=none; b=VzfjIWXtobmgcbCMemynVZ3lgqHNziHOAMd+YvA2yrxYenK3ENg8MURsiyRRECeo/aMP6ovOIBYOBjybjesqgKZhpYJjlvIV7NUNvbHxl0TuSupp/aKSX9t+EJFgsp6P9hoYLZ0qxKP+ZnwfwLs7m2xhTlhKaRX/GlGdpgiBjtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785152424; c=relaxed/simple;
	bh=2RXUrwY0zbrsvCAnBWB1uXr+KZaZ8spSxMsRS/yD9a4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FWZHg2Y6Z2bVLfuPUWX3+/H2SCKTxu4enj957oYZsd95QV3mgieLzqbLcd550ApyhW2sd7+ohhFWXO40eVRko/vXCFM5DdRmacJ8t94qSTNt37ygyWy1nIB5YXIZ+i46YGpAV1mtFfwjS7sPsNMJGtT2WgIlNk1U4yrI/CnZCYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T7OMLWX0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T7OMLWX0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 970C81F000E9;
	Mon, 27 Jul 2026 11:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785152422;
	bh=n2qS5mLYUTp7Uhtq7TiQK32AVf+rs7o35+jqHSIQjdw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=T7OMLWX0gYiwKXEiXgssU5fPiaQe6F++mUD+fwHLVNHIk9HOv1Yvhh9ZRchQz32Nt
	 LnQ5LDiAdizYA+qmqA1SVxRHHAR0hoEt/bd4mCi8k6Hq/JFkP6WuOj8ApoNfm3Ly9K
	 iuAxRMvaicTI+NcpJiKAWEuPtZCNJ1uOO9vIJPigpr6q+2V+HODr643mVFec0Q3OrI
	 XE3oGi3J/mM0RfCrQrwZDKOfBEgBLA8zQrBUI4xB2kD+tO8gQRyhCXqmt6Oi4fDDXH
	 nqQ7sees8iukt4+eTNpLhy3yicdte/VE2pqIL3ZlBXQZzdpHfIAHUuH8PK7DK1aaWx
	 A5wogUb8a0VKg==
Date: Mon, 27 Jul 2026 14:40:15 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@ziepe.ca>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Sven Schnelle <svens@linux.ibm.com>, x86@kernel.org,
	stable@vger.kernel.org, Michael Kelley <mhklinux@outlook.com>
Subject: Re: [PATCH v8 01/23] dma-direct: return struct page from
 dma_direct_alloc_from_pool()
Message-ID: <20260727114015.GL12003@unreal>
References: <20260721115456.GI110966@unreal>
 <yq5atsps77c5.fsf@kernel.org>
 <20260721142921.GN110966@unreal>
 <yq5ao6g0750v.fsf@kernel.org>
 <20260721153321.GO110966@unreal>
 <amEhEKQW0_HJ9cLN@ziepe.ca>
 <20260723075704.GC110966@unreal>
 <amTJY_CdE-uDgoGG@ziepe.ca>
 <20260726081753.GD12003@unreal>
 <ambdXXcfgK+cxqxa@ziepe.ca>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ambdXXcfgK+cxqxa@ziepe.ca>

On Mon, Jul 27, 2026 at 01:23:57AM -0300, Jason Gunthorpe wrote:
> On Sun, Jul 26, 2026 at 11:17:53AM +0300, Leon Romanovsky wrote:
> 
> > Currently, the phys type universally describes memory and can be
> > reliably translated into any required representation. It is the most
> > fundamental type we have.
> 
> You cannot go from phys to page reliably unless you make assumptions
> about the phys, that's the whole issue here. If the callchain expects
> and intends to use a page it should really stay in a page and not take
> a side trip to phys.
> 
> I agree it would help to have some helpers that were more phys based
> for the callchains that want that since we are mixing two fairly
> different activities in these functions..

Yes, we are agreed here.

> 
> But making phys the only output out of the pool isn't going to be an
> improvement.

I don't know, phys was natural suggestion due to multiple
page_to_phys/phys_to_page conversions down the road.

> 
> BTW how does a struct page even work for decrypted memory? You can't
> actually use it that way right? If you try to access it then you'll
> get the wrong IPA and it should explode?
> 
> Maybe we should be blocking the struct page path entirely for CC
> shared?

It will simplify things. Ultimately, this series demonstrates that
CC users must be aware of the memory attribute (CC_SHARED) and struct
page is too generic.

Thanks

> 
> Jason
> 
