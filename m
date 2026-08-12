Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49722339365;
	Wed, 12 Aug 2026 22:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786574019; cv=none; b=CeousrofJSFxNajkPrNYk8NCY74WqBjPYuwYM9xnHgNqz18GOY63PPUQlw8908matOrzyG5bx1vDIRqdEGe/1jR1qWRsJYTf5+R/ARC/JoJu4CUfmQl8zoRe/wFoyujZQwobh4j+O6872VW47lYYBkxwHPouXtCx093y3k15QNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786574019; c=relaxed/simple;
	bh=9jEZcXgs8xFvSWyzWWxmvAqve19sJy+uBZfUIpOHysc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d5cmfq+d7fDRTWEub1fPRxnvG/0ozXdQr5kfrR6+2T/CSEhieRLQNTB1OQUMW2R3w+1UBca69VfYWdPPzV3YVWUYtjLwmIxVn3cuImRWBtA87ooooERYpxYjTC1ZJeGkk428ptsBB7NFCU3JfmFumP8+n+ALw9o9Bc8xAj9CkNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxnDcAN9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxnDcAN9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6503E1F00A3F;
	Wed, 12 Aug 2026 22:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786574017;
	bh=aHVs81CE2IQ9JD4d8n66KMCOswlVQXDqi/24OSbt1Sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=NxnDcAN9Z4zXwB8VaQ4ooTdrRgky6Q8zLm6mxJ1RjWe0Ovnre8a/4e3j/pRx23n0/
	 cgEf7TjrJMOhg0gmXjJXZ4JO3u25sFIG+ohZ87f1hnkqMiFEbX7HY4rFnFRxcBbrlh
	 tarqc9v8P+vKy7klLcouGokQZCYzNvAPTFlHUzDvkg0nGKbkA5JZXjdnJZSEsnLwSd
	 kSwV3PlOUlPY3k2iIRlibhfvsba3Q+ayHFC5C16qaWaoflAOG0WuK1M2/oFs8EbGqQ
	 7FfrFAcQJBPX6Dt+03UO4/bZ+nDwz1sfdBzJP5rXNK3BVTpjgRsNEjab5htv4BFZXL
	 /sa4Zn9VXn4YQ==
Date: Wed, 12 Aug 2026 17:33:36 -0500
From: "Rob Herring (Arm)" <robh@kernel.org>
To: Thierry Reding <thierry.reding@kernel.org>
Cc: linaro-mm-sig@lists.linaro.org, Sumit Semwal <sumit.semwal@linaro.org>,
	Russell King <linux@armlinux.org.uk>, linux-tegra@vger.kernel.org,
	linux-mm@kvack.org, Maxime Ripard <mripard@kernel.org>,
	Yury Norov <yury.norov@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Vlastimil Babka <vbabka@kernel.org>,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	iommu@lists.linux.dev,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Brian Starkey <Brian.Starkey@arm.com>,
	linux-trace-kernel@vger.kernel.org,
	Steven Rostedt <rostedt@goodmis.org>,
	David Hildenbrand <david@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>, Simona Vetter <simona@ffwll.ch>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	"Liam R. Howlett" <liam@infradead.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
	Rasmus Villemoes <linux@rasmusvillemoes.dk>,
	Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	John Stultz <jstultz@google.com>,
	"T.J. Mercier" <tjmercier@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Masami Hiramatsu <mhiramat@kernel.org>, devicetree@vger.kernel.org,
	Mike Rapoport <rppt@kernel.org>,
	linux-arm-kernel@lists.infradead.org,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Suren Baghdasaryan <surenb@google.com>, Chun Ng <chunn@nvidia.com>,
	Thierry Reding <treding@nvidia.com>, linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>, David Airlie <airlied@gmail.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Jonathan Hunter <jonathanh@nvidia.com>
Subject: Re: [PATCH v4 02/10] dt-bindings: display: tegra: Document memory
 regions
Message-ID: <178657401505.1337249.16016860893024599580.robh@kernel.org>
References: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
 <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260807-tegra-vpr-v4-2-5510d16af89e@nvidia.com>


On Fri, 07 Aug 2026 17:54:22 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Add the memory-region and memory-region-names properties to the bindings
> for the display controllers and the host1x engine found on various Tegra
> generations. These memory regions are used to access firmware-provided
> framebuffer memory as well as the video protection region.
> 
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v4:
> - typofix
> 
> Changes in v3:
> - document properties for VIC
> ---
>  .../devicetree/bindings/display/tegra/nvidia,tegra124-vic.yaml |  8 ++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra186-dc.yaml  | 10 ++++++++++
>  .../devicetree/bindings/display/tegra/nvidia,tegra20-dc.yaml   | 10 +++++++++-
>  .../bindings/display/tegra/nvidia,tegra20-host1x.yaml          |  7 +++++++
>  4 files changed, 34 insertions(+), 1 deletion(-)
> 

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>

