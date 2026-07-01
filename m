Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC47342514;
	Wed,  1 Jul 2026 16:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782922122; cv=none; b=NbzNWgXl2E3Vmf4k1WlTtMl53q1zvN+LBZe7ffuCRo4OUqnue2IVJ8O6Nsg9feM68qfzG3Lg+zS3ncoFPJkP1BeIGd79DygToOLyWGkIRrlr6W9KNuV16ZJhC5d2OaoXVUiExGHLhZ+hTaNdHM0O1EBbVvlJ5nbcet6eA4xfbkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782922122; c=relaxed/simple;
	bh=mcbAkcbsEVWURkcAPa5vFsKErSyQeSmcgEUMd7efj+4=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=WRSDeZbUa7Xv9LfB8I1rd8nbJAzihhd2HFNvI0zB9omtPUvwaxeiCu8GeL/aJuiOzQc1nJB7jzarLx7p6tTpJmChlBTf49BuqNQdPB0PLgwFKsCpiUvLz976HPoVfYLYJ2w8LH7YtRm3LEGvvcdfnYVa3MspKJKtllHnlcFQBEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGttkpt2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGttkpt2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4031F000E9;
	Wed,  1 Jul 2026 16:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782922121;
	bh=yhKbdhzWpnCFtUyKxv59KV9t7EFGFM4f9xMCP7qFEVc=;
	h=From:Subject:Date:To:Cc;
	b=DGttkpt2Q8nKCRV6vNcCihSl2s2P3sXQXJneb2lgwIMp0raQkYNBn0B1iX9JZDkVQ
	 k4dG+eTP0xET6M0xHtUZMmPygZeNasR7NNqEs8Ao4tGxxBHVQT0dN0j35xqWlq9F3D
	 7TsLhvMtgoml/volx9enNoXRvNhfnq/UzStbhMITnm9bZ/xCkB/ptpFu6MST6Do92a
	 Bo7rV46eIb+rv+nHPcgdEpykB73R3FFnK2I3Ad0Q6npJcf291MYux1yByzq3FPIUbv
	 xnwNoo5N03lozMT4svu7Zev3XAoIVv3pMjNXbAUDMNWq26FygDt4YyuolIWjGdjhAx
	 3kDaMQyK3Hasw==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v3 00/11] dma-buf: heaps: Add support for Tegra VPR
Date: Wed, 01 Jul 2026 18:08:11 +0200
Message-Id: <20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WNQQ6CMBBFr2K6ts20lFpceQ/jAstYRgXMFInGc
 HepxpXLl7z//kskZMIktquXYJwo0dAvUKxXIrR1H1FSs7AwYByUsJEjRq7ldGMZGnsMpoQq2CA
 W/8Z4osentT98Od2PZwxjDmSjpTQO/PycTTp7ubsUwOjSugKUhcJU3kotx5aQ+akYG+rjLnY1X
 VUYOpHTk/mNHWhjtNMAlSq8K733/+MLco9XNXAUh3me32psPPb1AAAA
X-Change-ID: 20260507-tegra-vpr-cd4bc2509c4c
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@kernel.org>, 
 Jonathan Hunter <jonathanh@nvidia.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Sowjanya Komatineni <skomatineni@nvidia.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, Yury Norov <yury.norov@gmail.com>, 
 Rasmus Villemoes <linux@rasmusvillemoes.dk>, 
 Russell King <linux@armlinux.org.uk>, 
 Alexander Gordeev <agordeev@linux.ibm.com>, 
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, 
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
 Christian Borntraeger <borntraeger@linux.ibm.com>, 
 Sven Schnelle <svens@linux.ibm.com>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>, 
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
 Michal Hocko <mhocko@suse.com>, Marek Szyprowski <m.szyprowski@samsung.com>, 
 Robin Murphy <robin.murphy@arm.com>, Sumit Semwal <sumit.semwal@linaro.org>, 
 Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
 Brian Starkey <Brian.Starkey@arm.com>, John Stultz <jstultz@google.com>, 
 "T.J. Mercier" <tjmercier@google.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Steven Rostedt <rostedt@goodmis.org>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>, 
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>, 
 Chun Ng <chunn@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4551; i=treding@nvidia.com;
 h=from:subject:message-id; bh=mcbAkcbsEVWURkcAPa5vFsKErSyQeSmcgEUMd7efj+4=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqRTuFxsKTwjOCtR5nhntJn2yLMnMlfh6zt+LAH
 7ky+Ynu4rmJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCakU7hQAKCRDdI6zXfz6z
 oQwoD/0TQ8Z6/cD6v/Zn3dSTI8WYQWxtO0vPJo49co9ceBSk7rvwa7sDWVnkq/aSR1DWCnjdTxy
 MLbFDy8d42e7a8WASPwcb+qxk6A2DE+rORTT8tNXAHjZazxr1zUSNcD7bWpsgKSCx5aPWC1mqKr
 Qd/jKd8UnMS98mbljjkzPqeLPL+YhkPEpJJP8DVT1i9YQMwxmEaGSZCLxuhhgKgyc30NbeIG/3q
 RvqF9uzJW+aC+WeXK7CXK/zLuEYuBQWl2Q/o0khZFV5ky9mLOsc/5WLPo1OnbyRnV/MRyFgKLu0
 9bgqlw4SvKJ8pCjuf23uADlEoQG7f/dJiiftMDDtoEU8bv0k0MY18tWKYDhHo25E4op4WnnWmTY
 dT8fZaVl4l76093yChzqBXvDxzh2Z1ScWIvcKyJ7rXameRAxhIOBNUH1fKZSvMHxnwLiu6sz6L+
 jMDvSC6DYoDG3PkaCo5EHIRC4VLIEaDzOx4W9++lDj28rsNMbaxrT7E4/eaxGxaTxs+GSyK9OuH
 75g4ungRoFK/zaOhqHYK6clVpUjduhNhuGaqldgN40zWkEDO5NdGEghVx/3uGHLT0L8XOaUpm1c
 jYi+cqYAfuQpQnJQ8c3JrVv3P4AeO1rlBm5cvphmRxQRD23EP0kUoWFgxy+eVF+WUSDoRjnyb4X
 wTi/+K/io8cd7EQ==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

