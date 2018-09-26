From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 07/15] s390/qeth: remove additional skb refcount
Date: Wed, 26 Sep 2018 18:29:08 +0200
Message-ID: <20180926162916.102720-8-jwi@linux.ibm.com>
References: <20180926162916.102720-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180926162916.102720-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

This was presumably left over from back when qeth recursed into
dev_queue_xmit().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index c5c40c6d8b7d..012519ffd8de 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1211,7 +1211,6 @@ static void qeth_release_skbs(struct qeth_qdio_out_buffer *buf)
 				iucv->sk_txnotify(skb, TX_NOTIFY_GENERALERROR);
 			}
 		}
-		refcount_dec(&skb->users);
 	}
 	__skb_queue_purge(&buf->skb_list);
 }
@@ -3988,7 +3987,6 @@ static int qeth_fill_buffer(struct qeth_qdio_out_q *queue,
 	bool is_first_elem = true;
 	int flush_cnt = 0;
 
-	refcount_inc(&skb->users);
 	__skb_queue_tail(&buf->skb_list, skb);
 
 	/* build dedicated header element */
-- 
2.16.4
