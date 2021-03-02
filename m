Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABE18C433E0
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3C0EF64EA4
	for <linux-s390@archiver.kernel.org>; Wed,  3 Mar 2021 02:28:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbhCCCSe (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 2 Mar 2021 21:18:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:39906 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1835885AbhCBGYm (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Tue, 2 Mar 2021 01:24:42 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id D3047AFEF;
        Tue,  2 Mar 2021 06:22:18 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     gregkh@linuxfoundation.org
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jiri Slaby <jslaby@suse.cz>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        linux390@de.ibm.com, linux-s390@vger.kernel.org
Subject: [PATCH 19/44] tty: con3215, remove unneeded tty checks
Date:   Tue,  2 Mar 2021 07:21:49 +0100
Message-Id: <20210302062214.29627-19-jslaby@suse.cz>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210302062214.29627-1-jslaby@suse.cz>
References: <20210302062214.29627-1-jslaby@suse.cz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

There is no need to check tty in these functions as it's always
non-NULL. So remove the tests.

Signed-off-by: Jiri Slaby <jslaby@suse.cz>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
Cc: linux390@de.ibm.com
Cc: linux-s390@vger.kernel.org
---
 drivers/s390/char/con3215.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/s390/char/con3215.c b/drivers/s390/char/con3215.c
index 5923a1f133ef..ae0dd9c1595c 100644
--- a/drivers/s390/char/con3215.c
+++ b/drivers/s390/char/con3215.c
@@ -948,8 +948,6 @@ static int tty3215_write(struct tty_struct * tty,
 	struct raw3215_info *raw;
 	int i, written;
 
-	if (!tty)
-		return 0;
 	raw = (struct raw3215_info *) tty->driver_data;
 	written = count;
 	while (count > 0) {
@@ -975,8 +973,6 @@ static int tty3215_put_char(struct tty_struct *tty, unsigned char ch)
 {
 	struct raw3215_info *raw;
 
-	if (!tty)
-		return 0;
 	raw = (struct raw3215_info *) tty->driver_data;
 	raw3215_putchar(raw, ch);
 	return 1;
-- 
2.30.1

