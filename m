Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3619F3ED3D7
	for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 14:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779199477; cv=none; b=aJhJcV7GezS9cdJhchr7Typ/LBybtzUB/XeSbkbFCD8wF//W4CKPm3r72x8eNWUnUMI0JjBriRNJxNHUqtKZyPU35RLCg1KxpLj4fEdAp73Y33CFJATUP0qphrs8Q8BWe4Ny6cu0nmdM2fg1IPqSKNK+ku3jVlBfVQZNnsFTob4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779199477; c=relaxed/simple;
	bh=ldMlyu6KW0ehhtOLgHgTLzNQrPjv+3vF2LX9OYDZKO4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zu21UD0cwCHn03C7XrQDE3KDXm55Wz55XYgQVlWKv2wt6ZsB3WtID8hiC0GYXIUw2XZ8Rf4xOBVtkO7bpoXmQtWK6K0khawf0nSt0nyDktShQ2y6SVC/fGJQt6juBShatNStvtWG0eEe8Te46d2jW/+JJlB+xaCTg+g6wVKJhTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vrfApZez; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vrfApZez"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4891ca4ce02so3095e9.1
        for <linux-s390@vger.kernel.org>; Tue, 19 May 2026 07:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1779199474; x=1779804274; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/eckcCpi0xrpFbE201pgVvuYoNal9URjmldCWt34Ap8=;
        b=vrfApZezlt0/gq66lXw5hH7k4uD3XaUuj/oWhSgunnZCcowBuc1pbLVYWMnVs0kifl
         HylplSTg04tM9Cc+jRBmwy55MXFE4FfDCKr6SIQVslHscg+cIb5e1XrgWn7WI7wtO+k5
         +kvKJlpEFpCOSAePNkP1Yrbp0/HTseXoUrIWHIA00jVhj7N97js1Mt8vb9Zy0A8Z7oNr
         ZxOJI3R4wIgSRFO9KwSoMbpNd2auVS693GoDoJqdpLfiulvyzCwfBAQPcSZhq7cZ6al6
         3CooW6x+pT24sxf+kPXiKWemN6xQm6XU+KE0Wmv1P8qyABIQldnbrvMNduayPNaNTwqm
         HgCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779199474; x=1779804274;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eckcCpi0xrpFbE201pgVvuYoNal9URjmldCWt34Ap8=;
        b=Ju/7yKJcE5vPyn/6DLjkQo39rTYneO5gKYLmxPQ4OXFQQL5Rr8UN1zK3bd8wlowzBY
         LZNxxuTg9nwkT2Xkr/EriXLPpwgzpV7OZ79undhj5ZSB+X/4uIreW5e2P1ARkUgSqZXn
         +sexe5btwbdBU5ZgUmlIFVOpXQToEVGepIvLxO7G+HxLy2uAU8CdOfuWH/BLFZj87z+y
         jq9b1MtoGZosMeCmbaW8cLgUzk5JtT8ELl5mrSB47HWpCfhIQMGeDzX/SGZ2y9Pl+aHM
         sfPgsftO0QPhITtCfQLpORWpcJAd1Dp7vMHMsDUa6m6N/E8z/ITrc2tcK2QZlzty0tUf
         FMuQ==
X-Forwarded-Encrypted: i=1; AFNElJ8Y81IaHmpOk0w/egtbmMLj07blD1Tm+MQZRRfr2XcZjY3eoeRzbUYSCOIyhLYPqE8MU2O5qo5s6ISo@vger.kernel.org
X-Gm-Message-State: AOJu0Yzmql6ja74ROwP6dswKVNEWjQN0cVBV/GMXi0tpXYqg3sABivxz
	VO49uz20EjXrqeR6ERNUXAqH8Ori3xjSC48G9GdLCa6B9HGaC2b/5Zci1gcq6+x55g==
