Return-Path: <linux-kernel-owner@vger.kernel.org>
From: SF Markus Elfring <elfring@users.sourceforge.net>
Subject: [PATCH] S390-DASD: Delete an error message for a failed memory
 allocation in two functions
Message-ID: <5708cda3-991c-e05c-85c4-5b2199395bb4@users.sourceforge.net>
Date: Tue, 16 May 2017 15:36:34 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, =?UTF-8?Q?Jan_H=c3=b6ppner?= <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Stefan Haberland <sth@linux.vnet.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org, Wolfram Sang <wsa@the-dreams.de>
List-ID: <linux-s390.vger.kernel.org>

From: Markus Elfring <elfring@users.sourceforge.net>
Date: Tue, 16 May 2017 15:30:44 +0200

Omit an extra message for a memory allocation failure in this function.

This issue was detected by using the Coccinelle software.

Link: http://events.linuxfoundation.org/sites/events/files/slides/LCJ16-Refactor_Strings-WSang_0.pdf
Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
---
 drivers/s390/block/dasd_eckd.c | 7 ++-----
 drivers/s390/block/dasd_fba.c  | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 122456e4db89..99c73decae49 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -1721,12 +1721,9 @@ dasd_eckd_check_characteristics(struct dasd_device *device)
 	}
 	if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
-		if (!private) {
-			dev_warn(&device->cdev->dev,
-				 "Allocating memory for private DASD data "
-				 "failed\n");
+		if (!private)
 			return -ENOMEM;
-		}
+
 		device->private = private;
 	} else {
 		memset(private, 0, sizeof(*private));
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 462cab5d4302..2b2f9b0da5c2 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -132,12 +132,9 @@ dasd_fba_check_characteristics(struct dasd_device *device)
 
 	if (!private) {
 		private = kzalloc(sizeof(*private), GFP_KERNEL | GFP_DMA);
-		if (!private) {
-			dev_warn(&device->cdev->dev,
-				 "Allocating memory for private DASD "
-				 "data failed\n");
+		if (!private)
 			return -ENOMEM;
-		}
+
 		device->private = private;
 	} else {
 		memset(private, 0, sizeof(*private));
-- 
2.13.0
