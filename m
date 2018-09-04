Return-Path: <linux-serial-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 20/25] staging: gdm724x: gdm_tty: Change return type to void
Date: Tue,  4 Sep 2018 11:44:46 +0900
Message-Id: <1536029091-4426-21-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-serial-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/staging/gdm724x/gdm_tty.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/staging/gdm724x/gdm_tty.c b/drivers/staging/gdm724x/gdm_tty.c
index 6e81369..d6348df 100644
--- a/drivers/staging/gdm724x/gdm_tty.c
+++ b/drivers/staging/gdm724x/gdm_tty.c
@@ -62,6 +62,7 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 		return -ENODEV;
 
 	mutex_lock(&gdm_table_lock);
+
 	gdm = gdm_table[ret][tty->index];
 	if (!gdm) {
 		mutex_unlock(&gdm_table_lock);
@@ -69,15 +70,9 @@ static int gdm_tty_install(struct tty_driver *driver, struct tty_struct *tty)
 	}
 
 	tty_port_get(&gdm->port);
-
-	ret = tty_standard_install(driver, tty);
-	if (ret) {
-		tty_port_put(&gdm->port);
-		mutex_unlock(&gdm_table_lock);
-		return ret;
-	}
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = gdm;
+
 	mutex_unlock(&gdm_table_lock);
 
 	return 0;
-- 
2.7.4
