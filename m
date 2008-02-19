Return-Path: <linux-kernel-owner+w=401wt.eu-S1761282AbYBSOsz@vger.kernel.org>
Message-Id: <20080219144505.259341099@de.ibm.com>
References: <20080219144047.587547541@de.ibm.com>
Date: Tue, 19 Feb 2008 15:40:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 10/13] sclp: clean up send/receive naming scheme
Content-Disposition: inline; filename=010-sclp-cleanup.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>

Make state change events adjust the correct mask by cleaning up
naming inconsistencies. Also remove chance for lockup by removing
unnecessary mask related check before reading events.

Signed-off-by: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/sclp.c         |   12 ++++++------
 drivers/s390/char/sclp.h         |    6 ++++--
 drivers/s390/char/sclp_config.c  |    2 +-
 drivers/s390/char/sclp_cpi_sys.c |    2 +-
 drivers/s390/char/sclp_rw.c      |    4 ++--
 drivers/s390/char/sclp_vt220.c   |    2 +-
 6 files changed, 15 insertions(+), 13 deletions(-)

Index: quilt-2.6/drivers/s390/char/sclp.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.c
+++ quilt-2.6/drivers/s390/char/sclp.c
@@ -29,10 +29,10 @@ static ext_int_info_t ext_int_info_hwc;
 /* Lock to protect internal data consistency. */
 static DEFINE_SPINLOCK(sclp_lock);
 
-/* Mask of events that we can receive from the sclp interface. */
+/* Mask of events that we can send to the sclp interface. */
 static sccb_mask_t sclp_receive_mask;
 
-/* Mask of events that we can send to the sclp interface. */
+/* Mask of events that we can receive from the sclp interface. */
 static sccb_mask_t sclp_send_mask;
 
 /* List of registered event listeners and senders. */
@@ -380,7 +380,7 @@ sclp_interrupt_handler(__u16 code)
 		}
 		sclp_running_state = sclp_running_state_idle;
 	}
-	if (evbuf_pending && sclp_receive_mask != 0 &&
+	if (evbuf_pending &&
 	    sclp_activation_state == sclp_activation_state_active)
 		__sclp_queue_read_req();
 	spin_unlock(&sclp_lock);
@@ -459,8 +459,8 @@ sclp_dispatch_state_change(void)
 		reg = NULL;
 		list_for_each(l, &sclp_reg_list) {
 			reg = list_entry(l, struct sclp_register, list);
-			receive_mask = reg->receive_mask & sclp_receive_mask;
-			send_mask = reg->send_mask & sclp_send_mask;
+			receive_mask = reg->send_mask & sclp_receive_mask;
+			send_mask = reg->receive_mask & sclp_send_mask;
 			if (reg->sclp_receive_mask != receive_mask ||
 			    reg->sclp_send_mask != send_mask) {
 				reg->sclp_receive_mask = receive_mask;
@@ -615,8 +615,8 @@ struct init_sccb {
 	u16 mask_length;
 	sccb_mask_t receive_mask;
 	sccb_mask_t send_mask;
-	sccb_mask_t sclp_send_mask;
 	sccb_mask_t sclp_receive_mask;
+	sccb_mask_t sclp_send_mask;
 } __attribute__((packed));
 
 /* Prepare init mask request. Called while sclp_lock is locked. */
Index: quilt-2.6/drivers/s390/char/sclp_config.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_config.c
+++ quilt-2.6/drivers/s390/char/sclp_config.c
@@ -64,7 +64,7 @@ static int __init sclp_conf_init(void)
 		return rc;
 	}
 
-	if (!(sclp_conf_register.sclp_receive_mask & EVTYP_CONFMGMDATA_MASK)) {
+	if (!(sclp_conf_register.sclp_send_mask & EVTYP_CONFMGMDATA_MASK)) {
 		printk(KERN_WARNING TAG "no configuration management.\n");
 		sclp_unregister(&sclp_conf_register);
 		rc = -ENOSYS;
Index: quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_cpi_sys.c
+++ quilt-2.6/drivers/s390/char/sclp_cpi_sys.c
@@ -129,7 +129,7 @@ static int cpi_req(void)
 			"to hardware console.\n");
 		goto out;
 	}
-	if (!(sclp_cpi_event.sclp_send_mask & EVTYP_CTLPROGIDENT_MASK)) {
+	if (!(sclp_cpi_event.sclp_receive_mask & EVTYP_CTLPROGIDENT_MASK)) {
 		printk(KERN_WARNING "cpi: no control program "
 			"identification support\n");
 		rc = -EOPNOTSUPP;
Index: quilt-2.6/drivers/s390/char/sclp.h
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp.h
+++ quilt-2.6/drivers/s390/char/sclp.h
@@ -122,11 +122,13 @@ struct sclp_req {
 /* of some routines it wants to be called from the low level driver */
 struct sclp_register {
 	struct list_head list;
-	/* event masks this user is registered for */
+	/* User wants to receive: */
 	sccb_mask_t receive_mask;
+	/* User wants to send: */
 	sccb_mask_t send_mask;
-	/* actually present events */
+	/* H/W can receive: */
 	sccb_mask_t sclp_receive_mask;
+	/* H/W can send: */
 	sccb_mask_t sclp_send_mask;
 	/* called if event type availability changes */
 	void (*state_change_fn)(struct sclp_register *);
Index: quilt-2.6/drivers/s390/char/sclp_rw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_rw.c
+++ quilt-2.6/drivers/s390/char/sclp_rw.c
@@ -452,10 +452,10 @@ sclp_emit_buffer(struct sclp_buffer *buf
 		return -EIO;
 
 	sccb = buffer->sccb;
-	if (sclp_rw_event.sclp_send_mask & EVTYP_MSG_MASK)
+	if (sclp_rw_event.sclp_receive_mask & EVTYP_MSG_MASK)
 		/* Use normal write message */
 		sccb->msg_buf.header.type = EVTYP_MSG;
-	else if (sclp_rw_event.sclp_send_mask & EVTYP_PMSGCMD_MASK)
+	else if (sclp_rw_event.sclp_receive_mask & EVTYP_PMSGCMD_MASK)
 		/* Use write priority message */
 		sccb->msg_buf.header.type = EVTYP_PMSGCMD;
 	else
Index: quilt-2.6/drivers/s390/char/sclp_vt220.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/sclp_vt220.c
+++ quilt-2.6/drivers/s390/char/sclp_vt220.c
@@ -202,7 +202,7 @@ sclp_vt220_callback(struct sclp_req *req
 static int
 __sclp_vt220_emit(struct sclp_vt220_request *request)
 {
-	if (!(sclp_vt220_register.sclp_send_mask & EVTYP_VT220MSG_MASK)) {
+	if (!(sclp_vt220_register.sclp_receive_mask & EVTYP_VT220MSG_MASK)) {
 		request->sclp_req.status = SCLP_REQ_FAILED;
 		return -EIO;
 	}

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
