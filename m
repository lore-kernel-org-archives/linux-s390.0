From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 31 Jul 2018 08:43:54 +0000
Subject: [GIT PULL 08/19] s390/mm: Add gmap pmd linking
Message-Id: <20180731084405.28953-9-borntraeger@de.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Janosch Frank <frankja@linux.ibm.com>

Let's allow pmds to be linked into gmap for the upcoming s390 KVM huge
page support.

Before this patch we copied the full userspace pmd entry. This is not
correct, as it contains SW defined bits that might be interpreted
differently in the GMAP context. Now we only copy over all hardware
relevant information leaving out the software bits.

Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
Reviewed-by: David Hildenbrand <david@redhat.com>
---
 arch/s390/include/asm/pgtable.h |  6 ++++--
 arch/s390/mm/gmap.c             | 13 +++++++++----
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index 5ab636089c60..fe36b3bb2afd 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -268,8 +268,10 @@ static inline int is_module_addr(void *addr)
 #define _REGION_ENTRY_BITS_LARGE 0xffffffff8000fe2fUL
 
 /* Bits in the segment table entry */
-#define _SEGMENT_ENTRY_BITS	0xfffffffffffffe33UL
-#define _SEGMENT_ENTRY_BITS_LARGE 0xfffffffffff0ff33UL
+#define _SEGMENT_ENTRY_BITS			0xfffffffffffffe33UL
+#define _SEGMENT_ENTRY_BITS_LARGE		0xfffffffffff0ff33UL
+#define _SEGMENT_ENTRY_HARDWARE_BITS		0xfffffffffffffe30UL
+#define _SEGMENT_ENTRY_HARDWARE_BITS_LARGE	0xfffffffffff00730UL
 #define _SEGMENT_ENTRY_ORIGIN_LARGE ~0xfffffUL /* large page address	    */
 #define _SEGMENT_ENTRY_ORIGIN	~0x7ffUL/* page table origin		    */
 #define _SEGMENT_ENTRY_PROTECT	0x200	/* segment protection bit	    */
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 0bada5e097cb..870e81fcb0cf 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -596,10 +596,15 @@ int __gmap_link(struct gmap *gmap, unsigned long gaddr, unsigned long vmaddr)
 	if (*table == _SEGMENT_ENTRY_EMPTY) {
 		rc = radix_tree_insert(&gmap->host_to_guest,
 				       vmaddr >> PMD_SHIFT, table);
-		if (!rc)
-			*table = pmd_val(*pmd);
-	} else
-		rc = 0;
+		if (!rc) {
+			if (pmd_large(*pmd)) {
+				*table = pmd_val(*pmd) &
+					_SEGMENT_ENTRY_HARDWARE_BITS_LARGE;
+			} else
+				*table = pmd_val(*pmd) &
+					_SEGMENT_ENTRY_HARDWARE_BITS;
+		}
+	}
 	spin_unlock(&gmap->guest_table_lock);
 	spin_unlock(ptl);
 	radix_tree_preload_end();
-- 
2.17.0
