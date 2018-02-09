From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v3 07/16] s390/mm: Make gmap_read_table EDAT1 compatible
Date: Fri,  9 Feb 2018 10:34:15 +0100
Message-ID: <1518168864-147803-8-git-send-email-frankja@linux.vnet.ibm.com>
References: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1518168864-147803-1-git-send-email-frankja@linux.vnet.ibm.com>
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

gmap_read_table has to tell us to which guest DAT level it traveled to
get the information we requested. With this information we can start
shadowing without searching for the pmd or pte a second time.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |  2 +-
 arch/s390/kvm/gaccess.c      | 17 ++++++++++-------
 arch/s390/mm/gmap.c          | 34 ++++++++++++++++++++++++----------
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index 26a31c3..e7592e1 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -128,7 +128,7 @@ void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr);
 
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val, int *fc);
 
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c24bfa7..f9c5cc0 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -987,7 +987,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	union asce asce;
 	union vaddress vaddr;
 	unsigned long ptr;
-	int rc;
+	int rc, fc = 0;
 
 	*fake = 0;
 	*dat_protection = 0;
@@ -1034,7 +1034,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rfte.val = ptr;
 			goto shadow_r2t;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rfte.i)
@@ -1060,7 +1061,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rste.val = ptr;
 			goto shadow_r3t;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rste.i)
@@ -1087,7 +1089,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rtte.val = ptr;
 			goto shadow_sgt;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rtte.i)
@@ -1123,7 +1126,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			ste.val = ptr;
 			goto shadow_pgt;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val);
+		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val, &fc);
 		if (rc)
 			return rc;
 		if (ste.i)
@@ -1170,7 +1173,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 	union vaddress vaddr;
 	union page_table_entry pte;
 	unsigned long pgt;
-	int dat_protection, fake;
+	int dat_protection, fake, fc;
 	int rc;
 
 	down_read(&sg->mm->mmap_sem);
@@ -1192,7 +1195,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 		goto shadow_page;
 	}
 	if (!rc)
-		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
+		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val, &fc);
 	if (!rc && pte.i)
 		rc = PGM_PAGE_TRANSLATION;
 	if (!rc && pte.z)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 4dafa1e..5699770 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1254,27 +1254,41 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
  *
  * Called with gmap->mm->mmap_sem in read.
  */
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
+		    int *fc)
 {
 	unsigned long address, vmaddr;
 	spinlock_t *ptl;
+	pmd_t *pmdp;
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
+		pmdp = gmap_pmd_op_walk(gmap, gaddr);
+		if (pmdp && !(pmd_val(*pmdp) & _SEGMENT_ENTRY_INVALID)) {
+			if (!pmd_large(*pmdp)) {
+				ptep = pte_alloc_map_lock(gmap->mm, pmdp, gaddr, &ptl);
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
+					gmap_pte_op_end(ptl);
+				}
+			} else {
+				address = pmd_val(*pmdp) & HPAGE_MASK;
+				address += gaddr & ~HPAGE_MASK;
 				*val = *(unsigned long *) address;
-				pte_val(*ptep) |= _PAGE_YOUNG;
-				/* Do *NOT* clear the _PAGE_INVALID bit! */
+				*fc = 1;
 				rc = 0;
 			}
-			gmap_pte_op_end(ptl);
+			gmap_pmd_op_end(gmap, pmdp);
 		}
 		if (!rc)
 			break;
-- 
2.7.4
