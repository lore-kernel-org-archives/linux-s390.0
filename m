Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 22/25] tty: nozomi: Change return type to void
Date: Tue,  4 Sep 2018 11:44:48 +0900
Message-Id: <1536029091-4426-23-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_standard_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/nozomi.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/nozomi.c b/drivers/tty/nozomi.c
index fed820e..479583d 100644
--- a/drivers/tty/nozomi.c
+++ b/drivers/tty/nozomi.c
@@ -1555,13 +1555,11 @@ static int ntty_install(struct tty_driver *driver, struct tty_struct *tty)
 {
 	struct port *port = get_port_by_tty(tty);
 	struct nozomi *dc = get_dc_by_tty(tty);
-	int ret;
 	if (!port || !dc || dc->state != NOZOMI_STATE_READY)
 		return -ENODEV;
-	ret = tty_standard_install(driver, tty);
-	if (ret == 0)
-		tty->driver_data = port;
-	return ret;
+	tty_standard_install(driver, tty);
+	tty->driver_data = port;
+	return 0;
 }
 
 static void ntty_cleanup(struct tty_struct *tty)
-- 
2.7.4
