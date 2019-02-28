Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 5/9] s390/qeth: remove a redundant check for card->dev
Date: Thu, 28 Feb 2019 18:59:40 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-6-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

smatch complains that __qeth_l3_set_offline() first accesses card->dev,
and then later checks whether the pointer is valid.
Since commit d3d1b205e89f ("s390/qeth: allocate netdevice early"), the
pointer is _always_ valid - that patch merely missed to remove this one
check.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 1381e7e312cd..13d77957404c 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2414,7 +2414,7 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	rtnl_unlock();
 
 	qeth_l3_stop_card(card);
-	if ((card->options.cq == QETH_CQ_ENABLED) && card->dev) {
+	if (card->options.cq == QETH_CQ_ENABLED) {
 		rtnl_lock();
 		call_netdevice_notifiers(NETDEV_REBOOT, card->dev);
 		rtnl_unlock();
-- 
2.16.4
