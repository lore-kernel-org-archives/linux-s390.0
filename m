Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D6B8321457
	for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787576853; cv=none; b=MssBGXAj8FySZHriW4fmw2io3uzNSuSnbEdSiSXoJYZloa7EdUVrx9nFXr84q762dG+s2XVVroB4kZeFeOgnT6b26Gz/utzfS7XfJW3MLtOc8zuK8PK1VFnZYWmY50Mv4e9JxMYKuJmTWT8Ns3nMRyVkAD3FqXE4l5aZLBvvrrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787576853; c=relaxed/simple;
	bh=u5ihNkizXxWzyF5GSE/VjUlcZrXmF+6zr4JEzwJ38CA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Tr09R+3Yp4+U2TcCtAKSaH/MWkskNN2pthPwDtZwHFitrUUggAtYxdg7aXPT/ukrxOckyJ4ZwuH4NO8xe2jshWE0Bjm3Q/PHl0LDEph3RoQK1BokpGJM/Gc/ueSWEFnPwJRkFTKqZuSDGv771IoVzwdTfhvd5NlpyKa5/woFtP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VasDoPJ+; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VasDoPJ+"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-47f703a9d05so1670566f8f.0
        for <linux-s390@vger.kernel.org>; Mon, 24 Aug 2026 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787576849; x=1788181649; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=II0EHdpiWVifHn+uIz31c6Jp5mdC3hunRFCnEAwNy/g=;
        b=VasDoPJ+9W3n6kop+crjHXP7TptzbDGsgfbm9Uk4NKXGd6OGSugla7VlitMZw98TK9
         NVgdy1g8rya6Yqv+lAwmQAA7dqQjHTRt75BtuIha0W9mgx+ggKWWMmmUisJSlAMrinEf
         e3/R/ELvI9YYRlq7rCg1cATN/Ub4gE0rcWwcfO9hgfAQupcKHPbzKdmaIZZ0D9++h+oY
         dgvGtWeYGOvPvZVQeL6A7w6M0zsypu09XmYrqR3Iwv/cCfnEnCvT+xc+/+KUwzYHtU8o
         EpfP/3KzoKSiw0GhTSCSkj4lZZjidkJLF+3SH2bAzDuzawyPRDr7Y4fQ0iJXmjmixqg9
         8Dog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787576849; x=1788181649;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=II0EHdpiWVifHn+uIz31c6Jp5mdC3hunRFCnEAwNy/g=;
        b=NhcxFOdHBOddxpt3JfIej5vqzeDLFCRf0jRhX1jkPH4fhgmza9D8eTHhagw4QEd8/I
         ciD9V96NPb0fO6wgRCgPfiSIYzauBknHT2jrCUSxJhJGz47Sv4GYgPjEt3byu+KIYy4h
         Sx0j7U/MD0wbhVd1A9Io9piO72XqZmdQhMaXtDi0Tio41Y+jbnwmDtV/o8ZQpVZnIKr+
         Iu6sRGxUpemFeUXGdL20AqtRGvrl7zNrrfagmZurD9XkHmQc5z089U+J7m5R58DMB/dp
         V9VpN7RMskMwzTEYKDtMbh2fYJTjZk0iceqPwcTlaKAJC6WKv1yRvmpk85kW4zvrMh/M
         X7Mw==
X-Forwarded-Encrypted: i=1; AHgh+RrqcJBtYV/xBOBpA0yVjwfzvRBKAF0UxeorUMaOX+NYIf8NjZdRFLPePIHVmESzhdc41uQxi6Klb8Er@vger.kernel.org
X-Gm-Message-State: AFuF++lD7WjgnhC38XTD1QLmPzI9PaJATrgpZa/16AWwYJUPScR1TE8L
	gfNBjaVVsqubDsw7JwpqXqsonWH8K9mwqjFnY/3TsL98AWJxwY4ZFvdkUyJzs6X+iw==
X-Gm-Gg: AR+sD118SnZBE/QMzoFzBU/UW1s2LSaPwayXEg2FbdCOGK5z66dmcHbE8rcEu9zJ8vN
	ukOeZ6nzX7Tg6hGaefUVskyamHvtrUOU7QAppoeoLwOzow0TpT1tdFm4xnMF8+pXGYAhtYVpl+B
	V5ojmNsMqgkrjabX1yrBpY3m37uZQlb2mjheVeGxI04iZa+m2rYo2GhUlwyi2s2E8FPdIMlEDZ1
	O+LJWX81Bq0QPYVe9Tq27bC3rJEVRhO4HkpGUciEDOaWWpBAHNr0X4b8umuuGqwmNnv/rVLqNG5
	Z5loUQ/djDuRVEMMLx8losi3AYREbA3idYiRUB/iFJRkBNLRQ2vkBct3XF1aVDVZltiPVDFR9Gc
	HBIdzSUidg9HFGKbhg76l/t9mnTCBDOD6oU+E+bPF6mj/nxU2TWjRsS+SK4TY4SsJ2Nj6K5GnEx
	lClJJ20d/AJpJwVoI/KoBklS6Fqx5xbHwpFWMmLWhXKLfXp3BwCT2rRygI57XkHxCOofUHx56oN
	aSVLV+m5Zrj16I/LrdN9EfULn9N/CEq
X-Received: by 2002:a05:600c:8b76:b0:499:8c68:a3aa with SMTP id 5b1f17b1804b1-499b8475133mr350361245e9.13.1787576848494;
        Mon, 24 Aug 2026 06:07:28 -0700 (PDT)
