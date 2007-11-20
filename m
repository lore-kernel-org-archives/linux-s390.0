Return-Path: <linux-kernel-owner+w=401wt.eu-S1761223AbXKTCDX@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 39/59] drivers/s390: Add missing "space"
Date: Mon, 19 Nov 2007 17:48:31 -0800
Message-Id: <1195523331-15303-40-git-send-email-joe@perches.com>
In-Reply-To: <1195523331-15303-39-git-send-email-joe@perches.com>
References: 1234567
 <1195523331-15303-1-git-send-email-joe@perches.com>
 <1195523331-15303-2-git-send-email-joe@perches.com>
 <1195523331-15303-3-git-send-email-joe@perches.com>
 <1195523331-15303-4-git-send-email-joe@perches.com>
 <1195523331-15303-5-git-send-email-joe@perches.com>
 <1195523331-15303-6-git-send-email-joe@perches.com>
 <1195523331-15303-7-git-send-email-joe@perches.com>
 <1195523331-15303-8-git-send-email-joe@perches.com>
 <1195523331-15303-9-git-send-email-joe@perches.com>
 <1195523331-15303-10-git-send-email-joe@perches.com>
 <1195523331-15303-11-git-send-email-joe@perches.com>
 <1195523331-15303-12-git-send-email-joe@perches.com>
 <1195523331-15303-13-git-send-email-joe@perches.com>
 <1195523331-15303-14-git-send-email-joe@perches.com>
 <1195523331-15303-15-git-send-email-joe@perches.com>
 <1195523331-15303-16-git-send-email-joe@perches.com>
 <1195523331-15303-17-git-send-email-joe@perches.com>
 <1195523331-15303-18-git-send-email-joe@perches.com>
 <1195523331-15303-19-git-send-email-joe@perches.com>
 <1195523331-15303-20-git-send-email-joe@perches.com>
 <1195523331-15303-21-git-send-email-joe@perches.com>
 <1195523331-15303-22-git-send-email-joe@perches.com>
 <1195523331-15303-23-git-send-email-joe@perches.com>
 <1195523331-15303-24-git-send-email-joe@perches.com>
 <1195523331-15303-25-git-send-email-joe@perches.com>
 <1195523331-15303-26-git-send-email-joe@perches.com>
 <1195523331-15303-27-git-send-email-joe@perches.com>
 <1195523331-15303-28-git-send-email-joe@perches.com>
 <1195523331-15303-29-git-send-email-joe@perches.com>
 <1195523331-15303-30-git-send-email-joe@perches.com>
 <1195523331-15303-31-git-send-email-joe@perches.com>
 <1195523331-15303-32-git-send-email-joe@perches.com>
 <1195523331-15303-33-git-send-email-joe@perches.com>
 <1195523331-15303-34-git-send-email-joe@perches.com>
 <1195523331-15303-35-git-send-email-joe@perches.com>
 <1195523331-15303-36-git-send-email-joe@perches.com>
 <1195523331-15303-37-git-send-email-joe@perches.com>
 <1195523331-15303-38-git-send-email-joe@perches.com>
 <1195523331-15303-39-git-send-email-joe@perches.com>
Message-Id: <d9fb5d88f80db783c403b0d7c8e13c1e82c9ad32.1195454435.git.joe@perches.com>
In-Reply-To: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
References: <ee1678e1bc8b80b7ae420059fffc7241486ea91a.1195454434.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Frank Blaschka <blaschka@linux.vnet.ibm.com>, Swen Schillig <swen@vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, linux-s390@vger.kernel.org, linux390@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/char/monwriter.c |    2 +-
 drivers/s390/char/vmlogrdr.c  |    2 +-
 drivers/s390/cio/chsc.c       |    2 +-
 drivers/s390/net/claw.c       |    2 +-
 drivers/s390/net/lcs.c        |    2 +-
 drivers/s390/scsi/zfcp_fsf.c  |   10 +++++-----
 6 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/monwriter.c b/drivers/s390/char/monwriter.c
index 20442fb..a86c053 100644
--- a/drivers/s390/char/monwriter.c
+++ b/drivers/s390/char/monwriter.c
@@ -295,7 +295,7 @@ module_init(mon_init);
 module_exit(mon_exit);
 
 module_param_named(max_bufs, mon_max_bufs, int, 0644);
