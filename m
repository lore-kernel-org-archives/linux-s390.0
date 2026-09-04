Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FC146D545;
	Fri,  4 Sep 2026 10:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518721; cv=none; b=jMn2ZtRimc22OcBgSOXTjmeCk+sH0BmwD/1zaP9bjGnPqr2RVf8UD4k7JIlXS3dVK4EajhiLfAuF6frHxHcmWIlOYaIeS2Fj2GiO+CHClzvfrqb14qnhenzBL3hJMjsastthZVFFaLdCnFJTCqHF+GwLRLLIK4/uC+7M6ghqoqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518721; c=relaxed/simple;
	bh=56VMz5vHAxhz+LRAnNs/TniTeXBpTxsK81BlkdKdQFQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=ObFLkVO8jiECLOGYe9AX0wzWn8xCXfRRXWhnryd088TcpRbrt6wcySKk55pXEJprU3Q+WWjMhu+GGrk8+qgvBI73LZMdUEf+rdlR0HDBYj6Q6g/x+YVXErOGPnU0HAzt0AMeNwxX3JFFfGabXkIHoOnWUBM5kv1yDeiqMN4OLII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BALLR90L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BALLR90L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC5731F00A3D;
	Fri,  4 Sep 2026 10:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518718;
	bh=cqzmU3ki12NU7A9MsQeD++1Ge35jyyBd0fg3ah73vk4=;
	h=From:Subject:Date:To:Cc;
	b=BALLR90LQiklf7wRvUntz6hV9ibA9IU37ldiy/b2lr0DHgnfxUshPFPfKoIZpUQac
	 2NIYe949sQbBzLmLQAddAeBccv8aF/vnXwhWrEiU1+v4AkkHf0f1WikP6WTmUAdeu8
	 cMDCIhn9y7YswrVcgVXNKynOHhJHsvFODSSi/LTrxX3U2KKqBKKySNkkzjvyYXcQLx
	 YxTbvhz7STECbXG3TKRHFpnHAAoWRKVg510AXmK2Ywpl19wqrxucjlN/gte+8FpRPG
	 XpNhfZVnbwUYhnWkAv9x0EWl1x6Q9XJhLhK8FMa2YjtTn+49W3lgpAtC8qTRw5Vnpl
	 faSQQCCnrvMmw==
From: Thierry Reding <thierry.reding@kernel.org>
Subject: [PATCH v6 00/12] dma-buf: heaps: Add support for Tegra VPR
Date: Fri, 04 Sep 2026 12:44:51 +0200
Message-Id: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XQ0W6DIBQG4FdpuB7mHATEXfU9ll0IHJWt1QYdW
 dP47sM2iza9/JP/+0/gxiaKgSb2frixSClMYRxy0G8H5vpm6IgHnzMTIDQoqPhMXWx4ukTuvLR
 OKKiddCz3L5Ha8Hvf+vh85OnHfpGb14G10YdpHuP1fizh2lt38wIIVFKXUEgoRW0kRz73gWK8F
 pF8GLpjd27CqXDjma3TSfxjDSgEagSoi9JoZYx5xd8UBzoVY+weutx0Bbh7Uio5cG+grayp0Fp
 5HFLwodkOy42ap99IMlOlEDzqpjU1vVC1oyj3VGVaoSmFVR6E1E90WZY/tLGVgaYBAAA=
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
 Chun Ng <chunn@nvidia.com>, Mark Rutland <mark.rutland@arm.com>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: Thierry Reding <thierry.reding@gmail.com>, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org, 
 dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org, 
 linux-mm@kvack.org, iommu@lists.linux.dev, linaro-mm-sig@lists.linaro.org, 
 linux-trace-kernel@vger.kernel.org, Thierry Reding <treding@nvidia.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=5267; i=treding@nvidia.com;
 h=from:subject:message-id; bh=56VMz5vHAxhz+LRAnNs/TniTeXBpTxsK81BlkdKdQFQ=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE1V2RBeSbaiERM5hkiP3BUdWdEmk8oeAwvr
 DB4qXKfIXyJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhNQAKCRDdI6zXfz6z
 oUAnEACicMN7Orn8rhXBkLGkym+SdqsGrfqanUEAABndk3P8jAL4jPW9sZd8oMfdN7WwRfDGeSS
 2yH8tjJn9mDIBQtCvu9eZqErBbBJXluj+9kDosqusPTGZfNj2bCGTAHWEAlZlHA61YROjnlwl0c
 yi++/TuAmiSx++NIWF9QEnA0GU3ScxjLiDdiT7Vo3Z0iVf3nPwQt6h8y6jDwbq25MQ/vLwldQd3
 YliwIYC8jA/QftAgEZVrjJgPEkJTqdB3TYbRx73m3rQgBfmY9N3DmGlmcWgBhlFdXO2opW8FKwU
 OKWVFabqWMlENHMjpmzJCOFVPyE9TbVGjbawfumEyMl6mTbAUDMefOv3oFDJsG3+AIHz4GXNnJ9
 R4P7DrNg3TaN1JlLAjxz+apP5yQc+Ap05MHlg8HizQLNyJyrAhx5+oY9GIx9UHrVhjA1h3vzes5
 9UVqDKYanfSmRY+dCMCcKLVII5VRVCUD6Vr1T3EslJXmWLjamUlaBa3QdpHIfdTyDt7Sj3IyRjq
 pIEDqUXMhr05l6zFoQugXJ/GrDn8H8CHauucpvvQHekWiNQdj4JPqT7ak+H8XAfOU8fsZxgVLUa
 S3VXZNY7/0ifbaxeLlLVsPPB8dhNB/2MQk9SC5AxQcmuBT04wlrOsl2vmvk9lDT+Qzl0gUMaerq
 s2MsaOD+Z20vWEg==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

