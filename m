From: Steffen Maier <maier@linux.vnet.ibm.com>
Subject: [RFC 9/9] zfcp: decouple our scsi_eh callbacks from scsi_cmnd
Date: Tue, 25 Jul 2017 16:14:27 +0200
Message-ID: <20170725141427.35258-10-maier@linux.vnet.ibm.com>
References: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <20170725141427.35258-1-maier@linux.vnet.ibm.com>
Sender: linux-scsi-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-scsi/>
List-Post: <mailto:linux-scsi@vger.kernel.org>
To: linux-scsi@vger.kernel.org, Hannes Reinecke <hare@suse.de>
Cc: linux-s390@vger.kernel.org, Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

zfcp_scsi_eh_device_reset_handler() now only depends on scsi_device.
zfcp_scsi_eh_target_reset_handler() now only depends on scsi_target.
zfcp_scsi_eh_host_reset_handler() now only depends on Scsi_Host.
All derive other objects from these intended callback arguments.

Actually change the signature of zfcp_task_mgmt_function() used by
zfcp_scsi_eh_device_reset_handler() & zfcp_scsi_eh_target_reset_handler().
Since it was prepared in a previous patch, we only need to delete
some local auto variables which are now the intended arguments.

Signed-off-by: Steffen Maier <maier@linux.vnet.ibm.com>
---
 drivers/s390/scsi/zfcp_scsi.c | 40 ++++++++++++++++++++++++++++++++--------
 1 file changed, 32 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index 11cf33ea8c14..4cb38cfd46e3 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -266,11 +266,17 @@ static void zfcp_scsi_forget_cmnds(struct zfcp_port *port,
 	write_unlock_irqrestore(&adapter->abort_lock, flags);
 }
 
-static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
+/**
+ * zfcp_task_mgmt_function() - Synchronously send a task management function.
+ * @port: Pointer to zfcp port indicating scope.
+ * @sdev: Pointer to SCSI device as scope, or %NULL if scope is only port.
+ * @tm_flags: Task management flags,
+ *            here we only handle %FCP_TMF_TGT_RESET or %FCP_TMF_LUN_RESET.
+ */
+static int zfcp_task_mgmt_function(struct zfcp_port *port,
+				   struct scsi_device *sdev, u8 tm_flags)
 {
-	struct scsi_device *sdev = scpnt->device;
-	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
-	struct zfcp_port *port = zfcp_sdev->port;
+	struct zfcp_scsi_dev *zfcp_sdev = sdev ? sdev_to_zfcp(sdev) : NULL;
 	struct zfcp_adapter *adapter = port->adapter;
 	unsigned int scsi_id = port->starget_id;
 	u64 scsi_lun = ZFCP_DBF_INVALID_LUN;
@@ -325,18 +331,36 @@ static int zfcp_task_mgmt_function(struct scsi_cmnd *scpnt, u8 tm_flags)
 
 static int zfcp_scsi_eh_device_reset_handler(struct scsi_cmnd *scpnt)
 {
-	return zfcp_task_mgmt_function(scpnt, FCP_TMF_LUN_RESET);
+	struct scsi_device *sdev = scpnt->device;
+	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(sdev);
+	struct zfcp_port *port = zfcp_sdev->port;
+
+	return zfcp_task_mgmt_function(port, sdev, FCP_TMF_LUN_RESET);
 }
 
 static int zfcp_scsi_eh_target_reset_handler(struct scsi_cmnd *scpnt)
 {
-	return zfcp_task_mgmt_function(scpnt, FCP_TMF_TGT_RESET);
+	struct scsi_target *starget = scsi_target(scpnt->device);
+	struct fc_rport *rport = starget_to_rport(starget);
+	struct zfcp_adapter *adapter =
+		(struct zfcp_adapter *)rport_to_shost(rport)->hostdata[0];
+	struct zfcp_port *port = zfcp_get_port_by_wwpn(adapter,
+						       rport->port_name);
+	if (!port) {
+		zfcp_dbf_scsi_devreset("nopt", adapter, FCP_TMF_TGT_RESET,
+				       NULL, port->starget_id,
+				       ZFCP_DBF_INVALID_LUN);
+		return 0;
+	}
+
+	return zfcp_task_mgmt_function(port, NULL, FCP_TMF_TGT_RESET);
 }
 
 static int zfcp_scsi_eh_host_reset_handler(struct scsi_cmnd *scpnt)
 {
-	struct zfcp_scsi_dev *zfcp_sdev = sdev_to_zfcp(scpnt->device);
-	struct zfcp_adapter *adapter = zfcp_sdev->port->adapter;
+	struct Scsi_Host *shost = scpnt->device->host;
+	struct zfcp_adapter *adapter =
+		(struct zfcp_adapter *)shost->hostdata[0];
 	struct zfcp_port *port;
 	int ret = SUCCESS;
 
-- 
2.11.2
