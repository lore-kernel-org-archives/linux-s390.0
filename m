From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:52 +0000
Subject: [PATCH 09/10] zfcp: introduce SysFS interface to read the local B2B-Credit
Message-Id: <51fedf38b3213ea6e73a93204da6f34c205cb635.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In addition to the diagnostic data from the local SFP transceiver this
patch adds an interface to read the advertised buffer-to-buffer credit
from the local FC_Port.

With this patch the userspace-interface will only read data stored in
the corresponding "diagnostic buffer" (that was stored during completion
of a previous Exchange Config Data command). Implicit updating will
follow later in this series.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_sysfs.c | 40 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index e20baec37589..d49f8b442853 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -623,6 +623,45 @@ struct device_attribute *zfcp_sysfs_shost_attrs[] = {
 	NULL
 };
 
+static ssize_t zfcp_sysfs_adapter_diag_b2b_credit_show(
+	struct device *dev, struct device_attribute *attr, char *buf)
+{
+	struct zfcp_adapter *adapter = zfcp_ccw_adapter_by_cdev(to_ccwdev(dev));
+	struct zfcp_diag_header *diag_hdr;
+	struct fc_els_flogi *nsp;
+	ssize_t rc = -ENOLINK;
+	unsigned long flags;
+	unsigned int status;
+
+	if (!adapter)
+		return -ENODEV;
+
+	status = atomic_read(&adapter->status);
+	if (0 == (status & ZFCP_STATUS_COMMON_OPEN) ||
+	    0 == (status & ZFCP_STATUS_COMMON_UNBLOCKED) ||
+	    0 != (status & ZFCP_STATUS_COMMON_ERP_FAILED))
+		goto out;
+
+	diag_hdr = &adapter->diagnostics->config_data.header;
+
+	spin_lock_irqsave(&diag_hdr->access_lock, flags);
+	/* nport_serv_param doesn't contain the ELS_Command code */
+	nsp = (struct fc_els_flogi *)((unsigned long)
+					      adapter->diagnostics->config_data
+						      .data.nport_serv_param -
+				      sizeof(u32));
+
+	rc = scnprintf(buf, 5 + 2, "%hu\n",
+		       be16_to_cpu(nsp->fl_csp.sp_bb_cred));
+	spin_unlock_irqrestore(&diag_hdr->access_lock, flags);
+
+out:
+	zfcp_ccw_adapter_put(adapter);
+	return rc;
+}
+static ZFCP_DEV_ATTR(adapter_diag, b2b_credit, 0400,
+		     zfcp_sysfs_adapter_diag_b2b_credit_show, NULL);
+
 #define ZFCP_DEFINE_DIAG_SFP_ATTR(_name, _qtcb_member, _prtsize, _prtfmt)      \
 	static ssize_t zfcp_sysfs_adapter_diag_sfp_##_name##_show(             \
 		struct device *dev, struct device_attribute *attr, char *buf)  \
@@ -690,6 +729,7 @@ static struct attribute *zfcp_sysfs_diag_attrs[] = {
 	&dev_attr_adapter_diag_sfp_sfp_invalid.attr,
 	&dev_attr_adapter_diag_sfp_connector_type.attr,
 	&dev_attr_adapter_diag_sfp_fec_active.attr,
+	&dev_attr_adapter_diag_b2b_credit.attr,
 	NULL,
 };
 
-- 
2.16.4
