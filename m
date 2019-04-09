From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:47 +0000
Subject: [PATCH 04/10] zfcp: add diagnostics buffer for exchange config data
Message-Id: <aa442f46d408179149af8f1123985888e9e02a3b.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In the same vein as the previous patch, add diagnostic data capture for
the Exchange Config Data command.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_diag.c | 14 ++++++++++++--
 drivers/s390/scsi/zfcp_diag.h |  7 +++++++
 drivers/s390/scsi/zfcp_fsf.c  |  9 +++++++++
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
index ca56a8f136ca..a9564c9156eb 100644
--- a/drivers/s390/scsi/zfcp_diag.c
+++ b/drivers/s390/scsi/zfcp_diag.c
@@ -34,6 +34,9 @@
  */
 int zfcp_diag_adapter_setup(struct zfcp_adapter *const adapter)
 {
+	/* set the timestamp so that the first test on age will always fail */
+	const unsigned long initial_timestamp =
+		jiffies - msecs_to_jiffies(ZFCP_DIAG_MAX_AGE);
 	struct zfcp_diag_adapter *diag;
 	struct zfcp_diag_header *hdr;
 
@@ -47,8 +50,15 @@ int zfcp_diag_adapter_setup(struct zfcp_adapter *const adapter)
 	spin_lock_init(&hdr->access_lock);
 	hdr->buffer = &diag->port_data.data;
 	hdr->buffer_size = sizeof(diag->port_data.data);
-	/* set the timestamp so that the first test on age will always fail */
-	hdr->timestamp = jiffies - msecs_to_jiffies(ZFCP_DIAG_MAX_AGE);
+	hdr->timestamp = initial_timestamp;
+
+	/* setup header for config_data */
+	hdr = &diag->config_data.header;
+
+	spin_lock_init(&hdr->access_lock);
+	hdr->buffer = &diag->config_data.data;
+	hdr->buffer_size = sizeof(diag->config_data.data);
+	hdr->timestamp = initial_timestamp;
 
 	adapter->diagnostics = diag;
 	return 0;
diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
index 5c81e7a8b8d7..031050c82b6e 100644
--- a/drivers/s390/scsi/zfcp_diag.h
+++ b/drivers/s390/scsi/zfcp_diag.h
@@ -43,12 +43,19 @@ struct zfcp_diag_header {
  * @port_data: data retrieved using exchange port data.
  * @port_data.header: header with metadata for the cache in @port_data.data.
  * @port_data.data: cached QTCB Bottom of command exchange port data.
+ * @config_data: data retrieved using exchange config data.
+ * @config_data.header: header with metadata for the cache in @config_data.data.
+ * @config_data.data: cached QTCB Bottom of command exchange config data.
  */
 struct zfcp_diag_adapter {
 	struct {
 		struct zfcp_diag_header		header;
 		struct fsf_qtcb_bottom_port	data;
 	} port_data;
+	struct {
+		struct zfcp_diag_header		header;
+		struct fsf_qtcb_bottom_config	data;
+	} config_data;
 };
 
 int zfcp_diag_adapter_setup(struct zfcp_adapter *const adapter);
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 310cc937d1f1..e23bb0948740 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -545,6 +545,8 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
+	struct zfcp_diag_header *const diag_hdr =
+		&adapter->diagnostics->config_data.header;
 	struct fsf_qtcb *qtcb = req->qtcb;
 	struct fsf_qtcb_bottom_config *bottom = &qtcb->bottom.config;
 	struct Scsi_Host *shost = adapter->scsi_host;
@@ -561,6 +563,12 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 
 	switch (qtcb->header.fsf_status) {
 	case FSF_GOOD:
+		/*
+		 * usually we wait with an update till the cache is too old,
+		 * but because we have the data available, update it anyway
+		 */
+		zfcp_diag_update_xdata(diag_hdr, bottom, false);
+
 		if (zfcp_fsf_exchange_config_evaluate(req))
 			return;
 
@@ -576,6 +584,7 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 				&adapter->status);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
+		zfcp_diag_update_xdata(diag_hdr, bottom, true);
 		req->status |= ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE;
 
 		fc_host_node_name(shost) = 0;
-- 
2.16.4
