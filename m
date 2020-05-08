Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:52332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727830AbgEHRXr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:47 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 3/8] zfcp: move fc_host updates during xport data handling into fenced function
Date: Fri,  8 May 2020 19:23:30 +0200
Message-Id: <ae454c2dc6da0b02907c489af91d0b211d331825.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

When executing exchange port data for a FCP device for the first time, or
after an adapter recovery, we update several properties of the fibre
channel host object which represents that FCP device.

When moving the scsi host object allocation and registration - and thus
also the fibre channel host object allocation - to after the first
exchange config and exchange port data, this is not possible for the
former case.

Move all these update into separate, and fenced function that first
checks whether the scsi host object already exists or not, before making
the updates.

During the first ever exchange port data in the adapter life cycle
this will make the exchange port data handler skip over this update
step, but we can repeat it later, after we allocated the scsi host
object.

For any further recovery of that adapter the work flow is only changed
slightly because then the scsi host object already exists and we don't
free it until we release the adapter completely at the end of its life
cycle.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_ext.h  |  3 +++
 drivers/s390/scsi/zfcp_fsf.c  | 12 +++---------
 drivers/s390/scsi/zfcp_scsi.c | 19 +++++++++++++++++++
 3 files changed, 25 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 4c4be754cf6e..5dc9bdc5803f 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -176,6 +176,9 @@ extern void zfcp_scsi_shost_update_config_data(
 	struct zfcp_adapter *const adapter,
 	const struct fsf_qtcb_bottom_config *const bottom,
 	const bool bottom_incomplete);
+extern void zfcp_scsi_shost_update_port_data(
+	struct zfcp_adapter *const adapter,
+	const struct fsf_qtcb_bottom_port *const bottom);
 
 /* zfcp_sysfs.c */
 extern const struct attribute_group *zfcp_unit_attr_groups[];
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 54edfcbe84ce..bfb567a1d7bf 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -725,19 +725,10 @@ static void zfcp_fsf_exchange_port_evaluate(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
 	struct fsf_qtcb_bottom_port *bottom = &req->qtcb->bottom.port;
-	struct Scsi_Host *shost = adapter->scsi_host;
 
 	if (req->data)
 		memcpy(req->data, bottom, sizeof(*bottom));
 
-	fc_host_permanent_port_name(shost) = bottom->wwpn;
-	fc_host_maxframe_size(shost) = bottom->maximum_frame_size;
-	fc_host_supported_speeds(shost) =
-		zfcp_fsf_convert_portspeed(bottom->supported_speed);
-	memcpy(fc_host_supported_fc4s(shost), bottom->supported_fc4_types,
-	       FC_FC4_LIST_SIZE);
-	memcpy(fc_host_active_fc4s(shost), bottom->active_fc4_types,
-	       FC_FC4_LIST_SIZE);
 	if (adapter->adapter_features & FSF_FEATURE_FC_SECURITY)
 		adapter->fc_security_algorithms =
 			bottom->fc_security_algorithms;
@@ -764,6 +755,7 @@ static void zfcp_fsf_exchange_port_data_handler(struct zfcp_fsf_req *req)
 		 */
 		zfcp_diag_update_xdata(diag_hdr, bottom, false);
 
+		zfcp_scsi_shost_update_port_data(req->adapter, bottom);
 		zfcp_fsf_exchange_port_evaluate(req);
 		break;
 	case FSF_EXCHANGE_CONFIG_DATA_INCOMPLETE:
@@ -772,6 +764,8 @@ static void zfcp_fsf_exchange_port_data_handler(struct zfcp_fsf_req *req)
 
 		zfcp_fsf_link_down_info_eval(req,
 			&qtcb->header.fsf_status_qual.link_down_info);
+
+		zfcp_scsi_shost_update_port_data(req->adapter, bottom);
 		zfcp_fsf_exchange_port_evaluate(req);
 		break;
 	}
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index e1281a1ce488..f98e4015a0ed 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -911,6 +911,25 @@ void zfcp_scsi_shost_update_config_data(
 	}
 }
 
+void zfcp_scsi_shost_update_port_data(
+	struct zfcp_adapter *const adapter,
+	const struct fsf_qtcb_bottom_port *const bottom)
+{
+	struct Scsi_Host *const shost = adapter->scsi_host;
+
+	if (shost == NULL)
+		return;
+
+	fc_host_permanent_port_name(shost) = bottom->wwpn;
+	fc_host_maxframe_size(shost) = bottom->maximum_frame_size;
+	fc_host_supported_speeds(shost) =
+		zfcp_fsf_convert_portspeed(bottom->supported_speed);
+	memcpy(fc_host_supported_fc4s(shost), bottom->supported_fc4_types,
+	       FC_FC4_LIST_SIZE);
+	memcpy(fc_host_active_fc4s(shost), bottom->active_fc4_types,
+	       FC_FC4_LIST_SIZE);
+}
+
 struct fc_function_template zfcp_transport_functions = {
 	.show_starget_port_id = 1,
 	.show_starget_port_name = 1,
-- 
2.17.1
