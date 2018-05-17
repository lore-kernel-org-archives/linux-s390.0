From: Steffen Maier <maier@linux.ibm.com>
Date: Thu, 17 May 2018 17:15:01 +0000
Subject: [PATCH 19/25] zfcp: remove unused return values of ERP trigger functions
Message-Id: <20180517171507.18237-20-maier@linux.ibm.com>
To: linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Since v2.6.27 commit 553448f6c483 ("[SCSI] zfcp: Message cleanup"),
none of the callers has been interested any more.
Values were not returned consistently in all ERP trigger functions.

Signed-off-by: Steffen Maier <maier@linux.ibm.com>
Reviewed-by: Benjamin Block <bblock@linux.ibm.com>
---
 drivers/s390/scsi/zfcp_erp.c | 34 +++++++++++++---------------------
 drivers/s390/scsi/zfcp_ext.h |  2 +-
 2 files changed, 14 insertions(+), 22 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 245621769c26..2968d2f57788 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -294,12 +294,12 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(int need, u32 act_status,
 	return erp_action;
 }
 
-static int zfcp_erp_action_enqueue(int want, struct zfcp_adapter *adapter,
-				   struct zfcp_port *port,
-				   struct scsi_device *sdev,
-				   char *id, u32 act_status)
+static void zfcp_erp_action_enqueue(int want, struct zfcp_adapter *adapter,
+				    struct zfcp_port *port,
+				    struct scsi_device *sdev,
+				    char *id, u32 act_status)
 {
-	int retval = 1, need;
+	int need;
 	struct zfcp_erp_action *act;
 
 	need = zfcp_erp_handle_failed(want, adapter, port, sdev);
@@ -310,7 +310,6 @@ static int zfcp_erp_action_enqueue(int want, struct zfcp_adapter *adapter,
 
 	if (!adapter->erp_thread) {
 		need = ZFCP_ERP_ACTION_NONE; /* marker for trace */
-		retval = -EIO;
 		goto out;
 	}
 
@@ -327,10 +326,8 @@ static int zfcp_erp_action_enqueue(int want, struct zfcp_adapter *adapter,
 	++adapter->erp_total_count;
 	list_add_tail(&act->list, &adapter->erp_ready_head);
 	wake_up(&adapter->erp_ready_wq);
-	retval = 0;
  out:
 	zfcp_dbf_rec_trig(id, adapter, port, sdev, want, need);
-	return retval;
 }
 
 void zfcp_erp_port_forced_no_port_dbf(char *id, struct zfcp_adapter *adapter,
@@ -353,14 +350,14 @@ void zfcp_erp_port_forced_no_port_dbf(char *id, struct zfcp_adapter *adapter,
 	write_unlock_irqrestore(&adapter->erp_lock, flags);
 }
 
-static int _zfcp_erp_adapter_reopen(struct zfcp_adapter *adapter,
+static void _zfcp_erp_adapter_reopen(struct zfcp_adapter *adapter,
 				    int clear_mask, char *id)
 {
 	zfcp_erp_adapter_block(adapter, clear_mask);
 	zfcp_scsi_schedule_rports_block(adapter);
 
-	return zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER,
-				       adapter, NULL, NULL, id, 0);
+	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_ADAPTER,
+				adapter, NULL, NULL, id, 0);
 }
 
 /**
@@ -439,13 +436,13 @@ void zfcp_erp_port_forced_reopen(struct zfcp_port *port, int clear, char *id)
 	write_unlock_irqrestore(&adapter->erp_lock, flags);
 }
 
-static int _zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id)
+static void _zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id)
 {
 	zfcp_erp_port_block(port, clear);
 	zfcp_scsi_schedule_rport_block(port);
 
-	return zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_PORT,
-				       port->adapter, port, NULL, id, 0);
+	zfcp_erp_action_enqueue(ZFCP_ERP_ACTION_REOPEN_PORT,
+				port->adapter, port, NULL, id, 0);
 }
 
 /**
@@ -453,20 +450,15 @@ static int _zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id)
  * @port: port to recover
  * @clear_mask: flags in port status to be cleared
  * @id: Id for debug trace event.
- *
- * Returns 0 if recovery has been triggered, < 0 if not.
  */
-int zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id)
+void zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id)
 {
-	int retval;
 	unsigned long flags;
 	struct zfcp_adapter *adapter = port->adapter;
 
 	write_lock_irqsave(&adapter->erp_lock, flags);
-	retval = _zfcp_erp_port_reopen(port, clear, id);
+	_zfcp_erp_port_reopen(port, clear, id);
 	write_unlock_irqrestore(&adapter->erp_lock, flags);
-
-	return retval;
 }
 
 static void zfcp_erp_lun_block(struct scsi_device *sdev, int clear_mask)
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index e317c4b513c9..ad7c28ffd49f 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -63,7 +63,7 @@ extern void zfcp_erp_adapter_reopen(struct zfcp_adapter *, int, char *);
 extern void zfcp_erp_adapter_shutdown(struct zfcp_adapter *, int, char *);
 extern void zfcp_erp_set_port_status(struct zfcp_port *, u32);
 extern void zfcp_erp_clear_port_status(struct zfcp_port *, u32);
-extern int  zfcp_erp_port_reopen(struct zfcp_port *, int, char *);
+extern void zfcp_erp_port_reopen(struct zfcp_port *port, int clear, char *id);
 extern void zfcp_erp_port_shutdown(struct zfcp_port *, int, char *);
 extern void zfcp_erp_port_forced_reopen(struct zfcp_port *, int, char *);
 extern void zfcp_erp_set_lun_status(struct scsi_device *, u32);
-- 
2.16.3
