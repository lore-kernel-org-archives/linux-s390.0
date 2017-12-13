From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 2/4] s390/qeth: don't apply takeover changes to RXIP
Date: Wed, 13 Dec 2017 18:56:30 +0100
Message-ID: <20171213175632.100561-3-jwi@linux.vnet.ibm.com>
References: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When takeover is switched off, current code clears the 'TAKEOVER' flag on
all IPs. But the flag is also used for RXIP addresses, and those should
not be affected by the takeover mode.
Fix the behaviour by consistenly applying takover logic to NORMAL
addresses only.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 5 +++--
 drivers/s390/net/qeth_l3_sys.c  | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 6a73894b0cb5..4a4be81800eb 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -174,6 +174,8 @@ int qeth_l3_is_addr_covered_by_ipato(struct qeth_card *card,
 
 	if (!card->ipato.enabled)
 		return 0;
+	if (addr->type != QETH_IP_TYPE_NORMAL)
+		return 0;
 
 	qeth_l3_convert_addr_to_bits((u8 *) &addr->u, addr_bits,
 				  (addr->proto == QETH_PROT_IPV4)? 4:16);
@@ -290,8 +292,7 @@ int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 		memcpy(addr, tmp_addr, sizeof(struct qeth_ipaddr));
 		addr->ref_counter = 1;
 
-		if (addr->type == QETH_IP_TYPE_NORMAL  &&
-				qeth_l3_is_addr_covered_by_ipato(card, addr)) {
+		if (qeth_l3_is_addr_covered_by_ipato(card, addr)) {
 			QETH_CARD_TEXT(card, 2, "tkovaddr");
 			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
 		}
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 198717f71b3d..e256928092e5 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -396,10 +396,11 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 	card->ipato.enabled = enable;
 
 	hash_for_each(card->ip_htable, i, addr, hnode) {
+		if (addr->type != QETH_IP_TYPE_NORMAL)
+			continue;
 		if (!enable)
 			addr->set_flags &= ~QETH_IPA_SETIP_TAKEOVER_FLAG;
-		else if (addr->type == QETH_IP_TYPE_NORMAL &&
-			 qeth_l3_is_addr_covered_by_ipato(card, addr))
+		else if (qeth_l3_is_addr_covered_by_ipato(card, addr))
 			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
 	}
 out:
-- 
2.13.5
