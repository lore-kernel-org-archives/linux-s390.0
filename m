Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D39DD41D4D7;
	Tue,  7 Jul 2026 13:37:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783431421; cv=none; b=cUleUffoT4AoOE+8hpEQr2PcEkqfXoOkCRxz/N33/F7jRCaC/XUL7dQVpyMw/+vnaRiGtVfOTUdEpqIqkOM4RrbzAHQ+aFaNUCEuqQ+Htkqvrpzn5uX+zjwN1ym4U7MQORTubgGwuMftUlx3BXg1Dd2Et6mlm0C2+rd0exbRF0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783431421; c=relaxed/simple;
	bh=sYwS8ou9VYhfx6gHtvvSKZH1Q3kUx/7HfTO2JFgLyTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=V3bYOGU/Wg2FZYzmK8UOEOSgGjEmyD3gEE8wUQyNm8LWKQKm1MnJbhLKPAVQlbS8eClr2Ju0KGdJMnBAvmZufDAKapMTrOzBE1skqxxX8ym/lYFYYhxGQOfu5ofutDlp81/cl5pBgUyz9HdtDYThkyweTZPjvtl2BUf1N/2GLGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kUwTJQX7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kUwTJQX7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9E271F00A3A;
	Tue,  7 Jul 2026 13:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783431420;
	bh=vTs7v8zsu7whrsyWYprIzwZsShGkshSeH1mdnWeQhDk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=kUwTJQX71bILcSB7SmskFWmkhK3TGF8YHFkyzQY17WlEUAM8I+JqGhzvo55X7PZDi
	 oNje6D+myo2INszEVM2+lfsi+C0YTOUvQd8LQ6wAhpcKtd1hSyiihaQKnBkeNV4GNZ
	 5/3ulew7PLDZljlcalvW+jw7W3SqxgElQzYMRTnDAV7mG6O1GMwabMWgRGCkympsPW
	 1RpMFJA/eH96zKbocqhlAzgaIjPRn+rPf4mrjkia4fALw+u63xKvDyGhiNKwawd808
	 fZfwtvsYxWNpieAutJUVIs8936x82mFXpOxy8SGgRrCjLSRSD8AtbD3lO570OfQ5nP
	 hhaRyoXYh5eFQ==
Date: Tue, 7 Jul 2026 16:36:41 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Robin Murphy <robin.murphy@arm.com>
Cc: Will Deacon <will@kernel.org>,
	Thierry Reding <thierry.reding@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
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
	Suren Baghdasaryan <surenb@google.com>,
	Michal Hocko <mhocko@suse.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
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
	Thierry Reding <thierry.reding@gmail.com>,
	devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-mm@kvack.org,
	iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org,
	linux-trace-kernel@vger.kernel.org,
	Thierry Reding <treding@nvidia.com>, Chun Ng <chunn@nvidia.com>
Subject: Re: [PATCH v3 04/11] arm64/mm: Add set_memory_device() and
 set_memory_normal()
Message-ID: <ak0A6eLp0Pw8iKK0@kernel.org>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-4-d80f7b871bb4@nvidia.com>
 <akYs91INHMXMTI-t@willie-the-truck>
 <akZkuwktaXFTrASP@orome>
 <akaSJ5D98w2cHqb6@orome>
 <akftuw9NyRy36fXA@willie-the-truck>
 <akuvyu1Pq0ZVMZV0@orome>
 <akzikTrmhMsvkNVY@willie-the-truck>
 <b0a1bdd7-46ab-4025-8775-c9273892444e@arm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b0a1bdd7-46ab-4025-8775-c9273892444e@arm.com>

On Tue, Jul 07, 2026 at 02:17:29PM +0100, Robin Murphy wrote:
> 
> Given the precedent of memblock_mark_nomap(), as long as the reusable
> reserved-memory regions also get split into distinct memblocks, then it
> seems like in principle we ought to be able to give them a new
> MEMBLOCK_PTEMAP (or whatever) flag which could then be picked up in
> map_mem() without needing to override force_pte_mapping() globally?

Please don't. _nomap() caused enough pain.
 
> Cheers,
> Robin.

-- 
Sincerely yours,
Mike.
