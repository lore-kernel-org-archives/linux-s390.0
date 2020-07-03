Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:32868 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726039AbgGCNVE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:04 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 2/7] zfcp: fix an outdated comment for zfcp_qdio_send()
Date: Fri,  3 Jul 2020 15:19:58 +0200
Message-Id: <6717c26fc986bff8776d110e27c199b523684c63.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

zfcp no longer uses the qdio PCI flag, update the comment.

Fixes: 21ddaa53f92d ("[SCSI] zfcp: Remove PCI flag")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Fedor Loshakov <loshakov@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_qdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_qdio.c b/drivers/s390/scsi/zfcp_qdio.c
index 3a7f3374d10a..d3d110a04884 100644
--- a/drivers/s390/scsi/zfcp_qdio.c
+++ b/drivers/s390/scsi/zfcp_qdio.c
@@ -246,7 +246,7 @@ int zfcp_qdio_sbal_get(struct zfcp_qdio *qdio)
 }
 
 /**
- * zfcp_qdio_send - set PCI flag in first SBALE and send req to QDIO
+ * zfcp_qdio_send - send req to QDIO
  * @qdio: pointer to struct zfcp_qdio
  * @q_req: pointer to struct zfcp_qdio_req
  * Returns: 0 on success, error otherwise
-- 
2.26.2