X-Gm-Gg: Acq92OEXRLhxBtNC/IIdIxcy0N1yDCdhhE5k8owqggzF7tihhdeGmObon+r8Zm68Z7n
	YouF19lf+NN5tThyLzlTvw260CmsNCnbhAuOv4culY42orvLYBDUgFzKXZsLxHzYVfuFzRGhWNq
	RE/SoHLG3UhZ+WbM78eqVQIZghd5e+sYV4ME2mke9LB4YO/gD56EIGXq35lcoAEVktgy7zW3o+Q
	TZgKgGUR6fkmLa2DbMSiTETNhhFugjwi1gQDnBmaRBt0hgSb9+tbcHvWubiuu6uVIoLKLd2KRNZ
	ezppf/uNprrWYn761Be+93mOvHbGp2VHNPzXv8e0IJFBYmJgf2SpCwnHcqhPJBVAJsPDzPn+9uz
	641KK6HqUKjqtOVSQUMwQpJxlwC++sXVvP23G9SwbC63JHqnHpF6MNBCev148gDDuc3LhJTY3T0
	dH6eqtirWkDkL3nNTN6+DXxzQt5vxMKceHe+qqQKoBhYhDnESK9E6gRi4B1wgJPxNUDwnQbwRNb
	mg=
X-Received: by 2002:a05:600c:621a:b0:489:1adc:f017 with SMTP id 5b1f17b1804b1-4901573b1a3mr2225915e9.5.1779199473882;
        Tue, 19 May 2026 07:04:33 -0700 (PDT)
Received: from google.com (136.41.155.104.bc.googleusercontent.com. [104.155.41.136])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45da0a19b1dsm45189665f8f.17.2026.05.19.07.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 07:04:33 -0700 (PDT)
Date: Tue, 19 May 2026 14:04:29 +0000
From: Mostafa Saleh <smostafa@google.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>
Cc: Jason Gunthorpe <jgg@ziepe.ca>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Petr Tesarik <ptesarik@suse.com>,
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
Subject: Re: [PATCH v4 04/13] dma: swiotlb: track pool encryption state and
 honor DMA_ATTR_CC_SHARED
Message-ID: <agxt7SFGT7OLMIah@google.com>
References: <agSKQrSIhizCXKwx@google.com>
 <yq5ah5oaa63h.fsf@kernel.org>
 <agW5rhE9n2gDQ0w5@google.com>
 <yq5apl2y5f96.fsf@kernel.org>
 <agXaby-7L7yS3Vva@google.com>
 <yq5ah5oa59wy.fsf@kernel.org>
 <agxDxdxynp4KEovA@google.com>
 <20260519132911.GA7702@ziepe.ca>
 <agxolksC_1nfO34X@google.com>
 <yq5ah5o3sdn3.fsf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <yq5ah5o3sdn3.fsf@kernel.org>

On Tue, May 19, 2026 at 07:30:16PM +0530, Aneesh Kumar K.V wrote:
> Mostafa Saleh <smostafa@google.com> writes:
> 
> >> > 
> >> > I am still running more tests, but looking more into it. Setting
> >> > force_dma_unencrypted() to true for pKVM guests is wrong, as the
> >> > guest shouldn’t try to decrypt arbitrary memory as it can include
> >> > sensitive information (for example in case of virtio sub-page
> >> > allocation) and should strictly rely on the restricted-dma-pool
> >> > for that.
> >> 
> >> ??
> >> 
> >> Where does force_dma_unencrypted() cause arbitary memory passed into
> >> the DMA API to be decrypted? That should never happen???
> >
> > Sorry, maybe arbitrary is not the right expression again :)
> > I mean that, with emulated devices that use the DMA-API under pKVM,
> > they will map memory coming from other layers (VFS, net) through
> > vitrio-block, virtio-net... These can be smaller than a page, and
> >
> 
> Don't we PAGE_ALIGN these requests?
> 
> dma_direct_alloc
> 	size = PAGE_ALIGN(size);
> 
> iommu_dma_alloc_pages
> 	size_t alloc_size = PAGE_ALIGN(size);
> 
> 

For allocation, yes, and that's fine because we bring memory from
the pool.
But not for mapping, as dma_direct_map_phys(), where the memory is
allocated from the driver or other parts in the kernel and the page
may be shared with other kernel components.

Thanks,
Mostafa

> 
> > using force_dma_unencrypted() will share the whole page.
> > And as discussed, that leaks sensitive information to the untrusted
> > host.
> > I am currently investigating passing iova/phys/size
> > to force_dma_unencrypted() and then we can share pages inplace only
> > if possible without leaking extra information.
> > I am trying to get some performance results first. But the tricky part
> > is to get the semantics right, I believe in that case those devices
> > shouldn’t use restricted-dma-pools as those should always force
> > bouncing. Instead bouncing happens through the default SWIOTLB pool,
> > if not possible to decrypt in place.
> >
> 
> -aneesh
