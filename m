Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 32/41] TTY: con3215, unset raw3215[line]
Date: Tue,  7 Aug 2012 21:47:57 +0200
Message-Id: <1344368886-24033-33-git-send-email-jslaby@suse.cz>
In-Reply-To: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
References: <1344368886-24033-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

raw3215[line] is set in probe, but not unset in remove. This will lead
to random crashes if the device is removed and the corresponding tty
opened later. open would dereference freed memory.

So set raw3215[line] to NULL in remove to fix that.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c |    7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 6c0116d..1655498 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -716,10 +716,17 @@ static int raw3215_probe (struct ccw_device *cdev)
 static void raw3215_remove (struct ccw_device *cdev)
 {
 	struct raw3215_info *raw;
+	unsigned int line;
 
 	ccw_device_set_offline(cdev);
 	raw = dev_get_drvdata(&cdev->dev);
 	if (raw) {
+		spin_lock(&raw3215_device_lock);
+		for (line = 0; line < NR_3215; line++)
+			if (raw3215[line] == raw)
+				break;
+		raw3215[line] = NULL;
+		spin_unlock(&raw3215_device_lock);
 		dev_set_drvdata(&cdev->dev, NULL);
 		raw3215_free_info(raw);
 	}
-- 
1.7.10.4
