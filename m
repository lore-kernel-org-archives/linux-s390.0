Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26299C433E0
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D16FE64EA4
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231753AbhCCCSr (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:18:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:39908 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835886AbhCBGYp (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:45 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0E980AFF5;
        Tue,  2 Mar 2021 06:22:19 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH 20/44] tty: con3215, remove tty->driver_data casts
Date:   Tue,  2 Mar 2021 07:21:50 +0100
Message-Id: <20210302062214.29627-20-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Casts of 'void *' pointer are superfluous. So remove them.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 32 +++++++++++---------------------
 1 file changed, 11 insertions(+), 21 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index ae0dd9c1595c..d26947d743bc 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -911,9 +911,8 @@ static int tty3215_open(struct tty_struct *tty, struct file * filp)
  */
 static void tty3215_close(struct tty_struct *tty, struct file * filp)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	if (raw == NULL || tty->count > 1)
 		return;
 	tty->closing = 1;
@@ -928,9 +927,7 @@ static void tty3215_close(struct tty_struct *tty, struct file * filp)
  */
 static int tty3215_write_room(struct tty_struct *tty)
 {
-	struct raw3215_info *raw;
-
-	raw = (struct raw3215_info *) tty->driver_data;
+	struct raw3215_info *raw = tty->driver_data;
 
 	/* Subtract TAB_STOP_SIZE to allow for a tab, 8 <<< 64K */
 	if ((RAW3215_BUFFER_SIZE - raw->count - TAB_STOP_SIZE) >= 0)
@@ -945,10 +942,9 @@ static int tty3215_write_room(struct tty_struct *tty)
 static int tty3215_write(struct tty_struct * tty,
 			 const unsigned char *buf, int count)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 	int i, written;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	written = count;
 	while (count > 0) {
 		for (i = 0; i < count; i++)
@@ -971,10 +967,10 @@ static int tty3215_write(struct tty_struct * tty,
  */
 static int tty3215_put_char(struct tty_struct *tty, unsigned char ch)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	raw3215_putchar(raw, ch);
+
 	return 1;
 }
 
@@ -987,17 +983,15 @@ static void tty3215_flush_chars(struct tty_struct *tty)
  */
 static int tty3215_chars_in_buffer(struct tty_struct *tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	return raw->count;
 }
 
 static void tty3215_flush_buffer(struct tty_struct *tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	raw3215_flush_buffer(raw);
 	tty_wakeup(tty);
 }
@@ -1007,9 +1001,8 @@ static void tty3215_flush_buffer(struct tty_struct *tty)
  */
 static void tty3215_throttle(struct tty_struct * tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	raw->flags |= RAW3215_THROTTLED;
 }
 
@@ -1018,10 +1011,9 @@ static void tty3215_throttle(struct tty_struct * tty)
  */
 static void tty3215_unthrottle(struct tty_struct * tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 	unsigned long flags;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	if (raw->flags & RAW3215_THROTTLED) {
 		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		raw->flags &= ~RAW3215_THROTTLED;
@@ -1035,9 +1027,8 @@ static void tty3215_unthrottle(struct tty_struct * tty)
  */
 static void tty3215_stop(struct tty_struct *tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	raw->flags |= RAW3215_STOPPED;
 }
 
@@ -1046,10 +1037,9 @@ static void tty3215_stop(struct tty_struct *tty)
  */
 static void tty3215_start(struct tty_struct *tty)
 {
-	struct raw3215_info *raw;
+	struct raw3215_info *raw = tty->driver_data;
 	unsigned long flags;
 
-	raw = (struct raw3215_info *) tty->driver_data;
 	if (raw->flags & RAW3215_STOPPED) {
 		spin_lock_irqsave(get_ccwdev_lock(raw->cdev), flags);
 		raw->flags &= ~RAW3215_STOPPED;
-- 
2.30.1

