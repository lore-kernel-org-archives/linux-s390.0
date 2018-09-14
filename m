From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Fri, 14 Sep 2018 12:56:22 +0000
Subject: [GIT PULL 1/2] s390/mm: Check for valid vma before zapping in gmap_discard
Message-Id: <20180914125623.89084-2-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Userspace could have munmapped the area before doing unmapping from
the gmap. This would leave us with a valid vmaddr, but an invalid vma
from which we would try to zap memory.

Let's check before using the vma.

Fixes: 1e133ab296f3 ("s390/mm: split arch/s390/mm/pgtable.c")
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
Message-Id: <20180816082432.78828-1-frankja@linux.ibm.com>
Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
---
 arch/s390/mm/gmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index bb44990c8212..911c7ded35f1 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -708,11 +708,13 @@ void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 		vmaddr |= gaddr & ~PMD_MASK;
 		/* Find vma in the parent mm */
 		vma = find_vma(gmap->mm, vmaddr);
+		if (!vma)
+			continue;
 		/*
 		 * We do not discard pages that are backed by
 		 * hugetlbfs, so we don't have to refault them.
 		 */
-		if (vma && is_vm_hugetlb_page(vma))
+		if (is_vm_hugetlb_page(vma))
 			continue;
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
 		zap_page_range(vma, vmaddr, size);
-- 
2.17.0
