Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:8398 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725880AbgJ1VdJ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 28 Oct 2020 17:33:09 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 2/5] zfcp: remove orphaned function declarations
Date: Wed, 28 Oct 2020 19:30:49 +0100
Message-Id: <6854ae03c5c65805f746774eeb0f2869fcd6c397.1603908167.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1603908167.git.bblock@linux.ibm.com>
References: <cover.1603908167.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Benjamin Block <bblock@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Vasily Gorbik <gor@linux.ibm.com>

drivers/s390/scsi/zfcp_ext.h: zfcp_sg_free_table - only declaration left
after commit 58f3ead54752 ("scsi: zfcp: move SG table helper from aux
to fc and make them static")

drivers/s390/scsi/zfcp_ext.h: zfcp_sg_setup_table - only declaration
left after commit 58f3ead54752 ("scsi: zfcp: move SG table helper from
aux to fc and make them static")

Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_ext.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index 3ef5d74331c3..8b50f580584c 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -20,8 +20,6 @@ extern struct zfcp_port *zfcp_get_port_by_wwpn(struct zfcp_adapter *, u64);
 extern struct zfcp_adapter *zfcp_adapter_enqueue(struct ccw_device *);
 extern struct zfcp_port *zfcp_port_enqueue(struct zfcp_adapter *, u64, u32,
 					   u32);
-extern void zfcp_sg_free_table(struct scatterlist *, int);
-extern int zfcp_sg_setup_table(struct scatterlist *, int);
 extern void zfcp_adapter_release(struct kref *);
 extern void zfcp_adapter_unregister(struct zfcp_adapter *);
 
-- 
2.26.2
