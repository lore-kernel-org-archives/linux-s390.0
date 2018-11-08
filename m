From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 7/8] s390/qeth: remove unused fallback in Layer3's MAC code
Date: Thu,  8 Nov 2018 15:06:21 +0100
Message-ID: <20181108140622.35244-8-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If the CREATE ADDR sent by qeth_l3_iqd_read_initial_mac() fails, its
callback sets a random MAC address on the net_device. The error then
propagates back, and qeth_l3_setup_netdev() bails out without
registering the net_device.

Any subsequent call to qeth_l3_setup_netdev() will then attempt a fresh
CREATE ADDR which either 1) also fails, or 2) sets a proper MAC address
on the net_device. Consequently, the net_device will never be registered
with a random MAC and we can drop the fallback code.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 89d5e6fb21ac..674ff3344ff3 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -949,9 +949,6 @@ static int qeth_l3_iqd_read_initial_mac_cb(struct qeth_card *card,
 	if (cmd->hdr.return_code == 0)
 		ether_addr_copy(card->dev->dev_addr,
 				cmd->data.create_destroy_addr.unique_id);
-	else
-		eth_random_addr(card->dev->dev_addr);
-
 	return 0;
 }
 
-- 
2.16.4
