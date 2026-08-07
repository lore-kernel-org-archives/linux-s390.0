Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B250647124B;
	Fri,  7 Aug 2026 15:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786118092; cv=none; b=uPJLP02sk+Gh+xosOZ2MKUMGQCTnRuFYsNZMd/EOUsAq4XvixPROWa3LYFUiD65/Axi0VV7e6EyWJrQ3x05/rYjHsOlEYoQxdghG0lNLmssgjz9cza/mL0gX9ebRjM9v727vnr642+Bd8hBkudNhuO2xZTm2XrCIu2/V2BzDqd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786118092; c=relaxed/simple;
	bh=cNpFkM+ZcxbrYyXoZiVbDg/M+vrbqp/SW9+T2kNjvg8=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=EA1tPNQbJ5Ou4en8qQMiBvD8VfFD63Aj8gfQEPBqd64x5ypLGb1ypFKKWORhHLG5qKyKLEvvno6H19fFA5IjYS/xs8qoxJLrVM/pEOf1F/jXhDi/ktjqlKHzCkf+NZLJUtWJjaW+k4vcx5bTF7GZU0rE7GNfPy11yMLhkVOHg8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RFetetgo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RFetetgo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92E8D1F000E9;
	Fri,  7 Aug 2026 15:54:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786118090;
	bh=xDlurFDxUaKm0+DeKwG11I5Asqll1HaQOs3bWTM7T2A=;
	h=From:Subject:Date:To:Cc;
	b=RFetetgo7jgxk2hRoVBNP2thvqE1EPEabTG4g4lH092YzQbD/Odq965rNejDzleVE
	 J3ckOBjT8nkXZ3wNy9Nx4RPTK6m+askAC7z4QSWoQpfG4MxebffJpKPmv69UDX+6OL
	 iEVDLsrFQqAMjC3zb8GatM7NAYAeBLlhnRtZ8Mcce5gdM7SrXJqHkgyYk7Or7MAkVf
	 1v73+4+H/NMIykEPIocARawL6LBt2xLJEDW2wFY+w7Ljr85NJJJx0OjEEz4tm8uqs7
	 VRYlNv+S0gcff4TM8qKclQrd/ETGd8YPtZJh6hMl1H2rsh9+vs6QAXsneltbsqhXC2
	 1o0k2EvBe+C8g==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v4 00/10] dma-buf: heaps: Add support for Tegra VPR
Date: Fri, 07 Aug 2026 17:54:20 +0200
Message-Id: <20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WPwWrDMBBEfyXoXImVLNtyTvmP0oMtb+RtEzmsX
 NEQ/O+1YkoLPQ7Me8M8REImTOJ4eAjGTInmuAX7chB+6mNASeOWhQHTQA2tXDBwL/ONpR/t4E0
 NnbdebP0b45m+nq7Xtz2nz+Ed/VIEpTFRWma+P8eyLr3i3QxgdG2bCpSFynTOSi2XiZD5rhhHi
 uEUrj1dlJ+voqiz+YEb0MboRgN0qnJN7Zz7D38gR7yomcNOV790C/rPpVxJkKODczu4Vg+DPcV
 MI/X78Lqu36G64F8wAQAA
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
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
 Chun Ng <chunn@nvidia.com>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4495; i=treding@nvidia.com;
 h=from:subject:message-id; bh=cNpFkM+ZcxbrYyXoZiVbDg/M+vrbqp/SW9+T2kNjvg8=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqdf/COeJXZyRFVSTKd7+3r7oFtNF7xrGETRn4j
 DEXKT18h/KJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCanX/wgAKCRDdI6zXfz6z
 oX86EACf3u52ZHWbNE0gzPHk1VCKvHipIKLbzawEbY/eyFL+F3hj0f1oRk5u22tUVgR+XqqdgdU
 gwYJjdIxng+xk3RWveQ2oBaMIzwMJwiykwHMNXFjTMWO7RYuWiz8hLNjGRNX/h6RZRGUa7rSqpc
 ODAcuSqcvfgjqo//n+HcYlrTTme0RgMivbMPVwq/G7KLmDX/7m9mryCILkoR90jXSg0Ha1q8HLM
 DxVa1dmvxpWECDYJU/uizu1XpnO9zKnxwMgHpyNwRTaajqkRB0AOGV1CbZ9mYSFbu1bp5IKwk7e
 SwqEJxq9caikk5y6VUtj3udpbhhJkLqmgyQ1iRROgJ4Jdb0YGfmaMfcI7gpMADo9riMISSZ7BPb
 KBLw3THjD8cjbJl9FeEgiiSWvZce1TCAZEfduXqjJNI9lLl1gpIz2Zz7JyN9gcDPYyjetrj3bFP
 gOOJKTnB7mY4la1dVjl1x5RLq36hdfJhFvabG6qYclCsmQFgU17Oh/nbgiQtV/5S1wQgX5h4KJa
 TiAbSxXHoiN+eL+PJL+Rx5bz5TEcblTUMPK+ub7afb3I9XHkM65Yaj/dE8ZVfmeviLNuhQktuAf
 WXcrW3LRRxZH1TZWTSGjJwaUEcgrGaBx3zUoiECwB7n/9GpOfYfGp4P0FwZ4bqQ9EiWbyjmX1dC
 fksdo8Ciavc0KLw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

