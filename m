Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E138947B43A;
	Fri,  4 Sep 2026 11:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788522081; cv=none; b=mkXWooj5B11HJyUcJnfxKqFvtGM9buVx3TT0K+/Gk6i7rD9Qx2HdHcfKOL1Ol56QsBQFE+U210H7Cwfwm/qLPwUZuxSXqZcQVlbIfWAnEklh4lrzB/KLa/iWCnPtTlhfeAi6t9mCI5NeJKKeFx/plvQjodoQ6qyKRkucPLsZrOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788522081; c=relaxed/simple;
	bh=Q1NvEJXFyy5z7/NMmrTiOmbn6NbJe0qgf75i2SY26DE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zn6cBI33ifgQz42Kvg0tPcYOylljuaCRVnHw9jYj9iHWZtPK1OwH2qZ7nlZ26zfLdB0xRwLRX4iLkVd3UD1GN4u+EsjDE/nbcxuGYj8GZ3nOWeAEZsI5/LJm9jeD+byc4BWqy31IkAnZ4PPe4vWIZPnFBh2hLhIU8d1ncdcEez8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AiADOeqn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AiADOeqn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6381A1F00A3E;
	Fri,  4 Sep 2026 11:41:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788522079;
	bh=AVcKEaA4QKNBqPQxG7kCkdRB1jRFfjMN2gDUjmG9sC4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AiADOeqnGMHeLkfaGNji1T3Dj3iV1UB/ASC2xLDgi7AfO3Xx5O8iq6YxSwXlm2j4e
	 +kp9dklRJ7+iqSVX2PJ5wPUaOLeh0xL3AG7uZXSajQB8Ueai6Q/MwLs+2KsniKywT4
	 ng5I34uDzQcmVKk7eyz2TXtpx4Ht+KP87LPZnCDOBaW8k2Rs8suvD9hMRM0s3nI03H
	 khymos7oQULP1MD/xvWmlFFMgkHQ9XejH5YMHiX3uh0rmk92ZYbQ98AlvpLzDSohTg
	 v3IUX38C/8KGCNvpFnTzHhpBe9kqorbNRNmkYYevlia5fsjiGh0O87jfvbAnvMeM0J
	 1APOUvIK5UabA==
Date: Fri, 4 Sep 2026 12:41:05 +0100
From: Will Deacon <will@kernel.org>
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
	Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, vdonnefort@google.com
Subject: Re: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
Message-ID: <apquUWgrD9C2jWQ0@willie-the-truck>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>

Hi Thierry,

On Fri, Sep 04, 2026 at 12:44:51PM +0200, Thierry Reding wrote:
> This series adds support for the video protection region (VPR) used on
> Tegra SoC devices. It's a special region of memory that is protected
> from accesses by the CPU and used to store DRM protected content (both
> decrypted stream data as well as decoded video frames).
> 
> Patches 1 through 3 add DT binding documentation for the VPR and add the
> VPR to the list of memory-region items for display, host1x and NVDEC.
> 
> The set_direct_map_*_noflush() functions that will be used later in this
> series are exported in patch 4 so that the drivers that use them can be
> built as a module.
> 
> Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
> but works on sizes that are not a power of two.
> 
> The of_node_to_nid() function is exported in patch 6 because it is used
> in a later patch adding a driver that can be built as a module.
> 
> Patch 7 introduces new APIs needed by the Tegra VPR implementation that
> allow memory to be allocated at a fixed offset within a CMA area. Tegra
> VPR needs this in order to implement its own allocator on top of CMA to
> meet the strict hardware requirements. This replaces the dynamic CMA
> area creation patch from earlier versions.

Did you get a chance to see how this could work with Vincent's series:

https://lore.kernel.org/r/20260902104712.2399797-1-vdonnefort@google.com

? I think that should remove your reliance on can_set_direct_map() and
mean that you can retain block mappings for most of the linear mapping.

Looks like you forgot to cc him, so I added him here.

Cheers,

Will
