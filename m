From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:37 +0000
Subject: [RFC PATCH v1 10/10] s390/cio: Remove unused function/variables FIXUP
Message-Id: <20181109023937.96105-11-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This should be squashed into the previous commit.  It removes things that
that are no longer used, and thus causing compiler warnings, but is split
out to help with the readability of the refactoring that happened in the
previous commit.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 70 ++++++++++--------------------------------
 1 file changed, 16 insertions(+), 54 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d502dcd09d9a..ee3be5391edc 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -33,11 +33,6 @@ struct pfn_array {
 	int			pa_nr;
 };
 
-struct pfn_array_table {
-	struct pfn_array	*pat_pa;
-	int			pat_nr;
-};
-
 struct ccwchain {
 	struct list_head	next;
 	struct ccw1		*ch_ccw;
@@ -97,52 +92,24 @@ static void pfn_array_unpin_free(struct pfn_array *pa, struct device *mdev)
 	kfree(pa->pa_iova_pfn);
 }
 
-static int pfn_array_table_init(struct pfn_array_table *pat, int nr)
-{
-	pat->pat_pa = kcalloc(nr, sizeof(*pat->pat_pa), GFP_KERNEL);
-	if (unlikely(ZERO_OR_NULL_PTR(pat->pat_pa))) {
-		pat->pat_nr = 0;
-		return -ENOMEM;
-	}
-
-	pat->pat_nr = nr;
-
-	return 0;
-}
-
-static void pfn_array_table_unpin_free(struct pfn_array_table *pat,
-				       struct device *mdev)
-{
-	int i;
-
-	for (i = 0; i < pat->pat_nr; i++)
-		pfn_array_unpin_free(pat->pat_pa + i, mdev);
-
-	if (pat->pat_nr) {
-		kfree(pat->pat_pa);
-		pat->pat_pa = NULL;
-		pat->pat_nr = 0;
-	}
-}
-
-static bool pfn_array_table_iova_pinned(struct pfn_array *pa,
-					unsigned long iova)
+static bool pfn_array_iova_pinned(struct pfn_array *pa,
+				  unsigned long iova)
 {
 	unsigned long iova_pfn = iova >> PAGE_SHIFT;
-	int i, j;
+	int i;
 
-		for (j = 0; j < pa->pa_nr; j++)
-			if (pa->pa_iova_pfn[j] == iova_pfn)
-				return true;
+	for (i = 0; i < pa->pa_nr; i++)
+		if (pa->pa_iova_pfn[i] == iova_pfn)
+			return true;
 
 	return false;
 }
-/* Create the list idal words for a pfn_array_table. */
-static inline void pfn_array_table_idal_create_words(
+
+static inline void pfn_array_idal_create_words(
 	struct pfn_array *pa,
 	unsigned long *idaws)
 {
-	int i, j, k;
+	int i;
 
 	/*
 	 * Idal words (execept the first one) rely on the memory being 4k
@@ -151,15 +118,12 @@ static inline void pfn_array_table_idal_create_words(
 	 * there will be no problem here to simply use the phys to create an
 	 * idaw.
 	 */
-	k = 0;
-		for (j = 0; j < pa->pa_nr; j++) {
-			idaws[k] = pa->pa_pfn[j] << PAGE_SHIFT;
-			if (k == 0)
-				idaws[k] += pa->pa_iova & (PAGE_SIZE - 1);
-			k++;
-		}
-}
 
+	for (i = 0; i < pa->pa_nr; i++)
+		idaws[i] = pa->pa_pfn[i] << PAGE_SHIFT;
+
+	idaws[0] += pa->pa_iova & (PAGE_SIZE - 1);
+}
 
 /*
  * Within the domain (@mdev), copy @n bytes from a guest physical
@@ -431,7 +395,6 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 			      struct channel_program *cp)
 {
 	struct ccw1 *ccw;
-	struct pfn_array_table *pat;
 	struct pfn_array *pa;
 	unsigned long *idaws;
 	u64 idaw_iova;
@@ -503,7 +466,7 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 	ccw->cda = virt_to_phys(idaws);
 	ccw->flags |= CCW_FLAG_IDA;
 
-	pfn_array_table_idal_create_words(pa, idaws);
+	pfn_array_idal_create_words(pa, idaws);
 
 	return 0;
 
@@ -789,8 +752,7 @@ bool cp_iova_pinned(struct channel_program *cp, u64 iova)
 
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (pfn_array_table_iova_pinned(chain->ch_pa + i,
-							iova))
+			if (pfn_array_iova_pinned(chain->ch_pa + i, iova))
 				return true;
 	}
 
-- 
2.16.4
