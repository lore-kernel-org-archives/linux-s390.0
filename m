Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 2/6] s390/qeth: fix IP removal on offline cards
Date: Tue, 27 Feb 2018 18:58:13 +0100
In-Reply-To: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
References: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180227175817.84727-3-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

If the HW is not reachable, then none of the IPs in qeth's internal
table has been registered with the HW yet. So when deleting such an IP,
there's no need to stage it for deregistration - just drop it from
the table.

This fixes the "add-delete-add" scenario on an offline card, where the
the second "add" merely increments the IP's use count. But as the IP is
still set to DISP_ADDR_DELETE from the previous "delete" step,
l3_recover_ip() won't register it with the HW when the card goes online.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 3421893c37a4..34481b51029e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -173,12 +173,8 @@ int qeth_l3_delete_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 	if (addr->in_progress)
 		return -EINPROGRESS;
 
-	if (!qeth_card_hw_is_reachable(card)) {
-		addr->disp_flag = QETH_DISP_ADDR_DELETE;
-		return 0;
-	}
-
-	rc = qeth_l3_deregister_addr_entry(card, addr);
+	if (qeth_card_hw_is_reachable(card))
+		rc = qeth_l3_deregister_addr_entry(card, addr);
 
 	hash_del(&addr->hnode);
 	kfree(addr);
@@ -321,11 +317,7 @@ static void qeth_l3_recover_ip(struct qeth_card *card)
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
-		if (addr->disp_flag == QETH_DISP_ADDR_DELETE) {
-			qeth_l3_deregister_addr_entry(card, addr);
-			hash_del(&addr->hnode);
-			kfree(addr);
-		} else if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
+		if (addr->disp_flag == QETH_DISP_ADDR_ADD) {
 			if (addr->proto == QETH_PROT_IPV4) {
 				addr->in_progress = 1;
 				spin_unlock_bh(&card->ip_lock);
-- 
2.13.5
