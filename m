Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jaejoong Kim <climbbb.kim@gmail.com>
Subject: [PATCH 08/25] tty: n_gsm: Change return type to void
Date: Tue,  4 Sep 2018 11:44:34 +0900
Message-Id: <1536029091-4426-9-git-send-email-climbbb.kim@gmail.com>
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
 drivers/tty/n_gsm.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 86b7e20..c52fa2d 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -2917,7 +2917,6 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 	unsigned int line = tty->index;
 	unsigned int mux = line >> 6;
 	bool alloc = false;
-	int ret;
 
 	line = line & 0x3F;
 
@@ -2949,14 +2948,8 @@ static int gsmtty_install(struct tty_driver *driver, struct tty_struct *tty)
 		mutex_unlock(&gsm->mutex);
 		return -ENOMEM;
 	}
-	ret = tty_port_install(&dlci->port, driver, tty);
-	if (ret) {
-		if (alloc)
-			dlci_put(dlci);
-		mutex_unlock(&gsm->mutex);
-		return ret;
-	}
 
+	tty_port_install(&dlci->port, driver, tty);
 	dlci_get(dlci);
 	dlci_get(gsm->dlci[0]);
 	mux_get(gsm);
-- 
2.7.4
