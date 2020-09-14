Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:3874 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726180AbgINMRQ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 14 Sep 2020 08:17:16 -0400
From: Stefan Haberland <sth@linux.ibm.com>
Subject: [PATCH 1/1] s390/dasd: Fix zero write for FBA devices
Date: Mon, 14 Sep 2020 13:56:47 +0200
Message-Id: <20200914115647.94062-2-sth@linux.ibm.com>
In-Reply-To: <20200914115647.94062-1-sth@linux.ibm.com>
References: <20200914115647.94062-1-sth@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, hoeppner@linux.ibm.com, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, gor@linux.ibm.com, borntraeger@de.ibm.com

From: Jan Höppner <hoeppner@linux.ibm.com>

A discard request that writes zeros using the global kernel internal
ZERO_PAGE will fail for machines with more than 2GB of memory due to the
location of the ZERO_PAGE.

Fix this by using a driver owned global zero page allocated with GFP_DMA
flag set.

Fixes: 28b841b3a7cb ("s390/dasd: Add discard support for FBA devices")
Cc: <stable@vger.kernel.org> # 4.14+
Signed-off-by: Jan Höppner <hoeppner@linux.ibm.com>
Reviewed-by: Stefan Haberland <sth@linux.ibm.com>
---
 drivers/s390/block/dasd_fba.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index cbb770824226..1a44e321b54e 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -40,6 +40,7 @@
 MODULE_LICENSE("GPL");
 
 static struct dasd_discipline dasd_fba_discipline;
+static void *dasd_fba_zero_page;
 
 struct dasd_fba_private {
 	struct dasd_fba_characteristics rdc_data;
@@ -270,7 +271,7 @@ static void ccw_write_zero(struct ccw1 *ccw, int count)
 	ccw->cmd_code = DASD_FBA_CCW_WRITE;
 	ccw->flags |= CCW_FLAG_SLI;
 	ccw->count = count;
-	ccw->cda = (__u32) (addr_t) page_to_phys(ZERO_PAGE(0));
+	ccw->cda = (__u32) (addr_t) dasd_fba_zero_page;
 }
 
 /*
@@ -830,6 +831,11 @@ dasd_fba_init(void)
 	int ret;
 
 	ASCEBC(dasd_fba_discipline.ebcname, 4);
+
+	dasd_fba_zero_page = (void *)get_zeroed_page(GFP_KERNEL | GFP_DMA);
+	if (!dasd_fba_zero_page)
+		return -ENOMEM;
+
 	ret = ccw_driver_register(&dasd_fba_driver);
 	if (!ret)
 		wait_for_device_probe();
@@ -841,6 +847,7 @@ static void __exit
 dasd_fba_cleanup(void)
 {
 	ccw_driver_unregister(&dasd_fba_driver);
+	free_page((unsigned long)dasd_fba_zero_page);
 }
 
 module_init(dasd_fba_init);
-- 
2.17.1
