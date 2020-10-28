Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:55030 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgJ1Vm2 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:42:28 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 4/5] zfcp: process Version Change events
Date: Wed, 28 Oct 2020 19:30:51 +0100
Message-Id: <d2c7bc57c6cf1b65eabbf7a5d0e3927b9f65647f.1603908167.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Handle notifications for a concurrent change of the FCP Channel
firmware.
Update the relevant user-visible fields to provide accurate data.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 16 ++++++++++++++++
 drivers/s390/scsi/zfcp_fsf.h | 10 ++++++++++
 2 files changed, 26 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 6cb963a06777..afa95e04eceb 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -242,6 +242,19 @@ static void zfcp_fsf_status_read_link_down(struct zfcp_fsf_req *req)
 	}
 }
 
+static void
+zfcp_fsf_status_read_version_change(struct zfcp_adapter *adapter,
+				    struct fsf_status_read_buffer *sr_buf)
+{
+	if (sr_buf->status_subtype == FSF_STATUS_READ_SUB_LIC_CHANGE) {
+		u32 version = sr_buf->payload.version_change.current_version;
+
+		WRITE_ONCE(adapter->fsf_lic_version, version);
+		snprintf(fc_host_firmware_version(adapter->scsi_host),
+			 FC_VERSION_STRING_SIZE, "%#08x", version);
+	}
+}
+
 static void zfcp_fsf_status_read_handler(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
@@ -300,6 +313,9 @@ static void zfcp_fsf_status_read_handler(struct zfcp_fsf_req *req)
 	case FSF_STATUS_READ_FEATURE_UPDATE_ALERT:
 		adapter->adapter_features = sr_buf->payload.word[0];
 		break;
+	case FSF_STATUS_READ_VERSION_CHANGE:
+		zfcp_fsf_status_read_version_change(adapter, sr_buf);
+		break;
 	}
 
 	mempool_free(virt_to_page(sr_buf), adapter->pool.sr_data);
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 09d73d0061ef..26ad7a0c5ce3 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -134,6 +134,7 @@
 #define FSF_STATUS_READ_LINK_UP          	0x00000006
 #define FSF_STATUS_READ_NOTIFICATION_LOST	0x00000009
 #define FSF_STATUS_READ_FEATURE_UPDATE_ALERT	0x0000000C
+#define FSF_STATUS_READ_VERSION_CHANGE		0x0000000D
 
 /* status subtypes for link down */
 #define FSF_STATUS_READ_SUB_NO_PHYSICAL_LINK	0x00000000
@@ -143,6 +144,9 @@
 /* status subtypes for unsolicited status notification lost */
 #define FSF_STATUS_READ_SUB_INCOMING_ELS	0x00000001
 
+/* status subtypes for version change */
+#define FSF_STATUS_READ_SUB_LIC_CHANGE		0x00000001
+
 /* topologie that is detected by the adapter */
 #define FSF_TOPO_P2P				0x00000001
 #define FSF_TOPO_FABRIC				0x00000002
@@ -226,6 +230,11 @@ struct fsf_link_down_info {
 	u8 vendor_specific_code;
 } __attribute__ ((packed));
 
+struct fsf_version_change {
+	u32 current_version;
+	u32 previous_version;
+} __packed;
+
 struct fsf_status_read_buffer {
 	u32 status_type;
 	u32 status_subtype;
@@ -242,6 +251,7 @@ struct fsf_status_read_buffer {
 		u32 word[FSF_STATUS_READ_PAYLOAD_SIZE/sizeof(u32)];
 		struct fsf_link_down_info link_down_info;
 		struct fsf_bit_error_payload bit_error;
+		struct fsf_version_change version_change;
 	} payload;
 } __attribute__ ((packed));
 
-- 
2.26.2
