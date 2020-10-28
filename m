Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:2902 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725828AbgJ1Vc4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:32:56 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 5/5] zfcp: handle event-lost notification for Version Change events
Date: Wed, 28 Oct 2020 19:30:52 +0100
Message-Id: <297c7be2944c3714863fcd22d531d910312d29f0.1603908167.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

As recovery for a lost Version Change event, trigger an
Exchange Config Data cmd to retrieve the current FW version.

Doing so requires process context (as eg. zfcp_qdio_sbal_get()
might need to sleep), so defer from tasklet context into a work
item.

Suggested-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_aux.c | 11 +++++++++++
 drivers/s390/scsi/zfcp_def.h |  1 +
 drivers/s390/scsi/zfcp_fsf.c |  3 +++
 drivers/s390/scsi/zfcp_fsf.h |  1 +
 4 files changed, 16 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_aux.c b/drivers/s390/scsi/zfcp_aux.c
index 18b713a616de..768873dd55b8 100644
--- a/drivers/s390/scsi/zfcp_aux.c
+++ b/drivers/s390/scsi/zfcp_aux.c
@@ -292,6 +292,14 @@ static void _zfcp_status_read_scheduler(struct work_struct *work)
 					     stat_work));
 }
 
+static void zfcp_version_change_lost_work(struct work_struct *work)
+{
+	struct zfcp_adapter *adapter = container_of(work, struct zfcp_adapter,
+						    version_change_lost_work);
+
+	zfcp_fsf_exchange_config_data_sync(adapter->qdio, NULL);
+}
+
 static void zfcp_print_sl(struct seq_file *m, struct service_level *sl)
 {
 	struct zfcp_adapter *adapter =
@@ -353,6 +361,8 @@ struct zfcp_adapter *zfcp_adapter_enqueue(struct ccw_device *ccw_device)
 	INIT_WORK(&adapter->stat_work, _zfcp_status_read_scheduler);
 	INIT_DELAYED_WORK(&adapter->scan_work, zfcp_fc_scan_ports);
 	INIT_WORK(&adapter->ns_up_work, zfcp_fc_sym_name_update);
+	INIT_WORK(&adapter->version_change_lost_work,
+		  zfcp_version_change_lost_work);
 
 	adapter->next_port_scan = jiffies;
 
@@ -429,6 +439,7 @@ void zfcp_adapter_unregister(struct zfcp_adapter *adapter)
 	cancel_delayed_work_sync(&adapter->scan_work);
 	cancel_work_sync(&adapter->stat_work);
 	cancel_work_sync(&adapter->ns_up_work);
+	cancel_work_sync(&adapter->version_change_lost_work);
 	zfcp_destroy_adapter_work_queue(adapter);
 
 	zfcp_fc_wka_ports_force_offline(adapter->gs);
diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index da8a5ceb615c..f656d74a5f94 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -201,6 +201,7 @@ struct zfcp_adapter {
 	struct zfcp_fc_events events;
 	unsigned long		next_port_scan;
 	struct zfcp_diag_adapter	*diagnostics;
+	struct work_struct	version_change_lost_work;
 };
 
 struct zfcp_port {
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index afa95e04eceb..7593a9667b3e 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -309,6 +309,9 @@ static void zfcp_fsf_status_read_handler(struct zfcp_fsf_req *req)
 	case FSF_STATUS_READ_NOTIFICATION_LOST:
 		if (sr_buf->status_subtype & FSF_STATUS_READ_SUB_INCOMING_ELS)
 			zfcp_fc_conditional_port_scan(adapter);
+		if (sr_buf->status_subtype & FSF_STATUS_READ_SUB_VERSION_CHANGE)
+			queue_work(adapter->work_queue,
+				   &adapter->version_change_lost_work);
 		break;
 	case FSF_STATUS_READ_FEATURE_UPDATE_ALERT:
 		adapter->adapter_features = sr_buf->payload.word[0];
diff --git a/drivers/s390/scsi/zfcp_fsf.h b/drivers/s390/scsi/zfcp_fsf.h
index 26ad7a0c5ce3..5e6b601af980 100644
--- a/drivers/s390/scsi/zfcp_fsf.h
+++ b/drivers/s390/scsi/zfcp_fsf.h
@@ -143,6 +143,7 @@
 
 /* status subtypes for unsolicited status notification lost */
 #define FSF_STATUS_READ_SUB_INCOMING_ELS	0x00000001
+#define FSF_STATUS_READ_SUB_VERSION_CHANGE	0x00000100
 
 /* status subtypes for version change */
 #define FSF_STATUS_READ_SUB_LIC_CHANGE		0x00000001
-- 
2.26.2
