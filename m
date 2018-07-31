From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:44:03 +0000
Subject: [GIT PULL 17/19] s390/mm: hugetlb pages within a gmap can not be freed
Message-Id: <20180731084405.28953-18-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Guests backed by huge pages could theoretically free unused pages via
the diagnose 10 instruction. We currently don't allow that, so we
don't have to refault it once it's needed again.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index a6738c0c4499..736ed32a83c5 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -706,6 +706,12 @@ void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 		vmaddr |= gaddr & ~PMD_MASK;
 		/* Find vma in the parent mm */
 		vma = find_vma(gmap->mm, vmaddr);
+		/*
+		 * We do not discard pages that are backed by
+		 * hugetlbfs, so we don't have to refault them.
+		 */
+		if (vma && is_vm_hugetlb_page(vma))
+			continue;
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
 		zap_page_range(vma, vmaddr, size);
 	}
-- 
2.17.0
