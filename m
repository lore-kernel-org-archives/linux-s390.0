Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/3] s390/qeth: fix off-by-one in RX copybreak check
Date: Thu, 20 Feb 2020 15:54:56 +0100
In-Reply-To: <20200220145456.11571-1-jwi@linux.ibm.com>
References: <20200220145456.11571-1-jwi@linux.ibm.com>
Message-Id: <20200220145456.11571-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

The RX copybreak is intended as the _max_ value where the frame's data
should be copied. So for frame_len == copybreak, don't build an SG skb.

Fixes: 4a71df50047f ("qeth: new qeth device driver")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 2264c6619def..5efcaa43615b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5344,7 +5344,7 @@ static int qeth_extract_skb(struct qeth_card *card,
 	}
 
 	use_rx_sg = (card->options.cq == QETH_CQ_ENABLED) ||
-		    ((skb_len >= card->options.rx_sg_cb) &&
+		    (skb_len > card->options.rx_sg_cb &&
 		     !atomic_read(&card->force_alloc_skb) &&
 		     !IS_OSN(card));
 
-- 
2.17.1
