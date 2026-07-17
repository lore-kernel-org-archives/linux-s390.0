Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4939340417;
	Fri, 17 Jul 2026 18:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784311700; cv=none; b=bLr/3E3wSfEtX/dynhywlijTi1NVAwNBLdjT4alFS23xkl5CJhk0Mlfi5qrXOtlj7oH1x6EhQ5AdDx4VjTZ0xDXsYvMxkymAqgLW9bRSxBPBH+yCsA9Y8VwdCFUSwvqHjUpO5aNzJRTeHzdt1DdzPDkPZoYjhNRKksV9RerYHqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784311700; c=relaxed/simple;
	bh=Xq24ApDCDZEF81VDksq1HvzM/P+yTjCmGsP2m4R0Shk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YDo/kdtzRCevpei3AaNijP20shpJfdHA5awdXzOLOuroWkQz8AsMQ8z4rPwIepbTcMZ5fxl/Un1jt9NJ+DbRDM/PEtHU4djLfaf0h+UDCSr/rpJoOSRI6yCuJuQv2tagvwuispsB3vVsFt7l8caspTuXuo9C/glmuyDe+bl1LSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UcA7rv5C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UcA7rv5C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4003F1F00A3A;
	Fri, 17 Jul 2026 18:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784311699;
	bh=CV8QBh8RHI5mzqb2fm7QecW+bWIQzre8IVIoWdK1GKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UcA7rv5CVRknaqmMkLhCn+0BkGdRgLuDGal93rx/bnxSs87OrIsgv6UlyCzhge900
	 WWGpujZyRUd0jzlt2kT+uztP/P8EU2SyAW2q2Bv0GNfVZnPyvq0sEzP6RkV/cQUhx/
	 dGB0nDNgVJaJFd8xnO1rKvZiRXdHK4j3a7bymP/ZQxLhXPqsOcB7GfOiMYybllVRrV
	 EQLBKLPCShaco9snoCCdH+AjuFbu9LdqrsP3UqrA9e81PNcWmoG9ipa4T+ixJFfis9
	 R91MEf+DW2egIu2h7wMcSFTjBITZjCj6owfXUXnOzdtRu8QGy/gTniAoG1ozoiSx3o
	 04NmOFLPiPWGA==
From: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>
To: iommu@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-coco@lists.linux.dev
Cc: "Aneesh Kumar K.V (Arm)" <aneesh.kumar@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Will Deacon <will@kernel.org>,
	Marc Zyngier <maz@kernel.org>,
	Steven Price <steven.price@arm.com>,
	Suzuki K Poulose <Suzuki.Poulose@arm.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jason Gunthorpe <jgg@ziepe.ca>,
	Mostafa Saleh <smostafa@google.com>,
	Petr Tesarik <ptesarik@suse.com>,
	Alexey Kardashevskiy <aik@amd.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Xu Yilun <yilun.xu@linux.intel.com>,
	linuxppc-dev@lists.ozlabs.org,
	linux-s390@vger.kernel.org,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	x86@kernel.org,
	Jiri Pirko <jiri@nvidia.com>,
	Michael Kelley <mhklinux@outlook.com>
Subject: [PATCH v8 17/23] dma-direct: make dma_direct_map_phys() honor DMA_ATTR_CC_SHARED
Date: Fri, 17 Jul 2026 23:34:35 +0530
Message-ID: <20260717180442.110954-18-aneesh.kumar@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260717180442.110954-1-aneesh.kumar@kernel.org>
References: <20260717180442.110954-1-aneesh.kumar@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Teach dma_direct_map_phys() to select the DMA address encoding based on
DMA_ATTR_CC_SHARED.

Use phys_to_dma_unencrypted() for decrypted mappings and
phys_to_dma_encrypted() otherwise. If a device requires unencrypted DMA
but the source physical address is still encrypted, force the mapping
through swiotlb so the DMA address and backing memory attributes remain
consistent.

Update the arm64, x86, s390 and powerpc secure-guest setup to not use
swiotlb force option

Tested-by: Jiri Pirko <jiri@nvidia.com>
Tested-by: Michael Kelley <mhklinux@outlook.com>
Tested-by: Mostafa Saleh <smostafa@google.com>
Signed-off-by: Aneesh Kumar K.V (Arm) <aneesh.kumar@kernel.org>
---
Changes from v3:
* Handle DMA_ATTR_MMIO
---
 arch/arm64/mm/init.c                 |  4 +--
 arch/powerpc/platforms/pseries/svm.c |  2 +-
 arch/s390/mm/init.c                  |  2 +-
 arch/x86/kernel/pci-dma.c            |  4 +--
 kernel/dma/direct.c                  | 52 ++++++++++++++++------------
 5 files changed, 34 insertions(+), 30 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 48d69e390158..3c390ef7b41b 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -340,9 +340,7 @@ void __init arch_mm_preinit(void)
 	unsigned int flags = SWIOTLB_VERBOSE;
 	bool limited_addressing = max_pfn > PFN_DOWN(arm64_dma_phys_limit);
 
