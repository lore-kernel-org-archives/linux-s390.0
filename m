Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
Subject: [PATCH] s390: block: dasd_eer.c:  Cleaning up missing null-terminate in conjunction with strncpy
Date: Sat, 26 Jul 2014 16:29:12 +0200
Message-Id: <1406384952-2857-1-git-send-email-rickard_strandqvist@spectrumdigital.se>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Stefan Weinhuber <wein@de.ibm.com>, Stefan Haberland <stefan.haberland@de.ibm.com>
Cc: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Replacing strncpy with strlcpy to avoid strings that lacks null terminate.

Signed-off-by: Rickard Strandqvist <rickard_strandqvist@spectrumdigital.se>
---
 drivers/s390/block/dasd_eer.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/block/dasd_eer.c b/drivers/s390/block/dasd_eer.c
index 21ef63c..666dbd0 100644
--- a/drivers/s390/block/dasd_eer.c
+++ b/drivers/s390/block/dasd_eer.c
@@ -312,7 +312,7 @@ static void dasd_eer_write_standard_trigger(struct dasd_device *device,
 	do_gettimeofday(&tv);
 	header.tv_sec = tv.tv_sec;
 	header.tv_usec = tv.tv_usec;
-	strncpy(header.busid, dev_name(&device->cdev->dev),
+	strlcpy(header.busid, dev_name(&device->cdev->dev),
 		DASD_EER_BUSID_SIZE);
 
 	spin_lock_irqsave(&bufferlock, flags);
@@ -355,7 +355,7 @@ static void dasd_eer_write_snss_trigger(struct dasd_device *device,
 	do_gettimeofday(&tv);
 	header.tv_sec = tv.tv_sec;
 	header.tv_usec = tv.tv_usec;
-	strncpy(header.busid, dev_name(&device->cdev->dev),
+	strlcpy(header.busid, dev_name(&device->cdev->dev),
 		DASD_EER_BUSID_SIZE);
 
 	spin_lock_irqsave(&bufferlock, flags);
-- 
1.7.10.4
