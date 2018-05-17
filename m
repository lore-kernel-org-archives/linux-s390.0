From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:51 +0000
Subject: [PATCH 09/25] zfcp: decouple TMF response handler from scsi_cmnd
Message-Id: <20180517171507.18237-10-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Originally, I planned for TMF handling to have different context data in
fsf_req->data depending on the TMF scope in fcp_cmnd->fc_tm_flags:
* scsi_device if FCP_TMF_LUN_RESET,
* zfcp_port if FCP_TMF_TGT_RESET.
However, the FCP channel requires a valid LUN handle so we now use
scsi_device as context data with any TMF for the time being.

Regular SCSI I/O FCP requests continue using scsi_cmnd as req->data.

Hence, the callers of zfcp_fsf_fcp_handler_common() must resolve req->data
and pass scsi_device as common context.
While at it, remove the detour zfcp_sdev->port->adapter and use the more
direct req->adapter as elsewhere in this function already.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    Since the FCP channel always requires a valid LUN handle,
    we now use scsi_device as context data with any TMF instead of either
    scsi_device for FCP_TMF_LUN_RESET or zfcp_port for FCP_TMF_TGT_RESET.
    
    This also fixes a kernel panic due to a wrongly assigned req->data
    in the previous patch version.
    
    Added missing description on replacing zfcp_sdev->port->adapter with
    req->adapter which was already in the previous patch content.
    This is now the only change left in zfcp_fsf_fcp_handler_common().

 drivers/s390/scsi/zfcp_fsf.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index b12cb81ad8a2..a95070c7cad8 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2036,10 +2036,14 @@ static void zfcp_fsf_req_trace(struct zfcp_fsf_req *req, struct scsi_cmnd *scsi)
 			    sizeof(blktrc));
 }
 
-static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req)
+/**
+ * zfcp_fsf_fcp_handler_common() - FCP response handler common to I/O and TMF.
+ * @req: Pointer to FSF request.
+ * @sdev: Pointer to SCSI device as request context.
+ */
+static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req,
+					struct scsi_device *sdev)
 {
-	struct scsi_cmnd *scmnd = req->data;
-	struct scsi_device *sdev = scmnd->device;
 	struct zfcp_scsi_dev *zfcp_sdev;
 	struct fsf_qtcb_header *header = &req->qtcb->header;
 
@@ -2051,7 +2055,7 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req)
 	switch (header->fsf_status) {
 	case FSF_HANDLE_MISMATCH:
 	case FSF_PORT_HANDLE_NOT_VALID:
-		zfcp_erp_adapter_reopen(zfcp_sdev->port->adapter, 0, "fssfch1");
+		zfcp_erp_adapter_reopen(req->adapter, 0, "fssfch1");
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_FCPLUN_NOT_VALID:
@@ -2069,8 +2073,7 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req)
 			req->qtcb->bottom.io.data_direction,
 			(unsigned long long)zfcp_scsi_dev_lun(sdev),
 			(unsigned long long)zfcp_sdev->port->wwpn);
-		zfcp_erp_adapter_shutdown(zfcp_sdev->port->adapter, 0,
-					  "fssfch3");
+		zfcp_erp_adapter_shutdown(req->adapter, 0, "fssfch3");
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_CMND_LENGTH_NOT_VALID:
@@ -2080,8 +2083,7 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req)
 			req->qtcb->bottom.io.fcp_cmnd_length,
 			(unsigned long long)zfcp_scsi_dev_lun(sdev),
 			(unsigned long long)zfcp_sdev->port->wwpn);
-		zfcp_erp_adapter_shutdown(zfcp_sdev->port->adapter, 0,
-					  "fssfch4");
+		zfcp_erp_adapter_shutdown(req->adapter, 0, "fssfch4");
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_PORT_BOXED:
@@ -2120,7 +2122,7 @@ static void zfcp_fsf_fcp_cmnd_handler(struct zfcp_fsf_req *req)
 		return;
 	}
 
-	zfcp_fsf_fcp_handler_common(req);
+	zfcp_fsf_fcp_handler_common(req, scpnt->device);
 
 	if (unlikely(req->status & ZFCP_STATUS_FSFREQ_ERROR)) {
 		set_host_byte(scpnt, DID_TRANSPORT_DISRUPTED);
@@ -2297,10 +2299,11 @@ int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *scsi_cmnd)
 
 static void zfcp_fsf_fcp_task_mgmt_handler(struct zfcp_fsf_req *req)
 {
+	struct scsi_device *sdev = req->data;
 	struct fcp_resp_with_ext *fcp_rsp;
 	struct fcp_resp_rsp_info *rsp_info;
 
-	zfcp_fsf_fcp_handler_common(req);
+	zfcp_fsf_fcp_handler_common(req, sdev);
 
 	fcp_rsp = &req->qtcb->bottom.io.fcp_rsp.iu;
 	rsp_info = (struct fcp_resp_rsp_info *) &fcp_rsp[1];
@@ -2341,7 +2344,7 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
 		goto out;
 	}
 
-	req->data = scmnd;
+	req->data = scmnd->device;
 	req->handler = zfcp_fsf_fcp_task_mgmt_handler;
 	req->qtcb->header.lun_handle = zfcp_sdev->lun_handle;
 	req->qtcb->header.port_handle = zfcp_sdev->port->handle;
-- 
2.16.3
