From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:52 +0000
Subject: [PATCH 10/25] zfcp: split FCP_CMND IU setup between SCSI I/O and TMF again
Message-Id: <20180517171507.18237-11-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

This reverts commit 2443c8b23aea ("[SCSI] zfcp: Merge FCP task management
setup with regular FCP command setup"), because this introduced a
dependency on the unsuitable SCSI command for scsi_eh / TMF.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fc.h  | 22 ++++++++++++++--------
 drivers/s390/scsi/zfcp_fsf.c |  4 ++--
 2 files changed, 16 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fc.h b/drivers/s390/scsi/zfcp_fc.h
index 6a397ddaadf0..3cd74729cfb9 100644
--- a/drivers/s390/scsi/zfcp_fc.h
+++ b/drivers/s390/scsi/zfcp_fc.h
@@ -207,21 +207,14 @@ struct zfcp_fc_wka_ports {
  * zfcp_fc_scsi_to_fcp - setup FCP command with data from scsi_cmnd
  * @fcp: fcp_cmnd to setup
  * @scsi: scsi_cmnd where to get LUN, task attributes/flags and CDB
- * @tm: task management flags to setup task management command
  */
 static inline
-void zfcp_fc_scsi_to_fcp(struct fcp_cmnd *fcp, struct scsi_cmnd *scsi,
-			 u8 tm_flags)
+void zfcp_fc_scsi_to_fcp(struct fcp_cmnd *fcp, struct scsi_cmnd *scsi)
 {
 	u32 datalen;
 
 	int_to_scsilun(scsi->device->lun, (struct scsi_lun *) &fcp->fc_lun);
 
-	if (unlikely(tm_flags)) {
-		fcp->fc_tm_flags = tm_flags;
-		return;
-	}
-
 	fcp->fc_pri_ta = FCP_PTA_SIMPLE;
 
 	if (scsi->sc_data_direction == DMA_FROM_DEVICE)
@@ -240,6 +233,19 @@ void zfcp_fc_scsi_to_fcp(struct fcp_cmnd *fcp, struct scsi_cmnd *scsi,
 	}
 }
 
+/**
+ * zfcp_fc_fcp_tm() - Setup FCP command as task management command.
+ * @fcp: Pointer to FCP_CMND IU to set up.
+ * @dev: Pointer to SCSI_device where to send the task management command.
+ * @tm_flags: Task management flags to setup tm command.
+ */
+static inline
+void zfcp_fc_fcp_tm(struct fcp_cmnd *fcp, struct scsi_device *dev, u8 tm_flags)
+{
+	int_to_scsilun(dev->lun, (struct scsi_lun *) &fcp->fc_lun);
+	fcp->fc_tm_flags = tm_flags;
+}
+
 /**
  * zfcp_fc_evap_fcp_rsp - evaluate FCP RSP IU and update scsi_cmnd accordingly
  * @fcp_rsp: FCP RSP IU to evaluate
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index a95070c7cad8..8bc768a01ef5 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2260,7 +2260,7 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
 
 	BUILD_BUG_ON(sizeof(struct fcp_cmnd) > FSF_FCP_CMND_SIZE);
 	fcp_cmnd = &req->qtcb->bottom.io.fcp_cmnd.iu;
-	zfcp_fc_scsi_to_fcp(fcp_cmnd, scsi_cmnd, 0);
+	zfcp_fc_scsi_to_fcp(fcp_cmnd, scsi_cmnd);
 
 	if ((scsi_get_prot_op(scsi_cmnd) != SCSI_PROT_NORMAL) &&
 	    scsi_prot_sg_count(scsi_cmnd)) {
@@ -2355,7 +2355,7 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
 	zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
 
 	fcp_cmnd = &req->qtcb->bottom.io.fcp_cmnd.iu;
-	zfcp_fc_scsi_to_fcp(fcp_cmnd, scmnd, tm_flags);
+	zfcp_fc_fcp_tm(fcp_cmnd, scmnd->device, tm_flags);
 
 	zfcp_fsf_start_timer(req, ZFCP_SCSI_ER_TIMEOUT);
 	if (!zfcp_fsf_req_send(req))
-- 
2.16.3
