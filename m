From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/2] vfio: ccw: bypass bad idaw address when fetching IDAL ccws
Date: Mon, 16 Oct 2017 11:50:35 +0200
Message-ID: <20171016095036.27637-2-cohuck@redhat.com>
References: <20171016095036.27637-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171016095036.27637-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>

We currently return the same error code (-EFAULT) to indicate two
different error cases:
1. a bug in vfio-ccw implementation has been found.
2. a buggy channel program has been detected.

This brings difficulty for userland program (specifically Qemu) to
handle.

Let's use -EFAULT to only indicate the first case. For the second
case, we simply hand over the ccws to lower level for further
handling.

Notice:
Once a bad idaw address is detected, the current behavior is to
suppress the ssch. With this fix, the channel program will be
accepted, and part of the channel program (the part ahead of
the bad idaw) could possibly be executed by the device before
I/O conclusion.

Suggested-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Signed-off-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Message-Id: <20171011023822.42948-2-bjsdjshi@linux.vnet.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 5ccfdc80d0ec..722f8b8c7273 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -569,10 +569,6 @@ static int ccwchain_fetch_idal(struct ccwchain *chain,
 
 	for (i = 0; i < idaw_nr; i++) {
 		idaw_iova = *(idaws + i);
-		if (IS_ERR_VALUE(idaw_iova)) {
-			ret = -EFAULT;
-			goto out_free_idaws;
-		}
 
 		ret = pfn_array_alloc_pin(pat->pat_pa + i, cp->mdev,
 					  idaw_iova, 1);
-- 
2.13.6
