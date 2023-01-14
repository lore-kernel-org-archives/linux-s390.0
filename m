Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B0C3C46467
	for <linux-s390@archiver.kernel.org>; Sat, 14 Jan 2023 15:16:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjANPQB (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 14 Jan 2023 10:16:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbjANPQA (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 14 Jan 2023 10:16:00 -0500
X-Greylist: delayed 450 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 07:15:58 PST
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B97EA5276
        for <linux-s390@vger.kernel.org>; Sat, 14 Jan 2023 07:15:58 -0800 (PST)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Gi8vpZUiZWvItGi8vpe9oD; Sat, 14 Jan 2023 16:08:26 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 14 Jan 2023 16:08:26 +0100
X-ME-IP: 86.243.2.178
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-s390@vger.kernel.org
Subject: [PATCH] s390/ipl: Use kstrtobool() instead of strtobool() (second step)
Date:   Sat, 14 Jan 2023 16:08:22 +0100
Message-Id: <58a3ed2e21903a93dfd742943b1e6936863ca037.1673708887.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is similar to the serie ([1]) that tries to axed all usages
of strtobool().
Most of the patches have been merged in -next.

Commit d9b25bdf57e4 ("s390/ipl: Use kstrtobool() instead of strtobool()")
already fixed this file, but a new usage has been introduce by commit
87fd22e0ae92 ("s390/ipl: add eckd support").

This patch has been cross-compiled with make.cross.

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 arch/s390/kernel/ipl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ipl.c b/arch/s390/kernel/ipl.c
index fbd646dbf440..5547223acce0 100644
--- a/arch/s390/kernel/ipl.c
+++ b/arch/s390/kernel/ipl.c
@@ -1194,7 +1194,7 @@ static ssize_t reipl_eckd_clear_store(struct kobject *kobj,
 				      struct kobj_attribute *attr,
 				      const char *buf, size_t len)
 {
-	if (strtobool(buf, &reipl_eckd_clear) < 0)
+	if (kstrtobool(buf, &reipl_eckd_clear) < 0)
 		return -EINVAL;
 	return len;
 }
-- 
2.34.1

