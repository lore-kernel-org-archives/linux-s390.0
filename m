Return-Path: <linux-mmc-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 19/25] staging: fwserial: Change return type to void
Date: Tue,  4 Sep 2018 11:44:45 +0900
Message-Id: <1536029091-4426-20-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-mmc-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/staging/fwserial/fwserial.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/staging/fwserial/fwserial.c b/drivers/staging/fwserial/fwserial.c
index fa0dd42..5134019 100644
--- a/drivers/staging/fwserial/fwserial.c
+++ b/drivers/staging/fwserial/fwserial.c
@@ -1064,27 +1064,21 @@ static void fwtty_cleanup(struct tty_struct *tty)
 static int fwtty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(tty->index);
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwloop_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct fwtty_port *port = fwtty_port_get(table_idx(tty->index));
-	int err;
 
-	err = tty_standard_install(driver, tty);
-	if (!err)
-		tty->driver_data = port;
-	else
-		fwtty_port_put(port);
-	return err;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+
+	return 0;
 }
 
 static int fwtty_write(struct tty_struct *tty, const unsigned char *buf, int c)
-- 
2.7.4
