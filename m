Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 311A1C433DB
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CA4C36023B
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:20:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231434AbhCCCIG (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:08:06 -0500
Received: from mx2.suse.de ([195.135.220.15]:39616 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835872AbhCBGYS (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id A462BAFEA;
        Tue,  2 Mar 2021 06:22:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH 18/44] tty: con3215, remove tasklet for tty_wakeup
Date:   Tue,  2 Mar 2021 07:21:48 +0100
Message-Id: <20210302062214.29627-18-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

tty_wakeup is safe to be called from all contexts. No need to schedule
a tasklet for that. Let us call it directly like in other drivers.

And delete the tasklet completely.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 20 +-------------------
 1 file changed, 1 insertion(+), 19 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 671efee612af..5923a1f133ef 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -85,7 +85,6 @@ struct raw3215_info {
 	int written;		      /* number of bytes in write requests */
 	struct raw3215_req *queued_read; /* pointer to queued read requests */
 	struct raw3215_req *queued_write;/* pointer to queued write requests */
-	struct tasklet_struct tlet;   /* tasklet to invoke tty_wakeup */
 	wait_queue_head_t empty_wait; /* wait queue for flushing */
 	struct timer_list timer;      /* timer for delayed output */
 	int line_pos;		      /* position on the line (for tabs) */
@@ -329,21 +328,6 @@ static inline void raw3215_try_io(struct raw3215_info *raw)
 	}
 }
 
-/*
- * Call tty_wakeup from tasklet context
- */
-static void raw3215_wakeup(unsigned long data)
-{
-	struct raw3215_info *raw = (struct raw3215_info *) data;
-	struct tty_struct *tty;
-
-	tty = tty_port_tty_get(&raw->port);
-	if (tty) {
-		tty_wakeup(tty);
-		tty_kref_put(tty);
-	}
-}
-
 /*
  * Try to start the next IO and wake up processes waiting on the tty.
  */
@@ -352,7 +336,7 @@ static void raw3215_next_io(struct raw3215_info *raw, struct tty_struct *tty)
 	raw3215_mk_write_req(raw);
 	raw3215_try_io(raw);
 	if (tty && RAW3215_BUFFER_SIZE - raw->count >= RAW3215_MIN_SPACE)
-		tasklet_schedule(&raw->tlet);
+		tty_wakeup(tty);
 }
 
 /*
@@ -644,7 +628,6 @@ static struct raw3215_info *raw3215_alloc_info(void)
 
 	timer_setup(&info->timer, raw3215_timeout, 0);
 	init_waitqueue_head(&info->empty_wait);
-	tasklet_init(&info->tlet, raw3215_wakeup, (unsigned long)info);
 	tty_port_init(&info->port);
 
 	return info;
@@ -936,7 +919,6 @@ static void tty3215_close(struct tty_struct *tty, struct file * filp)
 	tty->closing = 1;
 	/* Shutdown the terminal */
 	raw3215_shutdown(raw);
-	tasklet_kill(&raw->tlet);
 	tty->closing = 0;
 	tty_port_tty_set(&raw->port, NULL);
 }
-- 
2.30.1

