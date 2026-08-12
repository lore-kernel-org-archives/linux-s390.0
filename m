Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F553424D6C;
	Wed, 12 Aug 2026 22:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574057; cv=none; b=d4zr95+gMIySjQc9o6JBudvzmUhulw21M0q4YL0keUTbN010n1aiQ6PO4nIWZZgoT5j/LOe2Sq1BXfR5uGQWVaQCXTRGhyvgkKChh10TcZ3+sy0teWSWiRrv03aMqT++Tq+OWZldKSDPtlyn4MScG6pnIQbTnvBkj9e4+5oZJGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574057; c=relaxed/simple;
	bh=NOqt4RUv2KOwDkZ5JeKKp/7bO0/RaXtgWZSMuZ8V5sM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cg7tazJWf17+Ux7Vd0s+wJUziyWR/FF9fzXsTMCOcDsc62RbDCWPWNzaHOUqdKZG3ZNOTyPXkL+wEIQZ4wNUywoQyCdgWDxDqA9aSBP6pSRz6Rmy2WuHgVDvlSkMSt+pvoEEXJmS7YWlsgEYpO4lfmUY1nDqu7SLj5uudm1DZ8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cGPTP03w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cGPTP03w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BCDE1F000E9;
	Wed, 12 Aug 2026 22:34:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574055;
	bh=zIJaVQwgy3+phEYTr1LnspZFuRmzeHEpVwwk/PBOaCo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=cGPTP03wUG80YmVMBODmbasm4ppKUGuWWZcUwvqj46epN/xQO8bSWtSuxBsSzMTrm
	 xVAi3EIOLC10qfV/rs8N0KHo3fqQtHQdL7PQ9jXzPzkuVeIBgKcwXHU3KIX+2rD14R
	 n6ah8z+Q/9HwjWNp7R/I9R0wQg4Yqkc7nhslLLwNSozuRhmUl3Vy8JXtLk5xybQM0J
	 /guRBSF2oOcCa+eBmtvEvHHraXmiyJe77EreH8uPP6jDQdm9BoLpnGwAGlm0CPZIyj
	 oMUvUbXA8fJ9m9NcDjx70rQLJkU+OPiUVZtIs87OoQOux+/pyvd4DhAO9Twdc+Sp3T
	 Op1aDi3RrsjGA==
Date: Wed, 12 Aug 2026 17:34:14 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: Lorenzo Stoakes <ljs@kernel.org>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Conor Dooley <conor+dt@kernel.org>,
	Sven Schnelle <svens@linux.ibm.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	dri-devel@lists.freedesktop.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Heiko Carstens <hca@linux.ibm.com>, Michal Hocko <mhocko@suse.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	David Hildenbrand <david@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	linux-trace-kernel@vger.kernel.org,
	Vasily Gorbik <gor@linux.ibm.com>,
	Russell King <linux@armlinux.org.uk>,
	John Stultz <jstultz@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	iommu@lists.linux.dev, Mike Rapoport <rppt@kernel.org>,
	Chun Ng <chunn@nvidia.com>, linux-media@vger.kernel.org,
	Thomas Zimmermann <tzimmermann@suse.de>,
	"T.J. Mercier" <tjmercier@google.com>, linux-kernel@vger.kernel.org,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	devicetree@vger.kernel.org, Will Deacon <will@kernel.org>,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Yury Norov <yury.norov@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Thierry Reding <treding@nvidia.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	linaro-mm-sig@lists.linaro.org,
	Steven Rostedt <rostedt@goodmis.org>,
	David Airlie <airlied@gmail.com>,
	Maxime Ripard <mripard@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	Robin Murphy <robin.murphy@arm.com>, linux-tegra@vger.kernel.org
Subject: Re: [PATCH v4 03/10] dt-bindings: gpu: host1x: Document
 memory-regions for NVDEC
Message-ID: <178657405441.1338311.10765338394838016729.robh@kernel.org>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-tegra-vpr-v4-3-5510d16af89e@nvidia.com>


On Fri, 07 Aug 2026 17:54:23 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The video protection region is a reserved memory region that can be used
> for secure video playback. NVDEC can access this region to decode images
> into securely.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
>  .../devicetree/bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml     | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

