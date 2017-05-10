Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: [PATCH 2/3] s390/dasd: Fix typos in two comment lines
From: SF Markus Elfring <elfring@users.sourceforge.net>
References: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Message-ID: <a37840d9-5e2f-f2da-176f-53beea1c69ae@users.sourceforge.net>
Date: Wed, 10 May 2017 20:02:16 +0200
MIME-Version: 1.0
In-Reply-To: <4af00744-1c8a-6b33-22c8-d26d569f6c5f@users.sourceforge.net>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Wed, 10 May 2017 19:19:19 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The script “checkpatch.pl” pointed information out like the following.

CHECK: '…' may be misspelled - perhaps '…'?

Thus fix two descriptions.

Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/block/dasd_eckd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index b3709d3cba54..e78601d97a67 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3863,7 +3863,7 @@ static struct dasd_ccw_req *dasd_raw_build_cp(struct dasd_device *startdev,
 	unsigned int pfx_datasize;
 
 	/*
-	 * raw track access needs to be mutiple of 64k and on 64k boundary
+	 * Raw track access needs to be multiple of 64k and on 64k boundary.
 	 * For read requests we can fix an incorrect alignment by padding
 	 * the request with dummy pages.
 	 */
@@ -4143,7 +4143,7 @@ dasd_eckd_fill_info(struct dasd_device * device,
 
 /*
  * Release device ioctl.
- * Buils a channel programm to releases a prior reserved
+ * Builds a channel program to release a prior reserved
  * (see dasd_eckd_reserve) device.
  */
 static int
-- 
2.12.3
