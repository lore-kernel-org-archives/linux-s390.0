Return-Path: <linux-kernel-owner+w=401wt.eu-S965833AbXLTPgY@vger.kernel.org>
Message-Id: <20071220152110.109094223@de.ibm.com>
References: <20071220151925.405881218@de.ibm.com>
Date: Thu, 20 Dec 2007 16:19:57 +0100
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 32/47] drivers/s390: Add missing "space"
Content-Disposition: inline; filename=131-drivers-whitespace.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Joe Perches <joe@perches.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Joe Perches <joe@perches.com>

Signed-off-by: Joe Perches <joe@perches.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/monwriter.c |    2 +-
 drivers/s390/char/vmlogrdr.c  |    2 +-
 drivers/s390/cio/chsc.c       |    2 +-
 drivers/s390/net/claw.c       |    2 +-
 drivers/s390/net/lcs.c        |    2 +-
 drivers/s390/scsi/zfcp_fsf.c  |   10 +++++-----
 6 files changed, 10 insertions(+), 10 deletions(-)

Index: quilt-2.6/drivers/s390/char/monwriter.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/monwriter.c
+++ quilt-2.6/drivers/s390/char/monwriter.c
@@ -295,7 +295,7 @@ module_init(mon_init);
 module_exit(mon_exit);
 
 module_param_named(max_bufs, mon_max_bufs, int, 0644);
-MODULE_PARM_DESC(max_bufs, "Maximum number of sample monitor data buffers"
+MODULE_PARM_DESC(max_bufs, "Maximum number of sample monitor data buffers "
 		 "that can be active at one time");
 
 MODULE_AUTHOR("Melissa Howland <Melissa.Howland@us.ibm.com>");
Index: quilt-2.6/drivers/s390/char/vmlogrdr.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/vmlogrdr.c
+++ quilt-2.6/drivers/s390/char/vmlogrdr.c
@@ -683,7 +683,7 @@ static int vmlogrdr_register_driver(void
 	/* Register with iucv driver */
 	ret = iucv_register(&vmlogrdr_iucv_handler, 1);
 	if (ret) {
-		printk (KERN_ERR "vmlogrdr: failed to register with"
+		printk (KERN_ERR "vmlogrdr: failed to register with "
 			"iucv driver\n");
 		goto out;
 	}
Index: quilt-2.6/drivers/s390/cio/chsc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/cio/chsc.c
+++ quilt-2.6/drivers/s390/cio/chsc.c
@@ -1042,7 +1042,7 @@ chsc_determine_css_characteristics(void)
 
 	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsc_area) {
-		CIO_MSG_EVENT(0, "Was not able to determine available"
+		CIO_MSG_EVENT(0, "Was not able to determine available "
 			      "CHSCs due to no memory.\n");
 		return -ENOMEM;
 	}
Index: quilt-2.6/drivers/s390/net/claw.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/claw.c
+++ quilt-2.6/drivers/s390/net/claw.c
@@ -2416,7 +2416,7 @@ init_ccw_bk(struct net_device *dev)
 		    privptr->p_buff_pages_perwrite);
 #endif
                    if (p_buff==NULL) {
-                        printk(KERN_INFO "%s:%s __get_free_pages"
+			printk(KERN_INFO "%s:%s __get_free_pages "
 			 	"for writes buf failed : get is for %d pages\n",
 				dev->name,
 				__FUNCTION__,
Index: quilt-2.6/drivers/s390/net/lcs.c
===================================================================
--- quilt-2.6.orig/drivers/s390/net/lcs.c
+++ quilt-2.6/drivers/s390/net/lcs.c
@@ -1115,7 +1115,7 @@ list_modified:
 			rc = lcs_send_setipm(card, ipm);
 			spin_lock_irqsave(&card->ipm_lock, flags);
 			if (rc) {
-				PRINT_INFO("Adding multicast address failed."
+				PRINT_INFO("Adding multicast address failed. "
 					   "Table possibly full!\n");
 				/* store ipm in failed list -> will be added
 				 * to ipm_list again, so a retry will be done
Index: quilt-2.6/drivers/s390/scsi/zfcp_fsf.c
===================================================================
--- quilt-2.6.orig/drivers/s390/scsi/zfcp_fsf.c
+++ quilt-2.6/drivers/s390/scsi/zfcp_fsf.c
@@ -502,7 +502,7 @@ zfcp_fsf_fsfstatus_qual_eval(struct zfcp
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_SQ_NO_RECOM:
-		ZFCP_LOG_NORMAL("bug: No recommendation could be given for a"
+		ZFCP_LOG_NORMAL("bug: No recommendation could be given for a "
 				"problem on the adapter %s "
 				"Stopping all operations on this adapter. ",
 				zfcp_get_busid_by_adapter(fsf_req->adapter));
@@ -813,7 +813,7 @@ zfcp_fsf_status_read_port_closed(struct 
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
 	if (!port || (port->d_id != (status_buffer->d_id & ZFCP_DID_MASK))) {
-		ZFCP_LOG_NORMAL("bug: Reopen port indication received for"
+		ZFCP_LOG_NORMAL("bug: Reopen port indication received for "
 				"nonexisting port with d_id 0x%06x on "
 				"adapter %s. Ignored.\n",
 				status_buffer->d_id & ZFCP_DID_MASK,
@@ -2280,7 +2280,7 @@ zfcp_fsf_exchange_port_data(struct zfcp_
 				     &lock_flags, &fsf_req);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "exchange port data request for"
+			      "exchange port data request for "
 			      "the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
@@ -2339,7 +2339,7 @@ zfcp_fsf_exchange_port_data_sync(struct 
 				0, NULL, &lock_flags, &fsf_req);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "exchange port data request for"
+			      "exchange port data request for "
 			      "the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
@@ -4725,7 +4725,7 @@ zfcp_fsf_req_create(struct zfcp_adapter 
 	/* allocate new FSF request */
 	fsf_req = zfcp_fsf_req_alloc(pool, req_flags);
 	if (unlikely(NULL == fsf_req)) {
-		ZFCP_LOG_DEBUG("error: Could not put an FSF request into"
+		ZFCP_LOG_DEBUG("error: Could not put an FSF request into "
 			       "the outbound (send) queue.\n");
 		ret = -ENOMEM;
 		goto failed_fsf_req;

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
