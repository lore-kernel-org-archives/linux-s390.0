Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:49352 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727834AbgEHRXr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:47 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 5/8] zfcp: move p-t-p port allocation to after xport data
Date: Fri,  8 May 2020 19:23:32 +0200
Message-Id: <73e5d4ac21e2b37bf0c3ca8e530bc5a5c6e74f8f.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

When doing the very first adapter recovery - initialization - for a FCP
device in a point-to-point topology we also allocate the port object
corresponding to the attached remote port, and trigger a port recovery
for it that will run after the adapter recovery finished.

Right now this happens right after we finished with the exchange config
data command, and uses the fibre channel host object corresponding to
the FCP device to determine whether a point-to-point topology is used.

When moving the scsi host object allocation and registration - and thus
also the fibre channel host object allocation - to after the first
exchange config and exchange port data, this use of the fc_host object
is not possible anymore at that point in the work flow.

But the allocation and recovery trigger doesn't have notable
side-effects on the following exchange port data processing, so we can
move those to after xport data, and thus also to after the scsi host
object allocation, once we move it. Then the fc_host object can be used
again, like it is now.

For any further adapter recoveries this doesn't change anything, because
at that point the port object already exists and recovery is triggered
elsewhere for existing port objects.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 3d0bc000f500..356f51d2bbee 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -4,7 +4,7 @@
  *
  * Error Recovery Procedures (ERP).
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2020
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -768,10 +768,14 @@ static enum zfcp_erp_act_result zfcp_erp_adapter_strat_fsf_xconf(
 	if (!(atomic_read(&adapter->status) & ZFCP_STATUS_ADAPTER_XCONFIG_OK))
 		return ZFCP_ERP_FAILED;
 
+	return ZFCP_ERP_SUCCEEDED;
+}
+
+static void
+zfcp_erp_adapter_strategy_open_ptp_port(struct zfcp_adapter *const adapter)
+{
 	if (fc_host_port_type(adapter->scsi_host) == FC_PORTTYPE_PTP)
 		zfcp_erp_enqueue_ptp_port(adapter);
-
-	return ZFCP_ERP_SUCCEEDED;
 }
 
 static enum zfcp_erp_act_result zfcp_erp_adapter_strategy_open_fsf_xport(
@@ -809,6 +813,8 @@ static enum zfcp_erp_act_result zfcp_erp_adapter_strategy_open_fsf(
 	if (zfcp_erp_adapter_strategy_open_fsf_xport(act) == ZFCP_ERP_FAILED)
 		return ZFCP_ERP_FAILED;
 
+	zfcp_erp_adapter_strategy_open_ptp_port(act->adapter);
+
 	if (mempool_resize(act->adapter->pool.sr_data,
 			   act->adapter->stat_read_buf_num))
 		return ZFCP_ERP_FAILED;
-- 
2.17.1
