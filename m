From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH RESEND net-next 07/12] s390/qeth: don't convert return code twice
Date: Thu, 12 Jan 2017 15:48:38 +0100
Message-ID: <20170112144843.33463-8-ubraun@linux.vnet.ibm.com>
References: <20170112144843.33463-1-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170112144843.33463-1-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, ubraun@linux.vnet.ibm.com
List-ID: <linux-s390.vger.kernel.org>

From: Julian Wiedmann <jwi@linux.vnet.ibm.com>

qeth_l2_send_groupmac() already translates the return code, so
calling qeth_setdel_makerc() a second time only produces garbage.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 3025f56..38fae10 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -210,8 +210,7 @@ static int qeth_l2_write_mac(struct qeth_card *card, struct qeth_mac *mac)
 				qeth_l2_send_setdelmac(card, mac->mac_addr,
 						IPA_CMD_SETVMAC));
 	} else {
-		rc = qeth_setdel_makerc(card,
-				qeth_l2_send_setgroupmac(card, mac->mac_addr));
+		rc = qeth_l2_send_setgroupmac(card, mac->mac_addr);
 	}
 	return rc;
 }
-- 
2.8.4
