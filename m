Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1888 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726437AbgCLRvW (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 12 Mar 2020 13:51:22 -0400
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
        by mx0b-001b2d01.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 02CHnpWA030984
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:51:20 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0b-001b2d01.pphosted.com with ESMTP id 2yqss8860u-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-s390@vger.kernel.org>; Thu, 12 Mar 2020 13:51:20 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-s390@vger.kernel.org> from <maier@linux.ibm.com>;
        Thu, 12 Mar 2020 17:45:26 -0000
From: Steffen Maier <maier@linux.ibm.com>
Subject: [PATCH 05/10] zfcp: auto variables for dereferenced structs in open port handler
Date: Thu, 12 Mar 2020 18:45:00 +0100
In-Reply-To: <20200312174505.51294-1-maier@linux.ibm.com>
References: <20200312174505.51294-1-maier@linux.ibm.com>
Message-Id: <20200312174505.51294-6-maier@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E . J . Bottomley" <jejb@linux.ibm.com>, "Martin K . Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Jens Remus <jremus@linux.ibm.com>

From: Jens Remus <jremus@linux.ibm.com>

Introduce automatic variables for adapter and QTCB bottom in
zfcp_fsf_open_port_handler(). This facilitates subsequent changes
to meet the 80 character per line limit.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Steffen Maier <maier@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_fsf.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 1fa94277d287..c3aa0546364a 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -4,7 +4,7 @@
  *
  * Implementation of FSF commands.
  *
- * Copyright IBM Corp. 2002, 2018
+ * Copyright IBM Corp. 2002, 2020
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -1499,8 +1499,10 @@ int zfcp_fsf_exchange_port_data_sync(struct zfcp_qdio *qdio,
 
 static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 {
+	struct zfcp_adapter *adapter = req->adapter;
 	struct zfcp_port *port = req->data;
 	struct fsf_qtcb_header *header = &req->qtcb->header;
+	struct fsf_qtcb_bottom_support *bottom = &req->qtcb->bottom.support;
 	struct fc_els_flogi *plogi;
 
 	if (req->status & ZFCP_STATUS_FSFREQ_ERROR)
@@ -1510,7 +1512,7 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 	case FSF_PORT_ALREADY_OPEN:
 		break;
 	case FSF_MAXIMUM_NUMBER_OF_PORTS_EXCEEDED:
-		dev_warn(&req->adapter->ccw_device->dev,
+		dev_warn(&adapter->ccw_device->dev,
 			 "Not enough FCP adapter resources to open "
 			 "remote port 0x%016Lx\n",
 			 (unsigned long long)port->wwpn);
@@ -1550,10 +1552,9 @@ static void zfcp_fsf_open_port_handler(struct zfcp_fsf_req *req)
 		 * another GID_PN straight after a port has been opened.
 		 * Alternately, an ADISC/PDISC ELS should suffice, as well.
 		 */
-		plogi = (struct fc_els_flogi *) req->qtcb->bottom.support.els;
-		if (req->qtcb->bottom.support.els1_length >=
-		    FSF_PLOGI_MIN_LEN)
-				zfcp_fc_plogi_evaluate(port, plogi);
+		plogi = (struct fc_els_flogi *) bottom->els;
+		if (bottom->els1_length >= FSF_PLOGI_MIN_LEN)
+			zfcp_fc_plogi_evaluate(port, plogi);
 		break;
 	case FSF_UNKNOWN_OP_SUBTYPE:
 		req->status |= ZFCP_STATUS_FSFREQ_ERROR;
-- 
2.17.1
