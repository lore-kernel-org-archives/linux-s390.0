From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 3/5] s390/qeth: avoid using is_multicast_ether_addr_64bits on (u8 *)[6]
Date: Fri, 29 Jun 2018 19:45:52 +0200
Message-ID: <20180629174554.53718-4-jwi@linux.ibm.com>
References: <20180629174554.53718-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180629174554.53718-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Vasily Gorbik <gor@linux.ibm.com>

*ether_addr*_64bits functions have been introduced to optimize
performance critical paths, which access 6-byte ethernet address as u64
value to get "nice" assembly. A harmless hack works nicely on ethernet
addresses shoved into a structure or a larger buffer, until busted by
Kasan on smth like plain (u8 *)[6].

qeth_l2_set_mac_address calls qeth_l2_remove_mac passing
u8 old_addr[ETH_ALEN] as an argument.

Adding/removing macs for an ethernet adapter is not that performance
critical. Moreover is_multicast_ether_addr_64bits itself on s390 is not
faster than is_multicast_ether_addr:

is_multicast_ether_addr(%r2) -> %r2
llc	%r2,0(%r2)
risbg	%r2,%r2,63,191,0

is_multicast_ether_addr_64bits(%r2) -> %r2
llgc	%r2,0(%r2)
risbg	%r2,%r2,63,191,0

So, let's just use is_multicast_ether_addr instead of
is_multicast_ether_addr_64bits.

Fixes: bcacfcbc82b4 ("s390/qeth: fix MAC address update sequence")
Reviewed-by: Julian Wiedmann <jwi@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 7daf125dae76..5464515b71f1 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -140,7 +140,7 @@ static int qeth_l2_send_setmac(struct qeth_card *card, __u8 *mac)
 
 static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 {
-	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr(mac) ?
 					IPA_CMD_SETGMAC : IPA_CMD_SETVMAC;
 	int rc;
 
@@ -157,7 +157,7 @@ static int qeth_l2_write_mac(struct qeth_card *card, u8 *mac)
 
 static int qeth_l2_remove_mac(struct qeth_card *card, u8 *mac)
 {
-	enum qeth_ipa_cmds cmd = is_multicast_ether_addr_64bits(mac) ?
+	enum qeth_ipa_cmds cmd = is_multicast_ether_addr(mac) ?
 					IPA_CMD_DELGMAC : IPA_CMD_DELVMAC;
 	int rc;
 
-- 
2.16.4