Received: from google.com (135.91.155.104.bc.googleusercontent.com. [104.155.91.135])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-499c355e1ddsm85389525e9.5.2026.08.24.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 06:07:27 -0700 (PDT)
Date: Mon, 24 Aug 2026 14:07:23 +0100
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
Message-ID: <aoxCC1yPFdutU5vB@google.com>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-7-5510d16af89e@nvidia.com>
 <an4MEI7lkc2p3nKI@google.com>
 <an8K2gb1pIqbDj6-@orome>
 <aoNDRTKCUkzd2n5G@google.com>
 <aoQ1lhZojzsSkWHQ@orome>
 <aoVy8dj8f3ll5-M4@google.com>
 <aobOs0ZidWzgoHut@orome>
 <aoi4wZJIutMWu9Ux@google.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aoi4wZJIutMWu9Ux@google.com>

On Fri, Aug 21, 2026 at 09:44:49PM +0100, Vincent Donnefort wrote:
> [...]
> 
> > > > Interesting. I had been thinking more along the lines of adding this
> > > > directly into memblock using a new entry in enum memblock_flags. None of
> > > > the existing ones seem to do what we need here, though some are closely
> > > > related. MEMBLOCK_SECURE or MEMBLOCK_PROTECTED are quite specific and
> > > > don't necessarily mean that we need the mapping to be page-granular, so
> > > > MEMBLOCK_PAGE_GRANULAR is perhaps clearer.
> > > 
> > > I thought it would be interesting to not have to modify memblock since it is
> > > used for all architectures, while the DT is at least slightly less widespread.
> > 
> > This isn't something that is DT specific. On the Tegra side, I suspect
> > we might need this on ACPI platforms eventually, too. And it's not an
> > ARM specific feature either. Other platforms could use shared carveouts,
> > too.
> 
> Agreed, and actually I have tried the memblock version and it looks quite neat!
> 
> I will share what I have after the merge-window.
> 
> > 
> > > Also, cma_init_reserved_mem() could use an order 9. In that case PTE-level isn't
> > > necessary and we could just use PMD-level. Extending that support would be more
> > > cumbersome with a memblock flag than with a callback.
> > > 
> > > rmem_cma_setup() hardcoding an order 0, perhaps this isn't really a problem at
> > > the moment?
> > 
> > How so? memblock is really just used as a way of backing the CMA. How
> > CMA subdivides it doesn't really matter, right?
> > 
> > Or are you suggesting that if we use an entire PMD as granularity, we
> > could equally well remove the entire PMD from the linear mapping instead
> > of doing it page-by-page? I think that'd work really well for at least
> > VPR, since it is 1 MiB aligned anyway. Using a granularity of 2 MiB is
> > easily doable.
> 
> Yes, that is what I meant. We could easily force a PMD-level mapping instead of
> PTE-level one. But then that means declaring another memblock flag. 
> 
> > 
> > For anything that doesn't require a single contiguous area to be
> > protected this might be a bit more challenging since it potentially
> > wastes a lot of memory. On the other hand, a lot of this is heavily
> > custom code anyway, so the entire stack could be modified to make
> > efficient use of this (i.e. userspace could allocate a larger chunk
> > for a pool of buffers, etc.).
> > 
> > > But yeah, the alternative is to create a "memblock_mark_forcepte" (it seems
> > > memblock_setclr_flag does split memblocks) and let of_reserved_mem call that
> > > function. Finally the arm64 mmu code can simply check for the flag before
> > > calling __map_memblock. Perhaps it isn't that bad in the end?
> > 
> > It sounds like the right level of abstraction to me. But I'm not too
> > familiar with this code, so it'd be good to hear from the MM and/or ARM
> > maintainers what they think about this.
> > 
> > [...]
> > > I had in mind to extend "shared-dma-pool" to handle
> > > set_direct_map_invalid_noflush()/set_direct_map_default_noflush() based on an
> > > option. But perhaps it is better to create another separate driver. And VPR
> > > needing a specific dma-heap driver anyway, it could call the direct-map
> > > functions there too without relying on CMA to do anything?
> > 
> > I think it'd be nice to have separate APIs for this case where we know
> > the memory region is already page-granular (or, I suppose, PMD granular)
> > and removing from (or adding back to) the linear mapping is safe. That
> > way we could avoid the checks for can_set_direct_map() for each page.
> > 
> > It'd also be nice to have a version that can update the protection bits
> > for a range of pages (would map directly to update_range_prot()) instead
> > of having to manually iterate over each page in a range.
> >
> 
> How about?
> 
>   /* True if can_set_direct_map() or [start, end) is mapped at PTE-level */
>   can_set_direct_map_range(phys_addr_t start, phys_addr_t end); 
> 
>   /* Must check can_set_direct_map() or can_set_direct_map_range() first */
>   __set_direct_map_invalid_noflush(phys_addr_t start, phys_addr_t end)
>   __set_direct_map_default_noflush(phys_addr_t start, phys_addr_t end)
> 
> > A good middle-ground might be to have helpers that do the grunt work and
> > they can then be called from VPR and the shared-dma-pool drivers to have
> > pages removed from the linear mapping. VPR and similar can then perform
> > the hardware protection bits on top of that.
> 
> I believe between the reserved-memory attribute to force the last-level mappings
> and the direct map functions above, there's enough for the VPR driver?
> 
> -- 
> Vincent
> 
> > 
> > Thierry

I have pushed a first version here [1]. I am waiting for the merge window to end
before posting anything on the list, but let me know if you have any comment.

[1] https://android-kvm.googlesource.com/linux/+/refs/heads/vdonnefort/ffa-lend-pool

-- 
Vincent
