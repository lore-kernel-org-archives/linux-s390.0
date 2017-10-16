Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Mon, 16 Oct 2017 16:44:34 -0700
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] s390/scsi: Convert timers to use timer_setup()
Message-ID: <20171016234434.GA102128@beast>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Steffen Maier <maier@linux.vnet.ibm.com>, Benjamin Block <bblock@linux.vnet.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

In preparation for unconditionally passing the struct timer_list pointer to
all timer callbacks, switch to using the new timer_setup() and from_timer()
to pass the timer pointer explicitly.

Cc: Steffen Maier <maier@linux.vnet.ibm.com>
Cc: Benjamin Block <bblock@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/s390/scsi/zfcp_erp.c | 16 ++++++++++------
 drivers/s390/scsi/zfcp_ext.h |  2 +-
 drivers/s390/scsi/zfcp_fsf.c | 13 ++++++-------
 3 files changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/s390/scsi/zfcp_erp.c b/drivers/s390/scsi/zfcp_erp.c
index 37408f5f81ce..c5ed119aa734 100644
--- a/drivers/s390/scsi/zfcp_erp.c
+++ b/drivers/s390/scsi/zfcp_erp.c
@@ -55,6 +55,8 @@ enum zfcp_erp_act_result {
 	ZFCP_ERP_NOMEM     = 5,
 };
 
+static void zfcp_erp_memwait_handler(struct timer_list *t);
+
 static void zfcp_erp_adapter_block(struct zfcp_adapter *adapter, int mask)
 {
 	zfcp_erp_clear_adapter_status(adapter,
@@ -232,6 +234,7 @@ static struct zfcp_erp_action *zfcp_erp_setup_act(int need, u32 act_status,
 	erp_action->adapter = adapter;
 	erp_action->action = need;
 	erp_action->status = act_status;
+	timer_setup(&erp_action->timer, zfcp_erp_memwait_handler, 0);
 
 	return erp_action;
 }
@@ -559,21 +562,22 @@ void zfcp_erp_notify(struct zfcp_erp_action *erp_action, unsigned long set_mask)
  * zfcp_erp_timeout_handler - Trigger ERP action from timed out ERP request
  * @data: ERP action (from timer data)
  */
-void zfcp_erp_timeout_handler(unsigned long data)
+void zfcp_erp_timeout_handler(struct timer_list *t)
 {
-	struct zfcp_erp_action *act = (struct zfcp_erp_action *) data;
+	struct zfcp_fsf_req *fsf_req = from_timer(fsf_req, t, timer);
+	struct zfcp_erp_action *act = fsf_req->erp_action;
 	zfcp_erp_notify(act, ZFCP_STATUS_ERP_TIMEDOUT);
 }
 
-static void zfcp_erp_memwait_handler(unsigned long data)
+static void zfcp_erp_memwait_handler(struct timer_list *t)
 {
-	zfcp_erp_notify((struct zfcp_erp_action *)data, 0);
+	struct zfcp_erp_action *act = from_timer(act, t, timer);
+
+	zfcp_erp_notify(act, 0);
 }
 
 static void zfcp_erp_strategy_memwait(struct zfcp_erp_action *erp_action)
 {
-	setup_timer(&erp_action->timer, zfcp_erp_memwait_handler,
-		    (unsigned long) erp_action);
 	erp_action->timer.expires = jiffies + HZ;
 	add_timer(&erp_action->timer);
 }
diff --git a/drivers/s390/scsi/zfcp_ext.h b/drivers/s390/scsi/zfcp_ext.h
index a9e968717dd9..17ba7ef3988e 100644
--- a/drivers/s390/scsi/zfcp_ext.h
+++ b/drivers/s390/scsi/zfcp_ext.h
@@ -68,7 +68,7 @@ extern int  zfcp_erp_thread_setup(struct zfcp_adapter *);
 extern void zfcp_erp_thread_kill(struct zfcp_adapter *);
 extern void zfcp_erp_wait(struct zfcp_adapter *);
 extern void zfcp_erp_notify(struct zfcp_erp_action *, unsigned long);
-extern void zfcp_erp_timeout_handler(unsigned long);
+extern void zfcp_erp_timeout_handler(struct timer_list *);
 
 /* zfcp_fc.c */
 extern struct kmem_cache *zfcp_fc_req_cache;
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index 69d1dc3ec79d..76e3dbe80765 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -20,9 +20,10 @@
 
 struct kmem_cache *zfcp_fsf_qtcb_cache;
 
-static void zfcp_fsf_request_timeout_handler(unsigned long data)
+static void zfcp_fsf_request_timeout_handler(struct timer_list *t)
 {
-	struct zfcp_adapter *adapter = (struct zfcp_adapter *) data;
+	struct zfcp_fsf_req *fsf_req = from_timer(fsf_req, t, timer);
+	struct zfcp_adapter *adapter = fsf_req->adapter;
 	zfcp_qdio_siosl(adapter);
 	zfcp_erp_adapter_reopen(adapter, ZFCP_STATUS_COMMON_ERP_FAILED,
 				"fsrth_1");
@@ -31,8 +32,7 @@ static void zfcp_fsf_request_timeout_handler(unsigned long data)
 static void zfcp_fsf_start_timer(struct zfcp_fsf_req *fsf_req,
 				 unsigned long timeout)
 {
-	fsf_req->timer.function = zfcp_fsf_request_timeout_handler;
-	fsf_req->timer.data = (unsigned long) fsf_req->adapter;
+	fsf_req->timer.function = (TIMER_FUNC_TYPE)zfcp_fsf_request_timeout_handler;
 	fsf_req->timer.expires = jiffies + timeout;
 	add_timer(&fsf_req->timer);
 }
@@ -40,8 +40,7 @@ static void zfcp_fsf_start_timer(struct zfcp_fsf_req *fsf_req,
 static void zfcp_fsf_start_erp_timer(struct zfcp_fsf_req *fsf_req)
 {
 	BUG_ON(!fsf_req->erp_action);
-	fsf_req->timer.function = zfcp_erp_timeout_handler;
-	fsf_req->timer.data = (unsigned long) fsf_req->erp_action;
+	fsf_req->timer.function = (TIMER_FUNC_TYPE)zfcp_erp_timeout_handler;
 	fsf_req->timer.expires = jiffies + 30 * HZ;
 	add_timer(&fsf_req->timer);
 }
@@ -691,7 +690,7 @@ static struct zfcp_fsf_req *zfcp_fsf_req_create(struct zfcp_qdio *qdio,
 		adapter->req_no++;
 
 	INIT_LIST_HEAD(&req->list);
-	init_timer(&req->timer);
+	timer_setup(&req->timer, NULL, 0);
 	init_completion(&req->completion);
 
 	req->adapter = adapter;
-- 
2.7.4


-- 
Kees Cook
Pixel Security
