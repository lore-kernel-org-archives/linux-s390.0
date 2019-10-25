Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:55630 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2502416AbfJYQNB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:01 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG8uVg070107
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from e06smtp07.uk.ibm.com (e06smtp07.uk.ibm.com [195.75.94.103])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv46t0fea-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from localhost
        by e06smtp07.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:58 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 03/11] zfcp: add diagnostics buffer for exchange config data
Date: Fri, 25 Oct 2019 18:12:45 +0200
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <7d8ac0a6cad403fa8f8b888693476a84e80a277b.1572018131.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

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
index fa1b25f3ec3c..d7d2db85b32e 100644
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
index 2a933326b6e4..a3eb21cc201d 100644
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
index 883bbfd67a62..0fff060de5ac 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -556,6 +556,8 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
+	struct zfcp_diag_header *const diag_hdr =
+		&adapter->diagnostics->config_data.header;
 	struct fsf_qtcb *qtcb = req->qtcb;
 	struct fsf_qtcb_bottom_config *bottom = &qtcb->bottom.config;
 	struct Scsi_Host *shost = adapter->scsi_host;
@@ -572,6 +574,12 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 
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
 
@@ -587,6 +595,7 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 				&adapter->status);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
+		zfcp_diag_update_xdata(diag_hdr, bottom, true);
 		req->status |= ZFCP_STATUS_FSFREQ_XDATAINCOMPLETE;
 
 		fc_host_node_name(shost) = 0;
-- 
2.21.0
