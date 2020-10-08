Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:31828 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729756AbgJHNNn (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 8 Oct 2020 09:13:43 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH v2 04/10] s390/dasd: Remove unused parameter from dasd_generic_probe()
Date: Thu,  8 Oct 2020 15:13:30 +0200
Message-Id: <20201008131336.61100-5-sth@linux.ibm.com>
In-Reply-To: <20201008131336.61100-1-sth@linux.ibm.com>
References: <20201008131336.61100-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Jan Hoeppner <hoeppner@linux.ibm.com>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>

From: Jan Höppner <hoeppner@linux.ibm.com>

The discipline argument in dasd_generic_probe() isn't used and there is
no history how it was used in the past. Remove it.

Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd.c      | 3 +--
 drivers/s390/block/dasd_eckd.c | 2 +-
 drivers/s390/block/dasd_fba.c  | 2 +-
 drivers/s390/block/dasd_int.h  | 2 +-
 4 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/block/dasd.c b/drivers/s390/block/dasd.c
index eb17fea8075c..9a0300d2e744 100644
--- a/drivers/s390/block/dasd.c
+++ b/drivers/s390/block/dasd.c
@@ -3465,8 +3465,7 @@ static void dasd_generic_auto_online(void *data, async_cookie_t cookie)
  * Initial attempt at a probe function. this can be simplified once
  * the other detection code is gone.
  */
-int dasd_generic_probe(struct ccw_device *cdev,
-		       struct dasd_discipline *discipline)
+int dasd_generic_probe(struct ccw_device *cdev)
 {
 	int ret;
 
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index ad44d22e8859..2b39d2a5965f 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -143,7 +143,7 @@ dasd_eckd_probe (struct ccw_device *cdev)
 				"ccw-device options");
 		return ret;
 	}
-	ret = dasd_generic_probe(cdev, &dasd_eckd_discipline);
+	ret = dasd_generic_probe(cdev);
 	return ret;
 }
 
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 1a44e321b54e..5b0ebf6bf20f 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -58,7 +58,7 @@ static struct ccw_driver dasd_fba_driver; /* see below */
 static int
 dasd_fba_probe(struct ccw_device *cdev)
 {
-	return dasd_generic_probe(cdev, &dasd_fba_discipline);
+	return dasd_generic_probe(cdev);
 }
 
 static int
diff --git a/drivers/s390/block/dasd_int.h b/drivers/s390/block/dasd_int.h
index fa552f9f1666..6dce9d4c55ce 100644
--- a/drivers/s390/block/dasd_int.h
+++ b/drivers/s390/block/dasd_int.h
@@ -774,7 +774,7 @@ void dasd_block_set_timer(struct dasd_block *, int);
 void dasd_block_clear_timer(struct dasd_block *);
 int  dasd_cancel_req(struct dasd_ccw_req *);
 int dasd_flush_device_queue(struct dasd_device *);
-int dasd_generic_probe (struct ccw_device *, struct dasd_discipline *);
+int dasd_generic_probe(struct ccw_device *);
 void dasd_generic_free_discipline(struct dasd_device *);
 void dasd_generic_remove (struct ccw_device *cdev);
 int dasd_generic_set_online(struct ccw_device *, struct dasd_discipline *);
-- 
2.17.1