-MODULE_PARM_DESC(max_bufs, "Maximum number of sample monitor data buffers"
+MODULE_PARM_DESC(max_bufs, "Maximum number of sample monitor data buffers "
 		 "that can be active at one time");
 
 MODULE_AUTHOR("Melissa Howland <Melissa.Howland@us.ibm.com>");
diff --git a/drivers/s390/char/vmlogrdr.c b/drivers/s390/char/vmlogrdr.c
index e0c4c50..d364e0b 100644
--- a/drivers/s390/char/vmlogrdr.c
+++ b/drivers/s390/char/vmlogrdr.c
@@ -683,7 +683,7 @@ static int vmlogrdr_register_driver(void)
 	/* Register with iucv driver */
 	ret = iucv_register(&vmlogrdr_iucv_handler, 1);
 	if (ret) {
-		printk (KERN_ERR "vmlogrdr: failed to register with"
+		printk (KERN_ERR "vmlogrdr: failed to register with "
 			"iucv driver\n");
 		goto out;
 	}
diff --git a/drivers/s390/cio/chsc.c b/drivers/s390/cio/chsc.c
index 597c0c7..bda3ea6 100644
--- a/drivers/s390/cio/chsc.c
+++ b/drivers/s390/cio/chsc.c
@@ -1075,7 +1075,7 @@ chsc_determine_css_characteristics(void)
 
 	scsc_area = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
 	if (!scsc_area) {
-		CIO_MSG_EVENT(0, "Was not able to determine available"
+		CIO_MSG_EVENT(0, "Was not able to determine available "
 			      "CHSCs due to no memory.\n");
 		return -ENOMEM;
 	}
diff --git a/drivers/s390/net/claw.c b/drivers/s390/net/claw.c
index 3561982..f63b518 100644
--- a/drivers/s390/net/claw.c
+++ b/drivers/s390/net/claw.c
@@ -2416,7 +2416,7 @@ init_ccw_bk(struct net_device *dev)
 		    privptr->p_buff_pages_perwrite);
 #endif
                    if (p_buff==NULL) {
-                        printk(KERN_INFO "%s:%s __get_free_pages"
+                        printk(KERN_INFO "%s:%s __get_free_pages "
 			 	"for writes buf failed : get is for %d pages\n",
 				dev->name,
 				__FUNCTION__,
diff --git a/drivers/s390/net/lcs.c b/drivers/s390/net/lcs.c
index 0fd663b..7bfe8d7 100644
--- a/drivers/s390/net/lcs.c
+++ b/drivers/s390/net/lcs.c
@@ -1115,7 +1115,7 @@ list_modified:
 			rc = lcs_send_setipm(card, ipm);
 			spin_lock_irqsave(&card->ipm_lock, flags);
 			if (rc) {
-				PRINT_INFO("Adding multicast address failed."
+				PRINT_INFO("Adding multicast address failed. "
 					   "Table possibly full!\n");
 				/* store ipm in failed list -> will be added
 				 * to ipm_list again, so a retry will be done
diff --git a/drivers/s390/scsi/zfcp_fsf.c b/drivers/s390/scsi/zfcp_fsf.c
index ff866eb..260b1ce 100644
--- a/drivers/s390/scsi/zfcp_fsf.c
+++ b/drivers/s390/scsi/zfcp_fsf.c
@@ -502,7 +502,7 @@ zfcp_fsf_fsfstatus_qual_eval(struct zfcp_fsf_req *fsf_req)
 		fsf_req->status |= ZFCP_STATUS_FSFREQ_ERROR;
 		break;
 	case FSF_SQ_NO_RECOM:
-		ZFCP_LOG_NORMAL("bug: No recommendation could be given for a"
+		ZFCP_LOG_NORMAL("bug: No recommendation could be given for a "
 				"problem on the adapter %s "
 				"Stopping all operations on this adapter. ",
 				zfcp_get_busid_by_adapter(fsf_req->adapter));
@@ -813,7 +813,7 @@ zfcp_fsf_status_read_port_closed(struct zfcp_fsf_req *fsf_req)
 	read_unlock_irqrestore(&zfcp_data.config_lock, flags);
 
 	if (!port || (port->d_id != (status_buffer->d_id & ZFCP_DID_MASK))) {
-		ZFCP_LOG_NORMAL("bug: Reopen port indication received for"
+		ZFCP_LOG_NORMAL("bug: Reopen port indication received for "
 				"nonexisting port with d_id 0x%06x on "
 				"adapter %s. Ignored.\n",
 				status_buffer->d_id & ZFCP_DID_MASK,
@@ -2280,7 +2280,7 @@ zfcp_fsf_exchange_port_data(struct zfcp_erp_action *erp_action)
 				     &lock_flags, &fsf_req);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "exchange port data request for"
+			      "exchange port data request for "
 			      "the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
@@ -2339,7 +2339,7 @@ zfcp_fsf_exchange_port_data_sync(struct zfcp_adapter *adapter,
 				0, NULL, &lock_flags, &fsf_req);
 	if (retval) {
 		ZFCP_LOG_INFO("error: Out of resources. Could not create an "
-			      "exchange port data request for"
+			      "exchange port data request for "
 			      "the adapter %s.\n",
 			      zfcp_get_busid_by_adapter(adapter));
 		write_unlock_irqrestore(&adapter->request_queue.queue_lock,
@@ -4725,7 +4725,7 @@ zfcp_fsf_req_create(struct zfcp_adapter *adapter, u32 fsf_cmd, int req_flags,
 	/* allocate new FSF request */
 	fsf_req = zfcp_fsf_req_alloc(pool, req_flags);
 	if (unlikely(NULL == fsf_req)) {
-		ZFCP_LOG_DEBUG("error: Could not put an FSF request into"
+		ZFCP_LOG_DEBUG("error: Could not put an FSF request into "
 			       "the outbound (send) queue.\n");
 		ret = -ENOMEM;
 		goto failed_fsf_req;
-- 
1.5.3.5.652.gf192c
