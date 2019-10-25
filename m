Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59534 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2504429AbfJYQNB (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Fri, 25 Oct 2019 12:13:01 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x9PG8vds024438
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2vv3snhb0g-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Fri, 25 Oct 2019 12:13:00 -0400
Received: from localhost
        by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <bblock@linux.ibm.com>;
        Fri, 25 Oct 2019 17:12:58 +0100
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH v2 04/11] zfcp: support retrieval of SFP Data via Exchange Port Data
Date: Fri, 25 Oct 2019 18:12:46 +0200
In-Reply-To: <cover.1571934247.git.bblock@linux.ibm.com>
References: <cover.1571934247.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Message-Id: <ee1eba4de71eb06b4d82207ad4f428429346156f.1572018132.git.bblock@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Peter Oberparleiter <oberpar@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

A new FCP channel feature allows us to read the diagnostics from our
local SFP transceivers. To make use of that add a flag
(FSF_FEATURE_REQUEST_SFP_DATA) to the feature-set we request from the
FCP channel. Whether the channel actually implements this can be
determined via an other new flag (FSF_FEATURE_REPORT_SFP_DATA), that is
set in the adapter_features field of the adapter structure after
Exchange Config Data finished.

Also add the corresponding definitions in the QTCB Bottom for Exchange
Port Data. These new definitions are only valid, if
FSF_FEATURE_REPORT_SFP_DATA is set.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c |  6 ++++--
 drivers/s390/scsi/zfcp_fsf.h | 21 ++++++++++++++++++++-
 2 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 0fff060de5ac..223a805f0b0b 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1286,7 +1286,8 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
-			FSF_FEATURE_UPDATE_ALERT;
+			FSF_FEATURE_UPDATE_ALERT |
+			FSF_FEATURE_REQUEST_SFP_DATA;
 	req->erp_action = erp_action;
 	req->handler = zfcp_fsf_exchange_config_data_handler;
 	erp_action->fsf_req_id = req->req_id;
@@ -1339,7 +1340,8 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
-			FSF_FEATURE_UPDATE_ALERT;
+			FSF_FEATURE_UPDATE_ALERT |
+			FSF_FEATURE_REQUEST_SFP_DATA;
 
 	if (data)
 		req->data = data;
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 2c658b66318c..2b1e4da1944f 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -163,6 +163,8 @@
 #define FSF_FEATURE_ELS_CT_CHAINED_SBALS	0x00000020
 #define FSF_FEATURE_UPDATE_ALERT		0x00000100
 #define FSF_FEATURE_MEASUREMENT_DATA		0x00000200
+#define FSF_FEATURE_REQUEST_SFP_DATA		0x00000200
+#define FSF_FEATURE_REPORT_SFP_DATA		0x00000800
 #define FSF_FEATURE_DIF_PROT_TYPE1		0x00010000
 #define FSF_FEATURE_DIX_PROT_TCPIP		0x00020000
 
@@ -407,7 +409,24 @@ struct fsf_qtcb_bottom_port {
 	u8 cp_util;
 	u8 cb_util;
 	u8 a_util;
-	u8 res2[253];
+	u8 res2;
+	u16 temperature;
+	u16 vcc;
+	u16 tx_bias;
+	u16 tx_power;
+	u16 rx_power;
+	union {
+		u16 raw;
+		struct {
+			u16 fec_active		:1;
+			u16:7;
+			u16 connector_type	:2;
+			u16 sfp_invalid		:1;
+			u16 optical_port	:1;
+			u16 port_tx_type	:4;
+		};
+	} sfp_flags;
+	u8 res3[240];
 } __attribute__ ((packed));
 
 union fsf_qtcb_bottom {
-- 
2.21.0
