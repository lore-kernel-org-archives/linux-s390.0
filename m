From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/6] s390/qeth: fix HiperSockets sniffer
Date: Fri,  2 Nov 2018 19:04:09 +0100
Message-ID: <20181102180413.53020-3-jwi@linux.ibm.com>
References: <20181102180413.53020-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181102180413.53020-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Sniffing mode for L3 HiperSockets requires that no IP addresses are
registered with the HW. The preferred way to achieve this is for
userspace to delete all the IPs on the interface. But qeth is expected
to also tolerate a configuration where that is not the case, by skipping
the IP registration when in sniffer mode.
Since commit 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
reworked the IP registration logic in the L3 subdriver, this no longer
works. When the qeth device is set online, qeth_l3_recover_ip() now
unconditionally registers all unicast addresses from our internal
IP table.

While we could fix this particular problem by skipping
qeth_l3_recover_ip() on a sniffer device, the more future-proof change
is to skip the IP address registration at the lowest level. This way we
a) catch any future code path that attempts to register an IP address
   without considering the sniffer scenario, and
b) continue to build up our internal IP table, so that if sniffer mode
   is switched off later we can operate just like normal.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index ffa2aa1dd4c5..968e344a240b 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -278,9 +278,6 @@ static void qeth_l3_clear_ip_htable(struct qeth_card *card, int recover)
 
 	QETH_CARD_TEXT(card, 4, "clearip");
 
-	if (recover && card->options.sniffer)
-		return;
-
 	spin_lock_bh(&card->ip_lock);
 
 	hash_for_each_safe(card->ip_htable, i, tmp, addr, hnode) {
@@ -661,6 +658,8 @@ static int qeth_l3_register_addr_entry(struct qeth_card *card,
 	int rc = 0;
 	int cnt = 3;
 
+	if (card->options.sniffer)
+		return 0;
 
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_CARD_TEXT(card, 2, "setaddr4");
@@ -695,6 +694,9 @@ static int qeth_l3_deregister_addr_entry(struct qeth_card *card,
 {
 	int rc = 0;
 
+	if (card->options.sniffer)
+		return 0;
+
 	if (addr->proto == QETH_PROT_IPV4) {
 		QETH_CARD_TEXT(card, 2, "deladdr4");
 		QETH_CARD_HEX(card, 3, &addr->u.a4.addr, sizeof(int));
-- 
2.16.4
