Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:34124 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2405838AbgFSQuh (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 19 Jun 2020 12:50:37 -0400
Date: Fri, 19 Jun 2020 11:56:00 -0500
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
Subject: [PATCH][next] s390/dasd: Use struct_size() helper
Message-ID: <20200619165600.GA8668@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>

Make use of the struct_size() helper instead of an open-coded version
in order to avoid any potential type mistakes. Also, remove unnecessary
variable _datasize_.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 drivers/s390/block/dasd_diag.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index facb588d09e4..7f53ba015300 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -506,7 +506,7 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	struct req_iterator iter;
 	struct bio_vec bv;
 	char *dst;
-	unsigned int count, datasize;
+	unsigned int count;
 	sector_t recid, first_rec, last_rec;
 	unsigned int blksize, off;
 	unsigned char rw_cmd;
@@ -534,10 +534,8 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
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
2.27.0
