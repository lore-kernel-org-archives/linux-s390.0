Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <1370080273.29224.21.camel@localhost.localdomain>
Subject: [PATCH] s390/ap: Cocci spatch "ptr_ret.spatch"
From: Thomas Meyer <thomas@m3y3r.de>
Date: Sat, 01 Jun 2013 11:51:13 +0200
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>


Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---

diff -u -p a/drivers/s390/crypto/ap_bus.c b/drivers/s390/crypto/ap_bus.c
--- a/drivers/s390/crypto/ap_bus.c
+++ b/drivers/s390/crypto/ap_bus.c
@@ -1795,7 +1795,7 @@ static int ap_poll_thread_start(void)
 	mutex_lock(&ap_poll_thread_mutex);
 	if (!ap_poll_kthread) {
 		ap_poll_kthread = kthread_run(ap_poll_thread, NULL, "appoll");
-		rc = IS_ERR(ap_poll_kthread) ? PTR_ERR(ap_poll_kthread) : 0;
+		rc = PTR_RET(ap_poll_kthread);
 		if (rc)
 			ap_poll_kthread = NULL;
 	}
@@ -1904,7 +1904,7 @@ int __init ap_module_init(void)
 
 	/* Create /sys/devices/ap. */
 	ap_root_device = root_device_register("ap");
-	rc = IS_ERR(ap_root_device) ? PTR_ERR(ap_root_device) : 0;
+	rc = PTR_RET(ap_root_device);
 	if (rc)
 		goto out_bus;
 