This series adds support for the video protection region (VPR) used on
Tegra SoC devices. It's a special region of memory that is protected
from accesses by the CPU and used to store DRM protected content (both
decrypted stream data as well as decoded video frames).

Patches 1 through 3 add DT binding documentation for the VPR and add the
VPR to the list of memory-region items for display, host1x and NVDEC.

The set_direct_map_*_noflush() functions that will be used later in this
series are exported in patch 4 so that the drivers that use them can be
built as a module.

Patch 5 adds bitmap_allocate(), which is like bitmap_allocate_region()
but works on sizes that are not a power of two.

The of_node_to_nid() function is exported in patch 6 because it is used
in a later patch adding a driver that can be built as a module.

Patch 7 introduces new APIs needed by the Tegra VPR implementation that
allow memory to be allocated at a fixed offset within a CMA area. Tegra
VPR needs this in order to implement its own allocator on top of CMA to
meet the strict hardware requirements. This replaces the dynamic CMA
area creation patch from earlier versions.

Patch 8 adds some infrastructure for DMA heap implementations to provide
information through debugfs.

The Tegra VPR implementation is added in patch 9. See its commit message
for more details about the specifics of this implementation.

Finally, patches 10-12 add the VPR placeholder node on Tegra234 and
Tegra264 and hook it up to the host1x node so that it can make use of
this region.

Changes in v6:
- refactor cma_alloc_at() to maximize code reuse
- allow building Tegra VPR support as a module
- requires two new patches to export symbols
- Link to v5: https://patch.msgid.link/20260814-tegra-vpr-v5-0-71832b5d0246@nvidia.com

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
Thierry Reding (12):
      dt-bindings: reserved-memory: Document Tegra VPR
      dt-bindings: display: tegra: Document memory regions
      dt-bindings: gpu: host1x: Document memory-regions for NVDEC
      arm64/mm: Export set_direct_map_*_noflush() APIs
      bitmap: Add bitmap_allocate() function
      of: Export of_node_to_nid()
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
 arch/arm64/mm/pageattr.c                           |    2 +
 drivers/dma-buf/dma-heap.c                         |   52 +
 drivers/dma-buf/heaps/Kconfig                      |   12 +
 drivers/dma-buf/heaps/Makefile                     |   10 +
 drivers/dma-buf/heaps/tegra-vpr-init.c             |  133 +++
 drivers/dma-buf/heaps/tegra-vpr.c                  | 1210 ++++++++++++++++++++
 drivers/dma-buf/heaps/tegra-vpr.h                  |   73 ++
 drivers/of/of_numa.c                               |    1 +
 include/linux/bitmap.h                             |   25 +-
 include/linux/cma.h                                |    4 +
 include/linux/dma-heap.h                           |    2 +
 include/trace/events/cma.h                         |   77 +-
 include/trace/events/tegra_vpr.h                   |   57 +
 mm/cma.c                                           |   88 +-
 22 files changed, 1913 insertions(+), 29 deletions(-)
---
base-commit: 850de4c714df026eb4c869fdb01dd722003e1ae3
change-id: 20260507-tegra-vpr-cd4bc2509c4c

Best regards,
--  
Thierry Reding <treding@nvidia.com>

