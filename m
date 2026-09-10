Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB7903B14CD;
	Thu, 10 Sep 2026 05:52:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789019523; cv=none; b=fQjaEACBAGS4joc3ZQopb56QSlVKRUhWFm33/DTC2UZ8hbPhnQ+03bz8I02uwodZdv+FTtzQwG5kEyJBYVdsrm5Br0PwSzWCtwmwlLQ1QOmznZHWIzqgrIDDr9310WLZAeB0qVI/GXfX6vU8VJmoGPxVAI+K+YIpkwB4XZV5KZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789019523; c=relaxed/simple;
	bh=eFkoKLMx6CWrBqLzh/2OAEjPMcLMJex/CnSZuYJAeB4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZSpC9r/5zYKIfGeL5XnmMYlW4WIA5yMRGgqhtFIrE16yueqpxB3spXRaTTqKdiggzuRJm9TnPnEtVvr8v5yWvjazEN0UTJkRsgDqe6naaJzRB6EwotaIIhZsZb+ClXjYNOsUZXOEJalw594//Lx7Kstp6CEJePRMX9nPQj0n8PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=2YEpsF2d; arc=none smtp.client-ip=198.137.202.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bombadil.srs.infradead.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="2YEpsF2d"
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
	:References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dr2hlvGX1oeEKCxfnd5X9ajv/3V1RzuH6f6k+gKLa1I=; b=2YEpsF2dy4dF+E5OuE1/Zk6cNe
	QCygMlId9eCRm2NVbsLffeSSqzYB99gs9iLF5flp3UVvUh//R01ZysL5QM1R/nsZazvygWachsRy1
	kqlHp5S2/99fGgHycoYYi/OGBrD8bvH8pyCKJjzQzmiAWUwSsFVcYy4xcFdR6BHD7Lp5m1LHvtkV2
	aEPgjFnNYdipWh0pO1JY2H+aZOpxYJ5lrn1vkFQxdRjHOegKXlWcaGKZq8lUZLXjvjzDBRAklcON3
	PWUYt2D20iByPA9g1u6y5Mm9bbo16VIWK8E7NgHiRbGGTdT5Ww4o10UajRwh/yOEqCHg2Jg8tcB6Z
	b0GhXEgQ==;
Received: from hch by bombadil.infradead.org with local (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4XhH-0000000DTvB-33x3;
	Thu, 10 Sep 2026 05:51:43 +0000
Date: Wed, 9 Sep 2026 22:51:43 -0700
From: Christoph Hellwig <hch@infradead.org>
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
	Mark Rutland <mark.rutland@arm.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v6 04/12] arm64/mm: Export set_direct_map_*_noflush() APIs
Message-ID: <aqJFb3VtsYtnIa1c@infradead.org>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
 <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260904-tegra-vpr-v6-4-79042cfa8de5@nvidia.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html

On Fri, Sep 04, 2026 at 12:44:55PM +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> Drivers that use this may want to be built as a module, so export them.

That's one of the worst commit log ever.  No, we don't just export
core symbols dealing with the kernel direct map because
"Drivers that use this may want to be built as a module".

For one exporting this at all needs a very good justification and
not just hand waiving.  But more importantly if we can't avoid
exporting it, it needs to be exported at the tightest sensible
scope.  E.g. for a given module if it is so special, or a namespace
if it's not that special.  But in doubt we should have a proper
core abstraction instead of opening up direct map manipulation to
random modules.

