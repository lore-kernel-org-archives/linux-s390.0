Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045143F787F
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 09:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786096310; cv=none; b=AA2jLrcEv58GbemrEjxmjl/sLuqQYXIaKmgbrTbh14dXtJJkMagVN7Qav5UKcvQ9WEq2MFZRD4GbJS6C4XAabftbhMXBqqtkmUFvweLxKZB8SLskLOQbDJODorXxlEcKgEbWfTHYseQEc31NxjmJWI1IFXrh1SabVBwStivQBd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786096310; c=relaxed/simple;
	bh=Zoi9izk/va9t0fdNhetVSgFenPIicWLXh7EZnbEnteQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kblGQKaMdiQakv5dhwgWMtfQIBKMlZgpAhxGme6EZp+XRF4BP7yen6/AMbkP/MpVNj3zHglbJooTT5GXD5JzG5hBEuKS9+wzPKeGiadfTU9FoNy4UBaTjikXalTa5OR0TI9alM/7r6vqbbdV8YUp4EsBUi24wvkCTJxdqJefl5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Nncgvv8C; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Nncgvv8C"
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-698b78c05b0so6306a12.1
        for <linux-s390@vger.kernel.org>; Fri, 07 Aug 2026 02:51:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786096305; x=1786701105; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QYbufw58gsel6FCE1/jEcLG9PAf4/Ixif2gUvboMhY0=;
        b=Nncgvv8C+6R2GY8B1iYcYKfJsJEuUwhVwAcjWE104aY76oPjpX+HsbaBYV/nMG/Yhn
         4iV8vJpWbPV5/+QbCqPas8/5VTMGhRXGOKvWUY0MyPBMlcpTv6j4M8NLWsvvb37I/FO7
         YsCzVO+EP6mJO5yyqFBfx0XSGOMNAUoVGhOgLHtmefP6oKwXndJCa3eKzNq2GFU+QffQ
         AGRasHuV1mrBXEoS87qY8+L6gY+AcC8Px0rOYe+HZj+IapKpHDEphqXfgyKlurMJm3Y6
         fjhm8YR99ciFYMw4VkHuUqCxjknB/IBy7GTcrVi2S28zf0AsAMN4wfgNYQ//jLdjlwmW
         d1ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786096305; x=1786701105;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QYbufw58gsel6FCE1/jEcLG9PAf4/Ixif2gUvboMhY0=;
        b=Ri856X8IDRK8RqjABwj9fHXJdtc1r8EC0xvZyNdkV49HwdXzunUdKSZiPNlNxvxyLk
         PcRgMOz9DG/LDREAxNqtfXgLtl7LaY7KeUFcbwz9O80cv5/D1Sxe0GHiKW1XSmUK9cAy
         EmxqTLo3qDO4kNO0FpGL4ns+v+f8MPXleCd7ovAdVa/BqlDahGtCmu/K+Gi5Dxxm+QZX
         OJ6O1YuMOQtzufxUQipCl6740xgx3jBXB4BQf0n56MHklj0XLGs1+vxe7YrWYiBPXfCb
         cHH28rHC5sCHoKNO6MLk82ZWDD3ZlpjkRWveY+rEbzh+4d53nP8x+sBjxcafPhJi1mT6
         GG5Q==
X-Forwarded-Encrypted: i=1; AHgh+RqbWRJmBXwqOJAoOqe/HfWFNLIVwiuPwR5RdObWt96BcnQZbQj/BAruOnvF95isuXp9lntjLsmIhE9p@vger.kernel.org
X-Gm-Message-State: AOJu0Yy6R9RvSoVR7J7mx017pO7MziNwjMOJx5odGbDD1+9qXk+l9Yng
	OG+HL90Ecc6qqcwFvrX01EVgQj/RSAWZ9SuHmCaNR8Xw3VBA79tNkHNQVCcJPjQWfA==
