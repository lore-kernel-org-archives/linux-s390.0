From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 14/16] s390/mm: hugetlb pages within a gmap can not be freed
Date: Fri,  9 Feb 2018 10:34:22 +0100
Message-ID: <1518168864-147803-15-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Dominik Dingel <dingel@linux.vnet.ibm.com>

Guests backed by huge pages could theoretically free unused pages via
the diagnose 10 instruction. We currently don't allow that, so we
don't have to refault it once it's needed again.

Signed-off-by: Dominik Dingel <dingel@linux.vnet.ibm.com>
Reviewed-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 arch/s390/mm/gmap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 482bbf1..0b81863 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -722,6 +722,9 @@ void gmap_discard(struct gmap *gmap, unsigned long from, unsigned long to)
 		vmaddr |= gaddr & ~PMD_MASK;
 		/* Find vma in the parent mm */
 		vma = find_vma(gmap->mm, vmaddr);
+		/* We do not discard pages that are backed by hugetlbfs */
+		if (vma && is_vm_hugetlb_page(vma))
+			continue;
 		size = min(to - gaddr, PMD_SIZE - (gaddr & ~PMD_MASK));
 		zap_page_range(vma, vmaddr, size);
 	}
-- 
2.7.4
