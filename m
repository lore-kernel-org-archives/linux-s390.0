Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Himanshu Jha <himanshujha199640@gmail.com>
Subject: [PATCH] s390/sclp: Use setup_timer and mod_timer
Date: Sun, 24 Sep 2017 17:30:14 +0530
Message-Id: <1506254414-10269-1-git-send-email-himanshujha199640@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: schwidefsky@de.ibm.com
Cc: heiko.carstens@de.ibm.com, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org, Himanshu Jha <himanshujha199640@gmail.com>
List-ID: <linux-s390.vger.kernel.org>

Use setup_timer and mod_timer API instead of structure assignments.

This is done using Coccinelle and semantic patch used
for this as follows:

@@
expression x,y,z,a,b;
@@

-init_timer (&x);
+setup_timer (&x, y, z);
+mod_timer (&a, b);
-x.function = y;
-x.data = z;
-x.expires = b;
-add_timer(&a);

Signed-off-by: Himanshu Jha <himanshujha199640@gmail.com>
---
 drivers/s390/char/sclp_con.c | 7 ++-----
 drivers/s390/char/sclp_tty.c | 7 ++-----
 2 files changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/sclp_con.c b/drivers/s390/char/sclp_con.c
index 6037bc8..9b5ac8f 100644
--- a/drivers/s390/char/sclp_con.c
+++ b/drivers/s390/char/sclp_con.c
@@ -210,11 +210,8 @@ sclp_console_write(struct console *console, const char *message,
 	/* Setup timer to output current console buffer after 1/10 second */
 	if (sclp_conbuf != NULL && sclp_chars_in_buffer(sclp_conbuf) != 0 &&
 	    !timer_pending(&sclp_con_timer)) {
-		init_timer(&sclp_con_timer);
-		sclp_con_timer.function = sclp_console_timeout;
-		sclp_con_timer.data = 0UL;
-		sclp_con_timer.expires = jiffies + HZ/10;
-		add_timer(&sclp_con_timer);
+		setup_timer(&sclp_con_timer, sclp_console_timeout, 0UL);
+		mod_timer(&sclp_con_timer, jiffies + HZ / 10);
 	}
 out:
 	spin_unlock_irqrestore(&sclp_con_lock, flags);
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 236b736..469487e 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -217,11 +217,8 @@ static int sclp_tty_write_string(const unsigned char *str, int count, int may_fa
 	/* Setup timer to output current console buffer after 1/10 second */
 	if (sclp_ttybuf && sclp_chars_in_buffer(sclp_ttybuf) &&
 	    !timer_pending(&sclp_tty_timer)) {
-		init_timer(&sclp_tty_timer);
-		sclp_tty_timer.function = sclp_tty_timeout;
-		sclp_tty_timer.data = 0UL;
-		sclp_tty_timer.expires = jiffies + HZ/10;
-		add_timer(&sclp_tty_timer);
+		setup_timer(&sclp_tty_timer, sclp_tty_timeout, 0UL);
+		mod_timer(&sclp_tty_timer, jiffies + HZ / 10);
 	}
 	spin_unlock_irqrestore(&sclp_tty_lock, flags);
 out:
-- 
2.7.4
