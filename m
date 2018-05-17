From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:07 +0000
Subject: [PATCH 25/25] zfcp: enhance comments on fc_link_speed and supported_speed
Message-Id: <20180517171507.18237-26-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Jens Remus <jremus@linux.ibm.com>

The comment on fsf_qtcb_bottom_port.supported_speed did read as if the
field can only assume one of two possible values (i.e. 0x1 for 1 GBit/s or
0x2 for 2 GBit/s). This is not true for two reasons: first it is a flag
field and can thus assume any combination and second there are meanwhile
more speeds.

Clarify comment on fsf_qtcb_bottom_port.supported_speed and add a comment
to fsf_qtcb_bottom_config.fc_link_speed.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Acked-by: Benjamin Block <bblock@linux.ibm.com>
Acked-by: Hendrik Brueckner <brueckner@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 4baca67aba6d..535628b92f0a 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -4,7 +4,7 @@
  *
  * Interface to the FSF support functions.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2018
  */
 
 #ifndef FSF_H
@@ -356,7 +356,7 @@ struct fsf_qtcb_bottom_config {
 	u32 adapter_features;
 	u32 connection_features;
 	u32 fc_topology;
-	u32 fc_link_speed;
+	u32 fc_link_speed;	/* one of ZFCP_FSF_PORTSPEED_* */
 	u32 adapter_type;
 	u8 res0;
 	u8 peer_d_id[3];
@@ -382,7 +382,7 @@ struct fsf_qtcb_bottom_port {
 	u32 class_of_service;	/* should be 0x00000006 for class 2 and 3 */
 	u8 supported_fc4_types[32]; /* should be 0x00000100 for scsi fcp */
 	u8 active_fc4_types[32];
-	u32 supported_speed;	/* 0x0001 for 1 GBit/s or 0x0002 for 2 GBit/s */
+	u32 supported_speed;	/* any combination of ZFCP_FSF_PORTSPEED_* */
 	u32 maximum_frame_size;	/* fixed value of 2112 */
 	u64 seconds_since_last_reset;
 	u64 tx_frames;
-- 
2.16.3
