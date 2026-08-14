Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1DC47D95C;
	Fri, 14 Aug 2026 15:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786721373; cv=none; b=JID7VolZv8DRKUV7TlbD10YMYHhhx1g4l8fU+zbHNUYtxEWETdsc6Gi07FUkEMgpuVLF8l4LFdkDOusa1uq3RgtKvnA6+25ed4FeOPWMVtpvqf4txkuWIQb6zfSWsI1CZOAXafzOEXhEapzV3bVgCt42n0TUOxQYKkNkiowFN2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786721373; c=relaxed/simple;
	bh=gMV7V9QWmW7q2rCHWJwnibTkArPOm6BKbU2U84kG6iI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=OnYEN+8z+fQe/2cpCKmZnRISn/yRMaghk/5U+mpiwZEgboKOUg+nBdfpQnTwQT0GgXFhQoWgMF9Iqa55b4yr3NYa/baAOqivZi4inm951UtwG7oEud4MEcX9mY7GcXfqe+dI6x/wWWhB64Zh22LTP5GlAyv4rgtxBtkaB/QxIx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ALAqGlE6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ALAqGlE6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617441F000E9;
	Fri, 14 Aug 2026 15:29:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786721372;
	bh=I5W/mlaNA8aWWG2YwoTdfe5O742aZlfNS32ROjwlwc0=;
	h=From:Subject:Date:To:Cc;
	b=ALAqGlE6Opa6bTMRjaG/9jXkqDM50K8dsxysIkI/dZQ0G1tjdusXToDszaQ9kOnsx
	 i2sV5ja8B2bSp8UiRz61wIGlEwYtC4kYMG8ZoD3xc4rKD3JdtwY4p6rxopwdf9RCLn
	 DGIQab8BuXX5zl22mUVhmPsJ9SImdpXnUBuUsdNatqugUEHga8mHcMFy54VMv86d09
	 MOXzIHPVpMNzZ8JPTRTJQQBgo/gsHsbUu5qeyhcnkDP7bPowIKcQjurccA4yqALCoP
	 41CshyCkKbLEyLuYj+Qxy5M72u1JYND86tLGmphNkZuuvzIdvQFrQgOy3iOw3uPyLg
	 K1cF43mf/OFIg==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v5 00/10] dma-buf: heaps: Add support for Tegra VPR
Date: Fri, 14 Aug 2026 17:29:08 +0200
Message-Id: <20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2WQQW6DMBBFrxJ5XaOxsY3pKveougB7gGkTEw3Ua
 hRx90KiikZdfum/9zVzExMy4SReDzfBmGmiMa3BvhxEGJrUo6S4ZqFBO7BQyRl7bmS+sAzRtEF
 bqIMJYu1fGDv6vrve3h95+mo/MMybYGsMNM0jX+9jWW29zbsaQCtrXAmFgVLX3kgl54GQ+VowR
 kr9sT83dCrCeBabOutf2IHSWjkFUBeld9Z7/x/+RE54KkbuH3S50xWoPyflUoKMHrqq9ZVqW3N
 MmSI1+7DZUf/0jWxW1FoFUbmm8zU+ocuy/ACApps0awEAAA==
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=4363; i=treding@nvidia.com;
 h=from:subject:message-id; bh=gMV7V9QWmW7q2rCHWJwnibTkArPOm6BKbU2U84kG6iI=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqfzRUshXPvNzGurrRdDa58bB+jm4ijctGMnhc+
 XNyVdMO/5OJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCan80VAAKCRDdI6zXfz6z
 oaK/D/4jGYpr7dHqhpDVoasmIjy66BZEhY1/vby2/UXhJnn1RZ3DLsSwmUT2jMVwAD193uYAJ4s
 LxecgvfXFkObnh3rG8o0a42l10wAnn5+ubRor0y6sIqiyVwxkmZ3WFkRATUlmepjDjtHnBIqEub
 tbntxW+JzTqxHvnmXThnm64LnCtPFK8qq16z5wgJZppkfA6pzSOZqzj/lyFfpk8LFrFPQ/qelKK
 INtyJIALZ6863s4BywHCCZVfQOc69wdZZLKFGbyjPLDU42jtJz7tYNBlY1tdpHb7kZbxcONFi1m
 EY8jfyp4XgF+0cpQC0b4SExqJJKw3KWIXbN3/7MFds1rDlxlUkW7oKN5efSWg9wYN44ufu3s7lZ
 yswICRgoiy3bX4/wruXQUbsKtTGL6yvMfX17x+tEFBOtjkY36V1MewN4VxM9StBYeg/M3FU4SwV
 xnjxEyjtSU7tH9d7qYkfxuYBXyvW3Y1zBfoNN3emdthXOGxD6i28vrBmWJL+A86OsbYV+CqHgvH
 F49TdVi07KGe0BmjR2sGCqQF/GXrLeVvuX+wz+cY3n8hCshLVHQ7ZaIi/nx7RYaZm9TwbLXqVMe
 wUOAN/ugPYrQ+D1s/2qGYHngVs2ACOJ3TYnUTFoDHM+qchzDkiMeT6NZXS4OCspggbtKN+GSTaf
 b4DzNQmznPws98A==
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
allow memory to be allocated at a fixed offset within a CMA area. Tegra
VPR needs this in order to implement its own allocator on top of CMA to
meet the strict hardware requirements. This replaces the dynamic CMA
area creation patch from earlier versions.

Patch 6 adds some infrastructure for DMA heap implementations to provide
information through debugfs.

The Tegra VPR implementation is added in patch 7. See its commit message
for more details about the specifics of this implementation.

Finally, patches 8-10 add the VPR placeholder node on Tegra234 and
Tegra264 and hook it up to the host1x node so that it can make use of
this region.

Changes in v5:
- use a single CMA area in combination with the new cma_alloc_at() API
- drop dynamic CMA area allocation patch
- various cleanups
- Link to v4: https://patch.msgid.link/20260807-tegra-vpr-v4-0-5510d16af89e@nvidia.com

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
      mm/cma: Introduce cma_alloc_at() API
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
 arch/arm64/boot/dts/nvidia/tegra234.dtsi           |   45 +
 arch/arm64/boot/dts/nvidia/tegra264.dtsi           |   33 +
 drivers/dma-buf/dma-heap.c                         |   52 +
 drivers/dma-buf/heaps/Kconfig                      |   12 +
 drivers/dma-buf/heaps/Makefile                     |    1 +
 drivers/dma-buf/heaps/tegra-vpr.c                  | 1410 ++++++++++++++++++++
 include/linux/bitmap.h                             |   25 +-
 include/linux/cma.h                                |    4 +
 include/linux/dma-heap.h                           |    2 +
 include/trace/events/cma.h                         |   63 +
 include/trace/events/tegra_vpr.h                   |   57 +
 mm/cma.c                                           |  148 ++
 18 files changed, 1964 insertions(+), 6 deletions(-)
---
base-commit: 48ae42ae65bf76d723943c717044a09ba6666e56
change-id: 20260507-tegra-vpr-cd4bc2509c4c

Best regards,
--  
Thierry Reding <treding@nvidia.com>

