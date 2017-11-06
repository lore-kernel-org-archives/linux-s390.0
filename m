From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 15/22] s390/mm: GMAP read table extensions
Date: Mon,  6 Nov 2017 23:29:53 +0100
Message-ID: <1510007400-42493-16-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

gmap_read_table has to tell us to which guest DAT level it traveled to
get the information we requested. With this information we can start
shadowing without searching for the pmd or pte a second time.

* This commit will most likely merged into the read table edat
* extension or into the shadowing.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/include/asm/gmap.h |  2 +-
 arch/s390/kvm/gaccess.c      | 15 +++++++++------
 arch/s390/mm/gmap.c          |  4 +++-
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/s390/include/asm/gmap.h b/arch/s390/include/asm/gmap.h
index dfd50d7..ff6b2d0 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -116,7 +116,7 @@ void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr);
 
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val, int *fc);
 
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index 3cc7739..4bd15a9f 100644
--- a/arch/s390/kvm/gaccess.c
+++ b/arch/s390/kvm/gaccess.c
@@ -986,7 +986,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 	union asce asce;
 	union vaddress vaddr;
 	unsigned long ptr;
-	int rc;
+	int rc, fc = 0;
 
 	*fake = 0;
 	*dat_protection = 0;
@@ -1033,7 +1033,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rfte.val = ptr;
 			goto shadow_r2t;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rfx * 8, &rfte.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rfte.i)
@@ -1059,7 +1060,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rste.val = ptr;
 			goto shadow_r3t;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rsx * 8, &rste.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rste.i)
@@ -1086,7 +1088,8 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			rtte.val = ptr;
 			goto shadow_sgt;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val);
+		rc = gmap_read_table(parent, ptr + vaddr.rtx * 8, &rtte.val,
+				     &fc);
 		if (rc)
 			return rc;
 		if (rtte.i)
@@ -1122,7 +1125,7 @@ static int kvm_s390_shadow_tables(struct gmap *sg, unsigned long saddr,
 			ste.val = ptr;
 			goto shadow_pgt;
 		}
-		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val);
+		rc = gmap_read_table(parent, ptr + vaddr.sx * 8, &ste.val, &fc);
 		if (rc)
 			return rc;
 		if (ste.i)
@@ -1191,7 +1194,7 @@ int kvm_s390_shadow_fault(struct kvm_vcpu *vcpu, struct gmap *sg,
 		goto shadow_page;
 	}
 	if (!rc)
-		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val);
+		rc = gmap_read_table(sg->parent, pgt + vaddr.px * 8, &pte.val, &fc);
 	if (!rc && pte.i)
 		rc = PGM_PAGE_TRANSLATION;
 	if (!rc && pte.z)
diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index f6a28d9..bc77688 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1204,7 +1204,8 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
  *
  * Called with gmap->mm->mmap_sem in read.
  */
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
+		    int *fc)
 {
 	unsigned long address, vmaddr;
 	spinlock_t *ptl;
@@ -1243,6 +1244,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 					address = pmd_val(pmd) & HPAGE_MASK;
 					address += gaddr & ~HPAGE_MASK;
 					*val = *(unsigned long *) address;
+					*fc = 1;
 					rc = 0;
 				}
 			}
-- 
2.7.4
