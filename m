Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:30138 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727824AbgEHRXr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 May 2020 13:23:47 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/8] zfcp: move shost modification after QDIO (re-)open into fenced function
Date: Fri,  8 May 2020 19:23:28 +0200
Message-Id: <a214ebf508f71e3690113e3e90edab1cea0e24e3.1588956679.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1588956679.git.bblock@linux.ibm.com>
References: <cover.1588956679.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

When establishing and activating the QDIO queue pair for a FCP device
for the first time, or after an adapter recovery, we publish some of its
characteristics to the scsi host object representing that FCP device.

When moving the scsi host object allocation and registration to after
the first exchange config and exchange port data, this is not possible
for the former case - QDIO open for the first time - because that
happens before exchange config and exchange port data.

Move the scsi host object update into a fenced function that checks
whether the object already exists or not. This way we can repeat that
step later, once we are past the allocation.

Once the first recovery succeeds we don't release the scsi host object
anymore, so further recoveries do work as before.

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_ext.h  |  2 ++
 drivers/s390/scsi/zfcp_qdio.c | 19 ++++++++++++++-----
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 88294ca0e2ea..d67f31b9b859 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -153,6 +153,8 @@ extern int zfcp_qdio_sbal_get(struct zfcp_qdio *);
 extern int zfcp_qdio_send(struct zfcp_qdio *, struct zfcp_qdio_req *);
 extern int zfcp_qdio_sbals_from_sg(struct zfcp_qdio *, struct zfcp_qdio_req *,
 				   struct scatterlist *);
+extern void zfcp_qdio_shost_update(struct zfcp_adapter *const adapter,
+				   const struct zfcp_qdio *const qdio);
 extern int zfcp_qdio_open(struct zfcp_qdio *);
 extern void zfcp_qdio_close(struct zfcp_qdio *);
 extern void zfcp_qdio_siosl(struct zfcp_adapter *);
diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 26702b56a7ab..3a7f3374d10a 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -4,7 +4,7 @@
  *
  * Setup and helper functions to access QDIO.
  *
- * Copyright IBM Corp. 2002, 2017
+ * Copyright IBM Corp. 2002, 2020
  */
 
 #define KMSG_COMPONENT "zfcp"
@@ -342,6 +342,18 @@ void zfcp_qdio_close(struct zfcp_qdio *qdio)
 	atomic_set(&qdio->req_q_free, 0);
 }
 
+void zfcp_qdio_shost_update(struct zfcp_adapter *const adapter,
+			    const struct zfcp_qdio *const qdio)
+{
+	struct Scsi_Host *const shost = adapter->scsi_host;
+
+	if (shost == NULL)
+		return;
+
+	shost->sg_tablesize = qdio->max_sbale_per_req;
+	shost->max_sectors = qdio->max_sbale_per_req * 8;
+}
+
 /**
  * zfcp_qdio_open - prepare and initialize response queue
  * @qdio: pointer to struct zfcp_qdio
@@ -420,10 +432,7 @@ int zfcp_qdio_open(struct zfcp_qdio *qdio)
 	atomic_set(&qdio->req_q_free, QDIO_MAX_BUFFERS_PER_Q);
 	atomic_or(ZFCP_STATUS_ADAPTER_QDIOUP, &qdio->adapter->status);
 
-	if (adapter->scsi_host) {
-		adapter->scsi_host->sg_tablesize = qdio->max_sbale_per_req;
-		adapter->scsi_host->max_sectors = qdio->max_sbale_per_req * 8;
-	}
+	zfcp_qdio_shost_update(adapter, qdio);
 
 	return 0;
 
-- 
2.17.1
