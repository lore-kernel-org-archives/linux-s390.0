Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:58480 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728635AbfKVFwk (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Fri, 22 Nov 2019 00:52:40 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 4.19 181/219] net/smc: don't wait for send buffer space when data was already sent
Date: Fri, 22 Nov 2019 00:48:33 -0500
Message-Id: <20191122054911.1750-174-sashal@kernel.org>
In-Reply-To: <20191122054911.1750-1-sashal@kernel.org>
References: <20191122054911.1750-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Karsten Graul <kgraul@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org, netdev@vger.kernel.org

From: Karsten Graul <kgraul@linux.ibm.com>

[ Upstream commit 6889b36da78a21a312d8b462c1fa25a03c2ff192 ]

When there is no more send buffer space and at least 1 byte was already
sent then return to user space. The wait is only done when no data was
sent by the sendmsg() call.
This fixes smc_tx_sendmsg() which tried to always send all user data and
started to wait for free send buffer space when needed. During this wait
the user space program was blocked in the sendmsg() call and hence not
able to receive incoming data. When both sides were in such a situation
then the connection stalled forever.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/smc/smc_tx.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/net/smc/smc_tx.c b/net/smc/smc_tx.c
index 28361aef99825..f1f621675db01 100644
--- a/net/smc/smc_tx.c
+++ b/net/smc/smc_tx.c
@@ -163,12 +163,11 @@ int smc_tx_sendmsg(struct smc_sock *smc, struct msghdr *msg, size_t len)
 			conn->local_tx_ctrl.prod_flags.urg_data_pending = 1;
 
 		if (!atomic_read(&conn->sndbuf_space) || conn->urg_tx_pend) {
+			if (send_done)
+				return send_done;
 			rc = smc_tx_wait(smc, msg->msg_flags);
-			if (rc) {
-				if (send_done)
-					return send_done;
+			if (rc)
 				goto out_err;
-			}
 			continue;
 		}
 
-- 
2.20.1
