Return-Path: <netdev-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 17/25] misc: pti: Change return type to void
Date: Tue,  4 Sep 2018 11:44:43 +0900
Message-Id: <1536029091-4426-18-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/misc/pti.c | 28 +++++++++++++---------------
 1 file changed, 13 insertions(+), 15 deletions(-)

diff --git a/drivers/misc/pti.c b/drivers/misc/pti.c
index 41f2a9f..5c885a1 100644
--- a/drivers/misc/pti.c
+++ b/drivers/misc/pti.c
@@ -462,26 +462,24 @@ static int pti_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	int idx = tty->index;
 	struct pti_tty *pti_tty_data;
-	int ret = tty_standard_install(driver, tty);
 
-	if (ret == 0) {
-		pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
-		if (pti_tty_data == NULL)
-			return -ENOMEM;
+	tty_standard_install(driver, tty);
+	pti_tty_data = kmalloc(sizeof(struct pti_tty), GFP_KERNEL);
+	if (pti_tty_data == NULL)
+		return -ENOMEM;
 
-		if (idx == PTITTY_MINOR_START)
-			pti_tty_data->mc = pti_request_masterchannel(0, NULL);
-		else
-			pti_tty_data->mc = pti_request_masterchannel(2, NULL);
+	if (idx == PTITTY_MINOR_START)
+		pti_tty_data->mc = pti_request_masterchannel(0, NULL);
+	else
+		pti_tty_data->mc = pti_request_masterchannel(2, NULL);
 
-		if (pti_tty_data->mc == NULL) {
-			kfree(pti_tty_data);
-			return -ENXIO;
-		}
-		tty->driver_data = pti_tty_data;
+	if (pti_tty_data->mc == NULL) {
+		kfree(pti_tty_data);
+		return -ENXIO;
 	}
+	tty->driver_data = pti_tty_data;
 
-	return ret;
+	return 0;
 }
 
 /**
-- 
2.7.4
