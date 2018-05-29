From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 3/6] vfio: ccw: shorten kernel doc description for pfn_array_pin()
Date: Tue, 29 May 2018 14:35:09 +0200
Message-ID: <20180529123512.14393-4-cohuck@redhat.com>
References: <20180529123512.14393-1-cohuck@redhat.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180529123512.14393-1-cohuck@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.ibm.com>

The kernel doc description for usage of the struct pfn_array in
pfn_array_pin() is unnecessary long. Let's shorten it by describing
the contents of the struct pfn_array fields at the struct's definition
instead.

Suggested-by: Cornelia Huck <cohuck@redhat.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.ibm.com>
Message-Id: <20180523025645.8978-2-bjsdjshi@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 9a2a39df1056..c532939c1c3f 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -23,9 +23,13 @@
 #define CCWCHAIN_LEN_MAX	256
 
 struct pfn_array {
+	/* Starting guest physical I/O address. */
 	unsigned long		pa_iova;
+	/* Array that stores PFNs of the pages need to pin. */
 	unsigned long		*pa_iova_pfn;
+	/* Array that receives PFNs of the pages pinned. */
 	unsigned long		*pa_pfn;
+	/* Number of pages to pin/pinned from @pa_iova. */
 	int			pa_nr;
 };
 
@@ -53,14 +57,8 @@ struct ccwchain {
  * Attempt to pin user pages in memory.
  *
  * Usage of pfn_array:
- * @pa->pa_iova     starting guest physical I/O address. Assigned by caller.
- * @pa->pa_iova_pfn array that stores PFNs of the pages need to pin. Allocated
- *                  by caller.
- * @pa->pa_pfn      array that receives PFNs of the pages pinned. Allocated by
- *                  caller.
- * @pa->pa_nr       number of pages from @pa->pa_iova to pin. Assigned by
- *                  caller.
- *                  number of pages pinned. Assigned by callee.
+ * Any field in this structure should be initialized by caller.
+ * We expect @pa->pa_nr > 0, and its value will be assigned by callee.
  *
  * Returns:
  *   Number of pages pinned on success.
-- 
2.14.3
