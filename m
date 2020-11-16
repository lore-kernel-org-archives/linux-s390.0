Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:65316 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731076AbgKPPXz (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 16 Nov 2020 10:23:55 -0500
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390/dasd: fix null pointer dereference for ERP requests
Date: Mon, 16 Nov 2020 16:23:47 +0100
Message-Id: <20201116152347.61093-2-sth@linux.ibm.com>
In-Reply-To: <20201116152347.61093-1-sth@linux.ibm.com>
References: <20201116152347.61093-1-sth@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

When requeueing all requests on the device request queue to the blocklayer
we might get to an ERP (error recovery) request that is a copy of an
original CQR.

Those requests do not have blocklayer request information or a pointer to
the dasd_queue set. When trying to access those data it will lead to a
null pointer dereference in dasd_requeue_all_requests().

Fix by checking if the request is an ERP request that can simply be
ignored. The blocklayer request will be requeued by the original CQR that
is on the device queue right behind the ERP request.

Fixes: 9487cfd3430d ("s390/dasd: fix handling of internal requests")

Cc: <stable@vger.kernel.org> #4.16
Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c..217a7b84abdf 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -2980,6 +2980,12 @@ static int _dasd_requeue_request(struct dasd_ccw_req *cqr)
 
 	if (!block)
 		return -EINVAL;
+	/*
+	 * If the request is an ERP request there is nothing to requeue.
+	 * This will be done with the remaining original request.
+	 */
+	if (cqr->refers)
+		return 0;
 	spin_lock_irq(&cqr->dq->lock);
 	req = (struct request *) cqr->callback_data;
 	blk_mq_requeue_request(req, false);
-- 
2.17.1
