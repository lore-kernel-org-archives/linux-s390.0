Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4335B274FD3;
	Tue, 21 Oct 2025 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761015407; cv=none; b=cgz85xUNnsPbgAIlvPPzWrmc01RNBZ3ffsdMIVP+55Ns/OWru1kwvCgYOXFWwmF3DTIBQIs54zNDNLlHCwjA+IVrLjkrin3+inICrAm6aIObPXz+JzlAwmq+kz3349RzyvP0VmShk7/q8JLY1O3NDi8lg5EDaO1V9ID2z9KhHQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761015407; c=relaxed/simple;
	bh=CxJm60S2gZHUoWCZVhWJAPPBtiNPP28nE8Kbbp6mI7g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=m6AaUqu0vE+V9G/3JULahH6yjVpKL3obLfWFRjHnhtCM01CMAdebxUwO/TZA8OlqcYJKDfUNRTR1Hm+TNA7i2EcA/YlTF+YMXMZaj0KqbFG/T7Anp8NhQne1OEHq3fOqP1YG68jqPZjlCgWNogE848FcZ/msR23HJyrDtjgqnps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D39371063;
	Mon, 20 Oct 2025 19:56:36 -0700 (PDT)
Received: from ergosum.cambridge.arm.com (ergosum.cambridge.arm.com [10.1.196.45])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 852D03F59E;
	Mon, 20 Oct 2025 19:56:43 -0700 (PDT)
From: Anshuman Khandual <anshuman.khandual@arm.com>
To: linux-mm@kvack.org
Cc: Anshuman Khandual <anshuman.khandual@arm.com>,
	linux-kernel@vger.kernel.org,
	iommu@lists.linux.dev,
	linux-s390@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	virtualization@lists.linux.dev
Subject: [PATCH] mm: Make INVALID_PHYS_ADDR a generic macro
Date: Tue, 21 Oct 2025 03:56:38 +0100
Message-Id: <20251021025638.2420216-1-anshuman.khandual@arm.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

INVALID_PHYS_ADDR has very similar definitions across the code base. Hence
just move that inside header <liux/mm.h> for more generic usage. Also drop
the now redundant ones which are no longer required.

Cc: linux-kernel@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: iommu@lists.linux.dev
Cc: linux-s390@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
Cc: virtualization@lists.linux.dev
Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
---
 arch/arm64/mm/mmu.c                  | 2 --
 arch/s390/boot/vmem.c                | 1 -
 drivers/vdpa/vdpa_user/iova_domain.h | 2 --
 include/linux/mm.h                   | 2 ++
 kernel/dma/swiotlb.c                 | 2 --
 5 files changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/arm64/mm/mmu.c b/arch/arm64/mm/mmu.c
index e80bb623ef53..1da02d908c30 100644
--- a/arch/arm64/mm/mmu.c
+++ b/arch/arm64/mm/mmu.c
@@ -470,8 +470,6 @@ static void __create_pgd_mapping(pgd_t *pgdir, phys_addr_t phys,
 	mutex_unlock(&fixmap_lock);
 }
 
-#define INVALID_PHYS_ADDR	(-1ULL)
-
 static phys_addr_t __pgd_pgtable_alloc(struct mm_struct *mm, gfp_t gfp,
 				       enum pgtable_type pgtable_type)
 {
diff --git a/arch/s390/boot/vmem.c b/arch/s390/boot/vmem.c
index cea3de4dce8c..fbe64ffdfb96 100644
--- a/arch/s390/boot/vmem.c
+++ b/arch/s390/boot/vmem.c
@@ -16,7 +16,6 @@
 #include "decompressor.h"
 #include "boot.h"
 
-#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
 struct ctlreg __bootdata_preserved(s390_invalid_asce);
 
 #ifdef CONFIG_PROC_FS
diff --git a/drivers/vdpa/vdpa_user/iova_domain.h b/drivers/vdpa/vdpa_user/iova_domain.h
index 775cad5238f3..a923971a64f5 100644
--- a/drivers/vdpa/vdpa_user/iova_domain.h
+++ b/drivers/vdpa/vdpa_user/iova_domain.h
@@ -17,8 +17,6 @@
 
 #define IOVA_START_PFN 1
 
-#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
-
 #define BOUNCE_MAP_SHIFT	12
 #define BOUNCE_MAP_SIZE	(1 << BOUNCE_MAP_SHIFT)
 #define BOUNCE_MAP_MASK	(~(BOUNCE_MAP_SIZE - 1))
diff --git a/include/linux/mm.h b/include/linux/mm.h
index d16b33bacc32..543a5f780874 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -105,6 +105,8 @@ extern int mmap_rnd_compat_bits __read_mostly;
 # endif
 #endif
 
+#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
+
 #include <asm/page.h>
 #include <asm/processor.h>
 
diff --git a/kernel/dma/swiotlb.c b/kernel/dma/swiotlb.c
index 0d37da3d95b6..a547c7693135 100644
--- a/kernel/dma/swiotlb.c
+++ b/kernel/dma/swiotlb.c
@@ -61,8 +61,6 @@
  */
 #define IO_TLB_MIN_SLABS ((1<<20) >> IO_TLB_SHIFT)
 
-#define INVALID_PHYS_ADDR (~(phys_addr_t)0)
-
 /**
  * struct io_tlb_slot - IO TLB slot descriptor
  * @orig_addr:	The original address corresponding to a mapped entry.
-- 
2.30.2

