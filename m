Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 773A448094F;
	Fri,  4 Sep 2026 10:45:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788518749; cv=none; b=KoQVulTqeixTuL/2KqBkJDYbdOqVviD/vbI70EA9EyVyS5RCO4AqOnR/LF0CRmxXxV1g3QDX+SE8FPyoJbV0RpXqHqvU3u8MMRpXjT5wumvFoVBRFjtuebWtwFO7icAavsyeLVMYlC/cBHJg+zyUlMbI2Wamzp/JVNDzZgRNzwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788518749; c=relaxed/simple;
	bh=4UQGsKse/1XBGbINJ3ESIk5UgeXQqJVDZzbrPp1+deA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=j97yF5PxqcJpnco+bXqTQMkK+G7buNgdhKUH9A/5iIdrLAydTCPmbiR6SfTZ2Z3JTrv063C0QLYipsgCoANju3jFG2+Zj3xtJnhw7r3d+F/MdXqSXR8cLjC9+ZYfVRc7ue9lDw+N/f0+PUg29jed1OzG44B0hHUIJW4ztMaBxwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DjYLlOOR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DjYLlOOR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4E031F00A3F;
	Fri,  4 Sep 2026 10:45:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788518743;
	bh=W6722AL723dTuRkbTw9SUzwXfCeSFvC8MFbz4kro58I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=DjYLlOORHXEZyuvETbwNAZlzHsltEB0E0/EjTVoqKYboy0sC3AZx0Z9hQhrk1eYAp
	 u2KNTNAhKdtXZjnygmobaUTUXVmxDLuc3WucWrEKvIibqt4c3vH1ZNe6H4r8ArWT0O
	 zy6QHY3diu4qLN6E3cie9dC+WEQ3MBWSwiMBtPFvPqaf63TFxjrDcEbgQWnh08PBFh
	 rRxdG9LUTACzbPvA0Leqo2MBphIA2STnEYYUNvRHb3h6xfYsyAn8AI/0U6xXQ/7/3/
	 R0cmfUfd0nf/LzL4VIEZcwunWBCKgJCiy1gZajDZvzbL/iZQJuFn+vi8nvBYrRFaHK
	 YS+kHCxXgdQGw==
From: Thierry Reding <thierry.reding@kernel.org>
Date: Fri, 04 Sep 2026 12:45:00 +0200
Subject: [PATCH v6 09/12] dma-buf: heaps: Add support for Tegra VPR
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260904-tegra-vpr-v6-9-79042cfa8de5@nvidia.com>
References: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
In-Reply-To: <20260904-tegra-vpr-v6-0-79042cfa8de5@nvidia.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=43445; i=treding@nvidia.com;
 h=from:subject:message-id; bh=ynUqNDTHBxqZaJRROW/jrpxxVutbil/TJP/xhH6ufvc=;
 b=owEBbQKS/ZANAwAKAd0jrNd/PrOhAcsmYgBqmqE7CWSkt7JwLLhGoopsId2jWiVLEa9G3XMF5
 QDKVWEaTwuJAjMEAAEKAB0WIQSI6sMIAUnM98CNyJ/dI6zXfz6zoQUCapqhOwAKCRDdI6zXfz6z
 oSbHEACTbt07quMSZ6mk7p9sokKQDXAOFNTY2XgsHUNRibWp82NGsiwzZHl/aEkzmdRPYHeLzJU
 mNvdZn54nplMPAxYKQkXAWQGXaoytvDlm7kVr8XxZC+ABLHWl24aVaggaNaROmyTVNqhdxtCawA
 zt96AYR4LDWG453K2gvxQpuvcrRuHz3nfhsKiSMoLSINfAasm44+jPc0jqCYoaMvouIQnqyA+yH
 UWSV4AYVCmX9jHleGXYZqbv8b/gg4e2LKKoWNISH6axwNQAs8MFhS9Cz84ILkAFO83WCRV5sEfP
 X295Duz2ZaqqY7DCCmojV9ntNA3Tc+jwguBgMthJDhinppgAPvmWrygydkuweMPD62HZzFGMAlF
 ghmEuEk1/c8Ap4/RGsNApzkHLAra5vBtnfUALnRaXr5xypuKYMKgg0SoBNoqZJ2/ojb/FfHxdt1
 aj7gk0cs0xxI+LYednEChrzyMKNSGekPoUQcpkIxgMYooD52AQu77v3jOanEnb8ADUoySjKHSlG
 WGXXThhEd4cCLkuKpPjKiwEpBYkWuKQ/ZVMHSwouV+PH83FfRChAjvmK+8zPchGL/xuoqG9zdS4
 +gMDv5cGwD0q8F3qlkpnskhIdak3MnEQ2HWQAk1PAFW1mOWhz6TIu7b0iUZE27k0wpF7+lmfGnY
 ORusTDsXl7CzdMw==
X-Developer-Key: i=treding@nvidia.com; a=openpgp;
 fpr=88EAC3080149CCF7C08DC89FDD23ACD77F3EB3A1

From: Thierry Reding <treding@nvidia.com>

NVIDIA Tegra SoCs commonly define a Video-Protection-Region, which is a
region of memory dedicated to content-protected video decode and
playback. This memory cannot be accessed by the CPU and only certain
hardware devices have access to it.

Expose the VPR as a DMA heap so that applications and drivers can
allocate buffers from this region for use-cases that require this kind
of protected memory.

VPR has a few very critical peculiarities. First, it must be a single
contiguous region of memory (there is a single pair of registers that
set the base address and size of the region), which is configured by
calling back into the secure monitor. The memory region also needs to
quite large for some use-cases because it needs to fit multiple video
frames (8K video should be supported), so VPR sizes of ~2 GiB are
expected. However, some devices cannot afford to reserve this amount
of memory for a particular use-case, and therefore the VPR must be
resizable.

Unfortunately, resizing the VPR is slightly tricky because the GPU found
on Tegra SoCs must be in reset during the VPR resize operation. This is
currently implemented by freezing all userspace processes and calling
invoking the GPU's freeze() implementation, resizing and the thawing the
GPU and userspace processes. This is quite heavy-handed, so eventually
it might be better to implement thawing/freezing in the GPU driver in
such a way that they block accesses to the GPU so that the VPR resize
operation can happen without suspending all userspace.

In order to balance the memory usage versus the amount of resizing that
needs to happen, the VPR is divided into multiple chunks. Each chunk is
implemented as a section of the CMA area that is completely allocated on
first use to guarantee the contiguity of the VPR. Once all buffers from
a chunk have been freed, the subsection is freed and the memory returned
to the system.

The Tegra VPR driver is split into two pieces: one tiny part of the
driver is always built-in and sets up the CMA area during early boot,
whereas the second, larger, part provides the DMA heap implementation
and can be built as a module. Note that tearing down VPR is tricky and
usually not necessary, so it can currently not be unloaded.

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
Changes in v6:
- split code into a small core and the main chunk so the latter can be
  built as a module

Changes in v5:
- use newly introduced cma_alloc_at() and work with a single CMA area
- setup CMA early and initialize VPR later during boot
- remove some unused variables
- use kalloc_objs()

Changes in v4:
- address Sashiko and checkpatch comments
- fully remove from linear map while chunks are allocated
- improve error handling
- remove freezer support

Changes in v3:
- use set_memory_device() and set_memory_normal() helpers
- use kzalloc_obj() instead of kzalloc() with sizeof()

