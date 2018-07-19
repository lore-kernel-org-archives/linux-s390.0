Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Wed, 18 Jul 2018 23:42:05 -0500
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] s390/ap_bus: replace PTR_RET with PTR_ERR_OR_ZERO
Message-ID: <20180719044205.GA24764@embeddedor.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Harald Freudenberger <freude@linux.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, "Gustavo A. R. Silva" <gustavo@embeddedor.com>
List-ID: <linux-s390.vger.kernel.org>

PTR_RET is deprecated, use PTR_ERR_OR_ZERO instead.

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/s390/crypto/ap_bus.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
index c0a6723..bf27fc4 100644
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -474,7 +474,7 @@ static int ap_poll_thread_start(void)
 		return 0;
 	mutex_lock(&ap_poll_thread_mutex);
 	ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
-	rc = PTR_RET(ap_poll_kthread);
+	rc = PTR_ERR_OR_ZERO(ap_poll_kthread);
 	if (rc)
 		ap_poll_kthread = NULL;
 	mutex_unlock(&ap_poll_thread_mutex);
@@ -1242,7 +1242,7 @@ static int __init ap_module_init(void)
 
 	/* Create /sys/devices/ap. */
 	ap_root_device = root_device_register("ap");
-	rc = PTR_RET(ap_root_device);
+	rc = PTR_ERR_OR_ZERO(ap_root_device);
 	if (rc)
 		goto out_bus;
 
-- 
2.7.4
