Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:36372 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726363AbgGCNVE (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 3 Jul 2020 09:21:04 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 5/7] zfcp: clean up zfcp_erp_action_ready()
Date: Fri,  3 Jul 2020 15:20:01 +0200
Message-Id: <d1bb04322f240dee32f4c4a551bc93bc736f4b01.1593780621.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1593780621.git.bblock@linux.ibm.com>
References: <cover.1593780621.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

We already maintain a pointer to act->adapter. Use it consistently to
avoid any confusion about whose ->erp_ready_head and ->erp_ready_wq
we are accessing.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 79f6e8fb03ca..59e662df5774 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -68,7 +68,7 @@ static void zfcp_erp_action_ready(struct zfcp_erp_action *act)
 {
 	struct zfcp_adapter *adapter = act->adapter;
 
-	list_move(&act->list, &act->adapter->erp_ready_head);
+	list_move(&act->list, &adapter->erp_ready_head);
 	zfcp_dbf_rec_run("erardy1", act);
 	wake_up(&adapter->erp_ready_wq);
 	zfcp_dbf_rec_run("erardy2", act);
-- 
2.26.2
