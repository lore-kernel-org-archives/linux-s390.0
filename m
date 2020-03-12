Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:29800 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726362AbgCLRp0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 13:45:26 -0400
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CHiLD2143372
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:45:24 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqsrbr122-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:45:24 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:22 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 03/10] zfcp: wire previously driver-specific sysfs attributes also to fc_host
Date: Thu, 12 Mar 2020 18:44:58 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-4-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>

Manufacturer, HBA model, firmware version, and hardware version.
Use the same value format as for the driver-specific attributes.
Keep the driver-specific attributes for stable user space sysfs API.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c  | 11 +++++++++++
 drivers/s390/scsi/zfcp_scsi.c |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 0289b09120f3..31ecbc160482 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -502,6 +502,8 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 	if (req->data)
 		memcpy(req->data, bottom, sizeof(*bottom));
 
+	snprintf(fc_host_manufacturer(shost), FC_SERIAL_NUMBER_SIZE, "%s",
+		 "IBM");
 	fc_host_port_name(shost) = be64_to_cpu(nsp->fl_wwpn);
 	fc_host_node_name(shost) = be64_to_cpu(nsp->fl_wwnn);
 	fc_host_supported_classes(shost) = FC_COS_CLASS2 | FC_COS_CLASS3;
@@ -525,6 +527,8 @@ static int zfcp_fsf_exchange_config_evaluate(struct zfcp_fsf_req *req)
 		zfcp_fsf_convert_portspeed(bottom->fc_link_speed);
 
 	adapter->hydra_version = bottom->adapter_type;
+	snprintf(fc_host_model(shost), FC_SYMBOLIC_NAME_SIZE, "0x%04x",
+		 bottom->adapter_type);
 
 	switch (bottom->fc_topology) {
 	case FSF_TOPO_P2P:
@@ -569,6 +573,8 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 	if (req->status & ZFCP_STATUS_FSFREQ_ERROR)
 		return;
 
+	snprintf(fc_host_firmware_version(shost), FC_VERSION_STRING_SIZE,
+		 "0x%08x", bottom->lic_version);
 	adapter->fsf_lic_version = bottom->lic_version;
 	adapter->adapter_features = bottom->adapter_features;
 	adapter->connection_features = bottom->connection_features;
@@ -609,6 +615,8 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 		fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 		fc_host_port_type(shost) = FC_PORTTYPE_UNKNOWN;
 		adapter->hydra_version = 0;
+		snprintf(fc_host_model(shost), FC_SYMBOLIC_NAME_SIZE, "0x%04x",
+			 0);
 
 		/* avoids adapter shutdown to be able to recognize
 		 * events such as LINK UP */
@@ -626,6 +634,9 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 
 	if (adapter->adapter_features & FSF_FEATURE_HBAAPI_MANAGEMENT) {
 		adapter->hardware_version = bottom->hardware_version;
+		snprintf(fc_host_hardware_version(shost),
+			 FC_VERSION_STRING_SIZE,
+			 "0x%08x", bottom->hardware_version);
 		memcpy(fc_host_serial_number(shost), bottom->serial_number,
 		       min(FC_SERIAL_NUMBER_SIZE, 17));
 		EBCASC(fc_host_serial_number(shost),
diff --git a/drivers/s390/scsi/zfcp_scsi.c b/drivers/s390/scsi/zfcp_scsi.c
index cb7efe8b2753..13d873f806e4 100644
--- a/drivers/s390/scsi/zfcp_scsi.c
+++ b/drivers/s390/scsi/zfcp_scsi.c
@@ -856,6 +856,10 @@ struct fc_function_template zfcp_transport_functions = {
 	.show_host_supported_speeds = 1,
 	.show_host_maxframe_size = 1,
 	.show_host_serial_number = 1,
+	.show_host_manufacturer = 1,
+	.show_host_model = 1,
+	.show_host_hardware_version = 1,
+	.show_host_firmware_version = 1,
 	.get_fc_host_stats = zfcp_scsi_get_fc_host_stats,
 	.reset_fc_host_stats = zfcp_scsi_reset_fc_host_stats,
 	.set_rport_dev_loss_tmo = zfcp_scsi_set_rport_dev_loss_tmo,
-- 
2.17.1
