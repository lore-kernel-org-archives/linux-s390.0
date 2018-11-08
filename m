From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 8/8] s390/qeth: don't process hsuid in qeth_l3_setup_netdev()
Date: Thu,  8 Nov 2018 15:06:22 +0100
Message-ID: <20181108140622.35244-9-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

qeth_l3_setup_netdev() checks if the hsuid attribute is set on the qeth
device, and propagates it to the net_device. In the past this was needed
to pick up any hsuid that was set before allocation of the net_device.

With commit d3d1b205e89f ("s390/qeth: allocate netdevice early") this
is no longer necessary, qeth_l3_dev_hsuid_store() always stores the
hsuid straight into dev->perm_addr.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 674ff3344ff3..eca68da39d05 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2279,9 +2279,6 @@ static int qeth_l3_setup_netdev(struct qeth_card *card, bool carrier_ok)
 		rc = qeth_l3_iqd_read_initial_mac(card);
 		if (rc)
 			goto out;
-
-		if (card->options.hsuid[0])
-			memcpy(card->dev->perm_addr, card->options.hsuid, 9);
 	} else
 		return -ENODEV;
 
-- 
2.16.4
