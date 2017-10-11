From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 2/2] vfio: ccw: validate the count field of a ccw before pinning
Date: Wed, 11 Oct 2017 04:38:22 +0200
Message-ID: <20171011023822.42948-3-bjsdjshi@linux.vnet.ibm.com>
References: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171011023822.42948-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

If the count field of a ccw is zero, there is no need to
try to pin page(s) for it. Let's check the count value
before starting pinning operations.

Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 722f8b8c7273..d8f98ad9b029 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -105,7 +105,10 @@ static int pfn_array_alloc_pin(struct pfn_array *pa, struct device *mdev,
 {
 	int ret = 0;
 
-	if (!len || pa->pa_nr)
+	if (!len)
+		return 0;
+
+	if (pa->pa_nr)
 		return -EINVAL;
 
 	pa->pa_iova = iova;
@@ -501,6 +504,16 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 
 	ccw = chain->ch_ccw + idx;
 
+	if (!ccw->count) {
+		/*
+		 * We just want the translation result of any direct ccw
+		 * to be an IDA ccw, so let's add the IDA flag for it.
+		 * Although the flag will be ignored by firmware.
+		 */
+		ccw->flags |= CCW_FLAG_IDA;
+		return 0;
+	}
+
 	/*
 	 * Pin data page(s) in memory.
 	 * The number of pages actually is the count of the idaws which will be
@@ -541,6 +554,9 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 
 	ccw = chain->ch_ccw + idx;
 
+	if (!ccw->count)
+		return 0;
+
 	/* Calculate size of idaws. */
 	ret = copy_from_iova(cp->mdev, &idaw_iova, ccw->cda, sizeof(idaw_iova));
 	if (ret)
-- 
2.13.5
