From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [PATCH 2/2] mm: s390: Rename gmap_pte_op_fixup
Date: Thu, 25 Jan 2018 16:33:18 +0100
Message-ID: <1516894398-12694-3-git-send-email-frankja@linux.vnet.ibm.com>
References: <86c5bd00-a552-1737-8db8-3f7b3c21057e@redhat.com>
 <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1516894398-12694-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Now we also fixup segments (pmds), so it should rather be called
gmap_fixup.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index c47964f..337fddd 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -843,7 +843,7 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 }
 
 /**
- * gmap_pte_op_fixup - force a page in and connect the gmap page table
+ * gmap_fixup - force memory in and connect the gmap table entry
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
  * @vmaddr: address in the host process address space
@@ -851,10 +851,10 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
  *
  * Returns 0 if the caller can retry __gmap_translate (might fail again),
  * -ENOMEM if out of memory and -EFAULT if anything goes wrong while fixing
- * up or connecting the gmap page table.
+ * up or connecting the gmap table entry.
  */
-static int gmap_pte_op_fixup(struct gmap *gmap, unsigned long gaddr,
-			     unsigned long vmaddr, int prot)
+static int gmap_fixup(struct gmap *gmap, unsigned long gaddr,
+		      unsigned long vmaddr, int prot)
 {
 	struct mm_struct *mm = gmap->mm;
 	unsigned int fault_flags;
@@ -1216,7 +1216,7 @@ static int gmap_protect_range(struct gmap *gmap, unsigned long gaddr,
 			vmaddr = __gmap_translate(gmap, gaddr);
 			if (IS_ERR_VALUE(vmaddr))
 				return vmaddr;
-			rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, prot);
+			rc = gmap_fixup(gmap, gaddr, vmaddr, prot);
 			if (rc)
 				return rc;
 		}
@@ -1314,7 +1314,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
 			rc = vmaddr;
 			break;
 		}
-		rc = gmap_pte_op_fixup(gmap, gaddr, vmaddr, PROT_READ);
+		rc = gmap_fixup(gmap, gaddr, vmaddr, PROT_READ);
 		if (rc)
 			break;
 	}
@@ -1462,7 +1462,7 @@ static int gmap_protect_rmap(struct gmap *sg, unsigned long raddr,
 		if (rc)
 			kfree(rmap);
 		if (rc == -EAGAIN) {
-			rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+			rc = gmap_fixup(parent, paddr, vmaddr, prot);
 			if (rc)
 				return rc;
 		}
@@ -2426,7 +2426,7 @@ int gmap_shadow_segment(struct gmap *sg, unsigned long saddr, pmd_t pmd)
 		radix_tree_preload_end();
 		if (!rc)
 			break;
-		rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+		rc = gmap_fixup(parent, paddr, vmaddr, prot);
 		if (rc)
 			break;
 	}
@@ -2519,7 +2519,7 @@ int gmap_shadow_page(struct gmap *sg, unsigned long saddr, pte_t pte)
 		radix_tree_preload_end();
 		if (!rc)
 			break;
-		rc = gmap_pte_op_fixup(parent, paddr, vmaddr, prot);
+		rc = gmap_fixup(parent, paddr, vmaddr, prot);
 		if (rc)
 			break;
 	}
-- 
2.7.4
