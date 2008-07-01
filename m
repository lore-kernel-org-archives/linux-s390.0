Return-Path: <linux-kernel-owner+w=401wt.eu-S1759444AbYGAOJY@vger.kernel.org>
Message-Id: <20080701140625.489478465@de.ibm.com>
References: <20080701140551.168274793@de.ibm.com>
Date: Tue, 01 Jul 2008 16:05:56 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 5/5] zfcp: adapt to new qdio driver
Content-Disposition: inline; filename=725-nqdio-zfcp.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: jang@linux.vnet.ibm.com, Swen Schillig <swen@vnet.ibm.com>, Christof Schmitt <christof.schmitt@de.ibm.com>, James Bottomley <James.Bottomley@HansenPartnership.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Jan Glauber <jang@linux.vnet.ibm.com>

- cleanup qdio interface error handling
- remove qdio interface threshold values
- remove do_QDIO unused last parameter
- no more -EINPROGRESS from qdio_shutdown()
- remove unused parameter from qdio_activate()
- remove QDIO_FLAG_UNDER_INTERRUPT

Cc: Swen Schillig <swen@vnet.ibm.com>
Cc: Christof Schmitt <christof.schmitt@de.ibm.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>

Signed-off-by: Jan Glauber <jang@linux.vnet.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/scsi/zfcp_dbf.c  |   12 +++---------
 drivers/s390/scsi/zfcp_dbf.h  |    2 --
 drivers/s390/scsi/zfcp_ext.h  |    5 ++---
 drivers/s390/scsi/zfcp_qdio.c |   42 ++++++++++++++----------------------------
 4 files changed, 19 insertions(+), 42 deletions(-)

