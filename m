Return-Path: <netdev-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 01/25] tty: Change return type to void
Date: Tue,  4 Sep 2018 11:44:27 +0900
Message-Id: <1536029091-4426-2-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Many drivers with tty use the tty_stand_install(). But, there is no
need to handle the error, since it always returns 0. So, change the
return type of tty_standard_install() and tty_port_install() to void
type and remove unnecessary exception handling where we use these
functions.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/tty_io.c   | 10 ++++++----
 drivers/tty/tty_port.c |  4 ++--
 include/linux/tty.h    |  4 ++--
 3 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 32bc3e3..b01cec8 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -1196,13 +1196,12 @@ void tty_init_termios(struct tty_struct *tty)
 }
 EXPORT_SYMBOL_GPL(tty_init_termios);
 
-int tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
+void tty_standard_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	tty_init_termios(tty);
 	tty_driver_kref_get(driver);
 	tty->count++;
 	driver->ttys[tty->index] = tty;
-	return 0;
 }
 EXPORT_SYMBOL_GPL(tty_standard_install);
 
@@ -1221,8 +1220,11 @@ EXPORT_SYMBOL_GPL(tty_standard_install);
 static int tty_driver_install_tty(struct tty_driver *driver,
 						struct tty_struct *tty)
 {
-	return driver->ops->install ? driver->ops->install(driver, tty) :
-		tty_standard_install(driver, tty);
+	if (driver->ops->install)
+		return driver->ops->install(driver, tty);
+
+	tty_standard_install(driver, tty);
+	return 0;
 }
 
 /**
diff --git a/drivers/tty/tty_port.c b/drivers/tty/tty_port.c
index 25d7368..fd8d40d 100644
--- a/drivers/tty/tty_port.c
+++ b/drivers/tty/tty_port.c
@@ -656,11 +656,11 @@ EXPORT_SYMBOL(tty_port_close);
  * to a concrete tty specified by @tty. Use this or tty_port_register_device
  * (or both). Call tty_port_link_device as a last resort.
  */
-int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 		struct tty_struct *tty)
 {
 	tty->port = port;
-	return tty_standard_install(driver, tty);
+	tty_standard_install(driver, tty);
 }
 EXPORT_SYMBOL_GPL(tty_port_install);
 
diff --git a/include/linux/tty.h b/include/linux/tty.h
index c56e397..63cdac1 100644
--- a/include/linux/tty.h
+++ b/include/linux/tty.h
@@ -556,7 +556,7 @@ extern struct tty_struct *tty_init_dev(struct tty_driver *driver, int idx);
 extern void tty_release_struct(struct tty_struct *tty, int idx);
 extern int tty_release(struct inode *inode, struct file *filp);
 extern void tty_init_termios(struct tty_struct *tty);
-extern int tty_standard_install(struct tty_driver *driver,
+extern void tty_standard_install(struct tty_driver *driver,
 		struct tty_struct *tty);
 
 extern struct mutex tty_mutex;
@@ -688,7 +688,7 @@ extern int tty_port_close_start(struct tty_port *port,
 extern void tty_port_close_end(struct tty_port *port, struct tty_struct *tty);
 extern void tty_port_close(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
-extern int tty_port_install(struct tty_port *port, struct tty_driver *driver,
+extern void tty_port_install(struct tty_port *port, struct tty_driver *driver,
 				struct tty_struct *tty);
 extern int tty_port_open(struct tty_port *port,
 				struct tty_struct *tty, struct file *filp);
-- 
2.7.4
