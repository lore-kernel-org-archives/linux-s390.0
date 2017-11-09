From: Cornelia Huck <cohuck@redhat.com>
Subject: [PULL 1/1] s390: vfio-ccw: Do not attempt to free no-op, test and tic cda.
Date: Thu,  9 Nov 2017 17:21:20 +0100
Message-ID: <20171109162120.27453-2-cohuck@redhat.com>
References: <20171109162120.27453-1-cohuck@redhat.com>
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <20171109162120.27453-1-cohuck@redhat.com>
Sender: kvm-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: bjsdjshi@linux.vnet.ibm.com, borntraeger@de.ibm.com, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Jason J. Herne" <jjherne@linux.vnet.ibm.com>, Cornelia Huck <cohuck@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

From: "Jason J. Herne" <jjherne@linux.vnet.ibm.com>

Because we do not make use of the cda (channel data address) for test,
no-op ccws no address translation takes place. This means cda could
contain a guest address which we do not want to attempt to free. Let's
check the command type and skip cda free when it is not needed.

For a TIC ccw, ccw->cda points to either a ccw in an existing chain or
it points to a whole new allocated chain. In either case the data will
be freed when the owning chain is freed.

Signed-off-by: Jason J. Herne <jjherne@linux.vnet.ibm.com>
Reviewed-by: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Reviewed-by: Pierre Morel <pmorel@linux.vnet.ibm.com>
Message-Id: <1510068152-21988-1-git-send-email-jjherne@linux.vnet.ibm.com>
Reviewed-by: Halil Pasic <pasic@linux.vnet.ibm.com>
Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>
Signed-off-by: Cornelia Huck <cohuck@redhat.com>
---
 drivers/s390/cio/vfio_ccw_cp.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index d8f98ad9b029..7ebbd8b482f5 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -332,6 +332,8 @@ static void ccwchain_cda_free(struct ccwchain *chain, int idx)
 {
 	struct ccw1 *ccw = chain->ch_ccw + idx;
 
+	if (ccw_is_test(ccw) || ccw_is_noop(ccw) || ccw_is_tic(ccw))
+		return;
 	if (!ccw->count)
 		return;
 
-- 
2.13.6
