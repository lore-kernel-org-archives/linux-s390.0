From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 13/13] s390/qeth: don't dump control cmd twice
Date: Wed, 18 Oct 2017 17:40:25 +0200
Message-ID: <20171018154025.73630-14-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

A few lines down, qeth_prepare_control_data() makes further changes to
the control cmd buffer, and then also writes a trace entry for it.
So the first entry just pollutes the trace file with intermediate data,
drop it.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 98b7e1ce0dd1..457a4b4e8212 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -2073,7 +2073,6 @@ int qeth_send_control_data(struct qeth_card *card, int len,
 	spin_lock_irqsave(&card->lock, flags);
 	list_add_tail(&reply->list, &card->cmd_waiter_list);
 	spin_unlock_irqrestore(&card->lock, flags);
-	QETH_DBF_HEX(CTRL, 2, iob->data, QETH_DBF_CTRL_LEN);
 
 	while (atomic_cmpxchg(&card->write.irq_pending, 0, 1)) ;
 	qeth_prepare_control_data(card, len, iob);
-- 
2.13.5
