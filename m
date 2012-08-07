Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 16/41] TTY: tty3270, free tty driver properly
Date: Tue,  7 Aug 2012 21:47:41 +0200
Message-Id: <1344368886-24033-17-git-send-email-jslaby@suse.cz>
In-Reply-To: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
References: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On module unload, in tty3270_exit, we forgot to free the tty driver.
Add there a call to put_tty_driver.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/tty3270.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index 1928f34..215037c 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -1800,6 +1800,7 @@ tty3270_exit(void)
 	driver = tty3270_driver;
 	tty3270_driver = NULL;
 	tty_unregister_driver(driver);
+	put_tty_driver(driver);
 	tty3270_del_views();
 }
 
-- 
1.7.10.4
