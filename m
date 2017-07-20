From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Subject: [PATCH 1/1] vfio: ccw: fix bad ptr math for TIC cda translation
Date: Thu, 20 Jul 2017 05:19:50 +0200
Message-ID: <20170720031950.64438-2-bjsdjshi@linux.vnet.ibm.com>
References: <20170720031950.64438-1-bjsdjshi@linux.vnet.ibm.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20170720031950.64438-1-bjsdjshi@linux.vnet.ibm.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: cohuck@redhat.com, borntraeger@de.ibm.com, bjsdjshi@linux.vnet.ibm.com, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

When we are translating channel data addresses from guest to host
address space for TIC instructions we are getting incorrect
addresses because of a pointer arithmetic error.

We currently calculate the offset of the TIC's cda from the start
of the channel program chain (ccw->cda - ccw_head). We then add
that to the address of the ccw chain in host memory (iter->ch_ccw).
The problem is that iter->ch_ccw is a poiner to struct ccw1 so
when we increment it we are actually incrementing by the size of
struct ccw1 which is 8 bytes. The intent was to increment by
n-bytes, not n*8.

The fix: cast iter->ch_ccw to char* so it will be incremented by
n*1.

Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index ba6ac83a6c25..5ccfdc80d0ec 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -481,7 +481,7 @@ static int ccwchain_fetch_tic(struct ccwchain *chain,
 		ccw_tail = ccw_head + (iter->ch_len - 1) * sizeof(struct ccw1);
 
 		if ((ccw_head <= ccw->cda) && (ccw->cda <= ccw_tail)) {
-			ccw->cda = (__u32) (addr_t) (iter->ch_ccw +
+			ccw->cda = (__u32) (addr_t) (((char *)iter->ch_ccw) +
 						     (ccw->cda - ccw_head));
 			return 0;
 		}
-- 
2.11.2
