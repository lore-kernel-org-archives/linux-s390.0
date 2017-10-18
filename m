From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 12/13] s390/qeth: support GRO flush timer
Date: Wed, 18 Oct 2017 17:40:24 +0200
Message-ID: <20171018154025.73630-13-jwi@linux.vnet.ibm.com>
References: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171018154025.73630-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Switch to napi_complete_done(), and thus enable delayed GRO flushing.
The timeout is configured via /sys/class/net/<if>/gro_flush_timeout.

Default timeout is 0, so no change in behaviour.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8855bc8534d2..98b7e1ce0dd1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5370,7 +5370,7 @@ int qeth_poll(struct napi_struct *napi, int budget)
 		}
 	}
 
-	napi_complete(napi);
+	napi_complete_done(napi, work_done);
 	if (qdio_start_irq(card->data.ccwdev, 0))
 		napi_schedule(&card->napi);
 out:
-- 
2.13.5
