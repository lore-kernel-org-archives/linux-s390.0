Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: when thread completes, wake up all waiters
Date: Tue, 20 Mar 2018 07:59:13 +0100
In-Reply-To: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
References: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180320065915.62076-3-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_wait_for_threads() is potentially called by multiple users, make
sure to notify all of them after qeth_clear_thread_running_bit()
adjusted the thread_running_mask. With no timeout, callers would
otherwise stall.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4a820afececd..42ee8806fa53 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -960,7 +960,7 @@ void qeth_clear_thread_running_bit(struct qeth_card *card, unsigned long thread)
 	spin_lock_irqsave(&card->thread_mask_lock, flags);
 	card->thread_running_mask &= ~thread;
 	spin_unlock_irqrestore(&card->thread_mask_lock, flags);
-	wake_up(&card->wait_q);
+	wake_up_all(&card->wait_q);
 }
 EXPORT_SYMBOL_GPL(qeth_clear_thread_running_bit);
 
-- 
2.13.5
