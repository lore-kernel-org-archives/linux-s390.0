From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:44 +0000
Subject: [PATCH 01/10] zfcp: signal incomplete or error for sync exchange config/port data
Message-Id: <66eec0139d12365ce0569d4664d329627de58c26.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Adds a new FSF-Request status flag (ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE)
that signal that the data received using Exchange Config Data or
Exchange Port Data was incomplete. This new flags is set in the
respective handlers during the response path.

With this patch, only the synchronous FSF-functions for each command got
support for the new flag, otherwise it is transparent.

Together with this new flag and already existing status flags the
synchronous FSF-functions are extended to now detect whether the
received data is complete, incomplete or completely invalid (this
includes cases where a command ran into a timeout). This is now signaled
back to the caller, where previously only failures on the request path
would result in a bad return-code.

For complete data the return-code remains 0. For incomplete data a new
return-code -EAGAIN is added to the function-interface. For completely
invalid data the already existing return-code -EIO is reused - formerly
this was used to signal failures on the request path.

Existing callers of the FSF-functions are adjusted so that they
behave as before for return-code 0 and -EAGAIN, to not change the
user-interface. As -EIO existed all along, it was already exposed to the
user - and needed handling - and will now also be exposed in this new
special case.

Fixes: 52ef11a7170e1 ("[SCSI] zfcp: cleanup, separation of ERP, non ERP-version for exchange_ functions")
Fixes: c41f8cbddd4e0 ("[SCSI] zfcp: zfcp_fsf cleanup.")
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_def.h   |  1 +
 drivers/s390/scsi/zfcp_fsf.c   | 52 ++++++++++++++++++++++++++++++++++++------
 drivers/s390/scsi/zfcp_scsi.c  |  4 ++--
 drivers/s390/scsi/zfcp_sysfs.c |  4 ++--
 4 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index 87d2f47a6990..f5acdb67442e 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -86,6 +86,7 @@
 #define ZFCP_STATUS_FSFREQ_ABORTNOTNEEDED       0x00000080
 #define ZFCP_STATUS_FSFREQ_TMFUNCFAILED         0x00000200
 #define ZFCP_STATUS_FSFREQ_DISMISSED            0x00001000
+#define ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE	0x00020000
 
 /************************* STRUCTURE DEFINITIONS *****************************/
 
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index d94496ee6883..c6a448586127 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -574,6 +574,8 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 				&adapter->status);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
+		req->status |= ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE;
+
 		fc_host_node_name(shost) = 0;
 		fc_host_port_name(shost) = 0;
 		fc_host_port_id(shost) = 0;
@@ -652,6 +654,8 @@ static void zfcp_fsf_exchange_port_data_handler(struct zfcp_fsf_req *req)
 		zfcp_fsf_exchange_port_evaluate(req);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
+		req->status |= ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE;
+
 		zfcp_fsf_exchange_port_evaluate(req);
 		zfcp_fsf_link_down_info_eval(req,
 			&qtcb->header.fsf_status_qual.link_down_info);
@@ -1248,6 +1252,19 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 	return retval;
 }
 
