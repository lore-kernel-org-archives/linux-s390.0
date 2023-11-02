Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE59DC4167B
	for <linux-s390@archiver.kernel.org>; Thu,  2 Nov 2023 09:36:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjKBJg7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 2 Nov 2023 05:36:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234737AbjKBJg6 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 2 Nov 2023 05:36:58 -0400
X-Greylist: delayed 579 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 02 Nov 2023 02:36:54 PDT
Received: from njjs-sys-mailin01.njjs.baidu.com (mx314.baidu.com [180.101.52.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EA53137
        for <linux-s390@vger.kernel.org>; Thu,  2 Nov 2023 02:36:54 -0700 (PDT)
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
        by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 69DDC7F0003D;
        Thu,  2 Nov 2023 17:27:12 +0800 (CST)
From:   Li RongQing <lirongqing@baidu.com>
To:     linux-s390@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH] net/smc: avoid atomic_set and smp_wmb in the tx path when possible
Date:   Thu,  2 Nov 2023 17:27:12 +0800
Message-Id: <20231102092712.30793-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

these is less opportunity that conn->tx_pushing is not 1, since
tx_pushing is just checked with 1, so move the setting tx_pushing
to 1 after atomic_dec_and_test() return false, to avoid atomic_set
and smp_wmb in tx path when possible

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 net/smc/smc_tx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 3b0ff3b..72dbdee 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -667,8 +667,6 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 		return 0;
 
 again:
-	atomic_set(&conn->tx_pushing, 1);
-	smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 	rc = __smc_tx_sndbuf_nonempty(conn);
 
 	/* We need to check whether someone else have added some data into
@@ -677,8 +675,11 @@ int smc_tx_sndbuf_nonempty(struct smc_connection *conn)
 	 * If so, we need to push again to prevent those data hang in the send
 	 * queue.
 	 */
-	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing)))
+	if (unlikely(!atomic_dec_and_test(&conn->tx_pushing))) {
+		atomic_set(&conn->tx_pushing, 1);
+		smp_wmb(); /* Make sure tx_pushing is 1 before real send */
 		goto again;
+	}
 
 	return rc;
 }
-- 
2.9.4

