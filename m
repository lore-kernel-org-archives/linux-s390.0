From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 3/4] s390/qeth: lock IP table while applying takeover changes
Date: Wed, 13 Dec 2017 18:56:31 +0100
Message-ID: <20171213175632.100561-4-jwi@linux.vnet.ibm.com>
References: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Modifying the flags of an IP addr object needs to be protected against
eg. concurrent removal of the same object from the IP table.

Fixes: 5f78e29ceebf ("qeth: optimize IP handling in rx_mode callback")
Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_sys.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index e256928092e5..aa676b4090da 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -395,6 +395,7 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		goto out;
 	card->ipato.enabled = enable;
 
+	spin_lock_bh(&card->ip_lock);
 	hash_for_each(card->ip_htable, i, addr, hnode) {
 		if (addr->type != QETH_IP_TYPE_NORMAL)
 			continue;
@@ -403,6 +404,7 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		else if (qeth_l3_is_addr_covered_by_ipato(card, addr))
 			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
 	}
+	spin_unlock_bh(&card->ip_lock);
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
-- 
2.13.5