+
+/**
+ * zfcp_fsf_exchange_config_data_sync() - Request information about FCP channel.
+ * @qdio: pointer to the QDIO-Queue to use for sending the command.
+ * @data: pointer to the QTCB-Bottom for storing the result of the command,
+ *        might be %NULL.
+ *
+ * Returns:
+ * * 0		- Exchange Config Data was successful, @data is complete
+ * * -EIO	- Exchange Config Data was not successful, @data is invalid
+ * * -EAGAIN	- @data contains incomplete data
+ * * -ENOMEM	- Some memory allocation failed along the way
+ */
 int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 				       struct fsf_qtcb_bottom_config *data)
 {
@@ -1279,9 +1296,17 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	spin_unlock_irq(&qdio->req_q_lock);
-	if (!retval)
+
+	if (!retval) {
 		wait_for_completion(&req->completion);
 
+		if (req->status &
+		    (ZFCP_STATUS_FSFREQ_ERROR | ZFCP_STATUS_FSFREQ_DISMISSED))
+			retval = -EIO;
+		else if (req->status & ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE)
+			retval = -EAGAIN;
+	}
+
 	zfcp_fsf_req_free(req);
 	return retval;
 
@@ -1336,10 +1361,17 @@ int zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action)
 }
 
 /**
- * zfcp_fsf_exchange_port_data_sync - request information about local port
- * @qdio: pointer to struct zfcp_qdio
- * @data: pointer to struct fsf_qtcb_bottom_port
- * Returns: 0 on success, error otherwise
+ * zfcp_fsf_exchange_port_data_sync() - Request information about local port.
+ * @qdio: pointer to the QDIO-Queue to use for sending the command.
+ * @data: pointer to the QTCB-Bottom for storing the result of the command,
+ *        might be %NULL.
+ *
+ * Returns:
+ * * 0		- Exchange Port Data was successful, @data is complete
+ * * -EIO	- Exchange Port Data was not successful, @data is invalid
+ * * -EAGAIN	- @data contains incomplete data
+ * * -ENOMEM	- Some memory allocation failed along the way
+ * * -EOPNOTSUPP	- This operation is not supported
  */
 int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 				     struct fsf_qtcb_bottom_port *data)
@@ -1372,11 +1404,17 @@ int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 	retval = zfcp_fsf_req_send(req);
 	spin_unlock_irq(&qdio->req_q_lock);
 
-	if (!retval)
+	if (!retval) {
 		wait_for_completion(&req->completion);
 
-	zfcp_fsf_req_free(req);
+		if (req->status &
+		    (ZFCP_STATUS_FSFREQ_ERROR | ZFCP_STATUS_FSFREQ_DISMISSED))
+			retval = -EIO;
+		else if (req->status & ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE)
+			retval = -EAGAIN;
+	}
 
+	zfcp_fsf_req_free(req);
 	return retval;
 
 out_unlock:
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index f4f6a07c5222..8ebce4445e10 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -592,7 +592,7 @@ zfcp_scsi_get_fc_host_stats(struct Scsi_Host *host)
 		return NULL;
 
 	ret = zfcp_fsf_exchange_port_data_sync(adapter->qdio, data);
-	if (ret) {
+	if (ret != 0 && ret != -EAGAIN) {
 		kfree(data);
 		return NULL;
 	}
@@ -621,7 +621,7 @@ static void zfcp_scsi_reset_fc_host_stats(struct Scsi_Host *shost)
 		return;
 
 	ret = zfcp_fsf_exchange_port_data_sync(adapter->qdio, data);
-	if (ret)
+	if (ret != 0 && ret != -EAGAIN)
 		kfree(data);
 	else {
 		adapter->stats_reset = jiffies/HZ;
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index b277be6f7611..11c945e8156d 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -534,7 +534,7 @@ static ssize_t zfcp_sysfs_adapter_util_show(struct device *dev,
 		return -ENOMEM;
 
 	retval = zfcp_fsf_exchange_port_data_sync(adapter->qdio, qtcb_port);
-	if (!retval)
+	if (retval == 0 || retval == -EAGAIN)
 		retval = sprintf(buf, "%u %u %u\n", qtcb_port->cp_util,
 				 qtcb_port->cb_util, qtcb_port->a_util);
 	kfree(qtcb_port);
@@ -560,7 +560,7 @@ static int zfcp_sysfs_adapter_ex_config(struct device *dev,
 		return -ENOMEM;
 
 	retval = zfcp_fsf_exchange_config_data_sync(adapter->qdio, qtcb_config);
-	if (!retval)
+	if (retval == 0 || retval == -EAGAIN)
 		*stat_inf = qtcb_config->stat_info;
 
 	kfree(qtcb_config);
-- 
2.16.4
