From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 12/12] s390/qeth: fix using of ref counter for rxip addresses
Date: Tue, 15 Aug 2017 17:02:50 +0200
Message-ID: <20170815150250.67158-13-jwi@linux.vnet.ibm.com>
References: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170815150250.67158-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>

IP-address setting and removal are delayed when the device is not yet in
state SOFTSETUP or UP. ref_counter has been implemented only for
ip-address with type normal. In this patch ref_counter logic is also used
for ip-address with type rxip to allow appropriate handling of multiple
postponed rxip add and del calls.

Signed-off-by: Kittipon Meesompop <kmeesomp@linux.vnet.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 41bd00454d0f..0a3dc14a1381 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -247,7 +247,8 @@ int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 		return -ENOENT;
 
 	addr->ref_counter--;
-	if (addr->type == QETH_IP_TYPE_NORMAL && addr->ref_counter > 0)
+	if (addr->ref_counter > 0 && (addr->type == QETH_IP_TYPE_NORMAL ||
+				      addr->type == QETH_IP_TYPE_RXIP))
 		return rc;
 	if (addr->in_progress)
 		return -EINPROGRESS;
@@ -329,8 +330,9 @@ int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 			kfree(addr);
 		}
 	} else {
-			if (addr->type == QETH_IP_TYPE_NORMAL)
-				addr->ref_counter++;
+		if (addr->type == QETH_IP_TYPE_NORMAL ||
+		    addr->type == QETH_IP_TYPE_RXIP)
+			addr->ref_counter++;
 	}
 
 	return rc;
-- 
2.11.2