This series adds support for the video protection region (VPR) used on
Tegra SoC devices. It's a special region of memory that is protected
from accesses by the CPU and used to store DRM protected content (both
decrypted stream data as well as decoded video frames).

Patches 1 through 3 add DT binding documentation for the VPR and add the
VPR to the list of memory-region items for display, host1x and NVDEC.

Patch 4 adds bitmap_allocate(), which is like bitmap_allocate_region()
but works on sizes that are not a power of two.

Patch 5 introduces new APIs needed by the Tegra VPR implementation that
allow CMA areas to be dynamically created at runtime rather than using
the fixed, system-wide list. This is used in this driver specifically
because it can use an arbitrary number of these areas (though they are
currently limited to 4).

Patch 6 adds some infrastructure for DMA heap implementations to provide
information through debugfs.

The Tegra VPR implementation is added in patch 7. See its commit message
for more details about the specifics of this implementation.

Finally, patches 8-10 add the VPR placeholder node on Tegra234 and
Tegra264 and hook it up to the host1x node so that it can make use of
this region.

Changes in v4:
- Link to v3: https://patch.msgid.link/20260701-tegra-vpr-v3-0-d80f7b871bb4@nvidia.com
- fully remove from linear map while chunks are active
- address checkpatch.pl and Sashiko comments
- improve error handling
- remove freezer support

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
 .../nvidia,tegra-video-protection-region.yaml      |   75 ++
 arch/arm/mm/dma-mapping.c                          |    2 +-
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   45 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |   33 +
 arch/s390/mm/init.c                                |    2 +-
 drivers/dma-buf/dma-heap.c                         |   56 +
 drivers/dma-buf/heaps/Kconfig                      |   12 +
 drivers/dma-buf/heaps/Makefile                     |    1 +
 drivers/dma-buf/heaps/tegra-vpr.c                  | 1368 ++++++++++++++++++++
 include/linux/bitmap.h                             |   25 +-
 include/linux/cma.h                                |    8 +-
 include/linux/dma-heap.h                           |    2 +
 include/trace/events/tegra_vpr.h                   |   57 +
 kernel/dma/contiguous.c                            |    2 +-
 mm/cma.c                                           |  221 +++-
 mm/cma.h                                           |    5 +-
 mm/cma_debug.c                                     |    6 +-
 mm/cma_sysfs.c                                     |    6 +-
 mm/mm_init.c                                       |    4 +-
 24 files changed, 1912 insertions(+), 61 deletions(-)
---
base-commit: a6cebf4799ccfd3ea08e45abe5360414fd3822e1
change-id: 20260507-tegra-vpr-cd4bc2509c4c

Best regards,
--  
Thierry Reding <treding@nvidia.com>

