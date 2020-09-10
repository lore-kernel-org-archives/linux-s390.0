Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:5760 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726760AbgIJTta (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Thu, 10 Sep 2020 15:49:30 -0400
From: Benjamin Block <bblock@linux.ibm.com>
Subject: [PATCH 1/2] zfcp: use list_first_entry_or_null() in zfcp_erp_thread()
Date: Thu, 10 Sep 2020 21:49:15 +0200
Message-Id: <ed669555c73aab95b29444c10066f492c0c43391.1599765652.git.bblock@linux.ibm.com>
In-Reply-To: <cover.1599765652.git.bblock@linux.ibm.com>
References: <cover.1599765652.git.bblock@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: "James E.J. Bottomley" <jejb@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Julian Wiedmann <jwi@linux.ibm.com>, Benjamin Block <bblock@linux.ibm.com>, Steffen Maier <maier@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Fedor Loshakov <loshakov@linux.ibm.com>, linux-scsi@vger.kernel.org, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

Use the right helper to avoid poking around in the list's internals.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Reviewed-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
Signed-off-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 59e662df5774..78d52a4c55f5 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -1607,7 +1607,6 @@ static enum zfcp_erp_act_result zfcp_erp_strategy(
 static int zfcp_erp_thread(void *data)
 {
 	struct zfcp_adapter *adapter = (struct zfcp_adapter *) data;
-	struct list_head *next;
 	struct zfcp_erp_action *act;
 	unsigned long flags;
 
@@ -1620,12 +1619,11 @@ static int zfcp_erp_thread(void *data)
 			break;
 
 		write_lock_irqsave(&adapter->erp_lock, flags);
-		next = adapter->erp_ready_head.next;
+		act = list_first_entry_or_null(&adapter->erp_ready_head,
+					       struct zfcp_erp_action, list);
 		write_unlock_irqrestore(&adapter->erp_lock, flags);
 
-		if (next != &adapter->erp_ready_head) {
-			act = list_entry(next, struct zfcp_erp_action, list);
-
+		if (act) {
 			/* there is more to come after dismission, no notify */
 			if (zfcp_erp_strategy(act) != ZFCP_ERP_DISMISSED)
 				zfcp_erp_wakeup(adapter);
-- 
2.26.2
