From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 1/3] s390/qeth: fix thinko in IPv4 multicast address tracking
Date: Fri,  1 Dec 2017 10:14:49 +0100
Message-ID: <20171201091451.52270-2-jwi@linux.vnet.ibm.com>
References: <20171201091451.52270-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171201091451.52270-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Commit 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
reworked how secondary addresses are managed for qeth devices.
Instead of dropping & subsequently re-adding all addresses on every
ndo_set_rx_mode() call, qeth now keeps track of the addresses that are
currently registered with the HW.
On a ndo_set_rx_mode(), we thus only need to do (de-)registration
requests for the addresses that have actually changed.

On L3 devices, the lookup for IPv4 Multicast addresses checks the wrong
hashtable - and thus never finds a match. As a result, we first delete
*all* such addresses, and then re-add them again. So each set_rx_mode()
causes a short period where the IPv4 Multicast addresses are not
registered, and the card stops forwarding inbound traffic for them.

Fix this by setting the ->is_multicast flag on the lookup object, thus
enabling qeth_l3_ip_from_hash() to search the correct hashtable and
find a match there.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index aadd384316a3..e79936b50698 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1376,6 +1376,7 @@ qeth_l3_add_mc_to_hash(struct qeth_card *card, struct in_device *in4_dev)
 
 		tmp->u.a4.addr = be32_to_cpu(im4->multiaddr);
 		memcpy(tmp->mac, buf, sizeof(tmp->mac));
+		tmp->is_multicast = 1;
 
 		ipm = qeth_l3_ip_from_hash(card, tmp);
 		if (ipm) {
-- 
2.13.5
