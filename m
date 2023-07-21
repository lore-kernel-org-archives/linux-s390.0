Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B071AC04A94
	for <linux-s390@archiver.kernel.org>; Fri, 21 Jul 2023 19:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230417AbjGUThA (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 21 Jul 2023 15:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230449AbjGUTg6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 21 Jul 2023 15:36:58 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94AA2D7F;
        Fri, 21 Jul 2023 12:36:56 -0700 (PDT)
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36LJYAjV012163;
        Fri, 21 Jul 2023 19:36:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=MX+D+FLqEF4vdbOhL8h6Xz0Esd5T7Zdx1L+ZZXStev8=;
 b=YolLS00MHldT/ENFFmhhMGj/QNKHb/gwgYMzx8OaoUNKorUv44g9nyvtk7zk8T+iV2+H
 3xnwvJ4ag2j0rkC4nF3rSkN/pxCsxsa91rkc8cJS9N0RIfYunhRWsayQw7smEx7ydyfo
 b4mTLdRVAcHsUFMnXjB3vk2kidux4FdmPf9HatipkqDyDrpkz4qmMFWTKavFqalwICEV
 2EMj/KH9lArv5ko64qFXbr82ivIniLcNUpYBBXAtwQZ4A6GUuqmFvYidmpP9n3UELMSm
 e/L3ARy5RV2ensGoVQHUX3D5z8FVAYB/JvoRJbkra1DuMDYE+5ylRKRDi/SvDSfhIhd2 4A== 
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s0047g774-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:54 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36LHO1mu031299;
        Fri, 21 Jul 2023 19:36:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3rv79k6t76-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 21 Jul 2023 19:36:53 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36LJanpq14615092
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 21 Jul 2023 19:36:49 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2069B20043;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0C7D320040;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri, 21 Jul 2023 19:36:49 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 20191)
        id 9D804E2695; Fri, 21 Jul 2023 21:36:48 +0200 (CEST)
From:   Stefan Haberland <sth@linux.ibm.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: [PATCH 3/4] s390/dasd: fix hanging device after request requeue
Date:   Fri, 21 Jul 2023 21:36:46 +0200
Message-Id: <20230721193647.3889634-4-sth@linux.ibm.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230721193647.3889634-1-sth@linux.ibm.com>
References: <20230721193647.3889634-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: APzqFAEj42qgZeIFHboeSzYx59e6-x_0
X-Proofpoint-GUID: APzqFAEj42qgZeIFHboeSzYx59e6-x_0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-21_11,2023-07-20_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1015
 mlxlogscore=978 bulkscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2306200000
 definitions=main-2307210172
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

The DASD device driver has a function to requeue requests to the
blocklayer.
This function is used in various cases when basic settings for the device
have to be changed like High Performance Ficon related parameters or copy
pair settings.

The functions iterates over the device->ccw_queue and also removes the
requests from the block->ccw_queue.
In case the device is started on an alias device instead of the base
device it might be removed from the block->ccw_queue without having it
canceled properly before. This might lead to a hanging device since the
request is no longer on a queue and can not be handled properly.

Fix by iterating over the block->ccw_queue instead of the
device->ccw_queue. This will take care of all blocklayer related requests
and handle them on all associated DASD devices.

Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 125 +++++++++++++++-----------------------
 1 file changed, 48 insertions(+), 77 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index edcbf77852c3..50a5ff70814a 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2943,41 +2943,32 @@ static void _dasd_wake_block_flush_cb(struct dasd_ccw_req *cqr, void *data)
  * Requeue a request back to the block request queue
  * only works for block requests
  */
-static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
+static void _dasd_requeue_request(struct dasd_ccw_req *cqr)
 {
-	struct dasd_block *block = cqr->block;
 	struct request *req;
 
-	if (!block)
-		return -EINVAL;
 	/*
 	 * If the request is an ERP request there is nothing to requeue.
 	 * This will be done with the remaining original request.
 	 */
 	if (cqr->refers)
-		return 0;
+		return;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, true);
 	spin_unlock_irq(&cqr->dq->lock);
 
-	return 0;
+	return;
 }
 
