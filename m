Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B8AFC7EE29
	for <linux-s390@archiver.kernel.org>; Sat, 10 Jun 2023 14:25:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjFJOZh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Sat, 10 Jun 2023 10:25:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233406AbjFJOZh (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Sat, 10 Jun 2023 10:25:37 -0400
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34123A9B
        for <linux-s390@vger.kernel.org>; Sat, 10 Jun 2023 07:25:35 -0700 (PDT)
Received: from pop-os.home ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id 7zX3qD8gIesxi7zX3qZACp; Sat, 10 Jun 2023 16:25:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1686407134;
        bh=OesB7QjVdvM9ATk6240RUwjhucS48HFh/O5XYkyqKNA=;
        h=From:To:Cc:Subject:Date;
        b=M0AlTevRVUoqzRZ5JN0ZssDLIEffQDx40BR5DsuQMaPQiwV+X866NJ7znhAzRSjvQ
         qVT3sf/zryB1byA3NX6sduDM4PRj6erJTXs3//27+gMY/jurynWLdZDl0xHMnl8NA/
         CmQcA75DEAVaXxLNBYLITWOiI4I9FFEgmH0gTSg4DyolbT4KdM4PaOb8MMEmx7+7p/
         QGEN9LXVMbVT4JcB+wFxL0PpDpotLcJtCYDlzW9QvKPdvKc8IJQXawc92Ac3U5/L5Q
         vyQAunq+5cA8FSex3+vi2Xox/IDFC1M+2jQr6snDeulXH+KLQ4BQ1FN+qe4JfXHeei
         eDbvsAhZPJsOQ==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 10 Jun 2023 16:25:34 +0200
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
Subject: [PATCH] s390: ebcdic: Fix a typo in a comment
Date:   Sat, 10 Jun 2023 16:25:28 +0200
Message-Id: <08ed63331699177b3354458da66a2f63c0217e49.1686407113.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

s/ECBDIC/EBCDIC/ 	(C and B are swapped)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 arch/s390/kernel/ebcdic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/s390/kernel/ebcdic.c b/arch/s390/kernel/ebcdic.c
index 7f8246c9be08..0e51fa537262 100644
--- a/arch/s390/kernel/ebcdic.c
+++ b/arch/s390/kernel/ebcdic.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- *    ECBDIC -> ASCII, ASCII -> ECBDIC,
+ *    EBCDIC -> ASCII, ASCII -> EBCDIC,
  *    upper to lower case (EBCDIC) conversion tables.
  *
  *  S390 version
-- 
2.34.1

