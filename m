Return-Path: <linux-mmc-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 15/25] um: Change return type to void
Date: Tue,  4 Sep 2018 11:44:41 +0900
Message-Id: <1536029091-4426-16-git-send-email-climbbb.kim@gmail.com>
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
 arch/um/drivers/line.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/arch/um/drivers/line.c b/arch/um/drivers/line.c
index 8d80b27..47058cf 100644
--- a/arch/um/drivers/line.c
+++ b/arch/um/drivers/line.c
@@ -338,12 +338,7 @@ int line_open(struct tty_struct *tty, struct file *filp)
 int line_install(struct tty_driver *driver, struct tty_struct *tty,
 		 struct line *line)
 {
-	int ret;
-
-	ret = tty_standard_install(driver, tty);
-	if (ret)
-		return ret;
-
+	tty_standard_install(driver, tty);
 	tty->driver_data = line;
 
 	return 0;
-- 
2.7.4
