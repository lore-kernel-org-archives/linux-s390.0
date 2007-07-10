Return-Path: <linux-kernel-owner+w=401wt.eu-S1764761AbXGJJco@vger.kernel.org>
Message-Id: <20070710093122.137128376@de.ibm.com>
References: <20070710092935.896013926@de.ibm.com>
Date: Tue, 10 Jul 2007 11:29:48 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 13/16] zcrypt: fix request timeout handling
Content-Disposition: inline; filename=013-zcrypt-timeout.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ralph Wuerthner <rwuerthn@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ralph Wuerthner <rwuerthn@de.ibm.com>

Under very high load zcrypt requests may timeout while waiting on the
request queue. Modify zcrypt that timeouts are based on crypto adapter
responses. A timeout occurs only if a crypto adapter does not respond
within a given time frame to sumitted requests. 

Signed-off-by: Ralph Wuerthner <rwuerthn@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/crypto/ap_bus.c        |   98 ++++++++++++++++++++++++++++++++----
 drivers/s390/crypto/ap_bus.h        |   11 ++++
 drivers/s390/crypto/zcrypt_cex2a.c  |   27 +++------
 drivers/s390/crypto/zcrypt_pcica.c  |   27 +++------
 drivers/s390/crypto/zcrypt_pcicc.c  |   27 +++------
 drivers/s390/crypto/zcrypt_pcixcc.c |   40 ++++----------
 6 files changed, 140 insertions(+), 90 deletions(-)

Index: quilt-2.6/drivers/s390/crypto/ap_bus.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.c
+++ quilt-2.6/drivers/s390/crypto/ap_bus.c
@@ -43,6 +43,7 @@ static void ap_poll_all(unsigned long);
 static void ap_poll_timeout(unsigned long);
 static int ap_poll_thread_start(void);
 static void ap_poll_thread_stop(void);
+static void ap_request_timeout(unsigned long);
 
 /**
  * Module description.
@@ -189,6 +190,7 @@ int ap_send(ap_qid_t qid, unsigned long 
 	case AP_RESPONSE_NORMAL:
 		return 0;
 	case AP_RESPONSE_Q_FULL:
+	case AP_RESPONSE_RESET_IN_PROGRESS:
 		return -EBUSY;
 	default:	/* Device is gone. */
 		return -ENODEV;
@@ -252,6 +254,8 @@ int ap_recv(ap_qid_t qid, unsigned long 
 		if (status.queue_empty)
 			return -ENOENT;
 		return -EBUSY;
+	case AP_RESPONSE_RESET_IN_PROGRESS:
+		return -EBUSY;
 	default:
 		return -ENODEV;
 	}
@@ -326,11 +330,12 @@ static int ap_init_queue(ap_qid_t qid)
 			i = AP_MAX_RESET;	/* return with -ENODEV */
 			break;
 		case AP_RESPONSE_RESET_IN_PROGRESS:
+			rc = -EBUSY;
 		case AP_RESPONSE_BUSY:
 		default:
 			break;
 		}
