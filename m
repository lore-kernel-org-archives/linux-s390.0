From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:54 +0000
Subject: [PATCH 12/25] zfcp: decouple SCSI setup of TMF from scsi_cmnd
Message-Id: <20180517171507.18237-13-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Actually change the signature of zfcp_fsf_fcp_task_mgmt().
Since it was prepared in the previous patch, we only need to delete
a local auto variable which is now the intended argument.

Prepare zfcp_fsf_fcp_task_mgmt's caller zfcp_task_mgmt_function()
to have its function body only depend on a scsi_device and derived objects.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---

Notes:
    Changes since RFC:
    
    Since the FCP channel always requires a valid LUN handle,
    we now use scsi_device as context data with any TMF instead of
    zfcp_port for FCP_TMF_TGT_RESET and an optional scsi_device for
    FCP_TMF_LUN_RESET.
    
    Thus, zfcp_scsi_forget_cmnds() does not need a change anymore and
    zfcp_task_mgmt_function() needs less changes because the tracing
    with a mandatory scsi_device is simpler.

 drivers/s390/scsi/zfcp_ext.h  |  3 ++-
 drivers/s390/scsi/zfcp_fsf.c  | 12 ++++++------
 drivers/s390/scsi/zfcp_scsi.c |  2 +-
 3 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 78bcd80d0509..e317c4b513c9 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -123,7 +123,8 @@ extern int zfcp_fsf_send_els(struct zfcp_adapter *, u32,
 			     struct zfcp_fsf_ct_els *, unsigned int);
 extern int zfcp_fsf_fcp_cmnd(struct scsi_cmnd *);
 extern void zfcp_fsf_req_free(struct zfcp_fsf_req *);
-extern struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *, u8);
+extern struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_device *sdev,
+						   u8 tm_flags);
 extern struct zfcp_fsf_req *zfcp_fsf_abort_fcp_cmnd(struct scsi_cmnd *);
 extern void zfcp_fsf_reqid_check(struct zfcp_qdio *, int);
 
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 5bc84eaa6948..d86c3bf71664 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -2314,17 +2314,17 @@ static void zfcp_fsf_fcp_task_mgmt_handler(struct zfcp_fsf_req *req)
 }
 
 /**
- * zfcp_fsf_fcp_task_mgmt - send SCSI task management command
- * @scmnd: SCSI command to send the task management command for
- * @tm_flags: unsigned byte for task management flags
- * Returns: on success pointer to struct fsf_req, NULL otherwise
+ * zfcp_fsf_fcp_task_mgmt() - Send SCSI task management command (TMF).
+ * @sdev: Pointer to SCSI device to send the task management command to.
+ * @tm_flags: Unsigned byte for task management flags.
+ *
+ * Return: On success pointer to struct zfcp_fsf_req, %NULL otherwise.
  */
-struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_cmnd *scmnd,
+struct zfcp_fsf_req *zfcp_fsf_fcp_task_mgmt(struct scsi_device *sdev,
 					    u8 tm_flags)
 {
 	struct zfcp_fsf_req *req = NULL;
 	struct fcp_cmnd *fcp_cmnd;
-	struct scsi_device *sdev = scmnd->device;
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_qdio *qdio = zfcp_sdev->port->adapter->qdio;
 
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 0afc546b71df..e77e43a0630a 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -275,7 +275,7 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 	int retry = 3;
 
 	while (retry--) {
-		fsf_req = zfcp_fsf_fcp_task_mgmt(scpnt, tm_flags);
+		fsf_req = zfcp_fsf_fcp_task_mgmt(sdev, tm_flags);
 		if (fsf_req)
 			break;
 
-- 
2.16.3
