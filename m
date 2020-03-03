Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:42376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728000AbgCCCrX (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Mon, 2 Mar 2020 21:47:23 -0500
From: Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.5 54/66] s390/qeth: fix off-by-one in RX copybreak check
Date: Mon,  2 Mar 2020 21:46:03 -0500
Message-Id: <20200303024615.8889-54-sashal@kernel.org>
In-Reply-To: <20200303024615.8889-1-sashal@kernel.org>
References: <20200303024615.8889-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc: Julian Wiedmann <jwi@linux.ibm.com>, "David S . Miller" <davem@davemloft.net>, Sasha Levin <sashal@kernel.org>, linux-s390@vger.kernel.org

From: Julian Wiedmann <jwi@linux.ibm.com>

[ Upstream commit 54a61fbc020fd2e305680871c453abcf7fc0339b ]

The RX copybreak is intended as the _max_ value where the frame's data
should be copied. So for frame_len == copybreak, don't build an SG skb.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 623475717183e..4fd7b0ceb4ffd 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5141,7 +5141,7 @@ struct sk_buff *qeth_core_get_next_skb(struct qeth_card *card,
 	}
 
 	use_rx_sg = (card->options.cq == QETH_CQ_ENABLED) ||
-		    ((skb_len >= card->options.rx_sg_cb) &&
+		    (skb_len > card->options.rx_sg_cb &&
 		     !atomic_read(&card->force_alloc_skb) &&
 		     !IS_OSN(card));
 
-- 
2.20.1
