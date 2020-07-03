Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:50132 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726361AbgGCNVF (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:05 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 6/7] zfcp: replace open-coded list move
Date: Fri,  3 Jul 2020 15:20:02 +0200
Message-Id: <cacb179f49ece50fd4dce119c61252d632cdc1d4.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Instead of manually moving each element of the unit and port lists into
our temporary on-stack lists, splice them over in one go.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_ccw.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_ccw.c b/drivers/s390/scsi/zfcp_ccw.c
index 49eda141ea43..d9fd0a41da64 100644
--- a/drivers/s390/scsi/zfcp_ccw.c
+++ b/drivers/s390/scsi/zfcp_ccw.c
@@ -124,13 +124,12 @@ static void zfcp_ccw_remove(struct ccw_device *cdev)
 		return;
 
 	write_lock_irq(&adapter->port_list_lock);
-	list_for_each_entry_safe(port, p, &adapter->port_list, list) {
+	list_for_each_entry(port, &adapter->port_list, list) {
 		write_lock(&port->unit_list_lock);
-		list_for_each_entry_safe(unit, u, &port->unit_list, list)
-			list_move(&unit->list, &unit_remove_lh);
+		list_splice_init(&port->unit_list, &unit_remove_lh);
 		write_unlock(&port->unit_list_lock);
-		list_move(&port->list, &port_remove_lh);
 	}
+	list_splice_init(&adapter->port_list, &port_remove_lh);
 	write_unlock_irq(&adapter->port_list_lock);
 	zfcp_ccw_adapter_put(adapter); /* put from zfcp_ccw_adapter_by_cdev */
 
-- 
2.26.2
