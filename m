Return-Path: <linux-usb-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 06/25] tty: hvc: hvcs: Change return type to void
Date: Tue,  4 Sep 2018 11:44:32 +0900
Message-Id: <1536029091-4426-7-git-send-email-climbbb.kim@gmail.com>
In-Reply-To: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
References: <1536029091-4426-1-git-send-email-climbbb.kim@gmail.com>
Sender: linux-usb-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-bluetooth/>
List-Post: <mailto:linux-bluetooth@vger.kernel.org>
To: linux-um@lists.infradead.org, netdev@vger.kernel.org, linux-mmc@vger.kernel.org, linux-s390@vger.kernel.org, devel@driverdev.osuosl.org, greybus-dev@lists.linaro.org, linuxppc-dev@lists.ozlabs.org, linux-serial@vger.kernel.org, sparclinux@vger.kernel.org, linux-usb@vger.kernel.org, linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Jiri Slaby <jslaby@suse.com>
List-ID: <linux-s390.vger.kernel.org>

Since tty_port_install() always returns 0, the return type has changed
to void. Now apply this and remove the obsolete error check.

Signed-off-by: Jaejoong Kim <climbbb.kim@gmail.com>
---
 drivers/tty/hvc/hvcs.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/drivers/tty/hvc/hvcs.c b/drivers/tty/hvc/hvcs.c
index cb4db1b..4dfa70c 100644
--- a/drivers/tty/hvc/hvcs.c
+++ b/drivers/tty/hvc/hvcs.c
@@ -1140,16 +1140,10 @@ static int hvcs_install(struct tty_driver *driver, struct tty_struct *tty)
 		goto err_put;
 	}
 
-	retval = tty_port_install(&hvcsd->port, driver, tty);
-	if (retval)
-		goto err_irq;
+	tty_port_install(&hvcsd->port, driver, tty);
 
 	return 0;
-err_irq:
-	spin_lock_irqsave(&hvcsd->lock, flags);
-	vio_disable_interrupts(hvcsd->vdev);
-	spin_unlock_irqrestore(&hvcsd->lock, flags);
-	free_irq(irq, hvcsd);
+
 err_put:
 	tty_port_put(&hvcsd->port);
 
-- 
2.7.4