-		if (rc != -ENODEV)
+		if (rc != -ENODEV && rc != -EBUSY)
 			break;
 		if (i < AP_MAX_RESET - 1) {
 			udelay(5);
@@ -341,6 +346,40 @@ static int ap_init_queue(ap_qid_t qid)
 }
 
 /**
+ * Arm request timeout if a AP device was idle and a new request is submitted.
+ */
+static void ap_increase_queue_count(struct ap_device *ap_dev)
+{
+	int timeout = ap_dev->drv->request_timeout;
+
+	ap_dev->queue_count++;
+	if (ap_dev->queue_count == 1) {
+		mod_timer(&ap_dev->timeout, jiffies + timeout);
+		ap_dev->reset = AP_RESET_ARMED;
+	}
+}
+
+/**
+ * AP device is still alive, re-schedule request timeout if there are still
+ * pending requests.
+ */
+static void ap_decrease_queue_count(struct ap_device *ap_dev)
+{
+	int timeout = ap_dev->drv->request_timeout;
+
+	ap_dev->queue_count--;
+	if (ap_dev->queue_count > 0)
+		mod_timer(&ap_dev->timeout, jiffies + timeout);
+	else
+		/**
+		 * The timeout timer should to be disabled now - since
+		 * del_timer_sync() is very expensive, we just tell via the
+		 * reset flag to ignore the pending timeout timer.
+		 */
+		ap_dev->reset = AP_RESET_IGNORE;
+}
+
+/**
  * AP device related attributes.
  */
 static ssize_t ap_hwtype_show(struct device *dev,
@@ -498,6 +537,7 @@ static int ap_device_remove(struct devic
 	struct ap_driver *ap_drv = ap_dev->drv;
 
 	ap_flush_queue(ap_dev);
+	del_timer_sync(&ap_dev->timeout);
 	if (ap_drv->remove)
 		ap_drv->remove(ap_dev);
 	spin_lock_bh(&ap_device_lock);
@@ -759,17 +799,21 @@ static void ap_scan_bus(struct work_stru
 				      __ap_scan_bus);
 		rc = ap_query_queue(qid, &queue_depth, &device_type);
 		if (dev) {
+			if (rc == -EBUSY) {
+				set_current_state(TASK_UNINTERRUPTIBLE);
+				schedule_timeout(AP_RESET_TIMEOUT);
+				rc = ap_query_queue(qid, &queue_depth,
+						    &device_type);
+			}
 			ap_dev = to_ap_dev(dev);
 			spin_lock_bh(&ap_dev->lock);
 			if (rc || ap_dev->unregistered) {
 				spin_unlock_bh(&ap_dev->lock);
-				put_device(dev);
 				device_unregister(dev);
+				put_device(dev);
 				continue;
-			} else
-				spin_unlock_bh(&ap_dev->lock);
-		}
-		if (dev) {
+			}
+			spin_unlock_bh(&ap_dev->lock);
 			put_device(dev);
 			continue;
 		}
@@ -788,6 +832,8 @@ static void ap_scan_bus(struct work_stru
 		INIT_LIST_HEAD(&ap_dev->pendingq);
 		INIT_LIST_HEAD(&ap_dev->requestq);
 		INIT_LIST_HEAD(&ap_dev->list);
+		setup_timer(&ap_dev->timeout, ap_request_timeout,
+			    (unsigned long) ap_dev);
 		if (device_type == 0)
 			ap_probe_device_type(ap_dev);
 		else
@@ -853,7 +899,7 @@ static int ap_poll_read(struct ap_device
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 		atomic_dec(&ap_poll_requests);
-		ap_dev->queue_count--;
+		ap_decrease_queue_count(ap_dev);
 		list_for_each_entry(ap_msg, &ap_dev->pendingq, list) {
 			if (ap_msg->psmid != ap_dev->reply->psmid)
 				continue;
@@ -904,7 +950,7 @@ static int ap_poll_write(struct ap_devic
 	switch (status.response_code) {
 	case AP_RESPONSE_NORMAL:
 		atomic_inc(&ap_poll_requests);
-		ap_dev->queue_count++;
+		ap_increase_queue_count(ap_dev);
 		list_move_tail(&ap_msg->list, &ap_dev->pendingq);
 		ap_dev->requestq_count--;
 		ap_dev->pendingq_count++;
@@ -914,6 +960,7 @@ static int ap_poll_write(struct ap_devic
 		*flags |= 2;
 		break;
 	case AP_RESPONSE_Q_FULL:
+	case AP_RESPONSE_RESET_IN_PROGRESS:
 		*flags |= 2;
 		break;
 	case AP_RESPONSE_MESSAGE_TOO_BIG:
@@ -960,10 +1007,11 @@ static int __ap_queue_message(struct ap_
 			list_add_tail(&ap_msg->list, &ap_dev->pendingq);
 			atomic_inc(&ap_poll_requests);
 			ap_dev->pendingq_count++;
-			ap_dev->queue_count++;
+			ap_increase_queue_count(ap_dev);
 			ap_dev->total_request_count++;
 			break;
 		case AP_RESPONSE_Q_FULL:
+		case AP_RESPONSE_RESET_IN_PROGRESS:
 			list_add_tail(&ap_msg->list, &ap_dev->requestq);
 			ap_dev->requestq_count++;
 			ap_dev->total_request_count++;
@@ -1046,6 +1094,25 @@ static void ap_poll_timeout(unsigned lon
 }
 
 /**
+ * Reset a not responding AP device and move all requests from the
+ * pending queue to the request queue.
+ */
+static void ap_reset(struct ap_device *ap_dev)
+{
+	int rc;
+
+	ap_dev->reset = AP_RESET_IGNORE;
+	atomic_sub(ap_dev->queue_count, &ap_poll_requests);
+	ap_dev->queue_count = 0;
+	list_splice_init(&ap_dev->pendingq, &ap_dev->requestq);
+	ap_dev->requestq_count += ap_dev->pendingq_count;
+	ap_dev->pendingq_count = 0;
+	rc = ap_init_queue(ap_dev->qid);
+	if (rc == -ENODEV)
+		ap_dev->unregistered = 1;
+}
+
+/**
  * Poll all AP devices on the bus in a round robin fashion. Continue
  * polling until bit 2^0 of the control flags is not set. If bit 2^1
  * of the control flags has been set arm the poll timer.
@@ -1056,6 +1123,8 @@ static int __ap_poll_all(struct ap_devic
 	if (!ap_dev->unregistered) {
 		if (ap_poll_queue(ap_dev, flags))
 			ap_dev->unregistered = 1;
+		if (ap_dev->reset == AP_RESET_DO)
+			ap_reset(ap_dev);
 	}
 	spin_unlock(&ap_dev->lock);
 	return 0;
@@ -1147,6 +1216,17 @@ static void ap_poll_thread_stop(void)
 	mutex_unlock(&ap_poll_thread_mutex);
 }
 
+/**
+ * Handling of request timeouts
+ */
+static void ap_request_timeout(unsigned long data)
+{
+	struct ap_device *ap_dev = (struct ap_device *) data;
+
+	if (ap_dev->reset == AP_RESET_ARMED)
+		ap_dev->reset = AP_RESET_DO;
+}
+
 static void ap_reset_domain(void)
 {
 	int i;
Index: quilt-2.6/drivers/s390/crypto/ap_bus.h
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/ap_bus.h
+++ quilt-2.6/drivers/s390/crypto/ap_bus.h
@@ -33,6 +33,7 @@
 #define AP_DEVICES 64		/* Number of AP devices. */
 #define AP_DOMAINS 16		/* Number of AP domains. */
 #define AP_MAX_RESET 90		/* Maximum number of resets. */
+#define AP_RESET_TIMEOUT (HZ/2)	/* Time in ticks for reset timeouts. */
 #define AP_CONFIG_TIME 30	/* Time in seconds between AP bus rescans. */
 #define AP_POLL_TIME 1		/* Time in ticks between receive polls. */
 
@@ -83,6 +84,13 @@ struct ap_queue_status {
 #define AP_DEVICE_TYPE_CEX2A	6
 #define AP_DEVICE_TYPE_CEX2C	7
 
+/**
+ * AP reset flag states
+ */
+#define AP_RESET_IGNORE	0	/* request timeout will be ignored */
+#define AP_RESET_ARMED	1	/* request timeout timer is active */
+#define AP_RESET_DO	2	/* AP reset required */
+
 struct ap_device;
 struct ap_message;
 
@@ -95,6 +103,7 @@ struct ap_driver {
 	/* receive is called from tasklet context */
 	void (*receive)(struct ap_device *, struct ap_message *,
 			struct ap_message *);
+	int request_timeout;		/* request timeout in jiffies */
 };
 
 #define to_ap_drv(x) container_of((x), struct ap_driver, driver)
@@ -112,6 +121,8 @@ struct ap_device {
 	int queue_depth;		/* AP queue depth.*/
 	int device_type;		/* AP device type. */
 	int unregistered;		/* marks AP device as unregistered */
+	struct timer_list timeout;	/* Timer for request timeouts. */
+	int reset;			/* Reset required after req. timeout. */
 
 	int queue_count;		/* # messages currently on AP queue. */
 
Index: quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_cex2a.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_cex2a.c
@@ -70,6 +70,7 @@ static struct ap_driver zcrypt_cex2a_dri
 	.remove = zcrypt_cex2a_remove,
 	.receive = zcrypt_cex2a_receive,
 	.ids = zcrypt_cex2a_ids,
+	.request_timeout = CEX2A_CLEANUP_TIME,
 };
 
 /**
@@ -306,18 +307,13 @@ static long zcrypt_cex2a_modexpo(struct 
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, CEX2A_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, mex->outputdata,
 				      mex->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	kfree(ap_msg.message);
 	return rc;
@@ -348,18 +344,13 @@ static long zcrypt_cex2a_modexpo_crt(str
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, CEX2A_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, crt->outputdata,
 				      crt->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	kfree(ap_msg.message);
 	return rc;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcica.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcica.c
@@ -70,6 +70,7 @@ static struct ap_driver zcrypt_pcica_dri
 	.remove = zcrypt_pcica_remove,
 	.receive = zcrypt_pcica_receive,
 	.ids = zcrypt_pcica_ids,
+	.request_timeout = PCICA_CLEANUP_TIME,
 };
 
 /**
@@ -290,18 +291,13 @@ static long zcrypt_pcica_modexpo(struct 
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, PCICA_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, mex->outputdata,
 				      mex->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	kfree(ap_msg.message);
 	return rc;
@@ -332,18 +328,13 @@ static long zcrypt_pcica_modexpo_crt(str
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, PCICA_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, crt->outputdata,
 				      crt->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	kfree(ap_msg.message);
 	return rc;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcicc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcicc.c
@@ -82,6 +82,7 @@ static struct ap_driver zcrypt_pcicc_dri
 	.remove = zcrypt_pcicc_remove,
 	.receive = zcrypt_pcicc_receive,
 	.ids = zcrypt_pcicc_ids,
+	.request_timeout = PCICC_CLEANUP_TIME,
 };
 
 /**
@@ -501,18 +502,13 @@ static long zcrypt_pcicc_modexpo(struct 
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, PCICC_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, mex->outputdata,
 				      mex->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	free_page((unsigned long) ap_msg.message);
 	return rc;
@@ -544,18 +540,13 @@ static long zcrypt_pcicc_modexpo_crt(str
 		goto out_free;
 	init_completion(&work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&work, PCICC_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&work);
+	if (rc == 0)
 		rc = convert_response(zdev, &ap_msg, crt->outputdata,
 				      crt->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	free_page((unsigned long) ap_msg.message);
 	return rc;
Index: quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
===================================================================
--- quilt-2.6.orig/drivers/s390/crypto/zcrypt_pcixcc.c
+++ quilt-2.6/drivers/s390/crypto/zcrypt_pcixcc.c
@@ -93,6 +93,7 @@ static struct ap_driver zcrypt_pcixcc_dr
 	.remove = zcrypt_pcixcc_remove,
 	.receive = zcrypt_pcixcc_receive,
 	.ids = zcrypt_pcixcc_ids,
+	.request_timeout = PCIXCC_CLEANUP_TIME,
 };
 
 /**
@@ -641,18 +642,13 @@ static long zcrypt_pcixcc_modexpo(struct
 		goto out_free;
 	init_completion(&resp_type.work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&resp_type.work, PCIXCC_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&resp_type.work);
+	if (rc == 0)
 		rc = convert_response_ica(zdev, &ap_msg, mex->outputdata,
 					  mex->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	free_page((unsigned long) ap_msg.message);
 	return rc;
@@ -685,18 +681,13 @@ static long zcrypt_pcixcc_modexpo_crt(st
 		goto out_free;
 	init_completion(&resp_type.work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&resp_type.work, PCIXCC_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&resp_type.work);
+	if (rc == 0)
 		rc = convert_response_ica(zdev, &ap_msg, crt->outputdata,
 					  crt->outputdatalength);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	free_page((unsigned long) ap_msg.message);
 	return rc;
@@ -729,17 +720,12 @@ static long zcrypt_pcixcc_send_cprb(stru
 		goto out_free;
 	init_completion(&resp_type.work);
 	ap_queue_message(zdev->ap_dev, &ap_msg);
-	rc = wait_for_completion_interruptible_timeout(
-				&resp_type.work, PCIXCC_CLEANUP_TIME);
-	if (rc > 0)
+	rc = wait_for_completion_interruptible(&resp_type.work);
+	if (rc == 0)
 		rc = convert_response_xcrb(zdev, &ap_msg, xcRB);
-	else {
-		/* Signal pending or message timed out. */
+	else
+		/* Signal pending. */
 		ap_cancel_message(zdev->ap_dev, &ap_msg);
-		if (rc == 0)
-			/* Message timed out. */
-			rc = -ETIME;
-	}
 out_free:
 	memset(ap_msg.message, 0x0, ap_msg.length);
 	kfree(ap_msg.message);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