This series adds support for the video protection region (VPR) used on
Tegra SoC devices. It's a special region of memory that is protected
from accesses by the CPU and used to store DRM protected content (both
decrypted stream data as well as decoded video frames).

Patches 1 through 3 add DT binding documentation for the VPR and add the
VPR to the list of memory-region items for display, host1x and NVDEC.

New set_memory_device() and set_memory_normal() helpers are defined in
patch 4 and will subsequently be used to set the memory type of the VPR
to make sure it won't be accessed by the CPU once it's made part of the
protected region.

Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
but works on sizes that are not a power of two.

Patch 6 introduces new APIs needed by the Tegra VPR implementation that
allow CMA areas to be dynamically created at runtime rather than using
the fixed, system-wide list. This is used in this driver specifically
because it can use an arbitrary number of these areas (though they are
currently limited to 4).

Patch 7 adds some infrastructure for DMA heap implementations to provide
information through debugfs.

The Tegra VPR implementation is added in patch 8. See its commit message
for more details about the specifics of this implementation.

Finally, patches 9-11 add the VPR placeholder node on Tegra234 and
Tegra264 and hook it up to the host1x node so that it can make use of
this region.

Changes in v3:
- Link to v2: https://patch.msgid.link/20260122161009.3865888-1-thierry.reding@kernel.org
- introduce set_memory_device() and set_memory_normal()
- rename VPR nodes to "protected"
- add Tegra264 placeholder nodes

Changes in v2:
- Link to v1: https://patch.msgid.link/20250902154630.4032984-1-thierry.reding@gmail.com
- Tegra VPR implementation is now more optimized to reduce the number of
  (very slow) resize operations, and allows cross-chunk allocations
- dynamic CMA areas are now trackd separately from static ones, but the
  global number of CMA pages accounts for all areas

Thierry

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Chun Ng (1):
      arm64/mm: Add set_memory_device() and set_memory_normal()

Thierry Reding (10):
      dt-bindings: reserved-memory: Document Tegra VPR
      dt-bindings: display: tegra: Document memory regions
      dt-bindings: gpu: host1x: Document memory-regions for NVDEC
      bitmap: Add bitmap_allocate() function
      mm/cma: Allow dynamically creating CMA areas
      dma-buf: heaps: Add debugfs support
      dma-buf: heaps: Add support for Tegra VPR
      arm64: tegra: Add VPR placeholder node on Tegra234
      arm64: tegra: Hook up VPR to host1x
      arm64: tegra: Add VPR placeholder node on Tegra264

 .../display/tegra/nvidia,tegra124-vic.yaml         |    8 +
 .../bindings/display/tegra/nvidia,tegra186-dc.yaml |   10 +
 .../bindings/display/tegra/nvidia,tegra20-dc.yaml  |   10 +-
 .../display/tegra/nvidia,tegra20-host1x.yaml       |    7 +
 .../bindings/gpu/host1x/nvidia,tegra234-nvdec.yaml |    8 +
 .../nvidia,tegra-video-protection-region.yaml      |   76 ++
 arch/arm/mm/dma-mapping.c                          |    2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   45 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |   33 +
 arch/arm64/include/asm/set_memory.h                |    2 +
 arch/arm64/mm/pageattr.c                           |   16 +
 arch/s390/mm/init.c                                |    2 +-
 drivers/dma-buf/dma-heap.c                         |   56 +
 drivers/dma-buf/heaps/Kconfig                      |    7 +
 drivers/dma-buf/heaps/Makefile                     |    1 +
 drivers/dma-buf/heaps/tegra-vpr.c                  | 1242 ++++++++++++++++++++
 include/linux/bitmap.h                             |   25 +-
 include/linux/cma.h                                |    8 +-
 include/linux/dma-heap.h                           |    2 +
 include/linux/set_memory.h                         |   11 +
 include/trace/events/tegra_vpr.h                   |   57 +
 kernel/dma/contiguous.c                            |    2 +-
 mm/cma.c                                           |  187 ++-
 mm/cma.h                                           |    5 +-
 24 files changed, 1775 insertions(+), 47 deletions(-)
---
base-commit: 703daa6d046136affd69f2a2e08f36ac4a7d5b2c
change-id: 20260507-tegra-vpr-cd4bc2509c4c

Best regards,
--  
Thierry Reding <treding@nvidia.com>

