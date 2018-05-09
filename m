From: Halil Pasic <pasic@linux.ibm.com>
Subject: [PATCH 1/1] s390: vfio-ccw: push down unsupported IDA check
Date: Wed,  9 May 2018 19:36:47 +0200
Message-ID: <20180509173647.61367-1-pasic@linux.ibm.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/kvm/>
List-Post: <mailto:kvm@vger.kernel.org>
To: Cornelia Huck <cohuck@redhat.com>, Dong Jia Shi <bjsdjshi@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

There is at least one relevant control program (CP) that don't set the
IDA flags in the ORB as we would like them, but never uses any IDA. So
instead of saying -EOPNOTSUPP when observing an ORB such that a channel
program specified by it could be a not supported one, let us say
-EOPNOTSUPP only if the channel program is a not supported one.

Of course, the real solution would be doing proper translation for all
IDA. This is possible, but given the current code not straight forward.

Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
Tested-by: Jason J. Herne <jjherne@linux.ibm.com>
---

QEMU counterpart comming soon.
---
 drivers/s390/cio/vfio_ccw_cp.c | 19 ++++++++++++++++---
 1 file changed, 16 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 2c7550797ec2..adfff492dc83 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -365,6 +365,9 @@ static void cp_unpin_free(struct channel_program *cp)
  * This is the chain length not considering any TICs.
  * You need to do a new round for each TIC target.
  *
+ * The program is also validated for absence of not yet supported
+ * indirect data addressing scenarios.
+ *
  * Returns: the length of the ccw chain or -errno.
  */
 static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
@@ -391,6 +394,14 @@ static int ccwchain_calc_length(u64 iova, struct channel_program *cp)
 	do {
 		cnt++;
 
+		/*
+		 * 2k byte block IDAWs (fmt1 or fmt2) are not yet supported.
+		 * There are however CPs that don't use IDA at all, and can
+		 * benefit from not failing until failure is eminent.
+		 */
+		if ((!cp->orb.cmd.c64 || cp->orb.cmd.i2k) && ccw_is_idal(ccw))
+			return -EOPNOTSUPP;
+
 		if ((!ccw_is_chain(ccw)) && (!ccw_is_tic(ccw)))
 			break;
 
@@ -656,10 +667,8 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	/*
 	 * XXX:
 	 * Only support prefetch enable mode now.
-	 * Only support 64bit addressing idal.
-	 * Only support 4k IDAW.
 	 */
-	if (!orb->cmd.pfch || !orb->cmd.c64 || orb->cmd.i2k)
+	if (!orb->cmd.pfch)
 		return -EOPNOTSUPP;
 
 	INIT_LIST_HEAD(&cp->ccwchain_list);
@@ -688,6 +697,10 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 	ret = ccwchain_loop_tic(chain, cp);
 	if (ret)
 		cp_unpin_free(cp);
+	/* It is safe to force: if not set but idals used
+	 * ccwchain_calc_length returns an error.
+	 */
+	cp->orb.cmd.c64 = 1;
 
 	return ret;
 }
-- 
2.16.3
