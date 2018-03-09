Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 04/12] s390/qeth: advertise IFF_UNICAST_FLT
Date: Fri,  9 Mar 2018 18:12:55 +0100
In-Reply-To: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
References: <20180309171303.65736-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180309171303.65736-5-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth implements HW-based Unicast Filtering (via SETVMAC) on L2 devices.
Tell the stack, so it knows that receiving traffic for secondary
addresses doesn't require full-blown promiscuous mode.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index ea607e5fb5dc..c7bc80b3a979 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -975,6 +975,7 @@ static int qeth_l2_setup_netdev(struct qeth_card *card)
 		return -ENODEV;
 
 	card->dev->ml_priv = card;
+	card->dev->priv_flags |= IFF_UNICAST_FLT;
 	card->dev->watchdog_timeo = QETH_TX_TIMEOUT;
 	card->dev->mtu = card->info.initial_mtu;
 	card->dev->min_mtu = 64;
-- 
2.13.5
