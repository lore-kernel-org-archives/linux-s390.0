Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:23492 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgCLR4t (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 13:56:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CHtakL084067
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:56:47 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqskk8v0j-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:56:44 -0400
Received: from localhost
        by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:40 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 09/10] zfcp: enhance handling of FC Endpoint Security errors
Date: Thu, 12 Mar 2020 18:45:04 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-10-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>

From: Jens Remus <jremus@linux.ibm.com>

Enable for explicit FCP channel FC Endpoint Security error reporting and
handle any FSF security errors according to specification. Take the
following recovery actions when a FSF_SECURITY_ERROR is reported for the
specified FSF commands:

- Open Port: Retry the command if possible
- Send FCP : Physically close the remote port and reopen

For Open Port the command status is set to error, which triggers a retry.
For Send FCP the command status is set to error and recovery is triggered
to physically reopen the remote port.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 13 +++++++++++--
 drivers/s390/scsi/zfcp_fsf.h |  1 +
 2 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 1d3eac12a8c6..e8d0bf0ec10f 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1405,7 +1405,8 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
 			FSF_FEATURE_UPDATE_ALERT |
-			FSF_FEATURE_REQUEST_SFP_DATA;
+			FSF_FEATURE_REQUEST_SFP_DATA |
+			FSF_FEATURE_FC_SECURITY;
 	req->erp_action = erp_action;
 	req->handler = zfcp_fsf_exchange_config_data_handler;
 	erp_action->fsf_req_id = req->req_id;
@@ -1459,7 +1460,8 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
 			FSF_FEATURE_UPDATE_ALERT |
-			FSF_FEATURE_REQUEST_SFP_DATA;
+			FSF_FEATURE_REQUEST_SFP_DATA |
+			FSF_FEATURE_FC_SECURITY;
 
 	if (data)
 		req->data = data;
@@ -1668,6 +1670,9 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 					 ZFCP_STATUS_COMMON_ERP_FAILED);
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
+	case FSF_SECURITY_ERROR:
+		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
 	case FSF_ADAPTER_STATUS_AVAILABLE:
 		switch (header->fsf_status_qual.word[0]) {
 		case FSF_SQ_INVOKE_LINK_TEST_PROCEDURE:
@@ -2398,6 +2403,10 @@ static void zfcp_fsf_fcp_handler_common(struct zfcp_fsf_req *req,
 			zfcp_fc_test_link(zfcp_sdev->port);
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
+	case FSF_SECURITY_ERROR:
+		zfcp_erp_port_forced_reopen(zfcp_sdev->port, 0, "fssfch7");
+		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
+		break;
 	}
 }
 
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 66de1708973d..c6a56f96c363 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -78,6 +78,7 @@
 #define FSF_BLOCK_GUARD_CHECK_FAILURE		0x00000081
 #define FSF_APP_TAG_CHECK_FAILURE		0x00000082
 #define FSF_REF_TAG_CHECK_FAILURE		0x00000083
+#define FSF_SECURITY_ERROR			0x00000090
 #define FSF_ADAPTER_STATUS_AVAILABLE		0x000000AD
 #define FSF_FCP_RSP_AVAILABLE			0x000000AF
 #define FSF_UNKNOWN_COMMAND			0x000000E2
-- 
2.17.1
