From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:53 +0000
Subject: [PATCH 11/25] zfcp: decouple FSF request setup of TMF from scsi_cmnd
Message-Id: <20180517171507.18237-12-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In zfcp_fsf_fcp_task_mgmt() resolve the still old argument scsi_cmnd
into scsi_device very early and only depend on scsi_device and derived
objects in the function body.

This prepares to later change the function signature replacing the
scsi_cmnd argument with scsi_device.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    Since the FCP channel always requires a valid LUN handle,
    we now use scsi_device as context data with any TMF instead of either
    scsi_device for FCP_TMF_LUN_RESET or zfcp_port for FCP_TMF_TGT_RESET.
    
    Thus, zfcp_fc_fcp_tm() no longer needs a change.
    
    This also fixes a kernel panic due to the unconditional dereference with
    sdev_to_zfcp(sdev) where sdev could have been NULL later in the patch set.

 drivers/s390/scsi/zfcp_fsf.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 8bc768a01ef5..5bc84eaa6948 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2324,7 +2324,8 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
 {
 	struct zfcp_fsf_req *req = NULL;
 	struct fcp_cmnd *fcp_cmnd;
-	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scmnd->device);
+	struct scsi_device *sdev = scmnd->device;
+	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_qdio *qdio = zfcp_sdev->port->adapter->qdio;
 
 	if (unlikely(!(atomic_read(&zfcp_sdev->status) &
@@ -2344,7 +2345,8 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
 		goto out;
 	}
 
-	req->data = scmnd->device;
+	req->data = sdev;
+
 	req->handler = zfcp_fsf_fcp_task_mgmt_handler;
 	req->qtcb->header.lun_handle = zfcp_sdev->lun_handle;
 	req->qtcb->header.port_handle = zfcp_sdev->port->handle;
@@ -2355,7 +2357,7 @@ struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
 	zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
 
 	fcp_cmnd = &req->qtcb->bottom.io.fcp_cmnd.iu;
-	zfcp_fc_fcp_tm(fcp_cmnd, scmnd->device, tm_flags);
+	zfcp_fc_fcp_tm(fcp_cmnd, sdev, tm_flags);
 
 	zfcp_fsf_start_timer(req, ZFCP_SCSI_ER_TIMEOUT);
 	if (!zfcp_fsf_req_send(req))
-- 
2.16.3
