Return-Path: <linux-kernel-owner+w=401wt.eu-S1765584AbYEFQGB@vger.kernel.org>
Message-Id: <20080506155112.537584495@de.ibm.com>
References: <20080506155027.974409738@de.ibm.com>
Date: Tue, 06 May 2008 17:50:34 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 7/8] tty3270: fix put_char fail/success conversion.
Content-Disposition: inline; filename=007-tty3270-fix.diff
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Alan Cox <alan@redhat.com>, Peter Oberparleiter <peter.oberparleiter@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Heiko Carstens <heiko.carstens@de.ibm.com>

The wrong function got coverted ;)

  CC      drivers/s390/char/tty3270.o
drivers/s390/char/tty3270.c:1747:
 warning: initialization from incompatible pointer type

Cc: Alan Cox <alan@redhat.com>
Cc: Peter Oberparleiter <peter.oberparleiter@de.ibm.com>
Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 drivers/s390/char/tty3270.c |   15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

Index: quilt-2.6/drivers/s390/char/tty3270.c
===================================================================
--- quilt-2.6.orig/drivers/s390/char/tty3270.c
+++ quilt-2.6/drivers/s390/char/tty3270.c
@@ -965,8 +965,7 @@ tty3270_write_room(struct tty_struct *tt
  * Insert character into the screen at the current position with the
  * current color and highlight. This function does NOT do cursor movement.
  */
-static int
-tty3270_put_character(struct tty3270 *tp, char ch)
+static void tty3270_put_character(struct tty3270 *tp, char ch)
 {
 	struct tty3270_line *line;
 	struct tty3270_cell *cell;
@@ -986,7 +985,6 @@ tty3270_put_character(struct tty3270 *tp
 	cell->character = tp->view.ascebc[(unsigned int) ch];
 	cell->highlight = tp->highlight;
 	cell->f_color = tp->f_color;
-	return 1;
 }
 
 /*
@@ -1612,16 +1610,15 @@ tty3270_write(struct tty_struct * tty,
 /*
  * Put single characters to the ttys character buffer
  */
-static void
-tty3270_put_char(struct tty_struct *tty, unsigned char ch)
+static int tty3270_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct tty3270 *tp;
 
 	tp = tty->driver_data;
-	if (!tp)
-		return;
-	if (tp->char_count < TTY3270_CHAR_BUF_SIZE)
-		tp->char_buf[tp->char_count++] = ch;
+	if (!tp || tp->char_count >= TTY3270_CHAR_BUF_SIZE)
+		return 0;
+	tp->char_buf[tp->char_count++] = ch;
+	return 1;
 }
 
 /*

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
