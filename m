Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 085D43AAF56
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 20:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787345098; cv=none; b=gCqssQnqM/xqZD/cnWBufZzysNscsyrN/YtOq2pexD9KJZLpCY8hUUSkdqVILB485px9vlzPr/yGDNpogPtC6OhpB4Kv9P5/XAXcQwv5zlsauuWn+bGBbWFYXzF3FTq6NfHbZMECzz2x/9Wcy66AEFsqKNgjO66IvGt5I4lHPos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787345098; c=relaxed/simple;
	bh=VLZNTb6sD+keLS3qr1GL0XKLbH4bPo17f2sE+RknAB8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TLCW5QwLYTwYH12G9lf5sgQ4qlWkRYpx7b2UCeGl0vmfdwibbn3vamgp3KBKZzmBa4sNw4nYIalBceTJwKSZhIjMddG0ItVnosnFQNW8ZIU9yhRO1Kv25sDZ0R67nXuc3nyoGszhZDGxI93xTdsqIOZ+se/qL6plZO2+yUCnPx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=X/bUI86S; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="X/bUI86S"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4956869750eso9757875e9.2
        for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 13:44:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787345094; x=1787949894; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=QzsO6bXfVkXRG/aUxfAmIkKsE+Fa964GVFQS62WZABw=;
        b=X/bUI86SGym0+rZ5lmIk8DrXgwhbl3fpeHY9RAMxr7k/gJAqeXBePXc+Jm0Do7Nl0a
         +NVcJEsXhr5mf9l2lnEJj7Gj45RSXiQOkLhOkZiadpSoWYcsQC4ZQLYpbAmBDic80S5V
         p7FDWGGPGyFJLFSyKEe/CZSx92KBjNNRVvg8mV0Yjz0QBFKqkkhBe2Ko635HSKqe0TWB
         bVv7x9ZnADLUg60HiWy9cHQBp3THgxQsYDCQL9u0mZn7Hmo0e193EvRomo+Sypsr/7xN
         wn07yUEFJJDYqFnZZf1NV4o9i/HhNBcKUkGOSvAmH61E+JnuAe2i8K4MkoDAeqnhwR30
         Uaxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787345094; x=1787949894;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QzsO6bXfVkXRG/aUxfAmIkKsE+Fa964GVFQS62WZABw=;
        b=KjuSo7k+i/UVfg2ig4lKM+lpx9UK0+LSqfsy0sHWDsa3Zebx9KtQPZzMYnzp79O3Is
         D7jz+r/+vQ8+ZjQysriGBOFNp1NE04SwWyw3NA9vr6ZrZp0fhhnUSO+hwMbUCXIykk9q
         PCjmW2i7qrlUGPOCoOjNKZAedxiTmbE+O4cIebwhjBKZPIVt3eLa0pHink3fH/iYNy1m
         iIFjFbjeL7usHKzs412FkEuzXfNO839iHA1/qUpQBKKgNx0hMqLQdNUocjqHPZ4RJGuF
         Wc/KvuqyKGDAYlqGAcRImiqbuZljsAdIYykCWuO2vLMBAkBk0tRPHZnCIaQamMrOuhBz
         bbLA==
X-Forwarded-Encrypted: i=1; AHgh+RoJNsL/AiHL9xlI2aOJzJFNCwUu8f9ZDV6SX0qfc8N9c/wheyeFJUmkrYMb5jTyqdG9MUsINfrdz7bT@vger.kernel.org
X-Gm-Message-State: AFuF++nSU/8KW0aKIFK2DDQcx1SPyXhnmgO2JcLaRq6vrAQXLrhhj+cy
	EAe2qnI7keOPBHA5Hms/pUjdoquZVXh32A5g0j6m/ksdvySXL85ux3ShkYynV+QebQ==
X-Gm-Gg: AR+sD12RVc7dhoYcn/d6WENRXpAG0QrNyh/phQRAEvUJPugIF9SxJID3/VSaf8T20vf
	+HmfyOsOslYP4RT+uAPZVjG4rI83V6thOR2PBi33pupKLISjuwIW5kiDuWpqEspBuuD1S1MMztE
	sw7yAcgG2ZqfbNua6KzojCRGP8pEEE1ewfUA7wiYPplUeWifoQ7go4c7l1T0Q05hYWvh1YJ298+
	DCm+I3tYkJ6tq+NKz0LlAiX4lAaFiKiJrpo91sN/XYkSA4KVYvDlHzARpyBXSUdnTS1zw1Zy411
	jGj0iYM2eahdn+75a3H3U4+kC9ooskXuQ0SqIfj8mQfK9QTLQsBaP8asAolfiYcansBpr3wor/K
	wkJ/4FX6qj3MqCTHsEAza6BdgCX+lLWdrbtx/Yv/2aclWxJOXvP7coQ4XIsfeWWRsTi+utzBvx2
	jPnGWGxGlx+aPhMSgLaLT61L2uXZWGGo3CCU2YSkTplIsQESLRP9570UM6TAcNLj93ILQE9v3rI
	KL6sa7B5bpyyHaEynvbvLU+SCJUcnUO
