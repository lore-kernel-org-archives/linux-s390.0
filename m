Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 07/25] tty: mips_ejtag_fdc: Change return type to void
Date: Tue,  4 Sep 2018 11:44:33 +0900
Message-Id: <1536029091-4426-8-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/mips_ejtag_fdc.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/mips_ejtag_fdc.c b/drivers/tty/mips_ejtag_fdc.c
index 4c1cd49..33e06b4 100644
--- a/drivers/tty/mips_ejtag_fdc.c
+++ b/drivers/tty/mips_ejtag_fdc.c
@@ -763,7 +763,9 @@ static int mips_ejtag_fdc_tty_install(struct tty_driver *driver,
 	struct mips_ejtag_fdc_tty *priv = driver->driver_state;
 
 	tty->driver_data = &priv->ports[tty->index];
-	return tty_port_install(&priv->ports[tty->index].port, driver, tty);
+	tty_port_install(&priv->ports[tty->index].port, driver, tty);
+
+	return 0;
 }
 
 static int mips_ejtag_fdc_tty_open(struct tty_struct *tty, struct file *filp)
-- 
2.7.4
