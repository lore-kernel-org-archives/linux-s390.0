From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 13/22] s390/mm: Make gmap_read_table EDAT1 compatible
Date: Mon,  6 Nov 2017 23:29:51 +0100
Message-ID: <1510007400-42493-14-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

For the VSIE we shadow the GMAP/DAT tables that a guest N builds for
its N + 1 guest. This means we read the GMAP from the memory of guest
N and use the retrieved information to build a shadow version from it
which is actually used to run the guest.

gmap_read_table is used to retrieve the data from the guest's address
space. Unfortunately it currently has no support for reading from huge
guests, so let's add that.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 44 +++++++++++++++++++++++++++++++++-----------
 1 file changed, 33 insertions(+), 11 deletions(-)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 69a575b..c8296bc 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1208,23 +1208,45 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 {
 	unsigned long address, vmaddr;
 	spinlock_t *ptl;
+	pmd_t *pmdp, pmd;
 	pte_t *ptep, pte;
 	int rc;
 
 	while (1) {
 		rc = -EAGAIN;
-		ptep = gmap_pte_op_walk(gmap, gaddr, &ptl);
-		if (ptep) {
-			pte = *ptep;
-			if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
-				address = pte_val(pte) & PAGE_MASK;
-				address += gaddr & ~PAGE_MASK;
-				*val = *(unsigned long *) address;
-				pte_val(*ptep) |= _PAGE_YOUNG;
-				/* Do *NOT* clear the _PAGE_INVALID bit! */
-				rc = 0;
+		pmdp = gmap_pmd_op_walk(gmap, gaddr);
+		if (pmdp) {
+			if (!pmd_large(*pmdp)) {
+				ptl = NULL;
+				ptep = NULL;
+				if (gmap_is_shadow(gmap))
+					ptep = pte_offset_map(pmdp, gaddr);
+				else
+					ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
+
+				if (ptep) {
+					pte = *ptep;
+					if (pte_present(pte) && (pte_val(pte) & _PAGE_READ)) {
+						address = pte_val(pte) & PAGE_MASK;
+						address += gaddr & ~PAGE_MASK;
+						*val = *(unsigned long *) address;
+						pte_val(*ptep) |= _PAGE_YOUNG;
+						/* Do *NOT* clear the _PAGE_INVALID bit! */
+						rc = 0;
+					}
+					if (ptl)
+						gmap_pte_op_end(ptl);
+				}
+			} else {
+				pmd = *pmdp;
+				if (!(pmd_val(pmd) & _SEGMENT_ENTRY_INVALID)) {
+					address = pmd_val(pmd) & HPAGE_MASK;
+					address += gaddr & ~HPAGE_MASK;
+					*val = *(unsigned long *) address;
+					rc = 0;
+				}
 			}
-			gmap_pte_op_end(ptl);
+			gmap_pmd_op_end(gmap, pmdp);
 		}
 		if (!rc)
 			break;
-- 
2.7.4
