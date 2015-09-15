Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Kuleshov <kuleshovmail@gmail.com>
Subject: [PATCH 2/2] s390/crash_dump: Use PFN_PHYS and PFN_DOWN macros
Date: Wed, 16 Sep 2015 00:54:38 +0600
Message-Id: <1442343278-10641-1-git-send-email-kuleshovmail@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Michael Holzheu <holzheu@linux.vnet.ibm.com>, Tony Luck <tony.luck@intel.com>, David Hildenbrand <dahi@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Alexander Kuleshov <kuleshovmail@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

The <linux/pfn.h> provides PFN_PHYS and PFN_DOWN macros for the
getting page frame number and physical address of a page frame number.
This patch replaces (pfn << PAGE_SHIFT) and (addr >> PAGE_SHIFT)
expressions with the PFN_PHYS and PFN_DOWN macros.

Signed-off-by: Alexander Kuleshov <kuleshovmail@gmail.com>
---
 arch/s390/kernel/crash_dump.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/arch/s390/kernel/crash_dump.c b/arch/s390/kernel/crash_dump.c
index 1e4fcfa..f8da32c 100644
--- a/arch/s390/kernel/crash_dump.c
+++ b/arch/s390/kernel/crash_dump.c
@@ -136,7 +136,7 @@ ssize_t copy_oldmem_page(unsigned long pfn, char *buf, size_t csize,
 
 	if (!csize)
 		return 0;
-	src = (pfn << PAGE_SHIFT) + offset;
+	src = (PFN_PHYS(pfn)) + offset;
 	if (OLDMEM_BASE)
 		return copy_oldmem_page_kdump(buf, csize, src, userbuf);
 	else
@@ -156,16 +156,17 @@ static int remap_oldmem_pfn_range_kdump(struct vm_area_struct *vma,
 	unsigned long size_old;
 	int rc;
 
-	if (pfn < OLDMEM_SIZE >> PAGE_SHIFT) {
-		size_old = min(size, OLDMEM_SIZE - (pfn << PAGE_SHIFT));
+	if (pfn < PFN_DOWN(OLDMEM_SIZE)) {
+		size_old = min(size,
+			OLDMEM_SIZE - (unsigned long)(PFN_PHYS(pfn)));
 		rc = remap_pfn_range(vma, from,
-				     pfn + (OLDMEM_BASE >> PAGE_SHIFT),
+				     pfn + (PFN_DOWN(OLDMEM_BASE)),
 				     size_old, prot);
 		if (rc || size == size_old)
 			return rc;
 		size -= size_old;
 		from += size_old;
-		pfn += size_old >> PAGE_SHIFT;
+		pfn += PFN_DOWN(size_old);
 	}
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
@@ -184,13 +185,14 @@ static int remap_oldmem_pfn_range_zfcpdump(struct vm_area_struct *vma,
 	unsigned long hsa_end = sclp.hsa_size;
 	unsigned long size_hsa;
 
-	if (pfn < hsa_end >> PAGE_SHIFT) {
-		size_hsa = min(size, hsa_end - (pfn << PAGE_SHIFT));
+	if (pfn < PFN_DOWN(hsa_end)) {
+		size_hsa = min(size,
+			hsa_end - (unsigned long)(PFN_PHYS(pfn)));
 		if (size == size_hsa)
 			return 0;
 		size -= size_hsa;
 		from += size_hsa;
-		pfn += size_hsa >> PAGE_SHIFT;
+		pfn += PFN_DOWN(size_hsa);
 	}
 	return remap_pfn_range(vma, from, pfn, size, prot);
 }
-- 
2.5.0
