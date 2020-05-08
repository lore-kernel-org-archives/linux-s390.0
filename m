Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:57222 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727893AbgEHRXr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:47 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 4/8] zfcp: fence fc_host updates during link-down handling
Date: Fri,  8 May 2020 19:23:31 +0200
Message-Id: <f841f2cda61dcd7b8549910c44e1831927459edf.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

When receiving a notification that a FCP device lost its local link we
usually update the fibre channel host object which represents that FCP
device to reflect that.

This notification/information can also surface when the FCP device is
running through adapter recovery (exchange config and exchange port data
return incomplete).

When moving the scsi host object allocation and registration  - and thus
also the fibre channel host object allocation - to after the first
exchange config and exchange port data, and this happens during the very
first adapter recovery, these updates can not be done until after the
scsi host object is allocated.

Reorder the fc_host updates in zfcp_fsf_fc_host_link_down() so that they
only happen after a check of whether the scsi host object is already
allocated or not.

During the first adapter recovery this will cause the skip of these
updates if a link-down condition is detected, but we can repeat them
after we allocated the scsi host object, if necessary.

For any further link-down handling the only changes in the work flow are
the slightly reordered assignments in zfcp_fsf_fc_host_link_down().

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index bfb567a1d7bf..8c4b690e329e 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -124,17 +124,21 @@ static void zfcp_fsf_fc_host_link_down(struct zfcp_adapter *adapter)
 {
 	struct Scsi_Host *shost = adapter->scsi_host;
 
+	adapter->hydra_version = 0;
+	adapter->peer_wwpn = 0;
+	adapter->peer_wwnn = 0;
+	adapter->peer_d_id = 0;
+
+	/* if there is no shost yet, we have nothing to zero-out */
+	if (shost == NULL)
+		return;
+
 	fc_host_port_id(shost) = 0;
 	fc_host_fabric_name(shost) = 0;
 	fc_host_speed(shost) = FC_PORTSPEED_UNKNOWN;
 	fc_host_port_type(shost) = FC_PORTTYPE_UNKNOWN;
-	adapter->hydra_version = 0;
 	snprintf(fc_host_model(shost), FC_SYMBOLIC_NAME_SIZE, "0x%04x", 0);
 	memset(fc_host_active_fc4s(shost), 0, FC_FC4_LIST_SIZE);
-
-	adapter->peer_wwpn = 0;
-	adapter->peer_wwnn = 0;
-	adapter->peer_d_id = 0;
 }
 
 static void zfcp_fsf_link_down_info_eval(struct zfcp_fsf_req *req,
-- 
2.17.1
