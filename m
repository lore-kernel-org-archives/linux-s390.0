Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:34898 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2502274AbfJYQNB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:01 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG92fa066099
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:12:59 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv1ycwsjg-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:12:59 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:58 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 07/11] zfcp: introduce SysFS interface to read the local B2B-Credit
Date: Fri, 25 Oct 2019 18:12:49 +0200
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <8a53aef87b53c50cfb1a3425b799bacb6f82b832.1572018132.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

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
 drivers/s390/scsi/zfcp_sysfs.c | 40 ++++++++++++++++++++++++++++++++++
 1 file changed, 40 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_sysfs.c b/drivers/s390/scsi/zfcp_sysfs.c
index a2fa3db5695d..376d76b9f337 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -666,6 +666,45 @@ struct device_attribute *zfcp_sysfs_shost_attrs[] = {
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
 	static ssize_t zfcp_sysfs_adapter_diag_sfp_##_name##_show(	       \
 		struct device *dev, struct device_attribute *attr, char *buf)  \
@@ -733,6 +772,7 @@ static struct attribute *zfcp_sysfs_diag_attrs[] = {
 	&dev_attr_adapter_diag_sfp_sfp_invalid.attr,
 	&dev_attr_adapter_diag_sfp_connector_type.attr,
 	&dev_attr_adapter_diag_sfp_fec_active.attr,
+	&dev_attr_adapter_diag_b2b_credit.attr,
 	NULL,
 };
 
-- 
2.21.0
