From: Benjamin Block <bblock@linux.ibm.com>
Date: Tue, 09 Apr 2019 16:50:48 +0000
Subject: [PATCH 05/10] zfcp: support retrieval of SFP Data via Exchange Port Data
Message-Id: <88f0c8377a80fe0c95dfa095c610515d474bf570.1554823974.git.bblock@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

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
index e23bb0948740..d0100cec10cb 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -1257,7 +1257,8 @@ int zfcp_fsf_exchange_config_data(struct zfcp_erp_action *erp_action)
 
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
-			FSF_FEATURE_UPDATE_ALERT;
+			FSF_FEATURE_UPDATE_ALERT |
+			FSF_FEATURE_REQUEST_SFP_DATA;
 	req->erp_action = erp_action;
 	req->handler = zfcp_fsf_exchange_config_data_handler;
 	erp_action->fsf_req_id = req->req_id;
@@ -1308,7 +1309,8 @@ int zfcp_fsf_exchange_config_data_sync(struct zfcp_qdio *qdio,
 
 	req->qtcb->bottom.config.feature_selection =
 			FSF_FEATURE_NOTIFICATION_LOST |
-			FSF_FEATURE_UPDATE_ALERT;
+			FSF_FEATURE_UPDATE_ALERT |
+			FSF_FEATURE_REQUEST_SFP_DATA;
 
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
2.16.4
