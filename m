From: Janosch Frank <frankja@linux.vnet.ibm.com>
Subject: [RFC/PATCH 06/22] s390/mm: Introduce gmap_pmdp_xchg
Date: Mon,  6 Nov 2017 23:29:44 +0100
Message-ID: <1510007400-42493-7-git-send-email-frankja@linux.vnet.ibm.com>
References: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <1510007400-42493-1-git-send-email-frankja@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: kvm@vger.kernel.org
Cc: schwidefsky@de.ibm.com, borntraeger@de.ibm.com, david@redhat.com, dominik.dingel@gmail.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When changing guest pmds, we don't need to take care of the
corresponding host pmd. This means, we don't need to flush the host
TLB entries and we don't need to notify on all gmaps.

Let's introduce a function, that exchanges a pmd and takes care of the
necessary flushing and notification.

Signed-off-by: Janosch Frank <frankja@linux.vnet.ibm.com>
---
 arch/s390/mm/gmap.c | 49 +++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 49 insertions(+)

diff --git a/arch/s390/mm/gmap.c b/arch/s390/mm/gmap.c
index 2c0cc16..d0d56f6 100644
--- a/arch/s390/mm/gmap.c
+++ b/arch/s390/mm/gmap.c
@@ -22,6 +22,9 @@
 
 #define GMAP_SHADOW_FAKE_TABLE 1ULL
 
+static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *old, pmd_t new,
+			   unsigned long gaddr);
+
 /**
  * gmap_alloc - allocate and initialize a guest address space
  * @mm: pointer to the parent mm_struct
@@ -2240,6 +2243,26 @@ void ptep_notify(struct mm_struct *mm, unsigned long vmaddr,
 EXPORT_SYMBOL_GPL(ptep_notify);
 
 /**
+ * pmdp_notify_gmap - call all invalidation callbacks for a specific pmd
+ * @gmap: pointer to the guest address space structure
+ * @gaddr: guest address which is affected
+ *
+ * This function is expected to be called with a locked
+ * guest_table_lock.
+ */
+static void pmdp_notify_gmap(struct gmap *gmap, unsigned long gaddr)
+{
+	unsigned long *table;
+
+	gaddr &= HPAGE_MASK;
+	table = gmap_table_walk(gmap, gaddr, 1);
+	if (!table || !(*table & _SEGMENT_ENTRY_GMAP_IN))
+		return;
+	*table &= ~_SEGMENT_ENTRY_GMAP_IN;
+	gmap_call_notifier(gmap, gaddr, gaddr + HPAGE_SIZE - 1);
+}
+
+/**
  * pmdp_notify - call all invalidation callbacks for a specific pmd
  * @mm: pointer to the process mm_struct
  * @vmaddr: virtual address in the process address space
@@ -2383,6 +2406,32 @@ void gmap_pmdp_idte_global(struct mm_struct *mm, unsigned long vmaddr)
 }
 EXPORT_SYMBOL_GPL(gmap_pmdp_idte_global);
 
+/**
+ * gmap_pmdp_xchg - exchange a gmap pmd with another and notify
+ * @gmap: pointer to the guest address space structure
+ * @pmdp: pointer to the pmd entry
+ * @new: replacement entry
+ * @gaddr: the affected guest address
+ *
+ * This function is assumed to be called with the guest_table_lock
+ * held.
+ */
+static void gmap_pmdp_xchg(struct gmap *gmap, pmd_t *pmdp, pmd_t new,
+			   unsigned long gaddr)
+{
+	pmdp_notify_gmap(gmap, gaddr);
+	if (MACHINE_HAS_TLB_GUEST)
+		__pmdp_idte(gaddr, (pmd_t *)pmdp,
+			    IDTE_GUEST_ASCE, gmap->asce,
+			    IDTE_GLOBAL);
+	if (MACHINE_HAS_IDTE)
+		__pmdp_idte(gaddr, (pmd_t *)pmdp,
+			    0, 0, IDTE_GLOBAL);
+	else
+		__pmdp_csp(pmdp);
+	*pmdp = new;
+}
+
 static inline void thp_split_mm(struct mm_struct *mm)
 {
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-- 
2.7.4