Changes in v2:
- cluster allocations to reduce the number of resize operations
- support cross-chunk allocation
---
 drivers/dma-buf/heaps/Kconfig          |   12 +
 drivers/dma-buf/heaps/Makefile         |   10 +
 drivers/dma-buf/heaps/tegra-vpr-init.c |  133 ++++
 drivers/dma-buf/heaps/tegra-vpr.c      | 1210 ++++++++++++++++++++++++++++++++
 drivers/dma-buf/heaps/tegra-vpr.h      |   73 ++
 include/trace/events/tegra_vpr.h       |   57 ++
 6 files changed, 1495 insertions(+)

diff --git a/drivers/dma-buf/heaps/Kconfig b/drivers/dma-buf/heaps/Kconfig
index bb729e91545c..28d2c0800fb5 100644
--- a/drivers/dma-buf/heaps/Kconfig
+++ b/drivers/dma-buf/heaps/Kconfig
@@ -20,3 +20,15 @@ config DMABUF_HEAPS_CMA
 	  Choose this option to enable dma-buf CMA heap. This heap is backed
 	  by the Contiguous Memory Allocator (CMA). If your system has these
 	  regions, you should say Y here.
+
+config DMABUF_HEAPS_TEGRA_VPR
+	tristate "NVIDIA Tegra Video-Protected-Region DMA-BUF Heap"
+	depends on DMABUF_HEAPS && DMA_CMA
+	help
+	  Choose this option to enable Video-Protected-Region (VPR) support on
+	  a range of NVIDIA Tegra devices. Access to VPR memory is limited to
+	  a subset of hardware engines and specifically disallowed from the
+	  CPU. The region can be fixed, in which case no linear mapping exists
+	  for the memory, or it can be resizable on systems that want to reuse
+	  the memory for other uses when content-protected video is not played
+	  back.
diff --git a/drivers/dma-buf/heaps/Makefile b/drivers/dma-buf/heaps/Makefile
index 974467791032..481fcb78f757 100644
--- a/drivers/dma-buf/heaps/Makefile
+++ b/drivers/dma-buf/heaps/Makefile
@@ -1,3 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_DMABUF_HEAPS_SYSTEM)	+= system_heap.o
 obj-$(CONFIG_DMABUF_HEAPS_CMA)		+= cma_heap.o
