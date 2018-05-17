From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:14:59 +0000
Subject: [PATCH 17/25] zfcp: remove unused ERP enum values
Message-Id: <20180517171507.18237-18-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

All constant defines were introduced with v2.6.0 history commit
ea127f975424 ("[PATCH] s390 (7/7): zfcp host adapter.") and refactored into
enums with commit 287ac01acf22 ("[SCSI] zfcp: Cleanup code in zfcp_erp.c").

ZFCP_STATUS_ERP_DISMISSING and ZFCP_ERP_STEP_FSF_XCONFIG were never used.

v2.6.27 commit 287ac01acf22 ("[SCSI] zfcp: Cleanup code in zfcp_erp.c")
removed the use of ZFCP_ERP_ACTION_READY on refactoring
zfcp_erp_action_exists() to now only check adapter->erp_running_head
but no longer adapter->erp_ready_head. The same commit could have
changed the function return type from int to "enum zfcp_erp_act_state".
ZFCP_ERP_ACTION_READY was never used outside of zfcp_erp_action_exists().

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 9be629607dc0..b5ca484d5d5f 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -19,7 +19,6 @@
 enum zfcp_erp_act_flags {
 	ZFCP_STATUS_ERP_TIMEDOUT	= 0x10000000,
 	ZFCP_STATUS_ERP_CLOSE_ONLY	= 0x01000000,
-	ZFCP_STATUS_ERP_DISMISSING	= 0x00100000,
 	ZFCP_STATUS_ERP_DISMISSED	= 0x00200000,
 	ZFCP_STATUS_ERP_LOWMEM		= 0x00400000,
 	ZFCP_STATUS_ERP_NO_REF		= 0x00800000,
@@ -27,7 +26,6 @@ enum zfcp_erp_act_flags {
 
 enum zfcp_erp_steps {
 	ZFCP_ERP_STEP_UNINITIALIZED	= 0x0000,
-	ZFCP_ERP_STEP_FSF_XCONFIG	= 0x0001,
 	ZFCP_ERP_STEP_PHYS_PORT_CLOSING	= 0x0010,
 	ZFCP_ERP_STEP_PORT_CLOSING	= 0x0100,
 	ZFCP_ERP_STEP_PORT_OPENING	= 0x0800,
@@ -61,7 +59,6 @@ enum zfcp_erp_act_type {
 
 enum zfcp_erp_act_state {
 	ZFCP_ERP_ACTION_RUNNING = 1,
-	ZFCP_ERP_ACTION_READY   = 2,
 };
 
 enum zfcp_erp_act_result {
-- 
2.16.3
