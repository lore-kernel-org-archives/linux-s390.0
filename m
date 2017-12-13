From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH v2 15/22] s390/mm: GMAP read table extensions
Date: Wed, 13 Dec 2017 13:53:26 +0100
Message-ID: <1513169613-13509-16-git-send-email-frankja@linux.vnet.ibm.com>
References: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1513169613-13509-1-git-send-email-frankja@linux.vnet.ibm.com>
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
index 518e00c..24c2f86 100644
--- a/arch/s390/include/asm/gmap.h
+++ b/arch/s390/include/asm/gmap.h
@@ -117,7 +117,7 @@ void gmap_discard(struct gmap *, unsigned long from, unsigned long to);
 void __gmap_zap(struct gmap *, unsigned long gaddr);
 void gmap_unlink(struct mm_struct *, unsigned long *table, unsigned long vmaddr);
 
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val);
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val, int *fc);
 
 struct gmap *gmap_shadow(struct gmap *parent, unsigned long asce,
 			 int edat_level);
diff --git a/arch/s390/kvm/gaccess.c b/arch/s390/kvm/gaccess.c
index c24bfa7..ebea9ec 100644
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
index d45ac26da..8833d2a 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -1197,7 +1197,8 @@ EXPORT_SYMBOL_GPL(gmap_mprotect_notify);
  *
  * Called with gmap->mm->mmap_sem in read.
  */
-int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
+int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val,
+		    int *fc)
 {
 	unsigned long address, vmaddr;
 	spinlock_t *ptl;
@@ -1229,6 +1230,7 @@ int gmap_read_table(struct gmap *gmap, unsigned long gaddr, unsigned long *val)
 					address = pmd_val(pmd) & HPAGE_MASK;
 					address += gaddr & ~HPAGE_MASK;
 					*val = *(unsigned long *) address;
+					*fc = 1;
 					rc = 0;
 				}
 			}
-- 
2.7.4
