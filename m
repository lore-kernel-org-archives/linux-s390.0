Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F27BC433F5
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53E7E60F11
	for <linux-s390@archiver.kernel.org>; Mon, 27 Sep 2021 21:56:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237482AbhI0V63 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 27 Sep 2021 17:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbhI0V61 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 27 Sep 2021 17:58:27 -0400
Received: from bombadil.infradead.org (unknown [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39B33C061575;
        Mon, 27 Sep 2021 14:56:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=hGX2uraOWKcbdqvQEGEcWfwcUwznDEuW9gnPoVw/EgI=; b=shlhIoloA5/y4cBG9UooN5GbSW
        ijM03Fm43/Qu54nJagQc7sk9etQwr9ldMXJEaFMwzQXMNAvsW52Kf0rw2Y9laLR8m91A/lFLEz0CN
        Yxi7Kg1b+VGuyaM4x3jvbN27QM/lrppJjx0bPRbLhaAKUA9R+G+yPWZe30FFX32qeogOzH1gkRPCq
        JZW6FWNvYlpGbTiibFSEDKaY0+f4mMj1KwbO4cWptBfJ6r7EpHEwZZdiNWUYS4VSNG2Utp1afkYsJ
        nIopo5QnPbPeegK/ay3PZ0KrPf7eKryFohKiTGpy9Pi/fsLOmYGLPrEzSDuPqPsgMK20jaZ5u8Hx3
        ER8gqQLA==;
Received: from [2601:1c0:6280:3f0::aa0b] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mUycC-004Rxw-Hi; Mon, 27 Sep 2021 21:56:48 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/sclp_vt220: fix unused function warning
Date:   Mon, 27 Sep 2021 14:56:47 -0700
Message-Id: <20210927215647.11506-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

When CONFIG_SCLP_VT220_TTY=y and CONFIG_SCLP_VT220_CONSOLE is not set:

../drivers/s390/char/sclp_vt220.c:771:13: warning: '__sclp_vt220_flush_buffer' defined but not used [-Wunused-function]
  771 | static void __sclp_vt220_flush_buffer(void)

so move this function inside the #ifdef block where it is used.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org
---
Sorry, I can't determine what the Fixes: tag for this should be
(missing some git fu).

 drivers/s390/char/sclp_vt220.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20210927.orig/drivers/s390/char/sclp_vt220.c
+++ linux-next-20210927/drivers/s390/char/sclp_vt220.c
@@ -768,6 +768,8 @@ out_driver:
 }
 __initcall(sclp_vt220_tty_init);
 
+#ifdef CONFIG_SCLP_VT220_CONSOLE
+
 static void __sclp_vt220_flush_buffer(void)
 {
 	unsigned long flags;
@@ -784,8 +786,6 @@ static void __sclp_vt220_flush_buffer(vo
 	spin_unlock_irqrestore(&sclp_vt220_lock, flags);
 }
 
-#ifdef CONFIG_SCLP_VT220_CONSOLE
-
 static void
 sclp_vt220_con_write(struct console *con, const char *buf, unsigned int count)
 {
