From: Cornelia Huck <cohuck@redhat.com>
Date: Tue, 13 Nov 2018 12:47:54 +0000
Subject: [PULL 3/4] s390/cio: Fix cleanup of pfn_array alloc failure
Message-Id: <20181113124755.4798-4-cohuck@redhat.com>
To: linux-s390@vger.kernel.org, kvm@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Eric Farman <farman@linux.ibm.com>

If pfn_array_alloc fails somehow, we need to release the pfn_array_table
that was malloc'd earlier.

Signed-off-by: Eric Farman <farman@linux.ibm.com>
Message-Id: <20181109023937.96105-2-farman@linux.ibm.com>
Acked-by: Halil Pasic <pasic@linux.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index fd77e46eb3b2..ef5ab45d94b3 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -528,7 +528,7 @@ static int ccwchain_fetch_direct(struct ccwchain *chain,
 
 	ret = pfn_array_alloc_pin(pat->pat_pa, cp->mdev, ccw->cda, ccw->count);
 	if (ret < 0)
-		goto out_init;
+		goto out_unpin;
 
 	/* Translate this direct ccw to a idal ccw. */
 	idaws = kcalloc(ret, sizeof(*idaws), GFP_DMA | GFP_KERNEL);
-- 
2.17.2