+
+#
+# The reserved-memory bits always need to be built-in so that the CMA
+# initialization runs during early boot. The VPR driver itself can be
+# built as a module.
+#
+ifneq ($(CONFIG_DMABUF_HEAPS_TEGRA_VPR),)
+obj-y					+= tegra-vpr-init.o
+obj-$(CONFIG_DMABUF_HEAPS_TEGRA_VPR)	+= tegra-vpr.o
+endif
diff --git a/drivers/dma-buf/heaps/tegra-vpr-init.c b/drivers/dma-buf/heaps/tegra-vpr-init.c
new file mode 100644
index 000000000000..65e917713c6d
--- /dev/null
+++ b/drivers/dma-buf/heaps/tegra-vpr-init.c
@@ -0,0 +1,133 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMA-BUF restricted heap exporter for NVIDIA Video-Protection-Region (VPR)
+ *
+ * Copyright (C) 2024-2026 NVIDIA Corporation
+ */
+
+#define pr_fmt(fmt) "tegra-vpr: " fmt
+
+#include "tegra-vpr.h"
+
+#include <linux/cma.h>
+#include <linux/of_reserved_mem.h>
+
+static DEFINE_MUTEX(vpr_lock);
+static LIST_HEAD_GUARDED(vpr_list, vpr_lock);
+
+static int __init tegra_vpr_node_init(unsigned long offset,
+				      struct reserved_mem *rmem)
+{
+	struct cma *cma;
+	int err;
+
+	if (!IS_ALIGNED(rmem->base, SZ_1M)) {
+		pr_err("%s: base is not aligned to 1 MiB\n", rmem->name);
+		return -EINVAL;
+	}
+
+	if (!IS_ALIGNED(rmem->size, SZ_1M)) {
+		pr_err("%s: size is not aligned to 1 MiB\n", rmem->name);
+		return -EINVAL;
+	}
+
+	err = cma_init_reserved_mem(rmem->base, rmem->size, 0, rmem->name,
+				    &cma);
+	if (err < 0) {
+		pr_err("%s: failed to initialize CMA: %d\n", __func__, err);
+		return err;
+	}
+
+	rmem->priv = cma;
+
+	return 0;
+}
+
+static struct tegra_vpr *tegra_vpr_lookup(struct cma *cma)
+{
+	struct tegra_vpr *vpr;
+
+	mutex_lock(&vpr_lock);
+
+	list_for_each_entry(vpr, &vpr_list, list) {
+		if (vpr->cma == cma) {
+			mutex_unlock(&vpr_lock);
+			return vpr;
+		}
+	}
+
+	mutex_unlock(&vpr_lock);
+
+	return ERR_PTR(-EPROBE_DEFER);
+}
+
+static int tegra_vpr_device_init(struct reserved_mem *rmem, struct device *dev)
+{
+	const struct dev_pm_ops *pm = dev->driver->pm;
+	struct tegra_vpr_device *node;
+	struct cma *cma = rmem->priv;
+	struct tegra_vpr *vpr;
+
+	vpr = tegra_vpr_lookup(cma);
+	if (IS_ERR(vpr))
+		return PTR_ERR(vpr);
+
+	if (!pm || !pm->freeze || !pm->thaw)
+		return -EINVAL;
+
+	node = kzalloc_obj(*node, GFP_KERNEL);
+	if (!node)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&node->node);
+	node->dev = dev;
+
+	mutex_lock(&vpr->lock);
+	list_add_tail(&node->node, &vpr->devices);
+	mutex_unlock(&vpr->lock);
+
+	return 0;
+}
+
+static void tegra_vpr_device_release(struct reserved_mem *rmem,
+				     struct device *dev)
+{
+	struct tegra_vpr_device *node, *tmp;
+	struct cma *cma = rmem->priv;
+	struct tegra_vpr *vpr;
+
+	vpr = tegra_vpr_lookup(cma);
+	if (IS_ERR(vpr)) {
+		dev_WARN(dev, "failed to find VPR for CMA '%s'\n",
+			 cma_get_name(cma));
+		return;
+	}
+
+	mutex_lock(&vpr->lock);
+
+	list_for_each_entry_safe(node, tmp, &vpr->devices, node) {
+		if (node->dev == dev) {
+			list_del(&node->node);
+			kfree(node);
+		}
+	}
+
+	mutex_unlock(&vpr->lock);
+}
+
+static const struct reserved_mem_ops tegra_vpr_rmem_ops = {
+	.node_init = tegra_vpr_node_init,
+	.device_init = tegra_vpr_device_init,
+	.device_release = tegra_vpr_device_release,
+};
+
+RESERVEDMEM_OF_DECLARE(tegra_vpr, "nvidia,tegra-video-protection-region",
+		       &tegra_vpr_rmem_ops);
+
+void tegra_vpr_add(struct tegra_vpr *vpr)
+{
+	mutex_lock(&vpr_lock);
+	list_add_tail(&vpr->list, &vpr_list);
+	mutex_unlock(&vpr_lock);
+}
+EXPORT_SYMBOL(tegra_vpr_add);
diff --git a/drivers/dma-buf/heaps/tegra-vpr.c b/drivers/dma-buf/heaps/tegra-vpr.c
new file mode 100644
index 000000000000..d8cff7e07ea0
--- /dev/null
+++ b/drivers/dma-buf/heaps/tegra-vpr.c
@@ -0,0 +1,1210 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * DMA-BUF restricted heap exporter for NVIDIA Video-Protection-Region (VPR)
+ *
+ * Copyright (C) 2024-2026 NVIDIA Corporation
+ */
+
+#define pr_fmt(fmt) "tegra-vpr: " fmt
+
+#include <linux/arm-smccc.h>
+#include <linux/cma.h>
+#include <linux/debugfs.h>
+#include <linux/dma-buf.h>
+#include <linux/dma-heap.h>
+#include <linux/find.h>
+#include <linux/memory.h>
+#include <linux/of_reserved_mem.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/reset.h>
+#include <linux/set_memory.h>
+
+#include "tegra-vpr.h"
+
+MODULE_IMPORT_NS("DMA_BUF_HEAP");
+MODULE_IMPORT_NS("DMA_BUF");
+
+#define CREATE_TRACE_POINTS
+#include <trace/events/tegra_vpr.h>
+
+#define TEGRA_VPR_MAX_CHUNKS 64
+
+struct tegra_vpr_buffer {
+	struct list_head attachments;
+	struct tegra_vpr *vpr;
+	struct list_head list;
+
+	/**
+	 * @lock: Protects concurrent access to the list of attachments.
+	 */
+	struct mutex lock;
+
+	struct page **pages;
+	pgoff_t num_pages;
+	phys_addr_t start;
+	phys_addr_t limit;
+	size_t size;
+	int pageno;
+	int order;
+
+	DECLARE_BITMAP(chunks, TEGRA_VPR_MAX_CHUNKS);
+};
+
+struct tegra_vpr_attachment {
+	struct device *dev;
+	struct sg_table sgt;
+	struct list_head list;
+};
+
+#define ARM_SMCCC_TE_FUNC_PROGRAM_VPR 0x3
+
+#define ARM_SMCCC_VENDOR_SIP_TE_PROGRAM_VPR_FUNC_ID		\
+	ARM_SMCCC_CALL_VAL(ARM_SMCCC_FAST_CALL,			\
+			   ARM_SMCCC_SMC_32,			\
+			   ARM_SMCCC_OWNER_SIP,			\
+			   ARM_SMCCC_TE_FUNC_PROGRAM_VPR)
+
+static int tegra_vpr_set(phys_addr_t base, phys_addr_t size)
+{
+	struct arm_smccc_res res;
+
+	arm_smccc_smc(ARM_SMCCC_VENDOR_SIP_TE_PROGRAM_VPR_FUNC_ID, base, size,
+		      0, 0, 0, 0, 0, &res);
+
+	return res.a0;
+}
+
+static int tegra_vpr_get_extents(struct tegra_vpr *vpr, phys_addr_t *base,
+				 phys_addr_t *size)
+{
+	phys_addr_t start = ~0, limit = 0;
+	unsigned int i;
+
+	for (i = 0; i < vpr->num_chunks; i++) {
+		struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+		if (chunk->active) {
+			if (chunk->start < start)
+				start = chunk->start;
+
+			if (chunk->limit > limit)
+				limit = chunk->limit;
+		}
+	}
+
+	if (limit > start) {
+		*size = limit - start;
+		*base = start;
+	} else {
+		*base = *size = 0;
+	}
+
+	return 0;
+}
+
+static int tegra_vpr_resize(struct tegra_vpr *vpr)
+{
+	struct tegra_vpr_device *node;
+	phys_addr_t base, size;
+	int err, status = 0;
+
+	err = tegra_vpr_get_extents(vpr, &base, &size);
+	if (err < 0) {
+		pr_err("%s(): failed to get VPR extents: %d\n", __func__, err);
+		return err;
+	}
+
+	list_for_each_entry(node, &vpr->devices, node) {
+		err = pm_generic_freeze(node->dev);
+		if (err < 0) {
+			pr_err("failed to freeze %s: %d\n",
+			       dev_name(node->dev), err);
+			status = err;
+			goto thaw;
+		}
+	}
+
+	trace_tegra_vpr_set(base, size);
+
+	err = tegra_vpr_set(base, size);
+	if (err < 0) {
+		pr_err("failed to secure VPR: %d\n", err);
+		status = err;
+	}
+
+thaw:
+	list_for_each_entry_continue_reverse(node, &vpr->devices, node) {
+		err = pm_generic_thaw(node->dev);
+		if (err < 0) {
+			pr_err("failed to thaw %s: %d\n",
+			       dev_name(node->dev), err);
+			continue;
+		}
+	}
+
+	return status;
+}
+
+static int tegra_vpr_chunk_init(struct tegra_vpr *vpr,
+				struct tegra_vpr_chunk *chunk,
+				phys_addr_t start, size_t size,
+				unsigned int order, const char *name)
+{
+	chunk->start = start;
+	chunk->limit = start + size;
+	chunk->size = size;
+	chunk->vpr = vpr;
+
+	chunk->offset = (start - vpr->base) >> PAGE_SHIFT;
+	chunk->num_pages = size >> PAGE_SHIFT;
+	chunk->num_buffers = 0;
+
+	/* CMA area is not reserved yet */
+	chunk->start_page = NULL;
+	chunk->virt = 0;
+
+	return 0;
+}
+
+static void tegra_vpr_chunk_free(struct tegra_vpr_chunk *chunk)
+{
+}
+
+static inline bool tegra_vpr_chunk_is_last(const struct tegra_vpr_chunk *chunk)
+{
+	phys_addr_t limit = chunk->vpr->base + chunk->vpr->size;
+
+	return chunk->limit == limit;
+}
+
+static inline bool tegra_vpr_chunk_is_leaf(const struct tegra_vpr_chunk *chunk)
+{
+	const struct tegra_vpr_chunk *next = chunk + 1;
+
+	if (tegra_vpr_chunk_is_last(chunk))
+		return true;
+
+	return !next->active;
+}
+
+static int tegra_vpr_chunk_alloc(struct tegra_vpr_chunk *chunk)
+{
+	chunk->start_page = cma_alloc_at(chunk->vpr->cma, chunk->offset,
+					 chunk->num_pages, false);
+	if (!chunk->start_page)
+		return -ENOMEM;
+
+	chunk->virt = (unsigned long)page_to_virt(chunk->start_page);
+
+	return 0;
+}
+
+static int tegra_vpr_chunk_activate(struct tegra_vpr_chunk *chunk)
+{
+	int err;
+
+	trace_tegra_vpr_chunk_activate(chunk->start, chunk->limit);
+
+	err = set_direct_map_invalid_noflush(chunk->start_page,
+					     chunk->num_pages);
+	if (err)
+		return err;
+
+	flush_tlb_kernel_range(chunk->virt, chunk->virt + chunk->size);
+	chunk->invalid = false;
+	chunk->active = true;
+
+	return 0;
+}
+
+static int tegra_vpr_chunk_deactivate(struct tegra_vpr_chunk *chunk)
+{
+	int err;
+
+	if (!chunk->active)
+		return 0;
+
+	/* do not deactivate if there are buffers left in this chunk */
+	if (WARN_ON(chunk->num_buffers > 0))
+		return -EBUSY;
+
+	trace_tegra_vpr_chunk_deactivate(chunk->start, chunk->limit);
+
+	err = set_direct_map_default_noflush(chunk->start_page,
+					     chunk->num_pages);
+	if (err)
+		return err;
+
+	flush_tlb_kernel_range(chunk->virt, chunk->virt + chunk->size);
+	chunk->invalid = false;
+	chunk->active = false;
+
+	return 0;
+}
+
+static void tegra_vpr_chunk_release(struct tegra_vpr_chunk *chunk)
+{
+	if (!WARN_ON(chunk->active || chunk->invalid)) {
+		cma_release(chunk->vpr->cma, chunk->start_page,
+			    chunk->num_pages);
+		chunk->start_page = NULL;
+		chunk->virt = 0;
+	}
+}
+
+static bool tegra_vpr_chunk_overlaps(struct tegra_vpr_chunk *chunk,
+				     unsigned int start, unsigned int limit)
+{
+	unsigned int first = chunk->offset;
+	unsigned int last = chunk->offset + chunk->num_pages - 1;
+
+	if (last < start || first >= limit)
+		return false;
+
+	return true;
+}
+
+static int tegra_vpr_activate_chunks(struct tegra_vpr *vpr,
+				     struct tegra_vpr_buffer *buffer)
+{
+	DECLARE_BITMAP(dirty, vpr->num_chunks);
+	unsigned int i, bottom, top;
+	int err = 0, ret;
+
+	bitmap_zero(dirty, vpr->num_chunks);
+
+	/* activate any inactive chunks that overlap this buffer */
+	for_each_set_bit(i, buffer->chunks, vpr->num_chunks) {
+		struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+		if (chunk->active)
+			continue;
+
+		err = tegra_vpr_chunk_alloc(chunk);
+		if (err < 0)
+			goto deactivate;
+
+		err = tegra_vpr_chunk_activate(chunk);
+		if (err < 0) {
+			tegra_vpr_chunk_release(chunk);
+			goto deactivate;
+		}
+
+		set_bit(i, vpr->active);
+		set_bit(i, dirty);
+	}
+
+	/*
+	 * Activating chunks above may have created holes, but since the VPR
+	 * can only ever be a single contiguous region, make sure to activate
+	 * any missing chunks.
+	 */
+	for_each_clear_bitrange(bottom, top, vpr->active, vpr->num_chunks) {
+		/* inactive chunks at the bottom or the top are harmless */
+		if (bottom == 0 || top == vpr->num_chunks)
+			continue;
+
+		for (i = bottom; i < top; i++) {
+			struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+			err = tegra_vpr_chunk_alloc(chunk);
+			if (err < 0)
+				goto deactivate;
+
+			err = tegra_vpr_chunk_activate(chunk);
+			if (err < 0) {
+				tegra_vpr_chunk_release(chunk);
+				goto deactivate;
+			}
+
+			set_bit(i, vpr->active);
+			set_bit(i, dirty);
+		}
+	}
+
+	/* if any chunks have been activated, VPR needs to be resized */
+	if (!bitmap_empty(dirty, vpr->num_chunks)) {
+		err = tegra_vpr_resize(vpr);
+		if (err < 0) {
+			pr_err("failed to grow VPR: %d\n", err);
+			goto deactivate;
+		}
+	}
+
+	/* increment buffer count for each chunk */
+	for_each_set_bit(i, buffer->chunks, vpr->num_chunks)
+		vpr->chunks[i].num_buffers++;
+
+	return 0;
+
+deactivate:
+	/* deactivate any of the previously inactive chunks on failure */
+	for_each_set_bit(i, dirty, vpr->num_chunks) {
+		struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+		ret = tegra_vpr_chunk_deactivate(chunk);
+		if (WARN_ON(ret < 0)) {
+			pr_err("failed to deactivate chunk #%u: %d\n", i, ret);
+		} else {
+			tegra_vpr_chunk_release(chunk);
+			clear_bit(i, vpr->active);
+		}
+	}
+
+	return err;
+}
+
+/*
+ * Retrieve the range of pages within the activate region of the VPR.
+ */
+static bool tegra_vpr_get_active_range(struct tegra_vpr *vpr,
+				       unsigned int *first,
+				       unsigned int *last)
+{
+	unsigned long i, j;
+
+	i = find_first_bit(vpr->active, vpr->num_chunks);
+	if (i >= vpr->num_chunks)
+		return false;
+
+	j = find_last_bit(vpr->active, vpr->num_chunks);
+	if (j >= vpr->num_chunks)
+		return false;
+
+	*first = vpr->chunks[i].offset;
+	*last = vpr->chunks[j].offset + vpr->chunks[j].num_pages;
+
+	return true;
+}
+
+/*
+ * Try to find and allocate a free region within a specific page range.
+ * Returns the page number if successful, -ENOSPC otherwise.
+ *
+ * This function mimics bitmap_find_free_region() but restricts the search
+ * to a specific range to enable allocation within individual chunks.
+ */
+static int tegra_vpr_find_free_region_in_range(struct tegra_vpr *vpr,
+					       unsigned int start_page,
+					       unsigned int end_page,
+					       unsigned int num_pages,
+					       unsigned int align)
+{
+	unsigned int pos, next = ALIGN(start_page, align);
+
+	/* Scan through aligned positions, trying to allocate at each one */
+	for (pos = next; pos + num_pages <= end_page; pos = next) {
+		next = find_next_bit(vpr->bitmap, pos + num_pages, pos);
+
+		if (next >= pos + num_pages) {
+			bitmap_set(vpr->bitmap, pos, num_pages);
+			return pos;
+		}
+
+		next = find_next_zero_bit(vpr->bitmap, vpr->num_pages, next);
+		next = ALIGN(next, align);
+	}
+
+	return -ENOSPC;
+}
+
+static int tegra_vpr_find_free_region(struct tegra_vpr *vpr,
+				      unsigned int num_pages,
+				      unsigned long align)
+{
+	return tegra_vpr_find_free_region_in_range(vpr, 0, vpr->num_pages - 1,
+						   num_pages, align);
+}
+
+static int tegra_vpr_find_free_region_clustered(struct tegra_vpr *vpr,
+						unsigned int num_pages,
+						unsigned int align)
+{
+	unsigned int target, first, last;
+	int pageno;
+
+	/*
+	 * If there are no allocations, abort the clustered allocation scheme
+	 * and use the generic allocation scheme instead.
+	 */
+	if (vpr->first > vpr->last)
+		return -ENOSPC;
+
+	/*
+	 * First, try to allocate within the currently allocated region. This
+	 * keeps allocations tightly packed and minimizes the VPR size needed.
+	 */
+	pageno = tegra_vpr_find_free_region_in_range(vpr, vpr->first,
+						     vpr->last + 1, num_pages,
+						     align);
+	if (pageno >= 0)
+		return pageno;
+
+	/*
+	 * If not enough free space exists within the currently allocated
+	 * region, check to see if the allocation fits anywhere within the
+	 * active region, avoiding the need to resize the VPR.
+	 */
+	if (tegra_vpr_get_active_range(vpr, &first, &last)) {
+		pageno = tegra_vpr_find_free_region_in_range(vpr, first, last,
+							     num_pages, align);
+		if (pageno >= 0)
+			return pageno;
+	}
+
+	/*
+	 * If not enough free space exists within the currently active region,
+	 * try to allocate adjacent to it to grow it contiguously and ensure
+	 * optimal packing.
+	 */
+
+	/*
+	 * Calculate where the allocation should start to end right at the
+	 * first allocated page, with proper alignment.
+	 */
+	if (vpr->first >= num_pages) {
+		target = ALIGN_DOWN(vpr->first - num_pages, align);
+
+		if (!bitmap_allocate(vpr->bitmap, target, num_pages))
+			return target;
+	}
+
+	/* Try after the last allocation */
+	target = ALIGN(vpr->last + 1, align);
+
+	if (target + num_pages <= vpr->num_pages &&
+	    !bitmap_allocate(vpr->bitmap, target, num_pages))
+		return target;
+
+	/*
+	 * Couldn't allocate at the ideal adjacent position, search for any
+	 * available space before the first allocated page.
+	 */
+	pageno = tegra_vpr_find_free_region_in_range(vpr, 0, vpr->first,
+						     num_pages, align);
+	if (pageno >= 0)
+		return pageno;
+
+	/*
+	 * Couldn't allocate at the ideal adjacent position, search
+	 * for any available space after the last allocated page.
+	 */
+	pageno = tegra_vpr_find_free_region_in_range(vpr, vpr->last + 1,
+						     vpr->num_pages, num_pages,
+						     align);
+	if (pageno >= 0)
+		return pageno;
+
+	return -ENOSPC;
+}
+
+/*
+ * Find a free region, preferring locations near existing allocations to
+ * minimize VPR fragmentation. The allocation strategy is to first allocate
+ * within or adjacent to the existing region to keep allocations clustered.
+ * Otherwise fall back to a generic allocation using the first available
+ * space.
+ *
+ * This approach focuses on page-level allocation first, then the chunk
+ * system determines which chunks need to be activated based on where the
+ * pages ended up.
+ */
+static int tegra_vpr_allocate_region(struct tegra_vpr *vpr,
+				     unsigned int num_pages,
+				     unsigned int align)
+{
+	int pageno;
+
+	/*
+	 * For non-resizable VPR (no chunks), use simple first-fit allocation.
+	 * Clustering optimization is only beneficial for resizable VPR where
+	 * keeping allocations together minimizes the active VPR size.
+	 */
+	if (!vpr->resizable)
+		return tegra_vpr_find_free_region(vpr, num_pages, align);
+
+	/*
+	 * Check if there are any existing allocations in the bitmap. If so,
+	 * try to allocate near them to minimize fragmentation.
+	 */
+	pageno = tegra_vpr_find_free_region_clustered(vpr, num_pages, align);
+	if (pageno >= 0)
+		return pageno;
+
+	/*
+	 * If there are no existing allocations, or no space adjacent to them,
+	 * fall back to the first available space anywhere in the VPR.
+	 */
+	pageno = tegra_vpr_find_free_region(vpr, num_pages, align);
+	if (pageno >= 0)
+		return pageno;
+
+	return -ENOSPC;
+}
+
+static struct tegra_vpr_buffer *
+tegra_vpr_buffer_allocate(struct tegra_vpr *vpr, size_t size)
+{
+	unsigned int num_pages = size >> PAGE_SHIFT;
+	unsigned int order = get_order(size);
+	struct tegra_vpr_buffer *buffer;
+	unsigned long first, last;
+	int pageno, err;
+
+	/*
+	 * Quick sanity check that we're not trying to allocate a buffer that
+	 * has no chance of fitting into the VPR.
+	 */
+	if (size > vpr->size)
+		return ERR_PTR(-EINVAL);
+
+	/*
+	 * "order" defines the alignment and size, so this may result in
+	 * fragmented memory depending on the allocation patterns. However,
+	 * since this is used primarily for video frames, it is expected that
+	 * a number of buffers of the same size will be allocated, so
+	 * fragmentation should be negligible.
+	 */
+	pageno = tegra_vpr_allocate_region(vpr, num_pages, 1);
+	if (pageno < 0)
+		return ERR_PTR(pageno);
+
+	first = find_first_bit(vpr->bitmap, vpr->num_pages);
+	last = find_last_bit(vpr->bitmap, vpr->num_pages);
+
+	buffer = kzalloc_obj(*buffer, GFP_KERNEL);
+	if (!buffer) {
+		err = -ENOMEM;
+		goto release;
+	}
+
+	INIT_LIST_HEAD(&buffer->attachments);
+	INIT_LIST_HEAD(&buffer->list);
+	mutex_init(&buffer->lock);
+	buffer->start = vpr->base + (pageno << PAGE_SHIFT);
+	buffer->limit = buffer->start + size;
+	buffer->size = size;
+	buffer->num_pages = num_pages;
+	buffer->pageno = pageno;
+	buffer->order = order;
+
+	/* track which chunks this buffer overlaps */
+	if (vpr->resizable) {
+		unsigned int limit = buffer->pageno + buffer->num_pages;
+		pgoff_t i;
+
+		/*
+		 * Memory is backed by struct page, so track which ones we
+		 * use.
+		 */
+		buffer->pages = kvmalloc_array(buffer->num_pages,
+					       sizeof(*buffer->pages),
+					       GFP_KERNEL);
+		if (!buffer->pages) {
+			err = -ENOMEM;
+			goto free;
+		}
+
+		for (i = 0; i < buffer->num_pages; i++)
+			buffer->pages[i] = &vpr->start_page[pageno + i];
+
+		for (i = 0; i < vpr->num_chunks; i++) {
+			struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+			if (tegra_vpr_chunk_overlaps(chunk, pageno, limit))
+				set_bit(i, buffer->chunks);
+		}
+
+		/* activate chunks if necessary */
+		err = tegra_vpr_activate_chunks(vpr, buffer);
+		if (err < 0) {
+			kfree(buffer->pages);
+			goto free;
+		}
+
+		/* track first and last allocated pages */
+		if (buffer->pageno < vpr->first)
+			vpr->first = buffer->pageno;
+
+		if (limit - 1 > vpr->last)
+			vpr->last = limit - 1;
+	}
+
+	return buffer;
+
+free:
+	kfree(buffer);
+release:
+	bitmap_clear(vpr->bitmap, pageno, num_pages);
+	return ERR_PTR(err);
+}
+
+static void tegra_vpr_buffer_release(struct tegra_vpr_buffer *buffer)
+{
+	struct tegra_vpr *vpr = buffer->vpr;
+	struct tegra_vpr_buffer *entry;
+	unsigned int i;
+
+	/*
+	 * Decrement buffer count for each overlapping chunk. Note that chunks
+	 * are not deactivated here yet, that's done in tegra_vpr_recycle()
+	 * instead.
+	 */
+	for_each_set_bit(i, buffer->chunks, vpr->num_chunks) {
+		if (!WARN_ON(vpr->chunks[i].num_buffers == 0))
+			vpr->chunks[i].num_buffers--;
+	}
+
+	/* track first and last allocated pages */
+	if (list_is_first(&buffer->list, &vpr->buffers) &&
+	    list_is_last(&buffer->list, &vpr->buffers)) {
+		/* if there are no remaining buffers after this, reset */
+		vpr->first = ~0U;
+		vpr->last = 0U;
+	} else if (list_is_first(&buffer->list, &vpr->buffers)) {
+		entry = list_next_entry(buffer, list);
+		vpr->first = entry->pageno;
+	} else if (list_is_last(&buffer->list, &vpr->buffers)) {
+		entry = list_prev_entry(buffer, list);
+		vpr->last = entry->pageno + entry->num_pages - 1;
+	}
+
+	bitmap_clear(vpr->bitmap, buffer->pageno, buffer->num_pages);
+	list_del(&buffer->list);
+	kfree(buffer->pages);
+	kfree(buffer);
+}
+
+static int tegra_vpr_attach(struct dma_buf *buf,
+			    struct dma_buf_attachment *attachment)
+{
+	struct tegra_vpr_buffer *buffer = buf->priv;
+	struct tegra_vpr_attachment *attach;
+	int err;
+
+	attach = kzalloc_obj(*attach, GFP_KERNEL);
+	if (!attach)
+		return -ENOMEM;
+
+	/*
+	 * For resizable VPR, the memory is backed by struct page, so we can
+	 * use the convenient helper to create the SG table.
+	 */
+	if (buffer->pages) {
+		err = sg_alloc_table_from_pages(&attach->sgt, buffer->pages,
+						buffer->num_pages, 0,
+						buffer->size, GFP_KERNEL);
+		if (err < 0)
+			goto free;
+	} else {
+		if (sg_alloc_table(&attach->sgt, 1, GFP_KERNEL)) {
+			err = -ENOMEM;
+			goto free;
+		}
+
+		sg_set_page(attach->sgt.sgl, NULL, buffer->size, 0);
+		sg_dma_address(attach->sgt.sgl) = buffer->start;
+		sg_dma_len(attach->sgt.sgl) = buffer->size;
+	}
+
+	attach->dev = attachment->dev;
+	INIT_LIST_HEAD(&attach->list);
+	attachment->priv = attach;
+
+	mutex_lock(&buffer->lock);
+	list_add(&attach->list, &buffer->attachments);
+	mutex_unlock(&buffer->lock);
+
+	return 0;
+
+free:
+	kfree(attach);
+	return err;
+}
+
+static void tegra_vpr_detach(struct dma_buf *buf,
+			     struct dma_buf_attachment *attachment)
+{
+	struct tegra_vpr_buffer *buffer = buf->priv;
+	struct tegra_vpr_attachment *attach = attachment->priv;
+
+	mutex_lock(&buffer->lock);
+	list_del(&attach->list);
+	mutex_unlock(&buffer->lock);
+
+	sg_free_table(&attach->sgt);
+	kfree(attach);
+}
+
+static struct sg_table *
+tegra_vpr_map_dma_buf(struct dma_buf_attachment *attachment,
+		      enum dma_data_direction direction)
+{
+	struct tegra_vpr_attachment *attach = attachment->priv;
+	struct sg_table *sgt = &attach->sgt;
+	int err;
+
+	err = dma_map_sgtable(attachment->dev, sgt, direction,
+			      DMA_ATTR_SKIP_CPU_SYNC);
+	if (err < 0)
+		return ERR_PTR(err);
+
+	return sgt;
+}
+
+static void tegra_vpr_unmap_dma_buf(struct dma_buf_attachment *attachment,
+				    struct sg_table *sgt,
+				    enum dma_data_direction direction)
+{
+	dma_unmap_sgtable(attachment->dev, sgt, direction,
+			  DMA_ATTR_SKIP_CPU_SYNC);
+}
+
+static void tegra_vpr_recycle(struct tegra_vpr *vpr)
+{
+	DECLARE_BITMAP(dirty, vpr->num_chunks);
+	unsigned int i;
+	int err;
+
+	if (!vpr->resizable)
+		return;
+
+	bitmap_zero(dirty, vpr->num_chunks);
+
+	/*
+	 * Deactivate any unused chunks from the bottom...
+	 */
+	for (i = 0; i < vpr->num_chunks; i++) {
+		struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+		if (!chunk->active)
+			continue;
+
+		if (chunk->num_buffers > 0)
+			break;
+
+		err = tegra_vpr_chunk_deactivate(chunk);
+		if (err < 0) {
+			pr_err("failed to deactivate chunk #%u: %d\n", i, err);
+			goto activate;
+		} else {
+			clear_bit(i, vpr->active);
+			set_bit(i, dirty);
+		}
+	}
+
+	/*
+	 * ... and the top.
+	 */
+	for (i = 0; i < vpr->num_chunks; i++) {
+		unsigned int index = vpr->num_chunks - i - 1;
+		struct tegra_vpr_chunk *chunk = &vpr->chunks[index];
+
+		if (!chunk->active)
+			continue;
+
+		if (chunk->num_buffers > 0)
+			break;
+
+		err = tegra_vpr_chunk_deactivate(chunk);
+		if (err < 0) {
+			pr_err("failed to deactivate chunk #%u: %d\n", index,
+			       err);
+			goto activate;
+		} else {
+			clear_bit(index, vpr->active);
+			set_bit(index, dirty);
+		}
+	}
+
+	if (!bitmap_empty(dirty, vpr->num_chunks)) {
+		err = tegra_vpr_resize(vpr);
+		if (err < 0) {
+			pr_err("failed to shrink VPR: %d\n", err);
+			goto activate;
+		}
+	}
+
+	/* release the CMA memory associated with deactivated chunks */
+	for_each_set_bit(i, dirty, vpr->num_chunks)
+		tegra_vpr_chunk_release(&vpr->chunks[i]);
+
+	return;
+
+activate:
+	for_each_set_bit(i, dirty, vpr->num_chunks) {
+		err = tegra_vpr_chunk_activate(&vpr->chunks[i]);
+		if (WARN_ON(err < 0))
+			pr_err("failed to activate chunk #%u: %d\n", i, err);
+
+		/*
+		 * This may not be fully activated at this point, but we need
+		 * to keep track of it anyway to make sure the CMA region can
+		 * eventually be released. The WARN_ON above tells us when it
+		 * happens: here be dragons.
+		 */
+		set_bit(i, vpr->active);
+	}
+}
+
+static void tegra_vpr_release(struct dma_buf *buf)
+{
+	struct tegra_vpr_buffer *buffer = buf->priv;
+	struct tegra_vpr *vpr = buffer->vpr;
+
+	mutex_lock(&vpr->lock);
+
+	tegra_vpr_buffer_release(buffer);
+	tegra_vpr_recycle(vpr);
+
+	mutex_unlock(&vpr->lock);
+}
+
+/*
+ * Prohibit userspace mapping because the CPU cannot access this memory
+ * anyway.
+ */
+static int tegra_vpr_begin_cpu_access(struct dma_buf *buf,
+				      enum dma_data_direction direction)
+{
+	return -EPERM;
+}
+
+static int tegra_vpr_end_cpu_access(struct dma_buf *buf,
+				    enum dma_data_direction direction)
+{
+	return -EPERM;
+}
+
+static int tegra_vpr_mmap(struct dma_buf *buf, struct vm_area_struct *vma)
+{
+	return -EPERM;
+}
+
+static const struct dma_buf_ops tegra_vpr_buf_ops = {
+	.attach = tegra_vpr_attach,
+	.detach = tegra_vpr_detach,
+	.map_dma_buf = tegra_vpr_map_dma_buf,
+	.unmap_dma_buf = tegra_vpr_unmap_dma_buf,
+	.release = tegra_vpr_release,
+	.begin_cpu_access = tegra_vpr_begin_cpu_access,
+	.end_cpu_access = tegra_vpr_end_cpu_access,
+	.mmap = tegra_vpr_mmap,
+};
+
+static struct dma_buf *tegra_vpr_allocate(struct dma_heap *heap,
+					  unsigned long len, u32 fd_flags,
+					  u64 heap_flags)
+{
+	struct tegra_vpr *vpr = dma_heap_get_drvdata(heap);
+	struct tegra_vpr_buffer *buffer, *entry;
+	size_t size = ALIGN(len, vpr->align);
+	DEFINE_DMA_BUF_EXPORT_INFO(export);
+	struct dma_buf *buf;
+
+	mutex_lock(&vpr->lock);
+
+	buffer = tegra_vpr_buffer_allocate(vpr, size);
+	if (IS_ERR(buffer)) {
+		mutex_unlock(&vpr->lock);
+		return ERR_CAST(buffer);
+	}
+
+	/* insert in the correct order */
+	if (!list_empty(&vpr->buffers)) {
+		list_for_each_entry(entry, &vpr->buffers, list) {
+			if (buffer->pageno < entry->pageno) {
+				list_add_tail(&buffer->list, &entry->list);
+				break;
+			}
+		}
+	}
+
+	if (list_empty(&buffer->list))
+		list_add_tail(&buffer->list, &vpr->buffers);
+
+	buffer->vpr = vpr;
+
+	/*
+	 * If a valid buffer was allocated, wrap it in a dma_buf
+	 * and return it.
+	 */
+	export.exp_name = dma_heap_get_name(heap);
+	export.ops = &tegra_vpr_buf_ops;
+	export.size = buffer->size;
+	export.flags = fd_flags;
+	export.priv = buffer;
+
+	buf = dma_buf_export(&export);
+	if (IS_ERR(buf)) {
+		tegra_vpr_buffer_release(buffer);
+		tegra_vpr_recycle(vpr);
+	}
+
+	mutex_unlock(&vpr->lock);
+	return buf;
+}
+
+static void tegra_vpr_debugfs_show_buffers(struct tegra_vpr *vpr,
+					   struct seq_file *s)
+{
+	struct tegra_vpr_buffer *buffer;
+	char buf[16];
+
+	mutex_lock(&vpr->lock);
+
+	list_for_each_entry(buffer, &vpr->buffers, list) {
+		string_get_size(buffer->size, 1, STRING_UNITS_2, buf,
+				sizeof(buf));
+		seq_printf(s, "  %pap-%pap (%s)\n", &buffer->start,
+			   &buffer->limit, buf);
+	}
+
+	mutex_unlock(&vpr->lock);
+}
+
+static void tegra_vpr_debugfs_show_chunks(struct tegra_vpr *vpr,
+					  struct seq_file *s)
+{
+	struct tegra_vpr_buffer *buffer;
+	unsigned int i;
+	char buf[16];
+
+	for (i = 0; i < vpr->num_chunks; i++) {
+		const struct tegra_vpr_chunk *chunk = &vpr->chunks[i];
+
+		string_get_size(chunk->size, 1, STRING_UNITS_2, buf,
+				sizeof(buf));
+		seq_printf(s, "  %pap-%pap (%s) (%s, %u buffers)\n",
+			   &chunk->start, &chunk->limit, buf,
+			   chunk->active ? "active" : "inactive",
+			   chunk->num_buffers);
+	}
+
+	list_for_each_entry(buffer, &vpr->buffers, list) {
+		string_get_size(buffer->size, 1, STRING_UNITS_2, buf,
+				sizeof(buf));
+		seq_printf(s, "%pap-%pap (%s, chunks: %*pbl)\n",
+			   &buffer->start, &buffer->limit, buf,
+			   vpr->num_chunks, buffer->chunks);
+	}
+}
+
+static int tegra_vpr_debugfs_show(struct seq_file *s, struct dma_heap *heap)
+{
+	struct tegra_vpr *vpr = dma_heap_get_drvdata(heap);
+	phys_addr_t limit = vpr->base + vpr->size;
+	char buf[16];
+
+	string_get_size(vpr->size, 1, STRING_UNITS_2, buf, sizeof(buf));
+	seq_printf(s, "%pap-%pap (%s)\n", &vpr->base, &limit, buf);
+
+	if (!vpr->resizable)
+		tegra_vpr_debugfs_show_buffers(vpr, s);
+	else
+		tegra_vpr_debugfs_show_chunks(vpr, s);
+
+	return 0;
+}
+
+static const struct dma_heap_ops tegra_vpr_heap_ops = {
+	.allocate = tegra_vpr_allocate,
+	.show = tegra_vpr_debugfs_show,
+};
+
+static int tegra_vpr_setup_chunks(struct tegra_vpr *vpr, const char *name)
+{
+	phys_addr_t start, limit;
+	unsigned int order, i = 0;
+	size_t max_size;
+	int err;
+
+	/* Memory is backed by struct page, so track the first one. */
+	vpr->start_page = phys_to_page(vpr->base);
+
+	/* This seems a reasonable value, so hard-code it for now. */
+	vpr->num_chunks = 4;
+
+	vpr->chunks = kzalloc_objs(*vpr->chunks, vpr->num_chunks);
+	if (!vpr->chunks)
+		return -ENOMEM;
+
+	vpr->active = bitmap_zalloc(vpr->num_chunks, GFP_KERNEL);
+	if (!vpr->active) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	max_size = PAGE_SIZE << (get_order(vpr->size) - ilog2(vpr->num_chunks));
+	order = get_order(vpr->align);
+
+	/*
+	 * Allocate CMA areas for VPR. All areas will be roughtly the same
+	 * size, with the last area taking up the rest.
+	 */
+	start = vpr->base;
+	limit = vpr->base + vpr->size;
+
+	pr_debug("VPR: %pap-%pap (%lu pages, %u chunks, %lu MiB)\n", &start,
+		 &limit, vpr->num_pages, vpr->num_chunks,
+		 (unsigned long)vpr->size / 1024 / 1024);
+
+	for (i = 0; i < vpr->num_chunks; i++) {
+		size_t size = limit - start;
+		phys_addr_t end;
+
+		size = min_t(size_t, size, max_size);
+		end = start + size - 1;
+
+		err = tegra_vpr_chunk_init(vpr, &vpr->chunks[i], start, size,
+					   order, name);
+		if (err < 0) {
+			pr_err("failed to create VPR chunk: %d\n", err);
+			goto free;
+		}
+
+		pr_debug("  %2u: %pap-%pap (%lu MiB)\n", i, &start, &end,
+			 size / 1024 / 1024);
+		start += size;
+	}
+
+	vpr->first = ~0U;
+	vpr->last = 0U;
+
+	return 0;
+
+free:
+	while (i--)
+		tegra_vpr_chunk_free(&vpr->chunks[i]);
+
+	kfree(vpr->active);
+	kfree(vpr->chunks);
+	return err;
+}
+
+static void tegra_vpr_free_chunks(struct tegra_vpr *vpr)
+{
+	unsigned int i;
+
+	for (i = 0; i < vpr->num_chunks; i++)
+		tegra_vpr_chunk_free(&vpr->chunks[i]);
+
+	kfree(vpr->chunks);
+}
+
+static int tegra_vpr_setup_static(struct tegra_vpr *vpr)
+{
+	phys_addr_t start, limit;
+
+	start = vpr->base;
+	limit = vpr->base + vpr->size;
+
+	pr_debug("VPR: %pap-%pap (%lu pages, %lu MiB)\n", &start, &limit,
+		 vpr->num_pages, (unsigned long)vpr->size / 1024 / 1024);
+
+	return 0;
+}
+
+static int tegra_vpr_add_heap(struct reserved_mem *rmem,
+			      struct device_node *np)
+{
+	struct dma_heap_export_info info = {};
+	unsigned long first, last;
+	struct dma_heap *heap;
+	struct tegra_vpr *vpr;
+	int err;
+
+	vpr = kzalloc_obj(*vpr, GFP_KERNEL);
+	if (!vpr)
+		return -ENOMEM;
+
+	INIT_LIST_HEAD(&vpr->list);
+	INIT_LIST_HEAD(&vpr->buffers);
+	INIT_LIST_HEAD(&vpr->devices);
+	mutex_init(&vpr->lock);
+
+	vpr->resizable = !of_property_read_bool(np, "no-map");
+	vpr->dev_node = of_node_get(np);
+	vpr->align = PAGE_SIZE;
+	vpr->base = rmem->base;
+	vpr->size = rmem->size;
+	vpr->num_pages = vpr->size >> PAGE_SHIFT;
+	vpr->nid = of_node_to_nid(np);
+	vpr->cma = rmem->priv;
+
+	vpr->bitmap = bitmap_zalloc(vpr->num_pages, GFP_KERNEL);
+	if (!vpr->bitmap) {
+		err = -ENOMEM;
+		goto free;
+	}
+
+	first = find_first_bit(vpr->bitmap, vpr->num_pages);
+	last = find_last_bit(vpr->bitmap, vpr->num_pages);
+
+	if (vpr->resizable)
+		err = tegra_vpr_setup_chunks(vpr, rmem->name);
+	else
+		err = tegra_vpr_setup_static(vpr);
+
+	if (err < 0)
+		goto free;
+
+	info.name = vpr->dev_node->name;
+	info.ops = &tegra_vpr_heap_ops;
+	info.priv = vpr;
+
+	heap = dma_heap_add(&info);
+	if (IS_ERR(heap)) {
+		err = PTR_ERR(heap);
+		goto cleanup;
+	}
+
+	tegra_vpr_add(vpr);
+
+	return 0;
+
+cleanup:
+	if (vpr->resizable)
+		tegra_vpr_free_chunks(vpr);
+free:
+	bitmap_free(vpr->bitmap);
+	kfree(vpr);
+	return err;
+}
+
+static int tegra_vpr_init(void)
+{
+	const char *compatible = "nvidia,tegra-video-protection-region";
+	struct device_node *parent;
+	struct reserved_mem *rmem;
+	int err;
+
+	parent = of_find_node_by_path("/reserved-memory");
+	if (!parent)
+		return 0;
+
+	for_each_child_of_node_scoped(parent, child) {
+		if (!of_device_is_compatible(child, compatible))
+			continue;
+
+		rmem = of_reserved_mem_lookup(child);
+		if (!rmem)
+			continue;
+
+		err = tegra_vpr_add_heap(rmem, child);
+		if (err < 0)
+			pr_err("failed to add VPR heap for %pOF: %d\n", child,
+			       err);
+
+		/* only a single VPR heap is supported */
+		break;
+	}
+
+	of_node_put(parent);
+	return 0;
+}
+module_init(tegra_vpr_init);
+
+MODULE_DESCRIPTION("NVIDIA Tegra Video-Protection-Region DMA-BUF heap driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/dma-buf/heaps/tegra-vpr.h b/drivers/dma-buf/heaps/tegra-vpr.h
new file mode 100644
index 000000000000..ba2afba8cc61
--- /dev/null
+++ b/drivers/dma-buf/heaps/tegra-vpr.h
@@ -0,0 +1,73 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * DMA-BUF restricted heap exporter for NVIDIA Video-Protection-Region (VPR)
+ *
+ * Copyright (C) 2024-2026 NVIDIA Corporation
+ */
+
+#ifndef DMA_BUF_HEAPS_TEGRA_VPR_H
+#define DMA_BUF_HEAPS_TEGRA_VPR_H
+
+#include <linux/list.h>
+#include <linux/mutex.h>
+
+struct tegra_vpr_device {
+	struct list_head node;
+	struct device *dev;
+};
+
+struct tegra_vpr;
+
+struct tegra_vpr_chunk {
+	phys_addr_t start;
+	phys_addr_t limit;
+	size_t size;
+
+	struct tegra_vpr *vpr;
+	bool invalid;
+	bool active;
+
+	struct page *start_page;
+	unsigned int offset;
+	unsigned long virt;
+	pgoff_t num_pages;
+
+	unsigned int num_buffers;
+};
+
+struct tegra_vpr {
+	struct list_head list;
+
+	struct device_node *dev_node;
+	unsigned long align;
+	phys_addr_t base;
+	phys_addr_t size;
+	int nid;
+
+	struct list_head buffers;
+	unsigned long *bitmap;
+	pgoff_t num_pages;
+
+	/* resizable VPR */
+	struct cma *cma;
+	unsigned long *active;
+	struct tegra_vpr_chunk *chunks;
+	unsigned int num_chunks;
+	struct page *start_page;
+	bool resizable;
+
+	unsigned int first;
+	unsigned int last;
+
+	struct list_head devices;
+
+	/**
+	 * @lock: Protects concurrent access to the allocation bitmap, as well
+	 * as the buffers and devices lists.
+	 */
+	struct mutex lock;
+};
+
+void tegra_vpr_add(struct tegra_vpr *vpr);
+
+#endif
diff --git a/include/trace/events/tegra_vpr.h b/include/trace/events/tegra_vpr.h
new file mode 100644
index 000000000000..f8ceb17679fe
--- /dev/null
+++ b/include/trace/events/tegra_vpr.h
@@ -0,0 +1,57 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#if !defined(_TRACE_TEGRA_VPR_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_TEGRA_VPR_H
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM tegra_vpr
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(tegra_vpr_chunk_activate,
+	TP_PROTO(phys_addr_t start, phys_addr_t limit),
+	TP_ARGS(start, limit),
+	TP_STRUCT__entry(
+		__field(phys_addr_t, start)
+		__field(phys_addr_t, limit)
+	),
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->limit = limit;
+	),
+	TP_printk("%pap-%pap", &__entry->start,
+		  &__entry->limit)
+);
+
+TRACE_EVENT(tegra_vpr_chunk_deactivate,
+	TP_PROTO(phys_addr_t start, phys_addr_t limit),
+	TP_ARGS(start, limit),
+	TP_STRUCT__entry(
+		__field(phys_addr_t, start)
+		__field(phys_addr_t, limit)
+	),
+	TP_fast_assign(
+		__entry->start = start;
+		__entry->limit = limit;
+	),
+	TP_printk("%pap-%pap", &__entry->start,
+		  &__entry->limit)
+);
+
+TRACE_EVENT(tegra_vpr_set,
+	TP_PROTO(phys_addr_t base, phys_addr_t size),
+	TP_ARGS(base, size),
+	TP_STRUCT__entry(
+		__field(phys_addr_t, start)
+		__field(phys_addr_t, limit)
+	),
+	TP_fast_assign(
+		__entry->start = base;
+		__entry->limit = base + size;
+	),
+	TP_printk("%pap-%pap", &__entry->start, &__entry->limit)
+);
+
+#endif /* _TRACE_TEGRA_VPR_H */
+
+#include <trace/define_trace.h>

-- 
2.55.0

