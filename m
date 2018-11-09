From: Eric Farman <farman@linux.ibm.com>
Date: Fri, 09 Nov 2018 02:39:36 +0000
Subject: [RFC PATCH v1 09/10] s390/cio: Eliminate the pfn_array_table struct
Message-Id: <20181109023937.96105-10-farman@linux.ibm.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The pfn_array_table struct is created as an array that is the number of
IDA Words, and each of those elements (a pfn_array struct) is itself an
array just one element long (one per IDAW, I guess).  This unnecessarily
complicates a lot of this code, when the whole point of an IDAL is to
point to an array of pages.  Since we know we have an IDAL in this code
path, we can replace this with just an array of pfn_array structs that
is itself the number of IDAWs we want and need.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 49 +++++++++++++++---------------------------
 1 file changed, 17 insertions(+), 32 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d01e146289fb..d502dcd09d9a 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -46,7 +46,7 @@ struct ccwchain {
 	/* Count of the valid ccws in chain. */
 	int			ch_len;
 	/* Pinned PAGEs for the original data. */
-	struct pfn_array_table	*ch_pat;
+	struct pfn_array	*ch_pa;
 };
 
 static int pfn_array_pin(struct pfn_array *pa, struct device *mdev)
@@ -125,14 +125,12 @@ static void pfn_array_table_unpin_free(struct pfn_array_table *pat,
 	}
 }
 
-static bool pfn_array_table_iova_pinned(struct pfn_array_table *pat,
+static bool pfn_array_table_iova_pinned(struct pfn_array *pa,
 					unsigned long iova)
 {
-	struct pfn_array *pa = pat->pat_pa;
 	unsigned long iova_pfn = iova >> PAGE_SHIFT;
 	int i, j;
 
-	for (i = 0; i < pat->pat_nr; i++, pa++)
 		for (j = 0; j < pa->pa_nr; j++)
 			if (pa->pa_iova_pfn[j] == iova_pfn)
 				return true;
@@ -141,10 +139,9 @@ static bool pfn_array_table_iova_pinned(struct pfn_array_table *pat,
 }
 /* Create the list idal words for a pfn_array_table. */
 static inline void pfn_array_table_idal_create_words(
-	struct pfn_array_table *pat,
+	struct pfn_array *pa,
 	unsigned long *idaws)
 {
-	struct pfn_array *pa;
 	int i, j, k;
 
 	/*
@@ -155,15 +152,12 @@ static inline void pfn_array_table_idal_create_words(
 	 * idaw.
 	 */
 	k = 0;
-	for (i = 0; i < pat->pat_nr; i++) {
-		pa = pat->pat_pa + i;
 		for (j = 0; j < pa->pa_nr; j++) {
 			idaws[k] = pa->pa_pfn[j] << PAGE_SHIFT;
 			if (k == 0)
 				idaws[k] += pa->pa_iova & (PAGE_SIZE - 1);
 			k++;
 		}
-	}
 }
 
 
@@ -274,7 +268,7 @@ static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 	/* Make ccw address aligned to 8. */
 	size = ((sizeof(*chain) + 7L) & -8L) +
 		sizeof(*chain->ch_ccw) * len +
-		sizeof(*chain->ch_pat) * len;
+		sizeof(*chain->ch_pa) * len;
 	chain = kzalloc(size, GFP_DMA | GFP_KERNEL);
 	if (!chain)
 		return NULL;
@@ -283,7 +277,7 @@ static struct ccwchain *ccwchain_alloc(struct channel_program *cp, int len)
 	chain->ch_ccw = (struct ccw1 *)data;
 
 	data = (u8 *)(chain->ch_ccw) + sizeof(*chain->ch_ccw) * len;
-	chain->ch_pat = (struct pfn_array_table *)data;
+	chain->ch_pa = (struct pfn_array *)data;
 
 	chain->ch_len = len;
 
@@ -471,8 +465,8 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 	idaw_len = idaw_nr * sizeof(*idaws);
 
 	/* Pin data page(s) in memory. */
-	pat = chain->ch_pat + idx;
-	ret = pfn_array_table_init(pat, idaw_nr);
+	pa = chain->ch_pa + idx;
+	ret = pfn_array_alloc(pa, idaw_nr);
 	if (ret)
 		goto out_init;
 
@@ -498,33 +492,25 @@ static int ccwchain_fetch_ccw(struct ccwchain *chain,
 	 * Build the pfn structure so we can pin the associated pages.
 	 */
 
-	for (i = 0; i < idaw_nr; i++) {
-		idaw_iova = *(idaws + i);
-		pa = pat->pat_pa + i;
-
-		ret = pfn_array_alloc(pa, 1);
-		if (ret < 0)
-			goto out_free_idaws;
+	pa->pa_iova = idaws[0];
+	for (i = 0; i < idaw_nr; i++)
+		pa->pa_iova_pfn[i] = idaws[i] >> PAGE_SHIFT;
 
-		pa->pa_iova = idaws[0];
-		pa->pa_iova_pfn[0] = idaws[i] >> PAGE_SHIFT;
-
-		ret = pfn_array_pin(pa, cp->mdev);
-		if (ret <= 0)
-			goto out_free_idaws;
-	}
+	ret = pfn_array_pin(pa, cp->mdev);
+	if (ret <= 0)
+		goto out_free_idaws;
 
 	ccw->cda = virt_to_phys(idaws);
 	ccw->flags |= CCW_FLAG_IDA;
 
-	pfn_array_table_idal_create_words(pat, idaws);
+	pfn_array_table_idal_create_words(pa, idaws);
 
 	return 0;
 
 out_free_idaws:
 	kfree(idaws);
 out_unpin:
-	pfn_array_table_unpin_free(pat, cp->mdev);
+	pfn_array_unpin_free(pa, cp->mdev);
 out_init:
 	ccw->cda = 0;
 	return ret;
@@ -643,8 +629,7 @@ void cp_free(struct channel_program *cp)
 
 	list_for_each_entry_safe(chain, temp, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++) {
-			pfn_array_table_unpin_free(chain->ch_pat + i,
-						   cp->mdev);
+			pfn_array_unpin_free(chain->ch_pa + i, cp->mdev);
 			ccwchain_cda_free(chain, i);
 		}
 		ccwchain_free(chain);
@@ -804,7 +789,7 @@ bool cp_iova_pinned(struct channel_program *cp, u64 iova)
 
 	list_for_each_entry(chain, &cp->ccwchain_list, next) {
 		for (i = 0; i < chain->ch_len; i++)
-			if (pfn_array_table_iova_pinned(chain->ch_pat + i,
+			if (pfn_array_table_iova_pinned(chain->ch_pa + i,
 							iova))
 				return true;
 	}
-- 
2.16.4