Index: quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_dbf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_dbf.c
@@ -297,15 +297,13 @@ void zfcp_hba_dbf_event_fsf_unsol(const 
 /**
  * zfcp_hba_dbf_event_qdio - trace event for QDIO related failure
  * @adapter: adapter affected by this QDIO related event
- * @status: as passed by qdio module
  * @qdio_error: as passed by qdio module
- * @siga_error: as passed by qdio module
  * @sbal_index: first buffer with error condition, as passed by qdio module
  * @sbal_count: number of buffers affected, as passed by qdio module
  */
-void zfcp_hba_dbf_event_qdio(struct zfcp_adapter *adapter, unsigned int status,
-			     unsigned int qdio_error, unsigned int siga_error,
-			     int sbal_index, int sbal_count)
+void zfcp_hba_dbf_event_qdio(struct zfcp_adapter *adapter,
+			     unsigned int qdio_error, int sbal_index,
+			     int sbal_count)
 {
 	struct zfcp_hba_dbf_record *r = &adapter->hba_dbf_buf;
 	unsigned long flags;
@@ -313,9 +311,7 @@ void zfcp_hba_dbf_event_qdio(struct zfcp
 	spin_lock_irqsave(&adapter->hba_dbf_lock, flags);
 	memset(r, 0, sizeof(*r));
 	strncpy(r->tag, "qdio", ZFCP_DBF_TAG_SIZE);
-	r->u.qdio.status = status;
 	r->u.qdio.qdio_error = qdio_error;
-	r->u.qdio.siga_error = siga_error;
 	r->u.qdio.sbal_index = sbal_index;
 	r->u.qdio.sbal_count = sbal_count;
 	debug_event(adapter->hba_dbf, 0, r, sizeof(*r));
@@ -398,9 +394,7 @@ static void zfcp_hba_dbf_view_status(cha
 
 static void zfcp_hba_dbf_view_qdio(char **p, struct zfcp_hba_dbf_record_qdio *r)
 {
-	zfcp_dbf_out(p, "status", "0x%08x", r->status);
 	zfcp_dbf_out(p, "qdio_error", "0x%08x", r->qdio_error);
-	zfcp_dbf_out(p, "siga_error", "0x%08x", r->siga_error);
 	zfcp_dbf_out(p, "sbal_index", "0x%02x", r->sbal_index);
 	zfcp_dbf_out(p, "sbal_count", "0x%02x", r->sbal_count);
 }
Index: quilt-2.6/drivers/s390/scsi/zfcp_dbf.h
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_dbf.h
+++ quilt-2.6/drivers/s390/scsi/zfcp_dbf.h
@@ -139,9 +139,7 @@ struct zfcp_hba_dbf_record_status {
 } __attribute__ ((packed));
 
 struct zfcp_hba_dbf_record_qdio {
-	u32 status;
 	u32 qdio_error;
-	u32 siga_error;
 	u8 sbal_index;
 	u8 sbal_count;
 } __attribute__ ((packed));
Index: quilt-2.6/drivers/s390/scsi/zfcp_ext.h
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_ext.h
+++ quilt-2.6/drivers/s390/scsi/zfcp_ext.h
@@ -164,9 +164,8 @@ extern void zfcp_rec_dbf_event_action(u8
 extern void zfcp_hba_dbf_event_fsf_response(struct zfcp_fsf_req *);
 extern void zfcp_hba_dbf_event_fsf_unsol(const char *, struct zfcp_adapter *,
 					 struct fsf_status_read_buffer *);
-extern void zfcp_hba_dbf_event_qdio(struct zfcp_adapter *,
-				    unsigned int, unsigned int, unsigned int,
-				    int, int);
+extern void zfcp_hba_dbf_event_qdio(struct zfcp_adapter *, unsigned int, int,
+				    int);
 
 extern void zfcp_san_dbf_event_ct_request(struct zfcp_fsf_req *);
 extern void zfcp_san_dbf_event_ct_response(struct zfcp_fsf_req *);
Index: quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_qdio.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_qdio.c
@@ -63,17 +63,15 @@ static void zfcp_qdio_handler_error(stru
 				ZFCP_STATUS_COMMON_ERP_FAILED, id, NULL);
 }
 
-static void zfcp_qdio_int_req(struct ccw_device *cdev, unsigned int status,
-			      unsigned int qdio_err, unsigned int siga_err,
-			      unsigned int queue_no, int first, int count,
+static void zfcp_qdio_int_req(struct ccw_device *cdev, unsigned int qdio_err,
+			      int queue_no, int first, int count,
 			      unsigned long parm)
 {
 	struct zfcp_adapter *adapter = (struct zfcp_adapter *) parm;
 	struct zfcp_qdio_queue *queue = &adapter->req_q;
 
-	if (unlikely(status & QDIO_STATUS_LOOK_FOR_ERROR)) {
-		zfcp_hba_dbf_event_qdio(adapter, status, qdio_err, siga_err,
-					first, count);
+	if (unlikely(qdio_err)) {
+		zfcp_hba_dbf_event_qdio(adapter, qdio_err, first, count);
 		zfcp_qdio_handler_error(adapter, 140);
 		return;
 	}
@@ -118,8 +116,7 @@ static void zfcp_qdio_resp_put_back(stru
 
 	count = atomic_read(&queue->count) + processed;
 
-	retval = do_QDIO(cdev, QDIO_FLAG_SYNC_INPUT | QDIO_FLAG_UNDER_INTERRUPT,
-			 0, start, count, NULL);
+	retval = do_QDIO(cdev, QDIO_FLAG_SYNC_INPUT, 0, start, count);
 
 	if (unlikely(retval)) {
 		atomic_set(&queue->count, count);
@@ -131,9 +128,8 @@ static void zfcp_qdio_resp_put_back(stru
 	}
 }
 
-static void zfcp_qdio_int_resp(struct ccw_device *cdev, unsigned int status,
-			       unsigned int qdio_err, unsigned int siga_err,
-			       unsigned int queue_no, int first, int count,
+static void zfcp_qdio_int_resp(struct ccw_device *cdev, unsigned int qdio_err,
+			       int queue_no, int first, int count,
 			       unsigned long parm)
 {
 	struct zfcp_adapter *adapter = (struct zfcp_adapter *) parm;
@@ -141,9 +137,8 @@ static void zfcp_qdio_int_resp(struct cc
 	volatile struct qdio_buffer_element *sbale;
 	int sbal_idx, sbale_idx, sbal_no;
 
-	if (unlikely(status & QDIO_STATUS_LOOK_FOR_ERROR)) {
-		zfcp_hba_dbf_event_qdio(adapter, status, qdio_err, siga_err,
-					first, count);
+	if (unlikely(qdio_err)) {
+		zfcp_hba_dbf_event_qdio(adapter, qdio_err, first, count);
 		zfcp_qdio_handler_error(adapter, 147);
 		return;
 	}
@@ -351,7 +346,7 @@ int zfcp_qdio_send(struct zfcp_fsf_req *
 	}
 
 	retval = do_QDIO(adapter->ccw_device, QDIO_FLAG_SYNC_OUTPUT, 0, first,
-			 count, NULL);
+			 count);
 	if (unlikely(retval)) {
 		zfcp_qdio_zero_sbals(req_q->sbal, first, count);
 		return retval;
@@ -405,10 +400,6 @@ int zfcp_qdio_allocate(struct zfcp_adapt
 	init_data->qib_param_field = NULL;
 	init_data->input_slib_elements = NULL;
 	init_data->output_slib_elements = NULL;
-	init_data->min_input_threshold = 1;
-	init_data->max_input_threshold = 5000;
-	init_data->min_output_threshold = 1;
-	init_data->max_output_threshold = 1000;
 	init_data->no_input_qs = 1;
 	init_data->no_output_qs = 1;
 	init_data->input_handler = zfcp_qdio_int_resp;
@@ -441,9 +432,7 @@ void zfcp_qdio_close(struct zfcp_adapter
 	atomic_clear_mask(ZFCP_STATUS_ADAPTER_QDIOUP, &adapter->status);
 	write_unlock_irq(&req_q->lock);
 
-	while (qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR)
-			== -EINPROGRESS)
-		ssleep(1);
+	qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR);
 
 	/* cleanup used outbound sbals */
 	count = atomic_read(&req_q->count);
@@ -478,7 +467,7 @@ int zfcp_qdio_open(struct zfcp_adapter *
 		return -EIO;
 	}
 
-	if (qdio_activate(adapter->ccw_device, 0)) {
+	if (qdio_activate(adapter->ccw_device)) {
 		dev_err(&adapter->ccw_device->dev,
 			 "Activate of QDIO queues failed.\n");
 		goto failed_qdio;
@@ -492,7 +481,7 @@ int zfcp_qdio_open(struct zfcp_adapter *
 	}
 
 	if (do_QDIO(adapter->ccw_device, QDIO_FLAG_SYNC_INPUT, 0, 0,
-		     QDIO_MAX_BUFFERS_PER_Q, NULL)) {
+		     QDIO_MAX_BUFFERS_PER_Q)) {
 		dev_err(&adapter->ccw_device->dev,
 			 "Init of QDIO response queue failed.\n");
 		goto failed_qdio;
@@ -506,9 +495,6 @@ int zfcp_qdio_open(struct zfcp_adapter *
 	return 0;
 
 failed_qdio:
-	while (qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR)
-			== -EINPROGRESS)
-		ssleep(1);
-
+	qdio_shutdown(adapter->ccw_device, QDIO_FLAG_CLEANUP_USING_CLEAR);
 	return -EIO;
 }

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
