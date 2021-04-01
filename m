Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FFACC433B4
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C16B61001
	for <linux-s390@archiver.kernel.org>; Thu,  1 Apr 2021 17:58:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236195AbhDAR6E (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 1 Apr 2021 13:58:04 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14674 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236492AbhDARyk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 1 Apr 2021 13:54:40 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FB2tZ0L3Jzmcqm;
        Thu,  1 Apr 2021 20:44:06 +0800 (CST)
Received: from huawei.com (10.174.28.241) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.498.0; Thu, 1 Apr 2021
 20:46:37 +0800
From:   Bixuan Cui <cuibixuan@huawei.com>
To:     <linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>
CC:     <schnelle@linux.ibm.com>, <gor@linux.ibm.com>,
        <borntraeger@de.ibm.com>, <john.wanghui@huawei.com>
Subject: [PATCH] s390/pci: move ioremap/ioremap_prot/ioremap_wc/ioremap_wt/iounmap to arch/s390/mm/ioremap.c
Date:   Thu, 1 Apr 2021 20:46:11 +0800
Message-ID: <20210401124611.49917-1-cuibixuan@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.28.241]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The ioremap/iounmap is implemented in arch/s390/pci/pci.c.
While CONFIG_PCI is disabled,the compilation error is reported:
    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `set_cis_map':
    cistpl.c:(.text+0x32a): undefined reference to `ioremap'
    s390x-linux-gnu-ld: cistpl.c:(.text+0x360): undefined reference to `iounmap'
    s390x-linux-gnu-ld: cistpl.c:(.text+0x384): undefined reference to `iounmap'
    s390x-linux-gnu-ld: cistpl.c:(.text+0x396): undefined reference to `ioremap'
    s390x-linux-gnu-ld: drivers/pcmcia/cistpl.o: in function `release_cis_mem':
    cistpl.c:(.text+0xcb8): undefined reference to `iounmap'

Add arch/s390/mm/ioremap.c file and move ioremap/ioremap_wc/ioremap_rt/iounmap
to it to fix the error.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Bixuan Cui <cuibixuan@huawei.com>
---
 arch/s390/include/asm/io.h |  8 ++---
 arch/s390/mm/Makefile      |  2 +-
 arch/s390/mm/ioremap.c     | 64 +++++++++++++++++++++++++++++++++
 arch/s390/pci/pci.c        | 73 ++++++--------------------------------
 4 files changed, 80 insertions(+), 67 deletions(-)
 create mode 100644 arch/s390/mm/ioremap.c

diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index e3882b012bfa..48a55644c34f 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -22,6 +22,10 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
 
+#define ioremap ioremap
+#define ioremap_wt ioremap_wt
+#define ioremap_wc ioremap_wc
+
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
 void __iomem *ioremap(phys_addr_t addr, size_t size);
 void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
@@ -51,10 +55,6 @@ static inline void ioport_unmap(void __iomem *p)
 #define pci_iomap_wc pci_iomap_wc
 #define pci_iomap_wc_range pci_iomap_wc_range
 
-#define ioremap ioremap
-#define ioremap_wt ioremap_wt
-#define ioremap_wc ioremap_wc
-
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
 #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
diff --git a/arch/s390/mm/Makefile b/arch/s390/mm/Makefile
index cd67e94c16aa..74c22dfb131b 100644
--- a/arch/s390/mm/Makefile
+++ b/arch/s390/mm/Makefile
@@ -4,7 +4,7 @@
 #
 
 obj-y		:= init.o fault.o extmem.o mmap.o vmem.o maccess.o
-obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o
+obj-y		+= page-states.o pageattr.o pgtable.o pgalloc.o ioremap.o
 
 obj-$(CONFIG_CMM)		+= cmm.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
diff --git a/arch/s390/mm/ioremap.c b/arch/s390/mm/ioremap.c
new file mode 100644
index 000000000000..132e6ddff36f
--- /dev/null
+++ b/arch/s390/mm/ioremap.c
@@ -0,0 +1,64 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2021 Huawei Ltd.
+ * Author: Bixuan Cui <cuibixuan@huawei.com>
+ */
+#include <linux/vmalloc.h>
+#include <linux/io.h>
+#include <linux/mm.h>
+#include <linux/jump_label.h>
+
+static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
+{
+	unsigned long offset, vaddr;
+	struct vm_struct *area;
+	phys_addr_t last_addr;
+
+	last_addr = addr + size - 1;
+	if (!size || last_addr < addr)
+		return NULL;
+
+	offset = addr & ~PAGE_MASK;
+	addr &= PAGE_MASK;
+	size = PAGE_ALIGN(size + offset);
+	area = get_vm_area(size, VM_IOREMAP);
+	if (!area)
+		return NULL;
+
+	vaddr = (unsigned long) area->addr;
+	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
+		free_vm_area(area);
+		return NULL;
+	}
+	return (void __iomem *) ((unsigned long) area->addr + offset);
+}
+
+void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
+{
+	return __ioremap(addr, size, __pgprot(prot));
+}
+EXPORT_SYMBOL(ioremap_prot);
+
+void __iomem *ioremap(phys_addr_t addr, size_t size)
+{
+	return __ioremap(addr, size, PAGE_KERNEL);
+}
+EXPORT_SYMBOL(ioremap);
+
+void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
+{
+	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
+}
+EXPORT_SYMBOL(ioremap_wc);
+
+void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
+{
+	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
+}
+EXPORT_SYMBOL(ioremap_wt);
+
+void iounmap(volatile void __iomem *addr)
+{
+	vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
+}
+EXPORT_SYMBOL(iounmap);
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index dd14641b2d20..be300850df9c 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -227,65 +227,6 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
        zpci_memcpy_toio(to, from, count);
 }
 
-static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
-{
-	unsigned long offset, vaddr;
-	struct vm_struct *area;
-	phys_addr_t last_addr;
-
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
-	if (!static_branch_unlikely(&have_mio))
-		return (void __iomem *) addr;
-
-	offset = addr & ~PAGE_MASK;
-	addr &= PAGE_MASK;
-	size = PAGE_ALIGN(size + offset);
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long) area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
-		free_vm_area(area);
-		return NULL;
-	}
-	return (void __iomem *) ((unsigned long) area->addr + offset);
-}
-
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
-{
-	return __ioremap(addr, size, __pgprot(prot));
-}
-EXPORT_SYMBOL(ioremap_prot);
-
-void __iomem *ioremap(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, PAGE_KERNEL);
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wt);
-
-void iounmap(volatile void __iomem *addr)
-{
-	if (static_branch_likely(&have_mio))
-		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
-}
-EXPORT_SYMBOL(iounmap);
-
 /* Create a virtual mapping cookie for a PCI BAR */
 static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,
 					unsigned long offset, unsigned long max)
@@ -312,7 +253,10 @@ static void __iomem *pci_iomap_range_mio(struct pci_dev *pdev, int bar,
 	struct zpci_dev *zdev = to_zpci(pdev);
 	void __iomem *iova;
 
-	iova = ioremap((unsigned long) zdev->bars[bar].mio_wt, barsize);
+	if (!static_branch_unlikely(&have_mio))
+		iova = (void __iomem *) zdev->bars[bar].mio_wt;
+	else
+		iova = ioremap((unsigned long) zdev->bars[bar].mio_wt, barsize);
 	return iova ? iova + offset : iova;
 }
 
@@ -342,7 +286,11 @@ static void __iomem *pci_iomap_wc_range_mio(struct pci_dev *pdev, int bar,
 	struct zpci_dev *zdev = to_zpci(pdev);
 	void __iomem *iova;
 
-	iova = ioremap((unsigned long) zdev->bars[bar].mio_wb, barsize);
+	if (!static_branch_unlikely(&have_mio))
+		iova = (void __iomem *) zdev->bars[bar].mio_wb;
+	else
+		iova = ioremap((unsigned long) zdev->bars[bar].mio_wb, barsize);
+
 	return iova ? iova + offset : iova;
 }
 
@@ -381,7 +329,8 @@ static void pci_iounmap_fh(struct pci_dev *pdev, void __iomem *addr)
 
 static void pci_iounmap_mio(struct pci_dev *pdev, void __iomem *addr)
 {
-	iounmap(addr);
+	if (static_branch_likely(&have_mio))
+		iounmap(addr);
 }
 
 void pci_iounmap(struct pci_dev *pdev, void __iomem *addr)
-- 
2.17.1

