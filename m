Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5EA1C4167B
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C3D7261166
	for <linux-s390@archiver.kernel.org>; Tue, 14 Sep 2021 09:14:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230479AbhINJPl (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 14 Sep 2021 05:15:41 -0400
Received: from smtp-out2.suse.de ([195.135.220.29]:44046 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229850AbhINJPh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 14 Sep 2021 05:15:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 0A8202003B;
        Tue, 14 Sep 2021 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1631610859; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0inWg5bKmkT0ZZvF/iDW7c5P6F4DFoIeVXk9hb5kLd8=;
        b=ZEnbIG8xdQNARrC2PEyHBynMMjIBjZGgamhL/F/zc5S8CEuTy1iiVUsD57mz+a5KeNIXZt
        fJReYaC+WU+uKBQW6Mqaq4VZ8uv86CxF5EiqOu+Qy1kJJ82j/sjyA9RAs8k6JSDUrQjmM1
        /pbeaMwHX5sjiPK2NG4+TpRmYVM3G54=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1631610859;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0inWg5bKmkT0ZZvF/iDW7c5P6F4DFoIeVXk9hb5kLd8=;
        b=R9SWt/BC7G3w63VdHr8ciAbMDX2CqilpjmsUVzvsKe3rxiCv9iQn3qwjGqsRqheyAW46+V
        QvG/oABrsLAqxiBA==
Received: from localhost.localdomain (unknown [10.100.201.122])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id D2477A3B94;
        Tue, 14 Sep 2021 09:14:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH 13/16] tty: drivers/s390/char/, stop using tty_flip_buffer_push
Date:   Tue, 14 Sep 2021 11:14:12 +0200
Message-Id: <20210914091415.17918-6-jslaby@suse.cz>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20210914091415.17918-1-jslaby@suse.cz>
References: <20210914091134.17426-1-jslaby@suse.cz>
 <20210914091415.17918-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Since commit a9c3f68f3cd8d (tty: Fix low_latency BUG) in 2014,
tty_flip_buffer_push() is only a wrapper to tty_schedule_flip(). We are
going to remove the former, so call the latter directly in
drivers/s390/char/.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c    | 4 ++--
 drivers/s390/char/sclp_tty.c   | 4 ++--
 drivers/s390/char/sclp_vt220.c | 2 +-
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index f356607835d8..f37f4c0594d7 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -399,7 +399,7 @@ static void raw3215_irq(struct ccw_device *cdev, unsigned long intparm,
 			case CTRLCHAR_CTRL:
 				tty_insert_flip_char(&raw->port, cchar,
 						TTY_NORMAL);
-				tty_flip_buffer_push(&raw->port);
+				tty_schedule_flip(&raw->port);
 				break;
 
 			case CTRLCHAR_NONE:
@@ -413,7 +413,7 @@ static void raw3215_irq(struct ccw_device *cdev, unsigned long intparm,
 					count -= 2;
 				tty_insert_flip_string(&raw->port, raw->inbuf,
 						count);
-				tty_flip_buffer_push(&raw->port);
+				tty_schedule_flip(&raw->port);
 				break;
 			}
 		} else if (req->type == RAW3215_WRITE) {
diff --git a/drivers/s390/char/sclp_tty.c b/drivers/s390/char/sclp_tty.c
index 971fbb52740b..99256bea31f7 100644
--- a/drivers/s390/char/sclp_tty.c
+++ b/drivers/s390/char/sclp_tty.c
@@ -330,7 +330,7 @@ sclp_tty_input(unsigned char* buf, unsigned int count)
 		break;
 	case CTRLCHAR_CTRL:
 		tty_insert_flip_char(&sclp_port, cchar, TTY_NORMAL);
-		tty_flip_buffer_push(&sclp_port);
+		tty_schedule_flip(&sclp_port);
 		break;
 	case CTRLCHAR_NONE:
 		/* send (normal) input to line discipline */
@@ -342,7 +342,7 @@ sclp_tty_input(unsigned char* buf, unsigned int count)
 			tty_insert_flip_char(&sclp_port, '\n', TTY_NORMAL);
 		} else
 			tty_insert_flip_string(&sclp_port, buf, count - 2);
-		tty_flip_buffer_push(&sclp_port);
+		tty_schedule_flip(&sclp_port);
 		break;
 	}
 	tty_kref_put(tty);
diff --git a/drivers/s390/char/sclp_vt220.c b/drivers/s390/char/sclp_vt220.c
index 29a6a0099f83..b1ed3bcf3201 100644
--- a/drivers/s390/char/sclp_vt220.c
+++ b/drivers/s390/char/sclp_vt220.c
@@ -542,7 +542,7 @@ sclp_vt220_receiver_fn(struct evbuf_header *evbuf)
 		buffer++;
 		count--;
 		sclp_vt220_handle_input(buffer, count);
-		tty_flip_buffer_push(&sclp_vt220_port);
+		tty_schedule_flip(&sclp_vt220_port);
 		break;
 	}
 }
-- 
2.33.0

