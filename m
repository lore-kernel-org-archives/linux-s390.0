Return-Path: <netdev-owner@vger.kernel.org>
From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 3/6] s390/qeth: fix double-free on IP add/remove race
Date: Tue, 27 Feb 2018 18:58:14 +0100
In-Reply-To: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
References: <20180227175817.84727-1-jwi@linux.vnet.ibm.com>
Message-Id: <20180227175817.84727-4-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Registering an IPv4 address with the HW takes quite a while, so we
temporarily drop the ip_htable lock. Any concurrent add/remove of the
same IP adjusts the IP's use count, and (on remove) is then blocked by
addr->in_progress.
After the register call has completed, we check the use count for
concurrently attempted add/remove calls - and possibly straight-away
deregister the IP again. This happens via l3_delete_ip(), which
1) looks up the queried IP in the htable (getting a reference to the
   *same* queried object),
2) deregisters the IP from the HW, and
3) frees the IP object.

The caller in l3_add_ip() then does a second free on the same object.

For this case, skip all the extra checks and lookups in l3_delete_ip()
and just deregister & free the IP object ourselves.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 34481b51029e..77cdb4fc7721 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -237,7 +237,8 @@ int qeth_l3_add_ip(struct qeth_card *card, struct qeth_ipaddr *tmp_addr)
 				(rc == IPA_RC_LAN_OFFLINE)) {
 			addr->disp_flag = QETH_DISP_ADDR_DO_NOTHING;
 			if (addr->ref_counter < 1) {
-				qeth_l3_delete_ip(card, addr);
+				qeth_l3_deregister_addr_entry(card, addr);
+				hash_del(&addr->hnode);
 				kfree(addr);
 			}
 		} else {
-- 
2.13.5
