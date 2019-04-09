From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:53 +0000
Subject: [PATCH 10/10] zfcp: implicitly refresh config-data diagnostics when reading SysFS
Message-Id: <a2acd762e1d299e0e9cd36bc3264f05c6e75edf9.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Adds implicit updates of cached diagnostics via Exchange Config Data
when reading SysFS attributes interfacing them. Right now this only
affects the new B2B-Credit diagnostic attribute.

This uses the same mechanism previously also used for cached diagnostics
of Exchange Port Data.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_diag.c  | 37 +++++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_diag.h  |  1 +
 drivers/s390/scsi/zfcp_sysfs.c |  5 +++++
 3 files changed, 43 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
index 54458c2bf843..6a9a1c54e23e 100644
--- a/drivers/s390/scsi/zfcp_diag.c
+++ b/drivers/s390/scsi/zfcp_diag.c
@@ -186,6 +186,43 @@ int zfcp_diag_update_port_data_buffer(struct zfcp_adapter *const adapter)
 	return rc;
 }
 
+/**
+ * zfcp_diag_update_config_data_buffer() - Implementation of
+ *                                         &typedef zfcp_diag_update_buffer_func
+ *                                         to collect and update Config Data.
+ * @adapter: Adapter to collect Config Data from.
+ *
+ * This call is SYNCHRONOUS ! It blocks till the respective command has
+ * finished completely, or has failed in some way.
+ *
+ * Return:
+ * * 0		- Successfully retrieved new Diagnostics and Updated the buffer;
+ *                this also includes cases where data was retrieved, but
+ *                incomplete; you'll have to check the flag ``incomplete``
+ *                of &struct zfcp_diag_header.
+ * * -ENOMEM	- In case it is not possible to allocate memory for the qtcb
+ *                bottom.
+ * * see zfcp_fsf_exchange_config_data_sync() for possible error-codes (
+ *   excluding -EAGAIN)
+ */
+int zfcp_diag_update_config_data_buffer(struct zfcp_adapter *const adapter)
+{
+	struct fsf_qtcb_bottom_config *qtcb_bottom;
+	int rc;
+
+	qtcb_bottom = kzalloc(sizeof(*qtcb_bottom), GFP_KERNEL);
+	if (qtcb_bottom == NULL)
+		return -ENOMEM;
+
+	rc = zfcp_fsf_exchange_config_data_sync(adapter->qdio, qtcb_bottom);
+	if (rc == -EAGAIN)
+		rc = 0; /* signaling incomplete via struct zfcp_diag_header */
+
+	/* buffer-data was updated in zfcp_fsf_exchange_config_data_handler() */
+
+	return rc;
+}
+
 static int __zfcp_diag_update_buffer(struct zfcp_adapter *const adapter,
 				     struct zfcp_diag_header *const hdr,
 				     zfcp_diag_update_buffer_func buffer_update,
diff --git a/drivers/s390/scsi/zfcp_diag.h b/drivers/s390/scsi/zfcp_diag.h
index 994ee7e9207c..e582b8219cc1 100644
--- a/drivers/s390/scsi/zfcp_diag.h
+++ b/drivers/s390/scsi/zfcp_diag.h
@@ -77,6 +77,7 @@ void zfcp_diag_update_xdata(struct zfcp_diag_header *const hdr,
  */
 typedef int (*zfcp_diag_update_buffer_func)(struct zfcp_adapter *const adapter);
 
+int zfcp_diag_update_config_data_buffer(struct zfcp_adapter *const adapter);
 int zfcp_diag_update_port_data_buffer(struct zfcp_adapter *const adapter);
 int zfcp_diag_update_buffer_limited(struct zfcp_adapter *const adapter,
 				    struct zfcp_diag_header *const hdr,
diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index d49f8b442853..8bd04b3ca9f9 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -644,6 +644,11 @@ static ssize_t zfcp_sysfs_adapter_diag_b2b_credit_show(
 
 	diag_hdr = &adapter->diagnostics->config_data.header;
 
+	rc = zfcp_diag_update_buffer_limited(
+		adapter, diag_hdr, zfcp_diag_update_config_data_buffer);
+	if (rc != 0)
+		goto out;
+
 	spin_lock_irqsave(&diag_hdr->access_lock, flags);
 	/* nport_serv_param doesn't contain the ELS_Command code */
 	nsp = (struct fc_els_flogi *)((unsigned long)
-- 
2.16.4
