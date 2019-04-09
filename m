From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:45 +0000
Subject: [PATCH 02/10] zfcp: remove option to pass NULL to sync exchange config/port data
Message-Id: <fbb06a9143bb760a394dc45fa030574bf444aa96.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

When the FSF functions for Exchange Config/Port Data were separated into
a async- and synchronous variation - where the synchronous variation is
and was only used by userspace-interfaces, and the asynchronous
variation by ERP - it was designed such that the synchronous variation
could optionally take a buffer to store the QTCB Bottom received with
Exchange Config/Port Data.

In practice this buffer was always used and no caller ever used these
functions and not pass the buffer. It is unclear what use these functions
would have for a userspace-interfaces without handling any of the data
received with the commands. Hence to cleanup and simplify the code a bit,
remove the optional part and make it mandatory.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 16 ++++++----------
 1 file changed, 6 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index c6a448586127..808e3f6200ae 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1256,8 +1256,7 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 /**
  * zfcp_fsf_exchange_config_data_sync() - Request information about FCP channel.
  * @qdio: pointer to the QDIO-Queue to use for sending the command.
- * @data: pointer to the QTCB-Bottom for storing the result of the command,
- *        might be %NULL.
+ * @data: pointer to the QTCB-Bottom for storing the result of the command.
  *
  * Returns:
  * * 0		- Exchange Config Data was successful, @data is complete
@@ -1290,8 +1289,7 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 			FSF_FEATURE_NOTIFICATION_LOST |
 			FSF_FEATURE_UPDATE_ALERT;
 
-	if (data)
-		req->data = data;
+	req->data = data;
 
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
@@ -1363,8 +1361,7 @@ int zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action)
 /**
  * zfcp_fsf_exchange_port_data_sync() - Request information about local port.
  * @qdio: pointer to the QDIO-Queue to use for sending the command.
- * @data: pointer to the QTCB-Bottom for storing the result of the command,
- *        might be %NULL.
+ * @data: pointer to the QTCB-Bottom for storing the result of the command.
  *
  * Returns:
  * * 0		- Exchange Port Data was successful, @data is complete
@@ -1394,12 +1391,11 @@ int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 		goto out_unlock;
 	}
 
-	if (data)
-		req->data = data;
-
 	zfcp_qdio_set_sbale_last(qdio, &req->qdio_req);
-
 	req->handler = zfcp_fsf_exchange_port_data_handler;
+
+	req->data = data;
+
 	zfcp_fsf_start_timer(req, ZFCP_FSF_REQUEST_TIMEOUT);
 	retval = zfcp_fsf_req_send(req);
 	spin_unlock_irq(&qdio->req_q_lock);
-- 
2.16.4
