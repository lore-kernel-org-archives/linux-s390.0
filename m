Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jared Rossi <jrossi@linux.ibm.com>
Subject: [PATCH 1/1] vfio-ccw: Enable transparent CCW IPL from DASD
Date: Fri, 17 Apr 2020 14:29:39 -0400
Message-Id: <20200417182939.11460-2-jrossi@linux.ibm.com>
In-Reply-To: <20200417182939.11460-1-jrossi@linux.ibm.com>
References: <20200417182939.11460-1-jrossi@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Eric Farman <farman@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>
Cc: linux-s390@vger.kernel.org, kvm@vger.kernel.org, linux-kernel@vger.kernel.org

Remove the explicit prefetch check when using vfio-ccw devices.
This check is not needed as all Linux channel programs are intended
to use prefetch and will be executed in the same way regardless.

Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 drivers/s390/cio/vfio_ccw_cp.c  | 16 ++++------------
 drivers/s390/cio/vfio_ccw_cp.h  |  2 +-
 drivers/s390/cio/vfio_ccw_fsm.c |  6 +++---
 3 files changed, 8 insertions(+), 16 deletions(-)

diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_cp.c
index 3645d1720c4b..5b47ecbb4baa 100644
--- a/drivers/s390/cio/vfio_ccw_cp.c
+++ b/drivers/s390/cio/vfio_ccw_cp.c
@@ -625,9 +625,8 @@ static int ccwchain_fetch_one(struct ccwchain *chain,
  * the target channel program from @orb->cmd.iova to the new ccwchain(s).
  *
  * Limitations:
- * 1. Supports only prefetch enabled mode.
- * 2. Supports idal(c64) ccw chaining.
- * 3. Supports 4k idaw.
+ * 1. Supports idal(c64) ccw chaining.
+ * 2. Supports 4k idaw.
  *
  * Returns:
  *   %0 on success and a negative error value on failure.
@@ -636,13 +635,6 @@ int cp_init(struct channel_program *cp, struct device *mdev, union orb *orb)
 {
 	int ret;
 
-	/*
-	 * XXX:
-	 * Only support prefetch enable mode now.
-	 */
-	if (!orb->cmd.pfch)
-		return -EOPNOTSUPP;
-
 	INIT_LIST_HEAD(&cp->ccwchain_list);
 	memcpy(&cp->orb, orb, sizeof(*orb));
 	cp->mdev = mdev;
@@ -690,7 +682,7 @@ void cp_free(struct channel_program *cp)
 }
 
 /**
- * cp_prefetch() - translate a guest physical address channel program to
+ * cp_fetch() - translate a guest physical address channel program to
  *                 a real-device runnable channel program.
  * @cp: channel_program on which to perform the operation
  *
@@ -726,7 +718,7 @@ void cp_free(struct channel_program *cp)
  * Returns:
  *   %0 on success and a negative error value on failure.
  */
-int cp_prefetch(struct channel_program *cp)
+int cp_fetch(struct channel_program *cp)
 {
 	struct ccwchain *chain;
 	int len, idx, ret;
diff --git a/drivers/s390/cio/vfio_ccw_cp.h b/drivers/s390/cio/vfio_ccw_cp.h
index ba31240ce965..a226f6e99d04 100644
--- a/drivers/s390/cio/vfio_ccw_cp.h
+++ b/drivers/s390/cio/vfio_ccw_cp.h
@@ -45,7 +45,7 @@ struct channel_program {
 extern int cp_init(struct channel_program *cp, struct device *mdev,
 		   union orb *orb);
 extern void cp_free(struct channel_program *cp);
-extern int cp_prefetch(struct channel_program *cp);
+extern int cp_fetch(struct channel_program *cp);
 extern union orb *cp_get_orb(struct channel_program *cp, u32 intparm, u8 lpm);
 extern void cp_update_scsw(struct channel_program *cp, union scsw *scsw);
 extern bool cp_iova_pinned(struct channel_program *cp, u64 iova);
diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_fsm.c
index 23e61aa638e4..446f9186d070 100644
--- a/drivers/s390/cio/vfio_ccw_fsm.c
+++ b/drivers/s390/cio/vfio_ccw_fsm.c
@@ -274,14 +274,14 @@ static void fsm_io_request(struct vfio_ccw_private *private,
 			goto err_out;
 		}
 
-		io_region->ret_code = cp_prefetch(&private->cp);
+		io_region->ret_code = cp_fetch(&private->cp);
 		if (io_region->ret_code) {
 			VFIO_CCW_MSG_EVENT(2,
-					   "%pUl (%x.%x.%04x): cp_prefetch=%d\n",
+					   "%pUl (%x.%x.%04x): cp_fetch=%d\n",
 					   mdev_uuid(mdev), schid.cssid,
 					   schid.ssid, schid.sch_no,
 					   io_region->ret_code);
-			errstr = "cp prefetch";
+			errstr = "cp fetch";
 			cp_free(&private->cp);
 			goto err_out;
 		}
-- 
2.17.0
