Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:16520 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729713AbgGNUGM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 14 Jul 2020 16:06:12 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 2/2] s390/dasd: Use struct_size() helper
Date: Tue, 14 Jul 2020 22:03:27 +0200
Message-Id: <20200714200327.40927-3-sth@linux.ibm.com>
In-Reply-To: <20200714200327.40927-1-sth@linux.ibm.com>
References: <20200714200327.40927-1-sth@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: "Gustavo A. R. Silva" <gustavoars@kernel.org>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _datasize_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_diag.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 069d6b39cacf..1b9e1442e6a5 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -515,7 +515,7 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	char *dst;
-	unsigned int count, datasize;
+	unsigned int count;
 	sector_t recid, first_rec, last_rec;
 	unsigned int blksize, off;
 	unsigned char rw_cmd;
@@ -543,10 +543,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	if (count != last_rec - first_rec + 1)
 		return ERR_PTR(-EINVAL);
 	/* Build the request */
-	datasize = sizeof(struct dasd_diag_req) +
-		count*sizeof(struct dasd_diag_bio);
-	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, datasize, memdev,
-				   blk_mq_rq_to_pdu(req));
+	cqr = dasd_smalloc_request(DASD_DIAG_MAGIC, 0, struct_size(dreq, bio, count),
+				   memdev, blk_mq_rq_to_pdu(req));
 	if (IS_ERR(cqr))
 		return cqr;
 
-- 
2.17.1
