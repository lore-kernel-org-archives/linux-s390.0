From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 18/22] s390/mm: Remove gmap_pte_op_walk
Date: Mon,  6 Nov 2017 23:29:56 +0100
Message-ID: <1510007400-42493-19-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

After the large page support was added, there are no more users of
this function. Let's get rid of it.

Might be squashed later on into the previous commit.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 32 --------------------------------
 1 file changed, 32 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 91a0824..95d15e2 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -830,38 +830,6 @@ static inline unsigned long *gmap_table_walk(struct gmap *gmap,
 }
 
 /**
- * gmap_pte_op_walk - walk the gmap page table, get the page table lock
- *		      and return the pte pointer
- * @gmap: pointer to guest mapping meta data structure
- * @gaddr: virtual address in the guest address space
- * @ptl: pointer to the spinlock pointer
- *
- * Returns a pointer to the locked pte for a guest address, or NULL
- *
- * Note: Can also be called for shadow gmaps.
- */
-static pte_t *gmap_pte_op_walk(struct gmap *gmap, unsigned long gaddr,
-			       spinlock_t **ptl)
-{
-	unsigned long *table;
-
-	if (gmap_is_shadow(gmap))
-		spin_lock(&gmap->guest_table_lock);
-	/* Walk the gmap page table, lock and get pte pointer */
-	table = gmap_table_walk(gmap, gaddr, 1); /* get segment pointer */
-	if (!table || *table & _SEGMENT_ENTRY_INVALID) {
-		if (gmap_is_shadow(gmap))
-			spin_unlock(&gmap->guest_table_lock);
-		return NULL;
-	}
-	if (gmap_is_shadow(gmap)) {
-		*ptl = &gmap->guest_table_lock;
-		return pte_offset_map((pmd_t *) table, gaddr);
-	}
-	return pte_alloc_map_lock(gmap->mm, (pmd_t *) table, gaddr, ptl);
-}
-
-/**
  * gmap_pte_op_fixup - force a page in and connect the gmap page table
  * @gmap: pointer to guest mapping meta data structure
  * @gaddr: virtual address in the guest address space
-- 
2.7.4
