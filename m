Return-Path: <SRS0=4oFk=ST=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/8] s390/qeth: don't bother updating the last-tx time
Date: Wed, 17 Apr 2019 18:17:30 +0200
In-Reply-To: <20190417161735.69637-1-jwi@linux.ibm.com>
References: <20190417161735.69637-1-jwi@linux.ibm.com>
Message-Id: <20190417161735.69637-4-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

As the documentation for netif_trans_update() says, netdev_start_xmit()
already updates the last-tx time after every good xmit. So don't
duplicate that effort.

One odd case is that qeth_flush_buffers() also gets called from our
TX completion handler, to flush out any partially filled buffer when
we switch the queue to non-packing mode. But as the TX completion
handler will _always_ wake the txq, we don't have to worry about
the TX watchdog there.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index ac592d610c5e..9e495df742cb 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -3371,7 +3371,6 @@ static void qeth_flush_buffers(struct qeth_qdio_out_q *queue, int index,
 	}
 
 	QETH_TXQ_STAT_ADD(queue, bufs, count);
-	netif_trans_update(queue->card->dev);
 	qdio_flags = QDIO_FLAG_SYNC_OUTPUT;
 	if (atomic_read(&queue->set_pci_flags_count))
 		qdio_flags |= QDIO_FLAG_PCI_OUT;
-- 
2.16.4
