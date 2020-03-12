Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:17772 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726387AbgCLR6W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 13:58:22 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CHtgx5088577
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:58:21 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqskk8ts1-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:58:17 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:43 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 10/10] zfcp: log FC Endpoint Security errors
Date: Thu, 12 Mar 2020 18:45:05 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-11-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>

From: Jens Remus <jremus@linux.ibm.com>

Log any FC Endpoint Security errors to the kernel ring buffer with rate-
limiting.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 62 ++++++++++++++++++++++++++++++++++++
 drivers/s390/scsi/zfcp_fsf.h |  8 +++++
 2 files changed, 70 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index e8d0bf0ec10f..662ddbc74263 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1647,6 +1647,62 @@ static void zfcp_fsf_log_port_fc_security(struct zfcp_port *port,
 	port->connection_info_old = port->connection_info;
 }
 
+static void zfcp_fsf_log_security_error(const struct device *dev, u32 fsf_sqw0,
+					u64 wwpn)
+{
+	switch (fsf_sqw0) {
+
+	/*
+	 * Open Port command error codes
+	 */
+
+	case FSF_SQ_SECURITY_REQUIRED:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: FC security is required but not supported or configured on remote port 0x%016llx\n",
+				     wwpn);
+		break;
+	case FSF_SQ_SECURITY_TIMEOUT:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: a timeout prevented opening remote port 0x%016llx\n",
+				     wwpn);
+		break;
+	case FSF_SQ_SECURITY_KM_UNAVAILABLE:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: opening remote port 0x%016llx failed because local and external key manager cannot communicate\n",
+				     wwpn);
+		break;
+	case FSF_SQ_SECURITY_RKM_UNAVAILABLE:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: opening remote port 0x%016llx failed because it cannot communicate with the external key manager\n",
+				     wwpn);
+		break;
+	case FSF_SQ_SECURITY_AUTH_FAILURE:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: the device could not verify the identity of remote port 0x%016llx\n",
+				     wwpn);
+		break;
+
+	/*
+	 * Send FCP command error codes
+	 */
+
+	case FSF_SQ_SECURITY_ENC_FAILURE:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: FC connection to remote port 0x%016llx closed because encryption broke down\n",
+				     wwpn);
+		break;
+
+	/*
+	 * Unknown error codes
+	 */
+
+	default:
+		dev_warn_ratelimited(dev,
+				     "FC Endpoint Security error: the device issued an unknown error code 0x%08x related to the FC connection to remote port 0x%016llx\n",
+				     fsf_sqw0, wwpn);
+	}
+}
+
 static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
@@ -1671,6 +1727,9 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_SECURITY_ERROR:
+		zfcp_fsf_log_security_error(&req->adapter->ccw_device->dev,
+					    header->fsf_status_qual.word[0],
+					    port->wwpn);
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_ADAPTER_STATUS_AVAILABLE:
@@ -2404,6 +2463,9 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req,
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_SECURITY_ERROR:
+		zfcp_fsf_log_security_error(&req->adapter->ccw_device->dev,
+					    header->fsf_status_qual.word[0],
+					    zfcp_sdev->port->wwpn);
 		zfcp_erp_port_forced_reopen(zfcp_sdev->port, 0, "fssfch7");
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index c6a56f96c363..ba1fd144b890 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -111,6 +111,14 @@
 #define FSF_PSQ_LINK_MODE_TABLE_CURRUPTED	0x00004000
 #define FSF_PSQ_LINK_NO_WWPN_ASSIGNMENT		0x00008000
 
+/* FSF status qualifier, security error */
+#define FSF_SQ_SECURITY_REQUIRED		0x00000001
+#define FSF_SQ_SECURITY_TIMEOUT			0x00000002
+#define FSF_SQ_SECURITY_KM_UNAVAILABLE		0x00000003
+#define FSF_SQ_SECURITY_RKM_UNAVAILABLE		0x00000004
+#define FSF_SQ_SECURITY_AUTH_FAILURE		0x00000005
+#define FSF_SQ_SECURITY_ENC_FAILURE		0x00000010
+
 /* payload size in status read buffer */
 #define FSF_STATUS_READ_PAYLOAD_SIZE		4032
 
-- 
2.17.1
