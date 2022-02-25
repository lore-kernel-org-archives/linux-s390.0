Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49CDBC433EF
	for <linux-s390@archiver.kernel.org>; Fri, 25 Feb 2022 07:37:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238163AbiBYHh5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 25 Feb 2022 02:37:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238152AbiBYHh4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 25 Feb 2022 02:37:56 -0500
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD671688CB;
        Thu, 24 Feb 2022 23:37:24 -0800 (PST)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R131e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0V5RxVeL_1645774641;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0V5RxVeL_1645774641)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 25 Feb 2022 15:37:22 +0800
From:   Tony Lu <tonylu@linux.alibaba.com>
To:     raspl@linux.ibm.com, kgraul@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net
Cc:     netdev@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH net-next] net/smc: Call trace_smc_tx_sendmsg when data corked
Date:   Fri, 25 Feb 2022 15:34:21 +0800
Message-Id: <20220225073420.84025-1-tonylu@linux.alibaba.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

This also calls trace_smc_tx_sendmsg() even if data is corked. For ease
of understanding, if statements are not expanded here.

Link: https://lore.kernel.org/all/f4166712-9a1e-51a0-409d-b7df25a66c52@linux.ibm.com/
Fixes: 139653bc6635 ("net/smc: Remove corked dealyed work")
Suggested-by: Stefan Raspl <raspl@linux.ibm.com>
Signed-off-by: Tony Lu <tonylu@linux.alibaba.com>
---
 net/smc/smc_tx.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 5df3940d4543..436ac836f363 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -235,15 +235,14 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 		 */
 		if ((msg->msg_flags & MSG_OOB) && !send_remaining)
 			conn->urg_tx_pend = true;
-		if ((msg->msg_flags & MSG_MORE || smc_tx_is_corked(smc) ||
-		     msg->msg_flags & MSG_SENDPAGE_NOTLAST) &&
-		    (atomic_read(&conn->sndbuf_space)))
-			/* for a corked socket defer the RDMA writes if
-			 * sndbuf_space is still available. The applications
-			 * should known how/when to uncork it.
-			 */
-			continue;
-		smc_tx_sndbuf_nonempty(conn);
+		/* for a corked socket defer the RDMA writes if
+		 * sndbuf_space is still available. The applications
+		 * should known how/when to uncork it.
+		 */
+		if (!((msg->msg_flags & MSG_MORE || smc_tx_is_corked(smc) ||
+		       msg->msg_flags & MSG_SENDPAGE_NOTLAST) &&
+		      atomic_read(&conn->sndbuf_space)))
+			smc_tx_sndbuf_nonempty(conn);
 
 		trace_smc_tx_sendmsg(smc, copylen);
 	} /* while (msg_data_left(msg)) */
-- 
2.32.0.3.g01195cf9f