-	if (is_realm_world() || is_protected_kvm_guest()) {
-		flags |= SWIOTLB_FORCE;
-	} else if (!limited_addressing) {
+	if (!limited_addressing) {
 		/*
 		 * If no bouncing needed for ZONE_DMA, reduce the swiotlb
 		 * buffer for kmalloc() bouncing to 1MB per 1GB of RAM.
diff --git a/arch/powerpc/platforms/pseries/svm.c b/arch/powerpc/platforms/pseries/svm.c
index 384c9dc1899a..7a403dbd35ee 100644
--- a/arch/powerpc/platforms/pseries/svm.c
+++ b/arch/powerpc/platforms/pseries/svm.c
@@ -29,7 +29,7 @@ static int __init init_svm(void)
 	 * need to use the SWIOTLB buffer for DMA even if dma_capable() says
 	 * otherwise.
 	 */
-	ppc_swiotlb_flags |= SWIOTLB_ANY | SWIOTLB_FORCE;
+	ppc_swiotlb_flags |= SWIOTLB_ANY;
 
 	/* Share the SWIOTLB buffer with the host. */
 	swiotlb_update_mem_attributes();
diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index 6b1c5a4fa9ce..8d1de5a2e554 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -166,7 +166,7 @@ static void __init pv_init(void)
 	virtio_set_mem_acc_cb(virtio_require_restricted_mem_acc);
 
 	/* make sure bounce buffers are shared */
-	swiotlb_init(true, SWIOTLB_FORCE | SWIOTLB_VERBOSE);
+	swiotlb_init(true, SWIOTLB_VERBOSE);
 	swiotlb_update_mem_attributes();
 }
 
diff --git a/arch/x86/kernel/pci-dma.c b/arch/x86/kernel/pci-dma.c
index 6267363e0189..75cf8f6ae8cd 100644
--- a/arch/x86/kernel/pci-dma.c
+++ b/arch/x86/kernel/pci-dma.c
@@ -59,10 +59,8 @@ static void __init pci_swiotlb_detect(void)
 	 * bounce buffers as the hypervisor can't access arbitrary VM memory
 	 * that is not explicitly shared with it.
 	 */
-	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT)) {
+	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
 		x86_swiotlb_enable = true;
-		x86_swiotlb_flags |= SWIOTLB_FORCE;
-	}
 }
 #else
 static inline void __init pci_swiotlb_detect(void)
diff --git a/kernel/dma/direct.c b/kernel/dma/direct.c
index 2413235c50f0..fed901c0224e 100644
--- a/kernel/dma/direct.c
+++ b/kernel/dma/direct.c
@@ -14,6 +14,8 @@
 #include <linux/set_memory.h>
 #include <linux/slab.h>
 #include <linux/pci-p2pdma.h>
+#include <linux/cc_platform.h>
+
 #include "direct.h"
 
 /*
@@ -626,37 +628,41 @@ dma_addr_t dma_direct_map_phys(struct device *dev, phys_addr_t phys,
 {
 	dma_addr_t dma_addr;
 
+	if (attrs & DMA_ATTR_MMIO) {
+		/*
+		 * For host memory encryption treat MMIO memory as shared
+		 */
+		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT))
+			attrs |= DMA_ATTR_CC_SHARED;
+	}
+
 	if (is_swiotlb_force_bounce(dev)) {
-		if (!(attrs & DMA_ATTR_CC_SHARED)) {
-			if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
-				return DMA_MAPPING_ERROR;
+		if (attrs & (DMA_ATTR_MMIO | DMA_ATTR_REQUIRE_COHERENT))
+			return DMA_MAPPING_ERROR;
 
-			return swiotlb_map(dev, phys, size, dir, attrs);
-		}
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
-		return DMA_MAPPING_ERROR;
+		return swiotlb_map(dev, phys, size, dir, attrs);
 	}
 
-	if (attrs & DMA_ATTR_MMIO) {
-		dma_addr = phys;
-		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
-			goto err_overflow;
-	} else if (attrs & DMA_ATTR_CC_SHARED) {
+	if (attrs & DMA_ATTR_CC_SHARED)
 		dma_addr = phys_to_dma_unencrypted(dev, phys);
+	else
+		dma_addr = phys_to_dma_encrypted(dev, phys);
+
+	if (attrs & DMA_ATTR_MMIO) {
 		if (unlikely(!dma_capable(dev, dma_addr, size, false, attrs)))
 			goto err_overflow;
-	} else {
-		dma_addr = phys_to_dma(dev, phys);
-		if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
-		    dma_kmalloc_needs_bounce(dev, size, dir)) {
-			if (is_swiotlb_active(dev) &&
-			    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
-				return swiotlb_map(dev, phys, size, dir, attrs);
+		goto dma_mapped;
+	}
 
-			goto err_overflow;
-		}
+	if (unlikely(!dma_capable(dev, dma_addr, size, true, attrs)) ||
+	    dma_kmalloc_needs_bounce(dev, size, dir)) {
+		if (is_swiotlb_active(dev) &&
+		    !(attrs & DMA_ATTR_REQUIRE_COHERENT))
+			return swiotlb_map(dev, phys, size, dir, attrs);
+		goto err_overflow;
 	}
 
+dma_mapped:
 	if (!dev_is_dma_coherent(dev) &&
 	    !(attrs & (DMA_ATTR_SKIP_CPU_SYNC | DMA_ATTR_MMIO))) {
 		arch_sync_dma_for_device(phys, size, dir);
@@ -748,8 +754,10 @@ size_t dma_direct_max_mapping_size(struct device *dev)
 {
 	/* If SWIOTLB is active, use its maximum mapping size */
 	if (is_swiotlb_active(dev) &&
-	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev)))
+	    (dma_addressing_limited(dev) || is_swiotlb_force_bounce(dev) ||
+	     force_dma_unencrypted(dev)))
 		return swiotlb_max_mapping_size(dev);
+
 	return SIZE_MAX;
 }
 
-- 
2.43.0