-/*
- * Go through all request on the dasd_block request queue, cancel them
- * on the respective dasd_device, and return them to the generic
- * block layer.
- */
-static int dasd_flush_block_queue(struct dasd_block *block)
+static int _dasd_requests_to_flushqueue(struct dasd_block *block,
+					struct list_head *flush_queue)
 {
 	struct dasd_ccw_req *cqr, *n;
-	int rc, i;
-	struct list_head flush_queue;
 	unsigned long flags;
+	int rc, i;
 
-	INIT_LIST_HEAD(&flush_queue);
-	spin_lock_bh(&block->queue_lock);
+	spin_lock_irqsave(&block->queue_lock, flags);
 	rc = 0;
 restart:
 	list_for_each_entry_safe(cqr, n, &block->ccw_queue, blocklist) {
@@ -2992,13 +2983,32 @@ static int dasd_flush_block_queue(struct dasd_block *block)
 		 * is returned from the dasd_device layer.
 		 */
 		cqr->callback = _dasd_wake_block_flush_cb;
-		for (i = 0; cqr != NULL; cqr = cqr->refers, i++)
-			list_move_tail(&cqr->blocklist, &flush_queue);
+		for (i = 0; cqr; cqr = cqr->refers, i++)
+			list_move_tail(&cqr->blocklist, flush_queue);
 		if (i > 1)
 			/* moved more than one request - need to restart */
 			goto restart;
 	}
-	spin_unlock_bh(&block->queue_lock);
+	spin_unlock_irqrestore(&block->queue_lock, flags);
+
+	return rc;
+}
+
+/*
+ * Go through all request on the dasd_block request queue, cancel them
+ * on the respective dasd_device, and return them to the generic
+ * block layer.
+ */
+static int dasd_flush_block_queue(struct dasd_block *block)
+{
+	struct dasd_ccw_req *cqr, *n;
+	struct list_head flush_queue;
+	unsigned long flags;
+	int rc;
+
+	INIT_LIST_HEAD(&flush_queue);
+	rc = _dasd_requests_to_flushqueue(block, &flush_queue);
+
 	/* Now call the callback function of flushed requests */
 restart_cb:
 	list_for_each_entry_safe(cqr, n, &flush_queue, blocklist) {
@@ -3881,75 +3891,36 @@ EXPORT_SYMBOL_GPL(dasd_generic_space_avail);
  */
 int dasd_generic_requeue_all_requests(struct dasd_device *device)
 {
+	struct dasd_block *block = device->block;
 	struct list_head requeue_queue;
 	struct dasd_ccw_req *cqr, *n;
-	struct dasd_ccw_req *refers;
 	int rc;
 
-	INIT_LIST_HEAD(&requeue_queue);
-	spin_lock_irq(get_ccwdev_lock(device->cdev));
-	rc = 0;
-	list_for_each_entry_safe(cqr, n, &device->ccw_queue, devlist) {
-		/* Check status and move request to flush_queue */
-		if (cqr->status == DASD_CQR_IN_IO) {
-			rc = device->discipline->term_IO(cqr);
-			if (rc) {
-				/* unable to terminate requeust */
-				dev_err(&device->cdev->dev,
-					"Unable to terminate request %p "
-					"on suspend\n", cqr);
-				spin_unlock_irq(get_ccwdev_lock(device->cdev));
-				dasd_put_device(device);
-				return rc;
-			}
-		}
-		list_move_tail(&cqr->devlist, &requeue_queue);
-	}
-	spin_unlock_irq(get_ccwdev_lock(device->cdev));
-
-	list_for_each_entry_safe(cqr, n, &requeue_queue, devlist) {
-		wait_event(dasd_flush_wq,
-			   (cqr->status != DASD_CQR_CLEAR_PENDING));
+	if (!block)
+		return 0;
 
-		/*
-		 * requeue requests to blocklayer will only work
-		 * for block device requests
-		 */
-		if (_dasd_requeue_request(cqr))
-			continue;
+	INIT_LIST_HEAD(&requeue_queue);
+	rc = _dasd_requests_to_flushqueue(block, &requeue_queue);
 
-		/* remove requests from device and block queue */
-		list_del_init(&cqr->devlist);
-		while (cqr->refers != NULL) {
-			refers = cqr->refers;
-			/* remove the request from the block queue */
-			list_del(&cqr->blocklist);
-			/* free the finished erp request */
-			dasd_free_erp_request(cqr, cqr->memdev);
-			cqr = refers;
+	/* Now call the callback function of flushed requests */
+restart_cb:
+	list_for_each_entry_safe(cqr, n, &requeue_queue, blocklist) {
+		wait_event(dasd_flush_wq, (cqr->status < DASD_CQR_QUEUED));
+		/* Process finished ERP request. */
+		if (cqr->refers) {
+			spin_lock_bh(&block->queue_lock);
+			__dasd_process_erp(block->base, cqr);
+			spin_unlock_bh(&block->queue_lock);
+			/* restart list_for_xx loop since dasd_process_erp
+			 * might remove multiple elements
+			 */
+			goto restart_cb;
 		}
-
-		/*
-		 * _dasd_requeue_request already checked for a valid
-		 * blockdevice, no need to check again
-		 * all erp requests (cqr->refers) have a cqr->block
-		 * pointer copy from the original cqr
-		 */
+		_dasd_requeue_request(cqr);
 		list_del_init(&cqr->blocklist);
 		cqr->block->base->discipline->free_cp(
 			cqr, (struct request *) cqr->callback_data);
 	}
-
-	/*
-	 * if requests remain then they are internal request
-	 * and go back to the device queue
-	 */
-	if (!list_empty(&requeue_queue)) {
-		/* move freeze_queue to start of the ccw_queue */
-		spin_lock_irq(get_ccwdev_lock(device->cdev));
-		list_splice_tail(&requeue_queue, &device->ccw_queue);
-		spin_unlock_irq(get_ccwdev_lock(device->cdev));
-	}
 	dasd_schedule_device_bh(device);
 	return rc;
 }
-- 
2.39.2

