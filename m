From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:58 +0000
Subject: [PATCH 16/25] zfcp: consistently use function name space prefix
Message-Id: <20180517171507.18237-17-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

I've been mixing up
zfcp_task_mgmt_function() [SCSI] and
zfcp_fsf_fcp_task_mgmt()  [FSF]
so often lately that I wanted to fix this.

SCSI changes complement v2.6.27 commit f76af7d7e363
("[SCSI] zfcp: Cleanup of code in zfcp_scsi.c").

While at it, also fixup the other inconsistencies elsewhere.

ERP changes complement v2.6.27 commit 287ac01acf22
("[SCSI] zfcp: Cleanup code in zfcp_erp.c") which introduced
status_change_set().

FC changes complement v2.6.32 commit 6f53a2d2ecae
("[SCSI] zfcp: Apply common naming conventions to zfcp_fc").
by renaming a leftover introduced with v2.6.27 commit cc8c282963bd
("[SCSI] zfcp: Automatically attach remote ports").

FSF changes fixup v2.6.32 commit a4623c467ff7
("[SCSI] zfcp: Improve request allocation through mempools").
which replaced zfcp_fsf_alloc_qtcb() introduced with v2.6.27
commit c41f8cbddd4e ("[SCSI] zfcp: zfcp_fsf cleanup.").

SCSI fc_host statistics were introduced with v2.6.16 commit f6cd94b126aa
("[SCSI] zfcp: transport class adaptations").

SCSI fc_host port_state was introduced with v2.6.27 commit 85a82392fe6f
("[SCSI] zfcp: Add port_state attribute to sysfs").

SCSI rport setter for dev_loss_tmo was introduced with v2.6.18
commit 338151e06608 ("[SCSI] zfcp: make use of fc_remote_port_delete when
target port is unavailable").

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c  | 11 +++++++----
 drivers/s390/scsi/zfcp_fc.c   |  4 ++--
 drivers/s390/scsi/zfcp_fsf.c  |  7 ++++---
 drivers/s390/scsi/zfcp_scsi.c | 46 ++++++++++++++++++++++---------------------
 4 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 69dfb328dba4..9be629607dc0 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -551,21 +551,23 @@ void zfcp_erp_lun_shutdown_wait(struct scsi_device *sdev, char *id)
 	zfcp_erp_wait(adapter);
 }
 
-static int status_change_set(unsigned long mask, atomic_t *status)
+static int zfcp_erp_status_change_set(unsigned long mask, atomic_t *status)
 {
 	return (atomic_read(status) ^ mask) & mask;
 }
 
 static void zfcp_erp_adapter_unblock(struct zfcp_adapter *adapter)
 {
-	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &adapter->status))
+	if (zfcp_erp_status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED,
+				       &adapter->status))
 		zfcp_dbf_rec_run("eraubl1", &adapter->erp_action);
 	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &adapter->status);
 }
 
 static void zfcp_erp_port_unblock(struct zfcp_port *port)
 {
-	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &port->status))
+	if (zfcp_erp_status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED,
+				       &port->status))
 		zfcp_dbf_rec_run("erpubl1", &port->erp_action);
 	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &port->status);
 }
@@ -574,7 +576,8 @@ static void zfcp_erp_lun_unblock(struct scsi_device *sdev)
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 
-	if (status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED, &zfcp_sdev->status))
+	if (zfcp_erp_status_change_set(ZFCP_STATUS_COMMON_UNBLOCKED,
+				       &zfcp_sdev->status))
 		zfcp_dbf_rec_run("erlubl1", &sdev_to_zfcp(sdev)->erp_action);
 	atomic_or(ZFCP_STATUS_COMMON_UNBLOCKED, &zfcp_sdev->status);
 }
diff --git a/drivers/s390/scsi/zfcp_fc.c b/drivers/s390/scsi/zfcp_fc.c
index 2ad80c43f674..54186943896b 100644
--- a/drivers/s390/scsi/zfcp_fc.c
+++ b/drivers/s390/scsi/zfcp_fc.c
@@ -598,7 +598,7 @@ void zfcp_fc_test_link(struct zfcp_port *port)
 		put_device(&port->dev);
 }
 
