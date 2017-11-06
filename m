Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] s390/dasd: avoid calling do_gettimeofday()
Date: Mon,  6 Nov 2017 15:02:41 +0100
Message-Id: <20171106140328.1498644-1-arnd@arndb.de>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Haberland <sth@linux.vnet.ibm.com>, Jan Hoeppner <hoeppner@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: Arnd Bergmann <arnd@arndb.de>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

do_gettimeofday() is deprecated because it's not y2038-safe on
32-bit architectures. Since it is basically a wrapper around
ktime_get_real_ts64(), we can just call that function directly
instead.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/s390/block/dasd_eer.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 4630782b5456..5169c717c9d6 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -296,7 +296,7 @@ static void dasd_eer_write_standard_trigger(struct dasd_device *device,
 {
 	struct dasd_ccw_req *temp_cqr;
 	int data_size;
-	struct timeval tv;
+	struct timespec64 ts64;
 	struct dasd_eer_header header;
 	unsigned long flags;
 	struct eerbuffer *eerb;
@@ -310,9 +310,9 @@ static void dasd_eer_write_standard_trigger(struct dasd_device *device,
 
 	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
 	header.trigger = trigger;
-	do_gettimeofday(&tv);
-	header.tv_sec = tv.tv_sec;
-	header.tv_usec = tv.tv_usec;
+	ktime_get_real_ts64(&ts);
+	header.tv_sec = ts.tv_sec;
+	header.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	strncpy(header.busid, dev_name(&device->cdev->dev),
 		DASD_EER_BUSID_SIZE);
 
@@ -340,7 +340,7 @@ static void dasd_eer_write_snss_trigger(struct dasd_device *device,
 {
 	int data_size;
 	int snss_rc;
-	struct timeval tv;
+	struct timespec64 ts;
 	struct dasd_eer_header header;
 	unsigned long flags;
 	struct eerbuffer *eerb;
@@ -353,9 +353,9 @@ static void dasd_eer_write_snss_trigger(struct dasd_device *device,
 
 	header.total_size = sizeof(header) + data_size + 4; /* "EOR" */
 	header.trigger = DASD_EER_STATECHANGE;
-	do_gettimeofday(&tv);
-	header.tv_sec = tv.tv_sec;
-	header.tv_usec = tv.tv_usec;
+	ktime_get_real_ts64(&ts);
+	header.tv_sec = ts.tv_sec;
+	header.tv_usec = ts.tv_nsec / NSEC_PER_USEC;
 	strncpy(header.busid, dev_name(&device->cdev->dev),
 		DASD_EER_BUSID_SIZE);
 
-- 
2.9.0
