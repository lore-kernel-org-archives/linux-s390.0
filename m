Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 31/69] TTY: tty3270, move initialization to allocation
Date: Mon,  2 Apr 2012 13:54:15 +0200
Message-Id: <1333367693-3244-32-git-send-email-jslaby@suse.cz>
In-Reply-To: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
References: <1333367693-3244-1-git-send-email-jslaby@suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: gregkh@linuxfoundation.org
Cc: alan@linux.intel.com, linux-kernel@vger.kernel.org, jirislaby@gmail.com, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux390@de.ibm.com, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Let us initialize all the tty3270's members at the place where the
structure is allocated.

It cleans up tty->ops->open a bit.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/tty3270.c |   20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/char/tty3270.c b/drivers/s390/char/tty3270.c
index b43445a..f3837da 100644
--- a/drivers/s390/char/tty3270.c
+++ b/drivers/s390/char/tty3270.c
@@ -690,6 +690,16 @@ tty3270_alloc_view(void)
 	if (!tp->freemem_pages)
 		goto out_tp;
 	INIT_LIST_HEAD(&tp->freemem);
+	INIT_LIST_HEAD(&tp->lines);
+	INIT_LIST_HEAD(&tp->update);
+	INIT_LIST_HEAD(&tp->rcl_lines);
+	tp->rcl_max = 20;
+	setup_timer(&tp->timer, (void (*)(unsigned long)) tty3270_update,
+		    (unsigned long) tp);
+	tasklet_init(&tp->readlet,
+		     (void (*)(unsigned long)) tty3270_read_tasklet,
+		     (unsigned long) tp->read);
+
 	for (pages = 0; pages < TTY3270_STRING_PAGES; pages++) {
 		tp->freemem_pages[pages] = (void *)
 			__get_free_pages(GFP_KERNEL|GFP_DMA, 0);
@@ -879,16 +889,6 @@ tty3270_open(struct tty_struct *tty, struct file * filp)
 	if (IS_ERR(tp))
 		return PTR_ERR(tp);
 
-	INIT_LIST_HEAD(&tp->lines);
-	INIT_LIST_HEAD(&tp->update);
-	INIT_LIST_HEAD(&tp->rcl_lines);
-	tp->rcl_max = 20;
-	setup_timer(&tp->timer, (void (*)(unsigned long)) tty3270_update,
-		    (unsigned long) tp);
-	tasklet_init(&tp->readlet, 
-		     (void (*)(unsigned long)) tty3270_read_tasklet,
-		     (unsigned long) tp->read);
-
 	rc = raw3270_add_view(&tp->view, &tty3270_fn,
 			      tty->index + RAW3270_FIRSTMINOR);
 	if (rc) {
-- 
1.7.9.2
