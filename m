Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 368B3431E7A;
	Wed,  1 Jul 2026 19:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782935593; cv=none; b=GgMF8YKHZ/JJBVMjPZNG2BtnfUkoACVEJDba3QGYt58xPDP99gp1i7O5xnrXSqqQxjAs8HBtI/WuYl4zrO7o1wP08rC+dhFWZBN/59sdzc6QBkB79mIOjaGb7ChOyJkNhM5UUbKYfyZqloUD7Z2rCk7tsd2p/8z1fyJS+14V9Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782935593; c=relaxed/simple;
	bh=dls7ew1+DYfJVASM/Ls/ff51kSQcSlGjKUlKVbrcrxs=;
	h=Date:Content-Type:MIME-Version:From:Cc:To:In-Reply-To:References:
	 Message-Id:Subject; b=PQM8Cy2Za1lzz7+ocF7hZYvBGH90Aa80frF0+sojwZW8IL0OS4sfo+g0gKzpmROMTjGxsbY23CEAlURzwK0h80P3BA0MKV8Fgck8WZt9+0Io41aRtn2ehu35zEOUl69iiVc+Gm91QRM13+0Hnh/Sxet6gmoY5Buq2rJEUPHuunM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SW5Xw1L4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SW5Xw1L4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DA4B1F000E9;
	Wed,  1 Jul 2026 19:53:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782935591;
	bh=Btp8Coh0/YDoX5eWIBILnB6rkqO9aOJKzbTAJEfWmYk=;
	h=Date:From:Cc:To:In-Reply-To:References:Subject;
	b=SW5Xw1L4n6km0go7iiQIUMhYp6NAfj0RV6eYQqCVHodCALEB8dTOYsfQaNULAMbqI
	 xB7nUW5AdUfmj/kfqGM0ge94GbUCCvRDC/EQnSopZqdpLC3YWJPU3hhxzoB7TiuMXK
	 rgwksGyFQDkLQ4L1Zv//reedGipqwPdRgCwYfIYn7SUowcW/xIaoKQgA7tLYyowF21
	 vtZqvsjUt5lA/qYPA9GV1RiCdmGczJhLUDM+otUG+k4cTl/W4Sjha1gMK6icACBU9B
	 4gKGJaZ253aNPnE8hxuMfX5mHW4TnINK1IFn2iP7EiwQlNNuW7HvzKuCaOFexbJrlV
	 u/4ONeNo3HSXg==
Date: Wed, 01 Jul 2026 14:53:10 -0500
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 dri-devel@lists.freedesktop.org, David Hildenbrand <david@kernel.org>, 
 Yury Norov <yury.norov@gmail.com>, linux-media@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, 
 Simona Vetter <simona@ffwll.ch>, linux-trace-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 linux-mm@kvack.org, Russell King <linux@armlinux.org.uk>, 
 Will Deacon <will@kernel.org>, Masami Hiramatsu <mhiramat@kernel.org>, 
 David Airlie <airlied@gmail.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 linaro-mm-sig@lists.linaro.org, Heiko Carstens <hca@linux.ibm.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, Thierry Reding <treding@nvidia.com>, 
 Maxime Ripard <mripard@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, John Stultz <jstultz@google.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Vlastimil Babka <vbabka@kernel.org>, Brian Starkey <Brian.Starkey@arm.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Michal Hocko <mhocko@suse.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Suren Baghdasaryan <surenb@google.com>, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 devicetree@vger.kernel.org, "Liam R. Howlett" <liam@infradead.org>, 
 linux-tegra@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>, 
 Conor Dooley <conor+dt@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Lorenzo Stoakes <ljs@kernel.org>, "T.J. Mercier" <tjmercier@google.com>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, iommu@lists.linux.dev, 
 Mike Rapoport <rppt@kernel.org>, Sven Schnelle <svens@linux.ibm.com>
To: Thierry Reding <thierry.reding@kernel.org>
In-Reply-To: <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
References: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
 <20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com>
Message-Id: <178293558945.1610040.13281502080616690110.robh@kernel.org>
Subject: Re: [PATCH v3 01/11] dt-bindings: reserved-memory: Document Tegra
 VPR


On Wed, 01 Jul 2026 18:08:12 +0200, Thierry Reding wrote:
> From: Thierry Reding <treding@nvidia.com>
> 
> The Video Protection Region (VPR) found on NVIDIA Tegra chips is a
> region of memory that is protected from CPU accesses. It is used to
> decode and play back DRM protected content.
> 
> It is a standard reserved memory region that can exist in two forms:
> static VPR where the base address and size are fixed (uses the "reg"
> property to describe the memory) and a resizable VPR where only the
> size is known upfront and the OS can allocate it wherever it can be
> accomodated.
> 
> Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
> Signed-off-by: Thierry Reding <treding@nvidia.com>
> ---
> Changes in v2:
> - add examples for fixed and resizable VPR
> ---
>  .../nvidia,tegra-video-protection-region.yaml      | 76 ++++++++++++++++++++++
>  1 file changed, 76 insertions(+)
> 

My bot found errors running 'make dt_binding_check' on your patch:

yamllint warnings/errors:

dtschema/dtc warnings/errors:
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protected@2a8000000 (nvidia,tegra-video-protection-region): reg: [[2, 2818572288], [0, 1879048192]] is too long
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra-video-protection-region.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/reserved-memory/nvidia,tegra-video-protection-region.example.dtb: protected@2a8000000 (nvidia,tegra-video-protection-region): Unevaluated properties are not allowed ('no-map', 'reg' were unexpected)
	from schema $id: http://devicetree.org/schemas/reserved-memory/nvidia,tegra-video-protection-region.yaml

doc reference errors (make refcheckdocs):

See https://patchwork.kernel.org/project/devicetree/patch/20260701-tegra-vpr-v3-1-d80f7b871bb4@nvidia.com

The base for the series is generally the latest rc1. A different dependency
should be noted in *this* patch.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit after running the above command yourself. Note
that DT_SCHEMA_FILES can be set to your schema file to speed up checking
your schema. However, it must be unset to test all examples with your schema.

