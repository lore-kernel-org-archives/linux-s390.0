Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35296C43334
	for <linux-s390@archiver.kernel.org>; Thu, 23 Jun 2022 06:07:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229441AbiFWGH3 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 23 Jun 2022 02:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiFWGH1 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 23 Jun 2022 02:07:27 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 923C041317;
        Wed, 22 Jun 2022 23:07:25 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 805E71E80CCC;
        Thu, 23 Jun 2022 14:07:07 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HzIKGLSmJDaE; Thu, 23 Jun 2022 14:07:04 +0800 (CST)
Received: from localhost.localdomain (unknown [112.64.61.33])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id 173F41E80C7D;
        Thu, 23 Jun 2022 14:07:04 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
        borntraeger@linux.ibm.com, svens@linux.ibm.com
Cc:     jwi@linux.ibm.com, bblock@linux.ibm.com, davem@davemloft.net,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] s390/qdio: Fix spelling mistake
Date:   Thu, 23 Jun 2022 14:05:43 +0800
Message-Id: <20220623060543.12870-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

Change 'defineable' to 'definable'.
Change 'paramater' to 'parameter'.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 arch/s390/include/asm/qdio.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/arch/s390/include/asm/qdio.h b/arch/s390/include/asm/qdio.h
index 54ae2dc65e3b..2f983e0b95e0 100644
--- a/arch/s390/include/asm/qdio.h
+++ b/arch/s390/include/asm/qdio.h
@@ -133,9 +133,9 @@ struct slibe {
  * @sb_count: number of storage blocks
  * @sba: storage block element addresses
  * @dcount: size of storage block elements
- * @user0: user defineable value
- * @res4: reserved paramater
- * @user1: user defineable value
+ * @user0: user definable value
+ * @res4: reserved parameter
+ * @user1: user definable value
  */
 struct qaob {
 	u64 res0[6];
-- 
2.25.1

