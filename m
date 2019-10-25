Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56784 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729994AbfJYQNC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:02 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG8xY7073489
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:01 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv20ap5n8-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:01 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:59 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 08/11] zfcp: implicitly refresh config-data diagnostics when reading SysFS
Date: Fri, 25 Oct 2019 18:12:50 +0200
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <60a94f55f2630b74b468fed5f39880208abb2679.1572018132.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

Adds implicit updates of cached diagnostics via Exchange Config Data
when reading SysFS attributes interfacing them. Right now this only
affects the new B2B-Credit diagnostic attribute.

This uses the same mechanism previously also used for cached diagnostics
of Exchange Port Data.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_diag.c  | 30 ++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_diag.h  |  1 +
 drivers/s390/scsi/zfcp_sysfs.c |  5 +++++
 3 files changed, 36 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_diag.c b/drivers/s390/scsi/zfcp_diag.c
index 9c5a0f3431ca..5ef7b3288c6f 100644
--- a/drivers/s390/scsi/zfcp_diag.c
+++ b/drivers/s390/scsi/zfcp_diag.c
@@ -176,6 +176,36 @@ int zfcp_diag_update_port_data_buffer(struct zfcp_adapter *const adapter)
 	return rc;
 }
 
+/**
+ * zfcp_diag_update_config_data_buffer() - Implementation of
+ *					   &typedef zfcp_diag_update_buffer_func
+ *					   to collect and update Config Data.
+ * @adapter: Adapter to collect Config Data from.
+ *
+ * This call is SYNCHRONOUS ! It blocks till the respective command has
+ * finished completely, or has failed in some way.
+ *
+ * Return:
+ * * 0		- Successfully retrieved new Diagnostics and Updated the buffer;
+ *		  this also includes cases where data was retrieved, but
+ *		  incomplete; you'll have to check the flag ``incomplete``
+ *		  of &struct zfcp_diag_header.
+ * * see zfcp_fsf_exchange_config_data_sync() for possible error-codes (
+ *   excluding -EAGAIN)
+ */
+int zfcp_diag_update_config_data_buffer(struct zfcp_adapter *const adapter)
+{
+	int rc;
+
+	rc = zfcp_fsf_exchange_config_data_sync(adapter->qdio, NULL);
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
index 7ff8fb0bb735..cf2947cd8c8f 100644
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
index 376d76b9f337..ae8e9137f448 100644
--- a/drivers/s390/scsi/zfcp_sysfs.c
+++ b/drivers/s390/scsi/zfcp_sysfs.c
@@ -687,6 +687,11 @@ static ssize_t zfcp_sysfs_adapter_diag_b2b_credit_show(
 
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
2.21.0
