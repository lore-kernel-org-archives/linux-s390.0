From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:00 +0000
Subject: [PATCH 18/25] zfcp: zfcp_erp_action_exists() does only check for running
Message-Id: <20180517171507.18237-19-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Simplify its signature to return boolean and rename it to
zfcp_erp_action_is_running() to indicate its actual unmodified semantics.
It has always been used like this since v2.6.0 history commit ea127f975424
("[PATCH] s390 (7/7): zfcp host adapter.").

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 14 +++++---------
 1 file changed, 5 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index b5ca484d5d5f..245621769c26 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -57,10 +57,6 @@ enum zfcp_erp_act_type {
 	ZFCP_ERP_ACTION_FAILED		   = 0xe0,
 };
 
-enum zfcp_erp_act_state {
-	ZFCP_ERP_ACTION_RUNNING = 1,
-};
-
 enum zfcp_erp_act_result {
 	ZFCP_ERP_SUCCEEDED = 0,
 	ZFCP_ERP_FAILED    = 1,
@@ -76,14 +72,14 @@ static void zfcp_erp_adapter_block(struct zfcp_adapter *adapter, int mask)
 				       ZFCP_STATUS_COMMON_UNBLOCKED | mask);
 }
 
-static int zfcp_erp_action_exists(struct zfcp_erp_action *act)
+static bool zfcp_erp_action_is_running(struct zfcp_erp_action *act)
 {
 	struct zfcp_erp_action *curr_act;
 
 	list_for_each_entry(curr_act, &act->adapter->erp_running_head, list)
 		if (act == curr_act)
-			return ZFCP_ERP_ACTION_RUNNING;
-	return 0;
+			return true;
+	return false;
 }
 
 static void zfcp_erp_action_ready(struct zfcp_erp_action *act)
@@ -99,7 +95,7 @@ static void zfcp_erp_action_ready(struct zfcp_erp_action *act)
 static void zfcp_erp_action_dismiss(struct zfcp_erp_action *act)
 {
 	act->status |= ZFCP_STATUS_ERP_DISMISSED;
-	if (zfcp_erp_action_exists(act) == ZFCP_ERP_ACTION_RUNNING)
+	if (zfcp_erp_action_is_running(act))
 		zfcp_erp_action_ready(act);
 }
 
@@ -622,7 +618,7 @@ void zfcp_erp_notify(struct zfcp_erp_action *erp_action, unsigned long set_mask)
 	unsigned long flags;
 
 	write_lock_irqsave(&adapter->erp_lock, flags);
-	if (zfcp_erp_action_exists(erp_action) == ZFCP_ERP_ACTION_RUNNING) {
+	if (zfcp_erp_action_is_running(erp_action)) {
 		erp_action->status |= set_mask;
 		zfcp_erp_action_ready(erp_action);
 	}
-- 
2.16.3
