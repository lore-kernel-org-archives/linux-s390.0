Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:25686 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726127AbgCLRzt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 13:55:49 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CHtbJq084721
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:55:47 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2yqskk8sgq-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:55:45 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:30 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 07/10] zfcp: log FC Endpoint Security of connections
Date: Thu, 12 Mar 2020 18:45:02 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-8-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>

From: Jens Remus <jremus@linux.ibm.com>

Log the usage of and subsequent changes in FC Endpoint Security of
connections between FCP devices and FC remote ports to the kernel ring
buffer. Activation of FC Endpoint Security is logged as informational.
Change and deactivation are logged as warning.

No logging takes place, if FC Endpoint Security is not used (i.e. never
activated) on a connection or if it does not change during reopen of
a port (e.g. due to adapter or port recovery).

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_def.h |  1 +
 drivers/s390/scsi/zfcp_fsf.c | 54 +++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_def.h b/drivers/s390/scsi/zfcp_def.h
index 861ddc1ef2a9..b6af4a93681c 100644
--- a/drivers/s390/scsi/zfcp_def.h
+++ b/drivers/s390/scsi/zfcp_def.h
@@ -220,6 +220,7 @@ struct zfcp_port {
 	u32                    maxframe_size;
 	u32                    supported_classes;
 	u32                    connection_info;
+	u32                    connection_info_old;
 	struct work_struct     gid_pn_work;
 	struct work_struct     test_link_work;
 	struct work_struct     rport_work;
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 068cb94beb58..08ce0fa04665 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -666,6 +666,9 @@ static void zfcp_fsf_exchange_config_data_handler(struct zfcp_fsf_req *req)
 
 /*
  * Mapping of FC Endpoint Security flag masks to mnemonics
+ *
+ * NOTE: Update macro ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH when making any
+ *       changes.
  */
 static const struct {
 	u32	mask;
@@ -676,6 +679,9 @@ static const struct {
 	  FSF_FC_SECURITY_ENC_ERAS,	"Encryption" },
 };
 
+/* maximum strlen(zfcp_fsf_fc_security_mnemonics[...].name) + 1 */
+#define ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH 15
+
 /**
  * zfcp_fsf_scnprint_fc_security() - translate FC Endpoint Security flags into
  *                                   mnemonics and place in a buffer
@@ -700,7 +706,8 @@ static const struct {
  * undefined in zfcp_fsf_fc_security_mnemonics, its value in hexadecimal
  * representation is placed into the buffer. If more than one FC Endpoint
  * Security flag was specified, their value in hexadecimal representation is
- * placed into the buffer.
+ * placed into the buffer. The macro ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH
+ * can be used to define a buffer that is large enough to hold one mnemonic.
  *
  * Return: The number of characters written into buf not including the trailing
  *         '\0'. If size is == 0 the function returns 0.
@@ -1572,6 +1579,50 @@ int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 	return retval;
 }
 
+static void zfcp_fsf_log_port_fc_security(struct zfcp_port *port)
+{
+	char mnemonic_old[ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH];
+	char mnemonic_new[ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH];
+
+	if (port->connection_info == port->connection_info_old) {
+		/* no change, no log */
+		return;
+	}
+
+	zfcp_fsf_scnprint_fc_security(mnemonic_old, sizeof(mnemonic_old),
+				      port->connection_info_old,
+				      ZFCP_FSF_PRINT_FMT_SINGLEITEM);
+	zfcp_fsf_scnprint_fc_security(mnemonic_new, sizeof(mnemonic_new),
+				      port->connection_info,
+				      ZFCP_FSF_PRINT_FMT_SINGLEITEM);
+
+	if (strncmp(mnemonic_old, mnemonic_new,
+		    ZFCP_FSF_MAX_FC_SECURITY_MNEMONIC_LENGTH) == 0) {
+		/* no change in string representation, no log */
+		goto out;
+	}
+
+	if (port->connection_info_old == 0) {
+		/* activation */
+		dev_info(&port->adapter->ccw_device->dev,
+			 "FC Endpoint Security of connection to remote port 0x%16llx enabled: %s\n",
+			 port->wwpn, mnemonic_new);
+	} else if (port->connection_info == 0) {
+		/* deactivation */
+		dev_warn(&port->adapter->ccw_device->dev,
+			 "FC Endpoint Security of connection to remote port 0x%16llx disabled: was %s\n",
+			 port->wwpn, mnemonic_old);
+	} else {
+		/* change */
+		dev_warn(&port->adapter->ccw_device->dev,
+			 "FC Endpoint Security of connection to remote port 0x%16llx changed: from %s to %s\n",
+			 port->wwpn, mnemonic_old, mnemonic_new);
+	}
+
+out:
+	port->connection_info_old = port->connection_info;
+}
+
 static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 {
 	struct zfcp_adapter *adapter = req->adapter;
@@ -1612,6 +1663,7 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 			port->connection_info = bottom->connection_info;
 		else
 			port->connection_info = 0;
+		zfcp_fsf_log_port_fc_security(port);
 		atomic_or(ZFCP_STATUS_COMMON_OPEN |
 				ZFCP_STATUS_PORT_PHYS_OPEN, &port->status);
 		atomic_andnot(ZFCP_STATUS_COMMON_ACCESS_BOXED,
-- 
2.17.1