X-Gm-Gg: AR+sD12ktBmmX71kaLWiaoKsGYKU9jdKaVnrq9S7g43lj5kc8Adv+zdNQGZdxNCLAT0
	5+3tCgI9vLUSY0ZxbboBhPuQXddV2OAK6XryXphaimM83WWXKbcum+IYf+X7y+YUlQBBYU5P8NU
	6PNxR7ESB4SlVa6d5oKxmJ0fB40F3pHTVe4onM9Yg/2B5qMnnkZCm4Ub2Wym+Z9RW6ym8mtVn7C
	LSPKgoNWXPjJRQzGxedH4y1UERlhGq98c+9Y4zaLGM3DAxPRAx51OWfzYgDZXhQxk1pVcK0xQTZ
	cMwQsbz5bgseNjkXMXIwo97uF+tXnzsY9CaeD8RxFezyyOXxl7jbO4vsNvd3sXPo8590ge38xY3
	ErPe7QrIbW9ZMEUI/uUWgAz6mGGDOGLoksnvoFAdVL2mJZj5uS5BaUPGRWagVI6YnM3TaNQgaNi
	vvlvnvU7nKc3c/L8gOE0gkA9yyy+iARmfTfQZti6LqbgkDrcuN6UJ6z57rYoj/tLDCBqGCkf2WQ
	EMACjWg06QBxd6OcStmEnYhPruz3Q==
X-Received: by 2002:a05:6402:a5c6:20b0:69c:cf5e:a504 with SMTP id 4fb4d7f45d1cf-6a1da7b32camr36697a12.8.1786096304665;
        Fri, 07 Aug 2026 02:51:44 -0700 (PDT)
Received: from google.com (250.192.189.35.bc.googleusercontent.com. [35.189.192.250])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2080a6fa80sm32856466b.22.2026.08.07.02.51.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2026 02:51:43 -0700 (PDT)
Date: Fri, 7 Aug 2026 09:51:39 +0000
From: Mostafa Saleh <smostafa@google.com>
To: Marek Szyprowski <m.szyprowski@samsung.com>
Cc: "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev, Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>, Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>, Jason Gunthorpe <jgg@ziepe.ca>,
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
Message-ID: <anWqq-vjEwwaziaM@google.com>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
 <CGME20260725070930eucas1p16cbafb514de7a2e7531d0e4ae158acfb@eucas1p1.samsung.com>
 <yq5azezfeeax.fsf@kernel.org>
 <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85be992d-9567-433e-ae2e-64ae5483964d@samsung.com>

Hi Marek,

On Fri, Jul 31, 2026 at 09:33:47AM +0200, Marek Szyprowski wrote:
> On 25.07.2026 09:09, Aneesh Kumar K.V wrote:
> > "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org> writes:
> >> This series tracks confidential-computing shared DMA state through the
> >> dma-direct, dma-pool, and swiotlb paths so that encrypted and decrypted
> >> DMA buffers are handled consistently.
> >>
> >> Today, the direct DMA path mostly relies on force_dma_unencrypted() for
> >>
[...]
> > pKVM topic branch is now available 
> >
> > https://lore.kernel.org/all/178467286876.125042.12010461715645610054.b4-ty@kernel.org/
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/coco
> I've just got back from my holiday's and I see that there is everything ready to give
> this patchset some tests in linux-next. I hope nothing will break.
> 
> I've applied this patchset to dma-mapping-for-next, on top of pKVM topic branch with

I was trying to find this tree and it seems the MAINTAINERS file have
the wrong address:
DMA MAPPING HELPERS
M:      Marek Szyprowski <m.szyprowski@samsung.com>
R:      Robin Murphy <robin.murphy@arm.com>
L:      iommu@lists.linux.dev
S:      Supported
W:      http://git.infradead.org/users/hch/dma-mapping.git
T:      git git://git.infradead.org/users/hch/dma-mapping.git

I believe the corret one is:
https://git.kernel.org/pub/scm/linux/kernel/git/mszyprowski/linux.git/

Thanks,
Mostafa

> patch "[PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED"
> rebased onto latest changes in arch/arm64/mm/init.c.
> 
> The remaining items pointed in the review can be fixed incrementally.
> 
> Best regards
> -- 
> Marek Szyprowski, PhD
> Samsung R&D Institute Poland
> 
