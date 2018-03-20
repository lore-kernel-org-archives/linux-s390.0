Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 4/4] s390/qeth: on channel error, reject further cmd requests
Date: Tue, 20 Mar 2018 07:59:15 +0100
In-Reply-To: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
References: <20180320065915.62076-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180320065915.62076-5-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When the IRQ handler determines that one of the cmd IO channels has
failed and schedules recovery, block any further cmd requests from
being submitted. The request would inevitably stall, and prevent the
recovery from making progress until the request times out.

This sort of error was observed after Live Guest Relocation, where
the pending IO on the READ channel intentionally gets terminated to
kick-start recovery. Simultaneously the guest executed SIOCETHTOOL,
triggering qeth to issue a QUERY CARD INFO command. The command
then stalled in the inoperabel WRITE channel.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 2a9afaf8f264..3653bea38470 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1174,6 +1174,7 @@ static void qeth_irq(struct ccw_device *cdev, unsigned long intparm,
 		}
 		rc = qeth_get_problem(cdev, irb);
 		if (rc) {
+			card->read_or_write_problem = 1;
 			qeth_clear_ipacmd_list(card);
 			qeth_schedule_recovery(card);
 			goto out;
-- 
2.13.5