X-Received: by 2002:a05:600c:548c:b0:499:8aff:59b6 with SMTP id 5b1f17b1804b1-499c19f514emr11324295e9.14.1787345093778;
        Fri, 21 Aug 2026 13:44:53 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499b911584bsm40454845e9.14.2026.08.21.13.44.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 13:44:52 -0700 (PDT)
Date: Fri, 21 Aug 2026 21:44:49 +0100
From: Vincent Donnefort <vdonnefort@google.com>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Yury Norov <yury.norov@gmail.com>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Russell King <linux@armlinux.org.uk>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	"Liam R. Howlett" <liam@infradead.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Mike Rapoport <rppt@kernel.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Chun Ng <chunn@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, pavan.kondeti@oss.qualcomm.com
Subject: Re: [PATCH v4 07/10] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <aoi4wZJIutMWu9Ux@google.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com>
 <an8K2gb1pIqbDj6-@orome>
 <aoNDRTKCUkzd2n5G@google.com>
 <aoQ1lhZojzsSkWHQ@orome>
 <aoVy8dj8f3ll5-M4@google.com>
 <aobOs0ZidWzgoHut@orome>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aobOs0ZidWzgoHut@orome>

[...]

> > > Interesting. I had been thinking more along the lines of adding this
> > > directly into memblock using a new entry in enum memblock_flags. None of
> > > the existing ones seem to do what we need here, though some are closely
> > > related. MEMBLOCK_SECURE or MEMBLOCK_PROTECTED are quite specific and
> > > don't necessarily mean that we need the mapping to be page-granular, so
> > > MEMBLOCK_PAGE_GRANULAR is perhaps clearer.
> > 
> > I thought it would be interesting to not have to modify memblock since it is
> > used for all architectures, while the DT is at least slightly less widespread.
> 
> This isn't something that is DT specific. On the Tegra side, I suspect
> we might need this on ACPI platforms eventually, too. And it's not an
> ARM specific feature either. Other platforms could use shared carveouts,
> too.

Agreed, and actually I have tried the memblock version and it looks quite neat!

I will share what I have after the merge-window.

> 
> > Also, cma_init_reserved_mem() could use an order 9. In that case PTE-level isn't
> > necessary and we could just use PMD-level. Extending that support would be more
> > cumbersome with a memblock flag than with a callback.
> > 
> > rmem_cma_setup() hardcoding an order 0, perhaps this isn't really a problem at
> > the moment?
> 
> How so? memblock is really just used as a way of backing the CMA. How
> CMA subdivides it doesn't really matter, right?
> 
> Or are you suggesting that if we use an entire PMD as granularity, we
> could equally well remove the entire PMD from the linear mapping instead
> of doing it page-by-page? I think that'd work really well for at least
> VPR, since it is 1 MiB aligned anyway. Using a granularity of 2 MiB is
> easily doable.

Yes, that is what I meant. We could easily force a PMD-level mapping instead of
PTE-level one. But then that means declaring another memblock flag. 

> 
> For anything that doesn't require a single contiguous area to be
> protected this might be a bit more challenging since it potentially
> wastes a lot of memory. On the other hand, a lot of this is heavily
> custom code anyway, so the entire stack could be modified to make
> efficient use of this (i.e. userspace could allocate a larger chunk
> for a pool of buffers, etc.).
> 
> > But yeah, the alternative is to create a "memblock_mark_forcepte" (it seems
> > memblock_setclr_flag does split memblocks) and let of_reserved_mem call that
> > function. Finally the arm64 mmu code can simply check for the flag before
> > calling __map_memblock. Perhaps it isn't that bad in the end?
> 
> It sounds like the right level of abstraction to me. But I'm not too
> familiar with this code, so it'd be good to hear from the MM and/or ARM
> maintainers what they think about this.
> 
> [...]
> > I had in mind to extend "shared-dma-pool" to handle
> > set_direct_map_invalid_noflush()/set_direct_map_default_noflush() based on an
> > option. But perhaps it is better to create another separate driver. And VPR
> > needing a specific dma-heap driver anyway, it could call the direct-map
> > functions there too without relying on CMA to do anything?
> 
> I think it'd be nice to have separate APIs for this case where we know
> the memory region is already page-granular (or, I suppose, PMD granular)
> and removing from (or adding back to) the linear mapping is safe. That
> way we could avoid the checks for can_set_direct_map() for each page.
> 
> It'd also be nice to have a version that can update the protection bits
> for a range of pages (would map directly to update_range_prot()) instead
> of having to manually iterate over each page in a range.
>

How about?

  /* True if can_set_direct_map() or [start, end) is mapped at PTE-level */
  can_set_direct_map_range(phys_addr_t start, phys_addr_t end); 

  /* Must check can_set_direct_map() or can_set_direct_map_range() first */
  __set_direct_map_invalid_noflush(phys_addr_t start, phys_addr_t end)
  __set_direct_map_default_noflush(phys_addr_t start, phys_addr_t end)

> A good middle-ground might be to have helpers that do the grunt work and
> they can then be called from VPR and the shared-dma-pool drivers to have
> pages removed from the linear mapping. VPR and similar can then perform
> the hardware protection bits on top of that.

I believe between the reserved-memory attribute to force the last-level mappings
and the direct map functions above, there's enough for the VPR driver?

-- 
Vincent

> 
> Thierry
