Return-Path: <netdev-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 25/25] usb: usb-serial: Change return type to void
Date: Tue,  4 Sep 2018 11:44:51 +0900
Message-Id: <1536029091-4426-26-git-send-email-climbbb.kim@gmail.com>
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
 drivers/usb/serial/usb-serial.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/usb/serial/usb-serial.c b/drivers/usb/serial/usb-serial.c
index f7aaa7f..5cfc2ca 100644
--- a/drivers/usb/serial/usb-serial.c
+++ b/drivers/usb/serial/usb-serial.c
@@ -192,9 +192,7 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 	if (retval)
 		goto error_get_interface;
 
-	retval = tty_standard_install(driver, tty);
-	if (retval)
-		goto error_init_termios;
+	tty_standard_install(driver, tty);
 
 	mutex_unlock(&serial->disc_mutex);
 
@@ -206,8 +204,6 @@ static int serial_install(struct tty_driver *driver, struct tty_struct *tty)
 
 	return retval;
 
- error_init_termios:
-	usb_autopm_put_interface(serial->interface);
  error_get_interface:
 	module_put(serial->type->driver.owner);
  error_module_get:
-- 
2.7.4