-static struct zfcp_fc_req *zfcp_alloc_sg_env(int buf_num)
+static struct zfcp_fc_req *zfcp_fc_alloc_sg_env(int buf_num)
 {
 	struct zfcp_fc_req *fc_req;
 
@@ -750,7 +750,7 @@ void zfcp_fc_scan_ports(struct work_struct *work)
 	if (zfcp_fc_wka_port_get(&adapter->gs->ds))
 		return;
 
-	fc_req = zfcp_alloc_sg_env(buf_num);
+	fc_req = zfcp_fc_alloc_sg_env(buf_num);
 	if (!fc_req)
 		goto out;
 
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index d86c3bf71664..049fdd968130 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -662,7 +662,7 @@ static struct zfcp_fsf_req *zfcp_fsf_alloc(mempool_t *pool)
 	return req;
 }
 
-static struct fsf_qtcb *zfcp_qtcb_alloc(mempool_t *pool)
+static struct fsf_qtcb *zfcp_fsf_qtcb_alloc(mempool_t *pool)
 {
 	struct fsf_qtcb *qtcb;
 
@@ -701,9 +701,10 @@ static struct zfcp_fsf_req *zfcp_fsf_req_create(struct zfcp_qdio *qdio,
 
 	if (likely(fsf_cmd != FSF_QTCB_UNSOLICITED_STATUS)) {
 		if (likely(pool))
-			req->qtcb = zfcp_qtcb_alloc(adapter->pool.qtcb_pool);
+			req->qtcb = zfcp_fsf_qtcb_alloc(
+				adapter->pool.qtcb_pool);
 		else
-			req->qtcb = zfcp_qtcb_alloc(NULL);
+			req->qtcb = zfcp_fsf_qtcb_alloc(NULL);
 
 		if (unlikely(!req->qtcb)) {
 			zfcp_fsf_req_free(req);
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 0f7830ffd40a..b4e1f1b82503 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -266,12 +266,12 @@ static void zfcp_scsi_forget_cmnds(struct zfcp_scsi_dev *zsdev, u8 tm_flags)
 }
 
 /**
- * zfcp_task_mgmt_function() - Synchronously send a task management function.
+ * zfcp_scsi_task_mgmt_function() - Send a task management function (sync).
  * @sdev: Pointer to SCSI device to send the task management command to.
  * @tm_flags: Task management flags,
  *	      here we only handle %FCP_TMF_TGT_RESET or %FCP_TMF_LUN_RESET.
  */
-static int zfcp_task_mgmt_function(struct scsi_device *sdev, u8 tm_flags)
+static int zfcp_scsi_task_mgmt_function(struct scsi_device *sdev, u8 tm_flags)
 {
 	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
 	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
@@ -322,7 +322,7 @@ static int zfcp_scsi_eh_device_reset_handler(struct scsi_cmnd *scpnt)
 {
 	struct scsi_device *sdev = scpnt->device;
 
-	return zfcp_task_mgmt_function(sdev, FCP_TMF_LUN_RESET);
+	return zfcp_scsi_task_mgmt_function(sdev, FCP_TMF_LUN_RESET);
 }
 
 static int zfcp_scsi_eh_target_reset_handler(struct scsi_cmnd *scpnt)
@@ -347,7 +347,7 @@ static int zfcp_scsi_eh_target_reset_handler(struct scsi_cmnd *scpnt)
 		return ret;
 	}
 
-	ret = zfcp_task_mgmt_function(sdev, FCP_TMF_TGT_RESET);
+	ret = zfcp_scsi_task_mgmt_function(sdev, FCP_TMF_TGT_RESET);
 
 	/* release reference from above shost_for_each_device */
 	if (sdev)
@@ -468,7 +468,7 @@ void zfcp_scsi_adapter_unregister(struct zfcp_adapter *adapter)
 }
 
 static struct fc_host_statistics*
-zfcp_init_fc_host_stats(struct zfcp_adapter *adapter)
+zfcp_scsi_init_fc_host_stats(struct zfcp_adapter *adapter)
 {
 	struct fc_host_statistics *fc_stats;
 
@@ -482,9 +482,9 @@ zfcp_init_fc_host_stats(struct zfcp_adapter *adapter)
 	return adapter->fc_stats;
 }
 
-static void zfcp_adjust_fc_host_stats(struct fc_host_statistics *fc_stats,
-				      struct fsf_qtcb_bottom_port *data,
-				      struct fsf_qtcb_bottom_port *old)
+static void zfcp_scsi_adjust_fc_host_stats(struct fc_host_statistics *fc_stats,
+					   struct fsf_qtcb_bottom_port *data,
+					   struct fsf_qtcb_bottom_port *old)
 {
 	fc_stats->seconds_since_last_reset =
 		data->seconds_since_last_reset - old->seconds_since_last_reset;
@@ -515,8 +515,8 @@ static void zfcp_adjust_fc_host_stats(struct fc_host_statistics *fc_stats,
 	fc_stats->fcp_output_megabytes = data->output_mb - old->output_mb;
 }
 
-static void zfcp_set_fc_host_stats(struct fc_host_statistics *fc_stats,
-				   struct fsf_qtcb_bottom_port *data)
+static void zfcp_scsi_set_fc_host_stats(struct fc_host_statistics *fc_stats,
+					struct fsf_qtcb_bottom_port *data)
 {
 	fc_stats->seconds_since_last_reset = data->seconds_since_last_reset;
 	fc_stats->tx_frames = data->tx_frames;
@@ -540,7 +540,8 @@ static void zfcp_set_fc_host_stats(struct fc_host_statistics *fc_stats,
 	fc_stats->fcp_output_megabytes = data->output_mb;
 }
 
-static struct fc_host_statistics *zfcp_get_fc_host_stats(struct Scsi_Host *host)
+static struct fc_host_statistics *
+zfcp_scsi_get_fc_host_stats(struct Scsi_Host *host)
 {
 	struct zfcp_adapter *adapter;
 	struct fc_host_statistics *fc_stats;
@@ -548,7 +549,7 @@ static struct fc_host_statistics *zfcp_get_fc_host_stats(struct Scsi_Host *host)
 	int ret;
 
 	adapter = (struct zfcp_adapter *)host->hostdata[0];
-	fc_stats = zfcp_init_fc_host_stats(adapter);
+	fc_stats = zfcp_scsi_init_fc_host_stats(adapter);
 	if (!fc_stats)
 		return NULL;
 
@@ -565,16 +566,16 @@ static struct fc_host_statistics *zfcp_get_fc_host_stats(struct Scsi_Host *host)
 	if (adapter->stats_reset &&
 	    ((jiffies/HZ - adapter->stats_reset) <
 	     data->seconds_since_last_reset))
-		zfcp_adjust_fc_host_stats(fc_stats, data,
-					  adapter->stats_reset_data);
+		zfcp_scsi_adjust_fc_host_stats(fc_stats, data,
+					       adapter->stats_reset_data);
 	else
-		zfcp_set_fc_host_stats(fc_stats, data);
+		zfcp_scsi_set_fc_host_stats(fc_stats, data);
 
 	kfree(data);
 	return fc_stats;
 }
 
-static void zfcp_reset_fc_host_stats(struct Scsi_Host *shost)
+static void zfcp_scsi_reset_fc_host_stats(struct Scsi_Host *shost)
 {
 	struct zfcp_adapter *adapter;
 	struct fsf_qtcb_bottom_port *data;
@@ -596,7 +597,7 @@ static void zfcp_reset_fc_host_stats(struct Scsi_Host *shost)
 	}
 }
 
-static void zfcp_get_host_port_state(struct Scsi_Host *shost)
+static void zfcp_scsi_get_host_port_state(struct Scsi_Host *shost)
 {
 	struct zfcp_adapter *adapter =
 		(struct zfcp_adapter *)shost->hostdata[0];
@@ -613,7 +614,8 @@ static void zfcp_get_host_port_state(struct Scsi_Host *shost)
 		fc_host_port_state(shost) = FC_PORTSTATE_UNKNOWN;
 }
 
-static void zfcp_set_rport_dev_loss_tmo(struct fc_rport *rport, u32 timeout)
+static void zfcp_scsi_set_rport_dev_loss_tmo(struct fc_rport *rport,
+					     u32 timeout)
 {
 	rport->dev_loss_tmo = timeout;
 }
@@ -807,10 +809,10 @@ struct fc_function_template zfcp_transport_functions = {
 	.show_host_supported_speeds = 1,
 	.show_host_maxframe_size = 1,
 	.show_host_serial_number = 1,
-	.get_fc_host_stats = zfcp_get_fc_host_stats,
-	.reset_fc_host_stats = zfcp_reset_fc_host_stats,
-	.set_rport_dev_loss_tmo = zfcp_set_rport_dev_loss_tmo,
-	.get_host_port_state = zfcp_get_host_port_state,
+	.get_fc_host_stats = zfcp_scsi_get_fc_host_stats,
+	.reset_fc_host_stats = zfcp_scsi_reset_fc_host_stats,
+	.set_rport_dev_loss_tmo = zfcp_scsi_set_rport_dev_loss_tmo,
+	.get_host_port_state = zfcp_scsi_get_host_port_state,
 	.terminate_rport_io = zfcp_scsi_terminate_rport_io,
 	.show_host_port_state = 1,
 	.show_host_active_fc4s = 1,
-- 
2.16.3
